Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD4FC54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 20:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732ED83189;
	Thu, 22 May 2025 22:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t1Lrtmi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B63F83192; Thu, 22 May 2025 22:40:02 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D912883108
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 22:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso66165835e9.2
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747946399; x=1748551199; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=62SXSGQT1Sf/CtjV1yF6LHqnd+PX62SGrr6E9V9a9FU=;
 b=t1Lrtmi9MW4HKqIeYXAVPNiZ+aBrQIT3ZO+KzKUtNBMS+kHUuyJKODmqtfGV8QGE8g
 uMdVQ4cH7cgvIqXl9MqDXX1X1cWeaBW3lb+M/LGA6sWr6lwoylrBt2HyupbcZkox6tod
 9sztRax0K6LWutl462URFD8pDXW4M/pi3+6CrAWG0lzPnEMBLFLVvXkiB4fGNx17gsX9
 K7HeAyHMjr56hVabX2mhMocBqLy7hILWRabwIAGjEPJjsXtOr1Xhr7LYw/PTPUSsLRJ2
 RArK63y5OEtWHcAmYx/2k1q/rS2L1RYHZUkhF1U8xWZtqCUTL3x83S/avnIgkVh9zlt/
 ONJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747946399; x=1748551199;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62SXSGQT1Sf/CtjV1yF6LHqnd+PX62SGrr6E9V9a9FU=;
 b=JHZt4H/vMSASauTjDBmNP4qXxJuaIRBPLP3HiEXzb6+w3Q4DQ4ZDWX5skYJmdkcr3e
 +9+ni9J9a8LGinYhtRAwHY+cT5nlrxm0FZj4cIdt2n1xfGkKHK1HJH3es91FgGidnnN7
 xCpfcuoVkpW0ixBqqrt8HnCXnrnZEbYJDs7tiTc81LNyheADs64dEuE3aA1DALGi239R
 Cnl4h4rm7xIwiJrUF718zYpWk+Q0KE7IFtcjYjURyhATtkI8uyWhkqlKBciwjnS+wWfR
 oT2l3poCbq7aN4fomXDWhRLJdZYGgHxM1X1jZbLQsqcsBL0GSAIoV6IP7TptnzwHHELX
 RKpg==
X-Gm-Message-State: AOJu0YwGmOx+LPhtEG9wzVzsKp0pJJcBXqAX8sZjyP0XYGe49U/2vNsv
 5l8B9piFzNwlCkQF+jrS1Aqt11jguw1+Ep15IZzYgehB37zLx7fk/MQI/IflMsJVhAw=
X-Gm-Gg: ASbGnct6TIy0FAnJ1CPJYwzJnmAjEZ5k62lAjfRUal/ZBkk/e+TQZyR+wZR5vdP/sDD
 cJR3hwnAIwcPrr6MOHHeNk2M0MsU97AbUsKc/w/rgBE+sl9xVruZ6WyNpHCbra9KbGZ3e0L2WWP
 fjEpo0TSInEeihxrxEk0FGfrTHmknnWZviNTAS7Pf8F7gK4DwEDitY/IvguVRbukSWpIJL3911u
 onpr3ZkFNnVNyo5HNlOWO9I8wU1LKic4QBBA58ciUxa25XgrfiNhnH2GDx2MeMf6bPYjykJsTQ/
 NmA2p9Dlc/VFurBv9Dhhhs4O+fWln497hMhwBzNtRZP03d0R0bj/timNWvXnbyeefI2BZza8tCE
 K85lRH1TJ4qfzSZlVbb8NZrcmxJ0u
