Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00F606A31E
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HmcPGSK4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=K+8F+KxH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1F3B406FA;
	Mon, 26 Oct 2026 17:29:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pVGL4o4QI27k; Mon, 26 Oct 2026 17:29:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 953BC40623
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793035756;
	b=PwGxg5F8T1+KZ3nqRGC4KReTdmw9gToPF3pVS3pZEPCrxIvo2X4+cGMOCPr6RXmFzYwo
	 XNuLnEGKTSV39FvSjTmfND07K1NhdHW3xMFD45AbzEJjvlzwXaowHBSI4kf2yZ9qAa6JY
	 VWQuOAAaB9RIAGrHLbS1CGIIQnKsF4QxUtMjPuWhYUkGSsBYO9CjjASVExc0l0gw0CBhk
	 /3ZOkUCoR+9MIU6+Ho/V1LWvguCGnJmumdmJJS9oIG9Ck9ecy6DbSyuFmfhCmQtOtscs1
	 4QdFzbOOXFwEQhPgn8wduCB2W8hvwQXhg7Qfqs70NFjtaZX9bxEyfv0WKhiCYCAkyHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793035756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=b7uBsV0zzkqm/v3GQQ7M2jO5bwkPsmzr9ZsEJ5Gz6cQ=;
	b=gkgNMi9AK5/0deM5RMBV3/fXJ37ZlzvwQbHIGyZ1kExw7uTSG7jvO7mejqXe34fAQ5ah
	 banQUTzeNSB1VeZSVXdyqrd6FtaUcvZ3gPHS9Ffl6CIf+uyDCrTQ+pLTrhw5nDF+KNOxR
	 uJEwrRKQUb/Yqvd6oE40S+lNiUp51Owu6Q0vLcoFjl3Do4yOr35FeCITMy/JhSZlN7oVW
	 nwnbE6jyQ+qRCu8kjqPSyDxlJ3jhiuUGUAdDcfjQk2sr0ztr+oM/OVcfiX/4PEnnM/F15
	 BC4V2U0Qxm1Er7ykjSo9PcDxZDQNzHbbkMxvCWEPCGXVuh2IAZAyQL4S2/fHJ/jHL6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793035756;
	bh=b7uBsV0zzkqm/v3GQQ7M2jO5bwkPsmzr9ZsEJ5Gz6cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HmcPGSK4F8nBqEQd6rcxY3RqPeJNoutWzdCdV57s3d4IZPbJTioHlckMpqNenzuT7
	 v/aarBIiIRtYsZM4QSCucQGlrmWpKlCDb8NUP8APFhgMxeD5zCASlKs5Q5gOfuVewf
	 wnlTZou0u7Syy98+pZMCDiNjbwAoeIhnK/Wau1kg+KVc9P8HqDVVwwRjWpZvB3YGW5
	 FqYkf7Hqun8a19MU3zo+6RRbPm0rc3CgMumjgfYzXSCsaX6VesBlsdMI/SwzWSjvco
	 ZVzks83KTSWMLCQzidjLe6GXCmN5aUaKz4rcyLBmRQDCIdtXei2TqTKB3tMHz0OWDr
	 KxnGmqU/ToE0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 953BC40623;
	Mon, 26 Oct 2026 17:29:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C400235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E06160612
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:29:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vZWYNWGsHpbe for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:29:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F3A6A60607
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793035754;
 b=KGxv7cKNTt8Yg5wW0AycH0E9NPQEoTfj17CPsnAES6VTAK/W0QqG6eoteqOh2hOhjcuU
 q2/aI1/wtUQxz2/wvPv3mGfeuvlnAPPwD52IpfmgYmHn80aMne0rwDC5dc2MLds31pDiU
 v/CyNtux0mslhoq0rh+AsCU6QEkt9PwgfYaJHAQSfdQS1Ds7CRG/rFOHIsXG2hgWtKkRe
 U2lhp5TwAR4WTsdSZUlPEJxsMvg89BfLvaXIbu+ggYpswIMH0xp6B9KEpXb5KfC3sGTnX
 WVQV8AhUxk6OR4tZ0ReutIhTAYIElznBFkZy1JaATFVMzYZg/KoaSIa9j5idPfXcDGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793035754;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=b7uBsV0zzkqm/v3GQQ7M2jO5bwkPsmzr9ZsEJ5Gz6cQ=;
 b=dJWHlSRF3WtoEjaMGJyF4zHLu/9JyvRlIkExyfN2MMYbdpsUQqD9fIMeWBQIVenEqEGW
 qplL7aJEbSqXnHGxxewbulbtHW83W9rS7L+/ZzTEH/GQIcBHAl/qIeJ+lJNnldwqrmJ5A
 xOos8SxQejTnmMaHMgWZUDJ1jQ+9dEWi29mJZ71CpH6f2czJm+oT8mF0SynCB37278P/H
 LNlX78XqzCbl2NWhqUMyluj98PITAVbw5jVoiEDtLcNEKr4GidyVn+VriMYdBaeCNzDxG
 spxtW9aSf1uPGfSZohlSodkfBvM+LBkdyUFRbTZqjDAnmn84d1XReCS3NPO9ymcxKyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=K+8F+KxH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::4;
 helo=mail-oo2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=K+8F+KxH
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3A6A60607
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:29:11 +0000 (UTC)
Received: by mail-oo2-x04.google.com with SMTP id
 006d021491bc7-702ba2fd61cso781164eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793035750; x=1793640550;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b7uBsV0zzkqm/v3GQQ7M2jO5bwkPsmzr9ZsEJ5Gz6cQ=;
 b=K+8F+KxHF/674FTi7YV1Y98B8rf+mKXR4qkcrSvFXtomxY8wkVOado+M2O5oo4sBK5
 LVRAkP/Tp5DletGnAprmnRrVzsJ5PUUm1kE/Pt43SNus3wtViZ9oNr7Wyav2cBPnUoiN
 echmtuyGoPL+s1LNyENuEF230VBwHOBW7/wXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793035750; x=1793640550;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b7uBsV0zzkqm/v3GQQ7M2jO5bwkPsmzr9ZsEJ5Gz6cQ=;
 b=zmKsG94cuVBSemP9DHXmKYiLWYDeu/a/zc6Mx9Ui+Tq8aYENNOT9b3yThvnEJSpE1C
 XY+U4QkZBJnIXOzn+QXvvJWeCKNshDdT7mhZe4K0TdYmmY3lICOY4l3Mhy0mD143aShT
 q1hJYmLifKgmwleZdnvD6LepemWt7CU9PCco1OlrNWx+iqLj3s/rAaw7a3+a72Mw1e7C
 k/Fp+kdV/xInuUK0V+ahcZyd5FacMlkbXYi2f1mTHmnxHWMmtmIlhggKYPRCooH+ftMT
 M7pMO+mJSAKXw00qtvVgLRiygjh5KzCw9fSGJi3pvQukdeOLE5/8pbw8jp8kBueI9P48
 LSqw==
