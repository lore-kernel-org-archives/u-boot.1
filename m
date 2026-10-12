Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC9DCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 228804057A;
	Mon, 12 Oct 2026 22:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHFK_wTlAtXc; Mon, 12 Oct 2026 22:41:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5783440575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844886;
	b=XjDf/0bYPzdz0rgdpw41BQddBXeivxOdNa6JymJxn6nB6DGCopXr2zCBKgKqz8vesv/O
	 e+WnjOgthqkMQF36a+LNsBz2ryoEdzCSrSH+RKmoeqIibHixl1+KSktoHtBdqBO3C5sFW
	 hHuP/lDsPH0TI8Ec/noon33JR1AMYIEOMAhyjJx5wu32/tMoitT8l68ceqkEPtDEMjNPU
	 FMLeLokJ+wQsfsqWZAtxC03+8aPBi1dmO071ejISp++VvB3bS0M2RkrzHCEi4dMzq61pJ
	 HIXeRczzXzEt2EPcw7EyXNWooToRxD2YC+TcxZM+o4Lufv3tqJbPZmRNnt8cFJC/yvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Vk/eZk6ySanjXJx5iZhfEftD9xgFiV+Ld6F+BA+7OFM=;
	b=Ab6dQI7fNkt42tI93ZkJCmnj5hSalClk3hwVg29ASQa+N8nmc4tc9p1edAsNnhhBF3uF
	 /a0SKXmLw3g+aPVVRnK25GTez7XK/cgiAnYv4TdI3hWfQiziB59483iONC8a6vZ8/62uc
	 ANFPiBDNNNbJv+woFYYs5yPy+xB0RAKe+0oMCwlajL/sAOItpBXTZhzSu+/PlNOaWC6CQ
	 DND0I9+FqB4HBsa6cDY25MTSkzcUVTDcUaYs3Z9Y3VebG2aQGOdsnYUAHiQY4iLh9QcO0
	 7wxzoWIq3oHVsaSfLiKMMufsAAt3RD5W0NeIAqIDU5UkwnEzKa07xe4zT40LewkuXlA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="h8/RSbkD";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844886;
	bh=Vk/eZk6ySanjXJx5iZhfEftD9xgFiV+Ld6F+BA+7OFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XTRsNgUjMiNewdPYdoONrD0TnyK6xQzxWKJM9RdiAcAdWY06MioeXHLJaIvyJXfSp
	 3QnAMrgE3IeEPlXtQprgDievKqmXoEi1OBynifw8k6R1e7k6TY2vTDyET4ptMXXSo5
	 6BmaopFm3wuj0A1Z5M6z5dA/rvhBdxQQWV4VCeOaBavz64hpZTRXCuL3nKrDF3Jmfn
	 Nh9R5lPxOLGWEvI9NTo5bH91Z2/JtHXr7tdNuRMjtAQfabieC3b+BC0cgaAVuwTT0K
	 QEZ1EGLsq/J8QhU+f0VoTPEg13ib7TIGALvo+/pVotkRsmdEzZ4gFvoN8xv5X90Xhk
	 Xwa90DD/38n5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5783440575;
	Mon, 12 Oct 2026 22:41:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C2044DD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:41:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 818C740575
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:41:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_hgjP0N7wjc for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:41:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB3FA40574
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844883;
 b=joH7q3KnwabrTRxwvHTOwaN5XrNL6bwpIS9AXLV9gUO/9oSc5KTb7lhxtPt7d49AT+P7
 FXoQA9Y8R5ufb3f4wRdTRIm5U4lrVp2s7LVUegcRNuAgwbXAiQM5T0jy70/qivJlmBIHI
 Alz/l6CE4CCl/JSG7f0rhrLdjE42pQ/dL/VSPi/95OCVQGdo5HDwrVmskg0FW4A2Pn2C/
 2Vo9VDRkN0OeOXSPCyCY2n43uuRmH6+lS3A0tqM7Jjm8ENJ1U2/HP+DWC6WuQcrYKXT5x
 uuXerap0F5lABIJBLCEjA/atRV1rGheAg3lCUCKzGFZDPWt2JrqWrqMyUhQkLBOCn9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844883;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Vk/eZk6ySanjXJx5iZhfEftD9xgFiV+Ld6F+BA+7OFM=;
 b=CsMHpc4A85KhZ+yXCvJ+/3rlZIMETeFIRplgEtgF7EUp1nrsVpnL0OHVjbETgrzvakTk
 aiKf1SOiiCudcPghvSYCyjLTXUQmsGV4xL6RhR7ZEn8Z3ZN2DZWxbi+XmK1tag+NcNrUw
 bt/qskykuL0OiX351c4huCeQvZI+Lb85+1mT/A0mAI2wknbrG72zb0Phxhnn43Zs109v1
 /paCZrzLjrFqS3hSrlycaBHkkhaKJEete/JF1P2qyalbAJUYU6SnvVMjUS52GABqI4kU3
 zwxyjM0BV+EggvkYjWPuxsoLWJ0IQM306B8AOwZfdIZMJn7lptHQvcXoyTdB19T6t7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="h8/RSbkD"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=h8/RSbkD
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB3FA40574
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:41:23 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6dd7070699eso1710116eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791844882; x=1792449682;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vk/eZk6ySanjXJx5iZhfEftD9xgFiV+Ld6F+BA+7OFM=;
 b=h8/RSbkDiAWQUPqcBRnIQbp+mwYwXNcCi0xZ/J+gGA/ZmkD9osvvlkrj7qFeYIetQI
 /frcUJzWH5K2zfc3pkieXG5AFHbSJC23WuYb+z9v9RTSRGli86Q8GZCVymz1ANh6on+I
 PsBGrubR1y8vgBboNu2TLkiN+DSr9IGPu5KOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844882; x=1792449682;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vk/eZk6ySanjXJx5iZhfEftD9xgFiV+Ld6F+BA+7OFM=;
 b=Q5YPoZZAv4SC8ONlmySNGvJ94zJvyWvNm680MEOE0NbycJQzyACrPsmYNc78mzKx39
 tFD3sn8YYMiv2jjU8SS6lLDKargS2Qfki851OZM5kLesc26RvJnaP1nprWm0CfVNsqp/
 dYq1XzAfx4gUHemDbVIwuSPyS51P4hGI6oALHNF6ogeF2uKBnGEb6onWZuw/rMWgAsK2
 zTOfBkZ1wKssOl2d72tjI28Rp/K5HyN8ZkYqyxfxWQgE7jyYWoKns1gf1+1csMOb8TPN
 /UsggcNKCHGOgF5G4GHz/UVcWCuZEEEfQR226bOthyE89bBHLbabheCmdqPYojvzHExN
 pLLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmZcgAhSOOQk4acIoasujFHFAPrHSGNpVne4TBfmzRGyjYBZJhz0OZ9UldvjWWkf4gs0HTlTQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI9Lq0p9OI1GGR46naS8zgVk2ZtG29MC5gCFX/5LtUemQUKx6Ku
 UKSSsBJ7kWFZYVMBaTRC0QrGbeeKy0zMOYZUPfgdVemPO8dRRPsldEts9vce6sUtLulKm041+Tf
 oyCkSV1rebpTM
