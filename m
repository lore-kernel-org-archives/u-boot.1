Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0A0F43848
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 831418428C;
	Wed, 15 Apr 2026 18:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Q6JaJkQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54DDB8421D; Wed, 15 Apr 2026 18:04:10 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6122A84228
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0046078so68601155e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269044; x=1776873844;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E0VtBKCIlgO3aUJfn2YwLwh38A/2xJronLoNHR4waqk=;
 b=Q6JaJkQWQQlkSOskNXrGDrOHsyDs9Ugb9g9CrQ7i3KY/YFf8YvyUbj2j3PMy3wrX3w
 VGyFJelZDgWW7JxOX4gqYPlYPRqWGXaXjGS9qo97q5SrDZnyt5EGZizSqXVu8XY1EtSr
 x5q1aQEIiVlfL9Gdc8gc7bofgcsHLhroxpS6OaGxF0WwujBBmhuUFthYWIEMHvb6ZVrN
 3cJ2t1D7AJFGax3VyjNrmYT6FoJVmUUJs41cl12zB61sA20SwIjeQj2XwvxSiDleeLyT
 Vx/6kmeQTILzrKCew1wuIFfzqhxIfj6DXWTgNvrgRJLsrFNyHseAuhsEcSW5tHlEW64Z
 XSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269044; x=1776873844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E0VtBKCIlgO3aUJfn2YwLwh38A/2xJronLoNHR4waqk=;
 b=rvSfO/TEor7DmuLOotaJISxFI/63d4n/HnGXa2g7MtRy6xyFt8bO2L10lfSZUPibh/
 Otdsvkrpt9CJ95LL7woPjB2KoUWEFxN3otbaT0vyGo2wItTGBYVA1n1y2eHgWfKJG1Rb
 pICuSu3dgcN8gE2Cjz5qksboziJ5D9DncRWk2D+bi9IGeZ5BRpqOyy7caP5lLTIox12+
 Ch7n/WrgReWaZpQxWKonn1L/DCP7r0TglMtBoW04foWnpmnRPRYBQ0hWbtV9QaQTRiXp
 5B2MQ8LOylG6yYD2i6pb+0enR8vV+pbroCzzPPER544U1KoxNbVpA/HBP2/6H3aGGy9f
 Uedg==
X-Gm-Message-State: AOJu0Yz/6Rx3YSD6cKTXeHcvpZYSC+71DeWykDMR9iAx/Cg4EO6M5qIT
 Q/n9qOfzJbEGeNhK9jmscHktzXpoF5G2Bp2kKBgBpZ2ovRrNUjixrbIUM5KPRC3DJJs=
X-Gm-Gg: AeBDievnfRrvN99FQQvyOb5ebXCxa2FRS9KWDRNR5r5noTVqIdYYjF5lv5MtsQvoZTA
 Fk25vlIctIgrFvS6Q0qOBeHKw7Natfpt8lzgfiXo+DYC+t2MkqH/xsUaikRiHx8FHTNTkyz3cJO
 a45pkyEW1a/c2H95/+PgH9r+k/DNtIjGuNnHy9Zu+ZWFXTbXsMqAnMIjUgXaGvZkFSk9uRWx9UH
 bwsMLQgLvfEerHjxmA3iQnwDJSuAVIB39UMVHGk1ockisnVTHvsfwp0UYclRbEBAhAQ13EDxe37
 vDaDp9M9DbMnVhYN6hdq0ksiGkGOPK6J2/hrPczD4mZJW4S55472E/LkdaQiJMcmSI6lSe84QOI
 1BnQYJIyO0wYzRFgZ+Dwof7V4Qqds+N+34haF0aH7d8tq6mpOS54owKiKV6tbjmi0Et1qAv3xX1
 FwJMxV7EOgSmQR1CumqVDe6g7cNxg5VP8=
X-Received: by 2002:a05:600c:45c9:b0:488:bc6a:5285 with SMTP id
 5b1f17b1804b1-488d689d277mr304802255e9.30.1776269043700; 
 Wed, 15 Apr 2026 09:04:03 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f253647fsm93683335e9.1.2026.04.15.09.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:04:03 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:33 +0200
Subject: [PATCH v6 12/14] arm: dts: am335x-bonegreen-eco-u-boot: Add
 include of bone-common
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-12-94cde349bb01@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=msp@baylibre.com;
 h=from:subject:message-id; bh=TfGs/l63TjFqkSsB+r3gfyXG60dAKUO+gstJ03ZLUN4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz72y6k7eVd05qwxWzz20KDadPaTq6utZvI1n10lu3rA
 IGr9y8zdJSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBE7h1h+Gd0wWr/wjVvXnBe
 jN93RuzPw9zTJ1cZMW5dVq+UtmKvVK86w3+PGRMLt877fG7XtMkmrBoSk38LR+RdkdMueve/eq/
 6r1+sAA==
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

am335x-bonegreen-eco is the only bone that does not have a -u-boot.dtsi
file yet. The added include for am335x-bone-common-u-boot.dtsi adds the
needed tick-timer definition.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi b/arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..e348f84d9be9a858596d5f5e1a7127e7d8c1e7d3
--- /dev/null
+++ b/arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * am335x-bonegreen-eco U-Boot Additions
+ */
+
+#include "am335x-bone-common-u-boot.dtsi"

-- 
2.53.0

