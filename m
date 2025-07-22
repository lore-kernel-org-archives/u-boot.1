Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4321BC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 15:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE84838BB;
	Tue, 22 Jul 2025 17:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q9CuFmGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5C28388E; Tue, 22 Jul 2025 17:35:19 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89041838A0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 17:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so39179825e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753198517; x=1753803317; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ehu6RuRVqrvoImtsZH1wLe4uxDbahHcqKrI/scOZs7A=;
 b=Q9CuFmGkzaS+/DJEkSEMWAE2x8YWhG/EY64aZTowcWugOL3qGb7Ry2JOM2ApFtJjWc
 Xu38rPTG/svAJ1dwDxr+9LD8npecWlBMY1yvhBkcNi7xSFGNfz7DQMx93RY1G7Vquu9x
 9dir58v1P3e7iF7FHHOv2phOSROychhVQfJdReEOFrNHXhDitAJU19S93qms0/ThlwcW
 OTKb28iTFF550y2ErBWqD3Ao6+MemhAN/0t4yXBTtoiN1+Q6UIt5zjrLx0dSq2Kv5OsH
 aZgg6cVGtXZBrHM3XHoTKI3L6SmeqdFiowphQ64lBwYFrozBc4BGJRkrtUmG71htPuFm
 bJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753198517; x=1753803317;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ehu6RuRVqrvoImtsZH1wLe4uxDbahHcqKrI/scOZs7A=;
 b=JK9/fjgmZv9y95I86gBIgkavAHYSUlKh0tpnv4a/ymMMksWoD01dYZ+dPtSc/txrYt
 nXT2o8cUj6sZAanFLDSjSNXITa6Xqh8dAw18V3p15+887rHpTQZycGXUHvQb/jngbT/f
 4Pqp54ktWhffT+LrBVFHoZqSBtEaiMld6zDUtX/bO4ikVcHxIS4TnBu40y1meylB+p52
 svx6gEX+3+2Jo2nxMFpNgmJMbPVTRgVZUgE1AWuMmjcvlaXqU1hsZlm5rMfv5eBU+ZxO
 eRZ9aBqiufNG06kodNf7dwX3VHlmF9Iojlf8DAMLiAll1EXpzM0iorC2RYKDyeO7Mn/x
 NJzg==
X-Gm-Message-State: AOJu0Yx4JkVp/lLIFJprJ3dAk9n7uR0bJQZAFMEh/qs7V0SPnAwE0KWk
 c/L7sL0ah675jHDO6cXfterfP3DmBSE80SV0wcGnlUMotjmTixaI6RrZj90yNNXk0eg=
X-Gm-Gg: ASbGncsyjZpQf7KHpllafHumEZHnXcWmpdjsy5ix7cQMekHArER4AkUs7nTmvjZ9laC
 mrMfKhVZjI3Qvk2JJreS8SkDjFe1D2QOWc5F9S3gK1y+E6d+KMc71svwE9p7yKfhZqyjGWLvJ2a
 +QJ4FQ1qwiR5hSsmJ/0vpegxBRgXyYtzd+J78j1xRwp+cIcMn0b8ahn8CcjOnJR5ON1XWmhOKvC
 V33EglSpC2XErBO3/E1B/qPvakTrxWc+D+o9tAFSswuuqJPZawfMr4P4uPcxgplYijsxqvtQU1w
 wK6mn8lqnecQMRVd/ZSXrd52RrOfFNwG1zODjqROjsyM2gpVAwfC9ND5rTCSDC48DiWtT1Tgrvo
 xTBvQovYb9/fG/gwRB3/xLWkCRi18b7qLnE0Y0u3UUEpw4BgAOeda4huzClPVrkqCLQ==
X-Google-Smtp-Source: AGHT+IG5pXdDXcoqldKt3hgS4mht55JQrkVMZtIktzAktvALeznUUmgC6WpnHc4WZ3rgvIkIASWrlg==
X-Received: by 2002:a05:600c:34ca:b0:440:6a79:6df0 with SMTP id
 5b1f17b1804b1-4562e373ee9mr189963645e9.22.1753198516785; 
 Tue, 22 Jul 2025 08:35:16 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886286sm198716285e9.26.2025.07.22.08.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:35:16 -0700 (PDT)
From: Casey Connolly <caleb.connolly@linaro.org>
Date: Tue, 22 Jul 2025 17:34:58 +0200
Subject: [PATCH v5 8/8] doc: board/qualcomm: update docs for new u-boot.mbn
 target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-b4-qcom-tooling-improvements-v5-8-df143f1247fc@linaro.org>
References: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
In-Reply-To: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6250;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=9LulKG3vhMeGfDftVpCBCYbqLXbnan4MI4jXgUc1m74=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoz69SvCxCYdYVKT2Cy84W5B1pE21Talb/YcK3/MEZlx4
 vsUo1LrjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRnFCGfxZKTj6PXRSy5Df4
 F9er14oFd7Kf71gw9UtERO53+b0ZtQz/rKZv1Fn/KHBi0Bfbns5Gs+i4nw8SPj96P/PQokcVKoz
 X9AA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Casey Connolly <casey.connolly@linaro.org>

