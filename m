Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE5CCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C14870B1;
	Thu, 19 Oct 2023 16:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DPMEMrAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B8978704A; Thu, 19 Oct 2023 16:01:19 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B318704A
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e2dc8fa02so12167272a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697724076; x=1698328876; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUzQ15YT4XEycIMAX9/qZZJprRdMVOa84x/tU6W8FBg=;
 b=DPMEMrAEcgxRxcxOFSsJ1F2rOs1lBPdZV9mGew443Tum3H6JBVJjthQ4XFeZQWinur
 pEGN4ooYfqqTKPtJ8wrPwoh+qRNcvi5U2tHD4bHuYnkMaRSUqMa+c291pKXoUaWvdX19
 i7gCnlu+oTyUHl03fukeRIrbWoS5c94fECg34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697724076; x=1698328876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUzQ15YT4XEycIMAX9/qZZJprRdMVOa84x/tU6W8FBg=;
 b=AUTDsbHu5y9EN7ReWc/HQZf4GRNS41izMV1Rt9hfz8Ak04z/FZ4pL5yZhHMJnd1zvU
 7mxGevxifYEe5C9gwhCde58+Vgs8jCmJ5iLnXwbTLJMvuv0lyqsJ+DH6sL7kuUdNr/4P
 SoBRDI3h/vPV0TX/A+2QJ8/fA5W3PhYHZ2kQEHQAWNSS1LZH5OS9v/pbhdbYoD7/ipq4
 H2leQ9Q450YeqltpsGnHwCvJMhncCbviklLOW0BN0oUPAM+l/RgtXU4ZvoBXFMDqdrf2
 bCJhzEkH5PD0cfvcil+VVW1t1szl/svhN5QuSEyN4f0jTFViE9b9x9DMP11tadn5saU/
 QJrQ==
X-Gm-Message-State: AOJu0Yz3KuNEHkg8H82dfV2KeEhnrFRTs1qrIO0Uelr7xBH9huu0DWTI
 zpNUPU4CIxfTy0przcXpe8pcWYWlzBXuaMO1yiVrP0eOl9bxaT4vYyc=
X-Google-Smtp-Source: AGHT+IFChkYkRhBFo0WfbKMJZ84hAyUSYJKbMeWURScGsMe0jeIVZqxVie7AguM+zYtOX/Bqc2zRTvgLutRq2IjT8qI=
X-Received: by 2002:a17:907:6d09:b0:9a2:26d8:f184 with SMTP id
 sa9-20020a1709076d0900b009a226d8f184mr1536041ejc.51.1697724075490; Thu, 19
 Oct 2023 07:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231018133709.GA3765642@bill-the-cat>
 <CAPnjgZ2qG7XgcbYyrpZaTef21MJA-B7SMm9jGMzk8G7M=mVv1w@mail.gmail.com>
 <CALeDE9MbMTCY-6eBeZ=a0es5MEDycAFWT710O81C_WYheBEVSQ@mail.gmail.com>
In-Reply-To: <CALeDE9MbMTCY-6eBeZ=a0es5MEDycAFWT710O81C_WYheBEVSQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Oct 2023 08:01:03 -0600
Message-ID: <CAPnjgZ33nozNaasFJgT2zu5RnJMkRTjiOfWL9054dPC4LSGPog@mail.gmail.com>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Peter,

On Thu, 19 Oct 2023 at 04:40, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Wed, Oct 18, 2023 at 4:29=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Tom,
> >
> > On Wed, 18 Oct 2023 at 07:37, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > >
> > > > Since efi_device_path.c calls eth_get_dev() and assumes that Ethern=
et is
> > > > available, add it as an explicit dependency.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v2)
> > > >
> > > > Changes in v2:
> > > > - Add new patch to update EFI_LOADER to depend on DM_ETH
> > > >
> > > >  lib/efi_loader/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index 13cad6342c36..fca4b3eef270 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > > >       depends on BLK
> > > > +     depends on DM_ETH
> > > >       depends on !EFI_APP
> > > >       default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
> > > >       select CHARSET
> > >
> > > I don't think this is needed.  After reconfiguring qemu_arm64 to be a=
ble
> > > to disable networking entirely, we still are able to build with
> > > EFI_LOADER enabled, and no warning / link errors.
> >
> > Fair enough.
> >
> > As of this patch the following errors are generated with -a ~CMDLINE :
> >
> > +lib/efi_loader/efi_device_path.c:985:(.text+0xca4): undefined
> > reference to `eth_get_dev'
> > +/bin/ld: lib/efi_loader/efi_device_path.c:987:(.text+0xca9):
> > undefined reference to `eth_get_dev'
> > +/bin/ld: lib/efi_loader/efi_device_path.c:993:(.text+0xcc9):
> > undefined reference to `eth_get_dev'
> > +/bin/ld: lib/efi_loader/efi_device_path.o: in function `efi_dp_from_na=
me':
> > +lib/efi_loader/efi_device_path.c:1095:(.text+0xe00): undefined
> > reference to `efi_get_image_parameters'
> >
> > which is why I added this patch. A later patch disables networking
> > entirely with ~CMDLINE so that is why this problem goes away.
> >
> > This series was basically built up by disabling CMDLINE and then
> > fixing the errors one by one. I didn't go back and check whether (at
> > the end) all the patches were needed.
>
> Was this just tested on sandbox? How do we know it's not going to
> regress a vast amount of actual devices?

This was tested with buildman to check for config changes. The purpose
of this series.is to get back to what worked a few years ago (CMDLINE
could be disabled). If you don't disable CMDLINE, then it doesn't
really change anything.

Perhaps we should add a build test for non-network EFI_LOADER if
people are going to use it? I don't see any boards that do:

$ ./tools/qconfig.py -f EFI_LOADER ~NET
0 matches

That is a great tool for checking what is used in the code base.

Regards,
Simon
