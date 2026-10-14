Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0FACC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB37880E09;
	Wed, 14 Oct 2026 12:25:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yU3FSufXfIAb; Wed, 14 Oct 2026 12:25:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BCAFE80DE6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980704;
	b=ch4LJctsieUmpTECnfmCANQ6OCfEAl+VsqzJL9Jiu6I+qShr2Tajldl0xn/23GmVE+6k
	 8tRuaPkyYLMqJoBebKzjetaK5OjwZX1k3ijY1ZXgSYYCl2sSQy7A2C07QTyhn8Pj86FDH
	 ebT8GnD0y01ZhB3Nlgexv+ZE0kJRKjdcSZs/1hWptMDWXzEdRMFxDcseeqj0VOVF3PF9x
	 jGLgYZ7WCk1ihv91A9FFltrG9hzY4QZsRHaaOd8UwWzugy45ca7iG7PVcD25yE/nHkIMg
	 oT0nRFeYI9Nl3Rtr1XvYhz4mDuj9vmiGK2MT/pVTLr6r7cxPoObEk6d6x+0Lni25VPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980704;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UDCZrJwViPPd+ahw84KG+aK67ALTyhPhFMmXlAGHCmc=;
	b=IuWSO4GjHLmlO7W06vdO1FiVNvGcVd5pBuC2elefmzy04A55bKHmMAxQeu0Z5ORn9Q6E
	 1Ek6sNkk+/6fL/P1OP5gLDhnMYQm4nRfSQVojVHbljdKhNxcC3x3BKAldhUJywbptlR12
	 YorWvBS+8x2Qva74unhB2ldWaH2fEui+venBkHiHX4kmDq++2fdII29EkUPoTx0BpDOym
	 6GHVv5MnSWeOe8ABUqvGlEqxS6oNkENQsvIZHP9pwm/Qrv8h3MsCQ+A3cJ8KVjI82O2fT
	 0CRFf5dCddPxoOT+eEGRALnitCJLIk4qj9s9BBI2QtHh6wmZi9pzLpxGTF9F1PHCtPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CGQo+H84;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980704;
	bh=UDCZrJwViPPd+ahw84KG+aK67ALTyhPhFMmXlAGHCmc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lQrtdtTjR9O1xjzWVi5o+5uRV9xfmP/3FFTZTGW/D0hnR9RF7isiWXrEA+UjG5gZ2
	 Lw/QZo6qlQdmorjfIkdRUJd/Sntsx0taelRNOQZyinI3el7zQUujEFbZWr5gWyf7Yx
	 PDqfUi5TpaRaSW1jZxhkKm0GtZGs1/l999aQqxDoaQAcV/yVQEv8WG5fWMwd8TQMAv
	 s5fSBsPFzwUMOYdlb5tV06nFxpbmsvEqtM0/34KBFyD2CCTQBtOGWuZr/++LISR2BQ
	 P7NpzgcuSF/i1VWuMD5B6jf8pfkwcEiv0dXnokrV4fuo4ytUocm8UC+zOmfXzl7W+4
	 8oovisvcS4Xww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCAFE80DE6;
	Wed, 14 Oct 2026 12:25:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CFEC2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E88280DEC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kp1AGYNcmQJ1 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:24:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25DA780DAE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980699;
 b=sKgpe+tkPai7QJSfVsFFFsYeZGvuz5gbNzjAlyTberyUcnZYg3Hw3OaXtvGyiuJX4GoQ
 FZ4JNbv5zm+83PdBIEwYwxun5ODFr/DFzBl//DVmMWtEGOtawnInVdOAGc7g+6l/nOyTD
 by7OdkUXVuj6id1jylLbzzRcmwOoyL9YUCApvgIeLdBn7II/ctTwD4VdAcYL7z/+rpJbw
 VfDMOaWF+o6JCE+/mzMO1YgpCWYrp6hiGj512hTOmTPneUSJe4jyOkg9Ey703RRL32aMC
 J9uGwqrgpOyCukqS/+YgUyUaTsgbbvKiD+6g21FmImSe1VYSWb4OH0o9h7nj7hcCpfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980699;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=UDCZrJwViPPd+ahw84KG+aK67ALTyhPhFMmXlAGHCmc=;
 b=PSSQiCh++j6rAB8pNU0iwf/2yiO/BF5B0wuoB3bC+32Dl/aPY0VhTRVeFLObbqoMLRcC
 B35pWNcFBV/yOKdbsQNFiJ/M6qhLjUdayx+kgkiEXpu+GKPFIJ7O7YFxz4yFf5fMsFJh+
 M3AujFrS7XGldeSFfC9z1LaKbMWK1NFm6FIfdY4/ujN/LtDMlgXMeIY1aBE28WcO02KHW
 I+8j7UBLoWVGfCtY6uKl14UtgwKDjsbphkr5Xlhf4Vsvi16wgekbnAzqGUTaQJhbPp8kW
 IsN4HAEbXBB77sBsmnUxbpRk/MVHJv5IeNn39p/W0fCS7ZvuqIwJWmPP9rd8BgMLnKQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CGQo+H84; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CGQo+H84
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 25DA780DAE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:58 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so8123045e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791980696; x=1792585496;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UDCZrJwViPPd+ahw84KG+aK67ALTyhPhFMmXlAGHCmc=;
 b=CGQo+H84awQeaV7phE/rbt7hdyQuvwJdrDSKF50WO/C3FfEYJD1rTaK2485wU618wG
 lql40LyVKENSWoKBEUT2erlsNXEA8SgjsuxqgxBUvVphWnHbFviDJsV0f09tbdDgJGwQ
 zsJdsgZex/l0S0jJK/ac8LzO8mu/stv1giYOH3w/ROWiHo3XTdvr2yj2kOBL0Sd7nKxh
 hLv60GMguUV5YQCIXFhzmwfmxI/ZGMeeuoQ+Tcimtvk9LD6GfEIw0UXVzBGuPjsMx4bO
 9yszi0918/1F3GSwJ9k48AMOp7FdzqQ2r03YlhbJA/1oqiEb7B6kLg+wJir3Dl9lberv
 NVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980696; x=1792585496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UDCZrJwViPPd+ahw84KG+aK67ALTyhPhFMmXlAGHCmc=;
 b=QjsvZS8mDB0VWr9KHJGz4WpMRKLa4pkRLa9kMfvY8ZLqJbS1YEoKL/cM2J+GdWPfpk
 EKHq4/pRXc+jypKsdgHc3/ZFAE1aaHMMcgZvSRUSNmBqG6etZYiXAWHNKXsiBiRdtryq
 H9mlUJhewLNC9o7lMvl74mDtrd1D6YKLlVTfarLspUwcB6iQY+dJa0okx7I/LiE6iQJv
 HDHUA8lPz4XTNRJPxiZ0A7F+bEGty/jIhOly9njO1OYUeAVGHzO7Y1SxOKnBEjAV329I
 4dPXEh2za8fBeZ1J0savHpnzhLO7C62LoHzMpA7dlyL6yVjDKGCVmbnf3Fva/ierCV0D
 +1ZA==
