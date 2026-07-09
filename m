Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBEDC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACD284B19;
	Fri, 10 Jul 2026 14:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qiQ9FCX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC3784B65; Fri, 10 Jul 2026 00:46:55 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB8784BBF
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 00:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4518ad44e83so150153fac.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 15:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783637212; x=1784242012; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E2gSOQg7Wc1sleX3luoU+HDXj4g81KKvN8w/aXXCN/c=;
 b=qiQ9FCX4FkHSZWVOYaKyHlws166BPciJLsoTYIWuy11J/BY3WdWdQH0r+JUfGU7Ziv
 OR989K0PQC11wh19eYoraHqfRUPuyzkokdSulEIp3zA6d0KaYM7vp5rGUorkKKoUs6iq
 OojAZXv4RXPtzOd0Q9/15d0IgbAl44hDj8OJpv1sxy1oeXvrcbm+abXx9ORSYllqPUYz
 cV51ewY0dpnNNpRxUhcTBaz0DdT8VC8pb7I+ckgnVYAqv+1+0ch9p68o/i27R2w6UVIJ
 uj8z2sQtuPddY5ih1QbpQjDgJsrG4dt8pslbLK6x797sq/B6xYygQsvooE310ghqNcx0
 F+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783637212; x=1784242012;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E2gSOQg7Wc1sleX3luoU+HDXj4g81KKvN8w/aXXCN/c=;
 b=BO8cEz04Wox/qLyUSp+7GRCv764lp1+G7rYBMDsXcwcBO5WaeknMKYML45UVKQ3bS6
 ngRK7YUYJJJ4X7S00NjkUz/N7Pm4ljIddj7sL0P5v+Cgah9qYh9vZVI+GTlySVYB9gcW
 nTzCzvU8aOkm4+IdeVxNUXq+uoj3yVtNgAwNMXGAj6jJxey7MAWUIOdoG91E3O4b/dSM
 AwyIZELsZY7qmalB+a4Eld723WvVE8vZjY1YaDZ/Ygl395gC1z/b+nHkSkPnbh/HBa/z
 hp3RG8n34q8w75J389Yha73mTjTaOAGcgIeCUOV5a0DkZSFKVyVT/CJfb2UjMx0VIsJ3
 sF5g==
X-Gm-Message-State: AOJu0Yw8QZFn7OVwg/Mlr+fKOxvL6/nIUo1FHtWg1GO2IEIUN0Umwy5B
 EcWZRRvrbuV9pQYMd+Sxfjrwk+1Lcnf94ASNyT1zPK65GDQXp3e4WDEY
X-Gm-Gg: AfdE7cm+49//6UFkS/vXAAqfANWxkCEKS4fvzmMIovHqAhW0LYK3rnMING2OUX2LFoN
 0mm1dyrK/sFWdFwwWwGIIYma4KOSN8wUsqE6Fd4DIdTrep0Tix/n1LMRXbwWKnfDr3MJO/6lRLO
 UEKKvHlYyQ0UYPwp8D4kSl9kxnFWpQMvs8ae06lyuJqzAxBRwmH+Po+QhwrANmit3sihQRRq/aS
 ZVa42CR+LVLYnTmLT40Wp7wrzJTKnb6Wt6bYjwHEGUaMsLq+PTP2eKUJwlK5jJ9ubX/K7WrA6kn
 p5X8N2RXuuPtTpNzLhSTx2YylygfbB60jtSTvhPD9Lu80qTOY5nf8jYXWlj4ikQch6Z/QjmLhc6
 MWyPzy4/d3UZZymsDX+Oai89NNpw7XZZLsDZndgHaoJqmDlchhxXVNMXlBxZX0LeVz+QA8OoMdO
 HuZFiBP5+ODFgy7XnODjrytyhP0dLJ+x5+jkQCqQPTGmEM/mdHb/SwrUCQdJjEB5j1V9/bZ2toS
 hHkoThBOaWrx11Sj1wzA39usbYJQPmd8RXYXSdUhxwP5plr/Hq8CBIB4epVZglI
X-Received: by 2002:a05:6870:3924:b0:443:154e:45b4 with SMTP id
 586e51a60fabf-45163cb580fmr6891872fac.28.1783637212242; 
 Thu, 09 Jul 2026 15:46:52 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45191643abdsm3310749fac.11.2026.07.09.15.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 15:46:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 09 Jul 2026 16:46:24 -0600
Subject: [PATCH v3 02/10] crypto: aes: allow DM AES in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-submit-ce-series-v2-v3-2-5017da8c9bef@gmail.com>
References: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
In-Reply-To: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
To: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ion Agorria <ion@agorria.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Michael Walle <mwalle@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
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

