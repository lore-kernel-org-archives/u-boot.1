Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9EC60A2608
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qSMoeEEV;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=XpzkNyl9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E8CC60A80;
	Wed, 18 Nov 2026 14:09:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TMvmXCDN184z; Wed, 18 Nov 2026 14:09:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 45DB260842
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795010957;
	b=qaW8cieHBdsd3ti7Vc0rc/iOnwRnShUXKqFIpjEgxCuVYQp10oI065LwN7RoTjVDNH8F
	 DXRmNOha18DxDJ5JdcW/9kXrKoAAo/+b7ydH/qiQbtQHstC0mzOjCzkoLtbsb/Dq1eGbF
	 OtwfrmjsZLn7/vimwAjwc78BTq9LFSAK8AWYBvBkl4c3RgiQzvFHW5Z6N4cAvXb3TqPCR
	 p2STc4Y93ZrT1HVWOwMo8CaxcVd1T74xjU4NDVkVECBvKTJFGvQG3jQzAmBB5dEbVMOI9
	 ujWetefpk04V0AYi5f5/CA2R24Usgyrf41OYCoDqrfO0cPgjxlmy1HNMD6Jf8ZrWxjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795010957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1AnCgLhiaS2CNtwxiPSuGQkRPQjQQBuwdFUXw3q3evM=;
	b=CVJPOlKyCzxuXifSm0BPCbwabbQUnnmFiXzU48Ohchz0STzObttbH5L4o8HiQ/I905e2
	 swgN7R4DQoVmts6kdw1rp/dRW35d2RfMGnwgx6Xs5i9A1xos7l6yISEd/tj3guUmo497s
	 Ax4VMPhV0qQR9ezmjHWo97+sEsAtgWlMq6uD9wXiRPJ5G346N19CLd98jvOQ1G7FTr0DE
	 WgHTJKmK+AdjQqZo9ISQC9OhuvlV8UaS4QyhuaBcMaQQQEVQXPftMFus6y9hDn/5Jgqoi
	 qBlix3v13wZuoN9+ap1cCypO3PW+mtT3Nnrw0X41ZvPSYUUqdoyAyDlz/pJXR9pWm+A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=XpzkNyl9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795010957;
	bh=1AnCgLhiaS2CNtwxiPSuGQkRPQjQQBuwdFUXw3q3evM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qSMoeEEV5WMWuMNtmHFlkq8gC7rrBnzmTF8fUyWpmhDg+3jf4EImIUEIVoxx53pRp
	 GLTp2OuJXfFLaB1N4a4u9AaVvHTyIbNYLyHyK9wTlK3Up4NdV6J13d7Dlz7LH0EuLr
	 ZGWBX4oX64kqcdt+hvrl92XrdCnmf6ZrEfu73NL4b80IOdF79h6osRbcuiIp07v6PM
	 K8FSGmhl4K4UTviUgJoXiJgnc6s+JK2adMDlKLM2xrP1h1dLhPVgnDMxDMrPyrKeFR
	 sruhAPRW3J7I0mGfQlRcG5wwj+xUQ1uFeuJVU8EpegXJyf0YL2nFsYPKuqInD4Vmvs
	 y+4AE0VAKeaVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45DB260842;
	Wed, 18 Nov 2026 14:09:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 34FB270B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A9DE60842
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8nce8DRb81MG for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 14:09:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 07A7E60735
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XpzkNyl9
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07A7E60735
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:09:14 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-499f20c7054so546709fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795010953; x=1795615753;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1AnCgLhiaS2CNtwxiPSuGQkRPQjQQBuwdFUXw3q3evM=;
 b=XpzkNyl9XNHdw+ue3MBsF9dR7fbsHs6d6evUX3xVa/JXJH0P9VBB0OmXr4ZBi6vd0F
 +LkHE6eTeUL1GZq5SYN4rEJmZycrf2I8ACRbqw+LVgjgpBQcPa+JGn0VgI46aIhBmhNZ
 MQsykLY0gThW7SFMCaeHdqRAcmnEd4Jk/97II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795010953; x=1795615753;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1AnCgLhiaS2CNtwxiPSuGQkRPQjQQBuwdFUXw3q3evM=;
 b=zviSGWHIXZtWLw+r6jqbgirsCEidRd4LADD1vQY7NBFTv70l24n50kJHnQrCNdOvWi
 JzxqaXpRjNLui1iGzIvwpICqvIb+qwPlb6z3Fm+U8+hQvWFjJHHfktQTk5Rk43FYmyqH
 iuQvIY8lvCM39ZhUmdmYGwH8nz7FTcfHiRKBmLqon322m2kajiajSh/boX0cIAvuLjO/
 aXbDz0KduIVGvE869eC1mfFcOTi05E5lQ9j4xslOCVNQaPWuzEQE5Uy9v7CDxzxPO9RU
 M4UoaRicau/N0hBydm3WqvVW94A2c3HZR3Qkp1tleZy/AY3USUO5IETX+J7zs1PQ39GG
 PI3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHcBds9PHEYRWdXEyrYI+KXSEBNia52XHjnB62MXL75JRjQ08WU4P6ij9pSyOLik4g6B/DW0eQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8ClR1U1kyAsNZrCXWwZwr4gRvtOE6o4UE+u4jwQfezgrSgi1oy
 Vp99QZnWvbrOUxIxPSE6roYAP0BO5gPblQ3Xj/ON21GPkBL/RPQzTVz7JD4DNIyZw/N1pMLV5E1
 d2mpwAVVdgA==
