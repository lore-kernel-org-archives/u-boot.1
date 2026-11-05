Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE9606A335
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kJYnf/IB;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=prk8pnSj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B07E608A1;
	Thu,  5 Nov 2026 17:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKjZMTCQmVDF; Thu,  5 Nov 2026 17:54:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 606C26089A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793901287;
	b=LE94erTOR5e26Go12xb01JPg1/hyu15LYbTfK5QDxK6mq3CcbU4+vonTvOdP9JAmtypL
	 6ErkuS2oW8QLG4ehKdFXf+1uBJwZXchGRYrDnkR3PRPV8rhe2e6D/oD6Znluy1wPvTX31
	 6kCTdjon8ZPvvzedMVAtrRuIVx4Y1clCaUBezOxTC8oaLePshfVIm1iMbeeq2MlmA/AsT
	 3PaB0wXQ222Jk0J9yQJtvo5nIexSTY2ZzT9yabqaCtQJvfrGhGwJb0qRKBDRJ3lv4Gtcy
	 76ro1cGjJIOrrnjeSuKuU+nuGnjqetWw/IKzjK7cDAe+PWdSn367YZzXfUp1ZZEUBbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793901287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xJWhwHHuOcKMpeDJpinw9xpdwsMeAAceZaARTweqU0c=;
	b=tbx/4a08Jn0fYTlBTZOxGmKkLbTzdy0BRdkXE3luw/vOJk1FNxDjIqX08EFfqvgkDvd1
	 0d/FQuAErNoqQB0KYEr9BeXxhqRrtRlvxwvQsfBhAgd0htvqg0/vakbTC/GMJz3/VAp9S
	 3D4ANzgKy+LFZ1eRqpq7IXC5me5kdrooo8HyJbSm78sIuYhOMzkKKEWGuA7Rjmblp86+9
	 JB76QyVDVom2O1+2eX/heOhBKSOtFe5FVC93FFYW4RP6FXGGMH+1q2SCxzhUHeXZKR+mZ
	 24Ao5iWUv2Nx4NngBZmuzfcJ+tz2JjaSEId6yPpdPBK+ARrc6rAeV8A2Ofv5WZQIzZQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793901287;
	bh=xJWhwHHuOcKMpeDJpinw9xpdwsMeAAceZaARTweqU0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kJYnf/IBjBV78k4SSruiFTPpVpmnIGyR1GNOauet/0FuYkYkdGJrZsvDatBRoHtmx
	 ETOxdg6z/0u4FlYClwa+yBkiAS7SZG3wBa7uyzHJzzArU7nlyy1dNfr4pCnWLgS8+2
	 gZ0UvBkw3Nub/NRWQa0LdAQwp0MnxXHRMd7JdKZf/VNJdOWo+i7CqJQP3zSHVyjKPk
	 1bBQXGjYIhZ78fljar5U79ORXiJ4qfKCrzBX0iVbVJthdvmGbwD5TV++UhR0ERFK2/
	 4JG2VLkrFLqIIXjliXRZUOLfSCd+vTAJ7OsFa2MltY9YLpImCUNy/wv45t93JqaFJM
	 IuYNmWSPNPqpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 606C26089A;
	Thu,  5 Nov 2026 17:54:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64B9E2AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 568CF40093
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j0Pom-cdpX-f for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:54:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B443740378
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=prk8pnSj
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B443740378
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:38 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6d68de53053so1194492eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793901277; x=1794506077;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xJWhwHHuOcKMpeDJpinw9xpdwsMeAAceZaARTweqU0c=;
 b=prk8pnSjcRk+gjtzKeUU5BDwgqbBsM4UVjLsFyjiaCaBzHoXaNXUkP0yOJOQ7l7oZp
 /PTt1IMmli/nY0tcE5WFGK5YvNvcA6kzrD9zORPhLcfdYFofzITeMMP1gLSI6OcO2ys5
 Q0gFO7MGCHrUXHJIz5Qi81+JRiLopSY6KduZG8IQzDgMc7jFC977Uufg8gn0QNwq9m3O
 9Yb1Y25jC/vqQSE7T9SPfKJisS5PXGQ4ag5JMMdPubQhLWUU7OH0LVJPGOPxWqqPpOYy
 rwm+xWEV8g+eHQw9yI50XQEakvYGrHBzIFpx4WJO2ebfCxgcc1OADUmvFVYyOVCj7Tzb
 Rf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793901277; x=1794506077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xJWhwHHuOcKMpeDJpinw9xpdwsMeAAceZaARTweqU0c=;
 b=hgVHEvPqyRXL2y6CJy5FXDj1eRJj6RdAj9ANJT1J5sIHhJCfY1otCjRI4TuhyOxp9o
 YKvGQQMRYFAPGbxqzZcdhTK3soVbceLJMxhrojjiobk5XqDTXEBphH1Janl2/6WzL5Ze
 CwuOAuX4ZQx0aVAefA2JoYVG/+B8BXkUVaXES9RXK3I4c/5ViVpCZzUqkC6RNDSbablY
 BeuyoMUVAByIYrC57hvFAWzKb0iyJI/kGu2yOUgNvSMI01pUgDgreRHqNcC2HDcdr49z
 3tnzG1j7t5mnAQ652jMXPUj56NoXCit8AOsglVER8+dtgGn/Bell7IYTcuNFt+3EXYLV
 JGpg==
