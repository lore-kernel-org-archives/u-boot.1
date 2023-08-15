Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29875C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6820B869D1;
	Tue, 15 Aug 2023 18:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oEfifINp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3078A869D6; Tue, 15 Aug 2023 18:27:45 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CCBD86797
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1bff2d2c141so3265173fac.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692116861; x=1692721661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JQCCOiL9CY0VpvCGD3c1moaNFvFJAGXuLxmp7hknjU=;
 b=oEfifINpqRp5+IfN+wooushY6LuMMjJcu8oKNHfmfdLOzO40MTKWb9zz65AKHzTQeN
 kWCRyjWnKgbi1uCptOKnvU9+WnhIThsiatE6yvl85bVuDvIpt24Wk134Z7iG21M1LKyY
 lf5h/7cpKjHo9pSUYLvrb8pmW3JX9XvDrbin/DO3Iq3pMgslEMANpHaZqlkcD6Wx+jAe
 NfFOvoIjZQIPDjJhWUD/xu+cLDwJFV9bU13Mb2DJD8bA/HFVRj6VWc7LBotVIproRg4/
 ehPSPPzpQBLwZtbLFkOljXip0dYAQp36UV4DaJk7MDr1sXjmOttbw0dMXRHfmjwgZt/X
 83Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692116861; x=1692721661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2JQCCOiL9CY0VpvCGD3c1moaNFvFJAGXuLxmp7hknjU=;
 b=ZuAVNBPETKoyf4tJaMMJjGzaifpYqU4GiwRZUwwd+voRTHRJQskKdvvfvqzJslORS6
 kaRbSQov47At5C7hqLX2dKYQc/f1yu2VHshYPW8ycbaxrIYw6pBZzufY+FXiQKaQdSS7
 59Gt4HIttDzEMwbseQCbNKl15v/ngctthjyjlZyLsNPVmLZJgDxGIuNzBXluD3MSUyS+
 WmBMoU/9rqAAia4l8ilrrcQe6mOMlQzaO4hWAcxikD0yOyITIH9K71aVszga2g3amCm2
 LyVm8VzVc459yqAevurjoazleIcZzNyxmgwiyP7F/FnGO71AzIMud0wVcO3ny+cegwy4
 3dlA==
X-Gm-Message-State: AOJu0YzIl4Kqx8AkM0AbRwqwOB8F3o5htj8nHUU3oFVINwkzKXrtaj2G
 eKyAQycwWFo9e8sZ2BAebuGierkJdY4=
X-Google-Smtp-Source: AGHT+IGDAbef1tC45fYe9AczX+4gB5wAIHYHTwl+m2kyJ8rVWPdQdb0eZ508gSIRuh93tH/qLqw1yA==
X-Received: by 2002:a05:6870:1717:b0:1b3:8fed:c4a0 with SMTP id
 h23-20020a056870171700b001b38fedc4a0mr11755624oae.1.1692116861026; 
 Tue, 15 Aug 2023 09:27:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6897])
 by smtp.gmail.com with ESMTPSA id
 zf26-20020a0568716a9a00b001c4f840e7bbsm2474441oab.47.2023.08.15.09.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 09:27:40 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 1/6] cmd: gpt: Remove confusing help text
Date: Tue, 15 Aug 2023 10:26:55 -0600
Message-Id: <20230815162726.1524958-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230815162726.1524958-1-JPEWhacker@gmail.com>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
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

This help text appears to be a fragment of the text shown when
CONFIG_CMD_GPT_RENAME is enabled, but is confusing so remove it.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 cmd/gpt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index 007a68eaa7..e6f7b0319a 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -1060,8 +1060,6 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
 	"      gpt_partition_name, gpt_partition_entry\n"
 	" gpt enumerate mmc 0\n"
 	"    - store list of partitions to gpt_partition_list environment variable\n"
-	" read <interface> <dev>\n"
-	"    - read GPT into a data structure for manipulation\n"
 	" gpt guid <interface> <dev>\n"
 	"    - print disk GUID\n"
 	" gpt guid <interface> <dev> <varname>\n"
-- 
2.33.0

