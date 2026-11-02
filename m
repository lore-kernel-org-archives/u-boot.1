Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425C606A327
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eOLP85H3;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Nu4NGB0b
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C0B680C73;
	Mon,  2 Nov 2026 18:29:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGR1t4AZ9DZc; Mon,  2 Nov 2026 18:29:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B61A180C41
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793644177;
	b=ILE/BJKcy5+nAfSgI7Xs/vaAY4fjrMf0NtI5e29iai0hMcNNuKvOW0A7XwaUI47i/IUa
	 EsmzcJ2ICfuzkaD5JTztYy+e81R7GDeQy9TLJW+jv+lfpjrHycI0RZ+m5fggURd+MDnVU
	 FSTRAhlnYi9/US+uF04x4yNv7AGS5Yk3MKIg6J1B/md4ihAJnhQAqOgLshZ+gBTHUIf9u
	 EPsCmdSvN/GA5u9rCTsO3XC/bwex9sNJJohMr//yA9Z22pAQtplfIiFt2DEwDCcWp5p6m
	 nXDsTvXLZxVH0kx6cg6Q7TFIN3jXFZYpwK/tc9RdVkncIBosMKD19xSOrQNDoF79ysg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793644177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qg27zqphlK5MNCmCIVrlPgUPPfWyJcuOUqhfLXZoz/8=;
	b=KGhkbhQwGL3UDxyPlk3RIE8ETwgdDvbEhJCq21QxDxNvdTLa6v+kAhY+zI3CqTvFJEZD
	 JYUabiypxQ3oMz5hbcVz4BJqub86Cp1YE28H8zbOUvEmX+yrBUKPAKKkRuy3ncudI3ndl
	 q4QSCIOkZvvYpeO2+McAgUv9pJrtuVCdt7m3ufq4cmcAJ00imTyjJnv5UhCMnaDE8x+qb
	 OY9lCIa9ux4HCYuSFLF8PZLNM9ULAVSchegcVtrW3fjMhiTCfAZp31nJv2T2ANnvvY/ro
	 xGdhlxEBrAF3HCrII/aLNCU2UDU06fvnmEk1YPcBJ3px8FA/miZPvFetslKn/oA6PGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793644177;
	bh=qg27zqphlK5MNCmCIVrlPgUPPfWyJcuOUqhfLXZoz/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eOLP85H3M2iOZuYamj/fRe6ySnm29sXtjhVoXv0ixCyRmUPTkEngHonbRCxWBjBWU
	 NJh7hO7xTpGfFXAm3c13cUR0hiJbbZykTdvAsaJ0ryCXO0yB/74ECUduh8FZPxrlS9
	 AWh2ruY8MpE96sR3Bg8yzLApBMV+3muqjvKpJg7y7MyPpE37RO7DQ+WY+9PBQ0lEgH
	 kah3+3hZ3xsyaPgs8L1fIioaZqcPE30MBfj54jJDZkU/Vs+s8elhsn+q/O/FsAphVh
	 vwagD4DIDGnY809SKHnmB3CEFWTgbXeDDozzKPCXNEOV9AZjZLeHbOsQ6nPbXDTXCh
	 Himb9yfZqo1Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B61A180C41;
	Mon,  2 Nov 2026 18:29:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 83C91235
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69389400E9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:29:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1QjcZLvl1-fr for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 18:29:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B1549400AC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793644174;
 b=NjeziwVfjWpRRRcvheE2sy3orN/koGGhhHmSXHupgd8tYjvXj2R0iQqYziJtJ+rBj3uX
 Oywcc2Y2EAfkZqiM2n0WYSVj/mrpgtqM/Xt1dofXcaVKVIlQGSmGEuSx5K0YdRADD72S1
 lcQf/BRbWuCus6c9vLVig9aTyZQeVY8riSe3zfvaZ60WflYtY4B6bETiuYglyJ7sqKE5s
 KV2zzPsv4odq3vTX3/y3BitjOjk90AH91MvWip8qjPWiqIN1rpmmFYq9yXJeIzNHNHAS7
 rjg0G73tTr6k4c2wKrS2a87B67R/2JEMV4RUzYNXR31niIiGH9CMitWPfHUD0OxpNmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793644174;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=qg27zqphlK5MNCmCIVrlPgUPPfWyJcuOUqhfLXZoz/8=;
 b=AzOPDBTH9DVUwsGfrcF23pAkbPxwY5bwRbC2Hpg2Kdp1IT7NAud6P+n3UlEK4S/zTlBU
 BLaNNm5QwmO5oSAqhmpoZhu6Ef7KQu5Rju1lO3JNqrKJre6b+JAbZHCbmF9Wg2c5Ux3tG
 f9ZK6NgZIQ/4RdK11vaQLiWvtlfjXRVOuJaTHS/z/2QaDODNW4IQhEJT3xIB/AyFQ5AxL
 pvL30aOwdTfQ2S99kmKG2lY/yLJPhTN5NXHBSQk1chbhVr6otQPJCeKI0yyjX+ABaX2bw
 jEbDeOH/LpwwntkN1rb9zTKNGC+vbzhW4+75svRf22J5fdvOABU7lHF3Ol/LNzCjrpQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Nu4NGB0b; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Nu4NGB0b
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1549400AC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:29:34 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4f14642adb4so2002970b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 10:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793644173; x=1794248973;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qg27zqphlK5MNCmCIVrlPgUPPfWyJcuOUqhfLXZoz/8=;
 b=Nu4NGB0bYUXVt0W1VGRChO3JbUcvSdPUWa8AYxjhx8q/7GneAdDTP95EadBytmTaZ5
 r04RhibYGVobuYYxpH7s9P+7PC48AWIngqf26NWfcdzBjLJbZNVXqxT0a1W2QpnwJ1wn
 6rmVeVcT6UbYh2wsagBH7ba+tjcPslZ1zJrIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793644173; x=1794248973;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qg27zqphlK5MNCmCIVrlPgUPPfWyJcuOUqhfLXZoz/8=;
 b=zIaAZaxAke4APYpa3/32GhLQWmU0gEW3W+6uHOTnkKUYKtGJJlRjTxRP6CZBYgWfzl
 N6fth6tUiEuyMJbCkQMLostwDvMu5OfvpFdV/gaUVB+Dvx5FbM/WYyovh07nApcWwGY1
 J12dxNGwii+2iHTLVfKVhLEhgXsgVkQjRmdYOL5Ev4Av/1yZqpsJNkKMMCVKXf77Ly2S
 s9BcXekJrJP6KO0K4kLULZrsJ/lpdqls5pvaLzqvjX7eTRHVZhHPw9awo6DqcmgK4aSB
 K1u2zOlUY/MA7E8IGkkV+OqYhYljAV06GyGFjBFdSZU2Lq+tOwGmNzsBVRXuKHHkTkfq
 lfog==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWrH4hgL+bvQuHb2+0E0tTh0vp+RxR+//s/RbQtj2HuolEO6Kmc5Zumtr17MUmC24dJjvSg8Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKJTMwdfNtqPMsuN7dVKrjwiWw5DEE9wSTmS/3ruqxJhie+B0sN
 8h7QhExGUFQk8YY45FjasdQ14kZHe/6W+uVaBdSSmMQnj/nGNlNuxV7CDgEFrnhvxwM=