X-Gm-Message-State: AFq9FYJrvwozqoLGs8Qa8ZUk7xdzjk8sSaaeDYRUOuCgRlgqu/R+BUAO
 SHVA9FrBHTdbPUWD0/G/O0MFa0c2RIR3dWxA13eahSZqKQMoOVJt2NyL9bcFqIDW2E8uyeNBomj
 FfBrG7zGvD43j1/E=
X-Gm-Gg: AYBFou1jTgP8Kp77C+AlqJZ6e95Wj0SeZEYOvUSJhLESaA7udOkilrsEV6zQ7x0PuKr
 G8Xcv8FhdAVP2kVrIiWkaxilDjL1tMrCauDq9J63x6NYWzK8+JRJ7W5iOz6woFuaFeB4Qqe4RiA
 LM31udDjswDHC6YQONYDIv6Wvizi2xm9ZtWPUp2d/BmeVuvFozzHfgEfaWKEyA8FAptINMcNlfm
 KEfYvz6V0hfzowQtNVdJ5xBvKH3tTZD0C77J+UOd2042+uZB/V0QBrT3YTBYtqB82Dd8z171wAZ
 rUDpYxRJBI3ivLTr4F+adcU91zpNPN4y0yWwaHZ0SvTOxo9jmA/vRrC6DwYXluM124gB8lfSycM
 a0B5MvqIpU89FNGwz3gWg6JXesDp7MrkYgvyX8oVGz/HxRzs791OaFOuebmHDWOYg+WWYAyZCxK
 ZqII2QsjU+VEEpACqW8X+jTlpI5qmu34gLr2JOUW6AVqf7zjB/HrQpKhzLzhry6p3Qdm3W3ECls
 wln6hmoEer+1YEJdZ11Prggm0/Te04j8Pu0qNKTZwaPPT9h8jCJ2OR+F4oCsYJL+ghzqFTvoihM
 BD2lp61cWNEn1gZn5icdqpphnsBkdZqTao7q0upwcT3ClA8LeOPootpUqKaljjrzgF99JuVmO1h
 y9pQsn7OQQNUYLgE1Y+F7yW1dFnsFdQ3N2gXPvMLFOs7n23qgVUtva31JZQ==
