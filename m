Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42078D3E788
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 04:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 357CA88B0C;
	Wed,  6 Nov 2024 05:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="keHYHDbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D6389175; Wed,  6 Nov 2024 05:23:24 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AFE98860B
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 05:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quwenruo.btrfs@gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1730866999; x=1731471799; i=quwenruo.btrfs@gmx.com;
 bh=8wSnnxJsFdfZn32ul//unmWKV4Zv/eDK7tv/M4m88eE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=keHYHDbubKwfVEExdyVae3aQFNLltFJ6exxIt9iIDHxZTBFfrwAK6eoVqVo21hHf
 K5Yw/m+6DZ5UB8e0X3FYPoOoPvq0cgqDfyaIAaY56QbyJHmxOZha88jBrS1dxRqbA
 aVKakSmhkBFk76/E+hCkwO90ncFS88tYDFJB3yj9EUCRxVi1nUf9m+X91ShHj3WN1
 bzt2OwNxu75mPJOQZfaYr3Xk616sZqeDxaejMmjw07AZcUYpKs6KSvYZA/FeZvTmm
 PQRdzXPnfYGtbm5REYCB5nxhakepl2jKYmyOdZSZDw2pSD7KBZCPHVJleL98JE28W
 M3KizYd5xdxA+Dv65A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqaxU-1tdBTz19N2-00eZ53; Wed, 06
 Nov 2024 05:23:19 +0100
Message-ID: <864430d3-65d7-48c5-8f59-30869ff565f3@gmx.com>
Date: Wed, 6 Nov 2024 14:53:15 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [u-boot PATCH] fs: btrfs: hide 'Cannot lookup file' errors on
 'load'
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
 Tom Rini <trini@konsulko.com>
Cc: linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
References: <20241106012918.1395878-1-dominique.martinet@atmark-techno.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20241106012918.1395878-1-dominique.martinet@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j1sjjEgfLwoRLEoBSDWWmf/M4DVwrhH9KQVsvE150wfnFaU0eM8
 8TgUgwqhoz4eH/7pRjTawC6ywBwVHvkMxMCmPAnT2dkKwpNui3yI7/LW5bTR3taFuxSo9uJ
 v+21ISWOxP2H0B+QDTahCAzecjBAKk79TEFxX4UZoVt4DTlOqgSy1z30S2R9RAWagwQrLRQ
 dBW3cKTk4wecwt3lqHspw==
UI-OutboundReport: notjunk:1;M01:P0:5+7NKCrtaek=;GImmB3UlW/N8+OnxDEmcPgObUA8
 2mgoSnGYO3RIYgYRGu8vQ3KNSqRiNQquIDhTeQ5j9tpd1r7L3nBHVG5WqgX89+/a4dTBCCXth
 lCamWeDlAtV6ozzJrUCr6yzUtP8KXLry5LaLhvPC+7XElZ3cUalc1CuH/PpLCxsjId3abaMqZ
 RHv57LdI3/Pmu4vI9xoZbLq8NUQ8M27Y+eIY1fpMVQz82lFxVBdfFlzSmcK+jzP7RKhLUxiSt
 7NlLjAJ+DdPMZqfHMypOlRuJOrv07Mb4dN/4xiaGCJzqBxulGy8sC40CwuW/R2Hf6BBNvJLc0
 /TTyoQdR2mr+U588OqHcQd5f9NFcr6rbuvdonr+84I0gIlTriz5o/7/Y7PbOLIjVDj7+ZUwRA
 2DZjzk56NZJD4d6eV/7WB9oFg26SbQUuTgGHGh1Z+Msu2Au7g/7vZUVu27jbZYNOnmgCKwiSd
 ueEdh64Sl6tEUzag3Gbby0TusN+E3kLx0tLrvt/0j+rJ5BOVxIH8CtZHouiWacLywOcwLnyJC
 UJvLXEgGxoK40gbBgBfUmTlLTN+32HO2d09hURJ2JUhJ22elDQ8CYtZTBV3ZQQW0UCysz6JcU
 F6He7b+w1yjCP67y5YsYnLqq7B+qwrK473qF+SD8i5l6kLUqjGpc/Fsvlhv1vPKknxL1HI4AS
 csE3REbpnYMtF/qfg8JYVaaOQZUdeq6i4zxxLIoioYDTCCUk7fhg9McmChZ6aoEvazsdCWqHB
 X1G+KK0MO1bUZjirLeBsjEi5TSQHC7mXBOzdZafBpsFSJ0f/pSv00g1d4qtAO9eQ8ZWVZSTcl
 HGnTI0Dp9bItxSpLoLRrTwjQ==
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



=E5=9C=A8 2024/11/6 11:59, Dominique Martinet =E5=86=99=E9=81=93:
> Running commands such as 'load mmc 2:1 $addr $path' when path does not
> exists historically do not print any error on filesystems such as ext4
> or fat.
> Changing the root filesystem to btrfs would make existing boot script
> print 'Cannot lookup file xxx' errors, confusing customers wondering if
> there is a problem when the mmc load command was used in a if (for
> example to load boot.scr conditionally)
>
> Make that printf a debug message so it is not displayed by default, like
> it is on other filesystems
>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Since other fses are already not output that error message, we have no
extra reason not to follow them.

Thanks for the fix,
Qu

> ---
> iirc this also used to trip up some test in test/fs but I don't recall
> what.
>
> It might make sense to print that error but I think we ought to be
> coherent and either print it for all fs or none; but if we print it
> we'll need to prepare a new command to test file existence before
> loading it.
>
> Thanks!
>
>   fs/btrfs/btrfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
> index 350cff0cbca0..f3087f690fa4 100644
> --- a/fs/btrfs/btrfs.c
> +++ b/fs/btrfs/btrfs.c
> @@ -193,7 +193,7 @@ int btrfs_size(const char *file, loff_t *size)
>   	ret =3D btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID=
,
>   				file, &root, &ino, &type, 40);
>   	if (ret < 0) {
> -		printf("Cannot lookup file %s\n", file);
> +		debug("Cannot lookup file %s\n", file);
>   		return ret;
>   	}
>   	if (type !=3D BTRFS_FT_REG_FILE) {

