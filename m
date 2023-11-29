Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805C6C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 09:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C507A86DB1;
	Wed, 29 Nov 2023 10:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="v8VFnH/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA868709A; Wed, 29 Nov 2023 10:26:42 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EB1786844
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6cdcef8b400so568719b3a.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 01:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1701249998; x=1701854798; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/pxzEcrUc8VyqF1c2gonORBzeywwNOF9ede0fuZaGVM=;
 b=v8VFnH/nXw401wiu1W9s6WQ4c38n9vT3MQzSOsUdxlO1G2v/ZW9gNW2V9dCoFWZ1UM
 eNH1qAxsPpgrZ0Fg6HysjPggyAcpBwFYOpEtc8KdZ3xR3p8h6fNQ3dtXEoSXhWP23C/l
 5IYVuiCU+HZTnycctTPJAc9djlHXMJEwuRnn2mcKEl4DridbcZP2201u8ab6P2Bzdxly
 aHu7pCFBDdEEDcXKQlBEM7B8Aob2Fxt/ZRrLndWUbVK4ZwKdZZo0nrV9mzKPI5yixdOT
 51M0qtKaJyzRWjN6SHSY4L5UfXp7mdAboRnHmIcqm0jPoioSCKT5iw79LZ7/0QXDRAII
 Tm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701249998; x=1701854798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/pxzEcrUc8VyqF1c2gonORBzeywwNOF9ede0fuZaGVM=;
 b=uIbN+uK11omC5Bf8hxZ2aE1vRSNjc8Fr1f5tpb+bS6b7eoFYrOs1nakB3JVrqMdUpm
 3no8GVmrWhKq8MUvmmab89jteHe1Ki5fzjnvvM6l0FS8O5HsfhzTeUM3dENn8N6DyVh5
 d59vS3BHeoszAEKb8Dqc5QbNN0pke5ev1kgtZNqENvONWRK1RRI/RyeglpAbCppjoihN
 rR36zX+AV7vkPU2jKr3Mmj11MF7/55Ar3go5ocoDwJHmnjgMeXHGYt/l9bkXxvXwD0G2
 cG2qd97ChvcZAn8KSfNiINg4JT8r7cvM87aoHvruUgeAFISGby9Nr1D5Neh70oeip4BN
 vYrg==
X-Gm-Message-State: AOJu0YyCZ3b/NOCuHZWtOJ8JXVLJNiIEpt1hQfpu16aU0U/7VC7pHLw0
 4zU47HZRwjZ8iaSKgPMI7ItKZcmTbhEnaJN0/pybja5gMroRfW6M
X-Google-Smtp-Source: AGHT+IEsN4joJXVkv7oMpDDbciAgxfPlQ+HJG+WMk9S3Tx89nLJO57rVMykPlOBC+aENkXJAFDGgZlmvoEYXVVerkAk=
X-Received: by 2002:a05:6a20:9384:b0:187:9521:92bc with SMTP id
 x4-20020a056a20938400b00187952192bcmr19952767pzh.58.1701249997894; Wed, 29
 Nov 2023 01:26:37 -0800 (PST)
MIME-Version: 1.0
References: <20231020102117.1583572-1-robert.marko@sartura.hr>
 <CA+HBbNHa_a2hnU9HgxsYjAaUijsgmb0ndDMOVaBz7GLP4JOVUA@mail.gmail.com>
 <8b1005a0-3960-4f8d-8dfc-ad9e858a68f3@denx.de>
 <f98674e7-82b8-48c6-aac9-825f4311824d@denx.de>
In-Reply-To: <f98674e7-82b8-48c6-aac9-825f4311824d@denx.de>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 29 Nov 2023 10:26:26 +0100
Message-ID: <CA+HBbNEdNkMJx8HX4W_h4khs2bnHZk6FmL-MCL0fwuy9m-TtHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm: mvebu: Espressobin: move FDT fixup into a
 separate function
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
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

On Tue, Nov 28, 2023 at 4:49=E2=80=AFPM Stefan Roese <sr@denx.de> wrote:
>
> Hi Robert,
>
> On 11/28/23 16:44, Stefan Roese wrote:
> > Hi Robert,
> >
> > On 11/28/23 11:19, Robert Marko wrote:
> >> On Fri, Oct 20, 2023 at 12:21=E2=80=AFPM Robert Marko
> >> <robert.marko@sartura.hr> wrote:
> >>>
> >>> Currently, Esspresobin FDT is being fixed up directly in
> >>> ft_board_setup()
> >>> which makes it hard to add support for any other board to be fixed up=
.
> >>>
> >>> So, lets just move the FDT fixup code to a separate function and call=
 it
