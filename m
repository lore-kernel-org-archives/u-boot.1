Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4360F43848
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC998423F;
	Wed, 15 Apr 2026 18:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="e9Yo1r7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F5E841D7; Wed, 15 Apr 2026 18:04:14 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FE3E84284
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b150559bso54957535e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269042; x=1776873842;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BGvjY5bueRWFe87EEbPdqN1luGiLep7h11nvjC3A5bo=;
 b=e9Yo1r7HowMVSbPW5F6+aPm8it4jwflF5J/LNEa2ANy8Le5zgQnwefzN805Utneswp
 z6UJlXfomn4qofv3u4p8/AoykFxPn1XoyLNCfglOLJK6qptGV9cpTAW6j94FXYORS6kw
 Kom5NWxqUbTp75CHQVySmZePHMo64IHi9pc2j4aFvbBPBexRWv1Afo5KFThV0JD2pZqT
 OBh6cdoWkEYvOY1+sLmO7hQceE/eeUk7xBE26fK/6cAWSCuFOJB4VEQ30n3hPz+jSvjr
 0DC5YmsoqyybRrjSsLhOx2SWnTitsdcsUlUiRluoUBo8olL2Ag2z2n1V09xZ9P1G5W8W
 jBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269042; x=1776873842;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BGvjY5bueRWFe87EEbPdqN1luGiLep7h11nvjC3A5bo=;
 b=tOYDl1He6qSWgA1YajuEfj1PFAtj40abU/xZTE+ASTz8U/FrYMaEheJI5ClBGgBPFj
 /h3CSzLj4rDvV+4Szqdkc9ocS4XuMNRQpHvlWujinfrwTBKwiyo5sopcu7tYF3yaiNKz
 9StrdeU/b/FTIdXlu/rkTb6Do6iy3bdOY4xkdf2qvcWgVtwsIWaD/f7e9UAox6lEnDAU
 0eOQAbvOXG56wq0pz0EGIfIWoTaeN2ceJR0fpVNdKzhTRsPsuY7QRBticZLcfTciusyl
 vxXl27kT4qeGXk9vyzs9naHD7KiEzrPoFSNY6fDoplPDW101z+oJClEpsvDKbk2fcEyn
 /xOQ==
X-Gm-Message-State: AOJu0YyT/S0uW7IEvaa3f9xGz9Ve0auMhudmXEM2h0osnXl8oHB1OiRS
 GNh9pRwccGz2/jrE1Vth55HIJF2IQFWBKD0XR1kcsSG6uWTYIHtXtq9CSwaSrgri82g=
X-Gm-Gg: AeBDieuCf0KJ3X5gs/fXyHd8DbOg+4XT8GJd8Wf/ELMSt2ZYC6oPKFAmYFQWhIvisiW
 2j2A0YESNetXu/6WfGEx2AmGnepo5sNeUsBsAdIEs2J0KugJldzkGnD5u02i1KvE6/NPz12qt0H
 PW3m6g5q2buidmSYQ4yOufEWWGv8a4CYseA3jDfUq6OecdcVSJ/n60vPbpOUxo3vaDb+QATz8/A
 XA3NpVj4YcUjsXC4aAvEiZLA/m++JxhcV4euMCZv6dI9+RDRHYKymX5BG1Zc5T1T/o2wmBsNREX
 11X6m74MiZfoid2Ljf44hUsMLctfO6/8/+hUUz/KuCeSjhx+iQxxnnu01a21NDflW188tqndiHh
 xd6l+eY/g3AOL97QelcjS4p6Xo+Tcltrc5tdFtP/AYYbl4pipzoZZSBpHv+YB+F43D90/ww06wf
 xjZNStDxXL0s+AexPAPP8O39Ofzfonlzc=
X-Received: by 2002:a05:600c:8706:b0:488:a62d:76d7 with SMTP id
 5b1f17b1804b1-488d67df53cmr317005575e9.1.1776269042539; 
 Wed, 15 Apr 2026 09:04:02 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0edb8absm22177755e9.36.2026.04.15.09.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:04:02 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:32 +0200
Subject: [PATCH v6 11/14] dm: core: Split SIMPLE_PM_BUS into phases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-11-94cde349bb01@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=msp@baylibre.com;
 h=from:subject:message-id; bh=yIC/PnqeCukJoGHoOJN/W/60X6V3ZptA09NrmFlGGXM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz7207ZTb+S+tvG9zLvu1mVJd3zDq3+eWbaxaYfrGmrJ
 aMeaLnId5SyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBERP4z/OH/tzFWTYV3gVbb
 7FrjF94hreXst9SaOq6svhwS9EOt/g3Df/dPFZudtnrwCjufW6S2W/YSy8n+7o1ckifM1G8GBLm
 zMAMA
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

Similar to SIMPLE_BUS, create a SPL_SIMPLE_PM_BUS additional to the
SIMPLE_PM_BUS. Most boards will not need SIMPLE_PM_BUS in SPL.

This is currently needed to reduce the SPL size for beagle bone black
with OF_UPSTREAM enabled.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/core/Kconfig  | 8 ++++++++
 drivers/core/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 5419bf65b5d653464f8bf958382ede30954d6402..0471e2977d0a993afcafee11874d43016d6738b4 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -342,6 +342,14 @@ config SIMPLE_PM_BUS
 	  Supports the 'simple-pm-bus' driver, which is used for busses that
 	  have power domains and/or clocks which need to be enabled before use.
 
+config SPL_SIMPLE_PM_BUS
+	bool "Support simple-pm-bus driver in SPL"
+	depends on SPL_DM && SPL_OF_CONTROL && SPL_CLK && SPL_POWER_DOMAIN
+	help
+	  Supports the 'simple-pm-bus' driver, which is used for busses that
+	  have power domains and/or clocks which need to be enabled before use,
+	  in SPL.
+
 config OF_TRANSLATE
 	bool "Translate addresses using fdt_translate_address"
 	depends on DM && OF_CONTROL
diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index a549890c22b997a8c3e7cd6ab08b2ed2ac7994b2..1073c26b2ed0009e15ccca0bac93a64d882f0df9 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_$(PHASE_)ACPIGEN) += acpi.o
 obj-$(CONFIG_$(PHASE_)DEVRES) += devres.o
 obj-$(CONFIG_$(PHASE_)DM_DEVICE_REMOVE)	+= device-remove.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_BUS)	+= simple-bus.o
-obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
+obj-$(CONFIG_$(PHASE_)SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_DM)	+= dump.o
 obj-$(CONFIG_$(PHASE_)REGMAP)	+= regmap.o
 obj-$(CONFIG_$(PHASE_)SYSCON)	+= syscon-uclass.o

-- 
2.53.0

