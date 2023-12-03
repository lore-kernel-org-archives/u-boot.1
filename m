Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61D4C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 04:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E8AF87687;
	Sun,  3 Dec 2023 05:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bnn7hzI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB79F87736; Sun,  3 Dec 2023 05:47:33 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74EA48759F
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 05:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-58d3c5126e9so2195279eaf.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 20:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701578849; x=1702183649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7W3x8ixTWnYgBMWlHdwJiQcqwRWp1Y5gJ9SC58jjUg=;
 b=bnn7hzI1YK8CbLZjhHbLxWqdoIkmkJbNzlAPtbefiqymQk7uAKndVtfH/vYg88VFeY
 BX3NrGxolAGqz9ubyGbSuWmfAL4V5TyRt33a46xm4gaVhotBsjDUwtMjSsFJwY5bB81N
 1r+93JoqLbiEhjGArZ04NNSHFVZqlNstoKruU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701578849; x=1702183649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7W3x8ixTWnYgBMWlHdwJiQcqwRWp1Y5gJ9SC58jjUg=;
 b=PQGcRoNfpOPpXmD0i69pqIgGIs7vneu0mECwkAj67+S7JHcpm89a1qpt+THxxi7awm
 MrrLUf75NTkgLKkB3GcFH7LzXpJN7qeO+oHnBbS+ek2d8p9jwyTKj+QGlmO36fFQCncR
 0t5WKaFvYvkne+YSJsCP08LV+FQGvg7vq3etUHQLnfmOBpTB42zA15v2ovHODZAEpAno
 qcP2Cz6mhis3yRSpqT02w2ZM4/q6I71i4Wd5D0eeM1rx/hh5034DdO4XLVEsBSD9XT6x
 otQAcBZ3AoBtV/pfS/c3SOlBMULDA9UgEKqby8D5cQjKITePcdhmKvoicZwhpasOqu1W
 ZtTQ==
X-Gm-Message-State: AOJu0Yxb7uPy+PndGAgse7RE8JkIs369PitCNY66/Xvv2IJ0p7Sgb+pp
 5EFlzBy+wvg07l3MJA9VxD4docHJbMNGxGKn4hulOw==
X-Google-Smtp-Source: AGHT+IGmd+vA/5/6hZ/xJFnp5pdw6tZFjfkDFi18AnUqeRlFh/akMlYUI0L97eB/89NA0iCmYpqqfg==
X-Received: by 2002:a05:6870:6708:b0:1fb:75a:7794 with SMTP id
 gb8-20020a056870670800b001fb075a7794mr2467552oab.69.1701578848460; 
 Sat, 02 Dec 2023 20:47:28 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 5-20020a17090a018500b00283991e2b8esm6023919pjc.57.2023.12.02.20.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 20:47:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-gitdm PATCH 2/2] Add some more employers
Date: Sat,  2 Dec 2023 21:46:58 -0700
Message-ID: <20231203044719.667116-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231203044719.667116-1-sjg@chromium.org>
References: <20231203044719.667116-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This looks at the top unknowns:

   git log --pretty=%ae v2023.01.. |sed 's/.*@//' |sort |uniq -c |
      sort -nr |
   (while read count email; do
       if ! grep -q $email u-boot-config/domain-map; then
          echo "$count $email";
       fi; done )

It reduces the (Unknown) count from a third to a fifth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 u-boot-config/domain-map | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/u-boot-config/domain-map b/u-boot-config/domain-map
index 63cb60f..27f1a7e 100644
--- a/u-boot-config/domain-map
+++ b/u-boot-config/domain-map
@@ -18,6 +18,7 @@ amd.com			AMD
 anagramm.de		Anagramm GmbH
 analog.com		Analog Devices
 android.com		Google LLC
+andestech.com		Andes Technology
 arastra.com		Arastra Inc
 areca.com.tw		Areca
 argos-messtechnik.de	Argos Meßtechnik GmbH
