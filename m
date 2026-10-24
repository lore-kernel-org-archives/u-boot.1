Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A61606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RuT2nIif;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=nTK9z/3f
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6965740769;
	Sat, 24 Oct 2026 18:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xmP4Kr-LpszR; Sat, 24 Oct 2026 18:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A60DD406CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792866672;
	b=OUKGEp6ICieWUv085FvZCg0+Od5zWx3sv3sL/wXRon31ZqxDsNpyKeJD6/FWqJuKd/3W
	 PhsCOHIp2H2gRDRlUpckOY8v8hPlGFGEMk9Deb7ba62sWmokLwnG4yUuIsqUbU2FcS9MO
	 ozEk5hjj8ufl6r9x6lzDixCyay4jW4WfOGGKjBsnehpP8+8B/STLo+Ie/5nM0CFVF7ggU
	 BM+m3e+FpHE7mQZtoGCZfqzZmIs0TzMSfBpoYG7TvbRP8C/PKQMbD0UKPyXKQK4Mwk70/
	 /aoUnkgJnES6WxrV/u/rX0sAQ1l9XTqhSElwBO7fG7tgI4HO26eXa8bBg5hddW/s8dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792866672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mkXUivKvF6rGasN+UnSaylSeT/7xfS/STmrxuCr6ihw=;
	b=lEthNKjpAn3j/mzZwRfWCN9x10+BKzGmdX2IRsXkcpDBYln5Km2mo/m2epVugXoWzWEh
	 jjKeAXhDE8kXg6rYWZABpJc7zvBP+qNmQcJL2u135kt1qTISanc8LJ+hzfmJWRp1Clc8g
	 IjbDfO+pVMnxvkIRu/8riQzORl+9gmeYNCHQcP+6Yl+hEJIHP4EOrmENI+sjdB12Ta0Yb
	 j6hC/w0knVlJrdNOnELo0O2ZY5vjSgngS4KAZkGywN18QvqPCd9I+6MBEH4AS7IClYUGO
	 pQEr9Z54gTBpOXN2kfWuuitWD9RK9d1SfBeDrCmgKNPFL5TWj+h/OGwtnwOIazkcdFA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792866672;
	bh=mkXUivKvF6rGasN+UnSaylSeT/7xfS/STmrxuCr6ihw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RuT2nIifqnN3rzgG7DYfAVn21F4t1SPpt6a/ZvshraY2x05yHQTo7WM5OUnvHiAGy
	 CU19B2o7l1BM/QOqgiZgU1VG8PTCs9ai4MNMpoVMuuxVbR6xtEw4iCdCo1n9ehgsth
	 QsPgaCE3LAy7S9OiVVYctxwDb7/gEvoiPiLRPm5OBmXqLohHpVF233hzdubXKybEdB
	 IhmCca6HhZrQJZouZUkHAjZS66b49EY4x8mJMYM4qkg54HYDmvbLUu9EZf5bsbHuVN
	 vQNRYcCphH9Sn3+I6KOcNWMwvd6aBjbnRSA4Dy1Eo2njGOjBf+T58h3KD2v+Tqf1y8
	 RIm5u5u7cA4VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A60DD406CF;
	Sat, 24 Oct 2026 18:31:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 195A64D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F244740049
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Smfe5NEZ-Erw for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 18:31:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 389534009F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792866671;
 b=jMmc/sv2bgPSaNYwzY0XOu2gsOFHMsTtnCoYK0JFkNU4HnsqlHyso7xG4DFUYlmVK88p
 XH6odx0OOz7f5kXk7JddXKtErXiYg/12O2Qtm6dlfzGwHR3ZFz+x7KSBBu17UxFX/T3Xs
 WFTcOC7N/OqNd3a104cclsQipyfdp3/AU1YKPew39KpI2OfSFfI1jmWRSYI4M7HiRk2mT
 DoGEhPT78E1UK/+E6Xx0ZU/1RmpnhegHSyDfA6iBDiUnBPp+XHv0lb9wrqxli+uYjkCft
 P8tiqJi9wsju+nGi+B4gN/AaTFF1ala+frC+qEKu6EFtmsM2k73aPSXXVt9zXqBRmZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792866671;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=mkXUivKvF6rGasN+UnSaylSeT/7xfS/STmrxuCr6ihw=;
 b=HZMaC7qv8udHUweH8DgJWMqueLixeWlgSwTdObAn/U4eeMdNuHtDsjSoGZmXeCPHYJgV
 HYpJerihLhK5/xL8Ac2QA5c6stUh4huY2tCPMeyE2IwAubVIxqHWDW4dtl3ns6QAnsPJk
 K+kLfMLKyJv0Cb2lztjIr/Fk+uk+NbDzrUfAgQhYRwqod1MW8e6P4XwAs6tANdMDqE+iS
 UaN25KzLFZTOMZa31MV+WQ47xOjxUAIi3YrrjfzMKF0ni//TuXTf93KxUW6NOr3MxM/mb
 BZIAvXCJOtqA4J5QUaISTkj2q2v1rOta/AoRnEfjOWatMdVvohEpOUm6rKxe6dcTYFQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="nTK9z/3f"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nTK9z/3f
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 389534009F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 18:31:10 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-8446af403b5so1290512a34.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792866669; x=1793471469;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mkXUivKvF6rGasN+UnSaylSeT/7xfS/STmrxuCr6ihw=;
 b=nTK9z/3f/c8zZbmeFDx4Oruo/VLku9r0qBjBVk2+kQYtv+k61PvFdD5ImdCjppotD/
 MVbaRxKGBbKL4rQDXw3Fnq3PJ0ZCP8ai/H/EIoWAF6qc94rRNannGrz5zR2Yzx4c1Uu1
 zdo+fPTDjfanu/gYwX4lbw4j5pd81m2UOO6LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792866669; x=1793471469;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mkXUivKvF6rGasN+UnSaylSeT/7xfS/STmrxuCr6ihw=;
 b=CoXHLCZuLO/WOGYQ7RK7sn1YJEoCzECD+kRBXVuQA9D65gRIKOT8bJ/CtVJw3CZHx2
 jy5Fc3dD9RHpP0Kf3ijquZBrTkoz8nSpnhmXUTo/A25LfF36v0Isag1YhuKrTic96mzS
 sMCA8HzjVCcBuxoIdj9H2/IHEzGOFALJ2w+bjI7GWNhuJvfzS9Y8U8g6RLZXYb7LtcbV
 A81RpjMl4QqkvDWpFnOsOtKCXgZOV7t12T3E56UyNcWJTtI/KwFbbaGPMqFjSUxTYgYk
 Tihr5GeUAdzEXuMRveo0gkslQS0+MXXPwcUsfhq2dXiAFnFAQKeFcnTVosLij+kES51o
 hhMg==
