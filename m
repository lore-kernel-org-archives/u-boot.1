Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63B8CF6BE0
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCDCD8401F;
	Wed,  7 Jan 2026 01:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kE1CsZrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F578402E; Wed,  7 Jan 2026 01:32:35 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07318401F
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3fe3cc80bc3so893531fac.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745951; x=1768350751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZrIjN3iaiHqW+SzivqkoIMCK2CJj5G5faxBUiEdetI=;
 b=kE1CsZrINGRTl8XzuR+wN273L0s0Hmiol28wT7k0tlitDkKRDm4XAsBdYMRCELvV07
 FM+ngmatTDcmRn5NmoVgfyZUBBxhHe9NeJXLnBCswwg0CPktFUTeqvfUxHqGvzgWq8/O
 DelQoIYhb6oUPmiLCnlpnqZD5XY2VhB3kLw9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745951; x=1768350751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uZrIjN3iaiHqW+SzivqkoIMCK2CJj5G5faxBUiEdetI=;
 b=UBcf+CGYCMd3DSVAyHDFWjyZXCngAVgmSx0TYRocK1NLr81QinrRDlnmhmxBgJ0VCL
 WtgQTkuFerxm2SqBhbbaICSlgw46rLYXSSwZrhD5HP296rN4gt0UTENU+tinkopnKX2o
 7IqOKigv1DVWBWEjk0r+0WxLOJRqIs6dCEfBma1M7wJXnkCQxWQcsoMwTOTejY1PDdVh
 Gke5AQUGGruYzNhoxtUKke5SLC6XJCBeE759dRwyO99YH1ip2x7WZoje8eNqy9fNpyVo
 Bm8JrHZO4QdGcz251VWkQziXk5l8J3uV8BMZFF4OILqw9DXZ8wtCNWqgF+AplIsTYOy0
 hoOg==
X-Gm-Message-State: AOJu0YwMRqZQI/FBNQqZxeSTgkcOPM/eoyuC7fR/JLf05bT2SH2rOXhs
 CzzHUrTBXB1xuCTN/r3l7PNU/9y4QmI9xt/fkPpUu0GhIj/9GNphRdMuAPqW08/v3bzF0OM4Lei
 hgdM=
X-Gm-Gg: AY/fxX7OP6BbANbboaNQ55b74hUf2/OAM12R4CSJ9SboWrgFMKHdeJRZ8iQKWNNi5AC
 zcAGZLC9Z2q1BhLoN8nUNciJtqR8flC0nd6DvpxGZcDyvbhKeHWIxolLLCg5rsdn9pmqkMETNvP
 3rpGj7T4jt6LfVMyIJANqnx9sn5V9I520EhSFXPgVdvB1HVk5SMNssgHnzOxxN+JqTwc4VkpUId
 NuWYvf9ilcAjuSZhJlPsP9aCTNSi5q9G29S6M79K5tKd9Y6jbO5McbVe4CqHm+F4mG2T/t1nTut
 pafSBaTXI4mIgL2gAZscmtpM6mFkG9b7bDo2E1GgHUfM0gUqsVuZBzozlSVtLXWyupavDiLznFo
 JMffAIXQtpA0wO0IJ5ADPYpqrhoGfeiY/7KiC+Vxj5Gap9alDVbq7sMgxFd9q3RCOjabdH+KPGf
 2LFExYtDmChDQvAGgj
X-Google-Smtp-Source: AGHT+IE0+fydYw4JMwR6F14EBR3mgRl7wyBBtszds1LEi3e30AeL5FwTU/LdYz4tuZ2I274CGJ/VSA==
X-Received: by 2002:a05:6820:c214:b0:65d:88b:c012 with SMTP id
 006d021491bc7-65f55089d1fmr211833eaf.72.1767745950695; 
 Tue, 06 Jan 2026 16:32:30 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Simon Glass <simon.glass@canonical.com>
Subject: [PATCH 03/10] bootm: Add a message when booting
Date: Tue,  6 Jan 2026 17:31:20 -0700
Message-ID: <20260107003131.3064800-4-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107003131.3064800-1-simon.glass@canonical.com>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
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

From: Simon Glass <sjg@chromium.org>

Add a message about starting the kernel. For EFI this will be printed
when boot-services are exited.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 boot/bootm_final.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/bootm_final.c b/boot/bootm_final.c
index 263cd95dcb3..71661334e11 100644
--- a/boot/bootm_final.c
+++ b/boot/bootm_final.c
@@ -10,5 +10,7 @@
 
 void bootm_final(enum bootm_final_t flags)
 {
+	printf("\nStarting kernel ...\n\n");
+
 	dm_remove_devices_active();
 }
-- 
2.43.0

