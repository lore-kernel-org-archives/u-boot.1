Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58400D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F52A83D77;
	Fri, 28 Nov 2025 23:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="296C12mH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B5AE83B91; Fri, 28 Nov 2025 21:47:43 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4F483B85
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 21:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so1371283f8f.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764362860; x=1764967660;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2wcyADOjb3BHO+ZX7nOd98URXE6E6aYuGJsajX+pYtI=;
 b=296C12mH+NXc/E14Y/QSELN1IV7oDXtA1Cpzsc+A10/t6gEsmVEyAZP1y9nmsQ8iu3
 651A/Jl7BJuyx85OVYwUoHSGP8OMIgQHBQ9sUFYwVFfNZWV0j3ycJnBBzBbU06WVUG2Z
 wJma1jo+6Yw1XjDPLRvoIeMXi7ldOnx4pCvEyHVTs2mQ3/TcefPjWM7pjf2kp0nWxLfV
 STjTbUI5+OcfOPs/f3hISF/V2o8py3Y58/qcNs6LZUoXQNdssTqO+BrFobFxeSy2VKkO
 Eij+xwTxBumXQyUEGqGJtzpO86oD4WAhJxeZH0Fx3Oe/n4xv5tVofeFIAZMz5YVkKWgz
 SvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764362860; x=1764967660;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2wcyADOjb3BHO+ZX7nOd98URXE6E6aYuGJsajX+pYtI=;
 b=OqMi+Kzf7opydqDYyaKSsbiad2DEHM1fS+g9oSOGz88mhix0n3+t5JvRLcxC0IdrhE
 MqmXVsjjNV0Sqo2UVYJaPjjatD1rXOYU8B/s2ke/jMIe48AptvjkBCRKq+rpRkpHZFXO
 awdgbgdV6YefUZpB4yecW38o8ClTYx79HMGtz6qRkKhpP2E8mJr2auh58AWkCm7H5NM8
 lYPQDQwGnQlY+ItSbjcW+4mlSzEkI49PeW0nvV+/M9/muy09yP/JhsGHgQsXyfvEu6/K
 GfKbbBiQeKZTYzF+xEHpxAFXlqmJCo26NMv1BgoMTztmXEV7rn3Jws1aeLj1CbSos/zu
 7MvQ==
X-Gm-Message-State: AOJu0YyEMDL5+83oNIo/nUAMrvEQMsMksSWWRiRVG7tjQoZ0wgC6DlBI
 Ha1rja/SDvr3vQxESuBCmrge2ZAMjz+CIycSBl9ZY6wIjN9/q47/zb6uqqo2aWco5As=
X-Gm-Gg: ASbGncuqUTWwVHir33hTQmcFagEXTPuCNFn+eK8nio3OzurYpoktNguOM5qsw0QIbYM
 jFekHX8VErJBtJqRj1z1kevr/NNfjyNcTgHWX3n271CY8Fjqe5UJoAmo9DkYRBfkk1+zj2YP92T
 ziiDYETD5Qlx9PDl+jXIqnaiQZgIcXBNYlwCbl46Bd0BkWaN/0BN63OjRRvJgbFyPNmhVhwrIZk
 ystdFitdcy+BRoPvbVl+up6cgxD6C7uP/nuAyZJklVwdXDDHSc65VMpQll/6QIS1z+AFxF277eN
 I/R96bG5xPOVlFpyq4WUkSPl3JgaUWEdDjbFSKiEFGPf79/m4txUdDdv2OGTEw/iTHssiLU6tqT
 ZpPePJZG4EUCQ8HZzpH73lFSAvda3TXw2CNp7r7A8+wXeeyWPdK6AU4H0khJWdgkBit5hf9xj4g
 SiGIzvVls=
X-Google-Smtp-Source: AGHT+IGvaRzHtN0QApxGTN6wI1DlqwovcqrzQgCTnxTkOG7pEs7gmr1Kfg/i1froe1wXE728M29Iqg==
X-Received: by 2002:a05:6000:3106:b0:429:cda2:9ffe with SMTP id
 ffacd0b85a97d-42e0f1fb97amr18661562f8f.7.1764362860610; 
 Fri, 28 Nov 2025 12:47:40 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1c5d6133sm12340687f8f.16.2025.11.28.12.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 12:47:40 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 21:46:35 +0100
Subject: [PATCH v2 5/7] am33xx: Fix comment about config symbols
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-evm-oftree-v2026-01-v2-5-42a863304498@baylibre.com>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WqMqHXlFwpIfNU/eINkXrasqXPiaUfz85EYwFgKNdeY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwtLr9tXv+u9Cr9nFyU8zxKOdl269ylwc2Hv7tI19WuO
 624xiCro5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZSeIrhv1+OtU5aC9fzOIZr
 LouiDsyeX7xWu1PPz+91oOaGg5tSHjP8j+GoYD76UrbYcs/rPP0n9feczHL5pDb8zm981lf0eN4
 udgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

Fix #else and #endif comments to match actual #if condition. Comments
incorrectly referenced CONFIG_USB_MUSB_* instead of CONFIG_AM335X_USB*
and CONFIG_XPL_BUILD.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-omap2/am33xx/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 4e9ad8935e3b5020c4ed1d022ae4846a2dc9486f..d7db260513308257f142ea70d5d5c643afc920c9 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -259,7 +259,7 @@ int arch_misc_init(void)
 {
 	return 0;
 }
-#else	/* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#else /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 int arch_misc_init(void)
 {
@@ -277,7 +277,7 @@ int arch_misc_init(void)
 	return 0;
 }
 
-#endif /* CONFIG_USB_MUSB_* && CONFIG_AM335X_USB* && !CONFIG_DM_USB */
+#endif /* CONFIG_AM335X_USB* && CONFIG_XPL_BUILD */
 
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 

-- 
2.51.0

