Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC306C3ABB9
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 22:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D0C8007D;
	Tue,  6 May 2025 00:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Bb7+5kx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 885018007D; Tue,  6 May 2025 00:07:37 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0909C8004F
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 00:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B0DA03F138
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 22:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746482853;
 bh=b8Mm4rTiOEp1Eq9dk6X8cnNwxRufMoBrjZmjR2ViLu0=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=Bb7+5kx0PDaBFenHyd3lDIZblEMFcC4qwdXFArMLgaU7M2f/zmEzHZ81WiLlXtbVL
 YjWdnxELbCBe3RaWucYX+8OK5B4CYoDdeDiwJZQcCUvIdgoTmNEAhaDVs9+2ulJDCb
 ZS6C42Dfa70806pnqgnoHJB3NssSAN1st1OBdCht7PncjWoSBPkadvpKiISaAORGLB
 OcWb4SkLws41pom7CQ5zAkCLM0yeJl+RFXe60Kbg/mxpxDEsTsefSSSMbP5avjqKT8
 5J4giDpy6h15ClJuA4dms84HbQzA+jtwPWWr3vtn+541w1z/9HAJQi+j+7Z7gvw+YR
 L+mcF6VuJqGyg==
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30a7cc8c52eso253703a91.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 15:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746482852; x=1747087652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b8Mm4rTiOEp1Eq9dk6X8cnNwxRufMoBrjZmjR2ViLu0=;
 b=T9ZB2t76EqeCVpuU1zevEKkN34w/PFinAGevmqDi/BU0fQi1dYOshIGqnNwqRlpXeb
 KWDWut3jiF0GIFvfSYLdkNWRBGVYD4vovyWOBrA3OG7ePSzqKT/Snd9xyVg/NkgFq4G0
 jmM+t4L96LWngTsr/o2seTFL9gCNvAQ16qryNhbeSRbQljS0nipUX+Jji6sHM4YVII5N
 2wJ6Ie9wpF3aQdPMz2bDThQH1xiD57zEq+F0j82LZVc5061RGvO1OBVcc/IUiJ3REHBu
 BCIZZ6cbrOpnmB+fNvgNb9zKjPS5pdqdZ07/R7bFN327TskY1HoDaKg8uuVIsI76mx01
 PDHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQfTSne45hDW6jIUSzPskxyqsde2cP+i61+eaSrNhu79XGcoQQpOJ0ca6ImxH9gnpXe+O2zDo=@lists.denx.de
X-Gm-Message-State: AOJu0YxSnZcgtTsBtzhPZSl5cIA72RAeUUNwExkx6LasHDXAAGUnvind
 4NNt2b8OThxO7bU/IdieHRfaMy8EQhgfUZwUYTdttSaDczYEtwwqMuKkiX33dQa2pJGzimksLx1
 LPOB8SEmviGaauiblT+zLJwSSoCopqqBd7YNX9UR9iIlM/ZSv4ghbtQ0ptS9YdwxN67ANzEQhl1
 fXTYbBbiKMWuYuBPDhzkWBWBdXqklTLcG2ItHJPPjDb4weTSupxw==
X-Gm-Gg: ASbGncugtEsl1DXWe+0hwoG+VfUAg6Txc2/dv1R0yLPdNrB+gOYP1GniZYBhH/PwqQ4
 nqa/p5CfxgX4N2NkTS3pm8bfCvtyAyySSHCyzJMBJYwB16t5Xzk/yu0bMC+0OVuxZqaT5Ng==
X-Received: by 2002:a17:90b:1f86:b0:2ff:64a0:4a58 with SMTP id
 98e67ed59e1d1-30a7f7052f2mr603599a91.22.1746482852048; 
 Mon, 05 May 2025 15:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIVSv9yZGXWTdXMpWd4F4Lt9T7FzGINMxwrYj5Pzfl1pO50qyyv/wzQQUDkmfuNOEw5pQiSDofaq+0hGFM258=
X-Received: by 2002:a17:90b:1f86:b0:2ff:64a0:4a58 with SMTP id
 98e67ed59e1d1-30a7f7052f2mr603578a91.22.1746482851701; Mon, 05 May 2025
 15:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <875xieanhm.fsf@bloch.sibelius.xs4all.nl>
 <CAM=mAOnFrM_wa5SSWYWROoY+839L87A0cSx8-X=Hr=cHB9y3Tw@mail.gmail.com>
 <20250505195452.GK5430@bill-the-cat>
In-Reply-To: <20250505195452.GK5430@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Tue, 6 May 2025 00:07:20 +0200
X-Gm-Features: ATxdqUGS-V1PEvYkMxuckD25EziJYJQbulZyDF3_YS3DgdSj5NTEUno3GAyKOAI
Message-ID: <CAM=mAOkXoXZm8Bag3SN0DYD0NG_UeYub_vkhnF6X5ODurbrttw@mail.gmail.com>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Tom Rini <trini@konsulko.com> schrieb am Mo., 5. Mai 2025, 21:54:

