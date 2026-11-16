Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC4606A890
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qIVHY7XO;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=D3kg6V2V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 571CD60814;
	Mon, 16 Nov 2026 14:01:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SMp-nRr5-R0r; Mon, 16 Nov 2026 14:01:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F4EC607F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837674;
	b=ifVABUavSqziSda7Qmf3eTsgxcmsheZWH/O77mEldmkwPmRlY678QUlyQ79qPE57dTsW
	 Wccsc4OzGX+BMjgVzK89QfEdTummrH03WhDv//8CzToK8MZwZszZCFhLKNZycLZluX8St
	 uw2gz5ImC6eLga0kO0WnPjt1/zlIOgwY1FoScOelDKnTYicAYuOjuocz8zK/5+vYGY0fU
	 mlJeaLDWS0CXWcDSZw+4R/dNT6W+3dPXBxQ3SN8V9+VlX783gIxddmetMtZlUe2HVU3rw
	 8XAl0mDpQBWbi9MiqgRPNsSzwkvVfUJdqUNnN/EBeiSmu8U/5ZsXq68wPVArGGbJe7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837674;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/e/QqVGK2V/35Y2G04sK9Wnv3KC0igy6EHM+hHh0gO4=;
	b=itrBWyrVKuJA5MW2eumxYhSlA+2Rg/XowW4UUjarijeDkcSLoNE64tv4DL/G5vaC3L6u
	 nKOK3GxBxIZYg1QOIW3tvNQ7NAVjImd+XuqoAeXMLDco86h37Swlh7oo3mKm2ckEaBf5U
	 6ZeGCt5cxhF50yF/aySHbbsUw/3clBu9Ey/pwNmuPrh6H0cCSG6qqFd2uvIqypku0oqrp
	 1d7HCSEBYl5NXEqeH5A3tJKNsqw9vAuwp7RPxYpvFcTJn1GfE4elfIMl383cIJ1+u2A2C
	 Ke7aPbHAAr1gfvHu2seF3Wsu56XBiS3XTqTUrI8CuU/Utj8hJyb6GK/QBmuTxWzOZwQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837674;
	bh=/e/QqVGK2V/35Y2G04sK9Wnv3KC0igy6EHM+hHh0gO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qIVHY7XOdqlWJjd6YchaHQtVvKjJS+Kje+yhtogvn9vqPbdjmE5V9OIr73nhlMqZV
	 f0TqKmk5qUYCgl/k6lFpJ58dpV0mTP5ytzBhShBJlqgx3Na7ytEsCDjfyIl5njSFGX
	 N+9x8PNcHV9q+A8v8cH9KvYwJtlgc0aHGDI64FpY3jMqFDvCgCOi+tV3debmODCuc/
	 FaMxua3m/i2+IFe0hqWh/mJW+2L4+V0z2Exnl/1spT9ZuizjqXu+McJLU8ZxcHNyCN
	 j0Lx/krTnxJIo+yaOZ1WCRZASSfm6kY3NhYukiAhnJp5cuMuraM9laglkEWpl5NPyb
	 yxZhy9pslUewQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F4EC607F0;
	Mon, 16 Nov 2026 14:01:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B03072FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9153680F49
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zJT67zNq_jnz for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:01:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A9EC80F4A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=D3kg6V2V
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A9EC80F4A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:01:09 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so3152413f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794837668; x=1795442468;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/e/QqVGK2V/35Y2G04sK9Wnv3KC0igy6EHM+hHh0gO4=;
 b=D3kg6V2VLMIOaTAjIXlh/PlF0imhcUFTjxkCkDey0rTXK/kd30YC1WYKHa4798LSAV
 b2y99btqMYXNSg3J3EXADyx1nrtAj1Qrq0+6efqbmeuhqyxUhIAOX7u6D6qSdC2e2IRI
 c3cqT0BsRFmRWBEWcdMhZg5upw288qtkhQXKu26PMMBj2yf3Pgj7ZJwDB2uuwgL/3sTK
 h1fzcJZF9wI9k6Frb4YL8Rwj7OuBfhkRwvsQLNoTMn1d2p34rASoxgXEw9llg4z87xKp
 WD6x/xDlxZQey73bJsiedGHRq1xIQZjDLLPsgtBNrVzLYk2SWAwdeTyyHlEGkoa8f/J8
 s1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837668; x=1795442468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/e/QqVGK2V/35Y2G04sK9Wnv3KC0igy6EHM+hHh0gO4=;
 b=EYSGIzfpO4AqX5cx8fKJnbqprqRH7nkqkUp71Kz3WxTJ3Jhnljj7fHZqHsfuI3nNwt
 6waY073EFY4006MX7wcreyFlHLxlpHQAUIXsMM2dK0W8kdqzGejxgas+Hbet8yWbbVpQ
 dZjZGuOykKaYdYTvBmmVy3NEErLNMbGCsT6fneTlvAAbO/mPBcSgILiJ9rG/kOmGmgnB
 Hjq7fxzTXseJwRzh5vWRmoiNJFtAcwK7TvZrxOFDUBGLMPYYxD+PYBeOWfkJgI+9SkcD
 7SoZzbc9C9lazQYnlfDGMU+OMxg8ACG3+6FRxFA6pCs5IS/i4UF6gAcXrtJJpf8bFjp6
 Y1yg==
