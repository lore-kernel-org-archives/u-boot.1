Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77118F483F8
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 21:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFDF83F00;
	Mon, 23 Mar 2026 22:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e0V8hex/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58DC483FA7; Mon, 23 Mar 2026 22:13:39 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D4683BE1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 22:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4648447e29bso929812b6e.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774300416; x=1774905216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rfdK868SqFc3I4EEB7azhpwLksyc4Rbzvtx33N1ALbg=;
 b=e0V8hex/VfVVwiuBfpDNUXwXbIuu9SNuMs2d8L8xSzWQYVpve01YoItcwK6WYW6vMq
 8si3YOtWyjq9uHsdCRajt0EEam4UI0XVN+ysgTzOKHOEZBYz7vG1i+gNYaryJhsYy8tR
 98Llg0ey8Dz5LoTMhivdyXcLbmNGm4sJ30mZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774300416; x=1774905216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfdK868SqFc3I4EEB7azhpwLksyc4Rbzvtx33N1ALbg=;
 b=DrWpJWyvj7aSC2dIApZhcQEyLLydbfc/s/0tqfB7qcEatCQnq0LVXs3X61nKwcxwho
 P5u5eZjDJKYfAVN1x6IFBQexmIUw7jVjdu1WBrRbZ87BjRV8MMDcvOVDCt7vQRWXbfZD
 q6tLJJWleVmdoLImNa2fl80XNfsQQWa+6CLarAgMdjPwnnnAj9aOnwy6ppxXSTrXPNRJ
 G25HfzDM5miszHYdedmVsYq3fft4r6A+QOWepEASK6GJgbcwLJ7P3FSq520Tn2LXA0wu
 fBRg0kX7TnAjl+yOmMVNwlGZkJJF6Ri75eiXPJMzCxrQUZHR3Jq+CiiaF/YhXi58NDpD
 OzlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdIPQBd1yF4GUemU/sNG0Dt6HY2ysQoSJWKA081jC+6OD7T4+g/TpwhfCcp9dxtCk3RPd/4iY=@lists.denx.de
X-Gm-Message-State: AOJu0YwXyEoB5pM7zvnbl9IunXvZTILjb9/hLBktF9slFglx2zsLDzKA
 DfWdr2QdJMXymtIVG6nRB/rfPXimbzv0KnUDoVUvAFQSLraRL9kuE0sT2rSH8RBO8QM=
X-Gm-Gg: ATEYQzwsQMMY8sH80Ec4/Va8MKUNiUgJPc3Zg4+7cuUAr0jRVF4A968XtbMjfzEBdq2
 abw09RrImRF93lc9ALVoQWv0301wjGxtnqlUaLrMqcPNh91c8Vb5Bx5djAEPBEOnTPP/G7THQH7
 NQi5qLPlGXzeI/u1a/sInUd/zfHfCdAS3ZES8c5xeH1IFru+5Bp9pI+pc7pmw10HQcZBwCluRFS
 oy9Hyoh4EAZDR4IksYVj+LjYFu1R+Hqm4tfr2EncKPV7w5zSz34O4V8HyHU6OfgoIp6D1kho+M2
 cTZmVKl6M/OdktLgUYOx6495BLOmfheTQUwZP3sSYLoPOX6VONSFt9GJFRG8is92+NHGVQVfTc2
 a7b4sm5/lz2DxWtBtztuqp+YE+b0inVOdwcNoTa09L5pb5WepA/KRSAbbQOlxEw1NM1ijwLW31K
 eKE3PvBukHrLMcOhj9eG4NUF13RDVyIVTOzsIsKSUxxBZH79yZAAu9InxofcgzWAD5Er+Rr5g1c
 7NmJB8Cx3CBquspQm4N7DBOE1sVK7QerOtwfxPtHVIq1d3T
X-Received: by 2002:a05:6808:d4e:b0:467:32c1:acf1 with SMTP id
 5614622812f47-467e5f3896dmr7012255b6e.39.1774300415706; 
 Mon, 23 Mar 2026 14:13:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7ecb194sm7591660b6e.12.2026.03.23.14.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 14:13:35 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:13:31 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/6] clk: mediatek: mt8189: add some VLP clocks
Message-ID: <20260323211331.GO502704@bill-the-cat>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
 <20260323-mtk-mt8391-initial-support-v3-1-19dd92f4543f@baylibre.com>
 <20260323202358.GM502704@bill-the-cat>
 <20260323203333.GN502704@bill-the-cat>
 <8ffb6e52-d161-49fd-b815-2eff4e864bd4@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jzZUzwE5JrKxHBs6"
Content-Disposition: inline
In-Reply-To: <8ffb6e52-d161-49fd-b815-2eff4e864bd4@baylibre.com>
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


--jzZUzwE5JrKxHBs6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 03:59:09PM -0500, David Lechner wrote:
> On 3/23/26 3:33 PM, Tom Rini wrote:
> > On Mon, Mar 23, 2026 at 02:23:58PM -0600, Tom Rini wrote:
> >> On Mon, Mar 23, 2026 at 03:16:52PM -0500, David Lechner wrote:
> >>
> >>> Add some VLP clocks needed by the PMIC on MT8189 and similar SoCs.
> >>>
> >>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>> ---
> >>>  drivers/clk/mediatek/clk-mt8189.c | 289 ++++++++++++++++++++++++++++=
++++++++++
> >>>  1 file changed, 289 insertions(+)
> >>
> >> I'm working on a series now to fix this globally, and it's not a
> >> MediaTek only problem, but:
> >>
> >>> @@ -1733,6 +2012,16 @@ U_BOOT_DRIVER(mtk_clk_topckgen) =3D {
> >>>  	.flags =3D DM_FLAG_PRE_RELOC,
> >>>  };
> >>> =20
> >>> +U_BOOT_DRIVER(mtk_clk_vlpckgen) =3D {
> >>
> >> This is a bad name to use. I bet in other parts of the series you re-u=
se
> >> it. These names need to be unique within a binary, and while today they
> >> will be I bet (since all the other examples are fine), someday we'd li=
ke
> >> to be able to compile test (and so static analyize) more code, and it
> >> will clash and fail to link. A better one would be
> >> "mt8189_clk_vlpckgen".
> >=20
> > Ugh, and I just hit the build problem where I see these re-used names
> > are important. So, thinking about things harder now.
> >=20
>=20
> I assume you are referring to the use in mtk_find_parent_rate() and
> a few of the mtk_common_clk_*_init() functions.

Yes, exactly.

> FYI, I would like to get away from that usage eventually. It seems
> pretty fragile. And now you've give another reason to motivate that
> change as well. I have so many other MediaTek clock refactor patches
> that I'm juggling right now, it will take a while to get around to it
> though.
>=20
> As it happens, mtk_clk_vlpckgen is actually globally unique, so I will
> just keep it to be consistent for now and work towards unique naming
> for all of the MediaTek clocks later.

Sounds good. I do feel like given a lot of the feedback over the last
6-9 months around clock stuff means we need to take a harder look at how
we're doing things today and there's some foundational / structural
issues that need to be addressed.

--=20
Tom

--jzZUzwE5JrKxHBs6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacGs9wAKCRAr4qD1Cr/k
CszWAQDIW0VxfgDXuRV6a8ABykdDp7BUrLILl+OoYOPKka2RzwD/aCagBa1NXfVd
AlsF5hclifbAAiix4YXrox82j93+Fw0=
=8kho
-----END PGP SIGNATURE-----

--jzZUzwE5JrKxHBs6--
