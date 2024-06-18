Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECB4C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 16:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C9B088263;
	Tue, 18 Jun 2024 18:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kRpcMCTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3754488315; Tue, 18 Jun 2024 18:57:09 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D41478824C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 18:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718729805; x=1719334605; i=xypron.glpk@gmx.de;
 bh=9qTjd1fxJRAkSXZPBc8aRZ8LUfjvy4iECTVf0gL2424=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=kRpcMCTMjjWYm22K+Avn/cdkKSyXk43sYfOEfSk4ILhag3dkKNFjBSjNfUQCYZnW
 EhLZsm5AHaz2IA9thHpW5tQlXE+fVWe31h+PyEg+6NZNgZ8fISt+Kqi5PBwsJETGw
 P/Mh9ghOtlYNd71fOEYiPfhdVT0BKuD48hdpgFE3lBuzDR2i9LihHk+mwZij4fQqB
 FqWSbUvjdAGMj7X6ZSmukco5QgccHc9AgC8prLbXxzXG0z8gzuxad4cTcb8QTSBg2
 IxCJ0XGlE1dPJLJC3L1xZa/Pq44M75v3AMMyaxJDAb7KlTLaZu+UT6hXLbiZsevUP
 W8m03R2cKm4iC9sEBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRjt-1suamL3nSL-00Znms; Tue, 18
 Jun 2024 18:56:45 +0200
Date: Tue, 18 Jun 2024 18:56:42 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tim Harvey <tharvey@gateworks.com>
CC: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v6 4/4] test: cmd: fdt: fix chosen test for DM_RNG
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJ+vNU2KH8NgFkjWt5ZPKMauPjhLXwd-oNfGFy-+QHO6MWKARA@mail.gmail.com>
References: <20240617191416.1351790-1-tharvey@gateworks.com>
 <20240617191416.1351790-5-tharvey@gateworks.com>
 <626fe70e-ff61-46f6-84de-e9b8486ac5ed@gmx.de>
 <CAJ+vNU3rtrGkL3gQwEZW0x=ivSPqv-jxsdUX59bCcYRofe7Wxw@mail.gmail.com>
 <CAJ+vNU2KH8NgFkjWt5ZPKMauPjhLXwd-oNfGFy-+QHO6MWKARA@mail.gmail.com>
Message-ID: <D837FC44-0CF7-4D39-84A9-B666B42AD1F5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y6fErE7GK3MGcpOdNoFGNsz7ByiR5iX1MceBN4r9/L7bRQg0aLt
 TjYwDWc3l+bpMeaSwdLq7VlUdGA4SIGLCHZm53N/0or/sLxTCakq7haBlLtT2w3ZlC8clBg
 PpskYONGIo8XX6/vw5gSyniiAKEOFOsW/8TiCsh6FdepbqOW4I0ayWOKQ8mxys3b/2H1pZI
 vMkXxIQmsh4PtpUAkV0ag==
UI-OutboundReport: notjunk:1;M01:P0:H8wggY2svKA=;4GvgEPwyNlBr6fJLJMkCHjsMd0k
 r93Znuui99lsXchTu1Yxu3AyQeWh+dvjTU13BYX7Q7AOInwPc473eJwRi7dMOXY8lpI3UHnEO
 7lUClySLe2BFwh2Odjgsu3cHfg0mkUBw3DCbGPn8b4FL2mm1JtQ3vIlhs5NXRNH6nAh0LJ/cU
 fchHrCs4/1QHti9E8eY44spHVfE53oaUGE6nfQAjVsQbxsdGzZLY5aFKpspLPTEH+o3jqTvMb
 G8uLlH2Nrk11SnBrDvVT8GPBHoPRSU6IQvcljeneGZPpBM1yVjwe3bHfpJbhyji6AO168vAP7
 IMj/bdhq6GaCS84sOMi0uai73Axp3Mmg4L9RxNcH7kd4g08ukr0YXQejL9vgGEsYETH+3Uy01
 nrID5RLyGVETG0s+RVQz6sms4mws82oRg6OLoaC1BsrsbF0H+6mSM+Hqn1epxcaBoBmJqSL0N
 fgeIokci3dS2ch7wwyom358ubOsNbYrVjouYmgAAg2QtfWz7SJZZvC2CWviaPUtzRvtUEJkCg
 XtM5hbu4PssfedVAozeDbPkfQNVwZasHXEZcT7R6qSb+LmxC1YUP17hhSbfafrcZDyrp/UI5j
 hUhlcFHWG7sLpsobCPxMGAR6K6vHn9BnYLAyUrVsqKO0kcMcVh3d2jjtZkObICijDD0iyXeP7
 EiW7g+P1WsS8eiyrWN2AVCpVhV/oMo3+lLLY/AgtDO79XI3jt+UnHbQZIBudKeGaq47Dx0LNa
 /pGZc/hWMZElSoj/kw25K+pGqKy4cLVYHsgJM6gqiSJk6lit74RsXro+6e6821nbAZn2fT3ay
 GgIvGYKjfsofQ9iEmOWijR8posJzMDYdEQkNlP+sc2XBs=
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