X-Gm-Message-State: APuU4Z8lIFezRc1er/1uTxfNGD22vnK2ZbCzSC6FhgYFeUtma9vvIex1
 vtwxz74Cm++bLHuJULAxEDs4Qj0k7d/dqqNtVOAzaSL5SdBYDaA0nz5pGP++kQG7U6A=
X-Gm-Gg: AZFdTZfIlxBGaJOrVXR83x+7tyoCYfXv3XKjR+IpU99zLsV4/Qhghta3t9wU7aQQJsA
 saRg3t0rrEF+VjZ5a1DXUOZu7WWGFQr/6lzlIHc7da3mmlS+V8Ujc/uSpb1OesDA16lZ5m3LE3g
 QfYjgRLc9VfVYbvNqxCUVv/xy4I0752A4Jqq5bN+VijS4WkLnJkG5RfxXP+NHXN5mPk1lF0Cftd
 azIJoF4/Ml/p/RNay4ZzfVkrhlHeudFAKYO6eDO/dUVsstPQHxo53V+MqB1c5y4IO7V1aKYQ7tR
 WVAYreOGUpy9enU0u3D392BpZd74flGY9IktL5ZfYE+xQPtnnkElcz6/Vbuc59IdBcN3lZJ3P/U
 01Zi8eowmjKBip5ALOJg7JMZJFnyJy0iMkBEp7fIU8B8jpf5qsVZ0Cm76OwehU76Y1o9HwRciOT
 zmsbG+wfyCJ06Hag9HMesmCy/N5wAv5muZSMkfX380yk7wRDaELEciUbGV4eAeqJEdiiV0gbNkf
 aqIWRzo/p2mAHW1xZh9se/Q6KrCRUTX9rFB3POwt2IarkimqyBPvnSnSNXBC36ljqAqGwD63gRU
 2mcreOaRanX4lE2ksWpAabMAw1Xcq+S5yAXFqQMsyONMoK+8kZw4qnOVAsA963nDb4b0dxupdO7
 zbigY1J6qcicZTElW599hbdZLo8TBAsMHds+FIo2tJLdHOA==
X-Received: by 2002:adf:e190:0:b0:493:8847:841b with SMTP id
 ffacd0b85a97d-49c70b059e9mr22676672f8f.19.1794837667690; 
 Mon, 16 Nov 2026 06:01:07 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c69406640sm22119355f8f.12.2026.11.16.06.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:01:07 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 15:00:52 +0100
Subject: [PATCH v3 6/7] spl: fastboot: support legacy U-Boot images
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-spl-fastboot-boot-v3-6-7b39e7a348c6@baylibre.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boards using a single legacy U-Boot image should be able to test it over
fastboot without changing their image format. Use the shared RAM reader
and SPL loader, with the downloaded length limiting header and payload
accesses.

Keep legacy support optional and reject compressed images, which this
RAM path does not yet support.

Reject legacy downloads when SPL FIT signature verification is enabled
to prevent bypassing that verification with an unsigned image.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/spl/spl_fastboot_boot.c |  4 ++--
 common/spl/spl_ram.c           | 32 ++++++++++++++++++++++++++++++++
 doc/android/fastboot.rst       | 22 +++++++++++++++-------
 drivers/fastboot/Kconfig       |  7 ++++---
 include/spl.h                  | 11 ++++++++++-
 include/spl_load.h             |  2 ++
 test/image/spl_fastboot.c      | 13 +++++++++++--
 7 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/common/spl/spl_fastboot_boot.c b/common/spl/spl_fastboot_boot.c
index f52ea83b230..6a765f91cba 100644
--- a/common/spl/spl_fastboot_boot.c
+++ b/common/spl/spl_fastboot_boot.c
@@ -11,7 +11,7 @@ struct fastboot_image {
 	size_t size;
 };
 
