Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FBACCA472
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 22:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1059983622;
	Mon,  6 Oct 2025 00:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A9Ix6qrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C9A0809A5; Mon,  6 Oct 2025 00:12:56 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD968361E
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 00:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so26907185e9.1
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759702370; x=1760307170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8DG5EYFiMKpDtRLcUK+2GLILNxw4rFTyZt++G8mtVdw=;
 b=A9Ix6qrZZnrH1VsdtNY2u8V33GiWeDxD+6/1XlS8qe/T7/wufZ8A2QgTSGFygtflQP
 qw0e/2hFkq6kaUyQtZC+wmMq1RHqy4xdCc6NYlEhnKznSQB7TaCtSZAMz8zHd2Jf578g
 clHfS3wwA6+sexf9eDjNjVppH0XDFlM12UNeUbmnO2G9wsA5e8ABsWAX+xJtuKhpUl2H
 nsZcmYgaom8IyCTSELy7dE2eF2LioYv1OXWP9wyy227E9d/H1nH+WbKgTNt6QIP1VROK
 c2z+h0bsdytM5AlkZ73OralobCa/f2LDlrggRvzjx4X2jOW94KdsiE0NtgBTIAM64O9O
 nE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759702370; x=1760307170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DG5EYFiMKpDtRLcUK+2GLILNxw4rFTyZt++G8mtVdw=;
 b=jZjArRaaFOASWN9eOYxO4JNUspO075ZTkuDA7m6yeRLBWjlyJsa2732CMobeCz1b2N
 ddO2CNTpmeSoDE8O28JyyAKhzOmSlM2MC1ngj/1Ddo6yz2z9P7jej4GkzZvc5/AgGpVC
 XqyMHCOdoFcYZ+i5IoyQn40FR0Xi/7t0/J48zXzVa9Vr9N42aE+QDBRbFRe+wcEh8kAx
 XXptDG07FbVkWzieStRcepXeWMWbN0uOdv817W14rnXwV/qcZ2Ek/Ko2dJh4SfuySfSQ
 eF7eF8nQWfeCLxruAQVhY2A+DZbDLy1aQAhraRkvSVS+IKHhdFWUsyUOASuELIRaJ9lC
 Pq3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQP/LmNBybihgspL4d54NhPicByLrlPhpeo3OVnBTF7kx0ySArh2WMVXymMl4aW150CTIy3jo=@lists.denx.de
X-Gm-Message-State: AOJu0YwL2PLWE3kSSsAJ1fXULnHUnkUnuO9f3VSiuAychp/Z+DcRwYh0
 DErrKPTqj/ipyOtYmyEg2TRhxutBxXkhaZJqSI7UaMwHKG2fSJ31REgL
X-Gm-Gg: ASbGncsmWAtDDRVsMuSFbnafW4dRnTLHlMLXOCLUdHDL7y0PPGpBndNUjiYWI0ue2+B
 Ivf2O66Qcrredbgp9AxYp9QBxzjdpJjYU+X49zBeboDg7JKDLN8FllzKoQGN3Osz6tJ5M9wKCn5
 Td7fLtCt8brBjsbbI6G1tg3DFLakLZgcXZcPjYjdsKOInVRSRl7MjL41ZGCHKpquibx4gb3tI4r
 5BeFOE7XnyAS/MmEogXvexywvyerD1eRzgD7r22RkoKdkvC/9PnvJnuKG3aeGsjmXH/K9FTW+3e
 qM9Qk5PJ0XJJBFGi79l9fEMGYi273nD7yLcq5WlDMPtaV3JL+zJGeensjbtWW9Gk0C9TIdiYnrn
 IwgwrrvZ/oCfsbN0kVKDtloP0wb6aYHMVPNlXj6WIlMQjZLFDeicHWg==
X-Google-Smtp-Source: AGHT+IEuySqLoBSzNoBhkP5v1q/JjdwCBci6gRKJCSOPgfqZp8RtL4aN3O9Q7+61vh4LebZVLJub/Q==
X-Received: by 2002:a05:600c:6092:b0:45c:b6d3:a11d with SMTP id
 5b1f17b1804b1-46e70c48dc8mr74199315e9.1.1759702370272; 
 Sun, 05 Oct 2025 15:12:50 -0700 (PDT)
