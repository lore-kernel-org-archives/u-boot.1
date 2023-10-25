Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AF5C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2204F86FA7;
	Wed, 25 Oct 2023 16:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qUUUU69b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D642B86F9A; Wed, 25 Oct 2023 16:57:42 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 712FC86F8A
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66d134a019cso39728206d6.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 07:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698245859; x=1698850659; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aO+O/gB+TZGWxZjNdHADQaX36QuVUbRt5XXZDp62pWY=;
 b=qUUUU69brnpa3w1tjpQ+OhvGtCJPtxUp1p4uBnNquZk4MYOkUnVRalI6MxcwDxI/yW
 YYjGXAnUuPAHwkqJzob7bLHPIg3+8plRUINcbe+blD5Mc9039kYqXMXfXoQ4phsxvpx3
 zO3ts5LSBfq/1j9Yee1dOkMLyEJk5+0dXuuHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698245859; x=1698850659;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aO+O/gB+TZGWxZjNdHADQaX36QuVUbRt5XXZDp62pWY=;
 b=WbeVOy038kthJ3KOrupE1P8Y7WwLxEZtlKy5tgZJ5MxgBvbA8xFvWXi8e29NRz8aFs
 LDhCQMNiulRbeIgX5Z6z/F/+1gGMDyRs+1SCRdZwVCkEY87OTyF7WAgWMjIWVGND3Y51
 UwSxR23usAOr3Y7n3VdgnfVKNzSDX6iQNZJbGVP0pXZ08Q6ug170STPyg6vfLa4yY1El
 /lPc9aFfTcmtwcTzgtfATBVMbL1MHSpeLeEqWgseXZtnTjj1ed+sLeSZmBP8ZDnUfCwV
 qeUhIirSzQ+yyZOkFZcHQm+UXMopka3MfpApnYoMBnphCrwQnUUh+VYiu0ww9LJUo+7+
 GSEw==
X-Gm-Message-State: AOJu0YxdKl/NsE29OcscaG8k5o9oTgCfva66Z2mE4S/dJykH4xwSIwHU
 rma8Y7Cfh/BY1pV3FeR5LnWMnWmxwDCaEPvX07Tssg==
X-Google-Smtp-Source: AGHT+IEe8TbPSJSe6SOx8RUbJXwfo21FHo5j6eyIT6kP6vKxtrnwbXxuA2ql9wAMQLBQwNUmSdRIVw==
X-Received: by 2002:a05:6214:d0f:b0:66d:d01:40a with SMTP id
 15-20020a0562140d0f00b0066d0d01040amr17781200qvh.33.1698245859158; 
 Wed, 25 Oct 2023 07:57:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 pm10-20020ad446ca000000b0066d1f118b7esm4490934qvb.1.2023.10.25.07.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 07:57:38 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:57:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: u-boot@lists.denx.de, nd@arm.com, xueliang.zhong@arm.com
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20231025145736.GS496310@bill-the-cat>
References: <20230821210927.GL3953269@bill-the-cat>
 <20231020115747.GA141285@e130802.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MyKdjMkkmNMM0ngP"
Content-Disposition: inline
In-Reply-To: <20231020115747.GA141285@e130802.arm.com>
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


--MyKdjMkkmNMM0ngP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 12:57:47PM +0100, Abdellatif El Khlifi wrote:
> Hi Tom,
>=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 464361:  Control flow issues  (DEADCODE)
> > /drivers/firmware/arm-ffa/arm-ffa-uclass.c: 148 in ffa_print_error_log()
> > 142
> > 143             if (ffa_id < FFA_FIRST_ID || ffa_id > FFA_LAST_ID)
> > 144                     return -EINVAL;
> > 145
> > 146             abi_idx =3D FFA_ID_TO_ERRMAP_ID(ffa_id);
> > 147             if (abi_idx < 0 || abi_idx >=3D FFA_ERRMAP_COUNT)
> > >>>     CID 464361:  Control flow issues  (DEADCODE)
> > >>>     Execution cannot reach this statement: "return -22;".
> > 148                     return -EINVAL;
>=20
> This is a false positive.
>=20
> abi_idx value could end up  matching this condition "(abi_idx < 0 || abi_=
idx >=3D FFA_ERRMAP_COUNT)".
>=20
> This happens when ffa_id value is above the allowed bounds. Example: when=
 ffa_id is 0x50 or 0x80
>=20
> 	ffa_print_error_log(0x50, ...); /* exceeding lower bound */
> 	ffa_print_error_log(0x80, ...);  /* exceeding upper bound */
>=20
> In these cases "return -EINVAL;" is executed.

So those invalid values aren't caught by the previous check that ffa_id
falls within FFA_FIRST_ID to FFA_LAST_ID ?

