Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7376ECCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 08:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83C7183C14;
	Wed, 12 Nov 2025 09:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="a2fxBe4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9461A83C28; Wed, 12 Nov 2025 09:53:55 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1543183C08
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 09:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D939EC0F559
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:53:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 787056070B;
 Wed, 12 Nov 2025 08:53:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 954D3103717C1; Wed, 12 Nov 2025 09:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762937631; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=euRd1KL3+Q6Yj1ktCw7CAupZ1+sPSOQLPVhcqT1lzDU=;
 b=a2fxBe4ohWjcKJehZpIvEZkqn1gHk02TLYBaRmvw9omzYuZaLMZLevTgJJ+iIv1mxBTfLx
 Jv1Qp3dy2pI2NngGKRMrlW/cGh5PhxgjhvwwKm+6tv1/ORbJqkTxQowpdWBZte9X/0ZP+a
 NvHgaYN7mpbUUeISYNlW8e4L/6JxJMfvk7fwWpc7ivAKbjIueA8VpwoyYWP/WLIJGBE7dB
 Zs/6aZ3am+uizyNKvukseg9EnamCHH//LQPu3X7xBiboqsdSj9qUQ1sS5lsneY5/CvtSQW
 fkgzgqiz+QcWTffzomQ4alUIDM6FN7ogiQEYbIZrMsUsz4UPHMnw3g3aUp0ETw==
Date: Wed, 12 Nov 2025 09:53:50 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20251112095350.3da9eff8@kmaincent-XPS-13-7390>
In-Reply-To: <20251110185507.GQ6688@bill-the-cat>
References: <20251110185507.GQ6688@bill-the-cat>
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

On Mon, 10 Nov 2025 12:55:07 -0600
Tom Rini <trini@konsulko.com> wrote:

> Here's the latest report. Just 2 new issues, both from the extensions
> series. Can we please address these shortly? Thanks!

Ok I will take a look at these errors!

>=20
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Nov 10, 2025 at 12:44=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>=20
>=20
> Hi,
>=20
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>=20
>    - *New Defects Found:* 2
>    - 1 defect(s), reported by Coverity Scan earlier, were marked fixed in
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 2 of 2 defect(s)
>=20
> Defect Details
>=20
> ** CID 638558:       Memory - illegal accesses  (UNINIT)
> /boot/pxe_utils.c: 485           in label_boot_extension()
>=20
>=20
> _________________________________________________________________________=
____________________
> *** CID 638558:         Memory - illegal accesses  (UNINIT)
> /boot/pxe_utils.c: 485             in label_boot_extension()
> 479     			return;
> 480
> 481     		snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
> 482     			 slash);
> 483     	} else {
> 484     		dir_len =3D 2;
> >>>     CID 638558:         Memory - illegal accesses  (UNINIT)
> >>>     Using uninitialized value "overlay_dir" when calling "snprintf".
> >>> [Note: The source code implementation of the function has been overri=
dden
> >>> by a builtin model.] =20
> 485     		snprintf(overlay_dir, dir_len, "/");
> 486     	}
> 487
> 488     	alist_for_each(extension, extension_list) {
> 489     		char *overlay_file;
> 490     		ulong size;
>=20
> ** CID 638557:       Null pointer dereferences  (NULL_RETURNS)
>=20
>=20
> _________________________________________________________________________=
____________________
> *** CID 638557:         Null pointer dereferences  (NULL_RETURNS)
> /cmd/extension_board.c: 102             in do_extension_list()
> 96     {
> 97     	struct alist *extension_list;
> 98     	struct extension *extension;
> 99     	int i =3D 0;
> 100
> 101     	extension_list =3D extension_get_list();
> >>>     CID 638557:         Null pointer dereferences  (NULL_RETURNS)
> >>>     Dereferencing a pointer that might be "NULL" "extension_list" when
> >>> calling "alist_get_ptr". =20
> 102     	if (!alist_get_ptr(extension_list, 0)) {
> 103     		printf("No extension registered - Please run
> \"extension scan\"\n"); 104     		return CMD_RET_SUCCESS;
> 105     	}
> 106
> 107     	alist_for_each(extension, extension_list) {
>=20
>=20
>=20
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>
>=20
> Best regards,
>=20
> The Coverity Scan Admin Team
>=20
> ----- End forwarded message -----
>=20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
