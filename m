Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCECC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F35D87869;
	Thu, 21 Dec 2023 15:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWydI36i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A801087867; Thu, 21 Dec 2023 15:24:45 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA0A876AE
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsankouski@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e305530baso1066234e87.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703168682; x=1703773482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVQj6QnCDq7e89nDEKJs/iNK37A7vZwH7vI9nb+NUTQ=;
 b=MWydI36iN8D/+tSFVFI4e5dDKKq7Q/Kw5hplPmdV2PlXmUJSve4L3cQKBTNw6EDkSI
 SBP85sZ0h9rCqXfBP+qpVArwPfDUhTeSRanZDY7mdqbK4dceNzs8pnrr+8MLnDue0g+0
 caajFSIsSJhVG2lU4LIDruLGShgIX9NKqmYugrolzBe0FwDDva0TKEGdoJGPTzi7fXBE
 Cy3oO7ZiMiDAaywOaWeIIGRIT+A7q7rQVpBuwshHfkRlh7hGoXu7C9T3tMcD5R7hu44B
 TXalKbbVCVDhM4RRILYy1DBsYivYk9pr8pXpbPw2K2gZmal/P9Nydi5W7HSTGXfv2C2T
 od5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703168682; x=1703773482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVQj6QnCDq7e89nDEKJs/iNK37A7vZwH7vI9nb+NUTQ=;
 b=KRLbP+yycY3fHaNHZmncTJlxAcG9/DgprKkbsyXEBEyZokbsauEj6lowX8LPPJoYB1
 pVoLVBokX/1fIPXBdCZKUjOfLO66FtYZxHh+Swtxe36Sfc9aHZRgEP4BH0yTBsa3Mls6
 /kCluBJliZv56FUCzyblYIvMfrws3iJyj7vF6yzNAWeTkBsZDxbldszFj7OqSCDNnNiL
 w/SLPPvWwlCyeRmJY2gnlrkdjo18nq3nVtI3txebMnHk6cibD064H0LJvFHb9W5FhGYN
 +SCpdkFDyt+gWO43fHtfzSFlVYR4HOe2x3BUW8BL69MTBjnhi3hV934ZL7ORzOrvdBjU
 KyiQ==
X-Gm-Message-State: AOJu0YxY4jI4tWa2MCK39l3nnvRbfSSQyExv0GhBe7b1s5SKy3mBDlNo
 iTu6zoDMQF5hbQgbEu2Tbez6tUXYRDw=
X-Google-Smtp-Source: AGHT+IEO2v6CM1YGaGmXIjJabNZiDDY5Lw3E4DQLv/P84JWTBDrtN9sKH4VBb4Fwar9l3BNQwsyZPg==
X-Received: by 2002:a05:6512:2308:b0:50e:4bd0:f489 with SMTP id
 o8-20020a056512230800b0050e4bd0f489mr2885465lfu.28.1703168682200; 
 Thu, 21 Dec 2023 06:24:42 -0800 (PST)
Received: from debian.localdomain ([37.45.245.217])
 by smtp.googlemail.com with ESMTPSA id
 q17-20020ac25fd1000000b0050e3719148fsm280653lfg.235.2023.12.21.06.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 06:24:41 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
To: u-boot@lists.denx.de
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH 3/4] arm: dts: starqltechn: add buttons
Date: Thu, 21 Dec 2023 17:24:08 +0300
Message-Id: <20231221142409.82877-4-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221142409.82877-1-dsankouski@gmail.com>
References: <20231221142409.82877-1-dsankouski@gmail.com>
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

Add volume up and Bixby buttons.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---

 arch/arm/dts/starqltechn.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/starqltechn.dts b/arch/arm/dts/starqltechn.dts
index 5bb1a7f90a..539c1b51ca 100644
--- a/arch/arm/dts/starqltechn.dts
+++ b/arch/arm/dts/starqltechn.dts
@@ -36,6 +36,22 @@
 		stride = <(1440 * 4)>;
 		format = "a8r8g8b8";
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-vol-up {
+			label = "Volume Up";
+			linux,code = <KEY_UP>;
+			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
+		};
+
+		key-bixby {
+			label = "Bixby";
+			linux,code = <KEY_RESERVED>;
+			gpios = <&pm8998_gpios 19 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &pm8998_resin {
-- 
2.39.2

