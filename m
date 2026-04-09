Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCC9F31E41
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 15:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2766C83D8A;
	Thu,  9 Apr 2026 17:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DKwM25jZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E982C83D8A; Thu,  9 Apr 2026 17:40:41 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BA383CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 17:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46aa216a5edso642672b6e.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775749238; x=1776354038; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wmvzbs8DNaDMUqrspIdPmrMIj1UEJkGFLyaIhe+ygDg=;
 b=DKwM25jZQgx866IPBOtpwjyOyP+sgnImste2ckFsKGF9XHRCmhTjrePT4nLdQVvj3I
 qAmKYR9GxYVm3FFMy0REdxAZcI7tNsuIWsFcACHhwOTZFlG9JpTf6ZKe5uXxHeM4D1hi
 6A59fg32hGZauMaQd9GOsNJrGXaSNbGavQ1R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775749238; x=1776354038;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmvzbs8DNaDMUqrspIdPmrMIj1UEJkGFLyaIhe+ygDg=;
 b=K0+Dbo5UaTdlRgkW24ToKucVTuLzf/DcMq/oNgHpZdRZ3roCcYbINc36k4fcOi5SFh
 vxzAT9JiqVzt8tSAyE44+OpFPYTIUcLAQM/fKM+OHlDqgmiEGvxFx99IX4anQ3BryCKA
 ADzBWE99bZYhQIA/5+d68YdmcT7eGNBdSo0E3iHKm2sXWL6gOKZubpJPIS/gIAo05BSr
 UiJD5A1q83OXKxXT5ToDo80N9r0Ozl/D5itpMBFX2pjQkpKzPgZ23rTJQwB4yG2X2J1n
 q/1D6/I7wsnDqMaausGrYD/JaNkFqA79YPWAX/gJoSFMp2+rV7Y5gBY8UPK5nz7J57Hm
 mqmQ==
X-Gm-Message-State: AOJu0YxQXiqZ7GMLtNF1j778+V+uPg0v1eU69xBIxyuQwRfHqcmZuSmU
 Sbp98qeyj/A+wvOaga2q9M+/ABWTJ0lMvrjaw2/2K8AXFB4uaOp9501x5ifAairPUn4=
X-Gm-Gg: AeBDiesSn6WpuHgH6DCmXZC1maGg8+3kRozXphKkxqzc8ovyce/Z+MoLRt6I9sMDPcs
 hUgxEHZRBEFMsI9UrA5xYTYbvuw7WPQ0QRQMDnrsKnpd6/pG33hjAjjm+EYW+J1gOIUlXeYuof+
 hewfUdPF1/0r/qnwvr+FjFQ5pJvw1PJJwh6/AOWTwRV9v8pL46LXGe9gxoWYZ1uyMc7BxysE4/G
 LWzF3/pvusfjobWIRzkFBtaxayFUjn1K8Eq46VfoP5ovTtUXyDjilQb5I8+7VbZnxpZQJ5VyR38
 uT2SGwAC76kwDYEGxM5hjZQukYkpsB1ImXUJKjeaIPC7M33bq9cIMdysSfR5L93xVV+x7bRoH9Q
 7770zbvQY19At0ACgi6ic153a9qh7ErGCKxhplbxkbn1EiidZPFDJOELQcRAjEY8jgnxXART9Vh
 0XI8sK06SBO3HEOlBob/Hyzr1O0NzaCNIZOviX0ZDC9pB7e72BoJ18QBYnCJftslSVerBnmOO1H
 3oumFI8GxbVhNsXePe8LRqHU1iAowZq82nnj8ugY+FkRbzw4hA=
X-Received: by 2002:a05:6808:22a8:b0:467:26e4:7295 with SMTP id
 5614622812f47-46ef8321711mr12115571b6e.44.1775749237913; 
 Thu, 09 Apr 2026 08:40:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47551804168sm4450840b6e.5.2026.04.09.08.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 08:40:37 -0700 (PDT)
Date: Thu, 9 Apr 2026 09:40:35 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Sebasti=E1n?= Alba <sebasjosue84@gmail.com>
Cc: u-boot@lists.denx.de, jerome.forissier@arm.com
Subject: Re: [SECURITY] net: nfs: buffer overflow in nfs_readlink_reply() in
 legacy NFS path (nfs-common.c) , incomplete fix
