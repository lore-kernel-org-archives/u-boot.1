Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A88FC4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA86D87C78;
	Sat, 16 Dec 2023 04:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V2eqKWiw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F31987C66; Sat, 16 Dec 2023 04:15:25 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63ABD87C5F
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7b3708b3eacso48409739f.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696519; x=1703301319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcI3S7KsB86sE2M9KXDz0ZapSUpAtWc9NrprvXPTAY8=;
 b=V2eqKWiw/CU96J7vzrMV2B9kJ74MGcmU8uYo+pHc4ju0eUHAr1BHT6buYlKYLCa26t
 npSg/zxYLsVyawHlo6/RojdKK/Ohvqhs2DBLS0COblA6g7EQYMqWVGW9B6Zezoy1nB+b
 KHxAffH+ua6LzfC4BbbAqeCtmcRIUCF0b/33g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696519; x=1703301319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZcI3S7KsB86sE2M9KXDz0ZapSUpAtWc9NrprvXPTAY8=;
 b=EZkSwQa5UkcRX9y4leyH25kT2CrR0D2n6mTLuMmYJxSFjODNuldd1jghxiGiPI+qkr
 iXUtC07JJHV1AN2GdQ/f57p9Ilw0mtSVb1+TdXIcwNfSfZ5jaTH2SJNLfy+UkD68qwjL
 4KyCFTEDjOXps7bcdTsJcSAnsN+hTIAuu5WAs7mBeTCHp4lBIVM3Wjv7gPKjHO74roxb
 G+ZFWpdbtb3/L1YO+ZZqlGZrB2LTuW5FMqPL+9hjqk0+iBVYfZhtR+M+vWUzsqu+Gpql
 CPc/VV6EAiBRnceexU3jcD15CwYP2/1myHMNKIPm4CgR5dWjtG31GRSfU8CP1QtHBkM3
 d3wA==
X-Gm-Message-State: AOJu0Ywy/hr7GruVpW7DkHeLsQ4soH0xpJiQM2Gs/5IclFcCvHNTzIfH
 UHpcH25vZbmWP9OgHfRswrb8jrrVvF/YMEOjPEhNXA==
X-Google-Smtp-Source: AGHT+IHiGIJb3rgS5ASM5kOLJ/UFGZoFKzj7SCdmM2oUTxndRgEg4cWqfSIvui1wz/Mz8XmMJgGT7w==
X-Received: by 2002:a92:ca4a:0:b0:35d:5405:e63 with SMTP id
 q10-20020a92ca4a000000b0035d54050e63mr15282268ilo.31.1702696518967; 
 Fri, 15 Dec 2023 19:15:18 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 12/22] booti: Avoid use of #ifdef
Date: Fri, 15 Dec 2023 20:14:16 -0700
Message-ID: <20231216031446.2222362-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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

Use the compiler to get the set of states, instead of the preprocessor.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Split out booti removal of #ifdef

 cmd/booti.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/cmd/booti.c b/cmd/booti.c
index 41d40c962ec2..d3cceb7e0a39 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -105,6 +105,7 @@ static int booti_start(struct cmd_tbl *cmdtp, int flag, int argc,
 
 int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	int states;
 	int ret;
 
 	/* Consume 'booti' */
@@ -120,19 +121,16 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bootm_disable_interrupts();
 
 	images.os.os = IH_OS_LINUX;
-#ifdef CONFIG_RISCV_SMODE
-	images.os.arch = IH_ARCH_RISCV;
-#elif CONFIG_ARM64
-	images.os.arch = IH_ARCH_ARM64;
-#endif
-	ret = do_bootm_states(cmdtp, flag, argc, argv,
-#ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
-			      BOOTM_STATE_RAMDISK |
-#endif
-			      BOOTM_STATE_MEASURE |
-			      BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
-			      BOOTM_STATE_OS_GO,
-			      &images, 1);
+	if (IS_ENABLED(CONFIG_RISCV_SMODE))
+		images.os.arch = IH_ARCH_RISCV;
+	else if (IS_ENABLED(CONFIG_ARM64))
+		images.os.arch = IH_ARCH_ARM64;
+
+	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
+		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
+	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
+		states |= BOOTM_STATE_RAMDISK;
+	ret = do_bootm_states(cmdtp, flag, argc, argv, states, &images, 1);
 
 	return ret;
 }
-- 
2.43.0.472.g3155946c3a-goog

