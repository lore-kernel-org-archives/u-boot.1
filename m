Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4C0CD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEBF584981;
	Thu,  4 Jun 2026 17:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="zWxYlLgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA8384981; Thu,  4 Jun 2026 17:31:33 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38F85844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so5156645e9.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780587090; x=1781191890; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fRkuqv/bEmPv1z90ZQdv46OKE/Q9rrUb1zHN6wDgkSc=;
 b=zWxYlLgf54G81A+ZOKYUmmAYZy6FVutJb7gGHvTy1YdOOzFm5sVda+awKpug2KABXa
 igLzxA3NYxi3cK5jLj9Q6T7UcmI/hP1N4ZK/pvkXMl59T1poGtOXOdc1/Pvubdxz1BUU
 9T3+KuJ0VmFJngw4im2KYtTzJnkGM1Qj//AkbVQ46GKd0GaS0j0p2GpvYwXXH07B8lx2
 lYRlopkW3KrY0jQWjQ/eQ0CD7qK3JCqhQGvaDcPGkby3Weu3WkXx7eDvM/Mkz8aockL0
 lVHT+u0S0uVNP0bdHhiuDjVf5LcnsEvBaZkzvqbQQl8PKapT9qQfko3Kvr8gOrE/mwYV
 p2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587090; x=1781191890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fRkuqv/bEmPv1z90ZQdv46OKE/Q9rrUb1zHN6wDgkSc=;
 b=QfW6dnBSBh1Lw5fgqWd0R5Mv6dIxP4K/f/RrE5XTSHxfl7bn8IORyQMswhKE7PM33D
 OL2j8acigc8BcHRZ2kA3GG7g3ovL1Sht4ydXKq0pWg0SKStpuOrB+TyGr3xYnKoVxYfC
 q4rX8RjdJNzgsccPsuVYkO6oxI2dL/CiSC8vVrUSjmAHrr6JvHMX++4MEA5XYlYHEG4T
 c+lvF1BEYWc2Np8sg4XeJJV1UjTUNI+3x3dVizQ/nTvs1diFNGYaaoTQCmkC4QAQrVsS
 qq9o7Q6Rg8cDe3DlVPF7aEKgceXEmC/93+Yo6k1XC3Cll+eKyGN/2266jHW6qrq4w8RZ
 LTXQ==
X-Gm-Message-State: AOJu0YzKRtXpwN8p0HXrRbK9r9XNrOi/iEcPltsJG6YHxz7vu0LC3i74
 Ely56lmphmuf71xo3UjzfDzaZM7xa4QkPJGrC8aCKfPcg6+cRDZdcoJ2uMG/EPDLbVk=
X-Gm-Gg: Acq92OFPwxyyUNZO1Ixe5yN4Eo54zq1toCY75NvMJvAi3idZ6je9rZM1qhUM5n6n9zw
 W2w7r0ZlyqN2UOVRhG1rwLOUbC1bzJuomlp/R8zgeKW59O1INyLVhGZ56eJ4UYOXMSNUxO5DRNI
 /Ncot4Hpq3BHTGG7BKQvdbiJ9hdyKmGw5foW0170gZA014XUc2bOiiFUbHsvp7QEDuoZKaHmRvL
 dDE1znbHI2j6SNZ5DxZoEFj+Qtg8LwrtzRsLFKx1c34dcrlPbeiFnQAii/xIjJx6gOEYVjIZHUP
 vSQOGKBqnQidBQmTNKV41YE1e4p4+7TZqPuhD/SRQ3hER5dvcmtnMdan5E12Rx875KgwOUyL+7C
 csXBanyPsthVtqfiQ3kyxHv1f7hXlQ8aDg92srY4lZ0aq47myrwLqE3yC9ZwvkZN6agLIQjQ64P
 HrLwO9cUpUM9A5aQ83Y/piqUR2r5DC4d+OCb/5HokGbAefByVhj90=
X-Received: by 2002:a05:600c:3593:b0:490:c0d8:d517 with SMTP id
 5b1f17b1804b1-490c0d8d616mr11356935e9.3.1780587089505; 
 Thu, 04 Jun 2026 08:31:29 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm28284932f8f.27.2026.06.04.08.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:31:29 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 04 Jun 2026 19:31:11 +0400
Subject: [PATCH 6/7] pxe_utils: accept "title" inside a label as a synonym
 for "menu label"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-bls-v1-6-4ce6d1ee4711@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ig8NEBPV4Jpv37G4m4dWLyevvD+CKVRPT2Ghq4rF9ss=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQpzrL312TmeBp5aOMzqenrW3o9AxROat3cs3jmRnnuj
 ounwoI/d0xkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVDxgY/rv/0XvU8vmhxM2FnNyp8i9WHcpN3v1EImNu5OdzC7fsubSa4Tdr8ck
 gr6LtU+0Dtx7zXuH6uGKZ0y7m6qveIc/myaUX72QBAA==
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

The parser already understands the "title" keyword at the menu level
(via "menu title"). Boot Loader Specification [1] type #2 entry files
use a bare "title" line at the entry level to give the human-readable
name of the entry, the closest extlinux equivalent of which is
"menu label" inside a label body.

Make parse_label_keys() honour "title" the same way it honours
"menu label", populating label->menu. This lets BLS entries surface
their pretty name through the existing label->menu plumbing without
the BLS bootmeth (or any other caller) having to special-case it.

No effect on existing extlinux/pxelinux files: those use "menu label"
inside a label, not bare "title", so this change is purely additive.

[1] https://uapi-group.org/specifications/specs/boot_loader_specification/

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 7ecee86a9ada..1f3f6150d9b1 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1284,6 +1284,19 @@ int parse_label_keys(char **c, struct pxe_menu *cfg, struct pxe_label *label,
 			err = parse_label_menu(c, cfg, label);
 			break;
 
+		case T_TITLE:
+			/*
+			 * Equivalent to 'menu label' inside a label body.
+			 * Boot Loader Specification entries use a bare
+			 * 'title' line for the human-readable name; honour
+			 * it here so the existing parser handles BLS files
+			 * natively. extlinux/pxelinux files conventionally
+			 * use 'menu label' instead, so this is additive.
+			 */
+			if (!label->menu)
+				err = parse_sliteral(c, &label->menu);
+			break;
+
 		case T_KERNEL:
 		case T_LINUX:
 			err = parse_label_kernel(c, label);

-- 
2.53.0

