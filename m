Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A0AC79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 18:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C73D240B71;
	Thu, 10 Sep 2026 18:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fK5HnhlGMySr; Thu, 10 Sep 2026 18:37:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F1F9940B5F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789065456;
	b=pn9RLZUbRy4ukdm5vMYJfWKPDa4NNP+5rT7E9+/qZ4bHun/Yri7j30zHZ2lRfMjzCs/w
	 bRxsNPGpoLS2BTwNlmZoEnjn7KquJq0+5KkAlchxon+QkCTQaoRhoPxxiBftel6JMO+/c
	 uPqcvwq+bV27r9h2PACsQXc0HumBey0/1ZXuKHvrHE8jQi4lJO26EVqz/GKl/mtwyZzQH
	 pVL+rd2/WV9Em1jNk7rGIahYYSZGVKQ/KllYmASGh0U9qfeJUfvq4Ijp35SBcofV2VYI7
	 A15WcNmUrVBkQyql6El1E7YuY2QLeGcIa0TrdZaa+LQngG0qh844/EXPzlrKVDQXjdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789065456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ht88x5pduV6c9tOSKGoDjKgJ3mtG9jICjnoD+3Knw+Q=;
	b=VUxjkTHlP6tQ9nO8xVqAEuW1Lc1kmCFYRoERI8O6dPij8Yk447JnyYD1IO4SSp5DpJSk
	 kTIsmKlZwdhHoW0+R4Mt+1GKipI9YJl2OJgbD//72oaXfjaR6ydXfXZi/aTvcZHstuXjZ
	 4WJfNvIWshrwQgpW/g6c01/Qsl1DjBzDiT6vQhm0Sz5M0WhZk1qej+QhZoyDRs3aBY/vs
	 oN1OaRPt2CG3CrBhR+NKJYD1CocAVTPaQXH4O6xbK53Js4UIwnThmNVcP4bS/5HT4yAEY
	 47N9GqDCximgLQOPEuujeAdS7nLbSxOnBaBarP4G2wsr3Nhxa0vwomxeJmBrT0FN9iQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789065456;
	bh=Ht88x5pduV6c9tOSKGoDjKgJ3mtG9jICjnoD+3Knw+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sXhw5JPfxuS09TYzSyme3tMmiipKHJCRjpwvdB1ApdJQEnpmaHexdAS7yCWriurSK
	 gIUYeB1rM64t55oDMWk5xyTFdMSS+JU5h6cTeZlycWjEPE+kB3ckinKTQhKoZ+P+1t
	 Lz4nykNHSzJzJYr/X/EtibhVCWvjcXlHNIBbWVRuRVcIPiurOvZA1Ii3VgQIog8Rkj
	 nJk0RA3UUkHzOduWWamY21tns8f05yBDsR37ZDV2RyCgMfjcodyAfwzRwkdOuDSzss
	 DBLYgPBQrS5m0uDDq2bPJMYOfCyzPU8Y6g1jSMtT7i/dmIxdGCbgV9S9neSYZ36X6R
	 PsZnbSYB+OwEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1F9940B5F;
	Thu, 10 Sep 2026 18:37:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B230B43F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 18:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A44F88117A
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 18:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KSni4UILkd4y for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 18:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DF67181175
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789065454;
 b=SIrzg59wmOuWfcR19gqp9d29DYlO0VUF92fFu2Gd0HbAODOW9uSJ/k9r+a1eJCQvBhTL
 l2ThwruHxSFNbQHqocwYK2n9MvgQuzRBV/Tqe+KXgNOJsGUW0Y+FMaqeJL1zGC6jjXv5k
 AVtzaMJK2eRE7ST1ONHWVjuwhUy+j5FGcUfgW5y/fxAdhGlYBXjqo+JlKkJJeIvg1UHAS
 ZAtAvaFbas9KquL34jZNeIXGz8JQ4HbSKEAtZBT7BQ3NnAyIUot9kFW/Av0vrjaAqyGcm
 uZA6cM7AZZUGcwXePpnpHwUeEBZmP6jWp4/rtniyRlHBNCVrddqZx6b2HGc+9u7w6Lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789065454;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Ht88x5pduV6c9tOSKGoDjKgJ3mtG9jICjnoD+3Knw+Q=;
 b=D99O2C42kuZLaiRGiAzXCQu4hC/+SHgwjetZhSk1FWUphf9PwnAOou98tBT4EDvZnaog
 oxG6Jpqu8H+T3pFslPGW+0G+Yr1dkluiPNsvU4+RF+Clf71T90/vyV+/LAuLX7vELYtN1
 xyBQHtYYEMMJnaAWTS9x1s3IpSLuT80UtjR4lISPGri4t580Sm6SqQAoIqgajwsVP89BR
 C7pWpSlrhml5Kh57rRnmFywaZZic57xFraNSB/VHI9p0cteJarHUyBhHHuoI9THt+Mj9n
 KBA0cV3a21PPlzY5QmdFQOvd79AoJnXcuY4rXjroNeml/7voYGyncjTJQu5n5JXkGIw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VFOlpaDi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VFOlpaDi
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF67181175
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 18:37:33 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4b3b1b3b992so91125b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789065452; x=1789670252;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ht88x5pduV6c9tOSKGoDjKgJ3mtG9jICjnoD+3Knw+Q=;
 b=VFOlpaDizfvKJDGMXaejYueL0mgemT35p9BE4+QDVBBNmN99MLboGudvGkXCP89KYc
 3iTVGoB3mFJ2Gey5lOpqYtHsTsOxT2di8kdmVas2K8l4gMdeLoJVB/vR9/arPsxguufQ
 U5W09Vwv2bdM/lhtQLJ6Lsj/W6zhkg2l4Xf2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789065452; x=1789670252;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ht88x5pduV6c9tOSKGoDjKgJ3mtG9jICjnoD+3Knw+Q=;
 b=CQqIWT88Viej3+4LaxaMN9dr1VmQ/VveJxYOT9MivK/UyYXtai1A1IqTZjZPdHnsPA
 8GjtytQnAVVp3nK0IW2esvJWRVJFMJDVC/eUSI/lVYjwBIPEPUG3BX2E+SaZykjKZSi8
 NlDwx7/zO0Da97Xb6a2NqvpV1nP3kMNAiTN2/IXDjguTbcsZIyliIJPaeU/L5Z8AqVUQ
 8gEO+LcYGrOZYvZWS+kcYeMWw3jFjShGKW1KmHOv7srLeXObt1/1Bqe1ojONFqvT/re5
 wXWfB2hWqSwA3Tn9+54oOyFUfhyXhNLivncOeeOqZ+IDKSmiS8x61ueT5zXfiyh2mvlO
 alYw==