@@ -44,6 +45,7 @@ bluewatersys.com	Bluewater Systems
 boeing.com		Boeing
 bootlin.com		Bootlin
 boundarydevices.com	Boundary Devices
+bp.renesas.com		Renesas Electronics Corporation
 broadcom.com		Broadcom
 brontes3d.com		Brontes Technologies
 bt.com			BT Group
@@ -51,6 +53,7 @@ bull.net		Bull SAS
 bus-elektronik.de	BuS Elektronik
 calxeda.com		Calxeda
 cam.ac.uk		University of Cambridge
+canonical.com		Canonical Ltd.
 ccur.com		Concurrent Computer Corporation
 cdi.cz			CDI.CZ
 celestrius.com		Celestrius
@@ -58,6 +61,7 @@ celunite.com		Azingo
 centtech.com		Centaur Technology
 cesa.opbu.xerox.com	Xerox
 chelsio.com		Chelsio
+chromium.org		Google LLC
 cideas.com		Custom IDEAS
 cisco.com		Cisco
 citi.umich.edu		Univ. of Michigan CITI
@@ -78,6 +82,7 @@ cosmosbay.com		Cosmosbay Vectis
 cozybit.com		cozybit
 cray.com		Cray
 cse-semaphore.com	CSE Semaphore, Inc.
+csgroup.eu		CS Group
 csr.com			CSR
 cyberguard.com		Secure Computing
 cybernetics.com		Cybernetics
@@ -89,11 +94,13 @@ dell.com		Dell
 denx.de			DENX Software Engineering
 devicescape.com		Devicescape
 digi.com		Digi International
+dimonoff.com		Dimonoff inc.
 doredevelopment.dk	Dore Development
 dti2.net		DTI2 - Desarrollo de la tecnologia de las comunicaciones
 e-coninfotech.com	e-con Infotech
 ecitele.com		ECI Telecom
 edesix.com		Edesix Ltd
+edgeble.ai		Edgeble AI
 einstruction.com	eInstruction
 eke.fi			EKE-Electronics
 elandigitalsystems.com	Elan Digital Systems
@@ -119,10 +126,13 @@ feig.de			Feig Electronic
 fixstars.com		Fixstars Technologies
 free-electrons.com	Bootlin
 freescale.com		NXP
+foss.st.com		ST Microelectronics
+foundries.io		Foundries.io
 fujitsu.com		Fujitsu
 gaisler.com		Gaisler Research
 ganssloser.com		Ingenieurbuero Ganssloser
 garzik.org		Red Hat
+gateworks.com		Gateworks Corporation
 gdsys.cc		Guntermann & Drunck
 gdsys.de		Guntermann & Drunck
 ge.com			General Electric
@@ -140,6 +150,7 @@ hevs.ch			HES-SO Valais Wallis
 highpoint-tech.com	HighPoint Technologies
 hitachi.co.jp		Hitachi
 hitachi.com		Hitachi
+hitachienergy.com	Hitachi
 hitachisoft.jp		Hitachi
 hp.com			HP
 huawei.com		Huawei Technologies
@@ -164,10 +175,13 @@ jmicron.com		jmicron.com
 jp.fujitsu.com		Fujitsu
 juniper.net		Juniper Networks
 katalix.com		Katalix Systems
+kernel-space.org	kernelspace
 keymile.com		Keymile
 keyspan.com		InnoSys
+kwiboo.se		Kwiboo
 kiethp.com		Intel
 konsulko.com		Konsulko Group
+kontron.de		Kontron
 labxtechnologies.com	Lab X Technologies
 laptop.org		OLPC
 laurelnetworks.com	ECI Telecom
@@ -176,9 +190,11 @@ linaro.org		Linaro
 linutronix.de		linutronix
 linux-foundation.org	Linux Foundation
 linuxant.com		Linuxant
+linux.microsoft.com	Microsoft Corporation
 linx.net		London Internet Exchange
 lippert-at.de		LiPPERT Embedded Computers GmbH
 lippertembedded.de	LiPPERT Embedded Computers GmbH
