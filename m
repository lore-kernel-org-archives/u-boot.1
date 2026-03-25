Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F68FEA83E
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 09:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE28840B5;
	Wed, 25 Mar 2026 10:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="h6glVtxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C23840CB; Wed, 25 Mar 2026 10:59:49 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E407A840B0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 10:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 42FF2C580B0;
 Wed, 25 Mar 2026 10:00:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9024F601A1;
 Wed, 25 Mar 2026 09:59:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 91DCE10451281; Wed, 25 Mar 2026 10:59:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774432786; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5rCobzhCxmTm2f1i9xY0/ehwg2PWSKInLBdLyrp+eiQ=;
 b=h6glVtxc/UKiBvwHH7IYsofHxGdmaBCPUCcSGDg1olGVkeKVqxb4GRvtUPxfhqcz6OO2Qd
 ROk7ZZcvI2eBFVmy9KLxgfAS8ETbO8w/QEnc8i1ghqKB62rElpvuKj16xQnoYb84fBUG8+
 pw+fQJT95KBZE2yzJGO1YWig2t2Pnhns+GfA4hPvfThajr34avYlAHA7cNlNs3mZ6lxXBv
 VwUQDy8B0IXfeCXTcpvmOZXra4skrWggegbDnbNY36iSMa1jQcXLYyhY/scI1idjd/vzLy
 yO9Ymek92Jo4jqAwCbQ10tR/u5dIz1saZKSvB9XkkGlrgCAUKbD7Glu/W+ME9A==
Date: Wed, 25 Mar 2026 10:59:41 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ryan =?UTF-8?B?UGVyc8OpZQ==?=
 <ryan.persee@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] bootstd: efi: Handle prior-stage FDT in network path
Message-ID: <20260325105941.4519d3d4@kmaincent-XPS-13-7390>
In-Reply-To: <20260322200856.1398442-1-sjg@chromium.org>
References: <20260322200856.1398442-1-sjg@chromium.org>
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

On Sun, 22 Mar 2026 14:08:50 -0600
Simon Glass <sjg@chromium.org> wrote:

> When CONFIG_OF_HAS_PRIOR_STAGE is enabled and fdtfile is not set,
> efi_get_distro_fdt_name() returns -EALREADY to indicate the prior-stage
> FDT should be used. The block-device EFI path handles this by setting
> BOOTFLOWF_USE_PRIOR_FDT, but the network path treats it as an error,
> causing the bootflow to stay in 'base' state with a -EALREADY error.
>=20
> This also means fdt_addr_r is required even when no FDT download is
> needed, giving a spurious  -EINVAL error.
>=20
> Fix this by calling efi_get_distro_fdt_name() before checking
> fdt_addr_r, and handling -EALREADY by setting BOOTFLOWF_USE_PRIOR_FDT
> to skip the FDT download, matching the block-device behaviour.
>=20
> THere is no test for this at present, since sandbox does not enable
> CONFIG_OF_HAS_PRIOR_STAGE and lacks infra for network-based EFI boot.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/bootmeth_efi.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>=20
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index f592fec07f6..cbb392e1636 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -269,27 +269,29 @@ static int distro_efi_read_bootflow_net(struct boot=
flow
> *bflow) return log_msg_ret("fi0", -ENOMEM);
> =20
>  	/* read the DT file also */
> -	fdt_addr_str =3D env_get("fdt_addr_r");
> -	if (!fdt_addr_str)
> -		return log_msg_ret("fdt", -EINVAL);
> -	fdt_addr =3D hextoul(fdt_addr_str, NULL);
> -	sprintf(file_addr, "%lx", fdt_addr);
> -
> -	/* We only allow the first prefix with PXE */
>  	ret =3D efi_get_distro_fdt_name(fname, sizeof(fname), 0);
> -	if (ret)
> +	if (ret =3D=3D -EALREADY) {
> +		bflow->flags |=3D BOOTFLOWF_USE_PRIOR_FDT;
> +	} else if (ret) {
>  		return log_msg_ret("nam", ret);
> +	} else {

Instead of this big else maybe you can return directly in the EALREADY case
alongside with a comment, like this:

if (ret =3D=3D -EALREADY) {
	/* Prior stage fdt is used */
	bflow->flags |=3D BOOTFLOWF_USE_PRIOR_FDT;
	bflow->state =3D BOOTFLOWST_READY;
	return 0;
} else if (ret) {
	return log_msg_ret("nam", ret);
}

> +		fdt_addr_str =3D env_get("fdt_addr_r");
> +		if (!fdt_addr_str)
> +			return log_msg_ret("fdt", -EINVAL);
> +		fdt_addr =3D hextoul(fdt_addr_str, NULL);
> +		sprintf(file_addr, "%lx", fdt_addr);
> =20
> -	bflow->fdt_fname =3D strdup(fname);
> -	if (!bflow->fdt_fname)
> -		return log_msg_ret("fil", -ENOMEM);
> +		bflow->fdt_fname =3D strdup(fname);
> +		if (!bflow->fdt_fname)
> +			return log_msg_ret("fil", -ENOMEM);
> =20
> -	if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
> -		bflow->fdt_size =3D env_get_hex("filesize", 0);
> -		bflow->fdt_addr =3D fdt_addr;
> -	} else {
> -		log_debug("No device tree available\n");
> -		bflow->flags |=3D BOOTFLOWF_USE_BUILTIN_FDT;
> +		if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
> +			bflow->fdt_size =3D env_get_hex("filesize", 0);
> +			bflow->fdt_addr =3D fdt_addr;
> +		} else {
> +			log_debug("No device tree available\n");
> +			bflow->flags |=3D BOOTFLOWF_USE_BUILTIN_FDT;
> +		}
>  	}
> =20
>  	bflow->state =3D BOOTFLOWST_READY;



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