X-Google-Smtp-Source: AGHT+IE9h7wVi0WG+bc4MKkExUKmviw8GJdsulxmRcLKHMK6ssjQvnvCrCgalevsFhrhxGtGZj/GaA==
X-Received: by 2002:a05:600c:a402:b0:444:c28f:e81a with SMTP id
 5b1f17b1804b1-444c28fea0amr172173845e9.27.1747946399203; 
 Thu, 22 May 2025 13:39:59 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863A39.versanet.de. [94.134.58.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f05581sm117304575e9.13.2025.05.22.13.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 13:39:58 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 22 May 2025 22:39:43 +0200
Subject: [PATCH 5/5] doc: board/qualcomm: update docs for new u-boot.mbn target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-b4-qcom-tooling-improvements-v1-5-8141b8955cfb@linaro.org>
References: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
In-Reply-To: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6320;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=rzmiumSurAHEDa9aarglhLyXk4Wh3vUTU5Bya2U6BcI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoL4uWOlmvjczuZg0GqB1TkI/60jq4oEa/FwsxS
 O4uB0vXEruJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaC+LlgAKCRAFgzErGV9k
 tozwD/4iYDKzO+37D99ShsAVHLFUKEL05NYVmiYVSWTyL+yUX6QT51zb7WdvbKMeJnlOebjR0km
 Kqo9DjB8ugFHv+SFUvx0INhrPg48fPb1NFNiOhpHrFXzoMCV4/N0qUaiKqjtwQebX+W3t77oEje
 RvHv1ZAOJrb0hJTFmxL9viHm4l/wY7P+YO2XUQY725FhYL/ISIf+ad3FOIY4sf5DVfDq2NuRZCy
 JxLVS8z4M4pEz7VXS8sRkLfQKEmWwZ+KElNE9HwQy3tSucYccIYEtR30B4C5ku6h7VOSPPCiOG+
 cbf1RAQiPt/X3T++RrPnRhlDU0nbFsWyKziqUwTHRrPL0roiH4JPh/k0TmpsgSVbbCutSD1hVVt
 njEcP0AsQ16CqiKpRy5XNBdRPlgiGn/42EOwKOcu6MdSHAXgDsJbJNjqLxN2E6O9ZByHsJWnOQy
 K7ZSFlo648BqmepsqO2Bt3WmUaUMws76wQFVlfbEt7RZitS/YXE0P3JAbNsGpT2zJVB7SbZ6577
 Am7CMhVzWz5aT6l1mdPG0alkWLJWeLuSW7ECsbKQ1BYhbJ4HUEVtaC4w5wEzew2ciyHyBjlmKNq
 EtrBf7gJu9XlTJzTo9pwNirtFn7R25Zh4TqL8o8Eko1NzTUB89SScf7FEpcdTDERtDtQspv5rP3
 oN5xCYHJeFJVtag==
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
 doc/board/qualcomm/rdp.rst     | 16 ++++------------
 doc/board/qualcomm/signing.rst | 29 +++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+), 26 deletions(-)

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
index fd14f1d9829dfaea4a7b503c1f60de8441f362e5..51f8d5772d054f791274f494ba3b7b0e1b691706 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -16,22 +16,14 @@ Installation
 First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``IPQ9574``::
 
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
   $ make qcom_ipq9574_mmc_defconfig
-  $ make -j8
+  $ make -j8 u-boot.mbn
 
-This will build ``u-boot.elf`` in the configured output directory.
+This will build the signed ``u-boot.mbn`` in the configured output directory. More information
+about image signing can be found in :doc:`signing`.
 
-Although the RDPs do not have secure boot set up by default, the firmware still
-expects firmware ELF images to be "signed". The signature does not provide any
-security in this case, but it provides the firmware with some required metadata.
-
-To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
-
-  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
-
-Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
-on your device with::
+Then install the image to the ``0:APPSBL`` partition on your device with::
 
   IPQ9574# tftpboot path/to/u-boot.mbn
   IPQ9574# mmc part (note down the start & end block no.s of '0:APPSBL' partition)
   IPQ9574# mmc erase <start blk no> <count>
diff --git a/doc/board/qualcomm/signing.rst b/doc/board/qualcomm/signing.rst
new file mode 100644
index 0000000000000000000000000000000000000000..443d6433d8fc66bcb4c9e6c0e7bc3e6dbe508bb0
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
+		b"qcom,qcs6490-rb3gen2\0": 0x9FC00000,
+	...
+	}
+
+
+When you run make to build the ``u-boot.mbn`` target, ``mkmbn`` will inspect the DTB in your
+U-Boot image and try to match the compatible to the table, then it will build an ELF image and
+hash/sign it per the MBN spec.

-- 
2.49.0