X-Gm-Message-State: AFq9FYImgmNwzdFOxgVNCASISsdlNQMvvEUuDi0xv73QZ3azsXCM/PJu
 O7/zXlwEwjo62Tkh5f8VVLCCvjMZJF1vmZlDUpxZ0InoGF6xvW5TnAfWMBZ0zxVnut0=
X-Gm-Gg: AYBFou1HeWdwe6t170vzJgK3nHk2JYRQ5YEliq0N0MMDeCAek695tlUBVqQbbgchKUT
 h3JcDuIrFh3mwPqUmAma4FCUft8hTZU3EAtZdiQGhialK76R8dhQdNQ2H9OjR34pjqG+D6lgyY4
 nCa7wZ2PoGtPmKj7DNU0TvkB/MQrw68hGKa2Q/L+x55JwENQ0y4zoUN4WN8x1DPKUeOZKQumwXB
 lACnTy9LinM8JvkHcyTQ9eggATPjrQlAHD6gZO0Vck00Y46k/tpzibCBDFi7ySpfcityWSaetXD
 G/MP5ARZBZR21hzdfZuwcDeaMqHDUR7ir8wZQozHGGVMIOhVh4JgrIDE24XcT2HAWpiSiOhmj/k
 XtMUla2jhI18XeAcmJ6XuewNntXD71IxE30X14LPrjUha8vXSYj3LcpFqzDUIXXwEREuAKnQXXK
 3fGxRHBBjoJxVIZVqS7eiJQm5xCvgya3NNhbsS2TDMUF23MpTewjZtggcjHC/HkToRYj170uVC4
 d+3DKH5W8lRuN0EZSponGoATof1EQkmgopQMBJQ0zgjGtiBwbVlotoSaVvX+gma1lfS1pNmOTzA
 k3IfedtxAr3XhCg=
X-Received: by 2002:a05:600c:4e43:b0:4a0:1f90:594b with SMTP id
 5b1f17b1804b1-4a18e4b67e1mr300987725e9.22.1791980695572; 
 Wed, 14 Oct 2026 05:24:55 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2fc4724sm50351815e9.2.2026.10.14.05.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:24:55 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 14 Oct 2026 14:24:33 +0200
Subject: [PATCH 5/6] spl: fastboot: support legacy U-Boot images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ccaione-upstream-spl-fastboot-boot-v1-5-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Boards using a single legacy U-Boot image should be able to test it over
fastboot without changing their image format. Use the shared RAM reader
and SPL loader, with the downloaded length limiting header and payload
accesses.

Keep legacy support optional and reject compressed images, which this
RAM path does not yet support.

Reject legacy downloads when SPL FIT signature verification is enabled
to prevent bypassing that verification with an unsigned image.

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
index ee588ef4718..43d9bc95516 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -14,6 +14,7 @@
 #include <log.h>
 #include <mapmem.h>
 #include <spl.h>
+#include <spl_load.h>
 #include <linux/libfdt.h>
 
 struct spl_ram_image {
@@ -48,6 +49,37 @@ int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size)
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
 #if CONFIG_IS_ENABLED(RAM_SUPPORT)
 static int spl_ram_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
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
index c2055132ccc..f57b959f0ea 100644
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