X-Gm-Gg: AYBFou2OZ8guhZJgK8dGkL16Uqtetd1EaFLNDglZIkwlVlOJLefr+U04sLPNaB5osR+
 DoprDfM/w31RDnphs2QStLhxJnKhR01MUJRO4uddS9FPDoHLUQbxcclLFdM8ByeUGuEu9u0wwQr
 9sh/KeM8Ng/wYO8aWTZ0Tusp7T/lX2Km5boAPxuGPGQHkVqY3V4aap9OM2MDe/e1c0HWStGowBc
 8HxgthFc0wNqSn/xXOqmR9hSm7JNF2rxlbOGgapRCvEqcuWjk3JpzSoOAOPABR/+IZ6RSZ+0jzw
 JeRf/xdjvY5C78dpP23se5xg/PTQdfhSqj84593rXBKGukYChP8up7cEPvcZsBOCx9Bw2sQ8zLp
 D0yB1vzrn58+V3/MhOwMjTNLYs2GeaON7PS7TJEWAy5H2PV+ahmbrK3hTXHDrak7gE81k+jRvfz
 ZUXkVS/XXcehh8+8uWq8OFpGpfV2ErwUdoTMn5YYaxvjOO56GKKVL62lbYWYDr3Lrhi2hc8WV2H
 xprCsIs3UKc/GBQwTfLB7usJPcezcOPC62c7pzNVtAMOziDfq47mMb787dSCsWWD4tqzT2+ptge
 /JKBuB3UQMNTesGexok=
