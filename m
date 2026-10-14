Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1781CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE5A2406F2;
	Wed, 14 Oct 2026 12:25:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YcSbCjeU9xSm; Wed, 14 Oct 2026 12:25:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88CB5406D4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980706;
	b=ofyHx9ezmTVuCs4ntosBRCBPgdYWPKMeskKuqaNU1tM91qVKUc5qNclbn/wu+jeMW6yj
	 O26omqlEdorWbGhafbI9AYhcWuU+QjtABLax+NmavqC2e2PQrlqTVkUFJRg+5xNMjdOhy
	 noiod/hDST4fZyc6ocRW5PTHTTMU1zR+JsREt1x+9aF0MZaR9eT4rhOLUe2nKi/L/b0d4
	 c3MfYxoANk5TgdGNB3fGhwuW9dHQQWgBv9ctPyPtF37s+N5fS1vKRqzrtfrGFdqyxG8hV
	 BYKlyJEH5yJYXIbH5DZV76xdkIVxR+3LdVBKpqTMhY3ZTxuOmr2m1D23e4SR+Qg23pA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gtlbqiJydmlnuknM+ebjr/TUCbpY+PiHUz2Jcq3ZyW8=;
	b=Qh0FsqSPzFou7qPKjwurW3SXj2yU5a/z+VbqbmkY7qAw5mV7OA8CHOuGhobcaNJ28Xij
	 ts4kpwgVoyVrjz8Dsu+9LyqZzJQCAI1hP71so22I4qGcAUns/N3y85/XKc3jac4INhX8X
	 1KdnF8XI8pHmaBherCqTB+2IjLoTRXBq3ktaHeoTpahwwqvLSCJ8dKtq6nmbJBb2S1y0o
	 9grIKJ5Y9Fq5TS/AX7OBxZIT7EznxcCDMj5L6jtqgc9HgxpL77Qgob2K/8pdkpYnpDb+q
	 McdYRZPx+ksAagV4w6vrqCsOZZNBB7KBdSFe50PEpvyXMIb8oROMuC/U49qcdcF2pVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980706;
	bh=gtlbqiJydmlnuknM+ebjr/TUCbpY+PiHUz2Jcq3ZyW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IauxjIbrFOqLWH39rwntAVQiQSZs5nLuTAeIQFNM5Xw/zk/sR8+/bUJOMg9DQeKsw
	 hhy22vS4VsPo6wzQeD/q7El0OcduCcjDN/aXk0N/yZTecdpVk+TyCOoG9oQHv86pad
	 R2mTsxqTQw2z7FKJeMZmZefQkXCr0SMjQXCQRLk4YnJOFMl+USwVuMlKi9GsZEMY9K
	 TwiiQu8KFTx3QU1tuqFYsjlr7DmVVKYtqweG3yBWqvFMOe2JZBNtcK7/tIWVZ4D+Q3
	 1lb2jSpEKSRwe+qY5c8PUJqpn3uM/NZjser2JRpIw4b+bGNVLNEX/DGdfitoSXC0qD
	 wuRcOSblbY4Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88CB5406D4;
	Wed, 14 Oct 2026 12:25:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BE08A58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE17980DC2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ej2TspZs9d9z for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:25:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 96FC780DCB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980700;
 b=EuL0CzGyBpiuLWRQB63+GtsIJrrpiJdV++RXydJybUQDOyzz8F1IMvHILVU98sjM2A+9
 0vtZvy6b+aJGOE3XsaXDatQdhtIvGvR1r139EClQb0G9kjpK4PcS2F760r2hueY8i+T7X
 2fSS9CkN2GYs3pm6zphDcNAZD+BNWnoRA93EmynPLh5opymbvqXhwRJIJzuefm8YUvj56
 QdgbfZhCC5jSxOAS35cwQRVy/kqaDfcOeGnyerIe0k1tQHeo6RojpJy2/TW1wpdWlxEaI
 8jCcRr8K67kiO0WBMiSY5vjtZwGd2OlXt9GI5TJeUZuZceBuDxItQN2+vV13buuenUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980700;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=gtlbqiJydmlnuknM+ebjr/TUCbpY+PiHUz2Jcq3ZyW8=;
 b=a5i1Goss4Xz1s1hiBTrRcsb38Gr6njjseKyvJgjpevyS6eJS/YRKpIVCpk5hkRUj+FM+
 izXbO1dva431/F4m3eL97igGGTrkV5rCD6kxkm9a+RrIRSq/N7IEKnLEJYgYWmZ+GOjfz
 adCtex8SNJLnQ4anaWKn7PTFaYigA3DE1rcqOKYuLmBHsSY7if50KMqXs5qAXkZ2PgzLl
 Jik/MPWxFZaCpI4WyTj4hTNE4AhLI+r+9Y2tbrXBAFlnjnElG4LZuRwGNsB49vnVfgmI+
 N/b1kh3tACwnLqNVqaTEV1hgN2+jWh+tNVE73DYwImGUG7QmfAD8IKzTV2Thz4EUnrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=EZZPDJc0; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EZZPDJc0
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96FC780DCB
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:59 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso31585785e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791980697; x=1792585497;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gtlbqiJydmlnuknM+ebjr/TUCbpY+PiHUz2Jcq3ZyW8=;
 b=EZZPDJc085tzob6xmNnTRd2Jdg5kbtEZBTaN0ecb+o43ucblNDWg0vcy2DEof6eGdm
 iN46MO93aRHm4n5pKESj8EEzcpELOIgDHvFsTYojNx2gaIZ021KRFmARCtGe79H0ySsO
 smMvhRL9q7ov+elBXDSB58qJ4xHMD3YuWGdLsuuvn1wgWDM1H/JFV8Ip0yygBx6gno7M
 M+OeXYIPDckkJ/AKt3WxdOqFZVxxoitzcj5YOt8/IwiQxtyT5ay6splGBo/WlXpkl63V
 azkCvGaPGkZHrzbvkjG2Ie6qhjPwmR+Xkf3qyqwgMSuoJw+kVi5/OVMO+yC7/hPW4yEk
 Y5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980697; x=1792585497;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gtlbqiJydmlnuknM+ebjr/TUCbpY+PiHUz2Jcq3ZyW8=;
 b=qRNlFxY5QIh6x1PB0Riwpdj7XELwPaLR2wj5XgibasMaBBnLCAnyhER49TEh45jyYf
 X1V9G322vp3X1a1npe3Q0MnD5xl1p41ri5n+x94RkUlFeTUY7Y0h16lFaT9e4N0tQM85
 +jKdJgBBx4JEDDZy5dbYIfglEozqEOTgz8kY0TZCsu2kV0g1SGpZh0EpXfLfTc/hd0c8
 Quwfqsu9vOyaTG12qNxkjblN3CeqJ67EC3nZPkJtqsTk1+YQJjdYWlgKuDIlWFwHAlcB
 FYr+FW0drCasPp35VN17tpsi1Rt6PJ2YdsWUC6BamutFrfZpQoMS+65oU+ftJtCK9jI/
 eBAQ==
