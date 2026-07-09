Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D31FC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 19:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0708884C2B;
	Thu,  9 Jul 2026 21:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CQgqEOQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 319E084C2A; Thu,  9 Jul 2026 21:16:07 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC64E84C02
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 21:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-698b6c87884so247799a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 12:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624564; cv=none;
 d=google.com; s=arc-20260327;
 b=rLsK5lLCKmNrnb1Ri0taNz/c4CGckpOlNMb/cbcls6phs+8Mp7ZiQIfeH+lQVToZkn
 mL0GQjn0n/bc5nfxw80f9CDdTzrfzBKmWMdGsOeY8yl4Nf5pCtOjdXp577tpj9aqdoWU
 zvgqz1mLQSj4V2GX8ag3GhXFCZa2f07P248yVD7+PblAs+eGTViJqqQRz8wEsIWH1dED
 ggTMOnw9114KXzuIpi6vyN1K4MKP41VgpnQjh80Bn6KLz6JvB4WzUni0O8htXOZQ8GIX
 Pfq/jC6sE5DlFf0y7Y7oONZnrB1S7S1SWuatv9a+zI9ZHW6MNFV9htXbi8H3tECHT5kW
 EgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qKnWTTNb1+tN2bYt0/6nCZ4XCHOO7lWfOV0xcqKPgHE=;
 fh=6hUQ+cBDEhdswFVdh7jsmENQZaH9K2EJzvSA9UTasck=;
 b=qcuaAWZvIU22tzNEI32kfccJOfs3DtnWya8LtiN2RDRzTMvjSEhWHyek8Omb0mr/v2
 HAJfbxe9HtO6rZtZwrEWsHlKMdpWBDMZjM5E84syUNoi8usuy67WZR0l3AwavqvoH90J
 /RvQBKPyCju1GCsdrXjWxtUm7re6Y90OtH5es1Oc3mvNRGRfakZsBE1VjDk+8dxuHeqI
 igTNba4LB8AagH44SmdFCvZgcSEZmMQoY8xaraX8DH9yQFE4aCI9HJQIWfCL0rD0wwve
 VqowAATJLwahqyXREpknO+s5pZs5zpPlKoQ+qrlZq+BaIdwDUlvxH3XA0mLujWiWySQH
 /1uQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783624564; x=1784229364; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qKnWTTNb1+tN2bYt0/6nCZ4XCHOO7lWfOV0xcqKPgHE=;
 b=CQgqEOQT4UpEx8FYGpahmvNmIlJDnpXMD7gIzh9mXPFlBEM533FmfuHJgr5cH5sp3H
 mYEHh4na2ZEjveJ7cMNxAUK72yaefX6lVSySX8ECsRi24arxq0zlHZyIl9dMY0RCSSNw
 uztdgYowrLIUTYPc58R0KHvUN4Epq+GYefLeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624564; x=1784229364;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qKnWTTNb1+tN2bYt0/6nCZ4XCHOO7lWfOV0xcqKPgHE=;
 b=q2Fv3PoIXVFSe1UfSUFYsXVGfSBAYTLfXlaBz+xDEVr1aoU+eZCVWHm+CmQ1s8S9X4
 8TIAlpJHiphdCbu0AJo9nolDps62YQzv5G9+SnFlbotHSmt0lqshi6EvzfTZV816WyAi
 vWqEbPlLWJUJJKHU9Skzi3qkQU7bTptmdap6M/tRk7oOmH/D65gpG+Ilug+9mPiJSDrk
 WFuhxlw62zDexxKGakkP248OBhiBSLwW23X3KQl2fEHyFosoCo613nlpfZhEHmeFLGLR
 5YCMwiZ2ZDdwHkEdQgR7NjAU73ir9ZjlcdpxMvmPHlO5+FGradZeqK130hwEcGg4Y27N
 2FSg==
X-Gm-Message-State: AOJu0YxjkNhvG45ymmbOGqV8wtK9SpwoUyUxV/tyhmKW0zroYg+sC9YH
 RH26gYFpbGp01WB+uE4eMFHbvznq6Dh2vSKstn2znrLVQ1aNncLbVqnTfsX9a16WGUc47BTVR9p
 TWBYIIyX1e9eHhlcZolIBBQuwQq7lNeN7mLWSglYo
X-Gm-Gg: AfdE7cldBStxQTkaZ9ehRFktpG4XFCeG9J86+mLrYLlQZcKH37W50xxSr3AqZofCU5d
 2qusYFWOjIJtK1uMpF5znqjXM/nk9v14LPoug7so1sSJpWPUx5d7NZqx1lgulUvEhVL6RQWYXw9
 azsEofmGCYHz5/t4ecEOQ9ODOQe8oDKvup8+S1KmN5gGC0/wWuSvplEB002vf475DI+p0wSvSG9
 2PLKLyj2x0HAFYMFhT9j2tQyiHvkivJMTVNM4R1JPyW7amv9008n22Rhzykw/A+L2upTwstAJDK
 t8lC9g==
X-Received: by 2002:a17:907:9495:b0:c12:8cd5:de26 with SMTP id
 a640c23a62f3a-c15cded025emr380042366b.6.1783624564209; Thu, 09 Jul 2026
 12:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <205BD474-178D-4E91-8C41-33C46E1CCFBB@baylibre.com>
 <CAFLszTgP05iS-4dyaLbzmPGppdMmFxUQvh=JJJGnSjKJ0MnL7Q@mail.gmail.com>
 <CADh8LscDis-pfMK26usYEfS-cfRRSwvcm5hg_akXr287oDXQ=A@mail.gmail.com>