X-Gm-Message-State: APuU4Z9sWWfliT+OZHi6npg3LG117Zy9iu8F74zKl6ZdjgV6NPHtyKrk
 ANGw2GQevqXrZ0u8P2JSYh2v4FOS9mPaD9/ad8VgGYRCTWvAPwBqFHSpZSqide97fYY=
X-Gm-Gg: AYBFou0lquff2Ed1b05VkTK6CE80Hq7Eu39qVekSIUtNjNO2VHWjCLlW1jK3TLTZHd2
 DlwPsvufwtS0ki054rov6Z2vQwCBa2y/3GTY1b3HFJdjEZuXn8hNdI0/wVwsNCvUv/4ll2VEJTv
 TrQLnvqYQg926ZpagQwAuaqe+cSa2HJ/MEKGdLuGIHaO4PM+t23a1nTppoRDvDX4uDH4lFcK+9v
 rbfJgRx6GCtDiMkKBlvLPLSYXuBZ7fusxvy9EDjQS1mO9ioVpyzPbt2jmcDbcOvEKLkjWfc3GE6
 io9Zj2eXFGkDwjoespEhiUPe56wc2QFXTvBQnEcjGpp6LmtUu9vsLBq8dJXJ9iJq0pQ8Tmuk1G6
 xiiK39uuX7Pu6n5ZoBPKrM7DLXw5steartthLALXy3zNFvgDUW62dIY1fHL9NjhLD5e5VM5IceK
 YlrCLuManQdsn66XyC1fIQPi8VmGeY+GviP1rvF28yPFcBIEtyWE5+5YHcmxiWutpbAJSTcq7Rd
 QQKP6OlWah2rd+VhBPXTZM64to8t2JsRWnN5kGo+4pIg9QSIRmpSbnlxL0cYxMhShWJV96OHkLC
 z1XLaqfkf9B8LRqVQCC8/06QcD+mit/Sqg==
X-Received: by 2002:a05:6820:1c91:b0:713:da3b:9052 with SMTP id
 006d021491bc7-716e78c1507mr214618eaf.31.1793901277163; 
 Thu, 05 Nov 2026 09:54:37 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12eb1b9sm4659682eaf.10.2026.11.05.09.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:54:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 11:53:41 -0600
