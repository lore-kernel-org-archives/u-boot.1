Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A66606A884
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GDMQuHX7;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dZ/VIx5n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8292F406F6;
	Mon, 16 Nov 2026 14:01:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-YFeLtraaeb; Mon, 16 Nov 2026 14:01:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 991C040705
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837672;
	b=NY0pVK6ddKw1Es8ZtXgZ3JaakTvgtJdqvTB1D0yONMqDK2otk/MomoGvQwPjmxOIBeqp
	 66FtcgfH2GUa1wqswfUTq8/WUE1+XPcO6bQ3eiT0QD6XbmiJGMFAxNl3BH/RPYEx4YEtN
	 KFll5KRDq2bzod5dB2wb4gh2Zqq3vNcpk7lyPPNuhM9HWF14xBaKpX4Lc8ce7Or/anPPD
	 TCxhdDc0TkGJtp4j6yAowtU3fB+1XTxu15brpnGHllGL7qEwvTO18Yph6mH1dkuiyAINu
	 ZMZSxeaq8m1jni+SCgpaxiQYKwRYVE/CTRucM6Gij9h7QHh4fGi4vaE72N741V3H2YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=w3brToEWN20VywlcqJPIvqAf1+YBBZHnVtTVxhfekfg=;
	b=XPdibvacWw0fDeqFx8UW0jyLCwS5MYcFp6WUDMJ0MfVVWtX3WEWORHaYv3iHzaJTKKXG
	 xFEIX93Rvhmp4yOno6OAvOwaWz8EeOkHfFVl6wLBefdVhrhX2iDR21DGLKqkj6nVwu16A
	 q5iaudBoIhFLBsU9lpE6MlWrpP5lzOoZvbU68uxuOy7p/72MfLW89a1umJGG0TnZU+u32
	 v7cVus6GciyM1W1iag2uhBWLKJVXw9QE59GHR6YpOcLrAFtA32pBpTdVmozIQ4xIUbzCZ
	 V75dTl7D9IGOP9uyv9CCFhzJ85cZKHBrZIKkM9JSWFFnERORI9pdXm3vNwPeTas62jw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837672;
	bh=w3brToEWN20VywlcqJPIvqAf1+YBBZHnVtTVxhfekfg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GDMQuHX7SA8iQi4InTUbstndXSItK/fiwk3CcGTaW7XPxeovPfyHBU3cbRxDdOJ+A
	 nonMUR4SnBFoaQ/JyHnN1lCfvv/I3nmggveBETHazllILUdFwk+73LPj88aWK1E0F2
	 cpj5D9nSgEoFypLmIoamssaJgB8o4uitTilaEVZJ/cxP/SSTHqissaOO+TCFEsHo14
	 lgpvUOWd4uxbtfqXHEJY8fkMbFswtjqZrYxptPIY8DkHKjEzJIciKNw+/E32felczK
	 oIHxQoRt4B/9gGWRk/dYQxmW5DjYjEv0BbrcpnpT2FzVnc6g1tNuZ9rorx95MbUZzE
	 pHmZteKGBWl3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 991C040705;
	Mon, 16 Nov 2026 14:01:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 94A602FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86C2B40274
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SZqhO4UgpNpe for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:01:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 965494009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dZ/VIx5n
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 965494009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:07 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa87so1845511f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794837665; x=1795442465;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w3brToEWN20VywlcqJPIvqAf1+YBBZHnVtTVxhfekfg=;
 b=dZ/VIx5nbqvAqdO4egu5wn8+iSPnCQIjNEgFvvcPoMXUnaFgz9yzuLz+3eMSe+7d3g
 OFD5aZYPq6iRsFRrOdITqLux10HvZO7H+bsmVPXlUEYbPKPYQ6NhwRXB/FlodPsAmjYn
 OpBMkgShgEePF9fscDdin3RWIUw5TYh6gjavRJqG1tsX7zAiMPQn3539dHZQKWGzewVm
 8pTDq+2VJ+Fr7aD1dvwA7YaF2asM7Yokyi4394EF/UwsKjKYuPk4xTneuNW7nj3GKTo6
 HxmHeCVN6awuhs6zoAMKoTNzh5rgYXpvuaaUPJmmKxSPcStKwG+aWQrPEgbuKq0gPZDn
 qH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837665; x=1795442465;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w3brToEWN20VywlcqJPIvqAf1+YBBZHnVtTVxhfekfg=;
 b=pgFgpPxff+PLcZ6p02YnJ2mTrJ38cOlCKUSt/6WMf7+MP1BUwKK22o1aNuOc6ITIWE
 tOy/1L/Mp+fC9EW8bfXvm+meTZrMCUeLeqx+1QaW0Oht9Ec4kl/rGCR/3hHHztSUDEqD
 axUorJ7oFZ0Jogi5H/m0XF78/TIDGi/niYgg0+QP6JtlrvUb5FpeCS6kNdD61qbJf2QM
 TtHnu5RnfQi7cKGfl3Ex8q6/qTGDdrRaX879yVxHDuwxg6UPTUv/XpRWebxxjJuCJ78c
 wnaTE62XZJxpb5SjmOXe7w+UvAj4RxEyyyBcpQPxtuOQKxQzKm8GddudNVisoYTD6iDt
 lN8g==
