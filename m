Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1C5C369D1
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B2D830B4;
	Thu, 17 Apr 2025 14:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="gNwQEm1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66FCD82FB8; Thu, 17 Apr 2025 11:10:16 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 749AD82F8C
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so507356f8f.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1744881013; x=1745485813;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4iVBRtwyE8AkNWpu6a7s/iulhnR0zJsGpoQ0uAmgysk=;
 b=gNwQEm1h5XbaUkZCSQcNX1lU+lwHMKnAVVDeZD8G4Py+EHCMQDeTI/9aB52IV/kIY/
 9x+mucWffQ3s9UKNHKTyXJcYwsc2VG6Bo8WrgVoap2oDMVUgAgeF7YmX6n5HM9QifX54
 G6kVjbZ+lSo3d9dH+qAVB3utj3UdAbp2eXRTpqXRUIcY+D7R68Gt7eqYWqflCgXxs2Gx
 U0eoqpwRvFpVDMqPZXMZp2rNoN8IAX4qFLuv/5IRtiNoAsvZKGwC0GrRzTfC3wr5mCQP
 qmd/FLGE6gmzsZMTDKdGNtzHSZMCB0gGRoQzPMsYTEamqZrxpXd8deMXlHk74sNakn//
 3QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744881013; x=1745485813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4iVBRtwyE8AkNWpu6a7s/iulhnR0zJsGpoQ0uAmgysk=;
 b=uSveaqIYBB780tmVd+Ei9df4eMQRZnStuV+8n4Q7eTHFGgd67uZK2Uw3//DTllWGnt
 eKlJtzAHjo47Olg4I3Kf1G2qClMImz6ds12NGNR2qf2FhPtStNqLtaeq4kigNd+pMy2U
 mnkgWHV2DsQDH8gO6kSRFBCLMz/uxHjHpL+6IwT9rGgvUbWvoZkwvdpBJ1byyrh6ZBtH
 396/8erq3V6yQXtWhRmQ1lv9fyz8mLMqXKoXtBz4UCqfxtpYYzE0/MG7vGnKbcjhNDdA
 KX/VPCTFNPEPq3CzZlKWDpj2AqgAPp13PkJJdWbCgPeIOE6yxLuPV4LwIT+fJG7wuWPa
 n2FQ==
X-Gm-Message-State: AOJu0Yxr2Mz8Jru/F21LKLkqduoY9uwitTj6tD3hI5n1DpFvwnA7MP5j
 Ep6MxyMqufHoDgf5p+xVygbqtyxAHVJ+8cB40SWS7J4CE9bH69d2l6S5Ff+qvj6jkfe29jad6XH
 I
X-Gm-Gg: ASbGncvrggitqNghPCIhk5C8WYdMkOve9Bg4JLK7BpLEtjjFoi8DZ4HweuvDuLdYxK4
 oP+yVns/9qimMxmGzNfEm7lARfJreuRCelj4Ys4MfnSe61ZEY/RHbIVp1tVHxTglA/OtiKbyv/R
 SoxFPeE7TjQuryjQb5G89+LnWa6kgmoGDJq1YObpoHy/5WZASlqR8QuNl2jOzGmZcKmLdqF+VOK
 TbbxQyD9wE5NywT1TzQlDbqXOO0ZuiW+Jv8SSJAos5/rHhDE00f/x3laDApMnIqZ0yENQKMK5Fz
 CF4xio1OJ84HDKfFhad625YJwB1w+K0oWk80y78=
X-Google-Smtp-Source: AGHT+IEzogWtCtLvIfoLoCCv+zf03V9OWunwoc/NAwGqEERwY2WCqmFAisag2UcdfqE59GF6F69VUQ==
X-Received: by 2002:a05:6000:2911:b0:391:466f:314e with SMTP id
 ffacd0b85a97d-39ee5b163b3mr4743137f8f.16.1744881013008; 
 Thu, 17 Apr 2025 02:10:13 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b58cc0csm46028945e9.32.2025.04.17.02.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 02:10:12 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Thu, 17 Apr 2025 11:09:55 +0200
Subject: [PATCH v2 8/8] ARM: dts: at91: sam9x60-curiosity: Enable watchdog node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-wdt-v2-8-49939de473e1@hifiphile.com>
References: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
In-Reply-To: <20250417-wdt-v2-0-49939de473e1@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 17 Apr 2025 14:34:54 +0200
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

Enable watchdog node on SAM9X60-Curiosity board.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/dts/at91-sam9x60_curiosity.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index 7f00014f13c97fe58e6ed40491f15e42512c6c8e..f70d782ff4338eff7662bb5b09b770fa1b97dd5c 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -332,3 +332,8 @@
 &usb2 {
 	status = "okay";
 };
+
+&watchdog {
+	status = "okay";
+	timeout-sec = <16>;
+};

-- 
2.49.0

