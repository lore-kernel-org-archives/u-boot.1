Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3E1C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 07:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A502E846F8;
	Fri,  3 Jul 2026 09:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nPxlDao8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688A5849F3; Fri,  3 Jul 2026 03:49:57 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48BF484994
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 03:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-495d310b587so15045b6e.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783043394; x=1783648194; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cMeqdJrmOPrfdcTctqvPUnrfJV9lJE0GuAQm4rDEYq0=;
 b=nPxlDao8/J98MvMtn7MZfkrt44saoq5Psx2QH7BqQZlcBE8PuB4JcGiG3K+j7TjfDG
 I/5hDETk5EZgx/aW8vN31VJPYjIVLnootLFUzMlS0W4OrMwLsiq39SW2tcyzW5gpDB8n
 KlU2G1Oha7Fr/jXQG1uIJ651u6bovyA4fyVgNaxJvGrioVdNwzqGtHTERgXp0uDl8Tad
 Do9ThNOBSy/dzo0Qpc9WpD6HDnhqWqjraNqJMLrlnMN1j0Pu0DOoH7iYrwLE980Gq5y7
 rl3ZHDJmwTW9xVex5ZGDxVlYlTGyk6eMELsHgHku4Oqxzvl6KuhiBbSCu2brRZhdXIkb
 1O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783043394; x=1783648194;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cMeqdJrmOPrfdcTctqvPUnrfJV9lJE0GuAQm4rDEYq0=;
 b=prfr155bHKKpUfz2JVQjFjsAqexlTwxeeuwna0Byk+id0qR+MKULwCfaoEBIzIoMai
 t0VLJQaJp3juKAIFcsKYGiQeNz9Ep0dzx8szLV8dXCaCx1xNpL9sWh/nHUik2A4j3Rco
 FAtcHxMn/kYrnzJIcZ/KS0g4F3RxAUjdaKMGcKwcdrjTwT6GwO7QOuybTnbv3ACNXy4q
 wnpSOtFn6JBxZop38/OCyzHLpotDaM3v0duRfmN7KSrJjoum/Lv6Xz5B8sEyq70pvjNM
 XVftlgRQfzJOcb1AcPKv9R+p1SEJePLgnvry3YiY5dI+kXF5nNi+/wQy+aKlGKCXLLCC
 HQtw==
X-Gm-Message-State: AOJu0YyMXRrKmHq8ybpBrnh79fnDrlqZqMxxCfyTyM5jzqM2SI467zEA
 cihScJvBAzgQo+tY1KQy1jlRbWn8Qas+qyTVNAhyr3Q2n/uLgh86QobL
X-Gm-Gg: AfdE7cky1EOQlewlVbqkLYlNQ3D41YyV8T7EcUXjml73oWq/lv++nIMf1Xct6wrBxu5
 yRwvN6yIWVkjQ7aEWb9yCfs7aMAyIwpe3oC1WeD+2Vx4/f1Rwj0we7MzWlhHcVSkQad+N4q+duB
 7ouIgzUGq7V7gw1b9Plic6BF1ucB9nSqGwxWcu24b2IoBov0FZcrzaukqF8A08FwM+7Qo4egDI6
 b13o2EXepcIF+76G/qbObM0Pg5nkKSAR4aAnM+jGRAWRozU5JIAsxlDSxINenTrX85nqiLsskvX
 +nCDrxfewd+/YaU+fPX2yS4dti3SP9W7J0+hiQPUQmWmo7qdsPb6Q5H9L7wkT9iraJNOJyoEiou
 qyMRrpnLkd0N8jnfTLcqFEr8C9p/nXx174ceRVv5hbAS7W7Hol+fNeDW8YPbmSDsbp6tJFBjs3M
 zvhr77FnTdA7//CNNVh266V7t63QwI5nPlDX5AhwYa+Xgqb7YpBDgQ5izVCw6FjU9mUIdyNfsVS
 aF0ktUrVJ3cqNLsDCz35lWy5/kmacqnQh9Pn1FttbECwGi/yMRFBmUpCVWjgccBTsxmog==
X-Received: by 2002:a05:6808:1305:b0:496:67:d8a8 with SMTP id
 5614622812f47-4962d972eb5mr5780841b6e.26.1783043394041; 
 Thu, 02 Jul 2026 18:49:54 -0700 (PDT)
Received: from [127.0.1.1] (97-118-25-163.hlrn.qwest.net. [97.118.25.163])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-497d1b43cfcsm2974888b6e.14.2026.07.02.18.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 18:49:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 02 Jul 2026 19:49:46 -0600
Subject: [PATCH v2 01/10] cmd: aes: fix DM operation handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-submit-ce-series-v2-v2-1-ffda5bed58af@gmail.com>
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

The DM AES command path takes operation-specific arguments after the
common arguments. argv[1] holds the mode, "ecb" or "cbc", while argv[2]
holds the requested operation, "enc" or "dec".

The DM path checked argv[1] for the operation, so the ecb and cbc
commands always returned CMD_RET_USAGE before running. Parse argv[2]
instead.

Fixes: b01444aa14cf ("cmd: aes: Add support for DM AES drivers")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
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

