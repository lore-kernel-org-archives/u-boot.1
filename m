Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60522C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 17:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDA6890F2;
	Fri, 26 Apr 2024 19:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="FT4JlvZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8E58863E; Fri, 26 Apr 2024 19:34:22 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90AFA890F2
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 19:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a55ab922260so328419466b.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714152859; x=1714757659; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhNmY0GvejQNKmGIIobkXmvFkP50xcY3O/+NXI2ihP4=;
 b=FT4JlvZyFW3gFG0PWlhz3upmpWqAvwTt3SzLHfTJDgyra8Hztgma5niBJGDPghwYX/
 zUZEmgUpsRBX8ybZaTX+irTq4Il3ZN29f9J9Mm5lgWKK4AShH8l9Mzn0GpuhZn1oKzn4
 UrP2AAc2cvajy8776Uydy59quW7oapjBGmk5KuumrWz6y8tvJY8JPfpxfhlZtdY13alM
 pPyuL9XzdU+yLsv38xLo8Vt7epQVuWHka/k3Y4OXlxL3MebZLwWl9An+G8lHcl5lHUQQ
 4EezXDatBOh+/gkDW/9Js7SxZTQETTp527nTvc43eWl8koU8WkmEsM0VhafZFU+K9M5d
 2pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714152859; x=1714757659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhNmY0GvejQNKmGIIobkXmvFkP50xcY3O/+NXI2ihP4=;
 b=AFO+GMq56aLvBNTpA6nzxKTllGzDTsv6H1cfG/F91EljwkSfI3h0ZmxjINV/zY0ElF
 xDiWKoFL1wT1chusqItReMryXlHHyGo58uqY2ASI51zV+/cpvZUSVS7S0jc9k7zKJapg
 F5NIOE9ZrsTTqdhw3FqPLzcXs0fTJZwulKrfmjEijtCQM+IdOTNUTq5EK/bLvaoEAZ2u
 y08l8YZqhnB5jXcVHmjrx/zCwfRoR7x5f/BOh40OxUegh6aDSU5CYKRg25g96xPSsgD5
 x2i5hqldu+Fp3bqOBFij6bpsAaQ3dzt8uMhnERQEyaboPznoCA4cqGHv2JQj6Hc7bRZs
 dlIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWioWPoP+WtG1hMcdU0i2mlM732L/fUCQqv+4iDvnRexVTP71uMWN8/ouLfODkunex53LSWvYaTpFoHeDvw7DU60yOb7g==
X-Gm-Message-State: AOJu0YzGbn9Fr3zEEBOFGBJSP+txxjuZbim19Vift7sMdOq2XmpT5Ku3
 x6m8Qjr5NtH66O4N0OYQ0s7TCtL6uUdosJYzkHB+ZdC5kArnlRrc2FAxd6Owx8dLZn5MiEyiYaU
 Ux0owALm0MMp/aIYsQo5VjGyiDIV+jiRr3pVpkw==
X-Google-Smtp-Source: AGHT+IF1Zncmea4Bc+oK2QnYXG0/iUyGu1SIR1mMYOHFq9Z+i/SIn22OtzP47w9JkbbJ1p4phGlBjJXsw9n2v+rXZmQ=
X-Received: by 2002:a17:906:5c1:b0:a55:b581:dca8 with SMTP id
 t1-20020a17090605c100b00a55b581dca8mr2190075ejt.38.1714152858883; Fri, 26 Apr
 2024 10:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240425230314.497203-1-marex@denx.de>
 <20240425230314.497203-2-marex@denx.de>
 <CAJ+vNU3ndKTXr5XBOd9b2aQF7WmBPARJ70Fsuab1rmnaQsEZiQ@mail.gmail.com>
 <94a75eb9-950c-41f0-b9fc-c7d95ecec6c6@denx.de>
 <8d75e195-d644-4436-8007-8476da589032@gmx.de>
In-Reply-To: <8d75e195-d644-4436-8007-8476da589032@gmx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 26 Apr 2024 10:34:07 -0700
Message-ID: <CAJ+vNU1sYMGMeJemEaMvEO4RNS_Yb-BZse3x6dXehjHL-+Gfkw@mail.gmail.com>
Subject: Re: [PATCH 2/3] crypto/fsl: Introduce SPL_FSL_CAAM_RNG
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Fri, Apr 26, 2024 at 7:45=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 26.04.24 06:03, Marek Vasut wrote:
> > On 4/26/24 2:16 AM, Tim Harvey wrote:
> >
> >>> diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefil=
e
> >>> index 7a2543e16cc..4fbce519a0b 100644
> >>> --- a/drivers/crypto/fsl/Makefile
> >>> +++ b/drivers/crypto/fsl/Makefile
> >>> @@ -6,6 +6,6 @@ obj-y +=3D sec.o
> >>>   obj-$(CONFIG_FSL_CAAM) +=3D jr.o fsl_hash.o jobdesc.o error.o
> >>>   obj-$(CONFIG_CMD_BLOB)$(CONFIG_IMX_CAAM_DEK_ENCAP) +=3D fsl_blob.o
> >>>   obj-$(CONFIG_RSA_FREESCALE_EXP) +=3D fsl_rsa.o
> >>> -obj-$(CONFIG_FSL_CAAM_RNG) +=3D rng.o
> >>> +obj-$(CONFIG_$(SPL_TPL_)FSL_CAAM_RNG) +=3D rng.o
> >>>   obj-$(CONFIG_FSL_DCP_RNG) +=3D dcp_rng.o
> >>>   obj-$(CONFIG_FSL_MFGPROT) +=3D fsl_mfgprot.o
> >>> --
> >>> 2.43.0
> >>>
> >>
> >> Marek,
> >
> > Hi,
> >
> >> Thanks - this series does solve the issue I am seeing in the SPL when
> >> enabling DM_RNG. Is this going to cause an issue for people who expect
> >> it to be currently enabled and now have to manually enable it?
> >
> > That's a good question. If I do '$ git grep FSL_CAAM_RNG' , there seem
> > to be no users, so I don't think we need to worry here, right ?
> >
> > With SPL_DM_RNG i.e. 1/3 I am a bit more concerned. But, looking at the
> > users that enable DM_RNG, I am not seeing any obvious ones that would
> > require SPL_DM_RNG too. What do you think ?
>
> Grepping for UCLASS_RNG should find usages.
>
> The only possible SPL usage seems to be in net/net_rand.h. Here a
> fallback to the mac address as seed exists.
>
> Best regards
>
> Heinrich
>

Hi Heinrich,

looks like its also used in lib/uuid.c by CONFIG_RANDOM_UUID and the
few configs have CONFIG_RANDOM_UUID=3Dy do not have DM_RNG=3Dy so not an
issue.

srand_mac is used in:
net/bootp.c which is CONFIG_CMD_BOOTP so not SPL
net/dhcpv6.c which is CONIFG_CMD_DHCP6 so not in SPL
net/net.c which is used by CONFIG_SPL_DM_ETH and the fallback you
refer to but 'git grep DM_RNG=3Dy configs/ | cut -d: -f1 | xargs grep
SPL_DM_ETH' shows no results so I think this is ok right?

but I also see lib/efi_loader/efi_rng.c where UCLASS_RNG used by
efi_rng_protocol - I don't know anything about efi... is this going to
be used by SPL?

Best Regards,

Tim