Update the build docs to describe building the u-boot.mbn target
explicitly for some boards. Additionally add a new "signing" page to
describe the purpose of mkmbn and the MBN format.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 doc/board/qualcomm/index.rst   |  1 +
 doc/board/qualcomm/rb3gen2.rst | 25 ++++++++++++------------
 doc/board/qualcomm/rdp.rst     |  3 ++-
 doc/board/qualcomm/signing.rst | 43 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index ccf834208e93..f8284beceeae 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -12,4 +12,5 @@ Qualcomm
    board
    phones
    debugging
    rdp
+   signing
diff --git a/doc/board/qualcomm/rb3gen2.rst b/doc/board/qualcomm/rb3gen2.rst
index 4240606224f5..eccc27559d0b 100644
--- a/doc/board/qualcomm/rb3gen2.rst
+++ b/doc/board/qualcomm/rb3gen2.rst
@@ -19,32 +19,31 @@ First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``qcm6490``::
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
   $ make qcm6490_defconfig
   $ make -j8
 
-This will build ``u-boot.elf`` in the configured output directory.
+This will build ``u-boot.mbn`` in the configured output directory.
 
 Although the RB3 Gen 2 does not have secure boot set up by default,
-the firmware still expects firmware ELF images to be "signed". The signature
-does not provide any security in this case, but it provides the firmware with
-some required metadata.
-
-To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
-
-  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
+the firmware still expects firmware ELF images to be "signed". This is handled automatically with mkmbn,
+explained in :doc:`signing`.
 
 Then install the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
 on your device with ``fastboot flash uefi_a u-boot.mbn``.
 
 U-Boot should be running after a reboot (``fastboot reboot``).
 
-Note that fastboot is not yet supported in U-Boot on this board, as a result,
-to flash back the original firmware, or new versoins of the U-Boot, EDL mode
-must be used. This can be accessed by pressing the EDL mode button as described
-in the Qualcomm Linux documentation. A tool like bkerler's `edl`_ can be used
-for flashing with the firehose loader binary appropriate for the board.
+Note that fastboot is not yet supported in U-Boot on this board, as a result, to flash
+back the original firmware, or new versoins of the U-Boot, EDL mode must be used. This
+can be accessed by holding the EDL button while powering on as described in the
+Qualcomm Linux documentation.
+
+A tool like bkerler's `edl`_ can be used for flashing with the firehose loader from the `RB3 Gen 2 bootbinaries`. ::
+
+  $ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
 
 .. _qtestsign: https://github.com/msm8916-mainline/qtestsign
 .. _edl: https://github.com/bkerler/edl
+.. _RB3 Gen 2 bootbinaries: https://artifacts.codelinaro.org/artifactory/qli-ci/software/chip/qualcomm_linux-spf-1-0/qualcomm-linux-spf-1-0_test_device_public/r1.0_00039.2/QCM6490.LE.1.0/common/build/ufs/bin/QCM6490_bootbinaries.zip
 
 Usage
 -----
 
diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57ce..29a654d064e1 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -18,9 +18,10 @@ First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``IPQ9574``::
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
   $ make qcom_ipq9574_mmc_defconfig
   $ make -j8
 
-This will build ``u-boot.elf`` in the configured output directory.
+This will build the signed ``u-boot.mbn`` in the configured output directory. More information
+about image signing can be found in :doc:`signing`.
 
 The firmware expects the ELF images to be in MBN format. The `elftombn.py` tool
 can be used to convert the ELF images to MBN format.
 
diff --git a/doc/board/qualcomm/signing.rst b/doc/board/qualcomm/signing.rst
new file mode 100644
index 000000000000..00161eb1018f
--- /dev/null
+++ b/doc/board/qualcomm/signing.rst
@@ -0,0 +1,43 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Casey Connolly <casey.connolly@linaro.org>
+
+Qualcomm Image Signing
+======================
+
+On some boards like the RB3 Gen 2 and IPQ5xxx dev boards where U-Boot runs as the first
+stage bootloader, it must be in a Qualcomm specific signed ELF format called ``mbn``.
+
+For most boards this is handled automatically with the ``mkmbn`` tool in the U-Boot
+build system. If you're bringing up a new platform which will run U-Boot as the first
+stage bootloader, you may need to add your board and platform compatible string and
+the load address used by your board to the ``boards`` table in ``tools/qcom/mkmbn/mkmbn.py``.
+
+For example:
+
+.. code-block:: python
+
+	boards: dict[bytes, int] = {
+		# Exact matches for boards, these are preferred
+		# Don't forget the null terminator!
+		b"qcom,qcs6490-rb3gen2\0": MbnData(0x9FC00000, 6, SwId.aboot),
+	...
+	}
+
+
+When you run make to build the ``u-boot.mbn`` target, ``mkmbn`` will inspect the DTB in your
+U-Boot image and try to match the compatible to the table, then it will build an ELF image and
+hash/sign it per the MBN spec.
+
+Build system
+------------
+
+The ``mkmbn`` tool is executed automatically at the end of the build process by binman (see
+``tools/binman/binman.rst`` for more information on binman). Binman is typically configured
+by a node in the board's devicetree, however these nodes are not part of the upstream DT
+schema, we instead use a custom devicetree file (``arch/arm/dts/qcom-binman.dts``) to tell
+binman to build the MBN image.
+
+Internally binman will invoke ``tools/binman/etype/u_boot_mbn.py`` which will call into the
+``tools/binman/btool/mkmbn.py`` "btool" to finally run ``mkmbn`` which then inspects
+the U-Boot binary to determine which DT is in use and uses an internal lookup table (described
+above) to determine the load address and MBN version to use.

-- 
2.50.1

