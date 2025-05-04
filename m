Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7B5C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 05:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351008214F;
	Sun,  4 May 2025 07:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cS1i1z2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8941B82163; Sun,  4 May 2025 07:34:18 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 635318210D
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 07:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C32EB3FFD4
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 05:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746336855;
 bh=q05Q4rfGt3ZloEtxOo4WLiXdXLuAhKd9W5lVZNF1Ffw=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=cS1i1z2Ot/bjbfhlF8Txccm60D6eMN/vyDpHczrlKvQkJLfAHeKzXD9e6dZ4yRfwK
 OXldQ6SndFGKJDilzHIE1M/UVRBYEqvmodfh8hsfR9KI4M1bMSF27glXX151XHQA7e
 uWDMFaEc7GZ9OZURVHdb3VgXy3q5RvaB2V9Hc3Eg5SOddM7bzdVFj0j6qsvns2b+mS
 u+rvoKy3KxUPJHqPqyeJgUvm7iKS/FfhqI5aba1Q0vDxFAIK0+xeBrqQ9C2zDS515X
 po1cuLaQ1opZ25W7PZPhQkQ8WDkmuhUuB65nmSNxJG+562teSfajNufri9mgrqHEJ6
 spmMMxdw1FIdw==
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b090c7c2c6aso1834390a12.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 22:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336854; x=1746941654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q05Q4rfGt3ZloEtxOo4WLiXdXLuAhKd9W5lVZNF1Ffw=;
 b=fzgWCI3aBC6i63kk9mAoEn2UOlWT5G9KQXsDnoH63qopX1LBioNh74gVG7SzvIB4Qq
 Ge7lXfE994ZJ1oyu4WyoWY5V7P+Lz+xY8M6v10fIonI13+Xng1iwBI5B+kQlBebbf6Hl
 yl8HUMHreR9b94hgJGrA9QiSz+wS6Sx1nAwQU+ma24VDaGyOlLOOv4WGEofmWopkdEls
 IR329WoZLpO//NYlVteva/pRnfB6K72pSqKz7rhyjBz/F+RlV78HFvCf4fp51RovUN3S
 ity0MSFBdelSX41suh9+s0M8U3yNVcbQ+D/DsOfTmvpE4nJfwLPX2LZgzUYvEZ3bYNm0
 JyBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9j9p9/w9gf4F7bkrCSmWhYD3rQYmAQ4DzLBtTo4y1qoS/grzwMHySaqiJpGDujL/w5kdO3Nc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2fwxJ3FvBdSPq04Wz/Wkk14mu1CFCmb4d9Bl/WTMC41TJt7Gx
 XzTpaQE3ntfDVPpfz8nbvhpAKXm0ygnrYv3rDiqADgcRnY/lmYHwLvy6ITMpTuKOctOocx3CKeQ
 kvaKPClcETmd3vD2XwKITalAyP33BHbxdMGDCaZCplz7QI6lL3iyxUYtLndQiy1l0oAXt1AJ2l5
 SRc5GcLivzGEcEUXQiGYssI6OcTJZ6LejmLYzFor32Ew==
X-Gm-Gg: ASbGnctQMDVoU5QdSBE6HPKihAKGelLnclp4YXc29Opa5Qxnrwd+nFaph7vIwi1XubT
 DMuz/6JR+gsY49fMB4FFGWxeWFaRU2aeYlFs+mnmnbaw0n6ilkzZxySq7cpxiZT9dEoBPy4mz2B
 TRlCYtbFBUXyHnwBl/bGBZn2lq
X-Received: by 2002:a17:90b:2dd1:b0:30a:4700:ca91 with SMTP id
 98e67ed59e1d1-30a61960c1cmr4247157a91.1.1746336854208; 
 Sat, 03 May 2025 22:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfKf320gxvg9vv8zxTZloqYgNaOvMfXA1L46xwiqim10rDDyx1VbLjPDZZ5hfsx6SvqbconTEuDeb7Att5tc0=
X-Received: by 2002:a17:90b:2dd1:b0:30a:4700:ca91 with SMTP id
 98e67ed59e1d1-30a61960c1cmr4247137a91.1.1746336853893; Sat, 03 May 2025
 22:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <CAFLszTg1Z7PArfxUUiyoNDsBj1N7Q23dn_xwhAJQ3pGikR0hzw@mail.gmail.com>
 <CAM=mAOmqSN7XOQonsOA6Q79T0MZRKpv3eObDCFMa_v4_3QzE6g@mail.gmail.com>
 <CAFLszTg9iecRkid=fp9FgPQjak93J0pLAt0+KYhd3sb+3CkKqw@mail.gmail.com>
