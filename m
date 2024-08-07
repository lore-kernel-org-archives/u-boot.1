Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5408CC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0162E88BAD;
	Thu,  8 Aug 2024 00:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ln3Jr3h/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B61188B49; Thu,  8 Aug 2024 00:48:23 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2BC888F8
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39adbfafde5so1662675ab.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070899; x=1723675699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nv5/PYJ4jSC4iL/zCFQIHrjg7dIOcbabh0s2sjG/i+k=;
 b=Ln3Jr3h/4OGuBV2fKthuQzCxph3a8afUjB2PsmYRrmwF9V7cGsMquYwFaHJmTznCTT
 c2DGAq34dt+fIFsK+2xLMUr/hxP3A0a6jnlxdLXBicjEu40ga2jXO+//b+swLQrbOfdi
 B7Hril9xKo6TU/A533jqtVVfEUnd0V7wzGxEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070899; x=1723675699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nv5/PYJ4jSC4iL/zCFQIHrjg7dIOcbabh0s2sjG/i+k=;
 b=MnGKmM70N44mMGSkyiIIgmX5Vnf3DIsZTpxxuXEy834TrOpDPaimCqi2/UA1YzLwt/
 1Jt9vCV8J+ba8PnT+p8H5sZjLmjzqt3w8EDnfCHIi1G9GGJBlFPvCkzTUMhXMAeyp7qK
 G/0bxoreg2YImNAcO117++3w+n3VR8/F/lEZWFSbc65Z3jctJ7/MPORlF4EHr4PnA6Ga
 +GPsp7fqkjFqtAFOGR7Pmta1/8Xb6MuN+OgKHChL74UgqiDyMYJs6lDa4zAWUpIJqVsC
 umpm1lL2Hg/FvVPRb4NPIbDZa4Ux+oyXx0bCe7O0SMVaom8NcLnIwKu0S2Pc/QDYN2Cr
 RCLQ==
X-Gm-Message-State: AOJu0YxW4maWc3lhVEV1QHMEq4Q2wyvuiToBuXcuxYTwMIxTcj/Yn2Ai
 KUqEWQC+ngJ9PXLOO5CdAxQcvcoB3fBlWx85yv9lNO3wsKJCYYCEjIBvZiwMMVupUTjMAIWHra8
 =
X-Google-Smtp-Source: AGHT+IGIaqewBW/UNDG26rLGAsXP+Q/p77GoAjeHsl/bLeZEL2rhF+PN4/jYl2tH9govAlHxCedCAA==
X-Received: by 2002:a92:1948:0:b0:379:361e:5067 with SMTP id
 e9e14a558f8ab-39b5ed39942mr540685ab.25.1723070899326; 
 Wed, 07 Aug 2024 15:48:19 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 18/21] upl: Add initial documentation
Date: Wed,  7 Aug 2024 16:47:36 -0600
Message-Id: <20240807164736.v4.18.I7abd8fe6045ce8ed9eeb7b94c8441a451a72cd97@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
MIME-Version: 1.0
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

Add some documentation to explain the basic concept along with a link
to the full spec.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add a link to the command
- Add a link to the spec

 MAINTAINERS           |  1 +
 doc/usage/cmd/upl.rst |  4 ++--
 doc/usage/index.rst   |  1 +
 doc/usage/upl.rst     | 46 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 doc/usage/upl.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 43d430c603a..215ffd02b45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1716,6 +1716,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
 F:	cmd/upl.c
 F:	common/spl/spl_upl.c
+F:	doc/usage/upl.rst
 F:	doc/usage/cmd/upl.rst
 F:	include/upl.h
 F:	test/boot/upl.c
diff --git a/doc/usage/cmd/upl.rst b/doc/usage/cmd/upl.rst
index a64063d42d5..8d6ea5daa37 100644
--- a/doc/usage/cmd/upl.rst
+++ b/doc/usage/cmd/upl.rst
@@ -16,8 +16,8 @@ Description
 -----------
 
 The *upl* command is used to test U-Boot's support for the Universal Payload
-Specification (UPL) firmware standard. It allows creation of a fake handoff for
-use in testing.
+Specification (UPL) firmware standard (see :doc:`../upl`). It allows creation of
+a fake handoff for use in testing.
 
 
 upl write
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 4246c06d97d..b058c2254fb 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -15,6 +15,7 @@ Use U-Boot
    cmdline
    semihosting
    measured_boot
+   upl
 
 Shell commands
 --------------
diff --git a/doc/usage/upl.rst b/doc/usage/upl.rst
new file mode 100644
index 00000000000..3c4a10c862c
--- /dev/null
+++ b/doc/usage/upl.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Universal Payload
+-----------------
+
+`Universal Payload (UPL) <https://universalpayload.github.io/spec/index.html>`_
+is an Industry Standard for firmware components. UPL
+is designed to improve interoperability within the firmware industry, allowing
+mixing and matching of projects with less friction and fewer project-specific
+implementations. UPL is cross-platform, supporting ARM, x86 and RISC-V
+initially.
+
+UPL is defined in termns of two firmware components:
+
+`Platform Init`
+	Perhaps initial setup of the hardware and jumps to the payload.
+
+`Payload`
+	Selects the OS to boot
+
+In practice UPL can be used to handle any number of handoffs through the
+firmware startup process, with one program acting as platform init and another
+acting as the payload.
+
+UPL provides a standard for three main pieces:
+
+- file format for the payload, which may comprise multiple images to load
+- handoff format for the information the payload needs, such as serial port,
+  memory layout, etc.
+- machine state and register settings at the point of handoff
+
+See also the :doc:`cmd/upl`.
+
+UPL in U-Boot
+~~~~~~~~~~~~~
+
+U-Boot supports:
+
+- writing a UPL handoff (devicetree) in SPL
+- reading a UPL handoff in U-Boot proper
+- creating a FIT
+
+There are some new FIT features in UPL which are not yet supported in U-Boot.
+
+.. sectionauthor:: Simon Glass <sjg@chromium.org>
+.. July 2024
-- 
2.34.1