> >>> if compatible matches, there should be no functional change.
> >>>
> >>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >>> Reviewed-by: Stefan Roese <sr@denx.de>
> >>
> >> Hi Stefan,
> >>
> >> Is there anything I can do to get this series merged?
> >
> > I just looked at it (again). My recollection was that something was
> > missing here - so I was waiting for a new version. Does not seem to
> > be the case though. So I guess I forgot to pull it (sorry for that)
> > and now with rc3 out it seems a bit too late in the release cycle.
> > I hope you don't mind that it's postponed to the next merge window.
>
> Seems my memory is not that bad after all. A world CI build fails with
> these 3 commits. Could you please have a look?
>
> Completed: 84 total built, 84 newly), duration 1:01:11, rate 0.02
> + ret=3D100
> + [[ 100 -ne 0 ]]
> + tools/buildman/buildman -o /tmp -seP am33xx at91_kirkwood mvebu omap
> -x siemens
> Summary of current source for 84 boards (2 threads, 1 job per thread)
>     aarch64:  w+   x240 turris_mox mvebu_ac5_rd eDPU
> mvebu_espressobin-88f3720 uDPU clearfog_gt_8k mvebu_db_armada8k
> mvebu_mcbin-88f8040 mvebu_puzzle-m801-88f8040 mvebu_crb_cn9130
> mvebu_db_cn9130 +   mvebu_db-88f3720
>         arm:  w+   am335x_shc am335x_shc_ict am335x_shc_netboot
> am335x_shc_sdboot brsmarc1 cm_t43 chiliboard am335x_igep003x am335x_sl50
> am43xx_evm_qspiboot am43xx_hs_evm_qspi controlcenterdc db-88f6720
> db-88f6820-gp igep00x0 sniper omap3_beagle omap4_panda omap4_sdp4430
> +aarch64-linux-ld.bfd: board/Marvell/mvebu_armada-37xx/board.o: in
> function `is_edpu_plus':
> +board/Marvell/mvebu_armada-37xx/board.c:94:(.text.last_stage_init+0xb4):
> undefined reference to `dm_mdio_read'
> +make[1]: *** [Makefile:1765: u-boot] Error 139
> +make[1]: *** Deleting file 'u-boot'
> +make: *** [Makefile:177: sub-make] Error 2

Ok, seems like CI doesn't have DM MDIO enabled.
Will fixup today.

I am fine with pulling the fixed patchset after the stable release.

Regards,
Robert
>
>
> Thanks,
> Stefan
>
>
> > Thanks,
> > Stefan
> >
> >> Regards,
> >> Robert
> >>
> >>> ---
> >>>   board/Marvell/mvebu_armada-37xx/board.c | 14 +++++++++-----
> >>>   1 file changed, 9 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/board/Marvell/mvebu_armada-37xx/board.c
> >>> b/board/Marvell/mvebu_armada-37xx/board.c
> >>> index 04124d8014..1471caa9a6 100644
> >>> --- a/board/Marvell/mvebu_armada-37xx/board.c
> >>> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> >>> @@ -363,18 +363,14 @@ EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT,
> >>> last_stage_init);
> >>>   #endif
> >>>
> >>>   #ifdef CONFIG_OF_BOARD_SETUP
> >>> -int ft_board_setup(void *blob, struct bd_info *bd)
> >>> +static int espressobin_fdt_setup(void *blob)
> >>>   {
> >>> -#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> >>>          int ret;
> >>>          int spi_off;
> >>>          int parts_off;
> >>>          int part_off;
> >>>
> >>>          /* Fill SPI MTD partitions for Linux kernel on Espressobin *=
/
> >>> -       if (!of_machine_is_compatible("globalscale,espressobin"))
> >>> -               return 0;
> >>> -
> >>>          spi_off =3D fdt_node_offset_by_compatible(blob, -1,
> >>> "jedec,spi-nor");
> >>>          if (spi_off < 0)
> >>>                  return 0;
> >>> @@ -459,6 +455,14 @@ int ft_board_setup(void *blob, struct bd_info *b=
d)
> >>>                  return 0;
> >>>          }
> >>>
> >>> +       return 0;
> >>> +}
> >>> +
> >>> +int ft_board_setup(void *blob, struct bd_info *bd)
> >>> +{
> >>> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> >>> +       if (of_machine_is_compatible("globalscale,espressobin"))
> >>> +               return espressobin_fdt_setup(blob);
> >>>   #endif
> >>>          return 0;
> >>>   }
> >>> --
> >>> 2.41.0
> >>>
> >>
> >>
> >
> > Viele Gr=C3=BC=C3=9Fe,
> > Stefan Roese
> >
>
> Viele Gr=C3=BC=C3=9Fe,
> Stefan Roese
>
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
