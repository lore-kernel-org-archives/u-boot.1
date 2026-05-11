Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664D9CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493D584666;
	Mon, 11 May 2026 15:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gQdrNPCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1868341A; Mon, 11 May 2026 15:58:04 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B5018460E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67f94c078e8so2034513a12.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778507877; x=1779112677; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FJHuu1XxfN6MORgVyQF878imY+UUFHkuoVcGRAp3pRU=;
 b=gQdrNPCRcH7JQQZV7nMWn3ZBSO11J0V3Z1Ht7PQpWBidnRDtrviW4NUNMFHulnnstD
 sfBLhDRoyYS0J+TFC3pOwk84kDHXkqAXfsuMLMofLDSJ2/9ROjlOuljlfNPHIufhfXep
 1m7R+aqWfg3rC38l3EsWqn6QNHBIe7m91vuo2jAnZ28ro+LGEiuFiMK7VVPcj76kbx8Z
 R8ISmXJ7U4INZ3uUOlTYaItPlDGKPjltZDVxXyYUeYTHXo+YWyaIc3Kp2Q5AHJ+sqGG2
 2OtJFjRr+o3Qj6VvXQzYviTpSl4wTLhxc87ZdYjOhMTTCxXs5eXrlTELzB89hFkMpT3k
 HE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507877; x=1779112677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FJHuu1XxfN6MORgVyQF878imY+UUFHkuoVcGRAp3pRU=;
 b=qQZjCxSxV48gyABieSor4BNB3G/dhoNCNvVeDTSdg5KNRvOjgZY2OUDsufItnAFsFe
 iNF2fR8jvZeshOrvqV8mKv6KpjmuKM86ztE+EIQONNlYevMSuN9aKGM506uYS8YrAdVJ
 HcpThDDPjvzLkpq2RKnZILQkD6lezKfd48z7YGKqB609TFOyScfjLeENU0c385KAgk6G
 sgfQ9j/djRrqHdQdam2vv+PYvjfO43Y4jgT+38tsWYgsSiH3Za4NUVtYxh8AOac6qRTv
 K1WZX2ha36N4PO+0QEjtdPEmB56X8cShAHWs5tK2jQVmrPofFKcIdWSlmXq2np3HEFge
 JCbg==
X-Gm-Message-State: AOJu0YxUL+YF4C4wdHRlhOfrpgNRkZbSS4HXB5yJqU7JAL6PL5VIkhlA
 YN341ui3pCxLttci0w/Zf6gmME0af+ZezdHPUJ3ZKczRHucPexvrf3KXTzgm9NxUKC0=
X-Gm-Gg: Acq92OG8RpEkvbbYb9H0XCQuk3/wYWnwnQ53cHgjFRt3xuea8ZdcICbamxfe+QrHjXP
 wy0WLziC6VMbgSG9U2QTGgbei+sxqdDXUkSotXLHVqjdcVqt3kLoo2IXHyPAOSUCUVLMEGJ2vDb
 8qdQ/h9fXBSKQNzIW2l+21Z2TqcvIqgQVdHg4/8UJZCSNOBUlY4mrQlivNnxrl524dc5DlbyH25
 vtS2thNgvTkdG6RgjHYmgzI29WTxu9lvByVsboQIU+yB9hpqCANaniUJa0hIBTViTrTNhC+q9/0
 jCyfaY4yCeU/ZYWoP/HHZHUk4XyTP/q2A89oR+Q7sNQtfUk0hAmMwLZEatp1F8Kh7Leg0aKxq5N
 NLxP0+znQ7wMayG2zwZkn+NYpDm01M7I2aC7HOorbpThWZeAVc4XKvPzIcRn+0IunQA0o30X5Ji
 hYGSzBr9zOIv/RCPv9t1tl8Alulsy22LClL091t9IOVIXdyWb3wEYcmx+heZqam/hnWt7n
X-Received: by 2002:a05:6402:e94:b0:671:8ba1:e8ab with SMTP id
 4fb4d7f45d1cf-67d63d7ef4amr11563740a12.1.1778507876801; 
 Mon, 11 May 2026 06:57:56 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0dfd34fsm3805377a12.14.2026.05.11.06.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:57:55 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 11 May 2026 15:57:46 +0200
Subject: [PATCH v7 4/6] doc: board/qualcomm: update docs for new u-boot.mbn
 target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-b4-qcom-tooling-improvements-v7-4-0c06346e79a9@linaro.org>
References: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
In-Reply-To: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9936;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=V52Qxsep5TVNHlvClvURLGzNz6/LoZTBe/da6eGXP/0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizGB7EH75nPdp3lcfXi7Obe/Ob1k04auWwS0piRbrX18
 qVOu959HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiFlcYGfayVblJrEq0k/b6
 G+fBwfcrUIx93d8XE54+/Hak3n+75wGG/15BC2d7aWy0lhOxrb+5b9MH4z5uPj27ki3HdSbcD3t
 8WBwA
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
 doc/board/qualcomm/board.rst           |  2 +-
 doc/board/qualcomm/dragonboard410c.rst | 19 ++++++-------------
 doc/board/qualcomm/dragonwing.rst      | 14 ++++----------
 doc/board/qualcomm/index.rst           |  1 +
 doc/board/qualcomm/rb3gen2.rst         | 30 ++++++++++++++----------------
 doc/board/qualcomm/rdp.rst             |  5 +++--
 doc/board/qualcomm/signing.rst         | 29 +++++++++++++++++++++++++++++
 7 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