X-Gm-Message-State: AFq9FYK0xFfYyM9pW5Wa76R3lLVV6lUzQbtBF6ygw1cG5qKtBhKr0jZy
 BZz5HqoquF2GaDmMcPNr5pqvlll9w9+wV4K5lxrq+f9fdvJHoY79Y0olvMsISbvaGqs=
X-Gm-Gg: AYBFou2LHWKT9h8fW5M3jVZvaLEZIAyfvtvQAS8QP7C8zIhJJGq3m+EPbg/kULt3Kx8
 h4i1xrMMQ/+P7CRVdQ1zn09IkseJrB1nIyhrBM+gLPX9+cl/i+Ij+8FAe1RAjwd3iR0pbDK8eW6
 7NhnigLW7R1PKd0dup7UR6nIhpOIdSeUI7YlL1mAY0pdx5RaCzdo5tT2djrXwObCnc5pOpG6M9z
 rigMUDGM15PBMJcXZUQJMwoybjhfmothjtXpQoQtE6n3W9/DpvUQzMz7JBaa1uM2dN/cXg7W+TL
 rdk1exJjJy6tFzXwDTDq3KZlV1j2s1fgn/Bx4uoOIOap6BYFmlOpK7L35Ssi48HGRRpxiH3P6kT
 n0ajvetgAHo5bTTeXIiU3hwJtcRVFddfdob+5qKRcxKVGudm16s2ctZ08TuM+wGRYv9/uE1Veru
 uTxTzKbNZrzAol7qNlcfpnEuLoMJAl/etkku+Qwl2bDjHWDceRVUL6MX1AMz0QY1BmhaXaz/HPe
 LZOMkSIsiEgmU/juYbdbGAa5SsUHO24Jn/rC8nUB81JaB31EfSGRRnZ5LSh4hSzYnLyMSCt3NY4
 W1NJJUC47Fo4ZTs=