Message-ID: <20260409154035.GM41863@bill-the-cat>
References: <CAJD=UNd17V=anGd6C=jM8YzV10uTwEewae+CD1YGym5=JGeuiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2bx9njEKrS6aWC49"
Content-Disposition: inline
In-Reply-To: <CAJD=UNd17V=anGd6C=jM8YzV10uTwEewae+CD1YGym5=JGeuiw@mail.gmail.com>
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


--2bx9njEKrS6aWC49
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 10:56:59PM -0600, Sebasti=C3=A1n Alba wrote:
> Hi Jerome, Tom, and U-Boot security list,
>=20
> I would like to report a buffer overflow vulnerability in
> net/nfs-common.c:nfs_readlink_reply()
> that was not addressed by the recent fix in commit fd6e3d34097f ("net:
> lwip: nfs: fix buffer
> overflow when using symlinks").
>=20
>=20
> *=3D=3D Vulnerability =3D=3D*
> File: net/nfs-common.c | Function: nfs_readlink_reply() | Lines: ~667-685
>=20
> The `rlen` field from a server READLINK reply is validated only against t=
he
> incoming packet
> length (check inherited from CVE-2019-14195), but NOT against the
> destination buffer
> nfs_path_buff[2048]:
>=20
>     rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
>=20
>     /* validates rlen against packet size only */
>     if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)(&rpc_pkt) + rlen) >
> len)
>         return -NFS_RPC_DROP;
>=20
>     /* MISSING: check that pathlen + rlen < sizeof(nfs_path_buff) */
>     pathlen =3D strlen(nfs_path);
>     memcpy(nfs_path + pathlen, data, rlen);   /* BSS overflow */
>     nfs_path[pathlen + rlen] =3D 0;             /* OOB write */
>=20
> An attacker controlling an NFS server can send a syntactically valid
> READLINK reply
> (rlen <=3D packet_size) where pathlen + rlen exceeds sizeof(nfs_path_buff=
) =3D
> 2048,
> overflowing the BSS buffer into adjacent memory.
>=20
>=20
> *=3D=3D Relationship to Existing Fixes =3D=3D*
> - CVE-2019-14195 (cf3a4f1e86): added a packet-size check for rlen only =
=E2=80=94
> does not bound the copy against nfs_path_buff.
> - fd6e3d34097f ("net: lwip: nfs: fix buffer overflow when using symlinks"=
):
> fixed the same overflow class in net/lwip/nfs.c only; net/nfs-common.c
> (legacy NFS path) was not addressed.
>=20
>=20
> *=3D=3D Impact =3D=3D*
> CWE-120 | CVSS 8.8 (AV:A/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H)
> Affects any U-Boot client booting via NFS when symlinks are present on the
> server.
>=20
>=20
> *=3D=3D Suggested Fix =3D=3D*
> --- a/net/nfs-common.c
> +++ b/net/nfs-common.c
>      pathlen =3D strlen(nfs_path);
> +    if (pathlen + rlen >=3D sizeof(nfs_path_buff))
> +        return -NFS_RPC_DROP;
>      memcpy(nfs_path + pathlen, data, rlen);
>      nfs_path[pathlen + rlen] =3D 0;
>=20
> Also required for the absolute path branch (~L683):
> +    if (rlen >=3D sizeof(nfs_path_buff))
> +        return -NFS_RPC_DROP;
>      memcpy(nfs_path, data, rlen);
>      nfs_path[rlen] =3D 0;
>=20
>=20
>=20
> I would appreciate if the project could request a CVE identifier through
> the appropriate CNA, crediting me as the reporter.

Thanks for the report. Please see
https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
to submit a patch we can apply. With respect to a CVE, that's up to the
submitter to request, from whatever service they usually work with for
one, currently.

--=20
Tom

--2bx9njEKrS6aWC49
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadfIbwAKCRAr4qD1Cr/k
Clt1AQDlSORWBeytpRCimXN9wycUzmsIQDhLf3i9G8nek64/OgEAsbyGKSGGkFan
HdvGQSZXw+sZwwujwYK750db6V7eAw8=
=w+mc
-----END PGP SIGNATURE-----

--2bx9njEKrS6aWC49--
