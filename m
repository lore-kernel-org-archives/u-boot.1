Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F7FC3DA58
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3D086B9B;
	Thu, 17 Aug 2023 19:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TL9SNQZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913FE86BAA; Thu, 17 Aug 2023 19:41:31 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D07FB86B9B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d72cf9156easo114087276.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692294087; x=1692898887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3U9+rF1jKShEFBy3a6mi7BV7pmumNdkfVbrO549W9NU=;
 b=TL9SNQZguOxDgWCPM9oCOSnuZ30dPqSn2NnxVI+VzAgv7BPEFwSqrP2UTYHSduCEM9
 XdAb+lsNgvPjYhtfOR4VaMJbvQFk196b+2mOFe0gN3r5914L5HyxhKlZJZzhvczKxpwr
 /jQR3jBq0BrRrsHzwKONnodf37xV4HG6eBeYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692294087; x=1692898887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3U9+rF1jKShEFBy3a6mi7BV7pmumNdkfVbrO549W9NU=;
 b=hcxocD8J2kuxgDZ3SS0gGNLxST9W071rsh1dqMrTsqlupHz8cYo9/b4oLJ0NgrWiTn
 uezUjYMp6x/biZVkJYOCzh+n+G6Sm+oPvR4QgakhyqG6TLtowCANfuYbufBDwPzwvJ3R
 hSnz8cw1b7jSAMuQBjnA2ymp5ROS4+9mU95NpytMjw4rOBRC43sYAcbt9pPVaFMlgjzv
 jVPYzbMU95TVarN1XEvsKRii9Wq89F5p/dRbVtDingFylfw6L1NjEPjPJ4dGVAGc/XOV
 jF2Jl9Jgekx+qSNaI2e8iFZ314eByqDUvtktBUnuq+mFGBtPed8gc/zvhuAiBIynOIv0
 Uc7g==
X-Gm-Message-State: AOJu0YxzWM8YRsDn/oRT/wAvHeGJGONzmkjoKZUQzjAVGAZAq5bZzFSO
 FDR7BEPo+UyZIbK20LdAiFGeVyegREWFa/Gtw1wjfA==
X-Google-Smtp-Source: AGHT+IHQ/wDhIPOGX6JcfA9RCPKVoQqtPVWK8PypWCivMQSDim+AUqWzCw/g4NLa/XcZBxGQLd3tfw==
X-Received: by 2002:a25:d08c:0:b0:d55:cf49:9144 with SMTP id
 h134-20020a25d08c000000b00d55cf499144mr313410ybg.15.1692294087432; 
 Thu, 17 Aug 2023 10:41:27 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 78-20020a250d51000000b00d1b86efc0ffsm4099005ybn.6.2023.08.17.10.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 10:41:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/4] fwu-mdata: Make FWU_MDATA_GPT_BLK depend on DFU
Date: Thu, 17 Aug 2023 13:41:23 -0400
Message-Id: <20230817174125.369849-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817174125.369849-1-trini@konsulko.com>
References: <20230817174125.369849-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The implementation of this option in lib/fwu_updates/fwu_gpt.c is wholly
dependent on DFU, so make that a requirement here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I'm honestly not sure how to best proceed here as
drivers/fwu-mdata/gpt_blk.c doesn't need DFU, but both files are
controlled by this single symbol.

Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/fwu-mdata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fwu-mdata/Kconfig b/drivers/fwu-mdata/Kconfig
index 42736a5e43b0..0bd5fef4abfa 100644
--- a/drivers/fwu-mdata/Kconfig
+++ b/drivers/fwu-mdata/Kconfig
@@ -15,7 +15,7 @@ config FWU_MDATA_GPT_BLK
 	bool "FWU Metadata access for GPT partitioned Block devices"
 	select PARTITION_TYPE_GUID
 	select PARTITION_UUIDS
-	depends on FWU_MDATA && BLK && EFI_PARTITION
+	depends on FWU_MDATA && BLK && EFI_PARTITION && DFU
 	help
 	  Enable support for accessing FWU Metadata on GPT partitioned
 	  block devices.
-- 
2.34.1

