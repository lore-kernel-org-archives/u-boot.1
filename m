Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61284C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A608C820E2;
	Wed, 30 Apr 2025 16:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X7oval46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B750382887; Wed, 30 Apr 2025 16:15:20 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1564B8007D
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c14138668so1948369a34.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746022517; x=1746627317; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EiKTjfg4mMoUTjLENKxQ40BrgeIdO1h9GOKa+kq1nyQ=;
 b=X7oval46IYGAZYvQzRX3D9pErx80ay9ofuMlHGxnThxlLDybpvMGx4bz+Z2LLK+RBU
 tOGwFFVQRN3PHNbg/3Z5Z73uyZYurnR/BNl26xdmtySp+7D1o+XbKy1OY8IZIC7Wir/9
 Ta1/1nVwx/sHU9ZjcIVCmykMNWUhEqlzpDhSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746022517; x=1746627317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiKTjfg4mMoUTjLENKxQ40BrgeIdO1h9GOKa+kq1nyQ=;
 b=tuoaIfQA0rkrNvLq1hMxNS+VwU/AaRKm1mXoqUD4FH61I+O770d/YgzB/xNSMImj1S
 EjevOIPggN/ThrM8a6Lu2sJ13Z9xVcaLWEm9qMgOaf1OUtyQt0JkWoxqE9fP2mWFCJMM
 bkz0aDG3s6nm5jmSJ3OnNPWz2x1Io3ETgfc/1UdkrdWezUWEAZ5izSr/I2xr4yOm6iUN
 5XrSK/iihU5bW2TpqRVALk/75jwIMhhZqtYHIF8C0P/rjRlFf3EetSzUhuxaPlU9IMWV
 Oi54b0GlMJGa5pSGj/Y3oFrdgJdwsIaZUz/c/uJYnDNIZ4dx3cPL616VKMpb/TEKTbtI
 bPuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO7a+qwciqPtTTWxK0ao9s6hMZjv7wrlJPVahV+NVXDSJMB/BTCY2sijy+c+V5XcvMvwSFU4c=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6RIe8V+M5/lCgrWSvdNOl2IscV5Vw1aAq8caHEAYzIvbk1QSa
 oMg/6oictvpuMCs9gZ49Y+fyPfUUrsd8XPs9iAyXhY3HGzl07EWO+0mT/FHaf+E=
X-Gm-Gg: ASbGncsPRznIYq/HEI0gw1Xbv3Kp93P6yd9za9rQKyvsJkm56FbCL5Xh5uPWtoQ8gqJ
 bJFLFt92mE4j7vU8MYCA9Rthzo8CnVJlPKmmot9ovUBO1wufFgLQc/tdhjArdwfOck+oyudG96E
 M/vmxjsU3FmS1yOyZ2+bCj+yc0bYrB7+NUvF32Gf161l52KmCxKKLUHMbz8ElybeyMhq6HT5+uC
 xhCSbQ/0OsNhj0tjed8p43IiKv2SY3vHkHOaojxPtTODHthSsVfM0vcDtgcqAQDkBqgbwvNiY9E
 XDIZpG1jjzUafOFZRrw1LhUKBAJ6n3yFzbBXS8bc4MxVqbsMYGOkBvkebaHy1VL4dakzVM9V1n8
 i9A==
X-Google-Smtp-Source: AGHT+IGKjkBalOxLgaBnI17N8upU30bq5lwzK2375XcaJBLmNZVJrip/KO8FdOT7fZxj9A4DLO9gxA==
X-Received: by 2002:a05:6808:aaf:b0:401:e98b:ee41 with SMTP id
 5614622812f47-402c7266566mr1445532b6e.21.1746022516540; 
 Wed, 30 Apr 2025 07:15:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40212a59a21sm834859b6e.37.2025.04.30.07.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:15:15 -0700 (PDT)
Date: Wed, 30 Apr 2025 08:15:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Roese <sr@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [REGRESSION] [PATCH v6 0/3] Static initcalls
Message-ID: <20250430141513.GN1261075@bill-the-cat>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <18d1c97d9a420c40181352bf1445e2772d784d9a.camel@codethink.co.uk>
 <CAFLszTjjsdp7xijT1SVq9P3mou9vvGWmK5_ngb1Y6Ap4A99QSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fr3raeVdHDcqmsAz"