X-Received: by 2002:a05:600c:3146:b0:4a0:34a:588c with SMTP id
 5b1f17b1804b1-4a18e4a7cb9mr308670025e9.14.1791980697068; 
 Wed, 14 Oct 2026 05:24:57 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2fc4724sm50351815e9.2.2026.10.14.05.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:24:56 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 14 Oct 2026 14:24:34 +0200
Subject: [PATCH 6/6] spl: fastboot: support raw U-Boot images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ccaione-upstream-spl-fastboot-boot-v1-6-d29df15fb9b8@baylibre.com>
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

Boards with fixed U-Boot load and entry addresses do not need an image
container for RAM boot. Allow raw downloads when SPL_RAW_IMAGE_SUPPORT
is enabled, using the board's existing address configuration and the
completed download length.

Keep recognized FIT and legacy images on their respective validation
paths, so an invalid container cannot fall back to raw execution.

Reject raw downloads when SPL FIT signature verification is enabled
to prevent bypassing that verification with an unsigned image.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/spl/spl_ram.c      | 28 ++++++++++++++++++++++++---
 doc/android/fastboot.rst  |  9 ++++++---
 drivers/fastboot/Kconfig  |  2 +-
 test/image/spl_fastboot.c | 48 ++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 43d9bc95516..463f5e48929 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -49,21 +49,43 @@ int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size)
 	return spl_load_simple_fit(spl_image, &load, 0, fit);
 }
 
+static int spl_ram_load_raw(struct spl_image_info *spl_image, void *buf,
+			    size_t size)
+{
+	if (CONFIG_IS_ENABLED(FIT_SIGNATURE))
+		return -EPERM;
+	if (!IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT))
+		return -ENOEXEC;
+	if (!size || size == SIZE_MAX)
+		return -EINVAL;
+	if (size > CONFIG_SYS_BOOTM_LEN)
+		return -EFBIG;
+
+	spl_set_header_raw_uboot(spl_image);
+	if (size > ULONG_MAX - spl_image->load_addr)
+		return -EOVERFLOW;
+	spl_image->size = size;
+	memmove(map_sysmem(spl_image->load_addr, size), buf, size);
+	return 0;
+}
+
 int spl_ram_load(struct spl_image_info *spl_image, void *buf, size_t size)
 {
 	struct legacy_img_hdr *header = buf;
 	struct spl_ram_image image = { .data = buf, .size = size };
 	struct spl_load_info load;
 
-	/* Require a complete magic word to identify a headered image. */
+	/* A buffer too short for a magic word can only be a raw image. */
 	if (size < sizeof(header->ih_magic))
-		return -EINVAL;
+		return spl_ram_load_raw(spl_image, buf, size);
 
 	/* FIT images can contain multiple payloads with separate load addresses. */
 	if (image_get_magic(header) == FDT_MAGIC)
 		return spl_ram_load_fit(spl_image, buf, size);
+
+	/* Only unknown magic selects raw; recognized formats keep their errors. */
 	if (image_get_magic(header) != IH_MAGIC)
-		return -ENOEXEC;
+		return spl_ram_load_raw(spl_image, buf, size);
 
 	/* Legacy images need a complete header and an uncompressed payload. */
 	if (CONFIG_IS_ENABLED(FIT_SIGNATURE))
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 73241e717b8..73b7825d726 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -157,9 +157,12 @@ FIT verification uses the board's existing SPL configuration.
 ``CONFIG_SPL_LEGACY_IMAGE_FORMAT`` also permits uncompressed legacy U-Boot
 images, using their header's load address and entry point. Legacy CRC checks
 follow ``CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK``.
-With ``CONFIG_SPL_FIT_SIGNATURE``, legacy downloads are rejected to prevent
-bypassing FIT verification.
-Raw U-Boot binaries are not supported.
+``CONFIG_SPL_RAW_IMAGE_SUPPORT`` permits a raw ``u-boot.bin``. SPL uses its
+configured or binman-provided load address and entry point, and loads exactly
+the downloaded bytes. The image must match that address and firmware handoff
+contract; raw images carry no size, checksum or signature of their own.
+With ``CONFIG_SPL_FIT_SIGNATURE``, legacy and raw downloads are rejected to
+prevent bypassing FIT verification.
 
 The loader accepts these images directly or inside the Android v0 wrapper
 added by the standard fastboot client; separate ramdisk and second-stage
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index f57b959f0ea..d83f0e371a8 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -71,7 +71,7 @@ config SPL_FASTBOOT_BOOT
 	bool "Boot images downloaded with fastboot in SPL"
 	depends on ARM || MIPS || RISCV || SANDBOX
 	depends on SPL_FASTBOOT && SPL_FRAMEWORK
-	depends on SPL_LOAD_FIT || SPL_LEGACY_IMAGE_FORMAT
+	depends on SPL_LOAD_FIT || SPL_LEGACY_IMAGE_FORMAT || SPL_RAW_IMAGE_SUPPORT
 	depends on !SPL_LOAD_FIT_FULL && !SPL_USB_SDP_SUPPORT
 	help
 	  Enable fastboot boot to load a downloaded image through the SPL
diff --git a/test/image/spl_fastboot.c b/test/image/spl_fastboot.c
index 1263416ba8d..b519ac8911f 100644
--- a/test/image/spl_fastboot.c
+++ b/test/image/spl_fastboot.c
@@ -124,10 +124,13 @@ static int check_images(struct unit_test_state *uts, void *image, size_t size,
 					   NULL, NULL));
 	ut_assertok(check_download(uts, image, size - 1, NULL, NULL));
 
