Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A03C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 08:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 910328108B;
	Fri, 14 Aug 2026 08:18:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8HCdBNICXcTF; Fri, 14 Aug 2026 08:18:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5D9A8101C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786695486;
	bh=HQy2kRnvrRkLXQVCVGTP9+dUn3elAIAetPObJjqf7uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SS0mvWQXIi+eAfeOlUjxmv0LIE+KZe6qAVe7udoADmlEL6YCOnn8Mrcj7zjXkk+LS
	 m5B+sAWhJ3UZiQVHELWuhtaM/JiQtyvxHhIDodPUrPbr0CQWS0ob/rXlSFT3Yc8lS2
	 5Vm/LSZkCBoCX9v0ihqarN7BUMjBY//H/lo+Ub++zF/XIx9hxYuIdAIVZ2z3DHyokI
	 jAfTIrWxWrcON2yv/FamkMSpYkw45lXZ1VYgJc/yNsORw+I14AmezrbSxvAcEH+/Im
	 0H4LWgjRPLZTPCudkqkaP9GnXwXJqd0fwiMYQjKGwiFCTDLWyELpfRLU71eHQIfQz1
	 zSQth7HsfEexw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5D9A8101C;
	Fri, 14 Aug 2026 08:18:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 70D8B139D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DEF6400AA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:18:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TZchS5ZzH6Qu for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 08:18:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 379C040079
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 379C040079
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gHsZ6QP9
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 379C040079
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:18:01 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso5127535e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786695480; x=1787300280;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HQy2kRnvrRkLXQVCVGTP9+dUn3elAIAetPObJjqf7uI=;
 b=gHsZ6QP9zR6f0aQL6WfbhzZfTg4dZRmxD8hBZTadkuDVv4D1X7ndv3zDKTRLuG22qW
 dSJnvtsL9CsOsg380toOJ0IQwKH14WVXcpKAftrjhlhWTcGaoue9eLR0uB+beATYWGFQ
 E545fkOEWDRDYFP3b88vocZTgtFf+qQP4LqVhS4BSjuWhX3acwBWDBhCIqdv//9Wxu2W
 VRSuWdXvzXqpBrSfZAHOJ4LnRZPJPnlsVNMYa9G9wbeHHbsoJAZaBje/JGDzr8SZYX8q
 5v/MtCmhDTOx5/oSdzatFO5uuqC7Oo5pJSxCsuTuLtTQL6Jyfj2VllW8Mu9EABaHvTaC
 T81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786695480; x=1787300280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HQy2kRnvrRkLXQVCVGTP9+dUn3elAIAetPObJjqf7uI=;
 b=IpQBIZ8ccuqDODp90Xpt3fqpnTdy8lBllZjMjsdLvFG47o2OSCNW052vnxvmRO6jYY
 yxANTX1nGy1dh6pXysQVT7RHzuP/uZQe789ZkVLfke2Ee7+YhiLIEtBNDpOhcHFi0RAV
 OuzO0K4ww8abYC3yoXQ6/wwwWrXCce47npu1/1let4BIAF2rSuSouD3uVRiBYgNGEVlk
 ooCxCicewMNf69lI4u/tSJ4yO4D51hh6vdoYC350TNASReIarxir/addgi3L/rcQNdtw
 JiS9AqK00WJXKTdYTqoWFCWefPX85v4qcCUAQtPB1s/W087pBGuWZaNCch74zu9KYNXn
 vRNw==
X-Gm-Message-State: AOJu0YzbAHX9pa6ESBGcPrtLYSHxYtALb6pkPILPrI8XcXrfDLICNGkD
 esb2353XBCxJ2o79eIRVPXQhdL7QbLQC/7cONW2rIKzrFUreMZMQG+4Z0MJfiRrI
X-Gm-Gg: AR+sD10OgRZdOOo1HC7Q/Go4FrHazOdLm8mg4SN+MouZcMZ8/AMcB+8eyQrclzszuUE
 lATE5Y5iFKNb0S6JDbx6/nITDTLdkL/tdv0vdvjCrmsG1LiYSpZ+94ety7SKDG+ziiwGviUsSXS
 f0rzylKajEf3gFT8kNp9wfzz8kGLUdSsk8NQnkSdPbhHLVVcInkmhH6geUdGGr6cUCt66dVow6I
 Y2hUaf+KVmm7y8GzRVWTTi22QS8guVmswovntgSFe4W2ZQB62bzKvWSsR5LCQ7pQr7TIJY3L89L
 CDU2n43fMi3eBVnG2a/5SFt9DKSA4r1OhSowqquEH1Tg/6OWlG75+gwTVJaE3YKroPG5ZTLlqoB
 p16XlS2Vu1b38KoA8L+P3JKVwlrfGE7dC5Vk0pBwplLYfCJefaltlnv9O94C4qN+EQsoOUz1kk1
 gEy1Nm3FtvdoIn4BAzxBOWWYz4IEDxVG2t7rVAXemrXjGh+Sg/rAqka3K9gF51QKepoA==