index eb800f8c535a..18119cec5b13 100644
--- a/doc/board/qualcomm/board.rst
+++ b/doc/board/qualcomm/board.rst
@@ -103,9 +103,9 @@ Use the following commands::
 	make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc)
 
 Or for db410c (and other boards not supported by the generic target)::
 
-	make CROSS_COMPILE=aarch64-linux-gnu- O=.output dragonboard410c_defconfig
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_dragonboard410c_defconfig
 	make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc)
 
 Or for smartphones::
 
diff --git a/doc/board/qualcomm/dragonboard410c.rst b/doc/board/qualcomm/dragonboard410c.rst
index 34629241110c..cc2d28e9dfda 100644
--- a/doc/board/qualcomm/dragonboard410c.rst
+++ b/doc/board/qualcomm/dragonboard410c.rst
@@ -20,28 +20,21 @@ Installation
 ------------
 First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``dragonboard410c``::
 
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
-  $ make dragonboard410c_defconfig
+  $ make qcom_dragonboard410c_defconfig
   $ make
 
-This will build ``u-boot.elf`` in the configured output directory.
+This will build ``u-boot.mbn`` in the configured output directory.
 
 Although the DragonBoard 410c does not have secure boot set up by default,
-the firmware still expects firmware ELF images to be "signed". The signature
-does not provide any security in this case, but it provides the firmware with
-some required metadata.
+the firmware still expects firmware ELF images to be "signed". This is
+handled automatically with mkmbn (see :doc:`signing` for more details).
 
-To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
-
-  $ ./qtestsign.py aboot u-boot.elf
-
-Then install the resulting ``u-boot-test-signed.mbn`` to the ``aboot`` partition
-on your device, e.g. with ``fastboot flash aboot u-boot-test-signed.mbn``.
+Then install the resulting ``u-boot.mbn`` to the ``aboot`` partition
+on your device, e.g. with ``fastboot flash aboot u-boot.mbn``.
 
 U-Boot should be running after a reboot (``fastboot reboot``).
 
-.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
-
 Usage
 -----
 Press Volume Down during boot to enter Fastboot mode.
diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
index d48994153095..028ec340d155 100644
--- a/doc/board/qualcomm/dragonwing.rst
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -19,20 +19,15 @@ Installation
 First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS615``, ``QCS8300`` or ``QCS9100``::
 
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
   $ make qcom_qcs8300_defconfig
-  $ make -j8 u-boot.mbn
+  $ make -j8
 
 Although the board does not have secure boot set up by default,
-the firmware still expects firmware ELF images to be "signed". The signature
-does not provide any security in this case, but it provides the firmware with
-some required metadata.
+the firmware still expects firmware ELF images to be "signed" in the MBN format.
+This is handled automatically with mkmbn (see :doc:`signing` for more details).
 
-To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
-
-  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
-
-Then flash the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
+Just flash the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
 on your device with ``fastboot flash uefi_a u-boot.mbn``.
 
 U-Boot should be running after a reboot (``fastboot reboot``).
 
@@ -43,7 +38,6 @@ A tool like bkerler's `edl`_ can be used for flashing with the firehose loader (
 the firehose loader can be obtained from `dragonwing IQ9 bootbinaries`.) ::
 
 $ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
 
-.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
 .. _edl: https://github.com/bkerler/edl
 .. _dragonwing IQ9 bootbinaries: https://artifacts.codelinaro.org/ui/native/qli-ci/flashable-binaries/qimpsdk/qcs9075-rb8-core-kit
diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 3238a68e859b..b7637b3c0439 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -13,4 +13,5 @@ Qualcomm
    rb3gen2
    iq8
    phones
    rdp
+   signing
diff --git a/doc/board/qualcomm/rb3gen2.rst b/doc/board/qualcomm/rb3gen2.rst
index 518d01c4c3a3..329baa8d1f3a 100644
--- a/doc/board/qualcomm/rb3gen2.rst
+++ b/doc/board/qualcomm/rb3gen2.rst
@@ -17,34 +17,32 @@ Installation
 First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``qcm6490``::
 
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
   $ make qcm6490_defconfig
-  $ make -j8
+  $ make -j8 DEVICE_TREE=qcom/qcs6490-rb3gen2
 
-This will build ``u-boot.elf`` in the configured output directory.
+This will build ``u-boot.mbn`` in the configured output directory.
 
-Although the RB3 Gen 2 does not have secure boot set up by default,
-the firmware still expects firmware ELF images to be "signed". The signature
-does not provide any security in this case, but it provides the firmware with
-some required metadata.
-
-To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
-
-  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
+Although the board does not have secure boot set up by default,
+the firmware still expects firmware ELF images to be "signed" in the MBN format.
+This is handled automatically with mkmbn (see :doc:`signing` for more details).
 
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
 
-.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
 .. _edl: https://github.com/bkerler/edl
+.. _RB3 Gen 2 bootbinaries: https://artifacts.codelinaro.org/artifactory/qli-ci/software/chip/qualcomm_linux-spf-1-0/qualcomm-linux-spf-1-0_test_device_public/r1.0_00039.2/QCM6490.LE.1.0/common/build/ufs/bin/QCM6490_bootbinaries.zip
 
 Usage
 -----
 
diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57ce..4e63fe624b8a 100644
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
index 000000000000..317cd57cefee
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
2.53.0

