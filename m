Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F33C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 15:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B125880C5;
	Wed, 27 Mar 2024 16:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K6L/GvYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DC2880E0; Wed, 27 Mar 2024 16:46:40 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E190880AD
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 16:46:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d4886a1cb4so89998691fa.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711554398; x=1712159198; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWLQvASEPp17TVYllXFJw3nyvTknS90gECrBiFeea90=;
 b=K6L/GvYf00SZzfMHfjahUdsyh5FWCHGUJohLPM6KJpG3MEgWoBJRJReK6QFMUJwHyI
 uQDkZwcWwEzDzdx+YJvHnA/ZoaLZspiJLxpyvIB6XDz+s71SleYbLhVekm4VFpegph/+
 lq/XWP7CxQQ5YqGMI6Qq4VCdEdNeOFi1nP1raAHnxn1KI6zv+1sw/ZKT0JLkaDd7zWQX
 aQJhC7D0tuTixIZt0LiVEq7Nvh5GM0BTSUq3n2snLXt99QgIJNo/HCCio17CUduClyc8
 EA5whThvk1J7K3M2JA0uUPBu001K09qfwknOz3IF6IopY4+WncYU6kF8kIPd7IkP2XMv
 pAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711554398; x=1712159198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWLQvASEPp17TVYllXFJw3nyvTknS90gECrBiFeea90=;
 b=eOxgsurmSzUWIkPgsLs7YahIUHMvLp5y9WKEs0hmIEm8PWqPoLbKaTMZAREJIUcoqB
 0mxEHxuyUuu5OjJ/j9Oq78iFzp/4/faxcbdTsjzuZx60Xh/i5A9f16qOCCsaP0hfQ/Ap
 EtJKJr9Y+fCmxPFg93xJwzgPZwRf5BH1xaq4i5mlMQdwOApkjxBR4u0vqaLrDJ/VXdBJ
 ZBS3bkdPwK70uyipOHpseNiHkQI6FB/TPoQv4luf4OmlAuCKK5vKsPPdeo4FeCc75S49
 sdv+1OWKFSU8gBYYzkWyRTx90wLAoBCMqYAD1ysXJQLIeLJrckCCY2lQV68v3BF05ARK
 iDGw==
X-Gm-Message-State: AOJu0YzV0edql4KY/R3WtqIq2VVtpinqcE2uD0/nN1uV+0iNo95V3YNi
 zuOqfj1kvXIU0U3dLAgAFnfCa9+5WSbRfhAA5LDvT8vhEEMF0RkIs0sKqtHpkyrDPMMT7T6y4NV
 ySNDVfgpXncpeKF7nJDXxthv4BaDB5nuQaY4HNg==
X-Google-Smtp-Source: AGHT+IGNjiBBElU2cy1FqG6JixHxaQsVX3tBI6lsNz8VjR0uXtkkeAzr7Rcqnr/ltY6GRWJPW5jUXyDYDxJCGAtN25c=
X-Received: by 2002:a2e:95d5:0:b0:2d4:6aba:f1a9 with SMTP id
 y21-20020a2e95d5000000b002d46abaf1a9mr325842ljh.40.1711554397563; Wed, 27 Mar
 2024 08:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU12-4EJN_RPGPPTfTVden2=beq-XaeFL=dF7t+AAqje=Q@mail.gmail.com>
 <CAC_iWj+B0r7o8Hwi_KZM=+L9t6=THH=pzY38jrcDDdAntWT3Rw@mail.gmail.com>
 <CAJ+vNU0380ved3FWt_R4UVR3stFrb3B4dLTx=m6dp0377MK6hQ@mail.gmail.com>
 <afab8b1e-ad41-47fc-ad76-383151f4caf2@linux.ibm.com>
In-Reply-To: <afab8b1e-ad41-47fc-ad76-383151f4caf2@linux.ibm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Mar 2024 17:46:01 +0200
Message-ID: <CAC_iWjK47NBn89yMs0FsMGtOijHTAta5uYmZL=oumzhzyW29WQ@mail.gmail.com>
Subject: Re: tcg2_platform_get_log failing to read address and size of
 memory-region via ofnode_get_addr_size
To: Eddie James <eajames@linux.ibm.com>, Tim Harvey <tharvey@gateworks.com>
Cc: u-boot <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, 
 Ruchika Gupta <ruchika.gupta@linaro.org>, Samuel Lee <slee@gateworks.com>
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

Hi both,