> > ...=20
> > _______________________________________________________________________=
_________________________________
> > *** CID 464360:  Control flow issues  (NO_EFFECT)
> > /drivers/firmware/arm-ffa/arm-ffa-uclass.c: 207 in ffa_get_version_hdlr=
()
> > 201             major =3D GET_FFA_MAJOR_VERSION(res.a0);
> > 202             minor =3D GET_FFA_MINOR_VERSION(res.a0);
> > 203
> > 204             log_debug("FF-A driver %d.%d\nFF-A framework %d.%d\n",
> > 205                      FFA_MAJOR_VERSION, FFA_MINOR_VERSION, major, m=
inor);
> > 206
> > >>>     CID 464360:  Control flow issues  (NO_EFFECT)
> > >>>     This greater-than-or-equal-to-zero comparison of an unsigned va=
lue is always true. "minor >=3D 0".
> > 207             if (major =3D=3D FFA_MAJOR_VERSION && minor >=3D FFA_MI=
NOR_VERSION) {
>=20
> Providing the facts that:
>=20
> #define FFA_MINOR_VERSION		(0)
> u16 minor;
>=20
> Yes, currently this condition is always true:  minor >=3D FFA_MINOR_VERSI=
ON
>=20
> However, we might upgrade FFA_MINOR_VERSION in the future. If we remove t=
he "minor >=3D FFA_MINOR_VERSION" ,
> non compatible versions could pass which we don't want.
>=20
> To keep this code scalable, I think it's better to keep this condition.

OK, thanks this makes sense as an intentional change for future sanity
checking.

> > _______________________________________________________________________=
_________________________________
> > *** CID 464359:    (PASS_BY_VALUE)
> > /drivers/firmware/arm-ffa/arm-ffa-uclass.c: 168 in invoke_ffa_fn()
> > 162      * @args: FF-A ABI arguments to be copied to Xn registers
> > 163      * @res: FF-A ABI return data to be copied from Xn registers
> > 164      *
> > 165      * Calls low level SMC implementation.
> > 166      * This function should be implemented by the user driver.
> > 167      */
> > >>>     CID 464359:    (PASS_BY_VALUE)
> > >>>     Passing parameter args of type "ffa_value_t" (size 144 bytes) b=
y value, which exceeds the low threshold of 128 bytes.
> > 168     void __weak invoke_ffa_fn(ffa_value_t args, ffa_value_t *res)
>=20
> We are using invoke_ffa_fn with the same arguments as in linux. The aim i=
s to use the same interfaces as in the Linux FF-A
> driver to make porting code easier.
>=20
> In Linux, args is passed by value [1].
> ffa_value_t is a structure with 18 "unsigned long" fields. So, the size i=
s fixed.
>=20
> [1]: invoke_ffa_fn arguments in the Linux FF-A driver
>=20
> https://elixir.bootlin.com/linux/v6.6-rc6/source/drivers/firmware/arm_ffa=
/driver.c#L115
> https://elixir.bootlin.com/linux/v6.6-rc6/source/drivers/firmware/arm_ffa=
/driver.c#L54
> https://elixir.bootlin.com/linux/v6.6-rc6/source/drivers/firmware/arm_ffa=
/common.h#L15
>=20
> [2]: include/linux/arm-smccc.h

So this is intentional, OK.

>=20
> > 169     {
> > 170     }
> > 171
> > 172     /**
> > 173      * ffa_get_version_hdlr() - FFA_VERSION handler function
> > /drivers/firmware/arm-ffa/ffa-emul-uclass.c: 673 in invoke_ffa_fn()
> > 667      * invoke_ffa_fn() - SMC wrapper
> > 668      * @args: FF-A ABI arguments to be copied to Xn registers
> > 669      * @res: FF-A ABI return data to be copied from Xn registers
> > 670      *
> > 671      * Calls the emulated SMC call.
> > 672      */
> > >>>     CID 464359:    (PASS_BY_VALUE)
> > >>>     Passing parameter args of type "ffa_value_t" (size 144 bytes) b=
y value, which exceeds the low threshold of 128 bytes.
> > 673     void invoke_ffa_fn(ffa_value_t args, ffa_value_t *res)
>=20
> Same feedback as above.

Thanks.  I'll update the last 3 CIDs shortly.

--=20
Tom

--MyKdjMkkmNMM0ngP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5LNYACgkQFHw5/5Y0
tywxyQv/fzECv2zeiU4lPpUOVw4ljLCot47kbobiy7n3tyU3H2Kx+86S7Pnwv0bQ
8sH8ihVfOfb32VsW/6MGuI8oMyncLIXPXEvaYcFC3/T4xGGygxoZ+yurw1PHq15w
l5Zi318+nAyM2kwnwATY/waLWcm5+luZJ/ofDwU1prHPbsTdQ7JfvstLIabe3jtP
lZ9by8qkjKrU1JV17lSrYRvICd9qBA4eqa2PaMwnrW+dQTknIiZlcOfcmkGqOytv
RPfvgdkQDFUq/zhup7I9++gsfSVm83qt/qxeWuB5wwJCnDvwuoQJs3eYyGCkXLqg
Cm43L4Mv43eU3Mr3V7QArPbJVvMsYUvJz5NMPCJk1uO+AqK3/HaCSZvAiLosBTA7
Dx6qKmS6t2xeZkD9G2KpDgJszchueKvceb+ZeKV08NBoQIqA9wjzTgWq4ySqcQpc
Wy2K8ZjNtuUg/HIBcixR19qO6KvA64cUmEKTCIQRvaiG0NuNfuCG5MfQBpZ4reYt
O/O0aroH
=+3Zy
-----END PGP SIGNATURE-----

--MyKdjMkkmNMM0ngP--
