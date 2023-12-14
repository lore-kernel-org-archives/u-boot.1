Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDD3C4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66C787ADB;
	Thu, 14 Dec 2023 17:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="njhd+BCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9998887AC2; Thu, 14 Dec 2023 17:51:58 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D2287AF9
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35d55c8ab0cso33518685ab.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572714; x=1703177514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDNgc+Giy/3ts6K03lrJuc4i6d9t9Q90whPdKm7ZmAE=;
 b=njhd+BCdX1wcG49zZ8LNuljxMcL8xzL/sMmjgrQBNxBTv4RBtS7OMHDjP+UofpDDEh
 GIyk45q9iD4eB4rwwqRC12H5ASMRdpvufqhgPHcrjnyLlr3hGM89WMYeuT6FiHvmswFR
 gB5pEZphkMdf4zYRiEk6d0uxly3XmeLVWY6/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572714; x=1703177514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDNgc+Giy/3ts6K03lrJuc4i6d9t9Q90whPdKm7ZmAE=;
 b=tO8XYstfQdqBq5VnurTttooUlq79R/4aOo64RndnMmWrJkoWwGrSRePzlAvGaPyHFP
 4QHyqg1iYGPC5Vjei53Wqmqb2y5QPiKfGhypNl3WUnN/OV5RDJu4IS9XxDaLxY8UGRO+
 tC9US2Kqb5o32mRw9iv9JP7m//Hreph+TtHmKnJf32NW+kTztvjwHr8LYx9NMdid1JjF
 k0k/kc0DkCU2NTnv1oKx5636hMXMQiVl4E5GXx/xp6hUc4kxhV99EK+IaK88og6JHVDK
 kuRtRqOb40avM+EJZe1+JxnCsZ1/nTihdEfmm1+WU8X0DL0pRAFg8HcE/WfV9Z21swX6
 WwCw==
X-Gm-Message-State: AOJu0YxXwlL4gYaP4bh9CFJYUhAtpVsa+7nBPptYk77J8ncgnu5Ng8Mm
 jpVP5s33VDWGmWuj8yq8uaUz2578H0ah7PFPMdzraw==
X-Google-Smtp-Source: AGHT+IHRuOC0qd4gy142uJuiOnKSlKTImSB3k3tHRTx3kTEikCUhcVyIql1ArqPpHr0rmSlRVO5l+g==
X-Received: by 2002:a05:6e02:174a:b0:35d:7054:3dd6 with SMTP id
 y10-20020a056e02174a00b0035d70543dd6mr14422594ill.6.1702572713911; 
 Thu, 14 Dec 2023 08:51:53 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 12/21] booti: Avoid use of #ifdef
Date: Thu, 14 Dec 2023 09:50:21 -0700
Message-ID: <20231214165112.2182274-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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
---

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

