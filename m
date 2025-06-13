Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102A6C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 17:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1842482E5A;
	Fri, 13 Jun 2025 19:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d29+7CQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7823082CE7; Fri, 13 Jun 2025 19:23:27 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E6282F7F
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 19:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso19430755e9.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749835404; x=1750440204; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rgv7OiDmK80BFWrWMm4cT1Fh4yqVyXA04WlKo50qBQQ=;
 b=d29+7CQwF/b4aHAl943tNgPK5eHf73vVYPcYpl1aMxmib7gs+u4WXcP0vyJA+4jW1K
 R5zQ+EeJlunWp1wc7PlNDDe4r9BWBJ2MUeF+eiKlgYHLyjkGWEQG+ZyNwYepBZzChMqg
 yOAEjjn6+S7fXFqFRrF7kyYFNaxpyrqho4Dt+sa2BLTVrblfv6iH+OJbNbWm/hY2BqPT
 TMjeKAy0N0VTMmQqo7zEcVH526ZgjnFiP+tgoriC6cq5pCu3ihNAIgG4Z+z4jXci8pjy
 hoFvph5D/qYudxzgX3eOPNxs+UqRMklFJTPFAiDcAVmplZ7Sq6d84doBxDqvujsyUeo4
 G9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749835404; x=1750440204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rgv7OiDmK80BFWrWMm4cT1Fh4yqVyXA04WlKo50qBQQ=;
 b=pL5GbnMbUX2hAydtY5BOxO8y5Gn6PdmmgMaCtWwG5hpMYGfHF97LAbcr/KVkB9mXu5
 77XuWC4whUM/X3O3zt+4/cZ+VPh8qsZc87TkjbElZDN9LeGNHDEQt9XcRqSRU1j439yA
 F0yxOEY14r+MUlQjAa/Fiu6kisA+x8LWJMspVukTL7qHD4L85lOZjltuip4RXrTYgdrl
 uw3kOveEezfXV+4wZqgCmgctjKeV0kP0diMRq98l7nJqTpplSZ8v8rSLj91lnrlBymSE
 YelLqeW6KzKeMZcLYwoTjo6v6/qPYAszdMXbdnSSk5oD6Sqc7vg+c/4aoW7LJ1n7x4hy
 QR0Q==
X-Gm-Message-State: AOJu0Yz4+HN2Rfj/Ae8BuphKYWT7pEI5VL+TG4BUFYzj6YjtXdqaPH5J
 bAKraSxdAS657+hVKdlnnwLrMMD9Nc5ojZRusGRji3Qo4vvc+LPMe0m4AQ19vuW5b+U=
X-Gm-Gg: ASbGncuuPpa27PkWW+OqrPEK1ADPFJOwzNEs4Lo3/aZs5tTG3zxjp0hsdnql9sBfqsb
 DJKrs9FMBdxZ05jdcHOal0APR9PyB9gweLRuSayO6O0FKWDu2ZzT95yj2ba3miFPAsp0soVvOgE
 bKZhfBu+UP95GYqcUjSLpzrYVRog1VZQqWeoSS4x1YjTpvRmwysdzXOTaoGITyFvAwrs21c7Eaj
 WQknpcGZvnIq5gFxEbt8D4gnrBTFl/eKmeV+RUiBtaeSH1ctSNxfhdr9b8ZAgwsk0+YAaer27m6
 fKcPoW34zVRAYCrXJHIy8vEREAUYzs3fw9Z1GXd4m74npSSeRGt8l5xU9Xd+LE8UJVhJ
X-Google-Smtp-Source: AGHT+IEu3TZOkqZ5k8zjvsuaqdoHLFeFQ0PxsVSnxSLdg0X9++ChiaE8I0msgQXv+8rvWILEeXJeKw==
X-Received: by 2002:a05:600c:5026:b0:43d:9f2:6274 with SMTP id
 5b1f17b1804b1-4533ca7790fmr5804895e9.14.1749835404093; 
 Fri, 13 Jun 2025 10:23:24 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c50esm57895015e9.4.2025.06.13.10.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 10:23:23 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 19:23:12 +0200
Subject: [PATCH v4 8/8] doc: board/qualcomm: update docs for new u-boot.mbn
 target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-b4-qcom-tooling-improvements-v4-8-7ea1c68779fa@linaro.org>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
In-Reply-To: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
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
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTF57TOa9NT37GDt/LG1YUQCEnbzKNADN4yJYZ
 iWU9WrP7uiJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExeewAKCRAFgzErGV9k
 tv17D/wJrQvCvzB4Wd4fRJstzA3YLhX3cTi2e0jG6GV911mn7qXdWG4L9laR2LLZ+njjHeP7taN
 VZfHbBiQFR9izGNvcdc3LgfYRkqMa0+fKXN9Acn84dRkvFeFOuQMriKyfd7B5RyOuKeLsySgu44
 saFu8lLCibf4ux9KkudfTCy2r6T7V+wOwkI6y2+HXUNCYX9bwe6BQvkn8naBHTomcgE7ge2RGgx
 cPnKH5oOkn2tcriQ18DE2oq+ZWteckb4lPDa7djfnYP/tJydxj1BXkNzgE2ex2T3kk6h/gHlxem
 98rCtd6Kp91LwUzBUh5dPDHq+pwO7sMbkBsb5u0Lo7O6rKauuPAXxAvtG+BM7mfc5hNsJkBVYXF
 RHAlIW/Xpo4smGtKJy8Oq23Q3lorAhg6Q7XjCWIQ1rPf2p+U//snTDDLgM4gYw6A8PxLiYWpsL0
 0ei62XiUlJGJG6IaWDiYYWHNHkJvVJfJmRkRETdIiNlaYCS/hoZtdaHgGd+UBuS5D2yoF68NdGs
 Ww1YlExLZaqtlnn3rf9/aRmEXkXZ8vPI4Ja/kzHef3Z5392nsB2wWWyhvDK7TekxcRfLJeorpjI
 CpDXtqzBWKv16SUBt2UB7FMxDgD3tRpPn1J+IMLAg45jrk138jtLYfRRqvlfk1lLNp3PdJ2bAyS
 Gp6xCE7J/opXb0A==
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