X-Gm-Message-State: APuU4Z90uPGOw3Dl8Y3PkZWFMwV8TALxPfwIsjDsLxVs5XW/XXLXy2Kz
 nMtMoyiYWtEgXOv2oYQXriELf2DVS0wpUewcLWRc38o9CRfh1M96xExiZg+wOVjXR4k=
X-Gm-Gg: AZFdTZdgm3PRvE8p5/XGevowmkbRQFGS4YV4dCZOqbxr7zoSqZL0vOulWlr+sFOx3BL
 +L8Y0nJG9Sosgczl1VEK9WlaZYiRWFT4dtM+5/7K2HR3YSO6QvAOqEyGL4LDOsv24qphk3506Oy
 MuXKTNhaJV2ZQX8Gtj/JJuxYRThJGLAAP/1CQFCVf2pkLPyL/YN23lt5sLS4mjFMl8y6YdMQCGZ
 TSEGuavQMqBwRrniocxWx6Y55ftjJpu9UT8Jvfqh1uvx/DbajmMYZDf5rOdnIqUGflr2cWxTht5
 VT0Ry726+hFt2htzotwdY45n1lXfJ43fYnk0inLDSjL4yslgQuIwQeO3KDoR03rC6w9zNXAVfOn
 T1FY+KoyyY27SE2EQnjkNghoRb3xSs4oo2L7qw5Y+mknMgEeINHYs19Ko6vftowXtZ9XPRzP4Rt
 5yiZaDjhEhg37TRMNFtmFjdwJUaJaaSyONn9nnlLWgWp6E4vanPzfFRB6GskAVLnEpOi+G8dH7g
 LQE+TDvIMfQR1lOnDUCAi8a1zROaxKmjwwWCshFnuNVz9LdxHDQBCs1YMnnOkraf1y/OLxNeAoB
 UIfBDQOd4gZXh65ZQNV7wEaRv3GhsGymx56sw45R9vZpOcs6gM5ku5BruZUDr333ImK+LXRi7wC
 46EmVbQyrgcnRA2tv3g5HkevTNOXeHVoVcgIZFjJubmjRnw==
X-Received: by 2002:a05:6000:1841:b0:48f:d7cd:a5ac with SMTP id
 ffacd0b85a97d-49c6b97336emr26890103f8f.0.1794837665152; 
 Mon, 16 Nov 2026 06:01:05 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c69406640sm22119355f8f.12.2026.11.16.06.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:01:04 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 15:00:51 +0100
Subject: [PATCH v3 5/7] spl: support booting FIT images downloaded with
 fastboot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-spl-fastboot-boot-v3-5-7b39e7a348c6@baylibre.com>
References: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
In-Reply-To: <20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>, 
 Rob Herring <robh@kernel.org>, York Sun <york.sun@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test farms need to run successive U-Boot builds without rewriting boot
storage. Add an optional RAM boot path for FIT images, including firmware
needed to enter U-Boot.

