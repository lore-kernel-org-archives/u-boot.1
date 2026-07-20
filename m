Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951BEC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 12:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B9DC849BC;
	Mon, 20 Jul 2026 14:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="Vc0tnOCW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4102F80517; Mon, 20 Jul 2026 11:53:09 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0558483E76
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=william.bright@imd-tec.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so9012762f8f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 02:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1784541186; x=1785145986; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oGR9O9HGi5wLKpcGwwa3Z4c44/JaUSf8+vMKcR9QYnk=;
 b=Vc0tnOCWO0fzpVENhzL8ohviOKXXQCoJsTcOI1uC8xW7lTzUNlhhHDtIS93pKiW/pW
 NqnuFJYINRNxdIyhbghmTI1egaVOL268RkYGrnIwAHPdZYKNG5JdbAROgLUzZzdNlMBu
 J/oYtIPBJJoSVeSaiyiBR+SmrjxgINLtLwt9Xvc+EseTc2nygwkwaPcPlOB58KeFOIkP
 A8YZ1dOu2atMLePoguQMaIE7ZPD1nKfiemW2p5Y3nhKU1cey9fToXy8yOMyr6/zZBI6q
 tWxBdl75rOu3ns0s9H01Kl+JCcR73+L093B01MF4f1Q+rmsj4eiBYXf+C1trpFKYQCsP
 iIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784541186; x=1785145986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oGR9O9HGi5wLKpcGwwa3Z4c44/JaUSf8+vMKcR9QYnk=;
 b=pIKgr+hSWp+Nfc+uiJXRbT1iHA2WiqGkIKeXCJacvQ6Ck/ZOyT6YPt/2hrhjehJP9B
 uVluh+Obc1fnXxhYZ7N2AgqEWMttUZYMBOyJpjp+g/YAqDagMTricEWzHABFgT/qtN1G
 AMhVLdNvjirdNqcb+AL/XpwIS8eCM/B8DzA7zn6Ei2L2m2WqD+/Ew+yZ2WN6OBV1x304
 V8HcKtWtH8BAV2HYg5v7Vg9vtJ8HVB19Oq+veztwV2X//B6y2dZ3kcxeS6bi1VVUObnb
 PHH1tbgNXdMMocapCyS76Xnm2aZ4pxCvRcI02AjQdOfvvmgKMVnhaqY28YheZqvJc6pt
 +3kA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXzkwzh5qANgs4PuMlIfxC6ksIr9M5joGITkkYplxIsQk60AdqEfG9WjdR1ayZRZy8U8tlHAM=@lists.denx.de
X-Gm-Message-State: AOJu0YxLftaVfL/PQQlGqAiF5/UKpnogF7APQAumaB4+nPPCteJf86f6
 0uipTCgIc44yo2v0MUJZEYHu48NieEJFc1O78k/Dr0Z6iBsXH4RUodCru4GGByK3gpOSJq7AQkh
 u+BxnjLg=
X-Gm-Gg: AfdE7cn2WWlDBxVBXFc+Gc+EiEfefqK2+YLgtTiNo8qeKkUE0EkQHcanE5xRugV+ltT
 3EgLSNDPcUFR2eKQoxNQEPZ4T8MBxRACVCzfm9LyHKwiMPVHYYnRdyZaJq4c9clLJtOnmC71UhR
 qYZjkYOSCHRtIECbfaCECQ8VKjNOfogJvZ/OnVlJrLyL4uXuusmY7SGJ3Q54AjJJdkm+dQCk5on
 sEOKBAVZqRAtCcnmcu9GxzJDVo2ONWrLAYSwmgbfQptDkBFyUbgg9qqHz8B4Hv2iGvT+Z8QQoU9
 agsJsu2L2oF0GwPdwj6SCnkqVqPLlT2zagnidjcVW5+dx2g+CqAkDTgyr48Fy5bjGgb7DBdkQtD
 txUxO8FmslKMDLzMsD7HFjx8rRwQc/WA3jIaJmRybCxJCyakplTxewfQTe+Iq8/FavACbVHopw8
 fyXeafbjhWzpP5UR37lLwquBLxrO+tzOxdFPov19TBSFttmL6IlxZ8iVn5NikHISt11Mk61A==
X-Received: by 2002:a05:6000:4904:b0:46f:7d90:8128 with SMTP id
 ffacd0b85a97d-47f6230e57fmr16732004f8f.14.1784541186495; 
 Mon, 20 Jul 2026 02:53:06 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm32537104f8f.11.2026.07.20.02.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 02:53:06 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Mon, 20 Jul 2026 10:52:11 +0100
Subject: [PATCH 1/3] doc: board: qualcomm: document SM8550/QCS8550
 building/flashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-sm8550-hdk-v1-1-84f077937303@imd-tec.com>
References: <20260720-sm8550-hdk-v1-0-84f077937303@imd-tec.com>
In-Reply-To: <20260720-sm8550-hdk-v1-0-84f077937303@imd-tec.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 20 Jul 2026 14:28:29 +0200
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

Introducing documentation support for Qualcomm SnapDragon Gen 2 SM8550
and QualComm Dragonwing Q8 QCS8550. Documents the build and flashing
steps.

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
 doc/board/qualcomm/index.rst  |  1 +
 doc/board/qualcomm/sm8550.rst | 48 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 3238a68e859..de5b24dd463 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -14,3 +14,4 @@ Qualcomm
    iq8
    phones
    rdp
+   sm8550
diff --git a/doc/board/qualcomm/sm8550.rst b/doc/board/qualcomm/sm8550.rst
new file mode 100644
index 00000000000..200420dcaf8
--- /dev/null
+++ b/doc/board/qualcomm/sm8550.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: William Bright <william.bright@imd-tec.com>
+
+Qualcomm SM8550
+===============
+
+The SM8550 (Snapdragon 8 Gen 2) is a Qualcomm mobile SoC featuring an octa-core
+Qualcomm Kryo CPU and a Qualcomm Adreno 740 GPU. The ``QCS8550``, part of the
+Qualcomm Dragonwing Q8 series, is a child SoC of the SM8550 that drops the
+RF modem. As the two SoCs are otherwise identical, the same
+``qcom_sm8550_defconfig`` and flashing process can be used for both SoCs.
+
+More information can be found on the `Qualcomm's SM8550 product page`_ and the
+`Qualcomm's QCS8550 product page`_.
+
+.. _Qualcomm's SM8550 product page:
+   https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-8-gen-2-mobile-platform
+.. _Qualcomm's QCS8550 product page:
+   https://www.qualcomm.com/internet-of-things/products/q8-series/qcs8550
+
+Installation
+------------
+First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for
+``SM8550``::
+
+   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+   $ make qcom_sm8550_defconfig
+   $ make -j8
+
+This will build the signed ``u-boot.mbn`` in the configured output directory.
+The firmware expects firmware ELF images to be "signed". The signature does not
+provide any security in this case, but it provides the firmware with some
+required metadata.
+
+Then flash the resulting ``u-boot.mbn`` to the ``uefi_a`` partition on your
+device with ``fastboot flash uefi_a u-boot.mbn``.
+
+U-Boot should be running after a reboot (``fastboot reboot``).
+
+Note that fastboot is not yet supported in U-Boot on the SM8550-HDK, as a
+result, to flash back the original firmware, or new versions of the U-Boot, EDL
+mode must be used.
+
+A tool like bkerler's `edl`_ can be used for flashing::
+
+   $ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
+
+.. _edl: https://github.com/bkerler/edl

-- 
2.43.0

