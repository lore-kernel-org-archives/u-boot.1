Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC23CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C148E83655;
	Fri, 24 Oct 2025 16:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NwWWDDbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5249D83677; Fri, 24 Oct 2025 16:23:30 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5383483631
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 16:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so1399019f8f.1
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761315808; x=1761920608;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CdQ/u5fAeQAUEcapSgh5vQA4fjrIXRM7xTQDKT1AX3I=;
 b=NwWWDDbGtr9SXkMYBtPVaTQqKfeLGsO5JOvQ/RllaF61dtut8RCy5FyE+7p9816Paf
 tZN/WyrbOB50AeRPu9mICAgHQjrU5mCnB4+qzigQd4CNbNAiQ8Jj3k3a2A86PTZKBOBj
 46J+TkSvLiYBxbKwvwdqNa3w2JF04UIKjMfRQbcxf6ESjgkQp8QocOvr+A4VUDt9IRta
 mDEpIVUBk3TGGKH/EPffzjJ2LQjFFbSQjmoPCq8O2gSdka1UbdrYQVUZ5goG/kWYwJLd
 qocJVUVQoGWtdvdc5n5RquiLR+xHpj2rnIkEVClpLLmLubUYp3arfW1VeRnsRPsfJxYS
 LQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761315808; x=1761920608;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CdQ/u5fAeQAUEcapSgh5vQA4fjrIXRM7xTQDKT1AX3I=;
 b=ooSuhrwV+IMPkW9+Rkw45RIAnvtJhL2Wa2Qw4Xci15pqr7D2CAlEWwSDRy7qXguWoN
 4cArIB188be2UC71rERg07PexLrf1UcyRa6SYp5BAoC3LaLQj8EUyHPJL2kZrGjmcpfp
 MKPeZbiejXlOzNbpHQ7o4UMm1K64hf/cz64WDU62Mg/bhSc8oq7F5KJx7VBgOO0gnDs9
 U72mgOJn6W5yzCyFWTuh9AkDsAasVin7jA1uHWVV85ZrY8K2rAnc5HW1GzGVlwRAXN0X
 tODsq99qj+or0C4CnXh9CwQ4eTmcPVj+Q81qmxEfcOxxdNEAkbHgV9SdXVEGWNDw732h
 SvHg==
X-Gm-Message-State: AOJu0Yyeikv9PNUIjFHLhiCgYKFzfJujHIYRGjG6HbiVVGEOdMb0an4S
 mv49Ie93OSo1ABnbWEQmBdHPSWPfK/MqDC15urg/K7yUNu3c/tPaJky/4sNIIjoqlzc=
X-Gm-Gg: ASbGncveqIzQ4k5Oz2xkFSW+JEZZqdK0jpZSJ203wMBUP2MgN8KSzIJeD0W6PF0Ctz2
 G9pT+tfHEtoq59rcIxLGkVWClDDyS/cP2suAw3MdwjuYEAt+dufVjzOYDYJk69pSN2vn0KpYtlI
 Uhjz6kr/+wwlmnVsb/q8CX1QBPq2gewfjjh9okafaC4HC6DkQ0IkmD5B9uoKhyyKP2j7/Y6fnWj
 GfNMK1WZoPVOS3k5h/MfRc7xTOahZnfajPivI0H6gneO6Ml0g65pTTS5IHkYcHhmLAHP2obNdKX
 Qx6RG5jMGTN2UiRcF4IrqzWhbcxkdPMt6TA0TZ0dMDQekjse44BSjwDfALi5rakfoE77vs4Q0W6
 DIkpfdrlNhBLiJds43sXnIikDdVNopzpMNg1MLBTtExegXf+bI7mAKph8rdIK4AXOrCdi5MBvKT
 p+OlY=
X-Google-Smtp-Source: AGHT+IHKg+T9/30inSyGFjbznnIWKKWdkl8vPkFhh2zibLzNm+y4wNfAZa1G5sGs6cxLpMFbffZqig==
X-Received: by 2002:a05:6000:3110:b0:3e4:64b0:a776 with SMTP id
 ffacd0b85a97d-42990747c84mr2099933f8f.52.1761315807611; 
 Fri, 24 Oct 2025 07:23:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:a5c0:bdf6:3b95:6cfd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898add8bsm9433243f8f.23.2025.10.24.07.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 07:23:27 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 24 Oct 2025 16:23:22 +0200
Subject: [PATCH] bootstd: android: add the bootargs env to the commandline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-botargsappend-v1-1-0b78f05f9132@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANmL+2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMT3aT8ksSi9OLEgoLUvBRdY4tEE2Nzw+Qks5RkJaCegqLUtMwKsHn
 RsbW1AMj5HMRfAAAA
X-Change-ID: 20251024-botargsappend-38a4371cb6dc
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 "Nicolas Belin (TI.com)" <nbelin@baylibre.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 george chan <gchan9527@gmail.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
X-Mailer: b4 0.14.3
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

From: "Nicolas Belin (TI.com)" <nbelin@baylibre.com>

When previously using script based bootflows, the U-Boot
environment variable bootargs was used to customize the kernel
commandline at boot time.
In order to get the same behaviour, concatenate the bootflow
commandline with the contents the bootargs environment variable.

Signed-off-by: Nicolas Belin (TI.com) <nbelin@baylibre.com>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 boot/bootmeth_android.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 8c2bde10e17..1374551dbeb 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -512,6 +512,37 @@ static int run_avb_verification(struct bootflow *bflow)
 }
 #endif /* AVB_VERIFY */
 
+static int append_bootargs_to_cmdline(struct bootflow *bflow)
+{
+	char *bootargs;
+	int len = 0;
+
+	/*
+	 * Check any additionnal bootargs coming from U-Boot env. If any,
+	 * merge them with the current cmdline
+	 */
+	bootargs = env_get("bootargs");
+	if (bootargs) {
+		len += strlen(bootargs) + 1; /* Extra space character needed */
+		len += strlen(bflow->cmdline);
+
+		char *newcmdline = malloc(len + 1); /* +1 for the '\0' */
+
+		if (!newcmdline)
+			return log_msg_ret("newcmdline malloc", -ENOMEM);
+
+		strcpy(newcmdline, bootargs);
+		strcat(newcmdline, " ");
+		strcat(newcmdline, bflow->cmdline);
+
+		/* Free the previous cmdline and replace it */
+		free(bflow->cmdline);
+		bflow->cmdline = newcmdline;
+	}
+
+	return 0;
+}
+
 static int boot_android_normal(struct bootflow *bflow)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
@@ -546,6 +577,10 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (priv->slot)
 		free(priv->slot);
 
+	ret = append_bootargs_to_cmdline(bflow);
+	if (ret < 0)
+		return log_msg_ret("bootargs append", ret);
+
 	ret = bootm_boot_start(loadaddr, bflow->cmdline);
 
 	return log_msg_ret("boot", ret);

---
base-commit: b10c055d4e1b5153a331a61ef82a5b01b5bb4c45
change-id: 20251024-botargsappend-38a4371cb6dc

Best regards,
-- 
Guillaume La Roque (TI.com) <glaroque@baylibre.com>