X-Gm-Gg: AYBFou3eGxWmPMU3pYVuKR9UBd2dnGCHgMHd+Y6y7/cuNTHC4D0F2L3GOyPe34IF8xk
 MBRhdULV/rJXTxIGdgpv2WrnCxrBuuiwoz99TXixysRKO1/eAO+4gevnYl10CO9oiaMy7yI/ek3
 UyKfjDNPItqRIbWJpKkslcuibk469KCTBQBDTPnUofm4YxNuJGgo796FNC1s0o5Ziv1RJ8rHdd7
 dLwnSDTtSWvXhEBOcqub7BK7k4y+f7RutSvr+IuhhXkPjKFWabYfYFs3qYXK/sLwQw84pqF2xe7
 +PrXiOzQmBchNkCdioe2udVgUkWoIYBrejhMyY6Ivj57zo7mtFX3sdCLFLYLD2e7wv53HxIG2lx
 29Jf7MTpHZuDFienf8eshfu1RCspjUOEXMa1sdlMPm4ki5DVNA2srs3Fpu61/RK3zd/DFPEGICB
 29ZU8o7fyxBIqYw750BPM5xKLCpN91mJY5FYo3VN6PdRBwdM/Whn2EflZSAZq2UeONRmO+9xUMj
 LmomtlLGx5JZjBj6L2And6wQH8bZrkFtwsuqv+JP01Vmgeo8+sszq/ZBfkFm22gz81LG23rLPUJ
 HnTCkbaGV9315yzTJPFbNp6IiY2KZuM4eRtBwR0qdUIoVvxpubACUuKaYkDaJC9+rLzDzSFmm23
 ozGgf3Qx9dJeM9POA3jjOMd3aSHUZDQ56WSwc7eY48WpHiZBUqxKxasvdjUjEs6UbSjXJcFs1iS
 WuKfkBy8o88XuvIuXW2la71VTCcg2Smm0xIKNX4cCt8fLwUFWBOrJa
X-Received: by 2002:a05:6870:c0ce:b0:479:be68:ce94 with SMTP id
 586e51a60fabf-4b75fb22625mr2293985fac.26.1795010953331; 
 Wed, 18 Nov 2026 06:09:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74412113asm2301072fac.8.2026.11.18.06.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:09:12 -0800 (PST)
Date: Wed, 18 Nov 2026 08:09:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/4] tools: qcom: mkmbn: Updates to support ipq5210
Message-ID: <20261118140909.GT554944@bill-the-cat>
References: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
 <a2b6bc3d-db58-4882-9964-ae0a1fb218e1@linaro.org>
 <20261112163645.GE554944@bill-the-cat>
 <67e7e8ba-172e-4d89-b5ec-0c1c936f6c75@linaro.org>
 <20261113184005.GO554944@bill-the-cat>
 <av0w3LWTq1kgxMiY@hu-varada-blr.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gH1jrjhwNdVhceUO"
