Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F03CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E0F5849F3;
	Mon,  1 Jun 2026 14:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="d/jO+LTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B54C384857; Mon,  1 Jun 2026 11:32:33 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42B584851
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490a765d410so13403865e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306351; x=1780911151; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M0AVVRgwMXO8ZVImV59tKU5ASeTJzbt6wSQg/q02AyI=;
 b=d/jO+LThMz8St2NWd+mbgJpWJEBo3FtMMimufqTi/oLiK2X5vq1QWJ2PRCqBCIufDk
 7Wk2zzYvkmN86ARmd55xNleVHub8tLCnL/of9b7qrLfSYEkXD0nZUk+yG0vyCMNDxjJx
 Ig7FUgZL1McK0ciotdiq/SFOlUsyOO7YsW5QuxxvJ/oIfANZlF+kdxlwZJsQQ8Ef+OzK
 0cL0X9TQIPYPhyNnI9Z7f4jzrD19B+4KFMUkC747C40Ro1wc4ZRcD5/UPacakrxFavCQ
 42DGY4X2Pw/cnGA8qq1KTmf03E2XVGJjBAL7tQn01lKH59wAhIBV6QInViWmtC6ZdCXM
 PteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306351; x=1780911151;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M0AVVRgwMXO8ZVImV59tKU5ASeTJzbt6wSQg/q02AyI=;
 b=dWv5oMIhUEC29cHy7TUvtYafMMa2ugQZPPQcyaY7FdUA1iDJ3duU+aq7wHMrOcCQxR
 j2VSSBz6anwAnWTZKYaAewcmr4OMn7gspzI7oexAYso0o8da11bTnzASceJMNzV5tRYL
 yDYEYA1EsvHh3V6hgdKuor4XH+qLZ1RlNLt7/66t9Gj6PvSG0DCgs82OofEl3J28BX8A
 G8TRItZFOR1E4OiuY1ni2TL7MELW72CJZLKgkR9AxreOlVMLVDm35W1jtp2TQhpYDRtU
 UWdkicMrysS7kQ3EHGRo0uIZfueHKkEZZOgJErNmQSYcRdfNTOvCnJn1P5I9339/noiY
 6Wxg==
X-Gm-Message-State: AOJu0YwFixmz1324ZMYlkc8+KG+ew70jilfxD8iTwb4lRjYzcsW6YvqM
 9Q27fpuMd0nWrPytl/MYfsPa1ECKj0PCRKW2Nky9OhRZomwKs87wXPLfVncsHn73uyM=
X-Gm-Gg: Acq92OG1Pl6gnwEnGQg4f9Vdy+7Xbc9F+m3LhlEDH6PljybchfRrr2x9dqx45N6p/gu
 BHVxQve+l8KVQ7dYynLUg7lfUR1N3FB2xLozkjRczeMTzkOoQPJ5pxOKcIHWDVRBjFNNJ/Xou+0
 p/Bl6pfBdzIs7coW0ifEP2dx7BluddbrPbRRdJjJzTU63e6wdqCoMrjsZ5p3jbTh2tOx20JRlJA
 duIqoIPhag1NDk938pcSmtg1D7sV7ffVs+18UbE2TpF6Kc/pLym3KmEnSsoAf+K3q+euZ3VUCUS
 NaLGLE//AowAULTFYGGPTRmtAV6CRREaYvbxd30wHVGIgxTRX5Ij4zMaITumgeHxXY7rmJir542
 znxy7hgucm3NwtFEdl2dKBDSQYmqPXUFy+OtzMPl46Gswx42lrHtCejMCHYk8JHr5ESO93/1HgE
 6XwJP401VAg0jSoNQGgJWwWGZFLENjRfk=
X-Received: by 2002:a05:600c:818c:b0:490:81cb:d7a with SMTP id
 5b1f17b1804b1-490a297085emr193125645e9.29.1780306351373; 
 Mon, 01 Jun 2026 02:32:31 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d7002e8sm264082525e9.15.2026.06.01.02.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:31 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:43 +0200
Subject: [PATCH v8 08/17] arm: dts: am335x-boneblack-u-boot: Add lcdc to
 all boot phases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-8-2c33c98e7ce5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=741; i=msp@baylibre.com;
 h=from:subject:message-id; bh=qvek2SMvCpKdU83XcTliAlVyZ+xVpBwz/HfiBZIZ24Q=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwGzeu9dPPla7Fn1B81HJW5kT9+/f+nl57b+IAqHed
 Urz3+q/7ShlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJmBkyMry8M3nqlq/V++6I
 BrC4pr/ovSz6cUnR+fMbXu175GRz/WsRI8MPjj92l46EFZ+q33Zl+aZtTRMWPW9tmR2W9EN3Rd7
 NXV+4AA==
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

