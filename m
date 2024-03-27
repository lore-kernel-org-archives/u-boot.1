Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D326C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 21:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A76968803F;
	Wed, 27 Mar 2024 22:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="OrdDASj6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B68C8803F; Wed, 27 Mar 2024 22:49:01 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4612987FD7
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 22:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56bc8cfc19fso340140a12.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1711576138; x=1712180938; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4u592uchFGakCyWubgOIV4cu6fBGshd1cCVYPYisj0=;
 b=OrdDASj69ubVneFxojMyCXc7l4hfkaPdXP9g+uChGywv+y5Ppe2psKE4TQOlZ0DgFv
 A0+1Ex3jG831CRWZf2jE5hUUJeHQHMRbvqtTVM9xDpT5PkLvy5V+i9rtBU1v4+Wb5Fyi
 jqc2sNvdtbk0e8OaDNNOkC49NWRLYjj5J4OfJqVQLMW4iq+lP4A3pZzjt+Rob7EagCJk
 5HDxxDn1MpLD/A38QK+cI6prEYzXhNu5hecJAXTzg+bdXTF8L9qRa+kpflDi46osNlV4
 5NSmNLUGCQnJyut3lXQUTThflk4IuvfHzyJlPvJx3tJr4uOpwg8s2dL4bwMOkIqTFZrp
 TzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711576138; x=1712180938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4u592uchFGakCyWubgOIV4cu6fBGshd1cCVYPYisj0=;
 b=ANoZkjaZu4vNAUN4Ns2jU+mJ8iBRmNjZZAvWqiMC2HQJjpOwi3Xa97DDp8onElmtvy
 fpoNk+XVMC1U920FXkpjH2JIJjlzKIjTFxC1ppT/bQ3/fU+8ksxJZWx0erunUGsv2lkr
 g+GHFporovxZCsMCwIBYuUakyDGq9SOjTNEWha9Wu5ML/RgImp2Q+7FkqFIXMKjRQ3Mg
 nYOmNDUZwrlrhxQ1KS3R+V7reorg52JuEu2WeXw7kToOhGnAkD9nIzU/qsxaterUlwHO
 iVoqk9M1/i9z8n19mhrH9tvC0mU3j48ST3ajVl0PBRrhOGsUPsOO9Akk4bH9FS4uILkh
 o1Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeFQO+WVx3oXT/BRLxbqewM+lVuuenkAlaFCiE3bbb6/eL8yPyMXgIWtTGZhT9RY+IoAXm5PGhhz87Tzb9uzldYau0Lw==
X-Gm-Message-State: AOJu0Yz3GsC6AnAhJrZ35+mD6cKcZHVvKbJX+fhfwUYJm3kiGnKxUlqu
 szMJdAmrJXRijjfLmue12neONRAps4IsRm2Yl5xxDSLU34XUO8Qi5hd/u48x9IFneot5nlI3ckz
 9tDNWeKmgQECe1vyMXKA/pq3Tkh8vWEk0Ebg1ng==
X-Google-Smtp-Source: AGHT+IGjwG9yANTshH+SJmSYBo3sDuU6nZDnRUSyXDjurUqlui7/9tC2BtB7fzEkHSu6Y2pvtLcCSCBo0RgHFf/It+E=
X-Received: by 2002:a17:906:c347:b0:a4e:14e5:c3b6 with SMTP id
 ci7-20020a170906c34700b00a4e14e5c3b6mr342302ejb.3.1711576138507; Wed, 27 Mar
 2024 14:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU12-4EJN_RPGPPTfTVden2=beq-XaeFL=dF7t+AAqje=Q@mail.gmail.com>
 <CAC_iWj+B0r7o8Hwi_KZM=+L9t6=THH=pzY38jrcDDdAntWT3Rw@mail.gmail.com>
 <CAJ+vNU0380ved3FWt_R4UVR3stFrb3B4dLTx=m6dp0377MK6hQ@mail.gmail.com>
 <afab8b1e-ad41-47fc-ad76-383151f4caf2@linux.ibm.com>
 <CAC_iWjK47NBn89yMs0FsMGtOijHTAta5uYmZL=oumzhzyW29WQ@mail.gmail.com>
 <CAJ+vNU228uHF3D6BzLjZifb1d-GN7tSTLJmaZRDk0tQWDrYknw@mail.gmail.com>
 <CAC_iWjK8SHvZeEUgDeBRYpq8LgU=M5bqQQbSYwTxsrV_H1hdVA@mail.gmail.com>