Subject: [PATCH v2 6/6] doc: board: mediatek: document Genio 520 and 720 boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-genio-720-spl-v2-6-4994535a3848@baylibre.com>
References: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
In-Reply-To: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11257;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=LUhHpKA/nfQrLgQZpEn5ds4nGxUMKahC7n5Vh0L4PEM=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7MLNHQKLUdqr+9X7IDPOKSCw6j2UUVuM17MNG
 TQRDD+tF1KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauzCzRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfcsH/jtb1QYQgY53+jVeZnygD30x8o/TCIM7bvOAX9Q
 GnhFgEkJtR+SHWKnPPklTKwapzy/Ww+2eEJ6dQWT+rYRusGGPqs4wXQ7H2fsWu9w/8kdSWNxba8
 ep096tetOzEPyTtq0l2vWc+vDmAb3778LPk5ber89zQcvd2hAmcpFOsmW4xqkGW+o53i8deidEz
 PmG3TjuF6BfSPjQYRxLKi4rf/f4lhmpzI66imWawQ9U/Q+193P2ZTv0+3krJW4v3FdoggqQNrqw
 65BjRG9/XmRm6uA5B3kj/Gy3FUuZ607DsLqVfr5a1v77KYHKUMd778IIWLg91iM8FCezSQ8bFzY
 5YDw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a board page for the Genio 520 and Genio 720 EVKs. It describes
how to build U-Boot proper as BL33 for the platform's own BL2.

It also describes the optional U-Boot SPL boot chain. This covers the
DDR-loader handoff contract, the MT8189 image layout and the eMMC
BootROM size limit, as well as the build and install steps.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS              |   1 +
 doc/board/mediatek/index.rst            |   1 +
 doc/board/mediatek/mt8189-genio-evk.rst | 238 ++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 17bbb4d9f59..aa21cb9c767 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -9,6 +9,7 @@ F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
 F:	configs/mt8391_genio_*
+F:	doc/board/mediatek/mt8189-genio-evk.rst
 
 MT8365 EVK
 M:	Julien Masson <jmasson@baylibre.com>
diff --git a/doc/board/mediatek/index.rst b/doc/board/mediatek/index.rst
index 7ca1bd9fde2..21f01ec88ad 100644
--- a/doc/board/mediatek/index.rst
+++ b/doc/board/mediatek/index.rst
@@ -8,3 +8,4 @@ Mediatek
 
    mt7621
    mt8188-genio-evk
