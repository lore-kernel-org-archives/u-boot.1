Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5815C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C79E182CD2;
	Thu, 12 Jun 2025 16:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c947JEcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6CD682CD9; Thu, 12 Jun 2025 16:16:54 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7740982CD2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so713880f8f.2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749737811; x=1750342611; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rgv7OiDmK80BFWrWMm4cT1Fh4yqVyXA04WlKo50qBQQ=;
 b=c947JEcrgZnkqKGTUu1XWguJU8CikV7lX6GwovGW8tEkKMFq7SzT/HfJ4TiS83pBuj
 jo9Np1Ekv5ZnLlRJ9kWSh2i9GbgF/+9kazbvv5eYLHT7k76h8yIjFVrsGENl+k4e8lKM
 pf6BmWN347b9WQduT+MtkyrBiFjV48w7bfJ/7n0S/6+Pn/Z1nNDvMqL7iwTRS40Djs4H
 tERqkChBypC7LaRpUI3lquvjE6egn236FeKBoaeTB5gL7tZTqOFNNdXiH8UCMPaXAWZo
 5vPa/0VT06DJRoj48odfL4OehivJVZptcVbJtxV9BhLvllQLgQVNZmaV/twvMM8Ea2ej
 YtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749737811; x=1750342611;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rgv7OiDmK80BFWrWMm4cT1Fh4yqVyXA04WlKo50qBQQ=;
 b=Kn6RH6SbrWeqNV2vHSUj3X+F5Fpd/yy0qgpjwdATA6FdSARib9pa2kOx9cMbmTYFoN
 T4R4GA6sy6O10B8jYdbH8sJCbmmQNEx//TfVbNRYj7Fl6pRuhRFKShXA/1Xio9HHJzrP
 2dNfGHIIVgwgTnHkw+Wjt/Ii46JODnGrDftfZtyP16fxYsFMODsdNA/7Hxh2GTwtPXoa
 4ulJyetd5sfjEErkDyecdZemFiHIOdXjkY1P5kVsT2FuCXts266oGzxA0aQ+qdmFFdUq
 WkE6oFLD2juVcpzBatzO9KcIs3wxmhjRABpeWkmnGbcq10wXPYFr1CyffHeLxjpF1bjT
 /lMA==
X-Gm-Message-State: AOJu0Yw3shIj275iDUJU8p55cc2kiRwUY78pSSgffSFL3Sr5YiDXawSC
 ykHwOio2BnnpthqrSjhUElWjS7nhwpXBA+aRC0UhJuJOH8shKwSNS7f/6Ftqt6DnRYl8RohS26M
 jJ77I
X-Gm-Gg: ASbGncsNfe5XOvvuayCwaYqvs8AMjZfBnO/9s25EyQvzPYvAqmNOWX71/wU9Z7NMkkB
 M8jMWa0DJF4uhfWKClcUg8DENFijpO//g6VsP+TiMuo8UPJeIg3+zDGVybgLHAolsc4IoydweBt
 BkvROIz5+nJnniQMPlBK8CvpccL6RdeacoyyOy9kCuTYyTM8uGD60uhD1eoHbH93Y3snux6dfqK
 YpHUYbbIcHuuuBoSF9ZSsV4wdnoBNCmtjjNjTMDVzgJmqADzqZP/nIoupSW8kk6SW36tuhfSlLe
 1tR/8bDA4cahCLItV6MHmN/FzebqJp1Z8TwOGL67myi33Z00qq6VAPuEMR+tCWpLEudBvr1B
X-Google-Smtp-Source: AGHT+IFlEDmnjNsu1StkrU+OQ6Jhfio5NXvSo5H5j8qPcBapJHuarWRdiux/eKUXVjJOGlGbMwMYfA==
X-Received: by 2002:a05:6000:430e:b0:3a5:3b93:be4b with SMTP id
 ffacd0b85a97d-3a5606cb243mr3308688f8f.25.1749737811359; 
 Thu, 12 Jun 2025 07:16:51 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561b510dfsm2044006f8f.82.2025.06.12.07.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:16:50 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 12 Jun 2025 16:16:43 +0200
Subject: [PATCH v3 7/7] doc: board/qualcomm: update docs for new u-boot.mbn
 target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-b4-qcom-tooling-improvements-v3-7-76f34cf216e2@linaro.org>