X-Gm-Message-State: AFuF++las1asumyE0QBbs1+wmltZUdgVk4AfwkpxCtfu3ERkXJdORJIy
 zkHhdC/aLLVp48DZJ15hK4nKyzJMKHV6NT5mW0aFFZcEt8J4IxJtD1zo/nQkOO0czOk=
X-Gm-Gg: AYBFou2+P71lT7uer9+mtw3VMdWlFvHUQfQIQw7oBa7gTOnvSLTZ2MfT2yuQoRSPGMb
 TLlfU/V450Yiqj66e+HgoMgGZf3/xJ+BtG1xLf8udA2KEFimC/6BAdJpGIV+eCVMzlgAoY44qrc
 OM4v9UDQs1ropqS2dH7yiw5pbZygZCw/maz6w6hjuFmjPBYa54mmOhjtA/1ZkuNrMmSmrn2e0a7
 7YVRBOnUM0yUOu09i9l9aJa3vPos1qFQ3w7p6RucvHDMgmbBQMRjQneGJ/Of6Ejtc705NsCGCQO
 Fduv8N6edrKUtIevy240jLGlI6a6h0hyUKKBH/S9fJ42X+dQbkv0EgurwWJulrpeUGIF3QA1WGT
 Ig3uANR5vkNzVizLZc0sASalAWmCv9bT3QcXYLyhYmK63f2FJSEVkx66XHuHaexAV1fo98FWUuv
 kDnuB3r984qthHHNyhz0Yg9Dsuff5c01FOVTtRi2RqwvNkFNorcHjNrPv8WwWW/BNGMOxIeZPCW
 G0YDVutwFehA6QcD2wcvCgl7WhTc2GzrKlhfFlusAYg4uU9giEFMc3y7JMeFJhFcz/Az85wICzB
 AEyxdRnay4rvpCn15tGI
