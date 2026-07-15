Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFABFC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 12:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A9F84AC3;
	Wed, 15 Jul 2026 14:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="wN/rpabT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADA084A29; Wed, 15 Jul 2026 14:27:38 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C22684A7B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 14:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15f020a223so717081266b.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784118455; x=1784723255; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fOtm6b1F2nH5BHVgnJH42fg1EHb+nHK0GjSaGkWF3xE=;
 b=wN/rpabT3M5JGnv0LQrKwueUL5IQTMW4xgWy5KECy15aX3ZhFmnnmYLFpYoMzRAMXI
 zXkcwEbCG61n0RIHz/tXIb0E2UTYISOr0XHfjPZUakT2vgrwEvKB3bNpyGd0BUIo+LQB
 nN4vVW268xtfIj675KQY7Tf/nk+N8+6SU/jkMG3o35B3HnBIXhBgYU4xGRyrHji41MAm
 8fSETR8K+ArU82zQB5sAgQij4P/WoYLiGqK5PogXuuPMrfNgFkaymqgbVSrrCmzCEi81
 FYv1gXMpa0sAEq/GmdMnfTx7rll2L+4SkRoN47Qhg+CPMICr2ACDGAPwtR4mbkTNWHH8
 rdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784118455; x=1784723255;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fOtm6b1F2nH5BHVgnJH42fg1EHb+nHK0GjSaGkWF3xE=;
 b=LA37gfYGMg9Y/MVZ5DWlUXqfhRVMTPLbzmbdyxrXwxOUmErhCviD0KoEWiAw71XxYA
 jnNmRa+LFJxKHEV06UriUJn+xrwgXVuieUKygeyajrIKCHjgULMK55FvAbNum8rMH+cS
 KztvvQXJfQJsoMlh/A9+j1fFAFgYA04Ln2qoVaN09abRnPCSgIBzidy3fghdlPiALSkX
 zUZv3lw6X4aMysRiL5ooRHAdiP9RUPnvuGkynDyLGk+mySvMMlSIFE14sEBeppfgeHIS
 jIxj9a97dgnHUZLruiAmbXMO+Vb0W5h1X3ZAEYi+Fs3pLhg9CemxoFUZHAMKybxRCldN
 b8Dw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLpyyJJ8ach/ygpEi/xNZ0483ybDM1KTKumootvQOKbrkkiaW2J9z66zbILfU2YoYuYIwxg9M=@lists.denx.de
X-Gm-Message-State: AOJu0YyRjoluuwvypmNOfvhoW/Hyq5Fx62Lk0paSIK1aHcEe6Ivq2jjr
 meXRcdAmMto+LgNXjNrvMPUvs4csDSM2QE5mveEHKMEvOlZl+FWen1kVza2sYNAXiDE=
X-Gm-Gg: AfdE7cm4KafrvXwI4s6eV7CIfWpJL8pc6vKAfkQO9zyXxd3cP3VGGIfDDOO9EjHwd+f
 nwAEOems+7fWSr5DnkH2bRb9PN1i/6T/XMWKcXoXV9gr9UVeRMbvvCPYqi021NvNbpqB1EfXRPz
 7hvFMz1ijoTjLdqmVOGgT92l1kfv66U4Yhb4/SkFmIfE1wY0aeXfwTmaJ/9zb5olAF3ORuCVVMY
 rQ6DJSNzu5CG21qaQNsOaeVW5i9CYGv+5DXBaQEU2xkpW4YPXBa4KalcsILgg5JvZsKR+Ahpvet
 L93iClQDBl1QxDNiY5StYHqEh0YdWGtSi4UaBYlyIm3rvj82bnxlIBUbAY2fyi1ntXdVIn3DE7k
 rv4EzVbz6TEGZPlg/38IrIUutkO0GJ8FEb2A37uzNWJUiT5Sj+X32W7EH2XJsOr1aTWaNbN/aP1
 YvFkNaSZ/63zSqfGlAv5lw5FWD2YZOngDViCk24I/hVkJzgk7gUQRjG9M4ZvaN5iB6HK0=
X-Received: by 2002:a17:907:d18:b0:c15:db3a:c105 with SMTP id
 a640c23a62f3a-c16679998e9mr360123066b.1.1784118454651; 
 Wed, 15 Jul 2026 05:27:34 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e6ecsm15062266b.44.2026.07.15.05.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 05:27:34 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 14:27:04 +0200
Subject: [PATCH v2 2/4] clk/qcom: Import GDSC flags from Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-gdsc-flags-v2-2-27704470a24c@fairphone.com>
References: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
In-Reply-To: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Ajit Singh <blfizzyy@gmail.com>, Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118453; l=1579;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Z2WLS/xyOgt4R8sKxIUbz3kELvPCtI1fYMrX+otp/Yk=;
 b=nwly/OlOqlqlmYjERieh7FQO0wWr9BRsFw5UIXpjalrl/oM4nqot/urpIvFLVfu9rvL3kp1+J
 xfAcn0D8yHDD+7k95Ho8zjJzkxYWXPiY22+rgKv69w2fc+mkLB9gHhp
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 14:38:59 +0200
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

From: Alexey Minnekhanov <alexeymin@minlexx.ru>

In Linux driver, depending on which GDSC flags are set, a different
status register is checked when powering it on/off. And on top of
that, a different bit inside that register is tested.

As a first step towards adding behaviour variation, import GDSC
flags from Linux driver. Even though only POLL_CFG_GDSCR is the
important one here, add all flags in order to make it easier to
compare which flags are needed for which GDSC, making the porting
process easier.

Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/clock-qcom.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 3a4550d8536..6962b0351b4 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -74,8 +74,28 @@ struct qcom_reset_map {
 	u8 bit;
 };
 
+/* Imported from linux: drivers/clk/qcom/gdsc.h L61 */
+enum qcom_gdsc_flags {
+	VOTABLE = BIT(0),
+	CLAMP_IO = BIT(1),
+	HW_CTRL = BIT(2),
+	SW_RESET = BIT(3),
+	AON_RESET = BIT(4),
+	POLL_CFG_GDSCR = BIT(5),
+	ALWAYS_ON = BIT(6),
+	RETAIN_FF_ENABLE = BIT(7),
+	NO_RET_PERIPH = BIT(8),
+	HW_CTRL_TRIGGER = BIT(9),
+};
+
+/**
+ * struct qcom_power_map - Globally Distributed Switch Controller
+ * @reg: GDSC control register. Linux driver calls this "gdscr"
+ * @flags: GDSC flags controlling its behaviour
+ */
 struct qcom_power_map {
 	unsigned int reg;
+	unsigned short flags;
 };
 
 struct clk;

-- 
2.55.0