References: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
In-Reply-To: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5758;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=51OuiCbMGcrrnhSPiF36vnO+5ITimLH+X4T6Q3WxZ+8=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSuFHORfEmpjRp5vtCjq82/PBl+r3hERRwCKZN
 wbk4oNVuNKJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaErhRwAKCRAFgzErGV9k
 tg3AD/9dGXybdTdj81M7ascHU7amz2VFXG/ZMUmFfbN8KZgt49jsR6l7zVWHBpJKx4LIKBb7NdZ
 FvkOqWGxqcv3AzYDEpWPCfamdB+Dc9dTEPGkMf17M2lEakyCCML7B7jKBoFVc5MnCFxfRz1qlP8
 GD8JPy83TUGHcl7JalcmoMOrOyclY/3pofCnYfSdNSvNN9mOdNE7mMZAL6wfPrO01hY/PbUbUqW
 b9lmhGxQD4XP/ElYbhEwcBiuFf4CkF6kbksgFbxiVqkExuXudoId5YBsy7UP+Z3GEOV4FTqt2Vv
 Am3eQELbfqU4baGwzQqZtDej9vMJnQVyYn4YXLzKyi/j2osMpUcjJcuYlLdi8j1Eo4+63sS7HVn
 6Z60yqTWJAG/5Td28QNHbXnttYbpD/htlhJ3fha6wt//Z8ZYTEdIiBuBEmZqmt97iraXScZR9f/
 eFpadbv0FlVRVXC6dF9S4F0mXLJS1fWZ+BQhaYQqflUPVjkizmmbMHZ7wwj1+GxhgcArwYPonAl
 ucWrl1QRtj/Fh+dtBqdpg/C+fsYsJKShbX3N7ToL9W+ZlD7TqW64T56iY5TKHuSUF+vujyqTYoY
 yL9xR6gs3du3B9sIpjY4AgAVH3bKfvLe7Td2HNn5rAF50XeCOrPTV/wAVRHyT5U0h7bR/Eyc2um
 0ex+wpELj7er4WA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Update the build docs to describe building the u-boot.mbn target
explicitly for some boards. Additionally add a new "signing" page to
describe the purpose of mkmbn and the MBN format.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 doc/board/qualcomm/index.rst   |  1 +
 doc/board/qualcomm/rb3gen2.rst | 27 +++++++++++++--------------
 doc/board/qualcomm/rdp.rst     |  5 +++--
 doc/board/qualcomm/signing.rst | 29 +++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index e2fcbfa19c2fff36c8551823ca4a53a5fdc7fa9a..0b24fb6691907ab6fcecc6ade55f363de44502a8 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -11,4 +11,5 @@ Qualcomm
    board
    phones
    debugging
    rdp
+   signing
diff --git a/doc/board/qualcomm/rb3gen2.rst b/doc/board/qualcomm/rb3gen2.rst
index 4240606224f5b36968277792dfd5dc93a762fdfa..79a57c689657719b61582fc33cd079f134cda054 100644
--- a/doc/board/qualcomm/rb3gen2.rst
+++ b/doc/board/qualcomm/rb3gen2.rst
@@ -17,34 +17,33 @@ Installation
 First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``qcm6490``::
 
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
   $ make qcm6490_defconfig
-  $ make -j8
+  $ make -j8 DEVICE_TREE=qcom/qcs6490-rb3gen2 u-boot.mbn
 
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
+the firmware still expects firmware ELF images to be "signed". More information can be
+found in :doc:`signing`.
 
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
index 99cf8eba57ce9fc8860ba112df274515f941b46d..4e63fe624b8a6156c0b12021b321db518d88c321 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -16,11 +16,12 @@ Installation
 First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``IPQ9574``::
 
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
   $ make qcom_ipq9574_mmc_defconfig
-  $ make -j8
+  $ make -j8 u-boot.mbn
 
-This will build ``u-boot.elf`` in the configured output directory.
+This will build the signed ``u-boot.mbn`` in the configured output directory. More information
+about image signing can be found in :doc:`signing`.
 
 The firmware expects the ELF images to be in MBN format. The `elftombn.py` tool
 can be used to convert the ELF images to MBN format.
 
diff --git a/doc/board/qualcomm/signing.rst b/doc/board/qualcomm/signing.rst
new file mode 100644
index 0000000000000000000000000000000000000000..317cd57cefeeb3b073ebec79286f00414d1da342
--- /dev/null
+++ b/doc/board/qualcomm/signing.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Casey Connolly <casey.connolly@linaro.org>
+
+Qualcomm Image Signing
+======================
+
+On some boards like the RB3 Gen 2 where U-Boot runs as the first stage bootloader,
+it must be in a Qualcomm specific signed ELF format called ``mbn``.
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

-- 
2.49.0