-	magic = fdt_magic(image);
-	fdt_set_magic(image, 0);
-	ut_assertok(check_download(uts, image, size, NULL, NULL));
-	fdt_set_magic(image, magic);
+	if (!IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT) ||
+	    CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
+		magic = fdt_magic(image);
+		fdt_set_magic(image, 0);
+		ut_assertok(check_download(uts, image, size, NULL, NULL));
+		fdt_set_magic(image, magic);
+	}
 
 	/* The Android envelope is independent of the payload format. */
 	if (type != FIT_INTERNAL)
@@ -139,7 +142,7 @@ static int check_images(struct unit_test_state *uts, void *image, size_t size,
 	ut_assertok(check_download(uts, wrapped, wrapped_size, info, data));
 	ut_assertok(check_download(uts, wrapped, sizeof(*hdr) - 100, NULL, NULL));
 	ut_assertok(check_download(uts, wrapped, wrapped_size - 1, NULL, NULL));
-	/* Android padding must not make a truncated FIT payload look complete. */
+	/* Android padding must not make a truncated payload look complete. */
 	hdr->kernel_size = cpu_to_le32(size - 1);
 	ut_assertok(check_download(uts, wrapped, wrapped_size, NULL, NULL));
 	hdr->kernel_size = cpu_to_le32(size);
@@ -190,3 +193,38 @@ out:
 SPL_IMG_TEST(spl_test_fastboot, FIT_INTERNAL, 0);
 SPL_IMG_TEST(spl_test_fastboot, FIT_EXTERNAL, 0);
 SPL_IMG_TEST(spl_test_fastboot, LEGACY, 0);
+
+static int spl_test_fastboot_raw(struct unit_test_state *uts)
+{
+	u8 image[31], buffer[sizeof(image)], *dest;
+	struct spl_image_info expected = {}, loaded = {};
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT))
+		return -EAGAIN;
+	generate_data(image, sizeof(image), __func__);
+	spl_set_header_raw_uboot(&expected);
+	dest = map_sysmem(expected.load_addr, sizeof(image) + 1);
+	dest[sizeof(image)] = 0xa5;
+	fastboot_init(buffer, sizeof(buffer));
+	ut_assertok(download_image(uts, image, sizeof(image)));
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT, "OKAY"));
+	fastboot_boot();
+	ret = spl_fastboot_load(&loaded);
+	fastboot_init(NULL, 0);
+	ut_asserteq(0xa5, dest[sizeof(image)]);
+	if (CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
+		ut_asserteq(-EPERM, ret);
+		ut_asserteq(0, loaded.size);
+		return 0;
+	}
+	ut_assertok(ret);
+	ut_asserteq(expected.load_addr, loaded.load_addr);
+	ut_asserteq(expected.entry_point, loaded.entry_point);
+	ut_asserteq(expected.os, loaded.os);
+	ut_asserteq(sizeof(image), loaded.size);
+	ut_asserteq_mem(image, dest, sizeof(image));
+	return 0;
+}
+
+SPL_TEST(spl_test_fastboot_raw, 0);

-- 
2.56.0

