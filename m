Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE594C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 00:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC69C8772E;
	Sat, 23 Dec 2023 01:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tSsGilyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 595F987579; Sat, 23 Dec 2023 01:44:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A08875FA
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 01:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703292287; x=1703897087; i=xypron.glpk@gmx.de;
 bh=GnWjx8hWwuDHDfOYVfZIPfjMVY78/OpVbI8AprLjN4k=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
 References;
 b=tSsGilywDt84T5kSZgrqtiuCqye+eIZ6V2qsxi4CFK1wpELJAjLf0LKB0x7gJUGB
 TQC6YRYxZz4WJqeboSB1EfsNuhFDuhOYvQl5z7Id3ALSgxWbjKoFRcwFUxAwIUXuU
 18tlMCPRoV4eVp0Ey4+Yj4yEASm4aBnMY9F+bEPi4N/Nl2wctw2jhWlLuQEy8CAG0
 WE4lcPTFuZ85iPXrxMXrP6w5CnWgrdIDfMHYJbgbbPf8L2d4YjVUfGPBXCM8fFuCi
 Wi7HstBRAciL7RF3JiOY/+bCP/i1hXWpP9kT2W4gvzucaA5r/iPBZZJPdW+t7wcpx
 Awa0wzDtpbolDaSOnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9T1-1rPsXW1ghN-00993r; Sat, 23
 Dec 2023 01:44:47 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 4/5] doc: man-page for smbios command
Date: Sat, 23 Dec 2023 01:44:28 +0100
Message-ID: <20231223004429.247301-5-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223004429.247301-1-xypron.glpk@gmx.de>
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tDky/Y3+RbncKGNwWQPbatYftLm3/yET7uYqrXr14McXcQikOXR
 oDLKfMcmZs/nMLcV5vZhTHXvS+NWodWEgJDSThwG+SQrN92UvMVbuEOHyWmo1jk+BVlKNmw
 o48wgexa3XtqMfBFDIl7dMtgQKEyexnqZvJ+I9ugVYkWBIX1v8w7xQzrzlNTPGUaRNOedAO
 ue0Jcnjwmq49W481tyGXQ==
UI-OutboundReport: notjunk:1;M01:P0:SyFRFjEpQeY=;4IFnNjHAZqgR+vOL5dBjsR37jbr
 DJi7RCzjFbQa+p1C7N5stNJgaD8/IliaXWNUqc8Ae3BLnxUFvlJ5xwlUowuBOZCU6p24a77Wa
 qOPucrmsM3GgrMfuyXcP7IzFIW19I/YSa7BdExdtf9TyA5YOBQRw1gJNxvyAMJqYKFlrPYrRw
 SUF+x0ICwWGiviw+zj1jk+g5l0tx6k/rBjMwmhQniDGh4AMlMu31CJFqvBPCoLMIL7ZeT/OZS
 n0IPsX9OEkj4POYLYJckYjrtTSsnP6WbE47+M7RaW/+1hIk2HjxyI34cz8k/bX3xlNVbotR8W
 8QyRTqDw8Hd7zLXBPmXpQeC6yNOSPsjR6Ci+PdtjtUF4FtjE1SR5fGPBJ2LjFZeBie5QAt+aP
 90yzmYZtLpxUyJx/52ZVfifYpNapg3Jqj5XUOmOMVik8Pf6X9dxNK7ZyQwfBNTlsUfOtqBJ5o
 cUSch1lSsYCWfviq7pRBE17nwDuWBgvkAWBkPmOy4CU9U1freYT4EGeXjQNiFHh2+u0+e8ZLq
 HcuWKN0D/4qGakGR7bRjnFUH7WF9CxfW2MWL6IL4qv5NHVcPsavPiWycd3Oa9S97UWC/q8roc
 +p3L86DkC02wUOSkS3Z/JQqoY0jioetCsnn03j2z9Fja5zFhdWaenPXYDLj/ZrWv2NM1OFaTL
 MFLONd3/yyVQ3zItlAVU8OhoKN4sITyM0ZzRZDKDhEagyfcWCTePUT/994LB1HN4buUveTA+z
 K31AyE0tOusk+tZI2qEQh8h8Y/trkqwgULa7kNpNrTOukoMnsA9ocra2r4MBrtJTcAhnhLiYR
 Q9HTAnCHNBb3PQbBJ/4vT1u0OtspY8d2v7gLv8vHBVyAfuz1IZFz1a5HMc9/pSAr8yQCulAnx
 nQjXY8CZsalCAPGPcCP5aY/1/pytQdlq04/OCJVsjmVocSTV0opO2vpnrd7NmeG0J7A+WLR5j
 JJrDZQ==
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

