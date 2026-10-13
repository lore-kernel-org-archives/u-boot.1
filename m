Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3206FCC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E03CA60784;
	Tue, 13 Oct 2026 15:01:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1BGlhQ7iyY6j; Tue, 13 Oct 2026 15:01:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34AA560743
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791903694;
	b=Z7CqINFVrXpMproJY0SvSE2bx0NXu/AHk3NfpksOfRuCkTE0yfM0n4aBjMDcQkgMkhi5
	 DhMjXev2sff5rYlCX3XHH0eT1Y0RdNtug9ZiuEnYaqnRKoZqRBqwEsRiT2aivRk1VGZxo
	 DxmVyKjkEDeJ2Ix2z4JvY+wxATHZc+pQmKCOw9wW8zX2Xz7dZGT+Oz2gzWT+eFQhg/arh
	 gkVWiL1KYlW/XtGoUpk0nI/ZMJl/l2LPO3rV8VNX2SViFnUPkPNDlKpESy0gafVolg9Bg
	 qJ5PtHbuTu2cauC7u1VhIlIojw5sN8GLzRFPyly1+1Hs/fqnBbDAa6Rur79TZsjWPDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791903694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vM51R5NRO9Uq9ST0W10IvsZwLvVOlFzF38iDfCpjZvM=;
	b=i4EFLf2CVdTPo7qZVWzq3xCJZvDFSoG1urv+nTcdDccFVYbwZfrSwC9nF0JmuwBzBrbE
	 lJsE5xZd2yjJ7TCHfe2TGeAlJF/AmSksnMgCeHc63WDCkYi4PYuXKMkStZ+OsXBkYstgG
	 3UW6sEKhG1AdXv6XbTxjmewv10ifPxL8+1J8fMAwBi1CgWTv/dP9VlFkRywT30ZmDJUR1
	 gCxGNtGbABco/nAF3g1eYaHOfq6EElB81Xbd1qZ4OewOqkV1W5BCuZLNZec3Jp4qOluHI
	 xYq+aQKGYNYGMHfftURTUk6GPUrELbaHykrUBOXeu58nDBHn3opbK9Nr6Cv7dWU/14A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Gf7ahxCJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791903694;
	bh=vM51R5NRO9Uq9ST0W10IvsZwLvVOlFzF38iDfCpjZvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ApQ7o9bU6vLN4MrcfN9ZXsdfT4dDVXRwoYb9GQJA4kSdXIEvpR4gqczQZzD2WRIZ/
	 MXetMx5Ve0Z6kgXt18LG4glLBVPnQXOox1s+XS5VRbZtB6HqMAiDFCc8KV3X7qfHHO
	 /nWLOzz37kDG29+dzEFJSsf1jXE5BbmBoE4lDvzqS5itS2KnE4PLVTZm0rbAFyl6ot
	 22masGDMJtTdeTWuxzZpMlq9pUze8871nfpr+XiTFpzI044FVz96dUnPSc4vRi5YOb
	 hekiOA9XNYTtE8YKIPh5RjMp659/r/C8mODmedw0Vt/IxIJ0/GqQ/enHacvxmrasFr
	 IC5f/HkVjqyIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34AA560743;
	Tue, 13 Oct 2026 15:01:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DC722E0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7B7560743
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:01:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lLd5SeQdmpJl for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:01:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 296BE6072B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791903692;
 b=Rl+khuHRHCoy+FnVAV9MhpSkOyRz/3aPtXJUVuLZsE79va3gNapu9LXxKQGk8CKzZjXV
 G1bF7sKOj33FY9H0nWKkmT4lFE9ZvXbReSq2biAdoUwZ0HBDS9nAwFNZoN/rJWLIEI3Qr
 Ho8hDEmS/9iZ2vnSp3hwVy5gfN3j/hvrf3g1j0O930C0o2IGY9GvMAvR32Yz5Gi9idyku
 zlCU/Jb4Tjr1XKv+3SzBHc4s71r08aS3RzzPGdnDg8tzW2hlDxSwfVV0vMzYWcgz4sne+
 4b8w5aNQbkvXLbeCW/r49gG5nYzC2Ra3kNpwgl2JFGBS0lz+DfkSpUmB9hEdSb2LAUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791903692;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=vM51R5NRO9Uq9ST0W10IvsZwLvVOlFzF38iDfCpjZvM=;
 b=Vm7d8w095QBWQ9WKArTNuxJEguAXkASrXTKMmY3H8Vppiv5jaYHuHMuyjKHkpZynqVdq
 de1epF8WvCrz9s3adFPFxaYeZHLrGxsAYpMFbIAtOXrxpG8Rb18VLVWjl4PJqfY33b0kn
 u4Fw+ETh/NmXn8e4SuKmqVEZFT7i0eiOw0guSefOCt/nQadwCnfVv+tR8xg/9bt7SNF/8
 ZKBlIaufUYP2H42Dxg3R6lhBDUpg673wd+FOdnUE+3h8TgXfC3lDVk2LXWxydnCYpA3jR
 dbdBm+FT95bSSgagjZIGQB5Mv4uoTq+UQ90raZayBeeWrVcnkmGVOz33jTXdFMisuPg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Gf7ahxCJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Gf7ahxCJ
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 296BE6072B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:01:31 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6d68de53053so1247979eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791903691; x=1792508491;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vM51R5NRO9Uq9ST0W10IvsZwLvVOlFzF38iDfCpjZvM=;
 b=Gf7ahxCJk6ibwy63VRJ/zCl9d+Bcawkcs1i93zfyOExH05vvV6Rmx3uDv/EW6zx4ck
 mTtuZPTE0cWJVxQwrQtvpKe1Tv5zoGYOrWLzF1XWANNo1e9LovrvfM5pNXPis+iqsFiE
 gexs2ZwMOvTfXwDMRGKyOqniiZ4s8gYRprFfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791903691; x=1792508491;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vM51R5NRO9Uq9ST0W10IvsZwLvVOlFzF38iDfCpjZvM=;
 b=N++qCzGBezmx4zXzbIEwq4mAEGwajUdfHrR4VJ+O7ta8KF+lJhKx8d0/q3ZIu8YFaI
 v9sh6aSiWv9+lxFI/rA4R3GsyZ++1b2ovQtyr/pLt4Eehh1itenWf5XzW8xdPdodYpeP
 wv0x+dmJfGLvfE8HH9YelY+L4ob44g93BTfNzd30pvDOPROkb8D8Go3tjF7tZhAXd2b9
 QDONJlMVKMgxueshyMgTTS2pDTdTMzHi6BNJSPVFiH47q11+BTynSMUxvjp1eP7oeZbO
 11KhcMhBMkXbmFXDqIaNBY4ibErN7Q9eCVPcvV4aktYxwqFtwHZAZ9uHPwW9SFr2Ii7l
 7E6w==