X-Gm-Gg: AYBFou0Idg++Fzf3zdwatcgGs07UNaRVSYM5rCM0NAFEl/yBHtwWTnIFHfXldkZHx2M
 b1MJUdQkzt0LsWkVHQQSfPitUZ0gHIu4tIpqr9cS2B2tRhWmWw8vPc7Dd0GpxvMX+Prvd8Uog+i
 cchZiCogdPZ7KFw1/lu+mzF8ubI7tUtZOc4aqKd77RzIJvY2vun7ODclYxUPJ/qXzFhG4EQ3vqT
 bLXNaG53EglHmiHiAiFlQdwAPUi6iVo1Om6vYVlWfM92Trdg7Dks+zFyUYKVMGihaNu86hoMDqN
 e0KNSkoCEB7xeosilOnTmKYpBxICw1C6uFOOUv6Z2A9X/vmIFd7dsgF+AVbSvdCC6mBZiv1LCJy
 bRM9Y3xfwCkU8yA+cMYo6J2GN7sQVYWYVJyYOYr4k23ZZ3IDhS0Kdju9lV66yf1i0A7rbQxB9z2
 xa2u/XOB/BCKbc7SjjEnhZ6tWEUoIETYjWvAQo+Mxp1cOvg3dAVuQ/U/8mm1xNV01hNvGFtRMwO
 hz/eIwSxzbxa9tNEc+tad25jQSFEEaSeaybcxAFlgL68b+rcCmb1GbRHEkBDRdQQrlSS/g74UQ4
 iIqLnvc15ZlU9UHMGmjE5cSiogoKzMEYr+iPQzy4lROmdjwmWkub/X7We45EH0SJxiX3PH1IqE/
 LTV3FeR1VZsVIlfKfi3ZrilpG6HKcgzfPpje4eTXtgDINHtaiOlS8wsxkYAd5Y4ci3yuh6Ddk6d
 cvBCpiZUsXFMs8bZKQ/nTrbwnGFKtrKAg=
X-Received: by 2002:a05:6808:1244:b0:510:7dc8:5ff7 with SMTP id
 5614622812f47-5640deea651mr8055085b6e.19.1793644173167; 
 Mon, 02 Nov 2026 10:29:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5640fdce900sm8977329b6e.8.2026.11.02.10.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 10:29:32 -0800 (PST)
Date: Mon, 2 Nov 2026 12:29:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Drake <ddrake@baylibre.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] imx93_frdm: make room for distro kernels and initrd
Message-ID: <20261102182930.GJ3309461@bill-the-cat>
References: <20261030-imx93-frdm-distro-boot-env-v1-1-5ba9a72f0904@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZZUnCZQkwG7vqTwr"
Content-Disposition: inline
In-Reply-To: <20261030-imx93-frdm-distro-boot-env-v1-1-5ba9a72f0904@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--ZZUnCZQkwG7vqTwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 03:25:49PM +0000, Daniel Drake wrote:

> The DTB is loaded 44 MiB after kernel_addr_r, which is too small for a
> generic distro arm64 Image (Debian's is 48 MiB), and ramdisk_addr_r is
> not set, so extlinux boot with an initrd fails.
>=20
> Move the DTB and boot script addresses up to leave 92 MiB for the kernel
> and add ramdisk_addr_r for standard boot with an initrd.
>=20
> Signed-off-by: Daniel Drake <ddrake@baylibre.com>
> ---
>  board/nxp/imx93_frdm/imx93_frdm.env | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

A recurring problem, sadly. To borrow from the comment block in=20
include/configs/ti_armv7_common.h you should have 128MiB of space
between kernel and device tree.

--=20
Tom

--ZZUnCZQkwG7vqTwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaujWigAKCRAr4qD1Cr/k
CurmAQDje2YG3A5Wmc0Ttp2Cd1yhkVS/1aIZBUxkstCLGbzaegEAwAvcpO3XVX8p
0xSkV1cTsSH57a5g916q/GvW2OBshAo=
=wr1s
-----END PGP SIGNATURE-----

--ZZUnCZQkwG7vqTwr--
