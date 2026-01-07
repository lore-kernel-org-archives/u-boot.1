Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C325CF6BE0
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E43D8400F;
	Wed,  7 Jan 2026 01:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b63UlI0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C6E84019; Wed,  7 Jan 2026 01:32:32 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB5BD83A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-656d9230cf2so752871eaf.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745947; x=1768350747; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xy3OUZnE/27It0fmqOuxCdAjpZ/GKimA5TZndbZ6ft4=;
 b=b63UlI0nzTX+EN7qyGnj3OuKKBY5bZRnx17sBNWjanFo6xSMzIYDSkt8NqFeS8w8MI
 1t+QamZoYfaflVl6QQJqhaQeIVKib2jgv5AS93rXhcCrKBCHS6OdYaWdgsLMZ3+d0xtc
 XaL3/Kumobic4wtWrZBiD0YBQFDgCtAHDnIrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745947; x=1768350747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xy3OUZnE/27It0fmqOuxCdAjpZ/GKimA5TZndbZ6ft4=;
 b=ZvzARrPMkdJPpYL6zxMN576teZ9uhQHR/QPxwMw/RSX/wFRvC82CfhosteAHXi27v/
 zvdQuHThIbsC3fLHhMcokWSJswT9pElexqr5KTq/nRCCslV3gwYOqIlr2Zbe6KPCMpC8
 Vny1cKklWSjEEiouTk83VFLjTAgOMGkdcXWKL0j03c9cxYs9lQWxaJDuzhQv+FfRkWVY
 PcX4iNtfkSNdelmkar1WyNyDUzd+55JM/W3fCPouASKg6nHwRbFCix8FYF8B9Yk+vy4y
 o2k8TVLzwfl+GXsgLSvrfl/10BCgoXGPPFnNtaxWjMQV3H4s87pIvB+sSidVcbqM02f0
 VxoA==
X-Gm-Message-State: AOJu0YyUNfdcpEQa9PLYKwTVSBfgGVRg0IpfVekwVlA3TIdGYUgyhjPI
 yFYV5VeLC0V1E6IEvld5qR38y9Xxm0hfOs+IcLsNTlXF6/BRGlhm2/o6PvMvTKEeCebPGbcZZuw
 JsT0=
X-Gm-Gg: AY/fxX5uSXflm3QIhzyHLKjJosQnltRwrzvCk5wiY6bulTCQxaXrWamyYHbJcZHBMuG
 +T2Oj/gCBTklf6p4Buo/UtMLo3w24W4pZJvT0YGLbjxJgsSNMpgwa0rch8SzxGzwXfoWn1sXT6W
 nsmgzV3lYkvLfZvcH/lNEAxU6Szp61dvdZ9q06gb/ItKHr9npUUmQLUtNGS1gV53SE7win2x5uA
 P2h2FACuRKw9CzH/FiH3yTGFh1/QGKUM6ki8alVCPSqI8vFeLIXspZGVZDSWDwePeLNuSUGqV2l
 CqVd4forteTbzeZQZRlUqYKWeAgBL4j+G7ebrEBqVM+OAsmn0Y/bNzZ4cNMw+Z6hFYj6LhaXUm7
 uM3Q6vepdVcyU90e5XMxy+xCrBB/nNZsHxj9U7vc78g9tWbReHZcqTm6q+yF8Q8btonIKPi1UIg
 0uQq1Hq3inQ31RzO6R
X-Google-Smtp-Source: AGHT+IF9cAW0dgMP1XUD/sG4qsrBzeWgbRgr0L8pze9vdxHJudG1e5GMNE4DsdJ1VlLpPgZY/jnooA==
X-Received: by 2002:a05:6820:2207:b0:659:9a49:8fce with SMTP id
 006d021491bc7-65f550960f7mr328040eaf.71.1767745947152; 
 Tue, 06 Jan 2026 16:32:27 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Simon Glass <simon.glass@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Yao Zi <me@ziyao.cc>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH 02/10] efi: Make use of bootm_final()
Date: Tue,  6 Jan 2026 17:31:19 -0700
Message-ID: <20260107003131.3064800-3-simon.glass@canonical.com>
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

Call this function from the EFI code. Add the required call to
dm_remove_devices_active() there.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 boot/bootm_final.c            | 2 ++
 lib/efi_loader/efi_boottime.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/bootm_final.c b/boot/bootm_final.c
index 15ddbbe5e74..263cd95dcb3 100644
--- a/boot/bootm_final.c
+++ b/boot/bootm_final.c
@@ -6,7 +6,9 @@
  */
 
 #include <bootm.h>
+#include <dm/root.h>
 
 void bootm_final(enum bootm_final_t flags)
 {
+	dm_remove_devices_active();
 }
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index ddc935d2240..13d0d4dbe88 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2241,7 +2241,7 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 		if (IS_ENABLED(CONFIG_DM_ETH))
 			eth_halt();
 		board_quiesce_devices();
-		dm_remove_devices_active();
+		bootm_final(0);
 	}
 
 	/* Patch out unsupported runtime function */
-- 
2.43.0