On Wed, 27 Mar 2024 at 17:22, Eddie James <eajames@linux.ibm.com> wrote:
>
>
> On 3/26/24 11:15, Tim Harvey wrote:
> > On Tue, Mar 26, 2024 at 2:24=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >> Hi Tim,
> >>
> >> On Tue, 26 Mar 2024 at 03:15, Tim Harvey <tharvey@gateworks.com> wrote=
:
> >>> Greetings,
> >>>
> >>> I'm unable to understand why tcg2_platform_get_log is failing to read
> >>> a memory region.
> >>>
> >>> For example the following diffs:
> >> I am not really sure what those nodes are supposed to do in sandbox.
> >> Pehaps Eddie remembers.
> >> What exactly are you trying to achieve here? Read the eventlog from TF=
-A?
> >>
> > Hi Ilias,
> >
> > I was trying to get measured boot (CONFIG_MEASURED_BOOT=3Dy) working on
> > a tpm on my board but ran into an issue when I couldn't get the
> > memory-region I added for testing to be recognized with the current
> > code in tcg2_platform_get_log().
> >
> > I wonder if an event log should be required for measured boot - it
> > sounds like that was something required for EFI, so I was thinking of
> > submitting the following:
> > commit b3f336c2f863168219a93cd1c7ac922396e0fad5 (HEAD -> master-venice)
> > Author: Tim Harvey <tharvey@gateworks.com>
> > Date:   Tue Mar 26 08:49:07 2024 -0700
> >
> >      tpm: allow measured boot without an event log
> >
> >      Currently an event log is required for measured boot. Remove this
> >      requirement.
> >
> >      Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >
> > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > index 68eaaa639f89..994f8089ba34 100644
> > --- a/lib/tpm-v2.c
> > +++ b/lib/tpm-v2.c
> > @@ -175,17 +175,19 @@ static int tcg2_log_append_check(struct
> > tcg2_event_log *elog, u32 pcr_index,
> >          u32 event_size;
> >          u8 *log;
> >
> > -       event_size =3D size + tcg2_event_get_size(digest_list);
> > -       if (elog->log_position + event_size > elog->log_size) {
> > -               printf("%s: log too large: %u + %u > %u\n", __func__,
> > -                      elog->log_position, event_size, elog->log_size);
> > -               return -ENOBUFS;
> > -       }
> > +       if (elog->log_size) {
> > +               event_size =3D size + tcg2_event_get_size(digest_list);
> > +               if (elog->log_position + event_size > elog->log_size) {
> > +                       printf("%s: log too large: %u + %u > %u\n", __f=
unc__,
> > +                              elog->log_position, event_size, elog->lo=
g_size);
> > +                       return -ENOBUFS;
> > +               }
> >
> > -       log =3D elog->log + elog->log_position;
> > -       elog->log_position +=3D event_size;
> > +               log =3D elog->log + elog->log_position;
> > +               elog->log_position +=3D event_size;
> >
> > -       tcg2_log_append(pcr_index, event_type, digest_list, size, event=
, log);
> > +               tcg2_log_append(pcr_index, event_type, digest_list,
> > size, event, log);
> > +       }
> >
> >          return 0;
> >   }
> > @@ -613,10 +615,8 @@ int tcg2_measurement_init(struct udevice **dev,
> > struct tcg2_event_log *elog,
> >                  return rc;
> >
> >          rc =3D tcg2_log_prepare_buffer(*dev, elog, ignore_existing_log=
);
> > -       if (rc) {
> > +       if (rc)
> >                  tcg2_measurement_term(*dev, elog, true);
> > -               return rc;
> > -       }
> >
> >          rc =3D tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERSION,
> >                                  strlen(version_string) + 1,
> >
> > Would you agree with removing the requirement for the event log?
>
>
> No, the log is required, otherwise it's fairly meaningless work. You
> need the log in your OS to verify the contents of the TPM.

It's the other way around. You trust the TPM and replay the event log
in memory to verify it's correct.
That being said, I do agree the event log is pretty useful when trying
to understand how and what the platform measured. In any case, I'd
rather fix any issues rather than sidestep them.

The return value of ofnode_get_addr_size() depends on a couple Kconfig
options. Any chance those differ from the ones Eddie is using?

Thanks
/Ilias

>
> Here is the device tree reserved memory stuff we're using, perhaps it
> will help.
>
> diff --git a/arch/arm/dts/ast2600-p10bmc.dts
> b/arch/arm/dts/ast2600-p10bmc.dts
> index 1d0f88bf96..8fbfeaa0d7 100755
> --- a/arch/arm/dts/ast2600-p10bmc.dts
> +++ b/arch/arm/dts/ast2600-p10bmc.dts
> @@ -13,6 +13,17 @@
>                  reg =3D <0x80000000 0x40000000>;
>          };
>
> +       reserved-memory {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges;
> +
> +               event_log: tcg_event_log@b3d00000 {
> +                       no-map;
> +                       reg =3D <0xb3d00000 0x100000>;
> +               };
> +       };
> +
>          chosen {
>                  stdout-path =3D &uart5;
>          };
> @@ -113,6 +124,7 @@
>          tpm@2e {
>                  compatible =3D "nuvoton,npct75x";
>                  reg =3D <0x2e>;
> +               memory-region =3D <&event_log>;
>          };
>   };
>
>
> >
> > I have another question that perhaps you may have some feedback on.
> > The tpm commands such as pcr_extend, pcr_read currently require a
> > 32-byte SHA256 digest and I wish to extend that as my TPM supports
> > only SHA1. The tpm2_pcr_extend and tpm2_pcr_read functions were
> > extended to  function to allow the digest type and length to be passed
> > in and I'm wondering what the best way to extend the tpm extend/read
> > commands would be to support that.
> >
> > The tcg2_create_digest function creates a digest based on the
> > capabilities of the tpm and the tcg2_pcr_extend loops over those
> > calling tpm2_pcr_extend for each digtest supported (and same for
> > tcg2_pcr_read looping over tpm2_pcr_read) and I'm assuming TPM's can
> > support multiple algos so I suppose a parameter needs to be added to
> > the pcr_read and pcr_extend commands. Would you agree with that?
> >
> > Best Regards,
> >
> > Tim
> >
> >> Thanks
> >> /Ilias
> >>> diff --git a/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> >>> b/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> >>> index 7b2130dbdb21..57b3c227ceaf 100644
> >>> --- a/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> >>> +++ b/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> >>> @@ -112,6 +112,7 @@
> >>>                  compatible =3D "tcg,tpm_tis-spi";
> >>>                  reg =3D <0x1>;
> >>>                  spi-max-frequency =3D <36000000>;
> >>> +               memory-region =3D <&event_log>;
> >>>          };
> >>>   };
> >>>   diff --git a/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> >>> b/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> >>> index c305e325d007..697fd1148785 100644
> >>> --- a/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> >>> +++ b/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> >>> @@ -13,6 +13,17 @@
> >>>                  reg =3D <0x0 0x40000000 0 0x80000000>;
> >>>          };
> >>>
> >>> +       reserved-memory {
> >>> +               #address-cells =3D <2>;
> >>> +               #size-cells =3D <2>;
> >>> +               ranges;
> >>> +
> >>> +               event_log: tcg_event_log {
> >>> +                       no-map;
> >>> +                       reg =3D <0 0x40000000 0x2000>;
> >>> +               };
> >>> +       };
> >>> +
> >>>          gpio-keys {
> >>>                  compatible =3D "gpio-keys";
> >>>
> >>> And at runtime:
> >>> u-boot=3D> fdt addr $fdtcontroladdr
> >>> u-boot=3D> fdt list /soc@0/bus@30800000/spba-bus@30800000/spi@3083000=
0/tpm@1/
> >>> tpm@1 {
> >>>          compatible =3D "tcg,tpm_tis-spi";
> >>>          reg =3D <0x00000001>;
> >>>          spi-max-frequency =3D <0x02255100>;
> >>>          memory-region =3D <0x00000025>;
> >>> };
> >>> u-boot=3D> fdt list /reserved-memory/
> >>> reserved-memory {
> >>>          #address-cells =3D <0x00000002>;
> >>>          #size-cells =3D <0x00000002>;
> >>>          ranges;
> >>>          tcg_event_log {
> >>>          };
> >>> };
> >>> u-boot=3D> fdt list /reserved-memory/tcg_event_log
> >>> tcg_event_log {
> >>>          no-map;
> >>>          reg =3D <0x00000000 0x40000000 0x00002000>;
> >>>          phandle =3D <0x00000025>;
> >>> };
> >>>
> >>> So why does the following code in tcg2_platform_get_log() return -ENO=
MEM?
> >>>
> >>>                  if (dev_read_phandle_with_args(dev, "memory-region",=
 NULL, 0,
> >>>                                                 0, &args))
> >>>                          return -ENODEV;
> >>>
> >>>                  a =3D ofnode_get_addr_size(args.node, "reg", &s);
> >>>                  if (a =3D=3D FDT_ADDR_T_NONE)
> >>>                          return -ENOMEM;
> >>>
> >>> debugging shows that dev_read_phandle_with_args returns non-zero but
> >>> args.args_count is 0.
> >>>
> >>> I feel like the construct of using dev_read_phandle_with_args followe=
d
> >>> by the ofnode_get_addr_size is just wrong but I don't understand why
> >>> nor do I understand how my dt changes differ from what is in
> >>> arch/sandbox/dts/test.dts (other than its using address-size=3D1 whic=
h
> >>> doesn't appear to be the issue in my testing). The abstraction of the
> >>> ofnode and fdt stuff always trip me up... very confusing.
> >>>
> >>> Can anyone explain the issue here?
> >>>
> >>> Best Regards,
> >>>
> >>> Tim