Received: from N580G.. ([2001:8a0:ca4a:300:ec0a:68da:a550:d9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72375b31sm137370095e9.20.2025.10.05.15.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 15:12:49 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>,
 "GitAuthor: Adriano Carvalho" <adrianocarvalho.pt@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Dhruva Gole <d-gole@ti.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Wadim Egorov <w.egorov@phytec.de>, Vitor Soares <vitor.soares@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH v2 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
Date: Sun,  5 Oct 2025 23:10:11 +0100
Message-ID: <20251005221057.255029-5-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
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

SVG files are not handled directly in the *.tex files. This commit
replaces all instances of ".. image::" with ".. kernel-figure::". With
this, the kfigure sphinx extension (already present) ensures that SVG
files are converted to PDF before the compilation of *.tex files.

If I don't do this, this is what I get with
docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
[...]
xelatex  'android.tex'
[...]
Output written on android.pdf (28 pages).
[...]
xelatex  'api.tex'
[...]
Output written on api.pdf (431 pages).
[...]
xelatex  'arch.tex'
[...]
Output written on arch.pdf (62 pages).
[...]
xelatex  'board.tex'
[...]

[152]
Chapter 14.

! LaTeX Error: Cannot determine size of graphic in boot_diagram_am62.svg (no Bo
undingBox).

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...

l.11422 ...ncludegraphics{{boot_diagram_am62}.svg}

?
! Emergency stop.
 ...

[...]

Output written on board.pdf (156 pages).
Transcript written on board.log.
make[2]: *** [Makefile:29: board.pdf] Error 1
make[1]: *** [doc/Makefile:95: pdfdocs] Error 2
make: *** [Makefile:2687: pdfdocs] Error 2

NOTE: This won't completely fix the pdfdocs target. See next commit(s).

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/board/beagle/am62x_beagleplay.rst     |  8 ++++----
 doc/board/beagle/am67a_beagley_ai.rst     |  6 +++---
 doc/board/beagle/j721e_beagleboneai64.rst | 10 +++++-----
 doc/board/samsung/e850-96.rst             |  2 +-
 doc/board/ti/am62ax_sk.rst                |  6 +++---
 doc/board/ti/am62px_sk.rst                |  8 ++++----
 doc/board/ti/am62x_sk.rst                 |  8 ++++----
 doc/board/ti/am64x_evm.rst                |  8 ++++----
 doc/board/ti/am65x_evm.rst                | 12 ++++++------
 doc/board/ti/j7200_evm.rst                | 10 +++++-----
 doc/board/ti/j721e_evm.rst                | 10 +++++-----
 doc/board/ti/j721s2_evm.rst               |  6 +++---
 doc/board/ti/j722s_evm.rst                |  6 +++---
 doc/board/ti/j784s4_evm.rst               |  8 ++++----
 doc/board/ti/k3.rst                       |  8 ++++----
 doc/develop/memory.rst                    |  4 ++--
 doc/develop/trace.rst                     | 10 +++++-----
 tools/patman/patman.rst                   |  2 +-
 18 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
index bc71aabaac3..8188f0b41c9 100644
--- a/doc/board/beagle/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -23,7 +23,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: ../ti/img/boot_diagram_am62.svg
+.. kernel-figure:: ../ti/img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - On this platform, 'TI Foundational Security' (TIFS) functions as the
@@ -85,12 +85,12 @@ Image formats
 
 - tiboot3.bin
 
-.. image:: ../ti/img/multi_cert_tiboot3.bin.svg
+.. kernel-figure:: ../ti/img/multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: ../ti/img/tifsstub_dm_tispl.bin.svg
+.. kernel-figure:: ../ti/img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 Additional hardware for U-Boot development
@@ -172,7 +172,7 @@ Area (UDA) hardware partition of the eMMC. These components can vary
 significantly in size. The choice of keeping tiboot3.bin in boot0 or
 boot1 partition depends on A/B update requirements.
 
-.. image:: img/beagleplay_emmc.svg
+.. kernel-figure:: img/beagleplay_emmc.svg
   :alt: eMMC partitions and boot file organization for BeaglePlay
 
 The following are the steps from Linux shell to program eMMC:
diff --git a/doc/board/beagle/am67a_beagley_ai.rst b/doc/board/beagle/am67a_beagley_ai.rst
index 3d2fc4a3195..7113029f0ff 100644
--- a/doc/board/beagle/am67a_beagley_ai.rst
+++ b/doc/board/beagle/am67a_beagley_ai.rst
@@ -23,7 +23,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: ../ti/img/boot_diagram_k3_current.svg
+.. kernel-figure:: ../ti/img/boot_diagram_k3_current.svg
   :alt: Boot flow diagram
 
 - On this platform, 'TI Foundational Security' (TIFS) functions as the
@@ -84,12 +84,12 @@ Image formats
 
 - tiboot3.bin
 
-.. image:: ../ti/img/multi_cert_tiboot3.bin.svg
+.. kernel-figure:: ../ti/img/multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: ../ti/img/tifsstub_dm_tispl.bin.svg
+.. kernel-figure:: ../ti/img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 Additional hardware for U-Boot development
diff --git a/doc/board/beagle/j721e_beagleboneai64.rst b/doc/board/beagle/j721e_beagleboneai64.rst
index a57bc743569..94bcce75a42 100644
--- a/doc/board/beagle/j721e_beagleboneai64.rst
+++ b/doc/board/beagle/j721e_beagleboneai64.rst
@@ -26,7 +26,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: ../ti/img/boot_diagram_j721e.svg
+.. kernel-figure:: ../ti/img/boot_diagram_j721e.svg
   :alt: Boot flow diagram
 
 - On this platform, DMSC runs 'TI Foundational Security' (TIFS) which
@@ -92,17 +92,17 @@ Image formats
 
 - tiboot3.bin
 
-.. image:: ../ti/img/no_multi_cert_tiboot3.bin.svg
+.. kernel-figure:: ../ti/img/no_multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: ../ti/img/dm_tispl.bin.svg
+.. kernel-figure:: ../ti/img/dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 - sysfw.itb
 
-.. image:: ../ti/img/sysfw.itb.svg
+.. kernel-figure:: ../ti/img/sysfw.itb.svg
   :alt: sysfw.itb image format
 
 Additional hardware for U-Boot development
@@ -184,7 +184,7 @@ Area (UDA) hardware partition of the eMMC. These components can vary
 significantly in size. The choice of keeping tiboot3.bin in boot0 or
 boot1 partition depends on A/B update requirements.
 
-.. image:: img/beagleplay_emmc.svg
+.. kernel-figure:: img/beagleplay_emmc.svg
   :alt: eMMC partitions and boot file organization for BeagleBone AI-64
 
 The following are the steps from Linux shell to program eMMC:
diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.rst
index b435fa8b353..8e47dcbf5b6 100644
--- a/doc/board/samsung/e850-96.rst
+++ b/doc/board/samsung/e850-96.rst
@@ -28,7 +28,7 @@ Boot Flow
 
 The boot path for Exynos850 is shown on the figure below.
 
-.. image:: img/exynos850-boot-architecture.svg
+.. kernel-figure:: img/exynos850-boot-architecture.svg
   :alt: Exynos850 SoC boot flow
 
 Legend:
diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 4dd998bcce9..8a45453c1a8 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -47,7 +47,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_am62.svg
+.. kernel-figure:: img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -138,12 +138,12 @@ Image formats:
 
 - tiboot3.bin
 
-.. image:: img/multi_cert_tiboot3.bin.svg
+.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: img/tifsstub_dm_tispl.bin.svg
+.. kernel-figure:: img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 Switch Setting for Boot Mode
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index a07d6a4da45..dc54a47dbb4 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -55,7 +55,7 @@ Boot Flow:
 The bootflow is exactly the same as all SoCs in the am62xxx extended SoC
 family. Below is the pictorial representation:
 
-.. image:: img/boot_diagram_am62.svg
+.. kernel-figure:: img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -152,12 +152,12 @@ Image formats:
 
 - tiboot3.bin
 
-.. image:: img/multi_cert_tiboot3.bin.svg
+.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: img/tifsstub_dm_tispl.bin.svg
+.. kernel-figure:: img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 OSPI:
@@ -181,7 +181,7 @@ over tftp and then flash those to OSPI at their respective addresses.
 
 Flash layout for OSPI:
 
-.. image:: img/ospi_sysfw2.svg
+.. kernel-figure:: img/ospi_sysfw2.svg
   :alt: OSPI flash partition layout
 
 A53 SPL DDR Memory Layout
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index dab2970a85c..4ca668dfeab 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -46,7 +46,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_am62.svg
+.. kernel-figure:: img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -174,12 +174,12 @@ Image formats:
 
 - tiboot3.bin
 
-.. image:: img/multi_cert_tiboot3.bin.svg
+.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: img/tifsstub_dm_tispl.bin.svg
+.. kernel-figure:: img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 OSPI:
@@ -203,7 +203,7 @@ over tftp and then flash those to OSPI at their respective addresses.
 
 Flash layout for OSPI:
 
-.. image:: img/ospi_sysfw2.svg
+.. kernel-figure:: img/ospi_sysfw2.svg
   :alt: OSPI flash partition layout
 
 A53 SPL DDR Memory Layout
diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
index 65c4c456528..015b8cfb299 100644
--- a/doc/board/ti/am64x_evm.rst
+++ b/doc/board/ti/am64x_evm.rst
@@ -35,7 +35,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_am64.svg
+.. kernel-figure:: img/boot_diagram_am64.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -136,12 +136,12 @@ Image formats:
 
 - tiboot3.bin
 
-.. image:: img/multi_cert_tiboot3.bin.svg
+.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: img/nodm_tispl.bin.svg
+.. kernel-figure:: img/nodm_tispl.bin.svg
   :alt: tispl.bin image format
 
 OSPI:
@@ -165,7 +165,7 @@ over tftp and then flash those to OSPI at their respective addresses.
 
 Flash layout for OSPI:
 
-.. image:: img/ospi_sysfw-am64.svg
+.. kernel-figure:: img/ospi_sysfw-am64.svg
   :alt: OSPI flash partition layout
 
 Switch Setting for Boot Mode
diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 60b08ceebf0..7be4c6eaf44 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -45,7 +45,7 @@ applications. This should happen before running Linux.
 3. In production boot flow, we might not like to use full U-Boot,
 instead use Falcon boot flow to reduce boot time.
 
-.. image:: img/boot_diagram_am65.svg
+.. kernel-figure:: img/boot_diagram_am65.svg
   :alt: Boot flow diagram
 
 - Here DMSC acts as master and provides all the critical services. R5/A53
@@ -141,17 +141,17 @@ Image formats:
 
 - tiboot3.bin
 
-.. image:: img/no_multi_cert_tiboot3.bin.svg
+.. kernel-figure:: img/no_multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: img/nodm_tispl.bin.svg
+.. kernel-figure:: img/nodm_tispl.bin.svg
   :alt: tispl.bin image format
 
 - sysfw.itb
 
-.. image:: img/sysfw.itb.svg
+.. kernel-figure:: img/sysfw.itb.svg
   :alt: sysfw.itb image format
 
 eMMC:
@@ -193,7 +193,7 @@ used:
 
 eMMC layout:
 
-.. image:: img/emmc_am65x_evm_boot0.svg
+.. kernel-figure:: img/emmc_am65x_evm_boot0.svg
   :alt: emmc boot partition layout
 
 Kernel image and DT are expected to be present in the /boot folder of rootfs.
@@ -229,7 +229,7 @@ addresses.
 
 Flash layout for OSPI:
 
-.. image:: img/ospi_sysfw.svg
+.. kernel-figure:: img/ospi_sysfw.svg
   :alt: OSPI flash partition layout
 
 Kernel Image and DT are expected to be present in the /boot folder of UBIFS
diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
index 4fd2aff8354..b6e285ec621 100644
--- a/doc/board/ti/j7200_evm.rst
+++ b/doc/board/ti/j7200_evm.rst
@@ -34,7 +34,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. kernel-figure:: img/boot_diagram_k3_current.svg
   :alt: Boot flow diagram
 
 - Here DMSC acts as master and provides all the critical services. R5/A72
@@ -135,12 +135,12 @@ Image formats:
 
 - tiboot3.bin
 
-.. image:: img/j7200_tiboot3.bin.svg
+.. kernel-figure:: img/j7200_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. kernel-figure:: img/dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 Switch Setting for Boot Mode
@@ -196,7 +196,7 @@ Current allocated size for tiboot3 size is 1MB, tispl is 2MB.
 Size of u-boot.img is taken 4MB for refernece,
 But this is subject to change depending upon atf, optee size
 
-.. image:: img/emmc_j7200_evm_boot01.svg
+.. kernel-figure:: img/emmc_j7200_evm_boot01.svg
   :alt: Traditional eMMC boot partition layout
 
 In case of UDA FS mode booting, following is layout.
@@ -204,7 +204,7 @@ In case of UDA FS mode booting, following is layout.
 All boot images tiboot3.bin, tispl and u-boot should be written to
 fat formatted UDA FS as file.
 
-.. image:: img/emmc_j7200_evm_udafs.svg
+.. kernel-figure:: img/emmc_j7200_evm_udafs.svg
   :alt: eMMC UDA boot partition layout
 
 In case of booting from eMMC, write above images into raw or UDA FS.
diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index 41c8d4c72a8..75994de8b60 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -39,7 +39,7 @@ Boot Flow:
 Boot flow is similar to that of AM65x SoC and extending it with remoteproc
 support. Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_j721e.svg
+.. kernel-figure:: img/boot_diagram_j721e.svg
   :alt: Boot flow diagram
 
 - Here DMSC acts as master and provides all the critical services. R5/A72
@@ -141,17 +141,17 @@ Image formats:
 
 - tiboot3.bin
 
-.. image:: img/no_multi_cert_tiboot3.bin.svg
+.. kernel-figure:: img/no_multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. kernel-figure:: img/dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 - sysfw.itb
 
-.. image:: img/sysfw.itb.svg
+.. kernel-figure:: img/sysfw.itb.svg
   :alt: sysfw.itb image format
 
 OSPI:
@@ -178,7 +178,7 @@ addresses.
 
 Flash layout for OSPI:
 
-.. image:: img/ospi_sysfw.svg
+.. kernel-figure:: img/ospi_sysfw.svg
   :alt: OSPI flash partition layout
 
 R5 Memory Map:
diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
index 21683b90b1a..1257c5a3ae9 100644
--- a/doc/board/ti/j721s2_evm.rst
+++ b/doc/board/ti/j721s2_evm.rst
@@ -42,7 +42,7 @@ Boot Flow:
 
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. kernel-figure:: img/boot_diagram_k3_current.svg
 
 - On this platform, "TI Foundational Security" (TIFS) functions as the
   security enclave master while "Device Manager" (DM), also known as the
@@ -152,11 +152,11 @@ Image formats:
 
 - tiboot3.bin
 
-.. image:: img/multi_cert_tiboot3.bin.svg
+.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. kernel-figure:: img/dm_tispl.bin.svg
 
 R5 Memory Map:
 --------------
diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
index 9c53fa50858..ec3254d9ae7 100644
--- a/doc/board/ti/j722s_evm.rst
+++ b/doc/board/ti/j722s_evm.rst
@@ -32,7 +32,7 @@ Boot Flow:
 The bootflow is exactly the same as all SoCs in the am62xxx extended SoC
 family. Below is the pictorial representation:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. kernel-figure:: img/boot_diagram_k3_current.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -126,12 +126,12 @@ Image formats:
 
 - tiboot3.bin
 
-.. image:: img/multi_cert_tiboot3.bin.svg
+.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
   :alt: tiboot3.bin image format
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. kernel-figure:: img/dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 A53 SPL DDR Memory Layout
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index 22442874110..a6bb11b9a91 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -41,7 +41,7 @@ Boot Flow
 ---------
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. kernel-figure:: img/boot_diagram_k3_current.svg
     :alt: K3 boot flow
 
 - On this platform, "TI Foundational Security" (TIFS) functions as the
@@ -158,12 +158,12 @@ Image formats
 
 - tiboot3.bin
 
-.. image:: img/multi_cert_tiboot3.bin.svg
+.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
     :alt: tiboot3.bin format
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. kernel-figure:: img/dm_tispl.bin.svg
     :alt: tispl.bin format
 
 OSPI:
@@ -188,7 +188,7 @@ addresses.
 
 Flash layout for OSPI NOR:
 
-.. image:: img/ospi_sysfw3.svg
+.. kernel-figure:: img/ospi_sysfw3.svg
   :alt: OSPI NOR flash partition layout
 
 R5 Memory Map
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 01fb9411688..0b9a91bf6fa 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -61,7 +61,7 @@ boot media needed to load the binaries packaged inside `tiboot3.bin`,
 including a 32bit U-Boot SPL, (called the wakeup SPL) that ROM will jump
 to after it has finished loading everything into internal SRAM.
 
-.. image:: img/boot_flow_01.svg
+.. kernel-figure:: img/boot_flow_01.svg
   :alt: Boot flow up to wakeup domain SPL
 
 The wakeup SPL, running on a wakeup domain core, will initialize DDR and
@@ -71,7 +71,7 @@ application cores inside the main domain to initialize the main domain,
 starting with Trusted Firmware-A (TF-A), before moving on to start
 OP-TEE and the main domain's U-Boot SPL.
 
-.. image:: img/boot_flow_02.svg
+.. kernel-figure:: img/boot_flow_02.svg
   :alt: Boot flow up to main domain SPL
 
 The main domain's SPL, running on a 64bit application core, has
@@ -80,7 +80,7 @@ initialize even more peripherals needed to load in the `u-boot.img`
 which loads more firmware into the micro-controller & wakeup domains and
 finally prepare the main domain to run Linux.
 
-.. image:: img/boot_flow_03.svg
+.. kernel-figure:: img/boot_flow_03.svg
   :alt: Complete boot flow up to Linux
 
 This is the typical boot flow for all K3 based SoCs, however this flow
@@ -691,7 +691,7 @@ generation device.
 
 The overall structure of this setup is in the following figure.
 
-.. image:: img/openocd-overview.svg
+.. kernel-figure:: img/openocd-overview.svg
   :alt: Overview of OpenOCD setup.
 
 .. note::
diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
index 5177229630d..d7f842f3367 100644
--- a/doc/develop/memory.rst
+++ b/doc/develop/memory.rst
@@ -69,7 +69,7 @@ SPL Flow
       Prior to setting up of the DRAM, the stack, malloc is defined as below
       possibly sitting on a smaller readily available memory (SRAM etc.):
 
-      .. image:: pics/spl_before_reloc.svg
+      .. kernel-figure:: pics/spl_before_reloc.svg
          :alt: contents of ready RAM before relocation in SPL
 
       Please see CONFIG_SPL_EARLY_BSS if BSS initialization is needed prior
@@ -95,7 +95,7 @@ SPL Flow
 
       The final environment is setup and the system RAM now looks like this:
 
-      .. image:: pics/spl_after_reloc.svg
+      .. kernel-figure:: pics/spl_after_reloc.svg
          :alt: contents of DRAM after relocation in SPL
 
       Again stack and gd are an optional move and may still remain in the
diff --git a/doc/develop/trace.rst b/doc/develop/trace.rst
index d3c8628d124..417f138fea2 100644
--- a/doc/develop/trace.rst
+++ b/doc/develop/trace.rst
@@ -111,7 +111,7 @@ Finally run kernelshark to display it (note it only works with `.dat` files!):
 Using this tool you can view the trace records and see the timestamp for each
 function.
 
-.. image:: pics/kernelshark.png
+.. kernel-figure:: pics/kernelshark.png
   :width: 800
   :alt: Kernelshark showing function-trace records
 
@@ -144,7 +144,7 @@ There is a -f option available to select a function graph:
 Again, you can use kernelshark or trace-cmd to look at the output. In this case
 you will see the time taken by each function shown against its exit record.
 
-.. image:: pics/kernelshark_fg.png
+.. kernel-figure:: pics/kernelshark_fg.png
   :width: 800
   :alt: Kernelshark showing function-graph records
 
@@ -188,11 +188,11 @@ command:
 You can load the .svg file into a viewer. If you use Chrome (and some other
 programs) you can click around and zoom in and out.
 
-.. image:: pics/flamegraph.png
+.. kernel-figure:: pics/flamegraph.png
   :width: 800
   :alt: Chrome showing the flamegraph.pl output
 
-.. image:: pics/flamegraph_zoom.png
+.. kernel-figure:: pics/flamegraph_zoom.png
   :width: 800
   :alt: Chrome showing zooming into the flamegraph.pl output
 
@@ -209,7 +209,7 @@ Note that trace collection does slow down execution so the timings will be
 inflated. They should be used to guide optimisation. For accurate boot timings,
 use bootstage.
 
-.. image:: pics/flamegraph_timing.png
+.. kernel-figure:: pics/flamegraph_timing.png
   :width: 800
   :alt: Chrome showing flamegraph.pl output with timing
 
diff --git a/tools/patman/patman.rst b/tools/patman/patman.rst
index 549e203c254..44a97ac11a6 100644
--- a/tools/patman/patman.rst
+++ b/tools/patman/patman.rst
@@ -932,7 +932,7 @@ be sure to check out the help.
 
 Here is a sample 'progress' view:
 
-.. image:: pics/patman.jpg
+.. kernel-figure:: pics/patman.jpg
   :width: 800
   :alt: Patman showing the progress view
 
-- 
2.34.1

