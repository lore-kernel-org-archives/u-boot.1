Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10A4F43857
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB279842CD;
	Wed, 15 Apr 2026 18:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="toO088WR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4680684228; Wed, 15 Apr 2026 18:04:11 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FCB28426C
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ad135063so68702305e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269042; x=1776873842;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M0AVVRgwMXO8ZVImV59tKU5ASeTJzbt6wSQg/q02AyI=;
 b=toO088WRUfcKm4Nu8zmGlQawCcEvGVT74u8S9xwRALU8lo5FgyhTSTFIQfyHohgmQe
 ffbIJZXWcm1Bghlq8aI6kVAP0JP4GXePef/oTUvdLjsI7ltWdeo6m7aTR7pGbK3c+iw5
 z6zrOs9Ac77YsJWXS74TAfRr4EqJWyarUgADvsLEPIstHJTQqRiK74HHsnSBpYgHrSfC
 eFW1TznOpLecYeyLd0cO6dRFJ/Jbo7cm2Q6kP4XS03dG7jKJURtEs7yccqL6Bc35lC4e
 DkaHYq45eCAiAGGl80mJYMaP9Fv2Tlp+ai7V6odbQRVbAdMztK5eyutbpbz5aD8NG8JE
 4otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269042; x=1776873842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M0AVVRgwMXO8ZVImV59tKU5ASeTJzbt6wSQg/q02AyI=;
 b=iOMLtQKPtMl71GZEzUhoOBzwqyWO+CutUc4ZY9z5ldIR1Y5TCc2FBL7nQQGWihl9ft
 KvM7xW0NFppaSr6qhtsDjPjWvYDHjIwuwmoIJYvHO8PNyGlYkdlKXh2tvM6+jJw/DCbI
 hSzoma22meeGhdXGNXTJjvpY9sffIkAOmv7zcT/CO28aF2uzqRE+TuPN50f4Jba/BbIO
 +s1siZINVgWVgtimXQF29FtkSe4DqNw/bPK1aqS2P2ztImwD1I1SMIi+R6pVgHGFLxBr
 PjtRn+wbT6h+52CQNj+lJi8kPBFlwRkMyITYoP1XoJfCz/cfibyyutZ49gpTpchHsMpl
 dJOw==
X-Gm-Message-State: AOJu0YwHN0nEatt8+1RWLkDkotyq2E8rr26dAXnCPLAT5Gb6vCh3wodO
 dUeDb6A2yefXk57416yEDVua1/Y30JTZoFg6HvGEG+lSnHs6E35aRuqKokJs4AqyA08=
X-Gm-Gg: AeBDieuzoNx2WLPPD7zJyh03EyvycRfojqVBkxw6TpgSet52JOBQa3HnVkF22ii6wYH
 Lm5mfrnkJYUWcDcY6AGMGsa8Z5eqxbZg5EhPXMijSZVobyYgSQ6HOB0M7QXl5CONezsLr2ZY7oz
 8Uo2spaexLqv8zeuGdSJ5I9l5l2PMKDC1/xzXgWygx1n4XW9jwv29Hz6LxR1rnc2Mu0p1Pe76pq
 4ejD81fhJA/l9CePM27K/UFnMktdDHOyfXCrm3FqD5xXY8UqdyPXP8lAGd7iJmb3qmYIxTRH7d0
 DA0btjWORjzj/EbnrJc2nlIxoMAHjMuIhNEfwjTLU8pSJclSm/ssci/8gcv88Qf+oFVLln/Kulg
 OWbYW1JoOpHj+0+NVWPKM2ThExd/PQCN2do6V7O/vh85/g420gXbqA024NmPmcZRz0pmf0sVoSs
 c53E2pBM8M2YD4vcTYXrbP6f4QD56DDkc=
X-Received: by 2002:a05:600c:19cf:b0:485:4453:401d with SMTP id
 5b1f17b1804b1-488d67ebc79mr290488045e9.2.1776269038569; 
 Wed, 15 Apr 2026 09:03:58 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f253647fsm93670325e9.1.2026.04.15.09.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:03:58 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:29 +0200
Subject: [PATCH v6 08/14] arm: dts: am335x-boneblack-u-boot: Add lcdc to
 all boot phases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-8-94cde349bb01@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=741; i=msp@baylibre.com;
 h=from:subject:message-id; bh=qvek2SMvCpKdU83XcTliAlVyZ+xVpBwz/HfiBZIZ24Q=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz72/ZMyzAxWebYlVV8y/jAv7/uVdLpSqqHzkprrv/Uf
 W7/+kLBjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjI/AxGhqnt3+6HR5T2dNbW
 KO+Xecks53j2ZFX57d3yx9y0AqpqUhn+8Lye/6p7yuqXbXx73Y1m7TpQ/eJN09wUcVaWKTv0O+r
 O8AIA
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