X-Forwarded-Encrypted: i=1;
 AKwUvByb7k5VenJe5WMDDlV8RPQTlQfBb+tPhGDbRitNLz7kz+RvQWXzYhhJayMG35ei5wMY9wAJ5oo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ5tMoak0eX1gVSR4TVNzhkvkl4jsYbyVCxJfiZwe1oPZ3tBcYe
 QrWIQ63Jyl4E6gm0/shNqG9m3wGlZN70pbaNuGSR6zV4AGz7HAuTGvloWX/bPSEXuxc=
X-Gm-Gg: AYBFou31rmyHYfDT4rboJv7PtWBBVq4htU54V3DrfuFzY4+fehdNe+nQXAzT3/WIle6
 j7xyufXFGsmPOUdpOP/lzpwreJu06aLQzVl/ofOSnNqVkSTyd3PiVG/OKNYlhyotPGD0UuxWT+P
 EeAG1RtdaaA/FmTti2vL/TlGxrlXX7gmbydRg9QhQDJSBxoH3z0AOVbBK03KiUNsiMwxB0H58xx
 mSB11RehZ0rnrgalFUuDKt8xKEuWWQLGKVQYfHK55Pc8Lv5WFHyV3C/tLd+oq0UXrZSXKpHftX2
 OScSaQihlmEGRyPQHuzWRylSWjKz3KSzeLhzzrSBhjO0vIhVCjq8yn0JM3CM7/sKjWNryQL/jV1
 5fGeDiaLm84ADZNLb6lDxktvrSXaxAcG31O6cDo/AyMv7OG8JV5Kz98qiTRifQZPxPmsSOB51sO
 NUU9bb1Z9Z7EafrecK3/K6YHUbF5g8GpG35k5sV/cajlEvzizGdlHJmxA9LoUwwa2wUvpKwour4
 mb4erq9uLClVGR2Paod3e+O65aORi0XMo+LMUAwdmobK54LanQRnDIBL+jNz022Rvmjdku5PmUP
 iRt4hj1PTOi20DYYork=
