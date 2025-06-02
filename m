Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B524C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F58E82A76;
	Mon,  2 Jun 2025 18:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vOJCfv6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6E582ADA; Mon,  2 Jun 2025 18:11:12 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 510FA82998
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so2666084f8f.0
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748880670; x=1749485470; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=INO6QTU+jiGEHlUzboHWZZdt6TwOlPxJc9gWJDR7daU=;
 b=vOJCfv6m8A+ykm2IJSSU3Vn5Cr8fnk1Zt5zVhQrnfMdTMkhoCtzvD0FAek/YKjFqQA
 yJBPd+wlavXl0EUt7kV7F7vFRTL5UTIvp5ct4VS2CZNZEHct3ZBhth/ObTrcHY3kbbWU
 eziTNTn8kh8iKJs8w7tACisRgL2PkXD2F15x7759zg+Pst/w/+e7BfE4TPL5RSBGOMaQ
 ESe0bhIyQJ/V8781a4MwLb7Vw/As2of2GEaJl0cPiUvpTlWQTZuZkGE6kxcYra6ByIAR
 rdwRAYgZGQZYNTtJl5MCW2qIbNuNX2rZIImtI6DzAYYwR35JAfg460LF6p+SLYDvG4cI
 7Zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748880670; x=1749485470;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INO6QTU+jiGEHlUzboHWZZdt6TwOlPxJc9gWJDR7daU=;
 b=twbX+dGjFepUg9a1npkCwJRew1HzkCwPNqLOMsDz0zpNDBFv2XikNQ+/OFtDE8xp5c
 9218h1VtdwgEioUbvoq1hDB5bInqoRgtMhJycwpiAA25SoDMkIBuYeKL4EcmZVlDzP6Q
 iuqEpVtLQtEc/cpygyhugGfpdpSSZqDBiUqkU0G2qwWM/Zmoalxhvkh3ZGtjq4mjCO8+
 emBp+61StqRZqdl8s0lXMxP7ZxC0Y/NbbASf29jBhZJ02sOm7LmEQxg5YZtiEPOdBHSR
 e17QLGC+pIkwRr+CJpk6zVDMbJ2TEHsq59J/+1QnEiiCiLR6FT9FVEw2/Z/8r/1NyMTf
 8HRg==
X-Gm-Message-State: AOJu0YzQJshZ1zcM4bGFOz6bb0o+gwJjIMnlxs6YiDQG8uBhH8kZtuGh
 poLcuU+9K6XZNcky32S+YQ+MY65pErh2TejN1hsLvOCQzmq4dTTYnn/LamrnXxoLqo0=
X-Gm-Gg: ASbGncvXSjFC7/Ps31gku2UXWKHVXu00cLxYC5KNkSjbKrll7qiSpSGnDGwdm8tyL5j
 V+/8iPs0G5jOwTPLPXaOJE05wtxMxksP+bY+oSElDwNb8TONs08G7X5zVGi5Kdcfd67zhIKnDCt
 4hyc9ZF/fzLKY8ifV7/xeReLYpY8VKa0alZ5jqM+IGF7+JlJyznmhut0tnbeJ72nMOo+lkmI6yv
 fv05rKuPIjzjnJXaL7tfIC4RQsSKyPgywN9d3VOao/kHRk4Gn1di7tU027Be7lESg7HsrlcP/ot
 hDVr8YKXmBK25NSw3mVfcKWM5KbWzzJsOINJye1MByC1bfK4BPDXLNpMMiPSzKZZjxu1xrUs5B4
 atSwaNwnZZVBm
X-Google-Smtp-Source: AGHT+IG7P4NdXYD9j5yfwI2qN+lQgByymFrat69ht2rfY5e3eysvNecpGm5/adBlsVt3qih26VYEnA==
X-Received: by 2002:a05:6000:2888:b0:3a4:ef2c:2e03 with SMTP id
 ffacd0b85a97d-3a4f7a368b4mr11507547f8f.33.1748880669633; 
 Mon, 02 Jun 2025 09:11:09 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:3688:a9e2:523f:a049])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b962sm15212138f8f.7.2025.06.02.09.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 09:11:08 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 02 Jun 2025 18:10:58 +0200
Subject: [PATCH v2 7/7] doc: board/qualcomm: update docs for new u-boot.mbn
 target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-qcom-tooling-improvements-v2-7-c7d19c0d4a8b@linaro.org>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
In-Reply-To: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6344;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=aHCc/F3jsoMEVHh2uSzox10AfM2zG19dgcJkSvh93DU=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoPc0SmKLRcCmDbekf4RUtEQapYitmRzFATrwvN
 P9huM477/iJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaD3NEgAKCRAFgzErGV9k
 tqZKD/42Q+EFgQZAjrmUtz2i7u9dmScf0hThUsQjRYZXs4hPhQOaVsu4X0nsvh2x+2csJLQjHxB
 7ua0aVU1pZKwWyAqkH8C7QAXwGZAzojvEv/toTTp4C+5Og5SwzXMNb9ub3+ZIKfgcy2HJL3judx
 OkR6OXXWlhp5JLT1ipVLNhKo/6Pvsxc/mW8t44sJkSoZkvNDDDcNSLU1lXmrjnx4UVnYw+z76Pg
 1RfLBnUYrARAkO2K4xbdSaA1iOO8iDc6ewHcWQD6VFmgmZ8Gb6FPStv1iPr8fc6u1Bp4luP9klM
 9IrD7sW/I33zQdUGZrHsXqVzhHv43tSDmV6hfsUZKdAeH8M2X6WpzJTIFUrmVK7k6Fro2gKMuwT
 cmrk021oHeFlmz3PoH3+patatCmnUA/mT2cn7uqxetdYr5460tJQQkGPvQt8rqRx/HRhKn4nw6B
 0ZAGWsebB51licyo/TwTWjvwQ/OREKU9Pl+N0FpFmoeNTWmYQ8ArHSxTYmcbiUaCo3iL6a4OMS2
 3kOPB4Kvyb5luLhys8CJCBpfE2T/bG3hHKUuwKR21IMaLFZPG3GmD3iDSWmUApjUS4C6Q9YGobO
 cbxPhzMVOnyOcA10iRh2Z+1Y2UfvxMu5quHCjPp0bSDd6d9RpEzeNWw3cEFBNRYE2RCCZd7f79y
 wLw+J7bKiG1IWzQ==
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