In-Reply-To: <CAFLszTg9iecRkid=fp9FgPQjak93J0pLAt0+KYhd3sb+3CkKqw@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sun, 4 May 2025 07:34:03 +0200
X-Gm-Features: ATxdqUEllC8a6YnhsCwzDLNc7eFrQx6RFdxQaxQ3E4rE5FWeQ2xXUmdYfJC9sAY
Message-ID: <CAM=mAO=zRr1FoNX12sCsO=qcq1WHBjnGpqbokxcjBVG3g-tJVA@mail.gmail.com>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
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

Simon Glass <sjg@chromium.org> schrieb am Sa., 3. Mai 2025, 23:26:

> HI Heinrich,
>
> On Sat, 3 May 2025 at 01:04, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> >
> >
> > Simon Glass <sjg@chromium.org> schrieb am Sa., 3. Mai 2025, 04:10:
> >>
> >> Hi Heinrich,
> >>
> >> On Fri, 2 May 2025 at 10:09, Heinrich Schuchardt
> >> <heinrich.schuchardt@canonical.com> wrote:
> >> >
> >> > On 5/2/25 16:49, Simon Glass wrote:
> >> > > Hi Heinrich,
> >> > >
> >> > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> >> > > <heinrich.schuchardt@canonical.com> wrote:
> >> > >>
> >> > >> The EFI boot manager bootmeth does not require variable BootOrder
> to be
> >> > >> preexisting. It creates this variable.
> >> > >>
> >> > >> Signed-off-by: Heinrich Schuchardt <
> heinrich.schuchardt@canonical.com>
> >> > >> ---
> >> > >>   boot/bootmeth_efi_mgr.c | 21 +++------------------
> >> > >>   1 file changed, 3 insertions(+), 18 deletions(-)
> >> > >>
> >> > >> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> >> > >> index 42b8863815e..1669cbed5bd 100644
> >> > >> --- a/boot/bootmeth_efi_mgr.c
> >> > >> +++ b/boot/bootmeth_efi_mgr.c
> >> > >> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev,
> struct bootflow_iter *iter)
> >> > >>
> >> > >>   static int efi_mgr_read_bootflow(struct udevice *dev, struct
> bootflow *bflow)
> >> > >>   {
> >> > >> -       struct efi_mgr_priv *priv = dev_get_priv(dev);
> >> > >> -       efi_status_t ret;
> >> > >> -       efi_uintn_t size;
> >> > >> -       u16 *bootorder;
> >> > >> -
> >> > >> -       if (priv->fake_dev) {
> >> > >> -               bflow->state = BOOTFLOWST_READY;
> >> > >> -               return 0;
> >> > >> -       }
> >> > >> +       int ret
> >> > >>
> >> > >>          ret = efi_init_obj_list();
> >> > >>          if (ret)
> >> > >>                  return log_msg_ret("init", ret);
> >> > >>
> >> > >> -       /* Enable this method if the "BootOrder" UEFI exists. */
> >> > >> -       bootorder = efi_get_var(u"BootOrder",
> &efi_global_variable_guid,
> >> > >> -                               &size);
> >> > >> -       if (bootorder) {
> >> > >> -               free(bootorder);
> >> > >> -               bflow->state = BOOTFLOWST_READY;
> >> > >> -               return 0;
> >> > >> -       }
> >> > >> +       bflow->state = BOOTFLOWST_READY;
> >> > >>
> >> > >> -       return -EINVAL;
> >> > >> +       return 0;
> >> > >>   }
> >> > >>
> >> > >>   static int efi_mgr_read_file(struct udevice *dev, struct
> bootflow *bflow,
> >> > >> --
> >> > >> 2.48.1
> >> > >>
> >> > >
> >> > > How do we know if the board is using EFI bootmgr? My understanding
> was
> >> > > that this was a way to find out?
> >> >
> >> > The boot manager must always run.
> >>
> >> Are you sure that is true? It seems false to me, e.g.
> >>
> >> - if we are booting FEL on suxi, it must not run.
> >> - none of the boards in my lab use it
> >> - the Ubuntu 24.04 test in my lab doesn't use it
> >>
> >> So how can we say that it must always run?
> >
> >
> > If a boot method that is earlier in the sequence boots the boot manager
> will not be reached. But the existence of BootOrder or any other EFI
> variable shall not decide if the boot manager runs or not.
>
> So is there *any* way to know whether it should run or not? Should we
> use the Kconfig to control it?


We already have a Kconfig variable for the bootmeth. If that is chosen and
FEL, script, extlinux fail the boot manager should run.

It feels like disappearing into the
> abyss when we run bootmgr, at present.


All boot methods may fail to find anything to boot. The EFI boot manager is
not special in that regard.

Best regards

Heinrich

I'm wondering if we can improve
> this.
>
> Regards,
> Simon
>