Accept the Android v0 envelope used by the standard fastboot client so
the same fastboot boot u-boot.itb workflow can be used with SPL.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS                     |   2 +
 common/spl/Makefile             |   1 +
 common/spl/spl_fastboot_boot.c  |  76 +++++++++++++++++
 configs/sandbox_spl_defconfig   |   1 +
 doc/android/fastboot.rst        |  45 +++++++++-
 drivers/fastboot/Kconfig        |  15 ++++
 drivers/fastboot/fb_command.c   |  29 +++++++
 drivers/usb/gadget/f_fastboot.c |   4 +-
 include/fastboot.h              |   8 ++
 include/spl.h                   |   7 ++
 test/image/Makefile             |   1 +
 test/image/spl_fastboot.c       | 183 ++++++++++++++++++++++++++++++++++++++++
 12 files changed, 369 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad224d913ac..d8b59a0a99b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1040,6 +1040,8 @@ M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	cmd/fastboot.c
+F:	common/spl/spl_fastboot_boot.c
+F:	test/image/spl_fastboot.c
 F:	doc/android/fastboot*.rst
 F:	include/fastboot.h
 F:	include/fastboot-internal.h
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 9c94e8f143e..710463f2a3b 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
 obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
 obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_BOOT) += spl_fastboot_boot.o spl_ram.o
 obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += spl_ufs.o
 endif
 
diff --git a/common/spl/spl_fastboot_boot.c b/common/spl/spl_fastboot_boot.c
new file mode 100644
index 00000000000..f52ea83b230
--- /dev/null
+++ b/common/spl/spl_fastboot_boot.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com> */
+
+#include <android_image.h>
+#include <fastboot.h>
+#include <spl.h>
+#include <linux/log2.h>
+
+struct fastboot_image {
+	const void *data;
+	size_t size;
+};
+
+/* The standard fastboot client wraps a FIT in an Android v0 boot image. */
+static int spl_fastboot_unwrap(struct fastboot_image *image)
+{
+	const struct andr_boot_img_hdr_v0 *hdr = image->data;
+	u32 page_size, kernel_size;
+	size_t hdr_size = offsetof(struct andr_boot_img_hdr_v0,
+				   recovery_dtbo_size);
+
+	if (image->size < ANDR_BOOT_MAGIC_SIZE ||
+	    memcmp(image->data, ANDR_BOOT_MAGIC, ANDR_BOOT_MAGIC_SIZE))
+		return 0;
+
+	if (image->size < hdr_size)
+		return -EINVAL;
+	if (le32_to_cpu(hdr->header_version) || hdr->ramdisk_size ||
+	    hdr->second_size)
+		return -EPROTONOSUPPORT;
+
+	page_size = le32_to_cpu(hdr->page_size);
+	kernel_size = le32_to_cpu(hdr->kernel_size);
+	if (!is_power_of_2(page_size) || page_size < hdr_size ||
+	    page_size > image->size || kernel_size > image->size - page_size)
+		return -EINVAL;
+
+	image->data += page_size;
+	image->size = kernel_size;
+	return 0;
+}
+
+int spl_fastboot_load(struct spl_image_info *spl_image)
+{
+	struct fastboot_image image;
+	void *buf;
+	int ret;
+
+	image.size = fastboot_get_boot_image(&buf);
+	image.data = buf;
+	if (!image.size)
+		return -EAGAIN;
+
+	ret = spl_fastboot_unwrap(&image);
+	if (ret)
+		return ret;
+	return spl_ram_load_fit(spl_image, (void *)image.data, image.size);
+}
+
+/* Sandbox tests the loader directly, without a physical USB boot method. */
+#if !IS_ENABLED(CONFIG_SANDBOX)
+static int spl_fastboot_load_image(struct spl_image_info *spl_image,
+				   struct spl_boot_device *bootdev)
+{
+	int ret;
+
+	ret = fastboot_usb_run(CONFIG_SPL_FASTBOOT_USB_DEV, NULL, 0);
+	if (ret)
+		return ret;
+
+	return spl_fastboot_load(spl_image);
+}
+
+SPL_LOAD_IMAGE_METHOD("USB fastboot", 0, BOOT_DEVICE_BOARD,
+		      spl_fastboot_load_image);
+#endif
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index b1112fd45e7..67640c7d85d 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -217,6 +217,7 @@ CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
 CONFIG_SPL_FASTBOOT=y
