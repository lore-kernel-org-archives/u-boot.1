Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35459C44508
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F19C84B67;
	Mon, 13 Jul 2026 15:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fpobtG7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347C784A4C; Mon, 13 Jul 2026 08:43:43 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 147E984A4B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-43bf9548df4so1290277fac.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925020; x=1784529820; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8+r99U6DshFIrzPM9V2y7bVv6pmwdSEIyQp6HKhjRcY=;
 b=fpobtG7vZzf8boQPSogOhy3kIlpkKnUEKmgkZYQqLNLS/tHVVBkPe/vF0YB/bUQqTb
 1YainMRuNSpV8AyKHLTo+INLbeaATS4SsiOIx7fNnOFqAyKTxczMuAMpclh+xVyQQywz
 1t9/Pe0F/gHzI4VbJyZ1ZzTe+WhDja/6a6EYvzsBERzdp7s1YOrDbzNqxxNCPMuxgQJH
 lTM6sOP6iJGWBcNgmccYNc0Jv2RV7fEOuToTQM+f8wy+yO1c4cSGP+7z54lWtyn3G/gv
 F73EoMUeqNf3KeGNaHE5v3Nt97LXeR6YINjNhKThCXKLwZm60j9edw534y34+Aygx2YK
 7dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925020; x=1784529820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8+r99U6DshFIrzPM9V2y7bVv6pmwdSEIyQp6HKhjRcY=;
 b=D2PShkoHZsvKxFzZAOVFdWYnPq0nsydtPHvifZB6cB3t9VD4BLWjobJQrkLWrsyJUv
 NSb7/qne1rcwraLQCXbp2kJ0+wFwMe3ohzrI4sBPlh8sJXh4ieQuuaT35qAQ5ofwGaqW
 9fWY/vR9hp218Dpk+tkgk79YLap8Mwi84vnklW3TrPCfYu6YYAutRgdO31KrSk7qrdYu
 J+V1S+Q5TDSGU8yaY7/V9NqwLh8oOWpeyfY+KvNLPyxHsvmUZECHvhkHwlVUVf7SZVM7
 DbblaSbuY7LXKwkd16EBZsBA1BD1jHYOd6BgHALY3UoVmbdiFSHz3UaZcjj2ba/L6fe4
 naQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtGZ7gMr2XUZdL2i2bjVGq8o7EKAuiPd+2wawXXuURrYKBy2hom+YqzOeQAW6+Z3zAqFBFE4Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyJ7DkqUXRS5CXrnxdAvJ4M4Rzdh1ayrdHtpeWWEijtG1/dR4Ld
 XhPMcGJ1XMDcZWL0BogCCqTfnr/BfQVGaSOB10YTyFjXKG+DUDzEHeZi
X-Gm-Gg: AfdE7ckobC2OlPWCRNQyIMCL7760Lyc0ScYIPHkRx0dtbCG+IWlNsEh3eKsxooi9i+E
 uyMrcWLg6jX1wrZbUUcKhwZ+b9EG39vNrAhRqdk7urQw8aZjR3ekLrEzxn8oCY30IkKmK31UC5e
 H0eWsbVfu/QHXu+uzcqk/TMo0PO5klc5AYcbGUY5+NtnFm2lPWbC6V6UYb44aUAVAmGy6Liwp5Z
 Iwz/Ra64JxfQwaf/ZdtgH+61NoOJiahfiMiZTZSKQ0BZ+17XKiCKcaR4uOq//OLm6FTukLBRUAy
 L1sTz9dXAuFki+G0uatirGSOJtR8unizFvuzqRF3aPhjT2qae1EZO+aKoJ9IB/NIvx2Jtps66nj
 GM7MFc8Jj7KUhJpIM0pJgTr7YQB07MIBaXWAZEP0qoCx0p+LGoGU+TSOOfRZwEwlFWkjXsqr5a8
 MyhGm9anNrwHFHtAsImAZXUlfRd0M4na8pzonRFLUSIamu5Ro4lkVF4pOV/Tkvopd/+HEKrn1k8
 QS9I0oP+J//SvyMxEbKFCukjN9QQp9eLNcL8p7HDnj5DKeVtHcht4tVdzFapiNm
X-Received: by 2002:a05:6870:3126:b0:451:cadb:2a98 with SMTP id
 586e51a60fabf-451f0f1c5a8mr4530327fac.2.1783925019667; 
 Sun, 12 Jul 2026 23:43:39 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:43:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 13 Jul 2026 00:43:00 -0600
Subject: [PATCH v4 03/14] crypto: aes: allow DM AES in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-submit-ce-series-v2-v4-3-ff7edc705b8a@gmail.com>
References: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
In-Reply-To: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:20:59 +0200
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

The AES uclass Makefile is already keyed by CONFIG_$(PHASE_)DM_AES,
but there is no SPL_DM_AES symbol to build it for SPL.

Add the SPL variant so SPL code can use UCLASS_AES providers, for
example when decrypting FIT images before loading U-Boot proper. Select
SPL_CRYPTO from SPL_DM_AES as well, since drivers/Makefile only descends
into drivers/crypto/ for SPL when SPL_CRYPTO is enabled.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Select SPL_CRYPTO from SPL_DM_AES  (suggested by Simon Glass)
---
 drivers/crypto/aes/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/aes/Kconfig b/drivers/crypto/aes/Kconfig
index 7e1b1b2875d..254cb598568 100644
--- a/drivers/crypto/aes/Kconfig
+++ b/drivers/crypto/aes/Kconfig
@@ -4,6 +4,14 @@ config DM_AES
 	help
 	  If you want to use driver model for AES crypto operations, say Y.
 
+config SPL_DM_AES
+	bool "Enable Driver Model for AES crypto operations in SPL"
+	depends on SPL_DM
+	select SPL_CRYPTO
+	help
+	  If you want to use driver model for AES crypto operations in SPL,
+	  say Y.
+
 config AES_SOFTWARE
 	bool "Enable driver for AES in software"
 	depends on DM_AES && AES

-- 
2.53.0

