Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A559C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 19:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F27A1810E9;
	Thu, 17 Sep 2026 19:53:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mQqXfVWWxrrT; Thu, 17 Sep 2026 19:53:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3AE6480FA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789674796;
	b=Jj/M9CNdIfzxzMDpgv4NWo4LooHUfSwsQEO8SjJrDHnoucXyBhRaIOk2GOMY3PC5rFfr
	 YgvoDxAtRLdsqfEzlqkYAt2/sI/2k0fKZilcXO+RE0BiwHis7Cqy0Gj8TqrpTzxiEFLvk
	 jwOcfuku/kQOkGAldncbvNLsczH1bP221dE6wjg+gL7EoYehhJqHBU6eqaZ8Tizxka//f
	 JtVCyQYFxrE6qf60a7C+J5yfbcrwFI58IHx8/jJyCqeFFSn1pLh6zBbcmkgpbfvlj+ags
	 Fga11/qq9YSqcf9eSi5oSmP25cH+jLZsXky8t2NynALeFKM30TSNiYl1HrH2+TH8rsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789674796;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DUvbe31KTERHfdDaKAYKkXvxD4H9sASj2C1f0MUFI1E=;
	b=JM7RBcLr3fBgTJ4TMi/xZ7xtstL5oklI2vB11jCJ9Z5+h6sLXfk16/ltqDS55OmZKDqo
	 LwdY260plT+QTs36e6/nQ+q/KqJGsKQ5UFdJWA+40NUWoOQWOzFg/DG7ubQh0vGOT5GZ/
	 hmCD8uxTM5B0xezTmWg51uTRqHR9zMN9feBFi5N8YDw+JaOkVGzdTaw9kzpVRlR9dQ3k4
	 aQr8vtNZjb9CoFYy6h6unLNwD54ybMzjnRD1qvkxj/bl/GtPrPu8JTrE8da9l01qyxFiO
	 YrVF/+mFRBrYrvo0japjA2DBvFSPR34rgoNlL874qh3j4F+CLqOIMHVs62JQT/vJC4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=OLY7hCKY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789674796;
	bh=DUvbe31KTERHfdDaKAYKkXvxD4H9sASj2C1f0MUFI1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vsckCd1AQhUfcBpBEj2wXXLXMVRTjdykiWmsvIEWAKXZc84Hg1JHkBRNB18MWYy9p
	 70fuJQIL/MGgCV9FLqx6y6qnmWD/zJ2jGyI3PlgsBfsiaW5iE1WNalK4YJiKYqJ2bL
	 HILFVoVP2uPOASlblk1NBxCPaskJR7H9Og70QPKNiX/Z0CHIhviSTu/TWp1BWZkCov
	 T0dbOZbSphq0njsHyif7ANJGoLEYzW0h9ZZmSQhWDDsJDxtnQZyiOa4VjjKiImB3v0
	 GzooY1FuYEYZXqz7Y+168tZpoInMsjjRUVuQ44hxj+JPai0cr4kLBAzqCkr5MZWwcY
	 Y2khGLUMSi3RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AE6480FA3;
	Thu, 17 Sep 2026 19:53:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C052D352
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 337C580F7B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:53:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WKdWUQs72dmg for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 19:53:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 727E08098C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789674788;
 b=oIXsazVlXeEh77xwE24kGZtPZSdduSUHH8Wn6ccratKJB+irHQjDChI/4zRKGIVYbo6C
 3xiJbB1YywoHM3/7FKTqpV3cvWHwaiJ1EPVb9T4m0z8sGNGujMinfoq+SQEXyN+wfJ+fK
 XC88qFtuvVzE+/Hcd2zUTp/hPnO8O+l17Giv1CzOu9+Ps9LbbIH3HpfKkQGvzyHzR8f+j
 BymC/+/8Ih/Cau/ns9e3LfeVxXDBZHb3hvQSoylzNhCJoLrfrRq9AY61F9F242+so6jyi
 UTF5zG0hxTyu+0ap0ch+uMiDyj/cT/UIhGfpu74E7P/npFvt3HiQKtkAORFXONpQhaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789674788;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=DUvbe31KTERHfdDaKAYKkXvxD4H9sASj2C1f0MUFI1E=;
 b=ZxNfg2WXW6mITNBWY02e7XOSqh0HYLqSRvJKRER7tfc1lnmfChtLomD0HDT7LiCM2fPl
 RbtLSqABi6Bx4cmtojShxl7jFYm8W97hrl3l/pa60azjRuPbfv615w+MYf6iTtDKTtUQP
 beIq97NlPBTqFo7xIqiuNs83pHpT16lA1weub2mp0Qs5i7ztsPUm5FEmCvJHzspde1Ewd
 u/8oPjcHXJkmWR5s+B64Jz16ctrkdVuxI2TH6lpFskJ7JMXeCQMkPDHZnBbqyPkB2vfar
 TCE4aFNDjzTyQL7K4Jal025ngZrXZC/I1lqQaAhYCjIa2re0c/cqQ05a4gV6wFjRgxw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OLY7hCKY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=OLY7hCKY
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 727E08098C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:53:07 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9ab667so101996fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789674787; x=1790279587;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DUvbe31KTERHfdDaKAYKkXvxD4H9sASj2C1f0MUFI1E=;
 b=OLY7hCKYPM4h7KsEc1Tsb986TBF3pom/41+k+lIgO6VwYvdxcqc38dKm0GMJduuhDq
 hUn3SgAX/BkNG6CFt+z9S9m20jjP8JKn1JHKmJlbvfr4qc5uYv6I7HMnkdE2Dr4W09/M
 EncTsIoruekMKXz/Z0ONrTpvnnC8TEjWkjVJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789674787; x=1790279587;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DUvbe31KTERHfdDaKAYKkXvxD4H9sASj2C1f0MUFI1E=;
 b=ZERlOoCMZgnyd4c8ks3SwAlDW19xwYkbuMElbs3wSRxmNAo7zpHxmvJDebhAkEy9DG
 efpnZ+mLUzdR5Py+tUf+pO+/LWB9dXZh2BZM7IEe4CjZ26887pfBPb8LvF+YuYbCAo6C
 ScoaJlURfNIutS1+6cGNinvbV8WEKl9DCun8lMG/vxOrWGJ1jgghhMtRGdMnei3zP4bp
 H9tt/l+/a5j+2jYqiBCMsL8Qd7SWID0egOo2E61UKfcjHbXg0EjhglKKIPPbJL31D9pe
 0CUbF0CRMJ5kmd5cwcg5a5kGjZGXUD1MZUX0AdeyMqGKUyC+B8/IzDCncA8wCIlABHFh
 xQvg==