Provide a man-page for the smbios command.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 doc/usage/cmd/smbios.rst | 93 ++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst      |  1 +
 2 files changed, 94 insertions(+)
 create mode 100644 doc/usage/cmd/smbios.rst

diff --git a/doc/usage/cmd/smbios.rst b/doc/usage/cmd/smbios.rst
new file mode 100644
index 0000000000..1ffd706d7d
=2D-- /dev/null
+++ b/doc/usage/cmd/smbios.rst
@@ -0,0 +1,93 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later:
+
+smbios command
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Synopsis
+--------
+
+::
+
+        smbios
+
+Description
+-----------
+
+The smbios command displays information from the SMBIOS tables.
+
+Examples
+--------
+
+The example below shows an example output of the smbios command.
+
+::
+
+    =3D> smbios
+    SMBIOS 2.8.0 present.
+    8 structures occupying 81 bytes
+    Table at 0x6d35018
+
+    Handle 0x0100, DMI type 1, 27 bytes at 0x6d35018
+    System Information
+        Manufacturer: QEMU
+        Product Name: Standard PC (i440FX + PIIX, 1996)
+        Version: pc-i440fx-2.5
+        Serial Number:
+        UUID 00000000-0000-0000-0000-000000000000
+        Wake Up Type:
+        Serial Number:
+        SKU Number:
+
+    Handle 0x0300, DMI type 3, 22 bytes at 0x6d35069
+    Header and Data:
+        00000000: 03 16 00 03 01 01 02 00 00 03 03 03 02 00 00 00
+        00000010: 00 00 00 00 00 00
+    Strings:
+        String 1: QEMU
+        String 2: pc-i440fx-2.5
+
+    Handle 0x0400, DMI type 4, 42 bytes at 0x6d35093
+    Header and Data:
+        00000000: 04 2a 00 04 01 03 01 02 63 06 00 00 fd ab 81 07
+        00000010: 03 00 00 00 d0 07 d0 07 41 01 ff ff ff ff ff ff
+        00000020: 00 00 00 01 01 01 02 00 01 00
+    Strings:
+        String 1: CPU 0
+        String 2: QEMU
+        String 3: pc-i440fx-2.5
+
+    Handle 0x1000, DMI type 16, 23 bytes at 0x6d350d7
+    Header and Data:
+        00000000: 10 17 00 10 01 03 06 00 00 02 00 fe ff 01 00 00
+        00000010: 00 00 00 00 00 00 00
+
+    Handle 0x1100, DMI type 17, 40 bytes at 0x6d350f0
+    Header and Data:
+        00000000: 11 28 00 11 00 10 fe ff ff ff ff ff 80 00 09 00
+        00000010: 01 00 07 02 00 00 00 02 00 00 00 00 00 00 00 00
+        00000020: 00 00 00 00 00 00 00 00
+    Strings:
+        String 1: DIMM 0
+        String 2: QEMU
+
+    Handle 0x1300, DMI type 19, 31 bytes at 0x6d35125
+    Header and Data:
+        00000000: 13 1f 00 13 00 00 00 00 ff ff 01 00 00 10 01 00
+        00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+
+    Handle 0x2000, DMI type 32, 11 bytes at 0x6d35146
+    Header and Data:
+        00000000: 20 0b 00 20 00 00 00 00 00 00 00
+
+    Handle 0x7f00, DMI type 127, 4 bytes at 0x6d35153
+    End Of Table
+
+Configuration
+-------------
+
+The command is only available if CONFIG_CMD_SMBIOS=3Dy.
+
+Return value
+------------
+
+The return value $? is 0 (true) on success, 1 (false) otherwise.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 1a626c03c2..eb2b2311f8 100644
=2D-- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -102,6 +102,7 @@ Shell commands
    cmd/size
    cmd/sleep
    cmd/sm
+   cmd/smbios
    cmd/sound
    cmd/source
    cmd/temperature
=2D-
2.43.0