Am 18=2E Juni 2024 18:45:53 MESZ schrieb Tim Harvey <tharvey@gateworks=2Ec=
om>:
>On Tue, Jun 18, 2024 at 8:48=E2=80=AFAM Tim Harvey <tharvey@gateworks=2Ec=
om> wrote:
>>
>> On Tue, Jun 18, 2024 at 4:51=E2=80=AFAM Heinrich Schuchardt <xypron=2Eg=
lpk@gmx=2Ede> wrote:
>> >
>> > On 17=2E06=2E24 21:14, Tim Harvey wrote:
>> > > Now that kaslr-seed is automatically added to the chosen node if DM=
_RNG
>> > > is enabled, adjust the test to expect this=2E
>> >
>> > We need to check that if CONFIG_EFI_TCG2_PROTOCOL=3Dy no kaslr-seed n=
ode
>> > is passed to EFI binaries=2E
>> >
>> > The right location for such a test is lib/efi_selftest/efi_selftest_t=
cg2=2Ec=2E
>> >
>>
>> Hi Heinrich,
>>
>> I see you sent a patch for that but I'm not understanding how that
>> fits into the ut framework=2E
>>
>> > We need as similar check for CONFIG_MEASURED_BOOT=3Dy=2E
>>
>> Can you explain more please?

The idea of measured boot is that you check if the hash has the same value=
 every time you boot=2E If you measure the device-tree and it contains a ra=
ndom value, you get a random hash=2E

Best regards

Heinrich

>>
>> Does this explain the CI failures I see here:
>> https://dev=2Eazure=2Ecom/u-boot/u-boot/_build/results?buildId=3D8721&v=
iew=3Dlogs&j=3D6ebe5bb0-481f-5026-b4e6-2d4192a94e80&t=3D66c5926e-2461-580f-=
927d-c0d0a6120549&l=3D539
>> https://dev=2Eazure=2Ecom/u-boot/u-boot/_build/results?buildId=3D8721&v=
iew=3Dlogs&j=3Da1270dec-081b-5c65-5cd5-5e915a842596&t=3D69f6cf72-86f3-551a-=
807d-f28f62a1426f&l=3D541
>>
>> I'm still trying to make sense of those=2E
>>
>> In order to test this locally I built for sandbox64_defconfig and ran
>> "=2E/u-boot -Dc 'ut fdt'" but it seems that doesn't cover enough cases=
=2E
>>
>
>I believe I understand the Azure pipeline failures now=2E I don't see
>exactly where they pick a defconfig but the failed test cases are
>under 'test=2Epy for sandbox sandbox' and 'test=2Epy for sandbox
>sandbox_clang' which I've come to understand means they use
>'sandbox_defconfig' which defines CONFIG_MEASURED_BOOT where
>sandbox64_defconfig which I tested does not=2E
>
>So I need to update the test to:
>+       if (IS_ENABLED(CONFIG_DM_RNG) &&
>+           !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
>+           !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
>+               ut_assert_nextlinen("\tkaslr-seed =3D ");
>
>I've issued a PR for v7 to test via CI and will submit if all is well=2E
>
>Best Regards,
>
>Tim
>
>> Best regards,
>>
>> Tim
>>
>> >
>> > Best regards
>> >
>> > Heinrich
>> >
>> > >
>> > > Signed-off-by: Tim Harvey <tharvey@gateworks=2Ecom>
>> > > Cc: Michal Simek <michal=2Esimek@amd=2Ecom>
>> > > Cc: Andy Yan <andy=2Eyan@rock-chips=2Ecom>
>> > > Cc: Akash Gajjar <gajjar04akash@gmail=2Ecom>
>> > > Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>> > > Cc: Simon Glass <sjg@chromium=2Eorg>
>> > > Cc: Patrick Delaunay <patrick=2Edelaunay@foss=2Est=2Ecom>
>> > > Cc: Patrice Chotard <patrice=2Echotard@foss=2Est=2Ecom>
>> > > Cc: Devarsh Thakkar <devarsht@ti=2Ecom>
>> > > Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> > > Cc: Hugo Villeneuve <hvilleneuve@dimonoff=2Ecom>
>> > > Cc: Marek Vasut <marex@denx=2Ede>
>> > > Cc: Tom Rini <trini@konsulko=2Ecom>
>> > > Cc: Chris Morgan <macromorgan@hotmail=2Ecom>
>> > > ---
>> > > v6: new patch
>> > > ---
>> > >   test/cmd/fdt=2Ec | 4 ++++
>> > >   1 file changed, 4 insertions(+)
>> > >
>> > > diff --git a/test/cmd/fdt=2Ec b/test/cmd/fdt=2Ec
>> > > index 547085521758=2E=2E537d8a338bbf 100644
>> > > --- a/test/cmd/fdt=2Ec
>> > > +++ b/test/cmd/fdt=2Ec
>> > > @@ -1347,6 +1347,8 @@ static int fdt_test_chosen(struct unit_test_s=
tate *uts)
>> > >       ut_assert_nextlinen("\tu-boot,version =3D "); /* Ignore the v=
ersion string */
>> > >       if (env_bootargs)
>> > >               ut_assert_nextline("\tbootargs =3D \"%s\";", env_boot=
args);
>> > > +     if (CONFIG_IS_ENABLED(DM_RNG))
>> > > +             ut_assert_nextlinen("\tkaslr-seed =3D ");
>> > >       ut_assert_nextline("};");
>> > >       ut_assertok(ut_check_console_end(uts));
>> > >
>> > > @@ -1363,6 +1365,8 @@ static int fdt_test_chosen(struct unit_test_s=
tate *uts)
>> > >       ut_assert_nextlinen("\tu-boot,version =3D "); /* Ignore the v=
ersion string */
>> > >       if (env_bootargs)
>> > >               ut_assert_nextline("\tbootargs =3D \"%s\";", env_boot=
args);
>> > > +     if (CONFIG_IS_ENABLED(DM_RNG))
>> > > +             ut_assert_nextlinen("\tkaslr-seed =3D ");
>> > >       ut_assert_nextline("};");
>> > >       ut_assertok(ut_check_console_end(uts));
>> > >
>> >