+CONFIG_SPL_FASTBOOT_BOOT=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 8e15f287f9b..9898348c961 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -96,7 +96,7 @@ stub. The ``continue`` command ends the session and returns control to the
 caller. The ``flash`` and ``erase`` commands are available when their SPL
 backend is enabled. A recognized command whose optional backend is disabled is
 reported as unsupported. Commands omitted from the SPL table, including
-``boot``, ``ucmd``, ``acmd`` and the OEM commands, are reported as unrecognized.
+``ucmd``, ``acmd`` and the OEM commands, are reported as unrecognized.
 
 MMC flash and erase support is enabled with
 ``CONFIG_SPL_FASTBOOT_FLASH_MMC``. The SPL partition-table parser matching the
@@ -120,6 +120,49 @@ Reboot commands require ``CONFIG_SPL_FASTBOOT_REBOOT`` and a platform
 and ``reboot-recovery`` commands also require a platform
 ``fastboot_set_reboot_flag()`` implementation.
 
+Booting a downloaded FIT from SPL
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Enable ``CONFIG_SPL_FASTBOOT_BOOT`` and include ``BOOT_DEVICE_BOARD`` in the
+board's SPL boot order. This load method starts the fastboot session itself;
+select the USB controller with ``CONFIG_SPL_FASTBOOT_USB_DEV``. RAM and the
+USB controller must be ready before the load method runs.
+
+The host can then download and run a U-Boot FIT without flashing it::
+
+   fastboot boot u-boot.itb
+
+::
+
+   Host                         Target
+   +----------------+           +-----------------------+
+   | U-Boot FIT     | -- USB -->| SPL fastboot download |
+   +----------------+           +-----------+-----------+
+                                            |
+                                  acknowledge boot,
+                                  stop USB session
+                                            |
+                                +-----------v-----------+
+                                | SPL FIT loader        |
+                                +-----------+-----------+
+                                            |
+                                +-----------v-----------+
+                                | Firmware / U-Boot     |
+                                | running from RAM      |
+                                +-----------------------+
+
+Use a FIT built for the target, including any firmware required by its normal
+SPL handoff (for example BL31 or OP-TEE). FIT verification uses the board's
+existing SPL configuration. Raw U-Boot binaries are not supported. The loader
+accepts a bare FIT or the Android v0 wrapper added by the standard fastboot
+client; separate ramdisk and second-stage arguments are not supported.
+
+Keep the download buffer separate from SPL, its heap and stack, and all FIT
+load destinations. ``CONFIG_SPL_FASTBOOT_FLASH`` is optional.
+
+``continue`` leaves fastboot and lets SPL try the remaining boot methods.
+Loading errors also follow SPL's normal boot order.
+
 Fastboot environment variables
 ------------------------------
 
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 9a5251d4b60..637fb9e4541 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -67,6 +67,21 @@ config SPL_FASTBOOT
 config SPL_USB_FUNCTION_FASTBOOT
 	bool
 
+config SPL_FASTBOOT_BOOT
+	bool "Boot FIT images downloaded with fastboot in SPL"
+	depends on ARM || MIPS || RISCV || SANDBOX
+	depends on SPL_FASTBOOT && SPL_FRAMEWORK && SPL_LOAD_FIT
+	depends on !SPL_LOAD_FIT_FULL && !SPL_USB_SDP_SUPPORT
+	help
+	  Enable fastboot boot to load a downloaded FIT image through the SPL
+	  image loader. Boards enter the USB session by selecting
+	  BOOT_DEVICE_BOARD in their SPL boot order.
+
+config SPL_FASTBOOT_USB_DEV
+	int "SPL fastboot USB controller number"
+	depends on SPL_FASTBOOT_BOOT
+	default 0
+
 config SPL_FASTBOOT_REBOOT
 	bool "Enable fastboot reboot commands in SPL"
 	depends on SPL_FASTBOOT
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 056d95cb1f8..6685420fb56 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -42,10 +42,13 @@ static u32 fastboot_bytes_received;
  */
 static u32 fastboot_bytes_expected;
 
