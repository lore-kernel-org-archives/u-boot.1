Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08724C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 15:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB6981100;
	Thu, 27 Feb 2025 16:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I008MNPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2C128110C; Thu, 27 Feb 2025 16:27:01 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D282680FF2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 16:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fc0bd358ccso2065887a91.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740670017; x=1741274817; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bBQuHfeqW3KL6I6aVbekhfwnpwiiFuYdB1Zy4Fj6Njo=;
 b=I008MNPIflJ1vlMzXDJXbePMUjXF1mefZ/hTHU72Az7BnWnq9enyE57/49Qi6L+EjY
 VKQ3l3+7thLTxTcRQWtSXi9ZOKae9as/1r+e1MSE9EyhrIxBXtXCVr8NVMZyjoBlH1CE
 //29KyMONoBQRX4V7NQPV/OOnyq3FppAPqab4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740670017; x=1741274817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBQuHfeqW3KL6I6aVbekhfwnpwiiFuYdB1Zy4Fj6Njo=;
 b=bmH2dQy78lMwX9XWGb3ylqgD2JKcgeC5vI4A/czFp343x2TZ71uwFWUL//j2j8Ow4V
 RLFwEw/IX9K0j4v/c72Jt2ZRMTGVnvcKvPJYC8gWB+p3oK/qMIqk6u5v3Xr94bqLfT0v
 E9H6Qka4OAFrEOFpXmJ1WcvR88acavibpsLcNyZoDYaaRtN99KSExiHGq2cFluvFeCq3
 XLFIZGeIpufL+E0nlR68snicviFYXrNwdDLwP2yPsQc2tf6J1ddS1r3zS+kxev+hmRws
 ueXk5IGCM1oQ4KR0tTFFx/dqpU9SfPxBr8Ac3adbus8lL/y7nl+LxXQqTp6yO3VASnYi
 NzDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdLnRGUWVAhux6jZGnOSBvPGyPCQbDwhf/HHBQ506cE7S5q+56kcStNSY2Wu3ce2xCdd2JjO4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzek8fJGyeiCRN7mJQRGDpZvLTHa1Gf5LFBRCVb7Jm20eOR0hSf
 +ddbpv3zALXYiPXg8JmLcDaQd4zN14l+zZ5yZK376LBfbhv6xL1WMWE2K0v/L2n2LAPh1PLJ+n3
 wQEQ=
X-Gm-Gg: ASbGncsnPQl9K31KgxdpfSIhziuF1B8hB53QGJaxjmMErGtIgDemUCcLVu+57LyZkAP
 417HJod2FvmoygvGEq3yh7cO18hhWSQRjTa/sTNUoycI/ciGg7NTzDhu6tB9NIPRUoXzaXhRorb
 q/19mF6rhLUJV599rsDOfaVqPr6d4rzio0e/NzPHIDuhbnQCiF7vJOH1jBmV0mmk5EBPOoPcqzr
 2V2q24/h8tU572NMMIxLOHzRw17E8ihZtc+dea71WIs9GmOqsdx2SO/SIs/h5N26XJBEiKvAiK2
 2RQPNDZEpGqvXaAuzLaKhwa1
X-Google-Smtp-Source: AGHT+IEmDuoLBsksS0KSq7wkXQpkqdQmqbHMypSbR6eILaHuE0Y3qOIgOQkQgrL54g074B7tPGvliw==
X-Received: by 2002:a17:90b:574e:b0:2fe:a515:4a98 with SMTP id
 98e67ed59e1d1-2fea5154b6emr4856970a91.31.1740670017254; 
 Thu, 27 Feb 2025 07:26:57 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea65e3a56sm1753889a91.0.2025.02.27.07.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 07:26:56 -0800 (PST)
Date: Thu, 27 Feb 2025 09:26:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 28/28] test: Add a test for booting Ubuntu 24.04
Message-ID: <20250227152654.GU2640854@bill-the-cat>
References: <20250219005515.GR1233568@bill-the-cat>
 <CAFLszTjmAeAFwajpB1ee85=8_AF3c2_ttm0Rj1wcMxN-OrXdeg@mail.gmail.com>
 <20250220145311.GY1233568@bill-the-cat>
 <CAFLszTjdBD3Do=E14dPspWRXS6UYrAHWopWETMSWXE_UEm0D0Q@mail.gmail.com>
 <20250221160628.GJ1233568@bill-the-cat>
 <CAFLszTghBpi0ACG-O6V5qFumKctVgW_1iuWg+U8Ugoz32VFyJQ@mail.gmail.com>
 <20250225135922.GL1233568@bill-the-cat>
 <CAFLszTh1N=vGGe73rNO+qTu-hLLc43v3goLdQXmffmE-nrMuzQ@mail.gmail.com>
 <20250226143541.GI2640854@bill-the-cat>
 <19e777d5-6c09-7a2a-6ccd-01fa556bdf2c@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fx2Ka9QQLsMcVopN"
Content-Disposition: inline
In-Reply-To: <19e777d5-6c09-7a2a-6ccd-01fa556bdf2c@denx.de>
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


--Fx2Ka9QQLsMcVopN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 11:11:32AM +0100, Heiko Schocher wrote:
> Hello Tom,
>=20
> On 26.02.25 15:35, Tom Rini wrote:
> > > > Yes, and as I've shown, you can also use labgrid without going down=
 the
> > > > same path you took, and we can also support other lab management me=
thods
> > > > too, which is important to get as much testing as possible without
> > > > needing to centralize everything.
> > > In summary, I suppose we just have different visions and ideas, which
> > > should be a good thing.
> > So long as the project can speak with one voice, yes. Which all circles
> > back to why I do not think what you're doing with u-boot.org is at all
> > helpful.
>=20
> dummy question ... what is the plan for this webaddress?

It's a very good question. Simon owns the domain. ci.u-boot.org
currently points to his personal gitlab instance and tree and is not a
CNAME for source.denx.de.

--=20
Tom

--Fx2Ka9QQLsMcVopN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAhDYACgkQFHw5/5Y0
tyx6gAv/RGhNYQDTJCmgjDgQhGJ6U7a5Iq1dXhaNF9Y2Z9VTAMcar8cdnn3V7Hk5
T+qrXfQ4cDv8BVOwUt/UkzL2A6VPVLulbA+i4PhCAHQLj15+rULzzJVxqemLmyKm
kighEO/bGa+jiPKFcXf06C43/wM8w+QCUmp6CZmwBGBVgGJfy79kJNHmDKLn+rmn
pmukfgiHY1frmaYD1aoAqqwI0S9tRWKZql05c1Y+8MkEIXpM3edQ4ojNl0EsHAIJ
+Tk8Zc6W8qjIZ3fBMx344lJXQr9a6izncYVTzVbjzShHkkt2UQYOoAit4VV53ND1
PCDN3prRlVALmsmL54FMXu/khJVkBYLrtO8pZYb2nSoKjokLZDC8JLsfacC+JcuC
FXUMJCiXbX5/f4mlyNnvG2XhB0HXlwFJIhx+Zxeuz7mwRgA6mZx8xIiJiO2qFC1p
m2IrF42gctGwAZ1tEoQ7ouPwgBhYcg+izMCNHAH5WGp2C9yrokdo9tJOvabJDLah
D5rCsKYR
=Ffa/
-----END PGP SIGNATURE-----

--Fx2Ka9QQLsMcVopN--