In-Reply-To: <CAC_iWjK8SHvZeEUgDeBRYpq8LgU=M5bqQQbSYwTxsrV_H1hdVA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 27 Mar 2024 14:48:46 -0700
Message-ID: <CAJ+vNU0ONNOr2-sQTMVnuhQPug+mUimcfMMQj=DEs9a8fprMOg@mail.gmail.com>
Subject: Re: tcg2_platform_get_log failing to read address and size of
 memory-region via ofnode_get_addr_size
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>, 
 u-boot <u-boot@lists.denx.de>, Ruchika Gupta <ruchika.gupta@linaro.org>, 
 Samuel Lee <slee@gateworks.com>
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

On Wed, Mar 27, 2024 at 10:06=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 27 Mar 2024 at 18:32, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 8:46=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi both,
> > >
> > > On Wed, 27 Mar 2024 at 17:22, Eddie James <eajames@linux.ibm.com> wro=
te:
> > > >
> > > >
> > > > On 3/26/24 11:15, Tim Harvey wrote:
> > > > > On Tue, Mar 26, 2024 at 2:24=E2=80=AFAM Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >> Hi Tim,
> > > > >>
> > > > >> On Tue, 26 Mar 2024 at 03:15, Tim Harvey <tharvey@gateworks.com>=
 wrote:
> > > > >>> Greetings,
> > > > >>>
> > > > >>> I'm unable to understand why tcg2_platform_get_log is failing t=
o read
> > > > >>> a memory region.
> > > > >>>
> > > > >>> For example the following diffs:
> > > > >> I am not really sure what those nodes are supposed to do in sand=
box.
> > > > >> Pehaps Eddie remembers.
> > > > >> What exactly are you trying to achieve here? Read the eventlog f=
rom TF-A?
> > > > >>
> > > > > Hi Ilias,
> > > > >
> > > > > I was trying to get measured boot (CONFIG_MEASURED_BOOT=3Dy) work=
ing on
> > > > > a tpm on my board but ran into an issue when I couldn't get the
> > > > > memory-region I added for testing to be recognized with the curre=
nt
> > > > > code in tcg2_platform_get_log().
> > > > >
> > > > > I wonder if an event log should be required for measured boot - i=
t
> > > > > sounds like that was something required for EFI, so I was thinkin=
g of
> > > > > submitting the following:
> > > > > commit b3f336c2f863168219a93cd1c7ac922396e0fad5 (HEAD -> master-v=
enice)
> > > > > Author: Tim Harvey <tharvey@gateworks.com>
> > > > > Date:   Tue Mar 26 08:49:07 2024 -0700
> > > > >
> > > > >      tpm: allow measured boot without an event log
> > > > >
> > > > >      Currently an event log is required for measured boot. Remove=
 this