X-Received: by 2002:a05:6820:8119:b0:6b1:bb82:f7a3 with SMTP id
 006d021491bc7-6ef08e7798dmr10099845eaf.5.1791903690535; 
 Tue, 13 Oct 2026 08:01:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-830385b9cb0sm12966030a34.4.2026.10.13.08.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:01:29 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:01:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
Message-ID: <20261013150127.GA4042005@bill-the-cat>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
 <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fHyNFi1Bep1LJXxG"
Content-Disposition: inline
In-Reply-To: <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
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


--fHyNFi1Bep1LJXxG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 08:47:48AM +0200, Ludwig Nussel wrote:
> On 10/12/26 16:44, Tom Rini wrote:
> > On Mon, Oct 12, 2026 at 02:26:55PM +0200, Ludwig Nussel wrote:
> > > [...]
> > >=20
> > > When I developed the patch OF_OMIT_DTB was "default". 68e65953400 cha=
nged it
> > > to "def_bool". Would something like this make sense as a fix?
> > >=20
> > > --- a/dts/Kconfig
> > > +++ b/dts/Kconfig
> > > @@ -213,7 +213,8 @@ config OF_HAS_PRIOR_STAGE
> > >            disabled in the board's defconfig file.
> > >=20
> > >   config OF_OMIT_DTB
> > > -       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
> > > +       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN && !ARCH_QEMU
> > > +       def_bool n if ARCH_QEMU
> > >          help
> > >            As a special case, avoid writing a device tree file u-boot=
=2Edtb
> > > when
> > >            building. Also don't include that file in u-boot.bin
> >=20
> > No, because commit 68e65953400 was fixing how the symbol had been
> > misused over time. I need to understand a bit better about what you're
> > doing here next, so we can see the path forward. In commit 99df7f471551
> > ("arm: Drop unused dts files") we dropped the empty dts file that was
> > being used to generate the dtb OF_OMIT_DTB required.
>=20
> Qemu provides it's own dt at a known address. Normally u-boot would just =
use
> that. The purpose of the series is to make u-boot check fit config
> signatures though. In order to check signatures, u-boot needs the trusted
> public keys in the dt. So in this scenario we need to merge u-boot's dt w=
ith
> qemu's.
>=20
> Maybe a better fix would be to remove OF_HAS_PRIOR_STAGE from ARCH_QEMU?
> Looks like this atm:
>=20
> config ARCH_QEMU:
>        ...
>        imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA

But then we would need to provide the whole device tree, yes? I think
this ends up being a tricky case because we're on QEMU for this. We're
just checking the signatures on later loaded FIT images. Maybe the
series that adds SPL to QEMU could be helpful here, since we do have a
normal path there for applying an overlay to a device tree, I would
swear...

--=20
Tom

--fHyNFi1Bep1LJXxG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas5HugAKCRAr4qD1Cr/k
ChMsAQCVNlstjiTVTE5nvIk4RsM7KYumVjC+3xbPsUhh8NetrwEA8datMPQtJqTK
8/AL129jjTk5vpUffczUcNmvlMcGjw4=
=dLDl
-----END PGP SIGNATURE-----

--fHyNFi1Bep1LJXxG--
