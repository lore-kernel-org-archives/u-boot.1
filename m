Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB4FC04FF9
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 19:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F320987E62;
	Fri, 12 Apr 2024 21:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UBhV27Lj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27EF987DF3; Fri, 12 Apr 2024 21:58:54 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C5986784
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 21:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e3f17c64daso10538885ad.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712951930; x=1713556730; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SnNF5dxZ+ZzrneJGKh+nI6jBWQfa/+JBHxOtxW+TFIo=;
 b=UBhV27LjkieitACCkNLlb5jsN8hM90q2f9m6PJDe+DsKFAlBbjtzaK9KzeMbX52cv0
 tSzpvsiw0sMGY9oY5SlQ75mcKFVAwpLaBU586AR/I3zkNZvFXgnUzVPibUcykJSg83Fs
 drF+8LrYYHXgSQV3ELqKxE+8Pgl6xXVA/zhds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712951930; x=1713556730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnNF5dxZ+ZzrneJGKh+nI6jBWQfa/+JBHxOtxW+TFIo=;
 b=i4ML0JTQncTbRHDz+w6/MJwWk4Rqbw0KCGjdCF6sNYdqMwAB2lJgApRMsKKNloKEhp
 Jdgj6MMd76fzDN1TQnF/OduxlgZpf+VkMt6BFY13bM7idp+AIqwPVuBJjAE5xbDNhYp8
 +gwaEkZGsrjKT3z2q5tdLnqgwbU0DImS6wQQ5ajtWhbK9AHQ8KISBOBxcCE/u8QUFWXc
 rASqAzNcBeUT4612banS9MNVZQXFycwo3OG20ybjJiF7a22/XVW7YhsPGMlVHdAJfxG4
 mGA63Ds7SwR4WeLeoemzGRvAFLJwGNMZoLPX4uRv+rwMek3RwXIlZ1dGMCwlJtDRK2OO
 93DQ==
X-Gm-Message-State: AOJu0YwDDWcphqjJd0xBuXPwyoPia7FxFf3Jnoho1EbpuERz3D7qf6tA
 S5Rq6fXYxxL3+Lj+GTftACC3952zbJH+95Y2hCFRrJvmq7LDHYHw3rDlV8MdTAo=
X-Google-Smtp-Source: AGHT+IGbkQMacE/W+Tjzg8ebdpe0Su5nNH2LrPkQiDCuzzxM+s9fSAYwACDqCoRYh8q5jm3XusmaBw==
X-Received: by 2002:a17:903:284:b0:1e4:55d8:dfae with SMTP id
 j4-20020a170903028400b001e455d8dfaemr3999345plr.4.1712951930329; 
 Fri, 12 Apr 2024 12:58:50 -0700 (PDT)
Received: from oliver.lan ([2806:102e:18:245e:2606:71da:664:f052])
 by smtp.gmail.com with ESMTPSA id
 im22-20020a170902bb1600b001e3d2314f4bsm3428169plb.132.2024.04.12.12.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 12:58:49 -0700 (PDT)
Date: Fri, 12 Apr 2024 13:58:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Charles Hardin <ckhardin@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
Subject: Re: [PATCH 1/1] net: add support to parse the NIS domain for the
 dhcp options
Message-ID: <20240412195847.GA401419@oliver.lan>
References: <20240401191319.62652-1-ckhardin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3nj/xt1fP7fGciPo"
Content-Disposition: inline
In-Reply-To: <20240401191319.62652-1-ckhardin@gmail.com>
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


--3nj/xt1fP7fGciPo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 12:13:19PM -0700, Charles Hardin wrote:

> There is code in the bootp parsing for NIS domain and add the
> same support for the dhcp options as well. This allows the same
> usage of the data when the dhcp command is used in the boot
> command.
>=20
> Signed-off-by: Charles Hardin <ckhardin@gmail.com>
> ---
>  net/bootp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/net/bootp.c b/net/bootp.c
> index 6800290963..046caf3685 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -883,6 +883,14 @@ static void dhcp_process_options(uchar *popt, uchar =
*end)
>  			break;
>  		case 28:	/* Ignore Broadcast Address Option */
>  			break;
> +		case 40:	/* NIS Domain name */
> +			if (net_nis_domain[0] =3D=3D 0) {
> +				size =3D truncate_sz("NIS Domain Name",
> +					sizeof(net_nis_domain), size);
> +				memcpy(&net_nis_domain, ext + 2, size);
> +				net_nis_domain[size] =3D 0;
> +			}
> +			break;
>  #if defined(CONFIG_CMD_SNTP) && defined(CONFIG_BOOTP_NTPSERVER)
>  		case 42:	/* NTP server IP */
>  			net_copy_ip(&net_ntp_server, (popt + 2));

This fails to build:
net/bootp.c: In function 'dhcp_process_options':
net/bootp.c:890:57: error: 'ext' undeclared (first use in this function)
  890 |                                 memcpy(&net_nis_domain, ext + 2, si=
ze);
      |                                                         ^~~
net/bootp.c:890:57: note: each undeclared identifier is reported only once =
for each function it appears in

--=20
Tom

--3nj/xt1fP7fGciPo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYZknQACgkQFHw5/5Y0
tyzXOwv/XeL44CaVk4fuRFTtdK8TsGr51qbqGoPiLyidXU+USJk0gn26+43z0ahr
K3yLFeB67iCTt9m4ARb0+bZqKzlpjvLDPAmiOQLEpVyfMjG5Nv897CFuIlM/VGNp
j1+HHmKkvX2lbe6ZgrnsD44iZrczvIpTjchHEdxy/7SkDjUNEwYNNE8LczU9zW4D
/5+bogMA81BL9Yt54yDQRUEnp4rao1VcwbhKFIVgfIpgkn4pg2W4TiM7pDkmLII/
in+h35pwpum05bXRjIXzdcia6sD3mvIMqbI9U2/+tsKKJObET1MGXOuOL0ySJzKa
bIB2nxen2jZfDvm6lNGpHNfyp/c0IkbTqgpWZDruwo970QIzRUckvyiHZoiZFdQ8
krklofZ+7Bq4ubjgl9LCfkZzeafMelV3Y30DpP28C8TYaaM9VOdQkOq0CZCy/gqc
ck7c/EfFakKBzdZP5T1oWIXtvjiUzMdl/a7msqBJTvy628ImuU9Kk8js5VCR03Ih
usz9MkjB
=8EWc
-----END PGP SIGNATURE-----

--3nj/xt1fP7fGciPo--