-/* The standard fastboot client wraps a FIT in an Android v0 boot image. */
+/* The standard fastboot client wraps non-Android images in a v0 header. */
 static int spl_fastboot_unwrap(struct fastboot_image *image)
 {
 	const struct andr_boot_img_hdr_v0 *hdr = image->data;
@@ -54,7 +54,7 @@ int spl_fastboot_load(struct spl_image_info *spl_image)
 	ret = spl_fastboot_unwrap(&image);
 	if (ret)
 		return ret;
-	return spl_ram_load_fit(spl_image, (void *)image.data, image.size);
+	return spl_ram_load(spl_image, (void *)image.data, image.size);
 }
 
 /* Sandbox tests the loader directly, without a physical USB boot method. */
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 75a3e5904b8..d93f4526d5f 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -14,6 +14,7 @@
 #include <log.h>
 #include <mapmem.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <linux/libfdt.h>
 
 struct spl_ram_image {
@@ -51,6 +52,37 @@ int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size)
 	return spl_load_simple_fit(spl_image, &load, 0, fit);
 }
 
+int spl_ram_load(struct spl_image_info *spl_image, void *buf, size_t size)
+{
+	struct legacy_img_hdr *header = buf;
+	struct spl_ram_image image = { .data = buf, .size = size };
+	struct spl_load_info load;
+
+	/* Require a complete magic word to identify a headered image. */
+	if (size < sizeof(header->ih_magic))
+		return -EINVAL;
+
+	/* FIT images can contain multiple payloads with separate load addresses. */
+	if (image_get_magic(header) == FDT_MAGIC)
+		return spl_ram_load_fit(spl_image, buf, size);
+	if (image_get_magic(header) != IH_MAGIC)
+		return -ENOEXEC;
+
+	/* Legacy images need a complete header and an uncompressed payload. */
+	if (CONFIG_IS_ENABLED(FIT_SIGNATURE))
+		return -EPERM;
+	if (!CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT))
+		return -EOPNOTSUPP;
+	if (size < sizeof(*header) || !image_get_data_size(header) ||
+	    image_get_data_size(header) > size - sizeof(*header))
+		return -EINVAL;
+	if (image_get_comp(header) != IH_COMP_NONE)
+		return -EPROTONOSUPPORT;
+
+	spl_load_init(&load, spl_ram_load_read, &image, 1);
+	return spl_load(spl_image, NULL, &load, size, 0);
+}
+
 #if CONFIG_IS_ENABLED(RAM_DEVICE) || CONFIG_IS_ENABLED(DFU) || \
 	CONFIG_IS_ENABLED(PCI_DFU)
 static int spl_ram_load_image(struct spl_image_info *spl_image,
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 9898348c961..73241e717b8 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -120,8 +120,8 @@ Reboot commands require ``CONFIG_SPL_FASTBOOT_REBOOT`` and a platform
 and ``reboot-recovery`` commands also require a platform
 ``fastboot_set_reboot_flag()`` implementation.
 
-Booting a downloaded FIT from SPL
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Booting a downloaded image from SPL
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Enable ``CONFIG_SPL_FASTBOOT_BOOT`` and include ``BOOT_DEVICE_BOARD`` in the
 board's SPL boot order. This load method starts the fastboot session itself;
@@ -151,11 +151,19 @@ The host can then download and run a U-Boot FIT without flashing it::
                                 | running from RAM      |
                                 +-----------------------+
 
-Use a FIT built for the target, including any firmware required by its normal
-SPL handoff (for example BL31 or OP-TEE). FIT verification uses the board's
-existing SPL configuration. Raw U-Boot binaries are not supported. The loader
-accepts a bare FIT or the Android v0 wrapper added by the standard fastboot
-client; separate ramdisk and second-stage arguments are not supported.
+With ``CONFIG_SPL_LOAD_FIT``, use a FIT built for the target, including any
+firmware required by its normal SPL handoff (for example BL31 or OP-TEE).
+FIT verification uses the board's existing SPL configuration.
+``CONFIG_SPL_LEGACY_IMAGE_FORMAT`` also permits uncompressed legacy U-Boot
+images, using their header's load address and entry point. Legacy CRC checks
+follow ``CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK``.
+With ``CONFIG_SPL_FIT_SIGNATURE``, legacy downloads are rejected to prevent
+bypassing FIT verification.
+Raw U-Boot binaries are not supported.
+
+The loader accepts these images directly or inside the Android v0 wrapper
+added by the standard fastboot client; separate ramdisk and second-stage
+arguments are not supported.
 
 Keep the download buffer separate from SPL, its heap and stack, and all FIT
 load destinations. ``CONFIG_SPL_FASTBOOT_FLASH`` is optional.
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 637fb9e4541..ea3be618470 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -68,12 +68,13 @@ config SPL_USB_FUNCTION_FASTBOOT
 	bool
 
 config SPL_FASTBOOT_BOOT
-	bool "Boot FIT images downloaded with fastboot in SPL"
+	bool "Boot images downloaded with fastboot in SPL"
 	depends on ARM || MIPS || RISCV || SANDBOX
-	depends on SPL_FASTBOOT && SPL_FRAMEWORK && SPL_LOAD_FIT
+	depends on SPL_FASTBOOT && SPL_FRAMEWORK
+	depends on SPL_LOAD_FIT || SPL_LEGACY_IMAGE_FORMAT
 	depends on !SPL_LOAD_FIT_FULL && !SPL_USB_SDP_SUPPORT
 	help
-	  Enable fastboot boot to load a downloaded FIT image through the SPL
+	  Enable fastboot boot to load a downloaded image through the SPL
 	  image loader. Boards enter the USB session by selecting
 	  BOOT_DEVICE_BOARD in their SPL boot order.
 
diff --git a/include/spl.h b/include/spl.h
index 2b12dbb7215..3348b424b54 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -999,7 +999,16 @@ int spl_dfu_cmd(int usbctrl, char *dfu_alt_info, char *interface, char *devstr);
 int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size);
 
 /**
- * spl_fastboot_load() - Load a FIT after the fastboot USB session has stopped
+ * spl_ram_load() - Load a downloaded image from RAM
+ * @spl_image: Receives the loaded image information
+ * @buf: Image buffer
+ * @size: Number of bytes in the buffer
+ * Return: 0 on success, or a negative error code
+ */
+int spl_ram_load(struct spl_image_info *spl_image, void *buf, size_t size);
+
+/**
+ * spl_fastboot_load() - Load an image after the fastboot USB session has stopped
  * @spl_image: Receives the image's load address and entry point
  * Return: 0 on success, -EAGAIN if no boot was requested, or another error
  */