+static bool boot_requested;
+
 static void okay(char *, char *);
 static void boot_image(char *, char *);
 static void getvar(char *, char *);
 static void download(char *, char *);
+static void boot(char *, char *);
 static void flash(char *, char *);
 static void erase(char *, char *);
 static void reboot_bootloader(char *, char *);
@@ -90,6 +93,10 @@ static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
 		.command = "erase",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (erase), (NULL))
 	},
+	[FASTBOOT_COMMAND_BOOT] = {
+		.command = "boot",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_BOOT, (boot), (NULL))
+	},
 	[FASTBOOT_COMMAND_CONTINUE] =  {
 		.command = "continue",
 		.dispatch = okay
@@ -323,6 +330,7 @@ void fastboot_download_reset(void)
 	image_size = 0;
 	fastboot_bytes_received = 0;
 	fastboot_bytes_expected = 0;
+	boot_requested = false;
 }
 
 /**
@@ -459,6 +467,27 @@ void fastboot_data_complete(char *response)
 	fastboot_bytes_received = 0;
 }
 
+static void __maybe_unused boot(char *cmd_parameter, char *response)
+{
+	if (!image_size || fastboot_bytes_expected)
+		fastboot_fail("No complete image downloaded", response);
+	else
+		fastboot_okay(NULL, response);
+}
+
+#if CONFIG_IS_ENABLED(FASTBOOT_BOOT)
+void fastboot_boot(void)
+{
+	boot_requested = true;
+}
+
+u32 fastboot_get_boot_image(void **buf)
+{
+	*buf = fastboot_buf_addr;
+	return boot_requested ? image_size : 0;
+}
+#endif
+
 /**
  * flash() - write the downloaded image to the indicated partition.
  *
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 68fe657f891..cdd88035eed 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -489,7 +489,7 @@ static void do_exit_on_complete(struct usb_ep *ep, struct usb_request *req)
 	g_dnl_trigger_detach();
 }
 
-#ifndef CONFIG_XPL_BUILD
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(FASTBOOT_BOOT)
 static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	req->complete = fastboot_complete;
@@ -566,7 +566,7 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
 	if (!strncmp("OKAY", response, 4)) {
 		switch (cmd) {
 		case FASTBOOT_COMMAND_BOOT:
-#ifndef CONFIG_XPL_BUILD
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(FASTBOOT_BOOT)
 			fastboot_func->in_req->complete = do_bootm_on_complete;
 #endif
 			break;
diff --git a/include/fastboot.h b/include/fastboot.h
index f3aa6fcc229..ee0458c582a 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -158,9 +158,17 @@ int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size);
  *
  * Otherwise execute "bootm <fastboot_buf_addr>", if that fails, reset
  * the board.
+ * In SPL, record the request for loading after the USB session stops.
  */
 void fastboot_boot(void);
 
+/**
+ * fastboot_get_boot_image() - Get the download requested for booting in SPL
+ * @buf: Receives the download buffer address
+ * Return: Image size, or zero if no boot command has completed
+ */
+u32 fastboot_get_boot_image(void **buf);
+
 /**
  * fastboot_handle_boot() - Shared implementation of system reaction to
  * fastboot commands
diff --git a/include/spl.h b/include/spl.h
index f884c24b85e..2b12dbb7215 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -998,6 +998,13 @@ int spl_dfu_cmd(int usbctrl, char *dfu_alt_info, char *interface, char *devstr);
  */
 int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size);
 
