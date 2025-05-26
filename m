Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9519CC5AE59
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 22:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E58882DB7;
	Tue, 27 May 2025 00:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dWirGoZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB48A82E34; Tue, 27 May 2025 00:25:30 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B884C82CF8
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 00:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72ec926e828so583583a34.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748298327; x=1748903127; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EIPUU/sMMXDA9jEgpDFijsy+fdNpmcGlDy+3Hyj8hoM=;
 b=dWirGoZb/qLUHfvYo313bpqaCDV2oLGp0YONkIoMOCnEFGFw1DW9YDOP9Tyy69jChQ
 1alIDiKRDswnkNlbvUOzAA1t5zYGfyLr48VPvdyzpKxYw3vXSUJjQGKMpGXhwNMkifkg
 1pGF7/HlaWPGVjv7TI4nkOQ9jcUQWwxylwbAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748298327; x=1748903127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EIPUU/sMMXDA9jEgpDFijsy+fdNpmcGlDy+3Hyj8hoM=;
 b=QZmy50SSb9guR5P9fzDrMdhfIC0AF2QMfiWNOKYNvB4xrEuVXWr8M4d5F6eUIPg0zk
 j9QcN44NdDIFyK29YPyT9H0020HPHHd7CtDQyt4OzRQ32+21POT6cTZK+J45m/j0JLyj
 ofmg92n6T10rXZVX0kEgkEY2YYkq81oJSzVGCNOXptXoAYSvBcUd5MoDMXirimYXveJ3
 qsQMln8PuL0raRiF0rn4tr1QDjjVJTCghIYTcE3fxxBL/lOvOuu+HFVOzfajE/3c2Ilg
 5+l3sn2fguRNj8/2hfrJAedW8dS2lN8LGS1lr1Xm1R/HaWCAcop/cw17L5Nd12L0w4ev
 boIw==
X-Gm-Message-State: AOJu0YwNq9XfUxwPy/Ygn5qnrp7/y8Gsp9/skPpyPm5OwwkkipJTRK3s
 9bzvv3igV5V6lP8rJIjsgu5teNDpxYZwkaxB0j9Y92gZ3f697q9BZej3jfPMwMH9uec=
X-Gm-Gg: ASbGncuoFjgSthgxyQpXaZNkA5rJnfD4moTNKLnsh/m98vjq9Pkz3wFMtBVz5k/GGbp
 lDaoVS2v96FqfAp9zvf+qJD3lrX1sLpaohQcm6NxMueBcO8+PsH0vGqkdakGJN34zPz7fbhtX1y
 8WTX6jFklA2xcby4zBZvYGIzl8DMNqLkIUutsYsfm0On2TKZxjPgaXe+tka19iS+u485ykdLma4
 ZcSIHJrtUGDAsTd9Yr4PtkSYMfSUtp/VSrrEJLWtsAy/Ee7KlVpu/r6+fPB31blLodIXoTipvhJ
 SFKAC28Tue3phxMRwvdGqbUuSCKe9pCiFVyTLme/YfFcfDDyKxmmc3AcyZl8v6mv+g3AY3dPaz4
 SInHIxhl2NvE3
X-Google-Smtp-Source: AGHT+IFzHSWcrU/ras75xQzbgCFYEU/E7qrdomQa73rgW35bVVtCRaoeiigtWw4NLro3huirGWkAlg==
X-Received: by 2002:a05:6830:6885:b0:72a:11aa:6ebd with SMTP id
 46e09a7af769-7355d129602mr5948712a34.23.1748298327423; 
 Mon, 26 May 2025 15:25:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a4afb9sm4148386a34.13.2025.05.26.15.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 15:25:26 -0700 (PDT)
Date: Mon, 26 May 2025 16:25:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] ext4fs: Fix: Read outside partition error
Message-ID: <20250526222524.GA2774370@bill-the-cat>
References: <20250523050201.22442-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="azt6UHVxvmu8R5JA"
Content-Disposition: inline
In-Reply-To: <20250523050201.22442-1-mibodhi@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--azt6UHVxvmu8R5JA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 10:02:01PM -0700, Tony Dinh wrote:

> Use lbaint_t for blknr to avoid overflow in ext4fs_read_file().
>=20
> Background:
>=20
> blknr (block number) used in ext4fs_read_file() could be increased to a
> very large value and causes a wrap around at 32 bit signed integer max,
> thus becomes negative. This results in an out-of-normal range for sector
> number (during the assignment delayed_start =3D blknr) where delayed_start
> sector is typed uint64 lbaint_t. This causes the "Read outside partition"
> error.
>=20
> This patch was tested on the Synology DS116 (Armada 385) board, and a
> 4TB Seagate HDD.
>=20
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>=20
>  fs/ext4/ext4fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
> index 1727da2dc6d..f10c622e62c 100644
> --- a/fs/ext4/ext4fs.c
> +++ b/fs/ext4/ext4fs.c
> @@ -101,7 +101,7 @@ int ext4fs_read_file(struct ext2fs_node *node, loff_t=
 pos,
>  	blockcnt =3D lldiv(((len + pos) + blocksize - 1), blocksize);
> =20
>  	for (i =3D lldiv(pos, blocksize); i < blockcnt; i++) {
> -		long int blknr;
> +		lbaint_t blknr;
>  		int blockoff =3D pos - (blocksize * i);
>  		int blockend =3D blocksize;
>  		int skipfirst =3D 0;

Sorry, I should have reviewed this deeper before accepting it. This
patch isn't right because it introduces a new problem, we ignore all
failures from read_allocated_block() now because we can never return a
negative value. This was reported by Coverity as CID 131183 and I need
to revert this for now.

--=20
Tom

--azt6UHVxvmu8R5JA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg06lAACgkQFHw5/5Y0
tyznXgv/SGGN0t71atoqjPeWlBWgRgMKgMkDgFfPuZ2JigsbtBbG5cr1t89MfveZ
8n/LnXrElxjw8xJRyE2sdCMOAL8wcZydaBljj9kb3ibbVpdCW12s8vZ2MT6GshxT
j0RfQrj73OkkPhBcKX2jRA/FW900vhGc0W+sZrHjduUU8vAWRUaEOE/OFYzZnjeP
YiqI7yL9idsPadh4x72V86dq/77mQr0j5cgvbNX3CqVCkIjJfvDtD6Gp3KeqcPkm
uyFCdKD1+/NImCj7Wahuh51Q7AvUrPfBOzepJZ+vpmoO1JsWobWsyeoEygjILxme
bb1eC5eiXJ8uE1M2pc7hGuiwaAbeHtj+owmQ1w0YTqBiJwXNW2Uk9NYNbhjNSY6S
Tu30/lasxcCBtQOznZgPtcTdCU1sbiMpChNjcuIJW3m9ULnBF3Ry1eA+M3RStIJ/
ZXhUrhWQulgEPNpwVfPyh3vy/RsGKSyOmdWrCyG1h/QjA5PaWyZDlGESESolyQ/Y
kPqGncJi
=L0UJ
-----END PGP SIGNATURE-----

--azt6UHVxvmu8R5JA--