X-Received: by 2002:a4a:e847:0:b0:6ca:b5f:e6cb with SMTP id
 006d021491bc7-6ef10492c2emr7887408eaf.42.1791844882064; 
 Mon, 12 Oct 2026 15:41:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6eef6e22b46sm10584655eaf.0.2026.10.12.15.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:41:21 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:41:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>,
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>,
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com,
 Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 2/9] fs: print change date in directory listing for FAT
Message-ID: <20261012224119.GO3722450@bill-the-cat>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Buadw3Dj01Rb/9Rw"
Content-Disposition: inline
In-Reply-To: <20261012140048.214059-3-heinrich.schuchardt@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Buadw3Dj01Rb/9Rw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 04:00:41PM +0200, Heinrich Schuchardt wrote:

> fs_ls_generic() displays file sizes but no timestamps. The FAT
> filesystem stores a change date in every directory entry and already
> populates fs_dirent::change_time in fat_readdir(). Print the date
> alongside the file size for filesystems that provide it.
>=20
> Add a u32 capability bitmap (caps) to struct fstype_info. Each bit
> documents a property that the filesystem's readdir() implementation
> guarantees:
>=20
>   FS_CAP_DATE  BIT(0)  change_time in fs_dirent is valid
>=20
> fs_ls_generic() tests FS_CAP_DATE once before the loop to select a
> consistent output format for the entire listing:
>=20
>   12345678  2024-03-15 09:30  filename.txt    (FAT)
>   12345678   filename.txt                     (ext4, squashfs, ...)
>=20
> Set FS_CAP_DATE for FAT. fat2rtc() loses the __maybe_unused annotation
> since it is now called unconditionally outside XPL builds. The attr,
> create_time, change_time, and access_time fields that were previously
> only populated under CONFIG_EFI_LOADER are now populated whenever
> CONFIG_XPL_BUILD is not set.
>=20
> Extending the feature to another filesystem requires only adding
> .caps =3D FS_CAP_DATE to its fstype_info entry and ensuring its readdir()
> fills in fs_dirent::change_time.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/fat/fat.c |  2 +-
>  fs/fs.c      | 38 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 4 deletions(-)

We should split the generic feature part from enabling it on FAT.

And, building on the comments I've already sent, I assume you've not
been inspired on some way to re-structure this code to avoid having to
have forward declarations of *something*.

--=20
Tom

--Buadw3Dj01Rb/9Rw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas1iDgAKCRAr4qD1Cr/k
CvJtAP9OoQhIZGVniC9+nas41Tk3+FDktSA2gXTYXf+jh2hHxAD/Zca4O+W40Zod
2lKdIx7K4Wu8wBXpO8GreCFaVw1LIAQ=
=IQUU
-----END PGP SIGNATURE-----

--Buadw3Dj01Rb/9Rw--