Content-Disposition: inline
In-Reply-To: <CAFLszTjjsdp7xijT1SVq9P3mou9vvGWmK5_ngb1Y6Ap4A99QSQ@mail.gmail.com>
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


--fr3raeVdHDcqmsAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 07:54:46AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 29 Apr 2025 at 16:32, Marcel Ziswiler
> <marcel.ziswiler@codethink.co.uk> wrote:
> >
> > Hi Jerome
> >
> > On Fri, 2025-04-04 at 15:50 +0200, Jerome Forissier wrote:
> > > This series replaces the dynamic initcalls (with function pointers) w=
ith
> > > static calls, and gets rid of initcall_run_list(), init_sequence_f,
> > > init_sequence_f_r and init_sequence_r. This makes the code simpler an=
d the
> > > binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
> > > bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> > >
> > > Execution time doesn't seem to change noticeably. There is no impact =
on
> > > the SPL.
> > >
> > > The inline assembly fixes, although they look unrelated, are triggered
> > > on some platforms with LTO enabled. For example: kirkwood_defconfig.
> > >
> > > CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/2=
5514
> >
> > This series seems to cause a regression on rock5b. E.g. on today's mast=
er:
> >
> > =3D> pci enum
> > =3D> setenv ipaddr 192.168.10.2
> > =3D> ping 192.168.10.1
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > failed to initialize card: -12
> > No ethernet found.
> > failed to initialize card: -12
> > failed to initialize card: -12
> > ping failed; host 192.168.10.1 is not alive
> >
> > Seems the rtl8169 driver runs out of memory trying to allocate descript=
ors?
> >
> > If I revert this series on top of today's master:
> >
> > =3D> pci enum
> > =3D> setenv ipaddr 192.168.10.2
> > =3D> ping 192.168.10.1
> >
> > Warning: eth_rtl8169 MAC addresses don't match:
> > Address in DT is                00:e0:4c:68:01:5a
> > Address in environment is       fe:b1:db:60:25:69
> > Using eth_rtl8169 device
> > host 192.168.10.1 is alive
> >
> > I just completed the bisection and will now look into what exactly coul=
d be going on.
> >
> > Any insights are much appreciated.
> >
> > Thanks!
>=20
> I have one of these boards in my lab. Could you please apply the
> pending lab patches, e.g. [1]? Also, can we get this board running
> network tests?

Your lab patches sadly stopped applying, I think somewhere around where
you didn't comment on my feedback about needing to fix problems with how
modern i.MX platforms do/don't handle blobs, and also the "all" make
target.

--=20
Tom

--fr3raeVdHDcqmsAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSMG0ACgkQFHw5/5Y0
tyzqjAv/Wp+9K8G9DksHTgPc5zL90dDInL34fsoO/SyATzleIK8+xiQlATi6QPON
Q79LP/V5xgLXNCLk5A/ZD42Dg2fv9nqwSU+zodw4uALV0smO8JC8nzYB0Dqgn9Y6
ey4HS8pstup/tuthRQXMRTl8oAJxcbZJWfHiCJDWLmxHRnAt04M3wu+efxnqDQ5A
0M33lGb2YuIDwbarhoyuc1gtGFDJZYgruV4oefAMNDByRxPdAGjEVbqbe3IGnGJh
yyPGsPHxD1cn9C7PvIBsEYqYnNJqNZpQaJUmER9Wfqvg+c5bd0Jas7uP46xtCtEf
7FjVc1t7tFnSqg0T4La5RJFf8mYLeNNeiq2xR/8cCeZOXR1UxFWSpaZoNjoaUYN8
D5nqLJAKe8+IEyXQHVTkNrMj7SN/VbP5wBpu7Z55gCmq3SOE+WBsLlQqnnUmSicq
WeDqGxWUqtIQMXH2zfPgLavH9UScw8UqyP85bYp+OT+9yC14nehUnYjNXW8Z9ymb
bXFjpysu
=BI80
-----END PGP SIGNATURE-----

--fr3raeVdHDcqmsAz--
