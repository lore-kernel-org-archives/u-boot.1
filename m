Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ADCFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2FF584137;
	Mon, 27 Apr 2026 14:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="X+/4uAeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FFF84150; Mon, 27 Apr 2026 11:03:31 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C0EC83693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso83387025e9.2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280606; x=1777885406;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M0AVVRgwMXO8ZVImV59tKU5ASeTJzbt6wSQg/q02AyI=;
 b=X+/4uAeX3pVtUnhS5NOL7y0TzDTlO+tQW9N9LU/qhKG3rcWGjlX1PFJINO+pk7g6wr
 nmIobV/eTG9xHY1LcDBrecnAB+1wY1TAYtC4h2j0FhbKndrgGlmSSnet9GJkl/VBRit+
 uBkpMkK17Ps0Ru9RzyApBRfNo/rlh0MeNyYqu7rYFabMoId7fpQjMfBwwODmbhIl0zrw
 Os61LMF1M7IeddqamzzM9UqFq2WhL1ZsvU5NBZKBL9ILCghWRfIvkLstsO914ue+XPtS
 jrzAXTS2EnaWy+GlkDZ1HL6ZIXI4MZNpD1uGn2ihNw6wiIZUzEDJjfMZIonzZxPUi4ll
 0YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280606; x=1777885406;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M0AVVRgwMXO8ZVImV59tKU5ASeTJzbt6wSQg/q02AyI=;
 b=UEHClQGbWomrPugDK/1iAMzFso4E3k+nEd3sBwfRq2Th+cbJ6YExC5vUOTDXrPq/gP
 wgJbMr8i+WTC2g+JMdNhlTlkCk2F6vLTwiiGFIcKimIIGFvjYi0q/gEpJ6Nmr19kT4Rx
 7bhZxs+DyhNJpzvx0O3k2ntIl6+umTVbKo9iEsdFhpYFb3sZ9igtXlN4ZIwgoeGrVusr
 bVPEiX3bfFBzfS2aVr37LQadSNfHzrK5j59AJByiAjsCYBoSHP9hP+Wn5xd/XEV3s5DV
 jzIdBt1SWs+1UNQauqQ2tf3CHFTNzv9enAUtS6ILghAnnViTlILb/1I6/cx+4BZb/Lz/
 C8pw==
X-Gm-Message-State: AOJu0YzzouDc2NlxxBwzKaZ8KoWtEtktu5NnprcYFoMwgKsjwls6Y6/7
 36WUPCmaju2Iwrs1fFoFJT6ZiLaSeCOWRf4lx0shAvmCsMVGEBxVdSaUxKoMj28bqt4=
X-Gm-Gg: AeBDietB7enQDi8rMwiFcyUmuLiREmSOSlxrN8D2Na4mB/eVnPqpYUpzc1Nba/cQlJ1
 Wp7m3nzxN12uVaHm0cD9SzRb5heBvFljGGlvCLumvegdRWbeRNpdgnCGKgZiTdOEFz3RCaWhLR9
 D2OTAu8OyYDCN91EpVULQkB14qn8bLuDjVxOKm/d0FpqFLK1xIe1YSLIwQMRSRw+x3NWoy+i9wC
 sM1gX+R1JM4tXLXjm9Zr6VcXoKx3Qgbno+LO+i5E8prSmEULqD54JLlP8txFTsirtX6PhJ764hA
 u0ZeBd7f+Z9HrZ/6yyj9LIsAJtw9zNnWZyf29h2+oOAfiS7FxJ0Wi9MqZ2fdF7lUqEYNh4LSsLe
 Dyd+bdVjuLLImExLgNMMEcU/MzpQEslplHzxGXdSRxtB6PsiEueJPljtOYvFkOUTwpxNt2QeapI
 /2/wCPOjT2q7GC3NBwETIre/ZfINJzlwY=
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id
 5b1f17b1804b1-488fb73d764mr573668375e9.1.1777280605591; 
 Mon, 27 Apr 2026 02:03:25 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a575ad67asm393929325e9.2.2026.04.27.02.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:25 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:24 +0200
Subject: [PATCH v7 08/14] arm: dts: am335x-boneblack-u-boot: Add lcdc to
 all boot phases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-8-7e6cd1a805a1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=741; i=msp@baylibre.com;
 h=from:subject:message-id; bh=qvek2SMvCpKdU83XcTliAlVyZ+xVpBwz/HfiBZIZ24Q=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3akaVj5utNOarunX5cN3m3yX88ujOFv9lzzR/tJzfq
 VdSEcDbUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABP5mszwP1V9cpjxoiLHuYIt
 Mouk7dW15J8np6qvbirhsXvuuWURE8P/kp67X/TNg6ffyb1qfba9/CNX93vru1cPr5DxcNXNtZz
 AAgA=
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

This is required for am335x to boot correctly.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am335x-boneblack-u-boot.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/dts/am335x-boneblack-u-boot.dtsi b/arch/arm/dts/am335x-boneblack-u-boot.dtsi
index e2afc77d9edc539323c73dee03511a9cd62d8ca8..366375bf446c4c49a12d210c1a24f1db2881f1c3 100644
--- a/arch/arm/dts/am335x-boneblack-u-boot.dtsi
+++ b/arch/arm/dts/am335x-boneblack-u-boot.dtsi
@@ -4,3 +4,14 @@
  */
 
 #include "am335x-bone-common-u-boot.dtsi"
+
+&l4_per {
+	segment@300000 {
+		target-module@e000 {
+			bootph-all;
+			lcdc: lcdc@0 {
+				bootph-all;
+			};
+		};
+	};
+};

-- 
2.53.0

