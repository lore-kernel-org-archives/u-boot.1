Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7F5C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 07:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32648484C;
	Fri,  3 Jul 2026 09:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NKsOUyzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0473084994; Fri,  3 Jul 2026 03:50:03 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F62F84857
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 03:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7eb64085c45so27986a34.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 18:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783043396; x=1783648196; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=viji+IAB7fMfNceu3iB6CUz9uHBI976SoXN29A4mNo0=;
 b=NKsOUyzroJSNi+iVE/exVszfTsQgH9r35IywYadZ0PYgaDDQ40+4qn+kKqM56Z21EK
 ugYE+fYOya+j6HNvhbej7YiQ4OKXd9t/jz9rQs23N3gF+y+uCLnJEfNc3PDh/nhsFQLw
 KaJqun8GglamlZa5jQk0Af4izgAO1VaPQ9YoctMq0oZJ2X0TosCCLx+450z7ruF2RxLU
 R44Z7W0KLzRdoBdfkPuHIUk6P/7uEu3d1MqK3FfluHjm/mxfXxbVkLqwpoUn2qlY7Jh0
 2qU8+S+YPLAkvAESytRdlOy6XLY0Y2iJPAM9SBFOJbJegCzhyTlz76tipgAnm5v5CJ8v
 th8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043396; x=1783648196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=viji+IAB7fMfNceu3iB6CUz9uHBI976SoXN29A4mNo0=;
 b=KBQ3rqkK0P+FR8idfQfdk/I6RDdx/QIPnV5mO6c0nbbQNuTcof5vzdOoEsk0Ufgkm8
 /8knCzD0BXmtQwgsqbNahrXHj+oDW6rxJDTbypnBR/lGLYCau5CSDYVemnYUmL1prTxa
 zclxraPkKgIcyaqyZkJa8mcBGoXfhT+PoOSlhC+RWqe91j+yPFr9iWYk79VBPInZLJJu
 Rn29ilwB/d4y4eF+pG4oEVpHc7HhtVlGQ7jQ+EJSAlaOKvSaSfde+clXlqWAstkbBArH
 KeuXB4gg7Q76/UytVm4dlYOHHcN0qJcYqXWQ8ASfnZx68DUzc2Vk1vtgWkL8TbKoALc4
 XXZQ==
X-Gm-Message-State: AOJu0YzRz8aFj0BXU4KRf6fGh6LTziqoX3KU05vXIbASph7z5sZ5vReD
 6OxTRlgdhOl40EZoV/gfyBaNaCJSN9UQv5FtTaw7/iBkeDq8aKjH5cMt
X-Gm-Gg: AfdE7cmpsPVXsqBrvhUvowP0nCI3ovy5bhoK9LYCyEIbQcwjZawJbzT4iveb87UUhI9
 mFdippNx3TxuALM4KtK54l6oT5jcmMUpvvugdQmPaesOT8MgvkLLkmArW+UeIrheDlVE7ardfuU
 rfbDM80x7Geoca3Rl6pYuwABXfsVHyYclEGebJD5aT9txsaTI227xeytqT5xa14qfr1dYnoJl0z
 UDYmKSerf2w9+aLoTVhhmAFUDdk6RKvG8JqLtGzzSacPVXQhyW/izKAd5YADNEaEXNrWgel4y6t
 Uuyx+2XbG+TxjQsG9AOFIOD1jMGOudK5dy3bLsSpxXQJ8hMJ8erpHNlBJ1zgKxqmG3DK810U12x
 o/7OUJHiloavAPfDBYCxkpNOu4+iExZDL77tkzdTgApc2MWLD4KSvw/b65sFiwsfnGKtSyEdgY+
 uJm3pusmezqqKDSZ0ons720nyrBQzleeRQDwssEed8nDV+VOK0bgUsZtmdw46cpxUgx20zOXr7N
 uRY4IN7/A9h+o6TnJhlLPwnhSxKXPzGvyftI41kiNlq/ov7AxT/yuRv2HyZImTrPVlTsw==
X-Received: by 2002:a05:6808:c082:b0:496:fd1:567b with SMTP id
 5614622812f47-4960fd179fcmr4535124b6e.24.1783043395821; 
 Thu, 02 Jul 2026 18:49:55 -0700 (PDT)
Received: from [127.0.1.1] (97-118-25-163.hlrn.qwest.net. [97.118.25.163])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm2974888b6e.14.2026.07.02.18.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 18:49:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 02 Jul 2026 19:49:47 -0600
Subject: [PATCH v2 02/10] crypto: aes: allow DM AES in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-submit-ce-series-v2-v2-2-ffda5bed58af@gmail.com>
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
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
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 03 Jul 2026 09:59:22 +0200
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

