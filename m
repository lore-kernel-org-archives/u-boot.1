Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA133C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 21:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15CA181E6C;
	Wed,  2 Apr 2025 23:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="WbmYNLG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D9281F0B; Wed,  2 Apr 2025 23:52:46 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA88E8035B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 23:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=aI7IitR+9+Ll69gr004mifuvaDEazRaibFYF9St3k9k=; b=WbmYNLG77i1WBK6RC2+gf1n8cQ
 1Eb1UT1MmperJb5mdrwo3hsH4DJwXSknVNhOGzBekFdocbC+sTb2oF51Z6Vbc2KSKw76nYdpr0P8a
 1WlR5cjGYLKe2fAPv1z47fASNVydLLCMc66jpIomzf9JAeCk19ZBKf8fL+PzOiOm59/TYOK1ooM0r
 zwyLlmDJFIxDH0D4maXqDq41hXwLReH7/pj0k4ZSCXyXWZlJJeEW4Vj/AyeKiMm9gSDsB0yy7rhfc
 51rInfNgm8EzVx2Q03llmGdrU7RhCNTEtWolUuSlOHSTWcJsldiwQFBvqB0IkAhhZDeUjMphJfKky
 fKqxMi4g==;
Received: from i53875bf8.versanet.de ([83.135.91.248] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u060n-0002xb-GM; Wed, 02 Apr 2025 23:52:41 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 u-boot@lists.denx.de, quentin.schulz@cherry.de,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] Revert "net: eth_bootdev_hunt() should not run DHCP"
Date: Wed, 02 Apr 2025 23:52:40 +0200
Message-ID: <2021838.usQuhbGJ8B@diego>
In-Reply-To: <1824254.VLH7GnMWUR@diego>
References: <20250401083830.2320479-1-heiko@sntech.de>
 <74ce355b-4e2b-4d5d-b6fc-2ad421be7f3d@gmx.de> <1824254.VLH7GnMWUR@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Mittwoch, 2. April 2025, 23:36:46 MESZ schrieb Heiko St=C3=BCbner:
> Am Dienstag, 1. April 2025, 18:13:35 MESZ schrieb Heinrich Schuchardt:
> > On 01.04.25 17:51, Simon Glass wrote:
> > > On Tue, 1 Apr 2025 at 21:38, Heiko Stuebner <heiko@sntech.de> wrote:
> > >>
> > >> This reverts commit 1f68057e03206e6597ca8b2be8bb1c49d4bd47d0.
> > >>
> > >> Commit 1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
> > >> aims to reduce EFI boot times by disabling the dhcp_run when
> > >> checking ethernet bootdevices, by preventing it from running double,
> > >> with the reasoning
> > >>
> > >>      We need to call eth_bootdev_hunt() when setting up the EFI sub-=
system to
> > >>      supply the simple network protocol. We don't need an IP address=
 set up.
> > >>
> > >> That might by true for EFI, but not for everything else, because when
> > >> running distro-boot and for example the PXE method in it, nothing wi=
ll
> > >> set up an IP address now.
> >=20
> > The removed call was dhcp_run(addr, NULL, true);
> >=20
> > We have:
> >=20
> > distro_efi_read_bootflow_net():
> > boot/bootmeth_efi.c:205:        ret =3D dhcp_run(addr, NULL, true);
> >=20
> > script_read_bootflow_net():
> > boot/bootmeth_script.c:132:     ret =3D dhcp_run(addr, fname, true);
> >=20
> > extlinux_pxe_read_bootflow() seems to be lacking the call.
> >=20
> > So instead of reverting
> > 1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
> > we should add the missing call in extlinux_pxe_read_bootflow().
>=20
> doing
>=20
> ----- 8< -----
> diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
> index b91e61bcbc4..6e5e0f99ea4 100644
> --- a/boot/bootmeth_pxe.c
> +++ b/boot/bootmeth_pxe.c
> @@ -73,6 +73,10 @@ static int extlinux_pxe_read_bootflow(struct udevice *=
dev,
>                 return log_msg_ret("pxeb", -EPERM);
>         addr =3D simple_strtoul(addr_str, NULL, 16);
> =20
> +       ret =3D dhcp_run(addr, NULL, false);
> +       if (ret)
> +               return log_msg_ret("dhc", ret);
> +
>         log_debug("calling pxe_get()\n");
>         ret =3D pxe_get(addr, &bootdir, &size, false);
>         log_debug("pxe_get() returned %d\n", ret);
> ----- 8< -----
>=20
> does seem to work in _my_ usecase and gets me loading stuff over pxe
> again.

=46or reference, I implemented that now in
https://lore.kernel.org/u-boot/20250402215025.2655384-1-heiko@sntech.de/

So people can decide which way to go :-)


Heiko


> I guess this whole thing now becomes a strategy decision ;-) :
>=20
> - it's very late in the release, do we revert to the known working state
>   or hope the above fixes all issues
> - Simon's wish of not sprinkling dhcp_run calls in multiple places
>=20
> I guess I'm fine with both way, as either fixes my use-case ;-)
>=20
> Heiko