In-Reply-To: <CADh8LscDis-pfMK26usYEfS-cfRRSwvcm5hg_akXr287oDXQ=A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 13:15:52 -0600
X-Gm-Features: AUfX_mwq5APFLUy8xCSjjW9imr5WfrgdHHmv4n_-b9sCmluk6AvcJXbzqFvFtck
Message-ID: <CAFLszTgqQtt-FMx7Rh3vVE_NLL8cKp5vveqmi4iNOKE2GwJt=Q@mail.gmail.com>
Subject: Re: [RFC] bootstd: firmware-owned OS devicetree for EBBR /
 SystemReady IR
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 baylibre-upstreaming@groups.io
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

Hi Carlo,

On Thu, 2 Jul 2026 at 08:27, Carlo Caione <ccaione@baylibre.com> wrote:
>
> On Thu, Jul 2, 2026 at 3:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> > For Mediatek specifically, I am hoping to eventually upstream support
> > for a load-only FIT (the spec supports it) so that you can load the DT
> > from a firmware partition, then still boot the OS (without a DT). This
> > works with FIT, but would need adjustment if the OS is actually an EFI
> > app.
> >
> > I wrote a post about this challenge:
> >
> > https://www-concept.deinde.dev/blog/devicetree-in-firmware-or-packaged-=
with-the-os/
>
> Well, this is convenient because your suggestion converges nicely with
> where this work has gone since I posted the RFC (I was ready to send
> out a V2 soon-ish).
>
> v2 of this design replaces the environment-described file set with a
> FIT manifest carried on the firmware partition itself: the FIT images
> hold the base DTB and the overlays, and each FIT configuration names
> one bootable combination through the standard 'fdt' property.
>
> Not exactly sure what you mean with =E2=80=9Cload-only=E2=80=9D but there=
 no kernel in
> it, the assembled devicetree is handed to the EFI app via the
> configuration table.
>
> v2 is implemented and validated on (my) hardware; I will post the
> updated RFC shortly. Some of your comments below are already addressed
> by it, noted inline.
>
> > > The *location* is described in the control devicetree. The bootstd no=
de carries
> > > a `firmware-fdt-source` phandle to a node that is a child of the medi=
a device
> > > that owns the partition, and identifies the partition by GPT type UUI=
D and/or
> > > name:
> > >
> > >         bootstd {
> > >                 compatible =3D "u-boot,boot-std";
> > >                 firmware-fdt-source =3D <&fw_fdt>;
> > >         };
> > >
> > >         &mmc0 {
> > >                 fw_fdt: firmware-fdt {
> > >                         compatible =3D "u-boot,firmware-fdt-block";
> >
> > Does the -block suffix indicate that it is a block device, rather than
> > a filesystem? How does this cope with the fast where multiple DTs are
> > provided for different models?
>
> The suffix names the backend: this one is a block device with a GPT
> partition holding a filesystem. It leaves room for sibling backends
> later, e.g. an UBI/MTD variant for NOR-based boards, which some
> MediaTek platforms would need. I will spell that out in the binding
> text.
>
> Multiple models are the manifest's job in v2: one FIT configuration
> per model/SKU, so the per-model knowledge lives with the devicetrees
> it describes and is updated atomically with them.
>
> > >                         partition-type-uuid =3D "....";   /* GPT type=
 UUID */
> > >                         partition-name =3D "firmware";    /* optional=
 */
> > >                         extra-size =3D <0x3000>;          /* overlay =
headroom */
> >
> > This seems like a parameter which would be better handled by U-Boot its=
elf?
>
> Yup, and it is gone in v2.
>
> > >   - the control DT describes the source and the partition policy;
> > >   - the board default environment carries factory defaults for the st=
atic values
> > >     (`fdtfile` and `dtb_path` for the base DTB, and the `fdt_addr_r` =
/
> > >     `fdtoverlay_addr_r` working addresses), so a from-source build bo=
ots and
> > >     `env default` restores a loadable configuration;
> >
> > I wish we could move away from filenames and use compatible strings
> > instead, as FIT does - this is how the FDT spec is written.
>
> v2 does this. 'fdtfile' and 'dtb_path' are gone leveraging
> FIT_BEST_MATCH. The only filename left is the manifest container
> itself (fdt.itb by default), which is a fixed convention (we can
> change it of course, I don't have a strong imagination).
>
> > > each installing the result through `efi_install_fdt()`. That is the c=
onvergence
> > > point all EFI launches pass through, so the firmware devicetree is in=
stalled
> > > regardless of how the EFI application was started, including the boot=
-manager
> > > autoboot path that SystemReady IR uses.
> >
> > What if you run GRUB?
>
> Not sure I 100% got this objection but it is not very special I guess,
> the firmware devicetree is installed into the EFI configuration table
> before the EFI app starts, GRUB does not touch it, and the kernel's
> EFI stub picks it up
> from the table (as long as GRUB does not install a different DTB at that =
point).

Just on this point, the question is really whether GRUB does not touch
it. My understand is that it actually loads the FDT from a file (Ilias
is the expert here) and that is why we have an EFI fix-up protocol to
send that loaded FDT back to U-Boot to be fixed up before booting.

>
> > >   5. Should the signed-FIT verification be part of this series or a f=
ollow-up?
> >
> > You likely get this for free, so I suggest including it.
>
> Indeed, since now the manifest is a FIT.
>
> I will post the v2 RFC as a follow-up to this thread.
>
> thanks for the review,
>

Regards,
Simon
