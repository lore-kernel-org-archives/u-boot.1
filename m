Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA17CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A13849CE;
	Mon,  1 Jun 2026 14:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="OTShcMCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2016A84862; Mon,  1 Jun 2026 11:32:27 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F4584837
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490aaa51683so4392035e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306344; x=1780911144; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uOlP9ehqKD0nJx09UK1ubBUZO9S/PHd9NFMrxofHz2E=;
 b=OTShcMCf9OEJ8BwyT/uOf66ZvUuAktjLnWaA43PbeSDnPPB7DMRmNvk4ELv2UZ+Gu7
 L+3NgyzDx+ybo4H/ii2V4/8M0qmeVcCWE/52q1047iJy/EUT5exVblhxTkA74z/qObvw
 UjNdMlPDrf4gPe1vKkeqpZCeltoZDdtKE7T0u252m+MF4VM8WihN8NgGhLwQW0MOmI+/
 fu+L+B4HTBTpwVDk0xGSeWEuiR4+CiAhMCnmVx3qy7V7URC1GyVJsyRol4jcrBRiTqPa
 yScNT3kNggYQhg9fXOl7Fd23U8cxBngnzGFKS9yCeAkKBGrDiZctkiFSJoy9rq7i4paA
 PSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306344; x=1780911144;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uOlP9ehqKD0nJx09UK1ubBUZO9S/PHd9NFMrxofHz2E=;
 b=fDanz3a8d9Tplp86nuQrKGoStYLt6bFnIsXI91oxzl1756xrXdVTzNhjLalByCxPCr
 xDTsxsMJy9Sp0F+keGhrpX8oeC6QjJOk5ufFxn8XvyA0UFx6XFZPwignFC6gP4EqiacZ
 PRmmob7OkeBDR4xfx+wbjO0krIf7lW1Y/8eenzSDuH1wj60u36eByCs4CJTypKGziQ1t
 eCBeM7jNO/J9p3pUP42xcXTfVNhTxisOFw73nVj2sn4/XBnCihqNaMRb3mTb8i/XZ2sF
 kr4v3/tpLAi7TfhZUgEk8Oak8bxhAfW6NYxkxyKIc8wyF3lsThrNmA43MpzTN7LhNnUD
 Gd1g==
X-Gm-Message-State: AOJu0YwlJB3SpPgueUhGy0ypUrGdjekICn6EbIfvc9vNyTEaBC4ubADE
 FeVay/wVHzSdAeodY8CGOfZhIup5qwFf+vUYVFQbepRW1AMCon6r35pJAABYWQAHW0k=
X-Gm-Gg: Acq92OEJDMYWpHNTMjeXX2qN6wJzcxQ192c1+md5ooDbQ5myyKEKd9hr3wiYpJ6H3bs
 0sXvEXgJ5kvL3AcYaBBrTc/DZ/JxhiXh/O0E3a3PT6BA6vKqFN5Wdnf3RwCSdrL2eP0ySzptXB8
 q5cyDqmYpa1BRhwUDSgOLN4fo4VUUU2N0cnhG+SESxoTatcBl1AmzH86vamFYKcsK1ttEyHj9MX
 8O6lSTdkgKqkSf3No4vPAcACvrfACS+KgZ2JwgFoUMsN/tGwusj2CkAqJfh2jpg+jbLBzGRLnQX
 dj5Ike2r2bARc9e5iGvpHTPfS5KohpllZPN2WaG0ts5WKq/gj9yU5SZI6KPFzKEnet93aqwAku2
 XEvIEoWL681B0LOSfrviLtiDMC/IMqVUFRgL+HE/nH5JLdQqboNPnSjEMHqD8NHrCW+fTwOvVX5
 tQYSzzxymQoq34h+vNVFxNtwffMGgQQv0=
X-Received: by 2002:a05:600c:a305:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-490a2933b47mr142099185e9.20.1780306344190; 
 Mon, 01 Jun 2026 02:32:24 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ae24427asm8271315e9.6.2026.06.01.02.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:23 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:38 +0200
Subject: [PATCH v8 03/17] include: configs: am335x_evm: Enable vidconsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-3-2c33c98e7ce5@baylibre.com>
References: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
In-Reply-To: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 David Lechner <dlechner@baylibre.com>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=795; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JamhYeju5KMhfYyut+kFM1iQJRDwSL3iLX9TNaqcHj4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwIBnEV0TNVrcTvSyW6/Lzd7vFXc777WD6aI17H+E9
 n64+qC0o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACYiX8vwVyTwmZ9km2//k5pY
 laM5U1bdvtz0dE5tpr6eW3hZ4cH5+xkZ1t/dMX3ttkx5P+3NHh+5JLktVquu/dR7WPDTxb1KJ5s
 SGAE=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

Enable vidconsole for the am335x-evm board.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 include/configs/am335x_evm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/am335x_evm.h b/include/configs/am335x_evm.h
index d2164b41d6d6e74c7da0554b966ad5ee1f78e8b2..babf065bc3ea8c63f562ecfb07080f471b489fcb 100644
--- a/include/configs/am335x_evm.h
+++ b/include/configs/am335x_evm.h
@@ -83,6 +83,8 @@
 	"fdtfile=undefined\0" \
 	"finduuid=part uuid mmc 0:2 uuid\0" \
 	"console=ttyO0,115200n8\0" \
+	"stdout=serial,vidconsole\0" \
+	"stderr=serial,vidconsole\0" \
 	"partitions=" \
 		"uuid_disk=${uuid_gpt_disk};" \
 		"name=bootloader,start=384K,size=1792K," \

-- 
2.53.0

