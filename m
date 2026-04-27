Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0523FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E068841DF;
	Mon, 27 Apr 2026 14:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Tm9o8T3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E47883C14; Mon, 27 Apr 2026 11:03:25 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE398416F
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-38df1889fb9so95333031fa.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280599; x=1777885399;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uOlP9ehqKD0nJx09UK1ubBUZO9S/PHd9NFMrxofHz2E=;
 b=Tm9o8T3FKBb6QG0ozTjakxEWs5JRaI2pqKG+H4VC8OVDI70pLGUPeQ/lGEeHXbBay9
 ZahQgWiTIMLgElUte7Yni8sTjzUi9S4DT3mi8OSQZqJJtugcIYzbgoeOwqrUyuNIuhGb
 6P98hZdVoVvdAbbg2zfWHD1znApky/uMOQlkPAf2bRDxu2+7+jn3R6EF53eyqblT6+vt
 fYzEyPr6+iH+HEhPfUf74zUbALQYWpIIvZBSVnnaGDJ0A3c5+qxjXTZrLoJG9MkAsEoV
 ZXYE3g7VvG9f4Q3NrDFPepQJx9i16LAd2CCODrpR6EhtM4kOszUQ00W+FnNAG2mCBl7o
 v8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280599; x=1777885399;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uOlP9ehqKD0nJx09UK1ubBUZO9S/PHd9NFMrxofHz2E=;
 b=pRSKnSwH5/gu7iw/psvLJ9ofwfnEkdv8so0hyRHdk7H759i7o1l3CQJ1ZPGsx/DoPa
 EJlGynmmxMhOcuIvjPouQR/2BmTSJXURYrzz6bImizX8EEET2sgIt8oPPZzjkR1zlSxj
 4TC0iemDzmNFSVf3Ej10/i9cXr4P2QDZnmnyswYCuwL1E8L6g/kiweTSe/bg/h3ljoEA
 ZPxPaNWYemqvoXlDuok26MMPd+JB7t9ksEVIa71/mp54csjbSXU0ifiDPiCZJFRegvbO
 ghsaODnClmKr83BDr90kEukirhT6yGkNdBecdQT4VGNQ6VDg+QrAw1ALCgLktrOpPU5d
 8khQ==
X-Gm-Message-State: AOJu0Ywzki6fwrLo78Ul0kkhnOIRRBjTmq1dH3X6zCWS4zJ88nddPD3s
 f6JxRWSHF1Jmd4JQevEmpLmGAjjzVvDJ2lzO6IzhvGGiS3MU+7jaybkU2SyXpJ7kIFo=
X-Gm-Gg: AeBDieu8LUFJrXvDbYH5/wGIaIS5tMIHtgiNHWKugG+L6EGdIMNXjpYPG36Uv+3odXp
 ieflfdGl+BcHjjKD33DndUev6R67DOgWk5mppUMUZ7TBKUwpxf36tBGPLOW8zCCPQNrLkYBtLNd
 4aQm63COVYVtiQExvaOR5LT+D/+12TuiVC67ZNfR6uQpdHR0dpnRmlFl8X3VUo8eF8WOiw3rGQc
 VTtFHxzLn9gDckpq3iWRclGVbLumzl6tmtMLGw/d7inrhuwh81chMIdzyF3fRt6KiXQ//bbpaxl
 grEX3yq500ruA/POaVAL6J0CX9XqZgLYa14ZLb/FzAQnmYASExIp+pS4izBA7+8ECgi2yQ5VtQv
 eeuUX/oHXtvYp8tVUOZXPHykPjYfl6SjTTA0TOSXL8mlxjezpmcp/3Qw3VGgrv29b1//WeEDsot
 OcQNLKTo2ya008XTLgMNnuto5eRyA5IoY=
X-Received: by 2002:a05:651c:418d:b0:38e:a883:6303 with SMTP id
 38308e7fff4ca-38ec7818f33mr107781651fa.9.1777280599457; 
 Mon, 27 Apr 2026 02:03:19 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4c221cdsm80450838f8f.0.2026.04.27.02.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:18 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:19 +0200
Subject: [PATCH v7 03/14] include: configs: am335x_evm: Enable vidconsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-3-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
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
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=795; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JamhYeju5KMhfYyut+kFM1iQJRDwSL3iLX9TNaqcHj4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3alKr3yzY8+HcqzfJd+MzRUQWy0S4F0keOr6hW7zx+
 AXZEJYLHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRV0yMDMcKWpamz/3/z/vk
 zDd9H40Zzf/ZTohVdV77t++ly5ojs7cxMlxhyrLzneJ92Ul5iaxzBc+2+RefMNQmJV7itvu7e/m
 hOl4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 27 Apr 2026 14:54:41 +0200
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

