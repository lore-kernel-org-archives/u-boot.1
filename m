Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7FDCED63B
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3DD83EBB;
	Tue, 18 Nov 2025 14:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vcWy7exT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE4383C96; Tue, 18 Nov 2025 11:42:36 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B108B83C98
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b735b89501fso586021866b.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462553; x=1764067353;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RvBM2jI/wYsQc3Zvvc7sIb+TfsOWvb3xq1IQ5l+vnbs=;
 b=vcWy7exTUjrtTMO0CXXL0peJIcs2pq5Sm8/bcLDzdAfzaLsgH0uIuBNr1o3pgRvJsA
 y/jaHkqljOYZFT1qkbaOflCA3pGZGzgMeQ7bj4J8s2OXbhvGO7bNuDgQJfB3yGVQ7+cO
 +4Lb5GBQFfJKNnSOHKrNB53rXwATjhLUrJY8iO1sjyMifJTsgSZfNKIEU9Ppm65NbgRS
 CQIlYQTZpF2/B4uWqnPr6JR6pyl3AHQLIGFtLXi2mAPrDNthYICS1Vltqp5NRVimL6nn
 niCuBbjjJyiX3po7fho1JNY+YTNyW+ftHZz8I9VFmd/DchJP6P77tM1E+33V+xWAbp3t
 pQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462553; x=1764067353;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RvBM2jI/wYsQc3Zvvc7sIb+TfsOWvb3xq1IQ5l+vnbs=;
 b=syUFNAZoxQAGxGM1olW7PR5pjfWVPwKF+Rxks1KMa/2NBOfV9KjsTvl3z43E3JW2P0
 FnoVqyguBD+XF9RLnkuhf9cvwUZq1I30HIMzTyW7dDIVJFrrC/1WnKDXSZOkVJO4iee0
 KoAUGR2aPGxj2Vg8mP0yD3JItkfzD2yCZVQGAR3bL2Q2GpzU75MnD1UETeyoNe4f105R
 cuiOu6CFZNOgGxnjoZmNJgxed3WVAKYpOr8NXhm4dT9nCOYOt5/CNQPlaiowydSthqNC
 QOOR1bC80xhbusyvG+VaG6236CRdvqIfTEdI8m7rC3h14duS5nRFjFD9hHbeRRtvrf16
 oe6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjr7JkOmORiHtUj8GKu4lrmKtgYnuEx+AQI2JXv5jT2qBR1P5p43mtDZ1WvMGVjRQGRezoLKA=@lists.denx.de
X-Gm-Message-State: AOJu0YyvLr4AouxaEZd+rf1isIp65GjGqYpdkOOY4AXGdJGKGRmT/7hp
 0Ldlkj8xA674JFq7t4UIJCdXcru+i9VeAJAEb8iXXc9eNb0GwNlvmymIWVDPihReRQE=
X-Gm-Gg: ASbGnctU0jvS0p+u0W2l3KONDUkXjNkZBy4ZQ1c3HrkxtPhFMFN4WP0iuJFEz+AJpoL
 sdi4IjJ2jRKGBXGuiyIIV3wJgQYPkDIv5CYXxXYbv8GaMuuzPNSHp0nf7/Ucm06uzaV8rPXNgRb
 hIc+/LnBalKRasuzhwmEd1s4veU0i++HlC2EnNqTgvnLU7vOh3qzOzUOB2WNiMWcIHUo4dhfXov
 DRuxutDlG4aMrw1NudT2dwBtDiiyMGfYh0wEs8r4/1Kv6M92mw8HB995cxJDoyTGsHdSbagNUEe
 ZEgrxxkPOMUpTU51VzUq/AqNbFIAtieAd2W96xAT5uX+XVEErmElM/X2+6MNh/V6sardzQkhCYu
 J4ekO3xvimn/GOiZQHGYuPdpDR3A6nxIJIggKGnV5ko6oV9/HS6UaBq9Sku5yLS+WzO/+6dBZZG
 93i7itLSo=
X-Google-Smtp-Source: AGHT+IEHsovZi1bTCjtAJwogPUFqAaP2zSZi4uo2N6tsydQRXuYkLz7vjAY1O2v3TIX7KBH/FRlP6Q==
X-Received: by 2002:a17:907:748:b0:b70:b661:cfcb with SMTP id
 a640c23a62f3a-b73678ee3a8mr1459724866b.31.1763462553024; 
 Tue, 18 Nov 2025 02:42:33 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fad48dcsm1326522266b.25.2025.11.18.02.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:32 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:35 +0100
Subject: [PATCH 15/15] configs: am335x_evm_defconfig: Switch to upstream
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-15-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WUfamHz2Hw0WG7tacESTATnryr/JEgjZhSh1zmxzLSM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZ3xqG5HQt40+79E06NW/t6uR9mDfp2HnrEPVVF5Ja3
 12OEmzoKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQ3h4hSAiQjfZvjvFXOELZVlxUSr/hm2
 Avn94m01715kiBS1ez0smXJs5p8FjAw31XqjLRgY9aM8VCq2TPne8TS/ii96B194xzfhiJblNuw A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
power domain driver is requierd as well now.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am335x_evm_defconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index bd188c252780fb541afbbe61a243bddaab79be93..994be4307b81d25a4a8ade4d25feb44651cd43ee 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -3,7 +3,11 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am335x-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_AM33XX=y
 CONFIG_CLOCK_SYNTHESIZER=y
 CONFIG_AM335X_USB0=y
@@ -50,7 +54,6 @@ CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y

-- 
2.51.0

