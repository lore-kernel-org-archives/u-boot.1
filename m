Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C73CD6E79
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA173839A8;
	Tue,  9 Jun 2026 03:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fTN8P3L6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB688484C; Tue,  9 Jun 2026 03:25:18 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECE68341A
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-68bd4aec7b0so790813a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 18:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780968316; x=1781573116; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U5v1oob8sEnM7olPNAgHeYa91E/ppnss699BOxt500g=;
 b=fTN8P3L6votQSbgIftjt5h+fIsKMnm2VQnb77W431E3m6Dj1lubg0gQK6Ygd3CEfDn
 6IN8uzY3huR6U3APMB+xl+j2bBmD7vgEeGedAPjt8TSzWXc7+WBZbNxOMxS8ndIcY+GL
 yNv1l4Yo26vqvM/S/JFmovBxqv/jmlJWgfwnH0dE7j+diOU8Mo72kVDxRAGGEq73F9Uq
 /izIErqygWM+h1w8lPEVrd7OR6/vbnRUHWH+mwn739qUq7fO8XbDMjq5TqWZaR1/6k9j
 wYYHS5UYr+U7+l1MvaGVBswAEMDunWmx7fsHEEwfKQV6EHOlmiTTEmWlWLn+iyqUde+m
 tJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780968316; x=1781573116;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U5v1oob8sEnM7olPNAgHeYa91E/ppnss699BOxt500g=;
 b=lxtBNYaZtb4gEqiV1ViqZf0Qw2yWaevqFig+uNdCwwCtLlbXOXuG2gLPf3qFKoIgSa
 b9VPEu0bAhdEslmuvK+OHWTALJayVNOYoJgTiayfI9FM4tiDLUxUUlcqro8jNpY+igrm
 tGvJoKoJcVHY1r7mB0U3Y/wP2dKd//ShHDMRyWkOioFRKGB7ct1i/2Y306ArMdPQ3R3f
 ZDp4iB6iKpAt7WYyz8Z2ySkV6lR2M+YSec6oNc1KxOGmF9bJyVnaa3DtJyIG6GVAO49H
 1kGnB4CSWFthO+WDmYVXzjso6X/wRMW4eNQFYkSE1xDAY61XLziCpnaXygzBjAUQ8SQW
 nUog==
X-Gm-Message-State: AOJu0YzsSWHbBESDYU+zmYI581CNzgMp0/OW64QugMffSOjIl9MA0hrJ
 6IiZRVTYZJnN4dKq99IYhHnZ41+v2IENg17y/Pi0LU1NQVuzREFlVfQMlxoTIg==
X-Gm-Gg: Acq92OHjs0AqKrsTEADpo/5iqY2GLh7qjZ8kLwhwA1GDV0zoMfZR74QsBvpJxzBf55z
 82K8+QU1xHMRjmo7tKuX8QQNILOoJA7g+5gXlOzAPEyHUiNPfHO8yTgmH6C63Fsu01plsV/HP+r
 rW2p2MH/VdR4zlQsaMzgMBCuWWTX06rGW1ycR43uKX1hdIzYExie28cfoWSapEFwJlpNt1sjBFS
 2wfivjt3CB5So+LmmhGJBEtbLxtqobByRD9K7EtgqF375GxmOM0dDucRqrg6izdsVcfyUmBg7Hy
 uzY+UU+s4hK+qLp3y1e7rIL19Xnvape7ydrks78sve1bjaRVJls4ZyCjfpr6XhhgPdGHn7W64FB
 bqjreJFWnDU0cVpqCZHjaHPS1BUNN5lhEbOf5s1KUzv00OqgC6YYozkw9R/SYps4FI9f9CyidI6
 Ebho4y/Fy6JxvxF1QRenga98OdWN5QJX5jZn5744J1ywJ7rKKyt7UAaflXYQo8p3T0sK3ovcWtt
 6S3IVE/ma8=
X-Received: by 2002:a17:907:75f3:b0:bd2:37d6:8fc1 with SMTP id
 a640c23a62f3a-bf37234c507mr299664266b.3.1780968315538; 
 Mon, 08 Jun 2026 18:25:15 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055307ce3sm945708066b.43.2026.06.08.18.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 18:25:13 -0700 (PDT)
Message-ID: <20cb8609-eecd-4863-9542-572dca14a294@gmail.com>
Date: Tue, 9 Jun 2026 03:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/8] Kconfig: power: pmic: fix typo
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

While restyling Kconfig the script checkpatch.pl gives
this info:

WARNING: 'refered' may be misspelled - perhaps 'referred'?

Fix by changing 'refered' to 'referred'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/power/pmic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 5bc14842e666..8504ae2b0796 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -376,7 +376,7 @@ config DM_PMIC_TPS80031
 	This config enables implementation of driver-model pmic uclass features
 	for TPS80031/TPS80032 PMICs. The driver implements read/write operations.
 	This is a Power Management IC with a decent set of peripherals from which
-	5 Buck Converters refered as Switched-mode power supply (SMPS), 11 General-
+	5 Buck Converters referred as Switched-mode power supply (SMPS), 11 General-
 	Purpose Low-Dropout Voltage Regulators (LDO), USB OTG Module, Real-Time
 	Clock (RTC) with Timer and Alarm Wake-Up, Two Digital PWM Outputs and more
 	with I2C Compatible Interface. PMIC occupies 4 I2C addresses.
--
2.39.5

