Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7CCC5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:07:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85CB5607F5;
	Thu, 13 Aug 2026 15:07:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0PQDBtDWMdb; Thu, 13 Aug 2026 15:07:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88109608AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786633655;
	bh=8G0GeRNG8HBxYdIJtDJ3MyLAuFcQSKoEX8//CxSp/0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n2xZ65vZFt16fXFmo031GRpQVDjkAC/roiim2mG6y0zFi/TLDntZhGWDdYkNqqfsY
	 JK1nun4j+eNilUlxkEi+YBUMZyO32nxO3nMmv7dRNu0r/K4syyQg75X7yRHl7Ye/VE
	 GPJmO32F7t5vI09oXLGurbSuFFWhiAfxDdidL/6RJ4eQrM4nXXiBwz9fj//RpqqD2L
	 mkIDvaeRbFS0Kp4WOLX2Zm5OolC8Lzg8GVAD5rvq9YzPjgd9oSWaZIvAasQeCVgMKA
	 Qm4CgKpVzAqkueXd2Fe9ajJlxLZwnQPDxxFdMOdTaipkS35625zyjtSdpEvEeClNP0
	 lHduiO09fRmQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88109608AD;
	Thu, 13 Aug 2026 15:07:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 98E71392
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F3C58117B
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8h-cBq0KZzwG for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:07:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6FA8381180
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FA8381180
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FA8381180
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:07:31 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so195955e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786633649; x=1787238449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8G0GeRNG8HBxYdIJtDJ3MyLAuFcQSKoEX8//CxSp/0E=;
 b=axubnOB30LbGg8t3RKkdsayq5tUpj+2dQ450vk7YMjODG0UApYqOsG8pggPmnYphOf
 cPu1gaKpR5ncGERhmE39i/BGlGJTUwuwTFJHUqYeFQjhmb6dd89A79SkAur5obn9FT8Y
 110s+ngN+TKNdpLQ2oYr1x7YtY/BHe5W9lItVjdMNOHcRfDwW5L+Usx9O8WrHi6APHFd
 HSmOZTq2Q0lASXKUBUTeScfd9QA+LaYRX2luZtpHCurTqG8JV/zq2WTbMjJHRuUA1RDi
 uuXR4gImBbHX3/xS3EXyzc61HnIgsFJGO2IC1MYTbtiFJcZFWZHoWxC2SS+GT684t9nx
 07Vw==
X-Gm-Message-State: AOJu0YxdIaEehwTpL+vGlrwZljQEKvg8zD78Vf1TCAUPHvq6DjEV/Oib
 fwZ7pHqvEF9m+PNt2z/8g9o591836IZOLnBsI4BZRAa8RiCOlZL90Ptv+Vt+YlEu
X-Gm-Gg: AR+sD11ettU0E4N9UY7b4XwR4OCbFPBPeQ2Bs+nG34cYrm/L/0AULW5qAFOny/EnsiK
 GhBo0TT+G5ICRlDQtEC7V8MXvywz1haT0J8hvzn3qXdPERvha/WVFhIPAl1UQFm9hvqwLsyMTGv
 4OiliUU4FFi1wahaxg0tlMaKHYHKuuD/s5sDRLw5SPe+jEqG5vZ0mfMRadLD3AQeCGkjQxHvES8
 HdMflNNBwW2jrYV0kwW4ClRBQnJn/8diNud0IP8HluNkIyS5yw6/04BXRiEOTFTItgxVIkfmWo8
 5B51Rc6GFjXh6jI1rMq/vMD2sbJsVk0S1khGXhk9o1HkwMNyv2LdRp3yzwka9XzepNx+ttf38gs
 6/zpNd7UwW/MfybUmSfs36ZwekzkB58YpyjAHGulFpxku5dP/6I6LEvWeAyFbEaXboXV3Jpe4om
 4f+9XjgnOfQHogXE9ZornccmGAnHVTaTDBxabhVINt+LxhoIIFb1eKjQdEdoAURRZb+g==
X-Received: by 2002:a05:600c:c177:b0:498:1595:be7b with SMTP id
 5b1f17b1804b1-499821c5be9mr73007205e9.4.1786633649223; 
 Thu, 13 Aug 2026 08:07:29 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b03cd0sm76265185e9.1.2026.08.13.08.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:07:28 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Stefan Agner <stefan@agner.ch>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 2/2] doc: board: toradex: add the Colibri VF50/VF61 page
Date: Thu, 13 Aug 2026 17:07:26 +0200
Message-ID: <20260813150726.2184452-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813150726.2184452-1-mehmet.fide@gmail.com>
References: <20260813150726.2184452-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786633649; x=1787238449;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8G0GeRNG8HBxYdIJtDJ3MyLAuFcQSKoEX8//CxSp/0E=;
 b=p0kpehGlqC73LOTHqB+njam3TbHd8FZfk71nIczAXTGVNHgxStR7JT78nWN4oYfGyc
 UOoyOlDkkJp+CbMrV1JJ0akh9qwucSnm8rRW2bHOWIsVvBUfV+dM6Bxp95XWaCgV/GBX
 YH9wBSTE7r6gvkFjufL0rimpwsvWzdFFhl2NvB9tOvEmBkAc+4CPRzZqoCvHuC3Yd7Fy
 CySL1fOAtrYZsLpCta4moczxvRK6j/yahnbUGUZqPiwrALmjF9ayevvhZIZAr2RMIVXU
 NuV0ZYCnhMVkdnbzZQXJl+0HMDxQ6O5ViuMgYFJqUJx4InvTZFVYhCf9yGbIdY8B2rr7
 GZOw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=p0kpehGl
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

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 doc/board/toradex/colibri_vf.rst | 70 ++++++++++++++++++++++++++++++++
 doc/board/toradex/index.rst      |  1 +
 2 files changed, 71 insertions(+)
 create mode 100644 doc/board/toradex/colibri_vf.rst

diff --git a/doc/board/toradex/colibri_vf.rst b/doc/board/toradex/colibri_vf.rst
new file mode 100644
index 00000000000..d2809bda2e8
--- /dev/null
+++ b/doc/board/toradex/colibri_vf.rst
@@ -0,0 +1,70 @@
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
+.. code-block:: bash
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
+.. code-block:: bash
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
+
+The image must be linked at ``CONFIG_TEXT_BASE=0x3f408000``; the BootROM
+does not start an image linked at the bottom of the gfxRAM area, whether
+loaded through eBoot or from NAND.
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