X-Received: by 2002:a05:6808:10c2:b0:4b9:e5fa:8a16 with SMTP id
 5614622812f47-4c31b3c7513mr289722b6e.27.1789065452163; 
 Thu, 10 Sep 2026 11:37:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c32eb41142sm8589b6e.2.2026.09.10.11.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:37:31 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:37:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH] spl: mmc: support board-selected raw partitions
Message-ID: <20260910183728.GM1764417@bill-the-cat>
References: <20260910-ccaione-upstream-part-dynamic-v1-1-381414ad9a34@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X1pHaPjI8PfUYFnX"
Content-Disposition: inline
In-Reply-To: <20260910-ccaione-upstream-part-dynamic-v1-1-381414ad9a34@baylibre.com>
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


--X1pHaPjI8PfUYFnX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 07:49:29AM +0200, Carlo Caione wrote:

> Boards may need to select the boot partition using on-device metadata,
> such as A/B slot state. The existing partition hook runs before MMC
> initialization, so it cannot read that metadata.
>=20
> A separate dynamic-partition mode makes this policy explicit while
> preserving fixed-partition selection and explicit requests to load other
> firmware.
>=20
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>  common/spl/Kconfig   |  9 +++++++
>  common/spl/spl_mmc.c | 67 +++++++++++++++++++++++++++++++++++++---------=
------
>  include/part.h       |  3 ++-
>  include/spl.h        | 21 ++++++++++++++++
>  4 files changed, 80 insertions(+), 20 deletions(-)
>=20
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 0618f42c941..f5904af3ed2 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -574,6 +574,15 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
>  	  raw mode. U-Boot will be loaded from the first partition of this
>  	  type to be found.
> =20
> +config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
> +	bool "MMC raw mode: by board-selected partition"
> +	select SPL_LOAD_BLOCK
> +	depends on SPL_PARTITIONS
> +	help
> +	  Use a partition selected by the board at runtime for loading
> +	  U-Boot when using MMC/SD in raw mode.
> +	  Override spl_mmc_get_uboot_raw_partition() to select the partition.

This seems interesting. But, looking at the resulting code, it was
already a little bit of a mess for
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION vs
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE and it doesn't make
sense I assume to enable both at once, and now a 3rd option. So, can you
please think about if any of these would help?
- Turn the current two options in to a choice, then see about
  simplifying / clarifying the code. Then add your new option, and
  hopefully keep the newly gained clarity.
- Restructure things so that we can have a __weak function and override
  it already, as I imagine the metadata here will end up being fairly
  implementation-specific.
- Move up the mmc initialization to be earlier.

Thanks!

--=20
Tom

--X1pHaPjI8PfUYFnX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqL45QAKCRAr4qD1Cr/k
CnPoAP9lSky3sydoNPFivMy7MhkhlME6LqWyT0bvOjVOzYoPKwEAge+bUAtzeLd8
Fm4U4+PEdX5rwY13T8mSvJMw57xLaQg=
=UOb0
-----END PGP SIGNATURE-----

--X1pHaPjI8PfUYFnX--