X-Forwarded-Encrypted: i=1;
 AKwUvByTOoWJUWIP2AbKBQ2lfm0+sXKvFys/PmLAZDLaswFnXfgB77Pt5i8LJfdUVC7ZD3qXWKbM0l4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJolt9uqGQ31SdKav0dkll9UpXd46u5OVxzWRzSIE299LnELN+d
 rGSiEj1lhwgjZcpCAWVyaH1UwAJusgTAu+K7RlUB70HDF/K2VosUoll+QuF6QS4pbeOyD9m3HjE
 PNFsPD9Za/+J8
X-Gm-Gg: AYBFou1Nr4QTis/VH84XtWsmQMudcLjkArKTf4SlhSiojmoTUljl+kCjkNGMbiR0bUB
 XLLdgFjbnp+NxcgOLLDjPOAaPCbXaIdDzggrJamszSpAUfsIlMKRObWwMbW+h72Xz93IbQ/RQmx
 Lmlp0vcSrWmm29tmV/5720LydIi5G73FHMyFV4eujRwLO7USyH1aap6GZVHTYFLQ3rGz0tupnDa
 atFNkrlU7Sb9SVoCR74+Yype2YU5JjvNm6o9/HYTSpJXNDxjZ474tUfLPNao6Ju5W3x57JkjpGo
 LG3UEC1Y2YdwrTOkHlgRs+hj5mvBWzYDLh18D2A7iR3YAtOgyIUZ/f0Y5OY7aGy/sxRluoIc+72
 2ELa4PHolATfUl5SmY+77EmGOVEUHrIayUFxCxeMe9GzODu2kBfcnQTAw5a8DES7T9rKlo2XokP
 GOGzZJUenffZAJPUGkQrWufVcZLDLWSS2/kVh0Vybqh7reVDQuW/3PhXjKI7y3XDm8S2/El3QTk
 sVzEVyN8X9y6FPl7dVDHJebOrnnR3sNWNAuk4qPqVi3K0MaV8BcEYDQXFjAywHRhdSK24zlaSHE
 EW477eM9TajivwGPGeA6MYRi79MsafEIpk7MdjaN5lfeqnTynFr3/sU5OKSQNjQXa+Gogf7qGro
 NrDVZBZzZBzkSkK6nfUmvOXwJIsfiv/kiqk0BNTwNKh3+C3Yu+js3TNO9qg==
