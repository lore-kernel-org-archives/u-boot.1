Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270D606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zdtwf6SI;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=clCiKwM8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37D7D8110A;
	Wed,  4 Nov 2026 09:41:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49FgY6uahzHW; Wed,  4 Nov 2026 09:41:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E796810F9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785278;
	b=dKSBOcVPGJy+nAHPfXZV6f8bDQXVlcWSkqZZuYtCod7zJuQvhGpM0BGRURnxkSPE/KcB
	 tj73qnzcy+USCusf5DBRWnn5OVFqqai1engtmW43gIGFijI4gcPbQUnbFwoPa1psUOSYW
	 LkZnl/Jc8Y5z8UpAdRK8TVghdz/zCPC3CPXkDpqS5LuK+2UxP9R2KKpeyllIvaO8GBDNg
	 /HJmHCb8zl7LjH4Ut84IPHtPv0nakZ1hKe/m7M3hpbU642sRNkkGJCL9/Q7jpaPFj6MkN
	 E6s58XpHhb6WK3X+3a+IKAHvrcem54bluvNRss6pe0jx4WhySwnjH8JWF/W5bnfKKhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785278;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=phlLOg51N0lIcMz5BBh/R5Xu2QKtFTpQHtEfXdW8Db8=;
	b=cvdT1OFIBGlFpxNRUVmse7YZnwxQZfPKg7rerYLUixJhXccIMT99ydaY+Pp+TM7ZvMlZ
	 kHftqiwAHuFHQx1a4jeyHGw856RCA9BeHEbZa2zwpWrQQasAxZfrxPoUFo3YIxdeD6DoR
	 RwhS1TSGJNlr07j0IpPlBqyv6TW7jQWymURYPSoCKt8u0OcOOBUCVietSXLdH1xlM+d8C
	 slMU9cITDRBOJz41gbsQ/4ZqVnjshG6dO1xHUjOSbM8WNmfPKwUDgoF+2JoCgRVmvksxu
	 wgbpt2FqjJT5/8TbmExWJoehKH37E3Gmrhz7pD5GoKh704FdjT8J+3CYOmlQqRPJfDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785278;
	bh=phlLOg51N0lIcMz5BBh/R5Xu2QKtFTpQHtEfXdW8Db8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zdtwf6SIyZwGqwdpROQuBmCcldHtQp2p9aU76wCMOIDhyfmo2ukgq5fWmzhU+63op
	 9wh0+Y2hf8xux0EIjXxgmq+CDjqmrmQMHytfdY8VWqdmPIVH0Eir0z24TzCAwBfXf7
	 EDivdLz/xXrNjf+UlEgFd7/cLoTMPuX/TKyika7dH+mcvRxdP7cKeEGlXfj5HqZNnD
	 D0jFjWmM6x38eC6+BrQGQ+hT2hHNPK4bQx3OIJagmvvLwIIwA7VmH8H/Dpl/BibOv6
	 rkzcUlaPJoszlNSDGRMN/UlT/Zm7IumwRKm/Q5mD5tyItSs/HdZXHH0UJva6y9CzAQ
	 bntod2KMFptlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E796810F9;
	Wed,  4 Nov 2026 09:41:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C546D37B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6AD960822
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbJKvLaVXO1g for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:41:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5269D6080C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785266;
 b=r49zQQmXSDIN1RE4kxCvLuDpRIZ9AqOu8c+tHQp37tw4Pzt2gWsUbxaQ2UxPf4uEoqPK
 TaJYr1DrtPEz3Vc+MsJYbP4Pb6bGobeCNe6RuVYn+p3+y1GLNHSLKDPApTbhyXakiwEZi
 bTiK76fEEaHG1gMC0RP0I5BNgPIedXTB9R5e0zJetAqcO8a3bXGo+wziJ7sJZFvxHDVUr
 IKjmESrg0qkDU7viKYYxKvAIk2Exy5cB7V+2qURnvPi6aMgFgD+twS7E0WVBvTYmNojuv
 rcNUhexcaq1vUbCpebd68OWa4+jSviY9bmF77Jv34genqA/Jl2hFbucL0Ty33ABXIZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785266;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=phlLOg51N0lIcMz5BBh/R5Xu2QKtFTpQHtEfXdW8Db8=;
 b=ey6tkABrpxYjZO+dvqvV8/aGK2Q0vYlB8sHetlSrDu0s6zjNA0EXYAYZhcK9J7iViukC
 ZahBtV83fPyoMiWs24zUBNl6xkli2ceG+qoabfbgIY4d2f9p+dm/B0/YhqStpc4+vjCU3
 axS7fJDjuglgdo9LCyfvjH7n8LDF5zVvzGdukYeLWj0IN1QG58QultlWHoCb+apcpQRLm
 EBCKQtOj8fpH0BblZd30rW0h0JVd/7SwMGK70H0khVO6y5fsA7t/Jq1siH6fV2/HRIJOS
 IerTNyJcG6t2i2DtnET9PAJgGBp+uhw9+OI9rj2mdlu/+Z81Pe6KBfMiiSgaFL5QWqA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=clCiKwM8; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=clCiKwM8
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5269D6080C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:41:03 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso4043455e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785262; x=1794390062;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=phlLOg51N0lIcMz5BBh/R5Xu2QKtFTpQHtEfXdW8Db8=;
 b=clCiKwM8zUKRiJX47osgQYgSkvf+7MXABddBnfiYySYy+07t2w6rx5U4WbYGEvxibK
 SZMYGBjkjOUKAptt6ZX8zRkqhGce+kJal9Pjsb/V3tkYxCpcaFQjoOD7U3VQAx9lCT9e
 ZxybERZIr+RxLQmgi9n1yIGa8SMgFISK74fnDJazkRBcIPyzArtHQuFGo4IhCtTH09gy
 uQ8eXzSeYfBYD7mwobHuv/sc/2IYQzjhcpsYuOhAwmKptV2gnHCg/6zTG2DVtGfL/pM1
 PNxbxvta20f+bWlRUtN7oxtk9I0wAB1TptR1BzWdqajCezy+nDdM6/6q512BgvTaNG8a
 zITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785262; x=1794390062;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=phlLOg51N0lIcMz5BBh/R5Xu2QKtFTpQHtEfXdW8Db8=;
 b=l9xNVRfDC76fiC2CjerTKs9TD9wgqPyFQPm6Ch5YSKW/IWY/YM0XW/Xi3VMhfN7QFl
 DAXifZ7X0yJn30biHqwsXZdnCYEcqqhxcOPhrHmGEFYRgy35GDqvhedpIVM+SHyDd1dw
 lHHgUq/e9BAkUH2G/a+kJmhnVY9j9comCzsvnXROz+sR9zOqH+agHAm2cNAq3siauS3V
 wcQ7dWbJksNVn6jZgLMX0hnmBUFxGUAlZSTONQUO1pkc6vhYDU4YsqJjRfcPhFvxCZ2X
 F7A/TkMKliAlAX3/mO43Lfns/oAKKZWD56qSF7x6fRoe3rutuyVInuW5O3sB3r08r5r7
 V5XA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrh0PsBsXbDK+Wo3fQcjLeQuIJ+rvG1EhhlEQJ0YdLW2scqviyMNsYagzDydxDoMx/86BcvS8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9AQPDwm5iPePPP171Vcpbt7X+sMeVvDLGNL5FeG/6tZPOdXoHY
 0FiDSvJV0m2A6mb0zpLkQoEIv2/vPf5GpAq14GQblPJ9Pcr+MwOj9uwfPPKMuzY9nUk=
