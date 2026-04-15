Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF42F43857
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5AD8422D;
	Wed, 15 Apr 2026 18:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="X0vLzoyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A468421D; Wed, 15 Apr 2026 18:03:57 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2E6C84228
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso107730185e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269032; x=1776873832;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uOlP9ehqKD0nJx09UK1ubBUZO9S/PHd9NFMrxofHz2E=;
 b=X0vLzoycQHX8LqOxCcFEznwZdt8rthErb/V0yyco/bL+jGg/VzZ6hHoPDn4Jw+H8Q4
 0cWMbsb/fzv+hJd3EJs71JPtQ3qybQuN3q3oJj218pKKkd/Jp8+BBgd6ErjDQbZAcWzD
 254EbhSa+FZajF+Gx5odRdl1KqLR8vcroUKSuU/Mr7Ui3D8TSS5SEHy+SncOdHBAhQBZ
 gLm/K4LuRzbUcKA+wubRE/lX+2Viui0rZqwhBMW0HB0/Oz1zf8UYqNxw1m8rVLegcLAD
 v5imfU5LxwJwaKeqR2tlcebEfZb4KVnUNYt1GuhR2T3mgRCYhzcBkYIw2siysQyYZz6k
 /IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269032; x=1776873832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uOlP9ehqKD0nJx09UK1ubBUZO9S/PHd9NFMrxofHz2E=;
 b=VOd7FV189Dza1g//M1TSoW/HEMFRCpiOpFgj5bCV56zOBSe29/azRGq3NjrHZZz+te
 7blLNrJrN5AgTw8dMiflmYe11g4r23fyesJd9dQbKRuYT1znssyQLWSieHQxMjDEXnCU
 qZqjQorS/cBA8YXBBe6EF1DkUx8RhOYRI/xAGBPn0EyxeBwmfwCerKBp0MbzyIiYfas3
 kryQACAR84LeztGmOpI5ODCaDoiZU0ddLkWc40Civ3R5OGmMFz+B3PXvz2SqpwTLiv52
 3ax4kBLruTTi3n+9ayyTEGPySB2o7eyUBIxCW0YWGp4oPK9FCuRwLNBlAlcifi9/+2GB
 F/oA==
X-Gm-Message-State: AOJu0Yxt4++APMcpOAtbU15nAei/RLabIHeTtpLZO8JDWwx4pS51zoUt
 Fi556po7HdjDaqGYek306Dk+alpvgsKNU1JL2P/xTsqP08n01GKocPWCgNf3gZXUqts=
X-Gm-Gg: AeBDietjeebAGsLg0hn8SBZRws1I2sbxyL5+GKveUvCgGdnXEXq+ob9SNRDw2Z0OzNR
 c9L86JpPBFwflrKf9JsRI7HhGE8NagYdKCDX25DgipHxglu3k4UEm2wvFCiSlcdiiiBmudPEvsO
 qdRCL2VBV8rr6AQ35KX7n65lfmbYS4UWTyhqKmUOe7JEDFUvMYAm7Y7+4X6MyW+4R6ePsvry3qB
 i6fuvhLwnnW/wCzoDHuRFzS7zd798Pm0MHeWaI/x+ScYs/9C5YXZofEw47O9AsiTzwjyzIgeZps
 fp8Rn31JQk4JYDfoqBecNDIBDS+qnjQ/I/ER3F8h44qP609ZlP7FwVaUpnMhFgoHbsBTE85JTEY
 grEqZnk6p809YsN70fMLWHdpGEnOUjG+KRDCnX/Ki+ZINQJ7s3qBPk3vsJt7sIQrRZxDskigbfU
 TnC0ftbrT8XddPNwSCwcXIKQxYyAAOIa0=
X-Received: by 2002:a05:600c:a411:b0:488:af48:af11 with SMTP id
 5b1f17b1804b1-488d67c749emr249822985e9.1.1776269031993; 
 Wed, 15 Apr 2026 09:03:51 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3ebaaasm5930994f8f.32.2026.04.15.09.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:03:51 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:24 +0200
Subject: [PATCH v6 03/14] include: configs: am335x_evm: Enable vidconsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-3-94cde349bb01@baylibre.com>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
In-Reply-To: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
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
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=795; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JamhYeju5KMhfYyut+kFM1iQJRDwSL3iLX9TNaqcHj4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz72xY7Pp6kc/r7YZ7YZo4tqROjmb3ehoSkbJyj1PbPe
 GrVQaWPHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRNEVGhveXfiue85R9Jfq4
 zyA/Q1nwWHn39q2LfqT1JHu1ark//c7IMKfnoFXlARnDXRcq32een3xcofzQOtPHMnLB3qqaMhf
 iWAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