X-Received: by 2002:a05:6820:1c81:b0:6df:2b6e:d57a with SMTP id
 006d021491bc7-70ba0f1d435mr3895656eaf.76.1793035750316; 
 Mon, 26 Oct 2026 10:29:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9e267e73sm7921159eaf.11.2026.10.26.10.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:29:09 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:29:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH RESEND 0/6] fs: ext4: check on-disk indices before using
 them
Message-ID: <20261026172907.GG646438@bill-the-cat>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u/Nyisdgt8Z4KD0t"
Content-Disposition: inline
In-Reply-To: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--u/Nyisdgt8Z4KD0t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 01:04:03PM +0000, Ana Bobillo wrote:

> This is a resend of the series posted on 23 October, now with the
> patches inline: the first posting carried them as attachments, which b4
> and Patchwork cannot use. The patches are unchanged and still apply to
> master.
>=20
> The ext4 driver takes several indices from the filesystem image and uses
> them without checking them against the structures they index. A corrupt
> or crafted image can then make ext4load read past an extent tree node, or
> make ext4write (and saveenv with the environment on ext4) write outside
> the block bitmaps, the inode bitmaps and the group descriptor table when
> it replaces an existing file.
>=20
> This series checks each of those indices where it is read:
>=20
> 1. extent tree nodes: entry count against the node's capacity, and the
>    depth, as Linux does
> 2. the triple indirect lookup compares the cached block with the wrong
>    index, read past the end of its buffer
> 3. the write path refuses block group layouts its bitmap code cannot
>    handle, including zero blocks per group, which divides by zero
> 4. block numbers released by the delete path must lie inside the
>    filesystem
> 5. the block group of an inode is (n - 1) / inodes_per_group in the write
>    path too, and inode numbers from directory entries are range checked
> 6. tests in test/py for the cases above
>=20
> With sandbox_defconfig and CONFIG_ASAN, the new tests fail on master and
> pass with the series applied. On master the corrupt extent header is not
> rejected, ASan reports segfaults in ext4fs_reset_block_bmap() and in
> ext4fs_reset_inode_bmap(), and ext4fs_init() divides by zero. The
> existing ext4, env and mmc tests still pass, and repeatedly overwriting
> files on clean images, with and without extents, with 1 KiB and 4 KiB
> blocks, keeps the images clean for e2fsck.

It would be good to see the results of a CI run for this series (and
this also applies to the other series you've posted) and we document how
to trigger one in:
https://docs.u-boot-project.org/en/latest/develop/ci_testing.html
Thanks.

--=20
Tom

--u/Nyisdgt8Z4KD0t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat+N4wAKCRAr4qD1Cr/k
ClyjAQCkv9zVhsRkWn9PL4wrOysYyDkYWpvY8fN1ZyeJQELnowD/flJmp1k9deNl
tqexezx4IbKZ5gxK86BHuz/J6nROpAI=
=9MAg
-----END PGP SIGNATURE-----

--u/Nyisdgt8Z4KD0t--
