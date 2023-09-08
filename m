Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615E8EE7FED
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9D186A04;
	Fri,  8 Sep 2023 15:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jy3e0a+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F8286A14; Fri,  8 Sep 2023 15:34:23 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E5D869F9
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5712b68dbc0so1186641eaf.1
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694180058; x=1694784858; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pzuMGXqdBtlS8yOUy8/yLYks23/clyXliaSlgWoFxb0=;
 b=Jy3e0a+EDcXN0HZyX12lWWRtXREb1pm1sI+yWFtIkCZTV9gKv8ais7OW/ciEBYTs6V
 Enni8ky4QuSrU7Z4E5bvMBC9+1SXkT6B6Z4MIyiVKmIharmrivAyGnIp7HdkjE/P1iqb
 TAV3s2ftgzk1H0Dk+OzUznUHTKusQr5YN7M5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694180058; x=1694784858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pzuMGXqdBtlS8yOUy8/yLYks23/clyXliaSlgWoFxb0=;
 b=I/6VAnpLdOJv0ehSZHImOdFbEHVaJpR9f/qS04eJ313S+pT2cMRP+RsIlIO21QL1jv
 rDCBJTFVFSzIzrOcH/8ZOecgWk6nnM02dxLYs0UcToiTk+GkaDddtp5pshUGkvZ8TCA7
 iYat99b6sJTZDwUj2KgDNDNZL9IiBl8olN29zn/tJiEHvJL/B/fGLeVH0x6OUM69IRbJ
 7bb2y9OSiRdQv9Khv9gptyVzaq1T2FlM+VdKuweufkzfIHYv6pi1Ds6eZh9webeGvGSj
 MOfu2tVqPkqWpQ+NiEwWoXQkKj67oHQI0neORF3hORZVXBUH8ZBMgqowqXt67A11ivO0
 NLFQ==
X-Gm-Message-State: AOJu0YznjucGHMGNZsbH8whkUTYYfVeSrw8AfpLanTgQmgvYwFf0ib1G
 H7RBoq8yPzWK4te8SL3mdoRNlQ==
X-Google-Smtp-Source: AGHT+IE8zRfOO0OyrP+BYxCBbKnDNfT20CrlXwKEEtj6E5dSr0vayR1Mnna50D6HFd7kFJaYbneUuw==
X-Received: by 2002:a05:6358:1101:b0:134:fdfc:4319 with SMTP id
 f1-20020a056358110100b00134fdfc4319mr2395007rwi.20.1694180058422; 
 Fri, 08 Sep 2023 06:34:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-031e-83f0-a4af-2e7d.res6.spectrum.com.
 [2603:6081:7b00:6400:31e:83f0:a4af:2e7d])
 by smtp.gmail.com with ESMTPSA id
 r125-20020a0dcf83000000b005929fd6a6c7sm429179ywd.41.2023.09.08.06.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:34:17 -0700 (PDT)
Date: Fri, 8 Sep 2023 09:34:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: sandbox trace errors in CI loop
Message-ID: <20230908133415.GA305624@bill-the-cat>
References: <7d128f4a-b972-0535-ac06-bd600ba2e37c@monstr.eu>
 <20230907181411.GX305624@bill-the-cat>
 <9d45165f-fc88-4615-969b-0aafc7d43f13@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DWH9NsjpgnNlfXYB"
Content-Disposition: inline
In-Reply-To: <9d45165f-fc88-4615-969b-0aafc7d43f13@monstr.eu>
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


--DWH9NsjpgnNlfXYB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 12:24:10PM +0200, Michal Simek wrote:
>=20
>=20
> On 9/7/23 20:14, Tom Rini wrote:
> > On Thu, Sep 07, 2023 at 05:30:03PM +0200, Michal Simek wrote:
> > > Hi Simon and Tom,
> > >=20
> > > I am preparing pull request and I see that CI loop is reporting issue=
 with