X-Gm-Gg: AYBFou0i15M2brimSMPw4zo6Y25j5HKtPFhkJy5KpBqg8rqv5+8fpc7ZZcD7pztxDFW
 NCQH5je5QcQLqyj7sM8fiu9O8mxPcZr8YG8xGisqDuSBbtDjeG3QwmWcJTCdsEJtehywOXxKTiR
 pBXN2Uxrj9f3zsbWisUVnINv3TrNaoTFB98pTheoEp0OZ1W4T87LThoNOusWauQJSsUQoNVGio2
 e1ZbKk/5tcsN69e/IQX7n05Fdk1NBBu7xQhg4AZaVwDYE6YOe6xOWWX4R/XVHs61VeiQfvDeslt
 cwPzISdCi4A7wgFP2XBJ3cP2CI8yJy/MKQZh8sddiXMSFv34w9uTn8MWtjGYtv54ILgmd13EdX/
 3A0hbA/Fm5JENIOiFsW+JZ7fvA2jumXBBYYHCZpt+7+XubZ8tqC44dDpMe9/eG73RS308XK0Tap
 q0wkLFnmBtcTdAByM8gb5SccETgvq8wcaKY9agBObaUsVh0taPMT+jb+fo+YKRcIOIlCPFJC0Wg
 Nrk9ExY9IKF+9YsIlc2HYDjlviUfA3kSEC01EisyRGVow1DKn4iqERRVlXEzHrFrUGkR+d0M/Gy
 /ok9qiJcA1eAEI3oViSY/JqfnjWONpQkElbJnEnPQnN134Ttw4JaPaT88Ti2ZOhTrEV/S6j8xiF
 K49t8KAJxRokfJIZeUEnWQC0xGO4gKx4I98mHe0v+7mwV0g==
X-Received: by 2002:a05:600c:4e48:b0:4a2:150f:1610 with SMTP id
 5b1f17b1804b1-4ac183d16eemr339123845e9.23.1793785261980; 
 Wed, 04 Nov 2026 01:41:01 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4527fed5bsm49856945e9.3.2026.11.04.01.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:41:01 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 10:40:27 +0100
Subject: [PATCH v2 7/7] spl: fastboot: support raw U-Boot images
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ccaione-upstream-spl-fastboot-boot-v2-7-cf9781441ed5@baylibre.com>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
To: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
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
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boards with fixed U-Boot load and entry addresses do not need an image
container for RAM boot. Allow raw downloads when SPL_RAW_IMAGE_SUPPORT
is enabled, using the board's existing address configuration and the
completed download length.

Keep recognized FIT and legacy images on their respective validation
paths, so an invalid container cannot fall back to raw execution.

Reject raw downloads when SPL FIT signature verification is enabled
to prevent bypassing that verification with an unsigned image.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/spl/spl_ram.c      | 28 ++++++++++++++++++++++++---
 doc/android/fastboot.rst  |  9 ++++++---
 drivers/fastboot/Kconfig  |  2 +-
 test/image/spl_fastboot.c | 48 ++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 328a905a97e..58f838bc15d 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -52,21 +52,43 @@ int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size)
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
index ea3be618470..b56cd4fafb3 100644
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

