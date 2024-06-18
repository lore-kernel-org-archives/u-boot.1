Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2B2C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E1C88307;
	Tue, 18 Jun 2024 17:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="SU9zmYVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6490D88307; Tue, 18 Jun 2024 17:48:35 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FDBB80C58
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6e43dad8ecso972873666b.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1718725712; x=1719330512; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnemZ9Mn02GbfTN0A/4aYAJ6rHd8irbg+REVymu+t5Q=;
 b=SU9zmYVCJ7nm7pNUytMOTiAb33EeT3v7awfqSK6t2yUQoRaaZ02WT/tG568ogn1oTs
 sDsIzJPEfsDpkPOVEJDSRlYw7vr1cjxEvyLpX2qAhFYJLoqW43TFIo54xUEq/LTVz/l4
 1aErHHycWQz3XtoRwcgXJEslXOBtnsRppUx+F2KoljNgy3qD8XBdkeYbnLbDvPOeMS1o
 sL2E0r3YEE68PD3hgGGxDOaiyuAbIZIATz6dYablqpqjPo4kjqE4d+I73F3NYf0XJoNB
 /RNdFmaORIJUUweXYsga6d+dUlJz/kQLfa79WqaOags2VSLAqrmZWyf2bWuV5GUReR5T
 Ft+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718725712; x=1719330512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnemZ9Mn02GbfTN0A/4aYAJ6rHd8irbg+REVymu+t5Q=;
 b=O2WbwKstYQLd/N+mV2xquncWJUNfwxKAb87GQuJ2cAjmD0G1vESsJEHlWg46kGc09+
 gYDTbWEDvlMXaCp67q9XNKH1kw/7vCJyQ/JY9Dln8axrth6rZMANpUHh35HdXzm1bSdR
 5VZGkNpI/6+0DuiOxRPipZli04936KVhUv3TEOCPcscT2gvo1iNi5BvaZr3Ue4dkXltt
 VaqPmfy7vCP17wbdcEH0zfXAkKdrdWmKn73UJj9Q3h9O9FrmLiJVIF9Vto2fs+msyDnP
 F6Udbc6XYcmPnHmwPRlIWLgSBNEeWhjVx0sjAksD4FYbeRwkAFpVR4c6AYfkAnkExfRk
 PcmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0JuNPawfRZnrFKzoYqaUypAwClA85iEx5noRLWdF2P7AiLohoR2VLOYbOFCLwuAnkkiqU/Ir+TL7Rvx2taA9YelKQtg==
X-Gm-Message-State: AOJu0YzYTyyBYJgy8lfawfsBS1JqfbGVhn9ncT3aWQiVW3HvQui8B3+9
 SHNH9fvO+3Gz6tSdtsSjY6/5R2N3NCq4BLEYiof1PKKbZyTYmAZamkV9bIII7g9WlEaWqRrkmdb
 x9b0ISQybxATRzkYei7NVl/HR2Zn8bggZK8Oxw4NZ2Md9VMOiFCQ=
X-Google-Smtp-Source: AGHT+IFeQmLcv9mOMOnfgSWzYew0SjOYwsvMO6e9RSbhYYOnQCpyYz2ujJE5C5aIwpors1Hy/w0c237Kj2M+5rbWFLE=
X-Received: by 2002:a17:907:a091:b0:a6f:6df5:a264 with SMTP id
 a640c23a62f3a-a6fa40d4349mr15504466b.1.1718725711861; Tue, 18 Jun 2024
 08:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240617191416.1351790-1-tharvey@gateworks.com>
 <20240617191416.1351790-5-tharvey@gateworks.com>
 <626fe70e-ff61-46f6-84de-e9b8486ac5ed@gmx.de>
In-Reply-To: <626fe70e-ff61-46f6-84de-e9b8486ac5ed@gmx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 18 Jun 2024 08:48:20 -0700
Message-ID: <CAJ+vNU3rtrGkL3gQwEZW0x=ivSPqv-jxsdUX59bCcYRofe7Wxw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] test: cmd: fdt: fix chosen test for DM_RNG
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 18, 2024 at 4:51=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 17.06.24 21:14, Tim Harvey wrote:
> > Now that kaslr-seed is automatically added to the chosen node if DM_RNG
> > is enabled, adjust the test to expect this.
>
> We need to check that if CONFIG_EFI_TCG2_PROTOCOL=3Dy no kaslr-seed node
> is passed to EFI binaries.
>
> The right location for such a test is lib/efi_selftest/efi_selftest_tcg2.=
c.
>

Hi Heinrich,

I see you sent a patch for that but I'm not understanding how that
fits into the ut framework.

> We need as similar check for CONFIG_MEASURED_BOOT=3Dy.

Can you explain more please?

Does this explain the CI failures I see here:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D8721&view=3Dlo=
gs&j=3D6ebe5bb0-481f-5026-b4e6-2d4192a94e80&t=3D66c5926e-2461-580f-927d-c0d=
0a6120549&l=3D539
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D8721&view=3Dlo=
gs&j=3Da1270dec-081b-5c65-5cd5-5e915a842596&t=3D69f6cf72-86f3-551a-807d-f28=
f62a1426f&l=3D541

I'm still trying to make sense of those.

In order to test this locally I built for sandbox64_defconfig and ran
"./u-boot -Dc 'ut fdt'" but it seems that doesn't cover enough cases.

Best regards,

Tim

>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > Cc: Michal Simek <michal.simek@amd.com>
> > Cc: Andy Yan <andy.yan@rock-chips.com>
> > Cc: Akash Gajjar <gajjar04akash@gmail.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > Cc: Devarsh Thakkar <devarsht@ti.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Chris Morgan <macromorgan@hotmail.com>
> > ---
> > v6: new patch
> > ---
> >   test/cmd/fdt.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > index 547085521758..537d8a338bbf 100644
> > --- a/test/cmd/fdt.c
> > +++ b/test/cmd/fdt.c
> > @@ -1347,6 +1347,8 @@ static int fdt_test_chosen(struct unit_test_state=
 *uts)
> >       ut_assert_nextlinen("\tu-boot,version =3D "); /* Ignore the versi=
on string */
> >       if (env_bootargs)
> >               ut_assert_nextline("\tbootargs =3D \"%s\";", env_bootargs=
);
> > +     if (CONFIG_IS_ENABLED(DM_RNG))
> > +             ut_assert_nextlinen("\tkaslr-seed =3D ");
> >       ut_assert_nextline("};");
> >       ut_assertok(ut_check_console_end(uts));
> >
> > @@ -1363,6 +1365,8 @@ static int fdt_test_chosen(struct unit_test_state=
 *uts)
> >       ut_assert_nextlinen("\tu-boot,version =3D "); /* Ignore the versi=
on string */
> >       if (env_bootargs)
> >               ut_assert_nextline("\tbootargs =3D \"%s\";", env_bootargs=
);
> > +     if (CONFIG_IS_ENABLED(DM_RNG))
> > +             ut_assert_nextlinen("\tkaslr-seed =3D ");
> >       ut_assert_nextline("};");
> >       ut_assertok(ut_check_console_end(uts));
> >
>
