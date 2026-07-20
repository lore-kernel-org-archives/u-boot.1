Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F983C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 04:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31CA3842FC;
	Mon, 20 Jul 2026 06:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R8altKKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 777B080433; Mon, 20 Jul 2026 06:14:12 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C4E5838D7
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7eb3865ea6fso6835575a34.2
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 21:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784520849; x=1785125649; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=R8altKKLdmZXBfcGM2WiHilOY+iyPj8saFO45D3VgOI07AmT6kZzPQmPqxWa5F7H0D
 H9yvDMXmQxy2CqUV2v7Si0VtqFbJnf+ZNNG3jeGDC5bJLbN1RGc4cvfH2S7dKkRM9pIH
 l/8FsIgOIlbW00veByEGl8sQC0ytEhY/+NaDXxn4z90vvciB4Rx/4owyT+ht3T0S17do
 T3baLNsD6iAIpq08zl00Ee99Uqv/AnQyTArzIHMGSis5Fr5T4RiOtdzucSfqDexKjg8A
 N0cJTYtT80qDafYdGMweI+Y3SeiSzlFfTkuvclNvaMBakzqro2obpkOegP9YjvTLRBuL
 EEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784520849; x=1785125649;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1XEBQ3uzR69M2nBOFTBjrzenv3EgWoQiRYWZo+q7syw=;
 b=DRMhrWQbAC7uz3krWDYXONOHqWmMzirBjhmo906xR9oSpf/HEAGoRRwxKwsHgxAmQY
 mmlVGGD0mrtntZxjVZfeugbNJCxrVQ3gqAhSzrX5zF1LaSb/41WURrdhfzQh/LuX8wcK
 1tr9tppOdmXmv6vIy2uWOtyIvpBx1jVXQz3pR5Kdt/WboZfzSFubC3TlzcR28AwAj0pc
 uONvaGIU8jNuztYtbt4sgsAFVgGmjn/waRJIKmjLrUGH7p/hDxFc0dpsDKxYS7ZDKMyC
 YzkRVY9DSaKOd70dUH/e9TT9RZWEUU41i8cG8VLszy1ad6UI0DMgu/uH8Px+g7KaqBFY
 0zFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEnCG/zBuPsXatnEGYADveQcCMo8ZSENb4yU4ByI5Z5LE4pLVi6leefQkzjzQYHF9M9VWiUvY=@lists.denx.de
X-Gm-Message-State: AOJu0YxFGIh4YSPQpBVPwQkR8JzfMDG0vEH9bTDk/EckhM2HQgjyw7r/
 t+UThNrI8g/ZlP0dR7CXDSmGcaVDf50wePSy3l6y4Us6zPCm5pXSsaqX
X-Gm-Gg: AfdE7cnyZTuTZklsazMGJT9OugOwoqGT/hP0MkULMrLqay58vy7gzXFNZ2htFFPVc/X
 2ibi6LwMP9LStnpq4bGN0eN5Q6ApZ/aoPzhRYDNSp3Mzq+wRGfihDWh7O+oeg2lC24ArRvaQVNI
 Di/jZBbbedpoSHEcsJfwBo/IXTipBL+5k1hv+f1R6FgDgrxdOM2AB1sEbfBDM4RzC0WUq18NjUf
 zi4cF0V39VyI4xbcRIm8GSxmUVVWIFtA1RmgrHSKWG9FDsm70TZCi/oEzITmBf2rgNG0qMC/31B
 nTcnINXxIHyHem92+OuJLXxaidSu6MZwKi9yOQVkLH4HlSWF4IAj4+wgjQfcF95XuNo36wsWYuj
 VVvREQYwO7y5FZPMRAAcHqm/vUDQAelkU5TrQVJK48nz6nr9cz/BiubbSxHoiGnYrhCVKbpeZXw
 pdOrvM5vEQitRQrT+Q7o9+SpZFqA/Bu3phAEZVqgcjLCYCfwktxcVzw2cStROp9JyF4Lb94O3C+
 HPQ+qXvj79LPlVU9dXOgVn/6Jzi5JTT0p9Uqk3dO+nruQTxKPTNPw==
X-Received: by 2002:a05:6830:4106:b0:7e6:8955:c52d with SMTP id
 46e09a7af769-7eda08a96acmr6518310a34.5.1784520849113; 
 Sun, 19 Jul 2026 21:14:09 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaf94a737sm7159191a34.15.2026.07.19.21.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 21:14:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 19 Jul 2026 22:13:45 -0600
Subject: [PATCH v5 01/14] cmd: aes: fix DM operation handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-submit-ce-series-v2-v5-1-3c41f66d4522@gmail.com>
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

The DM AES command path takes operation-specific arguments after the
common arguments. argv[1] holds the mode, "ecb" or "cbc", while argv[2]
holds the requested operation, "enc" or "dec".

The DM path checked argv[1] for the operation, so the ecb and cbc
commands always returned CMD_RET_USAGE before running. Parse argv[2]
instead.

Fixes: b01444aa14cf ("cmd: aes: Add support for DM AES drivers")
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Limit the patch to the argv parsing fix  (suggested by Simon Glass)
  - State that the commands always returned usage
    (suggested by Simon Glass)
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

