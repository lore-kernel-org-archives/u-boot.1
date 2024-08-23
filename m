Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F2EC5321E
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B7288AA9;
	Fri, 23 Aug 2024 23:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kx1EDvm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE1E288AAA; Fri, 23 Aug 2024 23:18:32 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 821A588A56
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5d5ed6f51cfso1849809eaf.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724447909; x=1725052709; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D1yMOvaZrj3LDVlqq7bK10nRIiit5WSvviOlfNkYkCg=;
 b=kx1EDvm3EInOWjoI0Y6eTyDa6arHbvxTQZx1tynfN3HQwF8IPO0V37onxhJu07mmA1
 WRrEfrnziHonq2VCZTF66700g8EWU7LdNT1NRnmz9Uegva2DzDdLecvjL9WQVV91nRE6
 TyJAqth58jm7xF7sXOI+5lEDicGd4+yiVFL6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724447909; x=1725052709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1yMOvaZrj3LDVlqq7bK10nRIiit5WSvviOlfNkYkCg=;
 b=FjaWLrXaGRt02HaqidcpOFaiMIfHrWX2dSs3L/gA5XuimyEBq3guiJ9hEvmXJAeTNN
 Ycw2H/ZPrFVefzAKEChnaxlvdi2RdLtj9IlIuF80Zno/zdMSvp8+XEI6qrIu1gxMl2TC
 mfAgPvqNusAYWWmEg9BH7lPabJe5rZWj2zQfNyOCjZXVSoTDPEihaewIiYo1KYkW95Nk
 I31otISkTV8SwxyxjGShqGdpk6/18C2t9NyxIIzFDf1E6aR595VrSA6XMTr9ekCspuvN
 D+wcAUVSo5hH3TMvK0NibgsLv0V9LBqb1cR9IHFir7BKDLPf2qh/3YVv36qjHI/LNfEy
 OTPA==
X-Gm-Message-State: AOJu0YyR9Q6RzktG0rHw+jJh6Dm28SkUWqeZmHBn8Y0fepQERpOAGYsM
 2zUqdJsscOnkTwd9YBu1rpixe8g2q3tfW3rayT3Wym5OJ8e1IUHtg17VdEQVFks=
X-Google-Smtp-Source: AGHT+IGr0aY7YiPzLeONx25DAxMm2oHo5mq6NuKQRh0Xw2vJeEQgFZpt4zia5nG+954HdbmeM5i+ew==
X-Received: by 2002:a05:6808:f16:b0:3d9:ed9e:ac0 with SMTP id
 5614622812f47-3de2a8ed18dmr3887026b6e.32.1724447908891; 
 Fri, 23 Aug 2024 14:18:28 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fdfc16d1sm21119011cf.6.2024.08.23.14.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 14:18:28 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:18:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v9 00/23] Introduce the lwIP network stack
Message-ID: <20240823211825.GZ1626301@bill-the-cat>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dK8JD0GXNQ5vX8si"
Content-Disposition: inline
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
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


--dK8JD0GXNQ5vX8si
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 03:48:04PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. and
> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> so. With that it becomes possible to fetch and launch a distro installer
> such as Debian etc. using a secure, authenticated connection directly
> from the U-Boot shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot

As an odd thing, the series leads to ethernut5 failing to build,
strangely over the RTC driver it uses, for me. I did have to manually
merge the CMD_WGET related patch, but I don't think that was what went
wrong here.

--=20
Tom

--dK8JD0GXNQ5vX8si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbI/JoACgkQFHw5/5Y0
tyw9IAv/YwqptXw8idU42wY98VPNK4Khaib0wUjRh5YLDdGjsjfGDvnAHfn1ldVN
0lVSlLwrT9vrZqpMyxogf+Gg4FDz9osfq4AwRC/VPnzYSS2OUeTgzUzojnWgWclz
JwRnpDnbQOeDbCxAYJWQHTbtp6npPsZ2XXqi/tQ93uZKQlCNug1rkH8T6+BHUZkS
DpvgnroWGH0J1UlxxecOJhpaAUU8ogQLY1IAvhXaQygOI1syiZOdItBTixp5UWrQ
UTheiX7HxCFZSLH1UJ4lKBcHgeWg+kUTLoh8Za3EnEEtn7CddcEN5RPLejbC+V33
5H5pMZNpAry63wwuGIcOzFMgN6AELYKvQBV56CjG7DRrqoL+Gc6wZLo+nbcFekx7
d3uLiDpu+dbsf9UlMRmRpiVS4D12868rjFWrknO6H9JrYcC2nzKj3EpSoh6yG4Pq
1MAmd1AhSBmt4F2/1OEXQaKrwCqow0Px4CufvOmTp5Z/gnfrcxAPbfByPy8zEzBK
LFPF0LAO
=9C7J
-----END PGP SIGNATURE-----

--dK8JD0GXNQ5vX8si--