> > > > >      requirement.
> > > > >
> > > > >      Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > >
> > > > > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > > > > index 68eaaa639f89..994f8089ba34 100644
> > > > > --- a/lib/tpm-v2.c
> > > > > +++ b/lib/tpm-v2.c
> > > > > @@ -175,17 +175,19 @@ static int tcg2_log_append_check(struct
> > > > > tcg2_event_log *elog, u32 pcr_index,
> > > > >          u32 event_size;
> > > > >          u8 *log;
> > > > >
> > > > > -       event_size =3D size + tcg2_event_get_size(digest_list);
> > > > > -       if (elog->log_position + event_size > elog->log_size) {
> > > > > -               printf("%s: log too large: %u + %u > %u\n", __fun=
c__,
> > > > > -                      elog->log_position, event_size, elog->log_=
size);
> > > > > -               return -ENOBUFS;
> > > > > -       }
> > > > > +       if (elog->log_size) {
> > > > > +               event_size =3D size + tcg2_event_get_size(digest_=
list);
> > > > > +               if (elog->log_position + event_size > elog->log_s=
ize) {
> > > > > +                       printf("%s: log too large: %u + %u > %u\n=
", __func__,
> > > > > +                              elog->log_position, event_size, el=
og->log_size);
> > > > > +                       return -ENOBUFS;
> > > > > +               }
> > > > >
> > > > > -       log =3D elog->log + elog->log_position;
> > > > > -       elog->log_position +=3D event_size;
> > > > > +               log =3D elog->log + elog->log_position;
> > > > > +               elog->log_position +=3D event_size;
> > > > >
> > > > > -       tcg2_log_append(pcr_index, event_type, digest_list, size,=
 event, log);
> > > > > +               tcg2_log_append(pcr_index, event_type, digest_lis=
t,
> > > > > size, event, log);
> > > > > +       }
> > > > >
> > > > >          return 0;
> > > > >   }
> > > > > @@ -613,10 +615,8 @@ int tcg2_measurement_init(struct udevice **d=
ev,
> > > > > struct tcg2_event_log *elog,
> > > > >                  return rc;
> > > > >
> > > > >          rc =3D tcg2_log_prepare_buffer(*dev, elog, ignore_existi=
ng_log);
> > > > > -       if (rc) {
> > > > > +       if (rc)
> > > > >                  tcg2_measurement_term(*dev, elog, true);
> > > > > -               return rc;
> > > > > -       }
> > > > >
> > > > >          rc =3D tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERSI=
ON,
> > > > >                                  strlen(version_string) + 1,
> > > > >
> > > > > Would you agree with removing the requirement for the event log?
> > > >
> > > >
> > > > No, the log is required, otherwise it's fairly meaningless work. Yo=
u
> > > > need the log in your OS to verify the contents of the TPM.
> > >
> > > It's the other way around. You trust the TPM and replay the event log
> > > in memory to verify it's correct.
> > > That being said, I do agree the event log is pretty useful when tryin=
g
> > > to understand how and what the platform measured. In any case, I'd
> > > rather fix any issues rather than sidestep them.
> > >
> >
> > Why do you need a log to verify the contents of the TPM? If the PCR's
> > are not correct you can't get your secrets from the TPM and if they
> > are you can regardless of a log. Where is this log requirement in the
> > TCG specification?
>
> Yes, as I said you *validate* the eventlog by looking at the TPM PCRs,
> not the other way around.
> The problem with the TCG spec is
> - EFI_TCG2_PROTOCOL.GetEventLog can only returns either EFI_SUCCESS or
> EFI_INVALID_PARAMETER. There's no EFI_UNSUPPORTED
> - EFI_TCG2_PROTOCOL.HashLogExtendEvent has a flag
> (EFI_TCG2_EXTEND_ONLY) which allows you to only extend PCRs and not
> log them
>
> But I can't find anywhere in the spec a statement that says "the
> eventlog is optional"
>
> >
> > Please see Linux commit 805fa88e0780b ("tpm: Don't make log failures
> > fatal") which has a commit log of:
> >
> > If a TPM is in disabled state, it's reasonable for it to have an empty
> > log.
>
> Yes, an empty log. Not missing a log overall. Which makes sense if the
> TPM is disabled.
>
> >  Bailing out of probe in this case means that the PPI interface
> > isn't available, so there's no way to then enable the TPM from the OS.
> > In general it seems reasonable to ignore log errors - they shouldn't
> > interfere with any other TPM functionality.
> >
> > That last sentence makes sense to me; Sure the log may be 'useful' to
> > some but I feel like it's not a requirement and it certainly is not a
> > requirement for Linux.
> >
> > > The return value of ofnode_get_addr_size() depends on a couple Kconfi=
g
> > > options. Any chance those differ from the ones Eddie is using?
> > >
> >
> > I have the same dt changes. I think this has something to do with the
> > whole are we using of or fdt, and is of live:
> >
> > $ git diff
> > diff --git a/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
> > b/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
> > index 97ed34a3c586..5752a38c7b4c 100644
> > --- a/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
> > +++ b/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
> > @@ -14,6 +14,17 @@
> >                 usb1 =3D &usbotg2;
> >         };
> >
> > +       reserved-memory {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <1>;
> > +               ranges;
> > +
> > +               event_log: tcg_event_log@40000000 {
> > +                       no-map;
> > +                       reg =3D <0x40000000 0x2000>;
> > +               };
> > +       };
> > +
> >         led-controller {
> >                 compatible =3D "gpio-leds";
> >                 pinctrl-names =3D "default";
> > @@ -91,6 +102,7 @@
> >         tpm@1 {
> >                 compatible =3D "tcg,tpm_tis-spi";
> >                 reg =3D <0x1>;
> > +               memory-region =3D <&event_log>;
> >                 spi-max-frequency =3D <36000000>;
> >         };
> >  };
> > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > index 994f8089ba34..0bc08cebed2f 100644
> > --- a/lib/tpm-v2.c
> > +++ b/lib/tpm-v2.c
> > @@ -672,11 +673,14 @@ __weak int tcg2_platform_get_log(struct udevice
> > *dev, void **addr, u32 *size)
> >                 phys_addr_t a;
> >                 fdt_size_t s;
> >
> > +printf("%s %s ofnode=3D%px valid=3D%d is_np=3D%d of_live_active=3D%d\n=
",
> > __func__, dev->name, dev_ofnode(dev).np, ofnode_valid(dev_ofnode(de
> > v)), ofnode_is_np(dev_ofnode(dev)), of_live_active());
> >                 if (dev_read_phandle_with_args(dev, "memory-region", NU=
LL, 0,
> >                                                0, &args))
> >                         return -ENODEV;
> > +printf("%s %s args:%d\n", __func__, dev->name, args.args_count);
> >
> >                 a =3D ofnode_get_addr_size(args.node, "reg", &s);
> > +printf("%s %s a:%px\n", __func__, dev->name, (void*)a);
> >                 if (a =3D=3D FDT_ADDR_T_NONE)
> >                         return -ENOMEM;
> >
> > This shows the following:
> > tcg2_platform_get_log tpm@1 ofnode=3D00000000000054d0 valid=3D1 is_np=
=3D0
> > of_live_active=3D0
> > tcg2_platform_get_log tpm@1 args:0
> > tcg2_platform_get_log tpm@1 a:ffffffffffffffff
> > ^^^ can't get address of reg
> >
> > so we have a valid of_node in the dev structure but its not a np?
> >
> > dev_read_phandle_with_args() is returning success but was not able to
> > parse any args, so we should not use 'args.node' as the arg of
> > ofnode_get_addr_size(args.node, "reg", &s);
> >
> > I think the mix of dev_read_phandle_with_args and ofnode_get_addr_size
> > is wrong. U-Boot is full of constructs like this that are extremely
> > confusing... missing fdt with of and the concept of if its live or
> > not. I'm hoping Simon can shed some light on this and maybe give or
> > point to a primer on all the of/dt/live stuff?
>
> Thanks that helps. I'll try to reproduce it with sandbox and/or QEMU
> with OF_LIVE and see if I get something.
>

Ilias,

I think the following is needed here:
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 994f8089ba34..6b9d587e491c 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -675,8 +675,7 @@ __weak int tcg2_platform_get_log(struct udevice
*dev, void **addr, u32 *size)
                if (dev_read_phandle_with_args(dev, "memory-region", NULL, =
0,
                                               0, &args))
                        return -ENODEV;
-
-               a =3D ofnode_get_addr_size(args.node, "reg", &s);
+               a =3D ofnode_get_addr_size_index(args.node, 0, &s);
                if (a =3D=3D FDT_ADDR_T_NONE)
                        return -ENOMEM;


Best Regards,

Tim
