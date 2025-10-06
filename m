Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63618CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4CDF83DBD;
	Mon,  6 Oct 2025 17:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DTZbdBAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2354783DE4; Mon,  6 Oct 2025 17:22:31 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA5D183C98
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6C6521A1174;
 Mon,  6 Oct 2025 15:22:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 32DFD606B7;
 Mon,  6 Oct 2025 15:22:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 00B72102F1E9F; 
 Mon,  6 Oct 2025 17:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1759764147; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=v0lmiQP/qXJLq8SBzRa2GUtq1geI1vWbLhPcgrSZbAc=;
 b=DTZbdBAJbY43it18zU7yQ+WxlcF33oEDhdhl63nkAcTQ8RXM/s3KVMmJhCKgHotn+gtQYH
 8+oXdEDtPeNcMr9GQbMxwxqTXpo6ZZ8NkDgh/KgXD80p7QgQcrZuhdybdodXsnZqPCxXrQ
 iE6q7Ce889u0Xjm/2q2uvq0xeo9SKWACdlltewMY6990KGX4MiE86krVT5V2oeOIZnu2HF
 nIUO2qWDXjOVoG9HXG9cooa6Ub05Z/7Nvi/99AQdXfAhk+5GMSDX+GErigm+TlEP9ZaxUc
 APDmhmOKOU+ekf3YfzqCQNFhqFGqak8bSZp3EWISjRg6DxTFn81v7L/l1TOYzA==
Date: Mon, 6 Oct 2025 17:22:24 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alison Chaiken <alison@she-devel.com>
Subject: Re: [PATCH] test: Update logic for video test
Message-ID: <20251006172224.0a8d1919@kmaincent-XPS-13-7390>
In-Reply-To: <20251006171335.7b40302c@kmaincent-XPS-13-7390>
References: <20250818165406.3194425-1-trini@konsulko.com>
 <20251006171335.7b40302c@kmaincent-XPS-13-7390>
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

On Mon, 6 Oct 2025 17:13:35 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Mon, 18 Aug 2025 10:54:06 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > The video test here is specific to the sandbox SDL video driver, so only
> > build it when that is enabled rather than VIDEO is enabled. =20
>=20
> This broke the build of sandbox_defconfig:

It seems CONFIG_SANDBOX_SDL=3Dy is missing in every sandbox defconfig, and =
it is
required to have CONFIG_VIDEO_SANDBOX_SDL enabled.

> /usr/bin/ld: /tmp/cc9hfosg.ltrans55.ltrans.o: in function `expo_render_im=
age':
> /home/kory/uboot/test/boot/expo.c:674:(.text+0x5eea): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/expo.c:687:(.text+0x6196): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/expo.c:688:(.text+0x61ea): undefined reference=
 to
> `video_check_copy_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/expo.c:696:(.text+0x62df): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/expo.c:699:(.text+0x63cb): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/expo.c:704:(.text+0x650b): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/expo.c:707:(.text+0x65fe): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/expo.c:733:(.text+0x68e9): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /tmp/cc9hfosg.ltrans56.ltrans.o:/home/kory/uboot/test/boot/cedit.c:267: m=
ore
> undefined references to `video_compress_fb' follow /usr/bin/ld:
> /tmp/cc9hfosg.ltrans56.ltrans.o: in function `cedit_render':
> /home/kory/uboot/test/boot/cedit.c:268:(.text+0x63e): undefined reference=
 to
> `video_check_copy_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/cedit.c:275:(.text+0x6c1): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/cedit.c:282:(.text+0x777): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/cedit.c:289:(.text+0x82d): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/cedit.c:296:(.text+0x8e3): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/cedit.c:303:(.text+0x999): undefined reference=
 to
> `video_compress_fb' /usr/bin/ld:
> /tmp/cc9hfosg.ltrans56.ltrans.o:/home/kory/uboot/test/boot/cedit.c:309: m=
ore
> undefined references to `video_compress_fb' follow /usr/bin/ld:
> /tmp/cc9hfosg.ltrans56.ltrans.o: in function `cedit_render_lineedit':
> /home/kory/uboot/test/boot/cedit.c:398:(.text+0x10b3): undefined referenc=
e to
> `video_check_copy_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/cedit.c:405:(.text+0x1136): undefined referenc=
e to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/cedit.c:413:(.text+0x11ec): undefined referenc=
e to
> `video_compress_fb' /usr/bin/ld:
> /home/kory/uboot/test/boot/cedit.c:424:(.text+0x135b): undefined referenc=
e to
> `video_compress_fb'
>=20

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