diff --git a/include/spl_load.h b/include/spl_load.h
index 31ed5651f7b..44c972b10fd 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -114,6 +114,8 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 	IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) + \
 	IS_ENABLED(CONFIG_SPL_SEMIHOSTING) + \
 	IS_ENABLED(CONFIG_SPL_SPI_LOAD) + \
+	(IS_ENABLED(CONFIG_SPL_FASTBOOT_BOOT) && \
+	 IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT)) + \
 	0
 
 #if SPL_LOAD_USERS > 1
diff --git a/test/image/spl_fastboot.c b/test/image/spl_fastboot.c
index 39dc784e5e6..1263416ba8d 100644
--- a/test/image/spl_fastboot.c
+++ b/test/image/spl_fastboot.c
@@ -92,6 +92,12 @@ static int check_download(struct unit_test_state *uts, void *image, size_t size,
 		ut_assert(ret < 0);
 		return 0;
 	}
+	if (CONFIG_IS_ENABLED(FIT_SIGNATURE) &&
+	    !(expected->flags & SPL_FIT_FOUND)) {
+		ut_asserteq(-EPERM, ret);
+		ut_asserteq(0, loaded.size);
+		return 0;
+	}
 	ut_assertok(ret);
 	ut_assertok(check_image_info(uts, expected, &loaded));
 	ut_asserteq_mem(data, map_sysmem(expected->load_addr, expected->size),
@@ -106,10 +112,12 @@ static int check_images(struct unit_test_state *uts, void *image, size_t size,
 	struct andr_boot_img_hdr_v0 *hdr = wrapped;
 	size_t wrapped_size = 2048 + size;
 	u32 magic;
+	bool fit = image_get_magic(image) == FDT_MAGIC;
 
 	ut_assertok(check_download(uts, image, size, info, data));
-	/* Truncated FIT metadata and external payloads must both fail. */
-	ut_assertok(check_download(uts, image, sizeof(struct fdt_header) - 1,
+	/* Both metadata and payload must fit in the completed download. */
+	ut_assertok(check_download(uts, image, (fit ? sizeof(struct fdt_header) :
+				   sizeof(struct legacy_img_hdr)) - 1,
 				   NULL, NULL));
 	if (type == FIT_EXTERNAL)
 		ut_assertok(check_download(uts, image, fdt_totalsize(image) - 1,
@@ -181,3 +189,4 @@ out:
 
 SPL_IMG_TEST(spl_test_fastboot, FIT_INTERNAL, 0);
 SPL_IMG_TEST(spl_test_fastboot, FIT_EXTERNAL, 0);
+SPL_IMG_TEST(spl_test_fastboot, LEGACY, 0);

-- 
2.56.0

