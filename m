Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F4AC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 04:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD94C8488B;
	Mon, 20 Jul 2026 06:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fCh1yypG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5334A838D7; Mon, 20 Jul 2026 06:14:19 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3798A80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso1970700a34.0
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 21:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784520856; x=1785125656; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8+r99U6DshFIrzPM9V2y7bVv6pmwdSEIyQp6HKhjRcY=;
 b=fCh1yypGelSiR5tWSZpZlikTCmmD6XjxGA88WEBwcF2Lus0I3ATfJKXRU8H4a41yqN
 qJi/3YzAKm0x2QR2X+2vHYjA/JkXuuRdu5Pa7lV912vkAVe95kpWXha1FxsOIsOniNFJ
 bREiFZrNHiYLeqqw+hwruSscMcmQFDOAk5yJo0PX7mxTAG7pH+n1ULg4fHfNNvDAMCsZ
 dnP2uCLVsCV7LYqmuO0n/eMIX6FfQJLmtaR7SKVs4TMbBmeI6seGc5UuUQDp8y+bRnIO
 75D+AicEXedue/ZI0VTb8sFN84Q39lTkAJquKtxA+EslG86M9lN1DZmZdisM0muaYbrc
 wUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784520856; x=1785125656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8+r99U6DshFIrzPM9V2y7bVv6pmwdSEIyQp6HKhjRcY=;
 b=qIKRQJlEEWCGhCFLgmwkEePJBeXry8iwoSy2+o2vRnNh0jx0I1t2vX1KX9u7lzsMdP
 Alajubf/93mY3ZpyIuZhLQqdVp7QTMgFwXBLZ5Zr3Jemnr4wG+X/U7PavhxRmqOm74Rw
 mOs//L+JRXeT3mLRCTjV5DORLlCo1zIVcWECWls/uvlW6OgRh1DmeJyqckFVhnvkGimQ
 MiHUCrZv7p1Sewclkq7jP+pVrPjgpyGQEsRVtq59u/KZ75yRZ0me923dG9Hd/73CyFZx
 iQPYHOPnb/SGYs4b4VsibpX3TkRTlXxVstFGd4FS0u35TRtz9OyBWfKwPB8lfcf5qSSc
 DjEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKq95UrqfwhmvpVavYN6lNJDZ1qtOp8+FaaQFcMZq/ZZd35l5SdwNVuJyoOrC0mMOfW6V4lEA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4MaMYJI5I7HWPBXoqwzrBruQdHlRTpsP/dHVt6FGSaZaoNRjV
 bRK1wbgF9Z6oaAcKqalqPaACKKy70Uqd5ckH8EXoWqG71/KSbZ360TuU
X-Gm-Gg: AfdE7cmgVn3HqKRHPpPDnY+OwTt0qS90Ux4vR9lZv+hvipbcGv/dBGhKn0oyoaRXrgC
 g2bKS4h1qk0cIdUgDyJcSpMqYEGVxssCrxZ0C9izcpbwihmMHffrP4iAPhUjO4upTmEDHI24uEk
 IK5tQk4669XgmcxYrFhg6rmiCXbF8WyOGlbUEKCh1XSdn+t4qHn9gZkMCgT7l5dVQTENWG45EkC
 L23YzDU0gGXS4TACw18AfIG6XGPYruE2W80yW1cHGNEHrOWRLjnDVL60Fq1y33eh/tGI7IMTea6
 iZadqGBG5BSi/4OFLZv2fCg/+v5kPKfBT9xdAaDvnnCz5XCqa4Pa6LXcg8SSTkBxrNYEwApdLZO
 nZBG1e36rCruAqFIy9NA8AcwrY11IH+pUio7LkiFK7gBby3V6MRZDcs/o4J1Qx6OLhOKEYUiqOp
 5iIon/37tm3aXDPspOPwQeUhVCfvffgpECm1ssdXWpEFHVhXosnAQT7U4Rq+EIttp9Ipyl6JQGY
 bNffiu9fHgv18SgqeOYBCfdbnjvSVrbrQlaiFugf2+IcXSo3DeQEg==
X-Received: by 2002:a05:6830:2a0a:b0:7e9:e808:e9c3 with SMTP id
 46e09a7af769-7eda92cc79bmr6150878a34.16.1784520856024; 
 Sun, 19 Jul 2026 21:14:16 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaf94a737sm7159191a34.15.2026.07.19.21.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 21:14:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 19 Jul 2026 22:13:47 -0600
Subject: [PATCH v5 03/14] crypto: aes: allow DM AES in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-submit-ce-series-v2-v5-3-3c41f66d4522@gmail.com>
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
In-Reply-To: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
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
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 20 Jul 2026 06:33:25 +0200
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

