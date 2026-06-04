Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A13CCD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0338495E;
	Thu,  4 Jun 2026 17:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="I/qXQ6Gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB85284964; Thu,  4 Jun 2026 17:31:21 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDEF9844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45eea68dd6fso485659f8f.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780587079; x=1781191879; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E+pnW/W+7pF26KQq0l6gJGwreTT+BEOc1GS3Rp2zkE0=;
 b=I/qXQ6GvSaiL7mm7qJ+GhboVFVHsTBAVCadazK6IDqDZc0CxxDmEjhNS6J+IDBiznq
 ZCSXao8TXuhhJftugiFvCs1NPkWEqlzeITphSDY1Bd8t2u0J/eZ3C4s5BFaUdPqhOOvK
 AekMiKxR/WB4Ly3WhybqKFof9VEAzgbpERIvgyEHzcJNMigMSmhrGoGhbs2fnu9UYr6S
 XLP/khiUHb73hF3LsR0hYpcGMGyRBjOwKBG/tSolHSrU6ibN7ZlPMHFPR1tbuuoMtonH
 MOE91j1wuQRwETbbL9ZsWqKEluqh74rzljpzO5qEHAcYxQlMd5GzOiGAgY0K+mE13iW0
 bPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587079; x=1781191879;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E+pnW/W+7pF26KQq0l6gJGwreTT+BEOc1GS3Rp2zkE0=;
 b=L0gXl8i+XZmtgQIGzpQ76V36liGj22rb1ohN2qLMUuqdjdlOLPGXPtIH4H/lXbPHk5
 jBgeCTMv5P1FIkjWbrHhow45gDgiDNCd+qFKfmXWPKAfuFNEMyJskOP7EGBDwrpiKvy3
 u818PY9T4cQWx864bz/zcxnYJIgfk7q9qAIwXcUd5DV+YIUWazmJPzG/c998Tiv00vvs
 k8GYa0Esf93lXOzLZKvrr2tn4BddlSnR5pYjBNvUyJO6syfi71KVZvGza23+TuE1By8/
 JLORTNdKJDQtntwxaLEHzAgE7Qw2kQeBkSlEym3rvbN55TVJyQq5IRFybAJ/BoAN/6oN
 YAGg==
X-Gm-Message-State: AOJu0Yxo6Ry3th6SDokqwFjVu4JRwQKjJCXNIwx8Xw9ewsDPOtuPFV72
 z5u6/mpjAIAlmmr1oEA92ZEy44zqme6h792/l6p8bLURW+hr3j/nqVkpN+8t7XL/odU=
X-Gm-Gg: Acq92OE/bfXk7T43xp/B11xA7v9W8VbrpD8AeUxfqqoLtQArpgAIu0lRVU8Jl/QlllM
 gOgdM03UzWYF/14jH5Hy+Lfk/+2v0ngqfhKUXtmgHrLD3I592TjEOdmCsHxqoEo0/3dHlZXsC/m
 topAxXewjTEjsT2HEzb+FptxP90/eUSf/L39DgrziH3q/guEtigrYSA/YntXEmIrm8RSbBPROd5
 oMocJUfnH2fCg10Kq/xqIyO7RytKRXyZViIUS7DF0DDDcIzEx6XY1duysQqaMjh3EiXLGAx3xxb
 6FtzETgu6ji+Bja4TBgglEVVeumz49XmvD8f7dvBhtJJ3NCYJ6YzxW8/J18wglL7n5wBEq5+8BK
 x8jwnv8G+Vm5kiG7hrctJmc7s1FGmx8pUBX/itppn49dVxe5Bu3OWCD9igLe+ScoUqZ58eJ3XdL
 Up8pMTeN+PY/TvERJejD2Isx7o7VsvYpT5rp7XnqBnZw1A20CFKRU=
X-Received: by 2002:adf:fc12:0:b0:45e:da57:be33 with SMTP id
 ffacd0b85a97d-46021827e34mr10537983f8f.23.1780587079219; 
 Thu, 04 Jun 2026 08:31:19 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm28284932f8f.27.2026.06.04.08.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:31:18 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 04 Jun 2026 19:31:07 +0400
Subject: [PATCH 2/7] pxe_utils: accept "options" as synonym for "append"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-bls-v1-2-4ce6d1ee4711@flipper.net>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
In-Reply-To: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=alchark@flipper.net;
 h=from:subject:message-id; bh=QmHFsK72PoK7JDTowwTuAIOPrErhO+OQCo+8cpfuAh8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQpzrK71PZdwKx/Z7Df7CWzTlh2PrqxRO7Jub/ZPKbfl
 Paslt66oWMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpbrRn+GedKGu7/PequlIlz39TtZw2XGQ1f17yOvhiNePnt3kVx5cz/GbR/bp
 kWcUzpjNZNVPeSgqVPC6IMvBY8OP/4mP7lkp8tuAAAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The Boot Loader Specification [1] type #2 entry files use the keyword
"options" for the kernel command line, which corresponds to extlinux's
"append". Recognising it here lets the existing pxelinux parser ingest
BLS entries unchanged, paving the way for a BLS bootmeth that reuses
the parser instead of duplicating it.

No effect on existing extlinux/pxelinux files: "options" is not a valid
keyword in those formats, so it cannot collide with prior usage.

[1] https://uapi-group.org/specifications/specs/boot_loader_specification/

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 774d5f43c036..c45c9d0cd012 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -894,6 +894,7 @@ static const struct token keywords[] = {
 	{"linux", T_LINUX},
 	{"localboot", T_LOCALBOOT},
 	{"append", T_APPEND},
+	{"options", T_APPEND},
 	{"initrd", T_INITRD},
 	{"include", T_INCLUDE},
 	{"devicetree", T_FDT},

-- 
2.53.0

