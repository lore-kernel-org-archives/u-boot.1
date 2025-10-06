Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D94CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D42283DA6;
	Mon,  6 Oct 2025 17:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="iXxFE15w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2727483DA7; Mon,  6 Oct 2025 17:13:45 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6456783C98
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8E99EC085CC;
 Mon,  6 Oct 2025 15:13:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A952F606EB;
 Mon,  6 Oct 2025 15:13:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8E9BF102F1D62; 
 Mon,  6 Oct 2025 17:13:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759763618; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VG0fCuFBDLePTfN7+k2BUMz7yNqfn3+Vgspu9A9TDuU=;
 b=iXxFE15wKpkqpYHK7GIzw06NOToY4GjJRDyEjAwCr9450pRUaZJoG9zrtO70Iq6auL1E5Z
 Ych6f8ojzIZTBmzsHf2wosXkd+bZ5D3AiZB/Z06StaneLlfy8pqZ3wrKjM1bypqngYjdYL
 TPhqno2Y7lab827d0+Wj3mbtmviX0xB/sY/37UKcFFo/sDGRshygCaqAMbJtS+gJRS8ydU
 q3riKNRUbeKqS+pCBFXct8jL5G7+XH0FAbuKY4cjgG2Qd/sWKJYH/+R26aCfUEihpjT9Nd
 XR5ZL0eM64urpSj6vWS0yXgZU5V9QsisapLbpvGRp1TV9+o7AFTPGMm2aRWrxA==
Date: Mon, 6 Oct 2025 17:13:35 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alison Chaiken <alison@she-devel.com>
Subject: Re: [PATCH] test: Update logic for video test
Message-ID: <20251006171335.7b40302c@kmaincent-XPS-13-7390>
In-Reply-To: <20250818165406.3194425-1-trini@konsulko.com>
References: <20250818165406.3194425-1-trini@konsulko.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Mon, 18 Aug 2025 10:54:06 -0600
Tom Rini <trini@konsulko.com> wrote:

> The video test here is specific to the sandbox SDL video driver, so only
> build it when that is enabled rather than VIDEO is enabled.

This broke the build of sandbox_defconfig:

/usr/bin/ld: /tmp/cc9hfosg.ltrans55.ltrans.o: in function `expo_render_imag=
e':
/home/kory/uboot/test/boot/expo.c:674:(.text+0x5eea): undefined reference t=
o `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/expo.c:687:(.text+0x6196): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/expo.c:688:(.text+0x61ea): undefine=
d reference to `video_check_copy_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/expo.c:696:(.text+0x62df): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/expo.c:699:(.text+0x63cb): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/expo.c:704:(.text+0x650b): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/expo.c:707:(.text+0x65fe): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/expo.c:733:(.text+0x68e9): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /tmp/cc9hfosg.ltrans56.ltrans.o:/home/kory/uboot/test/boot/ced=
it.c:267: more undefined references to `video_compress_fb' follow
/usr/bin/ld: /tmp/cc9hfosg.ltrans56.ltrans.o: in function `cedit_render':
/home/kory/uboot/test/boot/cedit.c:268:(.text+0x63e): undefined reference t=
o `video_check_copy_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/cedit.c:275:(.text+0x6c1): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/cedit.c:282:(.text+0x777): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/cedit.c:289:(.text+0x82d): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/cedit.c:296:(.text+0x8e3): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/cedit.c:303:(.text+0x999): undefine=
d reference to `video_compress_fb'
/usr/bin/ld: /tmp/cc9hfosg.ltrans56.ltrans.o:/home/kory/uboot/test/boot/ced=
it.c:309: more undefined references to `video_compress_fb' follow
/usr/bin/ld: /tmp/cc9hfosg.ltrans56.ltrans.o: in function `cedit_render_lin=
eedit':
/home/kory/uboot/test/boot/cedit.c:398:(.text+0x10b3): undefined reference =
to `video_check_copy_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/cedit.c:405:(.text+0x1136): undefin=
ed reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/cedit.c:413:(.text+0x11ec): undefin=
ed reference to `video_compress_fb'
/usr/bin/ld: /home/kory/uboot/test/boot/cedit.c:424:(.text+0x135b): undefin=
ed
reference to `video_compress_fb'

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