X-Received: by 2002:a05:6808:4fdf:b0:4f0:a3f9:9f89 with SMTP id
 5614622812f47-55c0020a86emr1894025b6e.18.1792866669477; 
 Sat, 24 Oct 2026 11:31:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c0424a05dsm1779326b6e.4.2026.10.24.11.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 11:31:08 -0700 (PDT)
Date: Sat, 24 Oct 2026 12:31:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Tyler Baker <tyler.baker@oss.qualcomm.com>, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@nabladev.com, marek.vasut+usb@mailbox.org,
 Michael.Srba@seznam.cz, nathbappai@gmail.com,
 nikroks@mainlining.org, luca.weiss@fairphone.com, jbx6244@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/8] arm64: qcom: Add initial support for Nord SoC
Message-ID: <20261024183106.GM3596691@bill-the-cat>
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261022213356.765702-1-tyler.baker@oss.qualcomm.com>
 <31a34a36-30b6-4422-a877-a24ce218bce7@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IMtenVnaZa7MWFD5"
Content-Disposition: inline
In-Reply-To: <31a34a36-30b6-4422-a877-a24ce218bce7@oss.qualcomm.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--IMtenVnaZa7MWFD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 11:52:47PM +0530, Aswin Murugan wrote:
> Hi Tyler
>=20
> On 10/23/2026 3:03 AM, Tyler Baker wrote:
> > On Wed, 21 Oct 2026 at 21:34, Aswin Murugan wrote:
> > > This series adds foundational support for the Qualcomm Nord SoC in
> > > U-Boot, including clock, pinctrl, USB HS PHY, and configuration updat=
es
> > There's no Nord DT in dts/upstream and nothing builds a Nord board, so
> > none of this is used or tested in tree. Please send it with the board
> > enablement.
>=20
> DTs for newer SoCs typically take longer to reach upstream. In the meanti=
me,
> we are posting the required platform drivers for review so they can be
> discussed and iterated independently.This follows the pattern commonly se=
en
> in the Linux kernel, where SoC support drivers (clock, pinctrl, PHY, etc.)
> are often upstreamed before the corresponding board DTS files become
> available. The board enablement series will consume these drivers once the
> DT support is ready.

As I've mentioned in private, but I'll repeat in public now, a lot of
this code needs a lot more internal review anyhow before being posted in
public. So no, I don't think we have the bandwidth to try and follow
the linux kernel model in this case. Especially since we're talking
about clock/pinctrl drivers and so that's not the tricky part anyhow.

--=20
Tom

--IMtenVnaZa7MWFD5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatz5ZgAKCRAr4qD1Cr/k
Cn6aAQC7wuywSn7ehVpywpEMWMBQJCAcktzmrXz8U/cYZO4iywD/ekcUs4dfD/EU
wkqhiwAEtbd8RssOgeESqARCb4ibXgo=
=A0+/
-----END PGP SIGNATURE-----

--IMtenVnaZa7MWFD5--