+   mt8189-genio-evk
diff --git a/doc/board/mediatek/mt8189-genio-evk.rst b/doc/board/mediatek/mt8189-genio-evk.rst
new file mode 100644
index 00000000000..184085b83c1
--- /dev/null
+++ b/doc/board/mediatek/mt8189-genio-evk.rst
@@ -0,0 +1,238 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+.. Copyright (C) 2026 BayLibre SAS
+
+MediaTek Genio 520 and Genio 720 EVKs
+=====================================
+
+The Genio 520 and Genio 720 EVKs use the same MT8189-family boot flow:
+
+================  ======  ====================================
+Board             SoC     Defconfig
+================  ======  ====================================
+Genio 520 EVK     MT8371  ``mt8371_genio_520_evk_defconfig``
+Genio 720 EVK     MT8391  ``mt8391_genio_720_evk_defconfig``
+================  ======  ====================================
+
+The configurations share their memory layout, drivers and firmware-image
+layout. Each board has its own control devicetree.
+
+U-Boot can be used on these boards in two ways:
+
+* as U-Boot proper only, started as BL33 by the platform's own BL2 and Arm
+  Trusted Firmware-A, or
+* optionally, also as U-Boot SPL, which replaces the platform BL2 and loads
+  BL31, OP-TEE and U-Boot proper itself.
+
+U-Boot proper
+-------------
+
+In the usual boot chain, U-Boot provides only U-Boot proper::
+
+   BootROM
+     -> platform BL2
+     -> Arm Trusted Firmware-A (BL31)
+     -> OP-TEE (BL32)
+     -> U-Boot proper (BL33)
+
+The platform BL2 initializes DRAM and loads BL31, BL32 and BL33. U-Boot proper
+is linked at ``CONFIG_TEXT_BASE``, ``0x4c000000``. It takes the DRAM size from
+the ``memory`` node of its devicetree, which describes 8 GiB of DRAM.
+
+Building
+~~~~~~~~
+
+Select the defconfig for the target board. For example, for Genio 720::
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ export KBUILD_OUTPUT=build
+   $ make mt8391_genio_720_evk_defconfig
+   $ make
+
+Use ``mt8371_genio_520_evk_defconfig`` instead for Genio 520.
+
+The EVKs have DIP switches and jumpers which connect either the eMMC or the
+UFS storage. The default devicetree is for eMMC. When the board is set up for
+UFS, select the UFS variant of the devicetree instead::
+
+   $ make DEVICE_TREE=mt8391-genio-720-evk-ufs
+
+Use ``DEVICE_TREE=mt8371-genio-520-evk-ufs`` for Genio 520.
+
+This produces ``build/u-boot.bin``, which is the BL33 image. The build also
+produces ``build/spl/u-boot-spl.bin``, which is not used in this boot chain.
+No external firmware is needed. Install ``u-boot.bin`` as BL33 as described
+by the platform firmware.
+
+U-Boot SPL
+----------
+
+U-Boot SPL can optionally replace the platform BL2::
+
+   BootROM
+     -> platform DDR loader
+     -> U-Boot SPL
+     -> Arm Trusted Firmware-A (BL31)
+     -> OP-TEE (BL32)
+     -> U-Boot proper (BL33)
+
+The BootROM loads a MediaTek image containing a platform DDR loader followed by
+U-Boot SPL. The DDR loader initializes DRAM, copies SPL to DRAM and enters it.
+SPL then reads a FIT image containing BL31, OP-TEE, U-Boot proper and the
+U-Boot control devicetree, and uses the standard FIT and Arm Trusted Firmware
+support to hand off to BL31.
+
+The DDR loader is a platform firmware component built separately from U-Boot
+and supplied to binman as an external blob.
+
+Boot storage
+~~~~~~~~~~~~
+
+The supplied configurations boot from eMMC. The BootROM loads ``mtk-boot.bin``
+from the eMMC boot0 hardware partition, and SPL loads ``bootloaders.img`` from
+GPT partition 1 of the eMMC user area. SPL selects the partition by number
+through ``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION``; it does not locate it
+by name.
+
+Make sure the DIP switches and jumpers are set for eMMC, and use the default
+devicetree.
+
+DDR-loader handoff contract
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The contract between the DDR loader and U-Boot SPL consists of a fixed image
+layout, initialized DRAM and the execution state at the SPL entry point. The
+BootROM loads the image payload to ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``::
+
+   offset 0                                     +----------------------+
+                                                | DDR loader           |
+                                                |                      |
+   offset CONFIG_MTK_GENIO_DDR_LOADER_SIZE      +----------------------+
+                                                | U-Boot SPL           |
+                                                | CONFIG_SPL_MAX_SIZE  |
+   image end                                    +----------------------+
+
+The supplied configurations use the following values:
+
+=====================================  ==============  ========
+Setting                                Value           Size
+=====================================  ==============  ========
+``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``    ``0x2001000``
+``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``   ``0xa0000``     640 KiB
+``CONFIG_SPL_MAX_SIZE``                ``0x40000``     256 KiB
+``CONFIG_SPL_TEXT_BASE``               ``0x40000000``
+``CONFIG_MTK_GENIO_BL31_LOAD_ADDR``    ``0x54601000``
+=====================================  ==============  ========
+
+The DDR loader must:
+
+* initialize and train DRAM,
+* copy the complete ``CONFIG_SPL_MAX_SIZE`` byte SPL region from
+  ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR + CONFIG_MTK_GENIO_DDR_LOADER_SIZE``
+  (``0x20a1000``) to ``CONFIG_SPL_TEXT_BASE``,
+* leave the MMU and caches disabled, with all of its writes visible to the
+  CPU, and
+* enter SPL at ``CONFIG_SPL_TEXT_BASE`` in AArch64 EL3h with exceptions
+  masked.
+
+SPL obtains platform information from its embedded control devicetree and
+initializes the console, clocks, pinctrl, watchdog and eMMC through U-Boot
+drivers.
+
+The MT8189 BootROM loads at most about 930 KiB from eMMC boot0 and does not
+start a larger image. The loader and SPL regions together occupy 896 KiB,
+which leaves little room to enlarge either of them.
+
+The DDR loader runs from SRAM at the load address, and the SPL region stays in
+the same SRAM until the loader has copied it to DRAM. The loader's code, data,
+BSS and stack must therefore all stay below the SPL region, not only its
+binary image.
+
+Firmware image prerequisites
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following external binaries are required to assemble the complete
+firmware images:
+
+``ddr-loader.bin``
+   A MediaTek DDR loader which initializes the DRAM fitted to the target board
+   and satisfies the handoff contract above. The input may be shorter than the
+   configured loader region; binman pads it with zeros.
+
+``BL31``
+   The U-Boot build variable naming the Arm Trusted Firmware-A BL31 binary
+   built for the MT8189 platform. It is loaded and entered at
+   ``CONFIG_MTK_GENIO_BL31_LOAD_ADDR``.
+
+``TEE``
+   The U-Boot build variable naming the OP-TEE binary. A standard OP-TEE v1
+   ``tee.bin`` image is supported. Binman removes its header and derives the
+   load and entry addresses from it when creating the FIT.
+
+BL31 and OP-TEE must agree on the secure-memory layout. Place
+``ddr-loader.bin`` in a directory which can be passed to binman with
+``BINMAN_INDIRS``.
+
+Building
+~~~~~~~~
+
+Enable ``CONFIG_MTK_GENIO_BOOT_IMAGES`` to assemble the complete firmware
+images. For example, for Genio 720 with the DDR loader in
+``/path/to/firmware/ddr-loader.bin``::
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ export KBUILD_OUTPUT=build
+   $ export BL31=/path/to/bl31.bin
+   $ export TEE=/path/to/tee.bin
+   $ make mt8391_genio_720_evk_defconfig
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --enable MTK_GENIO_BOOT_IMAGES
+   $ make olddefconfig
+   $ make BINMAN_INDIRS=/path/to/firmware
+
+Use ``mt8371_genio_520_evk_defconfig`` instead for Genio 520. ``TEE`` must be
+set for both configuration and compilation. Do not deploy images if binman
+reports that it used fake or missing external blobs.
+
+Binman produces two deployable images and one intermediate payload in the
+build directory:
+
+``mtk-boot.bin``
+   A MediaTek eMMC image with load and entry address
+   ``CONFIG_MTK_GENIO_BROM_LOAD_ADDR``. It contains the DDR loader, padded to
+   ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by U-Boot SPL padded to
+   ``CONFIG_SPL_MAX_SIZE``.
+
+``mtk-boot-payload.bin``
+   The raw DDR-loader and SPL payload contained in ``mtk-boot.bin``, without
+   the MediaTek BootROM header. This is an intermediate input for external
+   MediaTek secure-boot tooling and must not be flashed directly.
+
+``bootloaders.img``
+   A FIT image containing BL31, U-Boot proper, OP-TEE and the U-Boot control
+   devicetree. Each component has a SHA-256 hash.
+
+The FIT can also be signed, as described for the Genio 510 and Genio 700 EVKs
+in :doc:`mt8188-genio-evk`.
+
+Installing
+~~~~~~~~~~
+
+Use the board provisioning tools to place the images as follows:
+
+===================  ================================================
+Image                Destination
+===================  ================================================
+``mtk-boot.bin``     Start of the eMMC boot0 hardware partition
+``bootloaders.img``  GPT partition 1 in the eMMC user area
+===================  ================================================
+
+For example, with `Genio Tools
+<https://genio.mediatek.com/doc/iot-yocto/latest/tools/genio-tools.html>`_ and
+a prebuilt Genio image for the target board::
+
+   $ genio-flash -P /path/to/genio-image \
+         mmc0boot0:/absolute/path/to/build/mtk-boot.bin \
+         bootloaders:/absolute/path/to/build/bootloaders.img
+
+Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
+the platform recovery path while testing.

-- 
2.53.0

