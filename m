Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C814CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C485B849AE;
	Mon,  1 Jun 2026 14:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="eMv+R6SY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AA8A84852; Mon,  1 Jun 2026 11:32:43 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B0CB84857
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4904fd4f6aeso83095115e9.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306360; x=1780911160; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MBez1MFukg2yJe7WLQXixUw1nuD0EpshV1o3V5spfhk=;
 b=eMv+R6SYsqFGlI0i4RP+r3GXTUfzxdJ0mYh4T8XTwsZiUGgzyO6wpSVzvEIQNQ5z8R
 X3EvdkxGMDJDej4K1OuCuHtPaMwsfyTOM5kHt/WKUuS8MvRi96AaMruFeCVcpQk6ryQz
 ch5eKJKU/4ky/g7kJ+/qivALvKQGrHq9cmtQyJ6XKTmKJm6XLmXMYNeYRhVy9IZ5cgbT
 LS6HG0+t+/QH3H3hrQY6Gz2+5xtpn8E17aosK2rA4YWSbav6QsaoKLmuA5KB4xYdeMaj
 l5vXQMq1+vfs+64Qb1T0zBVph3b3OHUQCR88FTtv9/7AtZQNsoPLAEiWSvYbcq3I2RXo
 3wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306360; x=1780911160;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MBez1MFukg2yJe7WLQXixUw1nuD0EpshV1o3V5spfhk=;
 b=FwZ6b4snc+cc3zpyG28bf10VFVxbAgBSVbCMhtoJgl/bXVe+b/qatakumihfTUn8H5
 6Be5lOHlQezra99Y/6vrfrvXDP0hSpcsw7gRGfm1VEYbRazDVEC8fkj4hhYq1zLZ/jKQ
 lxNqQIkcSOqe4EWxysQV3c4NoiSf/pTMcPDCNvHWadnlY+lcS5PK4L/oOl/Kwvj0Ga79
 Pz8qgPDU/HnMwAocAFAutvzak/m86XkfN5EPtV3VNxUoxW+m57ZGOVoOBpQawkki7h1c
 OYjO2JXg0JfdQxT6cFbG94IRn9x5vjoLLI2YtHnGQXvAIvutp2GRjgSEFazl8F6QcbaP
 6V3g==
X-Gm-Message-State: AOJu0Yxx4G67qboSjR2jEknsJOyRzL6+z3ZLscTBImxJqnC099GcqQeo
 xAlKqfWMkNmfR7EoDVmnz5GBnSBoZin+/9Z9jutwP4emNvxOAivEpe8hy23QJ7+UeOg=
X-Gm-Gg: Acq92OEngtFDQHlalXQlEvw7dJx3AOr+OW4wi/1riMjWdQR9LRS4hVIRU3XqssCZWdN
 RDu16vXtaXlFgPwlajBfY7vmBjzXYA/4QChlU8aFcxTDZdSSdwun8/nRXPmK47pPZusVZdQi6Yy
 ULW7UVNH1QBv/I90y8jVEx4oTQpQrCbmtPVEpSDX+pV2PMe9SPCQfwApa52ENKHRSxsfII1Mee3
 AKrZJA2h4WgDN6E81Bv0NEzgUVbPfj7UxfjaNSaF+p6Zr9LrwTTq7bA/0CNL0owFfcUQeo9ZXrZ
 lipLv7K8+DvbGvc37QNLkTDa7GXGzB2iEEio8gZa+SAHKziFuGMwayrM6QbXvopSEflC0WRvg4H
 MXF/m4Mxxifi2F+qLYZ2is7jUl4zDnFdvzX7wPQnQ+WH8j9FQRrmf1d39TPiuOozqdWij0GxpuS
 ztzdMyp1dqn02nWqU8U55JfxpQZOu+p2s=
X-Received: by 2002:a05:600c:3b27:b0:488:7ff6:1f75 with SMTP id
 5b1f17b1804b1-490a293a0dbmr188571175e9.21.1780306360070; 
 Mon, 01 Jun 2026 02:32:40 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0b896csm172074795e9.1.2026.06.01.02.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:39 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:50 +0200
Subject: [PATCH v8 15/17] Makefile: Move dt_dir definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-15-2c33c98e7ce5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=msp@baylibre.com;
 h=from:subject:message-id; bh=2D608TWTfNA1e6Cn9woKQNTY4HHIqO+BjKpn9yDDGbc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwD57Zvv/J+T+XNm89PnTSy/3+r+JfpAS9Oz6y3/nJ
 O0ZzjOu6ChlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJXIxjZPh+3y45V2f+AvFP
 XPnqb787if5Q456RYfZgX2pjzOuXOREM/0uWe3WfEvgrKHWKs/zk1pjHYve2ZRxr5WXc6XHbYO4
 Rf2YA
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

dt_dir should be usable within architecture Makefiles. Move the
definition of dt_dir above the architecture include.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 Makefile | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index f07faada3d548c1d363d0945adcae180be61a40a..fe991baef1a35ab7be8b98da2110f5f908fd0eee 100644
--- a/Makefile
+++ b/Makefile
@@ -829,6 +829,21 @@ autoconf_is_old := $(shell find . -path ./$(KCONFIG_CONFIG) -newer \
 						include/config/auto.conf)
 ifeq ($(autoconf_is_old),)
 include $(srctree)/config.mk
+
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+ifeq ($(CONFIG_CPU_V8M),y)
+dt_dir := dts/upstream/src/arm64
+else
+ifeq ($(CONFIG_ARM64),y)
+dt_dir := dts/upstream/src/arm64
+else
+dt_dir := dts/upstream/src/$(ARCH)
+endif
+endif
+else
+dt_dir := arch/$(ARCH)/dts
+endif
+
 include $(srctree)/arch/$(ARCH)/Makefile
 endif
 endif
@@ -1445,20 +1460,6 @@ dt_binding_check: scripts_dtc
 quiet_cmd_copy = COPY    $@
       cmd_copy = cp $< $@
 
-ifeq ($(CONFIG_OF_UPSTREAM),y)
-ifeq ($(CONFIG_CPU_V8M),y)
-dt_dir := dts/upstream/src/arm64
-else
-ifeq ($(CONFIG_ARM64),y)
-dt_dir := dts/upstream/src/arm64
-else
-dt_dir := dts/upstream/src/$(ARCH)
-endif
-endif
-else
-dt_dir := arch/$(ARCH)/dts
-endif
-
 ifeq ($(CONFIG_MULTI_DTB_FIT),y)
 
 ifeq ($(CONFIG_MULTI_DTB_FIT_LZO),y)

-- 
2.53.0