> On Mon, May 05, 2025 at 09:51:52PM +0200, Heinrich Schuchardt wrote:
> > Mark Kettenis <mark.kettenis@xs4all.nl> schrieb am Mo., 5. Mai 2025,
> 21:03:
> >
> > > > Date: Fri, 2 May 2025 18:08:56 +0200
> > > > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > >
> > > > On 5/2/25 16:49, Simon Glass wrote:
> > > > > Hi Heinrich,
> > > > >
> > > > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > >>
> > > > >> The EFI boot manager bootmeth does not require variable BootOrder
> to
> > > be
> > > > >> preexisting. It creates this variable.
> > > > >>
> > > > >> Signed-off-by: Heinrich Schuchardt <
> heinrich.schuchardt@canonical.com
> > > >
> > > > >> ---
> > > > >>   boot/bootmeth_efi_mgr.c | 21 +++------------------
> > > > >>   1 file changed, 3 insertions(+), 18 deletions(-)
> > > > >>
> > > > >> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > >> index 42b8863815e..1669cbed5bd 100644
> > > > >> --- a/boot/bootmeth_efi_mgr.c
> > > > >> +++ b/boot/bootmeth_efi_mgr.c
> > > > >> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev,
> > > struct bootflow_iter *iter)
> > > > >>
> > > > >>   static int efi_mgr_read_bootflow(struct udevice *dev, struct
> > > bootflow *bflow)
> > > > >>   {
> > > > >> -       struct efi_mgr_priv *priv = dev_get_priv(dev);
> > > > >> -       efi_status_t ret;
> > > > >> -       efi_uintn_t size;
> > > > >> -       u16 *bootorder;
> > > > >> -
> > > > >> -       if (priv->fake_dev) {
> > > > >> -               bflow->state = BOOTFLOWST_READY;
> > > > >> -               return 0;
> > > > >> -       }
> > > > >> +       int ret
> > > > >>
> > > > >>          ret = efi_init_obj_list();
> > > > >>          if (ret)
> > > > >>                  return log_msg_ret("init", ret);
> > > > >>
> > > > >> -       /* Enable this method if the "BootOrder" UEFI exists. */
> > > > >> -       bootorder = efi_get_var(u"BootOrder",
> > > &efi_global_variable_guid,
> > > > >> -                               &size);
> > > > >> -       if (bootorder) {
> > > > >> -               free(bootorder);
> > > > >> -               bflow->state = BOOTFLOWST_READY;
> > > > >> -               return 0;
> > > > >> -       }
> > > > >> +       bflow->state = BOOTFLOWST_READY;
> > > > >>
> > > > >> -       return -EINVAL;
> > > > >> +       return 0;
> > > > >>   }
> > > > >>
> > > > >>   static int efi_mgr_read_file(struct udevice *dev, struct
> bootflow
> > > *bflow,
> > > > >> --
> > > > >> 2.48.1
> > > > >>
> > > > >
> > > > > How do we know if the board is using EFI bootmgr? My understanding
> was
> > > > > that this was a way to find out?
> > > >
> > > > The boot manager must always run.
> > > >
> > > > The check for the BootOrder variable introduced in commit
> f2bfa0cb1794
> > > > is a bug.
> > >
> > > Well, at the time the boot manager did not attempt to boot the default
> > > path.  So there was no point in running the boot manager code unless
> > > BootOrder (or BootNext) was set.  And of course before that commit the
> > > boot manager didn't run at all on non-sandbox builds that had the
> > > standard boot stuff enebaled.
> > >
> > > Anyway, I believe the thinking behind that commit is still sound.  As
> > > I explained earlier, I think that...
> > >
> > > > The boot manager handles in sequence:
> > > >
> > > > * Try to boot as indicated by BootNext.
> > > > * Try to boot as indicated by BootOrder.
> > > > * Try to boot default path for available media.
> > > >    This will add Boot#### entries and update BootOrder.
> > >
> > > ...doing this all in a monolithic sequence isn't the best way to
> > > handle EFI boot in the u-boot ecosystem.
> > >
> > > Your series moves the boot manager further down the list because the
> > > third step in the sequence has to happen late.  But as a result
> > > BootNext and BootOrder processing will also happen late.  So what
> > > happens if you have a board with two OS installations:
> > >
> > > 1. A generic Linux distro that boots via EFI.
> > >
> > > 2. Something like Armbian that provides an extlinux.conf file.
> > >
> > > Currently such a system will probably boot OS #1.  But after your
> > >
> >
> > This did not happen with distoboot. So migration from distroboot to
> > standard boot results in a change that you want to avoid.
> >
> > changes it will probably boot OS #2.  And if OS #1 sets BootOrder or
> > > BootNext that will not change anything.
> > >
> > > So I think we need a solution where BootNext and BootOrder processing
> > > happens early, like we do now.
> > >
> >
> > As of today BootNext does not invoke the boot manager.
> >
> > If BootOrder is set the boot manager may fail because not all devices are
> > detected as "hunters" have not been running. E.g. nvme scan and usb start
> > are only invoked after the EFI boot manager.
> >
> > I originally suggested to probe all boot devices before the boot manager
> > runs, but users complained that this slows down their non-EFI boot flows.
> > This is why I now move it after all boot methods but PXE.
>
> Can we not see what BootOrder is and then ensure it's been "hunted" ?
>
> --
> Tom
>

A load option may only contain the partition GUID and the file path. In
this case you wouldn't be able to tell whether it is for an NVMe drive, or
a USB stick.

As numbering of devices cannot be expected to be stable, it is preferable
to use this short form of device paths for load options.

Best regards

Heinrich

>
