Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9D0CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 17:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2BB8004F;
	Tue,  4 Nov 2025 18:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="od4pwUw4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5889783655; Tue,  4 Nov 2025 18:51:29 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA3CB8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 18:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-656b251d27cso471844eaf.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762278685; x=1762883485; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0zRBUFYJdnWWvxW/+2TKWVJhaq7SaTxI8sW8d6wNTJs=;
 b=od4pwUw4Iywkq8DdlyZ5XLWIAhjYm6tCYsZptoEd3eiUYfUa70HnW+fPldDu4PxiYI
 BrVyUEbSuZp8oGqm4i5oI42GtHOITpVkE6nhdp67LWZBqDBXFcEvK4YQOGOQ47AUREuo
 HDC1/EjHqlL4hmBMQNXav6P4dUU7bZPO8vaaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762278685; x=1762883485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zRBUFYJdnWWvxW/+2TKWVJhaq7SaTxI8sW8d6wNTJs=;
 b=UmKlqvuf7l6IBUqSCiPWYAxJej5kcm1M/VDv/Eg7oItguAnGqyKwhu3jl5UUSaxcdO
 DNQbF5o/lj/pYbGWn4BQ6ClyBm6E2tTos08MV7ZfQfvJuVuI60VSwcVibd5rRMHJEzL9
 j/zb2m3HrArOM7dJZnMOUTNpXYZd4KGtcPXhTEspeU+hPxKhEOgnlyTiVaiSi7Qcu54K
 jD0gCnIsnnYLBhDR1e4kVRgG7d5c42FVBYU4I9vW1Oo79jiI7VjftMy4DZnrik45wjVw
 lxUsiOidCykGG3vNo3K/MewJ+EkSs8aRnNoq6uzfJOK2ebjTZxmAF2xK4Gq3/NHX9YLm
 yIuw==
X-Gm-Message-State: AOJu0YyFdGZGpLkl+BL+MBpHMtqWcaZo9avAdksKhisqH+3yrpg391Lf
 NF2jnNOJPqZ0nw491Y/6gnLH2dLBwOplcm2Ru+bMXYah2qdeBZdKvyo/0QL3rugSc8L0xjCIwgf
 kl/osxXIb5g==
X-Gm-Gg: ASbGncvpwg33bMtnjuXMTxGoGPAXnYLAFdYlBHgrNoWxsaDDCqJiT5rB2JqMpfjmYDn
 7fpVLbsN48/puG1xKEn/OCpmkwT4fRMirsVD9Wrw8QqOwwa0a4HOPlgdf2JSL3ulWhKUDapeJfE
 39EH1+csFKdGUAX2Z6pTWr6vUfNn/bCJt2LKF4hX0IBHNIxYPc+X7Aogutr854H2m60db8YkMQ4
 w4BCg6ETQF/afPl3hEV/sEP6X207h/pmqZrQgyR16iJF7L0CARk1jdAYha0NaIsj9cpY1rsnjIb
 A/lb75n5zE0wqEZ/NMo50llHkHg6i+VKkYbbLyN0eNNoBfkz5Ts9QtB/r7fwVHiBCQx+p/URz/l
 oZ1JdHRrGQ3Ctk/P5zqxZjXcB+X36hFs2ToTRrnxb7GA5xkkV1s0vH4SqcRHStF7TDPlEUxOE6G
 /V5nBpxfaYWWPFA1Ss9rv7cg12E4BrpWNgE4nmTm8=
X-Google-Smtp-Source: AGHT+IFjzlmjqJlPNMIwQbaQ+bIOdBTbzhhJ4D+K7Tgr67VSISuhszntdwGF6Fea8AORCiqm+2t+Gw==
X-Received: by 2002:a05:6870:d1c5:b0:3d9:158e:d943 with SMTP id
 586e51a60fabf-3e199269b03mr129090fac.9.1762278685556; 
 Tue, 04 Nov 2025 09:51:25 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff736d560sm1238293fac.18.2025.11.04.09.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 09:51:24 -0800 (PST)
Date: Tue, 4 Nov 2025 11:51:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6] Add optimized Makefile support for SoCFPGA handoff
Message-ID: <20251104175123.GE6688@bill-the-cat>
References: <20251104010003.525-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GyOn2aFDvgRLqytA"
Content-Disposition: inline
In-Reply-To: <20251104010003.525-1-briansune@gmail.com>
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


--GyOn2aFDvgRLqytA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 09:00:03AM +0800, Brian Sune wrote:
> Add optimized Makefile support for SoCFPGA handoff
>=20
> - Introduce socfpga_g5_hanoff_prepare target in U-Boot Makefile
> - Detects Altera/Intel SoCFPGA boards from .config
> - Combines vendor/board extraction into a single shell call
> - Checks for hps_isw_handoff folder and .hiof files
> - Uses ls -d instead of find for faster folder detection
> - Runs BSP generator script only if files exist
> - Non-blocking: continues if handoff folder or files are missing
> - HANDOFF_PATH user define allows overriding auto-detected folder
> - Minimizes subshells and other slow constructs for faster CI
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  Makefile | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)

This should be able to reside in arch/arm/mach-socfpga/config.mk and so
it should be moved there. It might need to be done under "archprepare".
That would also let us gate even trying it with an ifeq, like we do
currently. I also don't see that you tested this "make O=3D/tmp/somedir"
(which is not the HANDOFF_PATH thing) and I expect it doesn't work there
as it references ".config" and not "$(objdir)/.config".

Finally, since you mentioned AIs in other emails, we do not yet have a
formal policy for or against their usage in this project (it is
something we need to discuss) but at a minimum the Fedora policy makes
sense to me if using one:
https://docs.fedoraproject.org/en-US/council/policy/ai-contribution-policy/

--=20
Tom

--GyOn2aFDvgRLqytA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQo9FwAKCRAr4qD1Cr/k
CqyoAP4zFg7na94ZhYMR+ZYel/g+R8DWbVfqT4LMlcm8w14W0AEAt7srqyudy4JY
0IFIcr58TAuStUW8WqgQ7uaANdMF4Q8=
=ZOv1
-----END PGP SIGNATURE-----

--GyOn2aFDvgRLqytA--
