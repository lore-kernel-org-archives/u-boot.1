Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCDFCD11DD
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 16:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B617388018;
	Tue, 26 Mar 2024 17:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="BFXQ39L4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE3AB87FF2; Tue, 26 Mar 2024 17:15:44 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 939BB8800D
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 17:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a46ba938de0so769652866b.3
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1711469741; x=1712074541; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yyi8wyMnD/CdSuNmd55ZBp2301dgvvMkBlqPhSQmT4M=;
 b=BFXQ39L4gxnKTG5gkY3ewt56m8/LuUDx4cFA5gYiWFX9mgdfcD4/A9U2qYjFn10wIg
 blh34zuo2dGttd6sUXpnelzjsLK35QaKV1SVu1rVoPTCv0CspVrk2OBYOy1WJVkyEHui
 aHxSfJElS0wJ3P5SbqNrkmDi4O9JVp4MV9FoyOh42Bdkgezq72LExbLDxL8nexAxToh8
 /V3ksw1xxXGN7yZrE6QFbjNNEJifqj/VefBZ82EFCtVCcD+EqfkkY0RNxvFBCxvZwQbp
 iAZWnvnB5SAD/6bRw+jc8OuVBLxsA/skBuKJA6M8qcNS+lkKm4SRF1H1MtoRwWmKynXa
 WYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711469741; x=1712074541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yyi8wyMnD/CdSuNmd55ZBp2301dgvvMkBlqPhSQmT4M=;
 b=kctlEACK96NInM+WH2EodWnxjs1J3b5tpA37+dlvm46fckOq5So26oQRaIS/It3b4U
 ACIIZN8uTw4OQa69ir9rYqn4Me+ojR1hDOaA2t7dxYktigDh2FAhNr06BDFa7hjiGrBQ
 u3SEY2BA6dAO0as0CaQZ8UPqgJt2uJPR73sky2dsTi7bXvxAlWVv5yI5oH9eHHFwYiIU
 pIl/0yBdm4AsWeR51zOTluFJFS4hBGweDvms0sZirc7l7q+i5gmVfmyWCaHlKldjtOts
 ion0WfAc8LpKKrLRBmTkPnXeqvpp5ZD5dfhGrZGyA9++/oSrIHu3Rw91HFC86/G19tn/
 aqdA==
X-Gm-Message-State: AOJu0YxRNBK5h0NvuFT2ltDPfYMCsgOdbb/DKyl26jlzDi5GYX2OvEyr
 huBSc1bpHK+D9821evnsK+tyoY/D/kLJc5zf/qBdTbT4S0ZrpewKg6B4oIlenlHCR+NTsiVHb96
 4B7SwUAN/4W6yI0YhypLSFw8XWmHacrDSVdaTTw==
X-Google-Smtp-Source: AGHT+IFnHBbn1Pv3H7xRFt5cBxvHtpdKPwc0zdOJ63kyhOjzjxa3EvHd/dDipFEdFLIZNnrbQB73CB2IY/PdpEuxUsI=
X-Received: by 2002:a17:906:dfc6:b0:a4d:fa1f:4cdd with SMTP id
 jt6-20020a170906dfc600b00a4dfa1f4cddmr887460ejc.43.1711469741009; Tue, 26 Mar
 2024 09:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU12-4EJN_RPGPPTfTVden2=beq-XaeFL=dF7t+AAqje=Q@mail.gmail.com>
 <CAC_iWj+B0r7o8Hwi_KZM=+L9t6=THH=pzY38jrcDDdAntWT3Rw@mail.gmail.com>
In-Reply-To: <CAC_iWj+B0r7o8Hwi_KZM=+L9t6=THH=pzY38jrcDDdAntWT3Rw@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 26 Mar 2024 09:15:29 -0700
Message-ID: <CAJ+vNU0380ved3FWt_R4UVR3stFrb3B4dLTx=m6dp0377MK6hQ@mail.gmail.com>
Subject: Re: tcg2_platform_get_log failing to read address and size of
 memory-region via ofnode_get_addr_size
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot <u-boot@lists.denx.de>, eajames@linux.ibm.com, 
 Simon Glass <sjg@chromium.org>, Ruchika Gupta <ruchika.gupta@linaro.org>, 
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

On Tue, Mar 26, 2024 at 2:24=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tim,
>
> On Tue, 26 Mar 2024 at 03:15, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > Greetings,
> >
> > I'm unable to understand why tcg2_platform_get_log is failing to read
> > a memory region.
> >
> > For example the following diffs:
>
> I am not really sure what those nodes are supposed to do in sandbox.
> Pehaps Eddie remembers.
> What exactly are you trying to achieve here? Read the eventlog from TF-A?
>

Hi Ilias,

I was trying to get measured boot (CONFIG_MEASURED_BOOT=3Dy) working on
a tpm on my board but ran into an issue when I couldn't get the
memory-region I added for testing to be recognized with the current
code in tcg2_platform_get_log().