X-Received: by 2002:a05:600c:4fc9:b0:493:e365:ace9 with SMTP id
 5b1f17b1804b1-4998797c6ccmr49904605e9.11.1786695479924; 
 Fri, 14 Aug 2026 01:17:59 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm33918625e9.3.2026.08.14.01.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 01:17:59 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Stefan Agner <stefan@agner.ch>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 2/2] doc: board: toradex: add the Colibri VF50/VF61 page
Date: Fri, 14 Aug 2026 10:17:56 +0200
Message-ID: <20260814081756.2498285-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814081756.2498285-1-mehmet.fide@gmail.com>
References: <20260814081756.2498285-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The other Toradex modules are documented here, the Vybrid ones were
not. Describe the build, the two ways of getting the image into NAND,
and the flashloader command of the WinCE-era bootloader that modules
from that era still carry.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 doc/board/toradex/colibri_vf.rst | 66 ++++++++++++++++++++++++++++++++
 doc/board/toradex/index.rst      |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 doc/board/toradex/colibri_vf.rst

diff --git a/doc/board/toradex/colibri_vf.rst b/doc/board/toradex/colibri_vf.rst
new file mode 100644
index 00000000000..f9c81d70214
--- /dev/null
+++ b/doc/board/toradex/colibri_vf.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. sectionauthor:: Mehmet Fide <mehmet.fide@screeningeagle.com>
+
+Colibri VF50/VF61 Modules
+=========================
+
+- SoM: https://www.toradex.com/computer-on-modules/colibri-arm-family/nxp-vybrid-vf5xx-vf6xx
+- Carrier boards: https://www.toradex.com/products/carrier-board/colibri-evaluation-board
+  and https://www.toradex.com/products/carrier-board/iris-carrier-board
+
+Quick Start
+-----------
+
+- Build U-Boot
+- Flash to NAND from a running U-Boot
+- Flash to NAND over recovery mode
+- Modules still carrying the WinCE bootloader
+
+Build U-Boot
+------------
+
+.. code-block:: console
+
+    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ make colibri_vf_defconfig
+    $ make
+
+This produces ``u-boot.imx``, the image with the IVT for the Vybrid
+BootROM, ready to be written to the ``u-boot`` NAND partition.
+
+Flash to NAND from a running U-Boot
+-----------------------------------
+
+Load the image over TFTP or from a FAT formatted SD card and use the
+``update_uboot`` script from the default environment:
+
+.. code-block:: none
+
+    Colibri VFxx # fatload mmc 0:1 ${loadaddr} u-boot.imx
+    Colibri VFxx # run update_uboot
+    Colibri VFxx # reset
+
+Flash to NAND over recovery mode
+--------------------------------
+
+With nothing bootable in NAND, the Vybrid BootROM falls back to the
+serial downloader on the USB client port. The `imx_usb_loader
+<https://github.com/boundarydevices/imx_usb_loader>`_ tool can push
+``u-boot.imx`` straight into OCRAM and run it:
+
+.. code-block:: console
+
+    $ imx_usb u-boot.imx
+
+From the running U-Boot, flash NAND as in the previous section.
+
+Modules still carrying the WinCE bootloader
+-------------------------------------------
+
+Modules that were shipped with the WinCE-era Toradex bootloader (eBoot)
+offer a ``flashloader`` command that writes a U-Boot image to NAND:
+
+.. code-block:: none
+
+    > flashloader u-boot.imx
+    > reboot
diff --git a/doc/board/toradex/index.rst b/doc/board/toradex/index.rst
index 2a45bde6991..5bf2d052462 100644
--- a/doc/board/toradex/index.rst
+++ b/doc/board/toradex/index.rst
@@ -10,6 +10,7 @@ Toradex
    aquila-am69
    colibri_imx7
    colibri-imx8x
+   colibri_vf
    smarc-imx8mp
    smarc-imx95
    verdin-am62
-- 
2.54.0