+lionizers.com		Lionizers
 llnl.gov		Lawrence Livermore National Laboratory
 lnxi.com		Linux Networx
 logitech.com		Logitech
@@ -194,10 +210,14 @@ mandriva.com.br		Mandriva
 marvell.com		Marvell
 matrix-vision.de	Matrix Vision
 mediamatech.com		Mediama Technologies
+mediatek.com		MediaTek Inc.
 mellanox.co.il		Mellanox
 melware.de		Cytronics & Melware
+metanate.com		Metanate Ltd.
 mev.co.uk		MEV Limited
+microchip.com		Microchip Technology Inc.
 microgate.com		MicroGate Systems
+microsoft.com		Microsoft Corporation
 mimc.co.uk		Mercury IMC Ltd.
 mips.com		MIPS
 miraclelinux.com	Miracle Linux
@@ -269,6 +289,7 @@ phytec.de		Phytec
 pikatech.com		PIKA Technologies
 pikron.com		PiKRON s.r.o
 pmc-sierra.com		PMC-Sierra
+prevas.dk		Prevas
 prodrive.nl		Prodrive
 profusion.mobi		ProFUSION
 promise.com		Promise Technology
@@ -278,6 +299,7 @@ psyent.com		Psyent
 pwav.com		Powerwave Technologies
 qlogic.com		QLogic
 qumranet.com		Qumranet
+radxa.com		Radxa
 rdc.com.tw		RDC Semiconductor
 realtek.com.tw		Realtek
 reccoware.de		Reccoware Systems
@@ -299,7 +321,9 @@ samsung.com		Samsung
 sanpeople.com		SANPeople
 sanyo.co.in		Sanyo LSI Technology India
 savantav.com		Savant Systems
+sberdevices.ru		Sber Devices
 scram.de		scram! e.V.
+seco.com		SECO S.p.A.
 secretlab.ca		Secretlab
 securecomputing.com	Secure Computing
 semihalf.com		Semihalf Embedded Systems
@@ -323,6 +347,7 @@ southpole.se		South Pole AB
 spidernet.net		SpiderNet Services
 st.com			ST Microelectronics
 starentnetworks.com	Starent Networks
+starfivetech.com	Shanghai Saifang Technology Co., Ltd.
 steeleye.com		SteelEye
 stericsson.com		ST-Ericsson
 stlinux.com		ST Microelectronics
@@ -343,10 +368,13 @@ telargo.com		Telargo
 teleca.com		Teleca
 tensilica.com		Tensilica
 terascala.com		Terascala
+theobroma-systems.com	Theobroma Systems Design und
 thinktube.com		Thinktube
+thorsis.com		Thorsis Technologies GmbH
 thot-soft.com		Thot-Soft 2002
 ti.com			Texas Instruments
 til-technologies.fr	TIL Technologies
+tinylab.org		Taixiao Technology
 tls.msk.ru		Telecom-Service
 toptica.com		TOPTICA Photonics
 toradex.com		Toradex
@@ -359,6 +387,7 @@ tqs.de			TQ Systems
 transitive.com		Transitive
 transmode.com		Transmode Systems
 transmode.se		Transmode Systems
+traverse.com.au		Traverse Technologies
 tresys.com		Tresys
 trinnov.com		Trinnov Audio
 tripeaks.co.jp		Tripeaks
@@ -536,3 +565,12 @@ sjg@chromium.org		Google LLC
 
 # Louis Yung-Chieh Lo <yjlou@chromium.org>
 # yjlou@google.com		Google LLC
+
+# Rob Herring
+robh@kernel.org			ARM
+
+# Masahiro Yamada
+masahiroy@kernel.org		Canonical
+
+# Marek Vasut
+marek.vasut+renesas@mailbox.org	Renesas Electronics Corporation
-- 
2.43.0.rc2.451.g8631bc7472-goog