I wonder if an event log should be required for measured boot - it
sounds like that was something required for EFI, so I was thinking of
submitting the following:
commit b3f336c2f863168219a93cd1c7ac922396e0fad5 (HEAD -> master-venice)
Author: Tim Harvey <tharvey@gateworks.com>
Date:   Tue Mar 26 08:49:07 2024 -0700

    tpm: allow measured boot without an event log

    Currently an event log is required for measured boot. Remove this
    requirement.

    Signed-off-by: Tim Harvey <tharvey@gateworks.com>

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 68eaaa639f89..994f8089ba34 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -175,17 +175,19 @@ static int tcg2_log_append_check(struct
tcg2_event_log *elog, u32 pcr_index,
        u32 event_size;
        u8 *log;

-       event_size =3D size + tcg2_event_get_size(digest_list);
-       if (elog->log_position + event_size > elog->log_size) {
-               printf("%s: log too large: %u + %u > %u\n", __func__,
-                      elog->log_position, event_size, elog->log_size);
-               return -ENOBUFS;
-       }
+       if (elog->log_size) {
+               event_size =3D size + tcg2_event_get_size(digest_list);
+               if (elog->log_position + event_size > elog->log_size) {
+                       printf("%s: log too large: %u + %u > %u\n", __func_=
_,
+                              elog->log_position, event_size, elog->log_si=
ze);
+                       return -ENOBUFS;
+               }

-       log =3D elog->log + elog->log_position;
-       elog->log_position +=3D event_size;
+               log =3D elog->log + elog->log_position;
+               elog->log_position +=3D event_size;

-       tcg2_log_append(pcr_index, event_type, digest_list, size, event, lo=
g);
+               tcg2_log_append(pcr_index, event_type, digest_list,
size, event, log);
+       }

        return 0;
 }
@@ -613,10 +615,8 @@ int tcg2_measurement_init(struct udevice **dev,
struct tcg2_event_log *elog,
                return rc;

        rc =3D tcg2_log_prepare_buffer(*dev, elog, ignore_existing_log);
-       if (rc) {
+       if (rc)
                tcg2_measurement_term(*dev, elog, true);
-               return rc;
-       }

        rc =3D tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERSION,
                                strlen(version_string) + 1,

Would you agree with removing the requirement for the event log?

I have another question that perhaps you may have some feedback on.
The tpm commands such as pcr_extend, pcr_read currently require a
32-byte SHA256 digest and I wish to extend that as my TPM supports
only SHA1. The tpm2_pcr_extend and tpm2_pcr_read functions were
extended to  function to allow the digest type and length to be passed
in and I'm wondering what the best way to extend the tpm extend/read
commands would be to support that.

The tcg2_create_digest function creates a digest based on the
capabilities of the tpm and the tcg2_pcr_extend loops over those
calling tpm2_pcr_extend for each digtest supported (and same for
tcg2_pcr_read looping over tpm2_pcr_read) and I'm assuming TPM's can
support multiple algos so I suppose a parameter needs to be added to
the pcr_read and pcr_extend commands. Would you agree with that?

Best Regards,

Tim

> Thanks
> /Ilias
> >
> > diff --git a/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> > b/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> > index 7b2130dbdb21..57b3c227ceaf 100644
> > --- a/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> > +++ b/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> > @@ -112,6 +112,7 @@
> >                 compatible =3D "tcg,tpm_tis-spi";
> >                 reg =3D <0x1>;
> >                 spi-max-frequency =3D <36000000>;
> > +               memory-region =3D <&event_log>;
> >         };
> >  };
> >  diff --git a/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> > b/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> > index c305e325d007..697fd1148785 100644
> > --- a/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> > +++ b/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> > @@ -13,6 +13,17 @@
> >                 reg =3D <0x0 0x40000000 0 0x80000000>;
> >         };
> >
> > +       reserved-memory {
> > +               #address-cells =3D <2>;
> > +               #size-cells =3D <2>;
> > +               ranges;
> > +
> > +               event_log: tcg_event_log {
> > +                       no-map;
> > +                       reg =3D <0 0x40000000 0x2000>;
> > +               };
> > +       };
> > +
> >         gpio-keys {
> >                 compatible =3D "gpio-keys";
> >
> > And at runtime:
> > u-boot=3D> fdt addr $fdtcontroladdr
> > u-boot=3D> fdt list /soc@0/bus@30800000/spba-bus@30800000/spi@30830000/=
tpm@1/
> > tpm@1 {
> >         compatible =3D "tcg,tpm_tis-spi";
> >         reg =3D <0x00000001>;
> >         spi-max-frequency =3D <0x02255100>;
> >         memory-region =3D <0x00000025>;
> > };
> > u-boot=3D> fdt list /reserved-memory/
> > reserved-memory {
> >         #address-cells =3D <0x00000002>;
> >         #size-cells =3D <0x00000002>;
> >         ranges;
> >         tcg_event_log {
> >         };
> > };
> > u-boot=3D> fdt list /reserved-memory/tcg_event_log
> > tcg_event_log {
> >         no-map;
> >         reg =3D <0x00000000 0x40000000 0x00002000>;
> >         phandle =3D <0x00000025>;
> > };
> >
> > So why does the following code in tcg2_platform_get_log() return -ENOME=
M?
> >
> >                 if (dev_read_phandle_with_args(dev, "memory-region", NU=
LL, 0,
> >                                                0, &args))
> >                         return -ENODEV;
> >
> >                 a =3D ofnode_get_addr_size(args.node, "reg", &s);
> >                 if (a =3D=3D FDT_ADDR_T_NONE)
> >                         return -ENOMEM;
> >
> > debugging shows that dev_read_phandle_with_args returns non-zero but
> > args.args_count is 0.
> >
> > I feel like the construct of using dev_read_phandle_with_args followed
> > by the ofnode_get_addr_size is just wrong but I don't understand why
> > nor do I understand how my dt changes differ from what is in
> > arch/sandbox/dts/test.dts (other than its using address-size=3D1 which
> > doesn't appear to be the issue in my testing). The abstraction of the
> > ofnode and fdt stuff always trip me up... very confusing.
> >
> > Can anyone explain the issue here?
> >
> > Best Regards,
> >
> > Tim
