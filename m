Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2DCC44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE6C84B07;
	Fri, 10 Jul 2026 14:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Il7cdgH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB298484A; Fri, 10 Jul 2026 00:46:53 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A87AD84B65
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 00:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6a376ad8fc0so150003eaf.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 15:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783637210; x=1784242010; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WQL7NyC0xnD/EBxulCmyVTPoNPz1LE0kUz+4iiqUA2c=;
 b=Il7cdgH2Mc8OpRfJAwAF90zztyDhfu7Oe56SfCVpH8Et16RulnJVTiNoadxctEqPe9
 4QPcODfc7DZiPwIwF5qZkF4FcWmkjKJ3mtaxzSk70H2gZArzWoMv3BLAGDdKtzjIogPl
 inkASTZ2tBWNYiC2lowA5U/STy+Jqf0rSScYjM/XiJxQp83P2pYabx/9QLThQozbFFHA
 MUp0N62ywPx/W2PcDFO3xOMVZioq8J3OCBXptoY0ki77fz6GysAKK8KexQXFp2sDVJMP
 nIOkDdLZdbpl2dqomP13gDhMMY0LVi0tl+4MVqH23Zo1uy1z939lA9PlqWYXuaSd1iy+
 mS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783637210; x=1784242010;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WQL7NyC0xnD/EBxulCmyVTPoNPz1LE0kUz+4iiqUA2c=;
 b=issldzRauw8uyh4wMNGc5FUCXbTUo+BJJqnmSvnFeki+Ivdg2zRv0bPX1cKm0e28MW
 v2pA7OKXe3kQHtQc4aIeBeCoHwSPSqLXOi8xVFoDsZagENlsMPimoLBamFELgmYfbdbY
 5/K9OxF74n598GvVVxDM3tkqBPaSWu1DzhlH5gWd7OyZCsqHLX+HG3hAGf3eLYy2FX0k
 dd/suUoGLxQFmgzEe5OihDoWWHqDD3fKd6HiYe0gmI5EtuZuyoda2s77oSXimLt1X+Gd
 CakBSdie0bVlEyjDZ5QBpo+3NbkNJOWL8tYc6Y4Gp5YIhOxYSAwHxVWXQ+Sg4bVPhQSQ
 fZOw==
X-Gm-Message-State: AOJu0YxR/wxjYvCPsJ2UR/BZqblBTAk6RmBGwrTsi0dnH4jRKwd40uyC
 DTKO1MypiFynSVYKlD1OteSwdSzYXQRDR0V/t63olB32HGE6KK5d/8XT
X-Gm-Gg: AfdE7cnYAM+NdFoaIMs2a7QeAQAufT7vSEoHwyOIxvX86+UbA/NYQ7Isto0N1qiRgqb
 zE8l4JG3LE8TejbF09pk32aF1eg3oZOEMmj2HwAVMcIVhZnAKD+u9aYPQ18eSF6rb8MHZv7Mx00
 Ss/SUqxz1laMsbQeBjuPOINlwLlWFc5hJylW6hyd9b0rjdRoD2nD4Lzm82aXgRdF9sC6miuZB+z
 gXTRZeyjSH6GDArMKsq5WM22Hk4JMc2XWYlTB8AbkCEGZc5kS3q+LSgoXHfg7ca9qC/7EhPte3G
 LdagCRn5AzvQ9sVCqwhv/YGHt+mRzaAUizl5O3l5lg0cHUvHPkmEAg5+PHmPNkAuRr1KMU1HTBs
 eLRMaxp3tQaqZdfju/dHu5CnOCg18vfDdTQE1/t5uEJ43u+7NKX6VmYKhsr/X4gzmf1G1Cbtx0s
 9W5sZaTg82xaDJClWfTWYe5JckJQy6+ahqDLIPtrhN/e9nrdYto0vm8AhmZNna6icjgKth62GhH
 EElkl/9wMtuBR0nEbyPyf93TYnBUtPzenx9q3CPL7rULFjP9PRPzGZusY0+Nt1n
X-Received: by 2002:a05:6820:4df4:b0:69d:9dfb:7928 with SMTP id
 006d021491bc7-6a36d878bf4mr6475928eaf.3.1783637210348; 
 Thu, 09 Jul 2026 15:46:50 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45191643abdsm3310749fac.11.2026.07.09.15.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 15:46:49 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 09 Jul 2026 16:46:23 -0600
Subject: [PATCH v3 01/10] cmd: aes: fix DM operation handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-submit-ce-series-v2-v3-1-5017da8c9bef@gmail.com>
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

The DM AES command path takes operation-specific arguments after the
common arguments. argv[1] holds the mode, "ecb" or "cbc", while argv[2]
holds the requested operation, "enc" or "dec".

The DM path checked argv[1] for the operation, so the ecb and cbc
commands always returned CMD_RET_USAGE before running. Parse argv[2]
instead.

Fixes: b01444aa14cf ("cmd: aes: Add support for DM AES drivers")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes v1 -> v2:
  - Limit the patch to the argv parsing fix  (suggested by Simon Glass)
  - State that the commands always returned usage  (suggested by Simon Glass)
  - Add a Fixes tag  (suggested by Simon Glass)
---
 cmd/aes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/aes.c b/cmd/aes.c
index 3fd83013ffe..edcd87cf11b 100644
--- a/cmd/aes.c
+++ b/cmd/aes.c
@@ -175,9 +175,9 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;
@@ -223,9 +223,9 @@ int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
 	if (ret)
 		return ret;
 
-	if (!strncmp(argv[1], "enc", 3))
+	if (!strncmp(argv[2], "enc", 3))
 		enc = 1;
-	else if (!strncmp(argv[1], "dec", 3))
+	else if (!strncmp(argv[2], "dec", 3))
 		enc = 0;
 	else
 		return CMD_RET_USAGE;

-- 
2.53.0