X-Gm-Message-State: AFuF++kROLSsKS/aEMzSayWbNKRVP5usk5edb8oe9DgT+36KfIFqO3Hk
 5QRpcs0ggYUHZoaub/RJTipMyFTgLXQrrzgum7CBVnaBYdGqZNDSXIUKMf752Kd0jo0=
X-Gm-Gg: AYBFou3egbo73Jq1/H7NTE3I+EsBf2LUENS5zkBDLnciZ8cB3Gzw8KsGlbFYa3p/N0Y
 i/T8peIoOl/3cF580ll3D/xWXs+wA1ul0nCQEpmSyPC7DQXDaTjOK+c8Pt+9p8OP5ma281aab2w
 fr3u8S6qyS/oD6sIYudtvNTZjQbJX4UcrrEvk6ZqmYwjTx91tHW2S2cHh8vlmPp8qqakZ7SEWXb
 bK0OhFIvstzirpACLSQiyaIhwSlwNKeZYIttU+Rycq317aT/FLsx0tmF5g8vNikzNZ7W9xY/nwk
 LS7E/S18nzDEB+GTNjdB5dlm6ymB0VljV+C25rFKjBu5USt3+i1P1G6ickPPno+Vfpgu2TMxh4D
 ginY/O0HwBUJdiMeg10bXtG4Z9HuqDgcDFfsVizEAu8Y8U5cWO5Wela1NZQaLolYuhmHraKQmU2
 H9mjRZUOgW1ICWtvhtV25IpU1fC3KNL8RO2CU68Oe13lzIX7sDmVURnQ5UjwxNGa3em0DmKrsZx
 5trKuGjP/3o+6jJqiJ3gg1MDDmNo4yYB3eRjEur5mwQ0SP9Gwt8EUYr/oDz/e3n8zO47MMvBYrp
 qPBgUcjPBEQZjexHerCa
X-Received: by 2002:a05:6808:c1b7:b0:4b9:a8ac:488 with SMTP id
 5614622812f47-4ccf9157388mr324002b6e.38.1789674787027; 
 Thu, 17 Sep 2026 12:53:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4cb6d79b8e7sm3741050b6e.16.2026.09.17.12.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:53:06 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:53:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 05/11] spl: fit: Decompress any supported algorithm
Message-ID: <20260917195303.GN858934@bill-the-cat>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
 <20260917-spl-fit-compression-v1-5-7985ac56ee9e@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BtEyqVCCY2DkTbbi"
Content-Disposition: inline
In-Reply-To: <20260917-spl-fit-compression-v1-5-7985ac56ee9e@flipper.net>
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


--BtEyqVCCY2DkTbbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 06:02:26PM +0400, Alexey Charkov wrote:

> load_simple_fit() open-codes gzip and lzma in two places, so a FIT built
> with any of the other five algorithms image_decomp() implements is
> silently copied to its load address without decompression and jumped into,
> causing a hang with nothing on the console to aid debugging.
>=20
> Call image_decomp() instead, which can handle all compression algorigthms
> enabled in the config, and will abort on an unknown one instead of trying
> to silently jump into it.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  common/spl/spl_fit.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)

This seems to solve part of what I just raised in the previous patch,
which really does make me wonder if we can clean that area up further
and drop it.

--=20
Tom

--BtEyqVCCY2DkTbbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqxFHwAKCRAr4qD1Cr/k
Cnc6AQCr1dtVKmBrfhtKNfXwCzCtaOMrg3uKLPbHjKOaqh1pCQD/exPNZAzqSuxx
ScLZk4EUxQX17f/xQNH3H/BytX7OgAA=
=PvL4
-----END PGP SIGNATURE-----

--BtEyqVCCY2DkTbbi--