Content-Disposition: inline
In-Reply-To: <av0w3LWTq1kgxMiY@hu-varada-blr.qualcomm.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--gH1jrjhwNdVhceUO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 10:30:12AM +0530, Varadarajan Narayanan wrote:
> On Fri, Nov 13, 2026 at 12:40:05PM -0600, Tom Rini wrote:
> > On Fri, Nov 13, 2026 at 07:18:41PM +0100, Casey Connolly wrote:
> > >
> > >
> > > On 11/12/26 17:36, Tom Rini wrote:
> > > > On Thu, Nov 12, 2026 at 05:21:36PM +0100, Casey Connolly wrote:
> > > > >
> > > > >
> > > > > On 06/11/2026 07:07, Varadarajan Narayanan wrote:
> > > > > > As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot prop=
er support,
> > > > > > the mkmbn script has to be upgraded to create images that can b=
e used
> > > > > > in the ipq5210 SoC.
> > > > > >
> > > > > > These changes are to address the feedback in the 'Qualcomm IPQ5=
210 SoC
> > > > > > bringup' series [1] to use mkbn.
> > > > > >
> > > > > > 1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71=
b8f9c6cf@linaro.org/
> > > > > >
> > > > > > While at it, fix the MBN version number for ipq5424.
> > > > > >
> > > > > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss=
=2Equalcomm.com>
> > > > > >
> > > > > > ---
> > > > > > Changes in v4:
> > > > > > - Drop sm8550 full defconfig and instead add a config fragment =
in board/qualcomm/sm8550.config
> > > > >
> > > > > why this change? let's keep it consistent. please resend the defc=
onfig
> > > > > patch standalone, i'll pick the others here.
> > > >
> > > > I asked for moving some of these to fragments because that's how te=
gra
> > > > handles the case of N platforms that are defconfig + switching defa=
ult
> > > > dtb (and more or less nothing else). It's just a tiny bit more typi=
ng
> > > > for humans to do the build and easily supported in
> > > > OE/buildroot/deb/rpm/etc.
> > >
> > > ahh i see, i think i missed that - apologies.
> > >
> > > i've thought about it a fair bit and I don't think I'm fully on board=
 with
> > > the concept of having board support via fragments. to me they represe=
nt
> > > optional additional functionality, and there should be a strict 1 to =
many
> > > mapping from defconfig to board support, with fragments providing
> > > opinionated or usecase specific features.
> > >
> > > If the main issue is the world build CI, would it be ok to allow excl=
uding
> > > defconfigs if they're trivial #include's?
> > >
> > > There was discussion before about de-duping some of the ipq qcom defc=
onfigs,
> > > and this is work I'd very much still like to see.
> >
> > It's a hard balance to achieve. I was just now thinking, can we perhaps
> > figure out some way to take 1 U-Boot binary and a list of dtb files, and
> > make N u-boot-plus-dtb outputs? Or would that not quite solve it since
> > there's more than just changing the included dtb?
>=20
> Not sure if I competent enough to answer this question. As I understand,
> most of the times CONFIG_TEXT_BASE also changes (atleast in Qualcomm's
> case). So, the single U-Boot binary may not work out.
>=20
> 	$ grep CONFIG_TEXT_BASE configs/qcom*config board/qualcomm/*.config
> 	configs/qcom_dragonboard410c_defconfig:CONFIG_TEXT_BASE=3D0x8f600000
> 	configs/qcom_dragonboard820c_defconfig:CONFIG_TEXT_BASE=3D0x80080000
> 	configs/qcom_ipq5424_mmc_defconfig:CONFIG_TEXT_BASE=3D0x8a380000
> 	configs/qcom_ipq9574_mmc_defconfig:CONFIG_TEXT_BASE=3D0x4A240000
> 	configs/qcom_qcs615_defconfig:CONFIG_TEXT_BASE=3D0x9fc00000
> 	configs/qcom_qcs8300_defconfig:CONFIG_TEXT_BASE=3D0xaf000000
> 	configs/qcom_qcs9100_defconfig:CONFIG_TEXT_BASE=3D0xaf000000
> 	configs/qcom_sdm845_spl_defconfig:CONFIG_TEXT_BASE=3D0x14880000
> 	configs/qcom_sm8650_defconfig:CONFIG_TEXT_BASE=3D0xa7000000
> 	board/qualcomm/google-pixel.config:CONFIG_TEXT_BASE=3D0x80080000
> 	board/qualcomm/sm8550.config:CONFIG_TEXT_BASE=3D0xa7000000

I forget, sorry, why we can't keep using POSITION_INDEPENDENT in this
case, can you please remind me?

> Casey/Tom,
>=20
> Please let me know if board/qualcomm/sm8550.config is ok for this series =
to
> be picked up or should I revert back to full defconfig for sm8550 and post
> a new version.

Casey nak'd it and I defer to the SoC custodian on these decisions so
please go back, sorry.

--=20
Tom

--gH1jrjhwNdVhceUO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCav2xeQAKCRAr4qD1Cr/k
Cra2AQDIA7KtpQD9Z0VxmvejEWkeheKnmi00ZtoUAL57DFam+QD+K1AZqStjSMWA
MHppVEFo3eLHCnsekOVDpD04o5ZBqAw=
=ZrwC
-----END PGP SIGNATURE-----

--gH1jrjhwNdVhceUO--
