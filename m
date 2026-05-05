Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA540FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6EC1848CE;
	Tue,  5 May 2026 17:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SQgnRpN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E8F84994; Tue,  5 May 2026 17:48:57 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1C4084951
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 17:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so52485615e9.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777996134; x=1778600934; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lzWadQb21A++i7EkdA5OrftUFXP1i94lh/s73J01ZkM=;
 b=SQgnRpN3u8T5UTDGAVY6hovqyH3xDmceOTfNbPqkzveEjiEqQMM2kvqH74cWSwr3gA
 DHbvMT+6xoJHD8dVfxanvdnHFrImPYBXMifbl1qx8muZtf3gOXAhf4sfhTnWY/dSP8d9
 uhaqANEpCoU0m9pwpqJ+vL7STv8LunQcOya5o/9CnU06GIGNX/98i4c/pkhEMtoYP5He
 ryQWqAW0QdMyjm+bFa+mnkmNbXsPY1AN3YqkzFZ35ZW3caMX/pzXZAVU8DwdusYsqCCx
 WXEFAWApu/kpmTeM7odJCIm8VIaUN/SgQVEiq4RxaLbi3ppU5aS8pgpzuv7kkQa6mGgt
 tBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777996134; x=1778600934;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lzWadQb21A++i7EkdA5OrftUFXP1i94lh/s73J01ZkM=;
 b=YkQ8Mi3PG6uaLJOCAEmo2Ty/Jq0zQr2Smaj6JoSNi8WgrsA+uF3hgdzHsx+HkDm0A5
 B31hc47MODhEA1Ao5Y8r5+sqPhO3cGzcce1ASVP5hDDL3gtAdZuQ7YRIVQoTTnwDCiNM
 hpUhZdf48BKrLVn+9BTB+fAQq8pD4V1mXDvfgQTc/F78z3XSuDxhLKmwzpBnRX830JQd
 l3P82fcwM9WYLsDvSQaoA7/7TQQXE7cn6ZPOoQbs1sLNoLqKelMY5yXnv7jFtJVdLjfJ
 yS8dVd1KKPLk3Zcoasjo8xb2+dtGnQg2rb082USjx50msXYHuYgH3Nfs9bWCwLBQA+W2
 yNRw==
X-Gm-Message-State: AOJu0YweW9ZBaLIGNQ0k8C79rg2fvudtY4ry7D/3uY69IfVjEA0x7rG2
 0xeEQ+DoaACgDK2h2r3lFja5L4Ykae+S/Vwss/EK+qY4ymZLru/4Lqh1z8AAv9OZbP8=
X-Gm-Gg: AeBDietrX4rWe/I6S0AzHc9zU+PGjC6vhEGvPiAinf1Q5gNyA4E5yFlvrg6gnjsY7qP
 i7FxFhkP6e8DniwFgtRfN4eY7zQG7b0yZnkecLsXeGmfbFagtrpQ6d4vY3uiIhyBtCiUeUXSEw3
 ggwMudZKJaZ7zt7GkkJbkCaBeZsvKoEsmbZ+xk/B9aJN3zKUypVKHSSdD+H4Ye4cHsXMegEtX4a
 JdXHrsuES22i4h7Wk1Q7TrAMfsbdccSmTX01LSDWDxxcNp9o8QJAS5y3MCYTd5QucNR6uhUtEPq
 5rj6oujLXEGWT3iCtv4QMa7G5DGnjtQXa2DcRIPSKNgdfBgx1s2WUg+jn5KRpkMKm518yvizLjW
 Q5klVztXcAoW7RE9EkOCey6lRM75NN3AC9YZHOIssS1Shtdh3MMUnD4B8ozYhg+qWZ39tuxIHL9
 Y+n+v5rkn6denSZPNOwW1iOrPlaeVPQY2H+VC6UWdpAveMABnXQRd56Kt0dl1GKNzhGRBq62gb/
 gzG5qo=
X-Received: by 2002:a05:600c:8907:b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-48d18cfe207mr45809955e9.29.1777996134193; 
 Tue, 05 May 2026 08:48:54 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d182ee923sm20305955e9.27.2026.05.05.08.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 08:48:52 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 05 May 2026 17:48:44 +0200
Subject: [PATCH v6 4/6] doc: board/qualcomm: update docs for new u-boot.mbn
 target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-b4-qcom-tooling-improvements-v6-4-a5fb673f4af6@linaro.org>
References: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
In-Reply-To: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7490;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=FkuB4/AyXxwek3gq8MkKF4q+Zmv9ETHEGEa+/MeHAgM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsxfgrEiHJZx+2bd8eD3939/69jZLlHRQ7MFz87/2nGqc
 cmJ3r0/OkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEYmQZGbZ812PecHyGlti5
 21d67j9552ZheUEwYN6SNcYTbGepb7vDyLCjlTNsKf9kaSmtp9Mdl7caXdCuffT3gJRB3j/FHX5
 xe4IA
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
 doc/board/qualcomm/dragonwing.rst | 14 ++++----------
 doc/board/qualcomm/index.rst      |  1 +
 doc/board/qualcomm/rb3gen2.rst    | 30 ++++++++++++++----------------
 doc/board/qualcomm/rdp.rst        |  5 +++--
 doc/board/qualcomm/signing.rst    | 29 +++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 28 deletions(-)

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