> > > sandbox trace and I have no idea what's going wrong here.
> > >=20
> > > This is the first problematic commit but have no clue what it has to =
do with trace.
> > >=20
> > > https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/commit/8=
c5f80d11b29536979ac41a6087fb8938f45bbf2
> > >=20
> > > If you have an access you can take a look at my queue to see that onl=
y this
> > > job is failing.
> > > https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines
> > >=20
> > > Thanks,
> > > Michal
> > >=20
> > > collected 1152 items / 1151 deselected / 1 selected
> > > test/py/tests/test_trace.py F                                        =
    [100%]
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > __________________________________ test_trace _______________________=
___________
> > > test/py/tests/test_trace.py:292: in test_trace
> > >      check_function(cons, fname, proftool, map_fname, trace_dat)
> > > test/py/tests/test_trace.py:117: in check_function
> > >      out =3D util.run_and_log(cons, ['sh', '-c', cmd])
> > > test/py/u_boot_utils.py:181: in run_and_log
> > >      output =3D runner.run(cmd, ignore_errors=3Dignore_errors, stdin=
=3Dstdin, env=3Denv)
> > > test/py/multiplexed_log.py:183: in run
> > >      raise exception
> > > E   ValueError: Exit code: 1
> > > ---------------------------- Captured stdout setup ------------------=
-----------
> > > /u-boot
> > > trace: early enable at 00100000
> > > sandbox_serial serial: pinctrl_select_state_full:
> > > uclass_get_device_by_phandle_id: err=3D-19
> > > =3D>
> >=20
> > I don't get it either since I see this on master with trace options
> > enabled per CI:
> > $ ./u-boot -T arch/sandbox/dts/test.dtb
> > trace: early enable at 00100000
> > sandbox_serial serial: pinctrl_select_state_full: uclass_get_device_by_=
phandle_id: err=3D-19
> > ... rest of boot proceeds ...
> >=20
> > So the test should be failing already if that was the problem.
> >=20
>=20
> I don't thin it is the problematic part.
>=20
> When I look at
> https://source.denx.de/u-boot/u-boot/-/blob/master/tools/docker/Dockerfil=
e?ref_type=3Dheads#L225
>=20
> clone is done from
> git clone https://github.com/rostedt/trace-cmd.git /tmp/trace/trace-cmd &=
& \
>=20
> https://github.com/rostedt/trace-cmd/blob/master/README#L5
>=20
> we should be using
> git://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git instead.
>=20
> I installed the latest version on my PC and run it via pytest and this is
> what I am getting.
> You see that trace-cmd report is returning "failed to init data".
>=20
> Are we wired to any specific trace-cmd version?

Wait, no, what's going on exactly? The github repository is a mirror of
the kernel.org one. So yes, we should correct to point to the main one,
but the top of tree in both cases is commit
354dccca52e805ce1b22e2b62cbae8c265886c27.

--=20
Tom

--DWH9NsjpgnNlfXYB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT7ItEACgkQFHw5/5Y0
tywC8wwAmPSIP2q0BgbQzoS5YkrvCabbIVOMeKw20VoaQJaBXFCgVNG6fkcD0dj9
EgsnO/GaSq2fV5SfnRJnuJSSOT6qj95fyNdzZ5Mw2sOurMlCGwioqzz5uCtRxF55
wQ5FJZG8CCywc6vVJeWjEAAQ36PuATiez86c7067hg7SZ2rUhqe97dOAy2S1H8AB
epEPspgKLmYgopOTrVG6TbWEsMHcxZKB/7q1ai4bQOCve0rCrK9ew+ehAfJRKAR3
U+h0ZHBcelqRYGgCyfZzYugtra78CtNiuW0AwIGukGk1jE94oOwBVCz8/qMxLHfM
nal9tElLBYTLf4SoQiGoteR3rJi+CeZvL0HBLiL8KWvzlz6dodHCWefiFK6r+6c1
tswaM23SLB1c9tPPEI6OgjsLkeKSKqeFzXMMp/0/Vckffsc4vGj0cV5PplN/Dvax
7882arfMEK4EBeTNXuoSAAxN88n7VBu1iyMsGfmoByiY71UEYzQbJTIt7ZI//K9l
0sTEnccZ
=O8P7
-----END PGP SIGNATURE-----

--DWH9NsjpgnNlfXYB--