+/**
+ * spl_fastboot_load() - Load a FIT after the fastboot USB session has stopped
+ * @spl_image: Receives the image's load address and entry point
+ * Return: 0 on success, -EAGAIN if no boot was requested, or another error
+ */
+int spl_fastboot_load(struct spl_image_info *spl_image);
+
 /**
  * spl_mmc_clear_cache() - Clear cached MMC devices
  *
diff --git a/test/image/Makefile b/test/image/Makefile
index feca0611fcf..67d9b97a2d2 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -3,6 +3,7 @@
 # Copyright 2021 Google LLC
 
 obj-y += spl_load.o
+obj-$(CONFIG_SPL_FASTBOOT_BOOT) += spl_fastboot.o
 obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
 obj-$(CONFIG_SPL_UT_LOAD_NAND) += spl_load_nand.o
 obj-$(CONFIG_SPL_UT_LOAD_NET) += spl_load_net.o
diff --git a/test/image/spl_fastboot.c b/test/image/spl_fastboot.c
new file mode 100644
index 00000000000..39dc784e5e6
--- /dev/null
+++ b/test/image/spl_fastboot.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com> */
+
+#include <android_image.h>
+#include <fastboot.h>
+#include <image.h>
+#include <mapmem.h>
+#include <spl.h>
+#include <test/spl.h>
+#include <test/ut.h>
+
+static int run_fastboot_command(struct unit_test_state *uts, const char *command,
+				int expected_cmd, const char *expected_response)
+{
+	char response[FASTBOOT_RESPONSE_LEN];
+	char cmd[FASTBOOT_COMMAND_LEN];
+
+	strlcpy(cmd, command, sizeof(cmd));
+	ut_asserteq(expected_cmd, fastboot_handle_command(cmd, response));
+	ut_asserteq_str(expected_response, response);
+	return 0;
+}
+
+static int download_image(struct unit_test_state *uts, const void *data,
+			  size_t size)
+{
+	char command[FASTBOOT_COMMAND_LEN];
+	char expected[FASTBOOT_RESPONSE_LEN];
+	char response[FASTBOOT_RESPONSE_LEN];
+
+	snprintf(command, sizeof(command), "download:%08x", (uint)size);
+	snprintf(expected, sizeof(expected), "DATA%08x", (uint)size);
+	ut_assertok(run_fastboot_command(uts, command, FASTBOOT_COMMAND_DOWNLOAD, expected));
+	fastboot_data_download(data, size, response);
+	ut_asserteq_str("", response);
+	fastboot_data_complete(response);
+	ut_asserteq_str("OKAY", response);
+	return 0;
+}
+
+static int spl_test_fastboot_state(struct unit_test_state *uts)
+{
+	char buffer[64], data[32] = {}, response[FASTBOOT_RESPONSE_LEN];
+	struct spl_image_info info = {};
+	void *image;
+
+	fastboot_init(buffer, sizeof(buffer));
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT,
+					 "FAILNo complete image downloaded"));
+	ut_asserteq(-EAGAIN, spl_fastboot_load(&info));
+	ut_assertok(download_image(uts, data, sizeof(data)));
+	ut_assertok(run_fastboot_command(uts, "continue", FASTBOOT_COMMAND_CONTINUE, "OKAY"));
+	ut_asserteq(0, fastboot_get_boot_image(&image));
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT, "OKAY"));
+	/* The request is only made when the USB OKAY has completed. */
+	ut_asserteq(0, fastboot_get_boot_image(&image));
+	fastboot_boot();
+	ut_asserteq(sizeof(data), fastboot_get_boot_image(&image));
+	ut_asserteq_ptr(buffer, image);
+
+	ut_assertok(run_fastboot_command(uts, "download:00000020", FASTBOOT_COMMAND_DOWNLOAD,
+					 "DATA00000020"));
+	fastboot_data_download(data, 16, response);
+	fastboot_data_complete(response);
+	ut_asserteq_str("FAILIncomplete download", response);
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT,
+					 "FAILNo complete image downloaded"));
+	ut_asserteq(0, fastboot_get_boot_image(&image));
+
+	ut_assertok(download_image(uts, data, sizeof(data)));
+	fastboot_boot();
+	fastboot_init(buffer, sizeof(buffer));
+	ut_asserteq(0, fastboot_get_boot_image(&image));
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT,
+					 "FAILNo complete image downloaded"));
+	return 0;
+}
+
+SPL_TEST(spl_test_fastboot_state, 0);
+
+static int check_download(struct unit_test_state *uts, void *image, size_t size,
+			  struct spl_image_info *expected, const void *data)
+{
+	struct spl_image_info loaded = {};
+	int ret;
+
+	ut_assertok(download_image(uts, image, size));
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT, "OKAY"));
+	fastboot_boot();
+	ret = spl_fastboot_load(&loaded);
+	if (!expected) {
+		ut_assert(ret < 0);
+		return 0;
+	}
+	ut_assertok(ret);
+	ut_assertok(check_image_info(uts, expected, &loaded));
+	ut_asserteq_mem(data, map_sysmem(expected->load_addr, expected->size),
+			expected->size);
+	return 0;
+}
+
+static int check_images(struct unit_test_state *uts, void *image, size_t size,
+			struct spl_image_info *info, const void *data,
+			void *wrapped, enum spl_test_image type)
+{
+	struct andr_boot_img_hdr_v0 *hdr = wrapped;
+	size_t wrapped_size = 2048 + size;
+	u32 magic;
+
+	ut_assertok(check_download(uts, image, size, info, data));
+	/* Truncated FIT metadata and external payloads must both fail. */
+	ut_assertok(check_download(uts, image, sizeof(struct fdt_header) - 1,
+				   NULL, NULL));
+	if (type == FIT_EXTERNAL)
+		ut_assertok(check_download(uts, image, fdt_totalsize(image) - 1,
+					   NULL, NULL));
+	ut_assertok(check_download(uts, image, size - 1, NULL, NULL));
+
+	magic = fdt_magic(image);
+	fdt_set_magic(image, 0);
+	ut_assertok(check_download(uts, image, size, NULL, NULL));
+	fdt_set_magic(image, magic);
+
+	/* The Android envelope is independent of the payload format. */
+	if (type != FIT_INTERNAL)
+		return 0;
+
+	memcpy(hdr->magic, ANDR_BOOT_MAGIC, ANDR_BOOT_MAGIC_SIZE);
+	hdr->page_size = cpu_to_le32(2048);
+	hdr->kernel_size = cpu_to_le32(size);
+	ut_assertok(check_download(uts, wrapped, wrapped_size, info, data));
+	ut_assertok(check_download(uts, wrapped, sizeof(*hdr) - 100, NULL, NULL));
+	ut_assertok(check_download(uts, wrapped, wrapped_size - 1, NULL, NULL));
+	/* Android padding must not make a truncated FIT payload look complete. */
+	hdr->kernel_size = cpu_to_le32(size - 1);
+	ut_assertok(check_download(uts, wrapped, wrapped_size, NULL, NULL));
+	hdr->kernel_size = cpu_to_le32(size);
+	hdr->header_version = cpu_to_le32(3);
+	ut_assertok(check_download(uts, wrapped, wrapped_size, NULL, NULL));
+	hdr->header_version = 0;
+	hdr->page_size = cpu_to_le32(2047);
+	ut_assertok(check_download(uts, wrapped, wrapped_size, NULL, NULL));
+	hdr->page_size = cpu_to_le32(2048);
+	hdr->ramdisk_size = cpu_to_le32(1);
+	ut_assertok(check_download(uts, wrapped, wrapped_size, NULL, NULL));
+	return 0;
+}
+
+static int spl_test_fastboot(struct unit_test_state *uts, const char *name,
+			     enum spl_test_image type)
+{
+	struct spl_image_info info = { .name = name, .size = SPL_TEST_DATA_SIZE };
+	size_t size, offset;
+	void *image, *buffer, *wrapped;
+	int ret = -ENOMEM;
+
+	size = create_image(NULL, type, &info, &offset);
+	ut_assert(size);
+	buffer = malloc(size + 2048);
+	wrapped = calloc(1, size + 2048);
+	if (!buffer || !wrapped)
+		goto out;
+
+	image = wrapped + 2048;
+	generate_data(image + offset, info.size, name);
+	if (create_image(image, type, &info, NULL) != size) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (type == FIT_INTERNAL)
+		size = fdt_totalsize(image);
+	fastboot_init(buffer, size + 2048);
+	ret = check_images(uts, image, size, &info, image + offset, wrapped, type);
+out:
+	fastboot_init(NULL, 0);
+	free(wrapped);
+	free(buffer);
+	ut_assertok(ret);
+	return 0;
+}
+
+SPL_IMG_TEST(spl_test_fastboot, FIT_INTERNAL, 0);
+SPL_IMG_TEST(spl_test_fastboot, FIT_EXTERNAL, 0);

-- 
2.56.0

