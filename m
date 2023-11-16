Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618D1C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643CC870D2;
	Thu, 16 Nov 2023 05:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ss9YdPed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5AA487258; Thu, 16 Nov 2023 05:43:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEA0086F53
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quwenruo.btrfs@gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1700109829; x=1700714629; i=quwenruo.btrfs@gmx.com;
 bh=kcY/9DWz3HeV/6asvyZrJ9/esOmJFvIKpghpoQUVzVI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Ss9YdPedqMxCgF6UnUIiXbsJ1Zr+vkwyU2fAtYF8swww6h98vMF+n8B1Zd3m9y6p
 yunHswOxHRHE2Q60c9OhbeQGSMVGW+KSdSVda5NDUYpyCiHig8K1IA9X6OywwDRGn
 uk+p5AwpdRyltpK/uAkGnz6nQbTorDQarXj1M3AxCFtEyHurJiEMqaTCXi9pSkcb+
 9jkBMOoZCANXF7grcZdOarGF3bm0Daamjyt5px9FQhYQwBekEjrU3xDEnUCgydx4S
 BviF+BveDUph61UQLST/zDxItvn5A539GOAdmP4LaxqVfSKLlqti4RCv9k0kB/5ZE
 PIfclShgIg5HEoSboQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N79uI-1rQWPA2gYe-017QwL; Thu, 16
 Nov 2023 05:43:49 +0100
Message-ID: <fff8b725-1c64-4407-acb8-c47c258e6571@gmx.com>
Date: Thu, 16 Nov 2023 15:13:44 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: btrfs: fix reading when length specified
Content-Language: en-US
To: Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>
References: <20231111151904.149009-1-CFSworks@gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231111151904.149009-1-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oMgDiQycwge92N07URLDVUuyVih3rM8QuvtldTwLxDZr20pxKK8
 xE5h8/Rr/7m9wV3YXkgeTebbVJiBqOMzj/xNFdpktj+SLJGx8+CuwZzkyAt9wbMWG6Z91nv
 rqtIF/WaHt69omSLCCEfrqe04//0DDWKt3Lvf4Tdzffc2+nvGq6A/OXZMblORP2vNFhtXGx
 JyXxsSmnoBiIjLaJosKGg==
UI-OutboundReport: notjunk:1;M01:P0:Kt6EdSdAHPY=;XEyaNhVGLkI3Ln43+s2ZTezIUwK
 Rxx7pf8/ucB3IOr+HjOOTDcZEMIjNFfkkYSv6DeKEOqcHBKVBAe+FTnT1lUu9Gkg31MRducug
 KrjSXGs+ot4lJBwd8OuB6yFSzhdLcBX4dpBaz/n8vsfdZgniSF0lOpYtWTdYQfEudQZiM8tbt
 nkBiURIdPIqqyi5IPHeC88y6D5THV8qHWxlRGkUwEx0KOAN+Tuoj8ckGeqYdsPiFY4njExl26
 vny4C52iDaMlFC7lfn6cbxADGZ538iobL4w0qiNDGZPJxaRbq24/QK7zKjS1VoE7TrvwxCFy7
 5cgMqd7Z3b0EhfLm5SmY65iRWgxXcV+IIt29awQXEOcJ+4plRv91iMdx6EZnfyLFRdhN+HKj9
 Ldkp3yqchKV2BxmumjjXUboBov8jNrBpl93qrewaY8o3IAkp5mSZH+lfZE/p4B1Cih2GQ88RZ
 NbLgcwYfaVfoJIlK7K7Ec+C0BI4jdYfffQ9hLKvC2SySRJAWTokAF+iFqfefzv/yEYX8G1c3c
 2yfU+lIXrLveSBItpjVARE6x6g07fFtF8drwiad+YfdAoihIAG03sUFe2ixNsWflsHlBZXvIn
 uA9QzG3Bs98fpsabo+znqqZu7Uz7LAnLZFvYdAlnSYOVSOXfJM7dejPQT2R30Ksib/+TDLi/N
 +wFHXHIQ5xAZi3LxiF2mnOgCAcH0upWSKUlBvenD70EsverRXXq385mynhtNuJX0wNSbfJPa5
 a516OAMLkqbwjjH3E9NRF+qRhQhG4G+PL/lvIpiIsc7byULX+ldekIic84UKhNyRoJPsDu3to
 sfNDq21Mv4LO6Xdo2Y9xZzaCyDCFPT+ULe0cFND+et/wEb4n7V1jybf7x1BWL6QuL5LIvyEfu
 FSyiWAzDZwtLva8D3oqHeSXKPI2NoeKypy4HrJRgj+bWTc8NfRSw/ULEYnI/g7KRomNbZjUXm
 01LovQ==
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



On 2023/11/12 01:49, Sam Edwards wrote:
> The btrfs read function limits the read length to ensure that it
> and the read offset do not together exceed the size of the file.
> However, this size was only being queried if the read length was
> passed a value of zero (meaning "whole file"), and the size is
> defaulted to 0 otherwise. This means the clamp will just zero out
> the length if one is specified, preventing reading of the file.
>
> Fix this by checking the file size unconditionally, and unifying
> the default length and clamping logic as a single range check instead.
>
> This bug was discovered when trying to boot Linux with initrd=3D via
> 'bootefi' from a btrfs partition. The EFI stub entered an infinite
> loop of zero-length reads while trying to read the initrd, and the
> boot process stalled indefinitely.

I'm not sure why this happend for the EFI environment.

Doesn't the EFI runtime should also try to read the whole file? Or that
EFI environment has specified the length to read instead?

>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Anyway, the fix looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/btrfs.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
> index 4cdbbbe3d0..1149a3b200 100644
> --- a/fs/btrfs/btrfs.c
> +++ b/fs/btrfs/btrfs.c
> @@ -228,7 +228,7 @@ int btrfs_read(const char *file, void *buf, loff_t o=
ffset, loff_t len,
>   {
>   	struct btrfs_fs_info *fs_info =3D current_fs_info;
>   	struct btrfs_root *root;
> -	loff_t real_size =3D 0;
> +	loff_t real_size;
>   	u64 ino;
>   	u8 type;
>   	int ret;
> @@ -246,16 +246,13 @@ int btrfs_read(const char *file, void *buf, loff_t=
 offset, loff_t len,
>   		return -EINVAL;
>   	}
>
> -	if (!len) {
> -		ret =3D btrfs_size(file, &real_size);
> -		if (ret < 0) {
> -			error("Failed to get inode size: %s", file);
> -			return ret;
> -		}
> -		len =3D real_size;
> +	ret =3D btrfs_size(file, &real_size);
> +	if (ret < 0) {
> +		error("Failed to get inode size: %s", file);
> +		return ret;
>   	}
>
> -	if (len > real_size - offset)
> +	if (!len || len > real_size - offset)
>   		len =3D real_size - offset;
>
>   	ret =3D btrfs_file_read(root, ino, offset, len, buf);
