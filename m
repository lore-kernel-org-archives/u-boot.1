Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8077C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 17:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA1D879D9;
	Wed, 27 Dec 2023 18:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SGcMH1KW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E0A879C7; Wed, 27 Dec 2023 18:49:12 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD3B879D5
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 18:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-427f5cc49afso70031cf.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703699347; x=1704304147; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmwsU4BbXPpXPXtQt59h7lUAokVDuDigTBVtGbC1Umo=;
 b=SGcMH1KWHToFDEsebzzlW2jUsxi/TFN7ZPgcsrwFvL/FEL8mFrYPql3OCRR+1xzt+e
 wXQk7v8F+hRDLWtALvS13MZJvv/WgDcQ/YRSJfKxc1FeI/xzUalzWo3wmlw0RMO15Ri8
 XTmP0c4CMD2P4JUv941d8rUV4cAKBEoXnfsQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703699347; x=1704304147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmwsU4BbXPpXPXtQt59h7lUAokVDuDigTBVtGbC1Umo=;
 b=UYEv8BJ5C15lQcBbN8VXCPKBih09YAtPDLeTBOF1yarPkkVyMkn0o2PD8aK8N5eZVZ
 qXw4C859dea1HLpMQ2KtvIcASKOJ7uHnQw/UOQRuIlHLd2kHjB80V4cdvjzVNG/0kXZL
 WJ4HE+zt22vxTtpvGcKJO5j9o8DY6pR0q/4ifyWpSWc8jkTw3vXEFW68WFms8vC8/nbN
 TBpFczWutx2VqeQsi6/uvUZ6IBEJUW3GE7sHaDvnzPzL0FejJjA4jLquIw+xt9Qg1B6L
 4g0N9k2Rxenb/cjuYcEBz+dLRLk0zs78/HqG1FlNQiUozbfgHmxqNQ0gBlNxImA+uwq8
 MW7w==
X-Gm-Message-State: AOJu0YyRlog64hcs3sg+zWHvmAfo+PxevvYptgQ6i3PJubIzJvo+F8e0
 q5uiP12ogyzO0Ux4X4IcVtZn2xgO2owZIEuylfWKnEDLXtGU
X-Google-Smtp-Source: AGHT+IFgYU2mjKweKDQcYqBjtM9S9uwNryP/QFEL57KdbJH4euqYJnWF+X5g5QXXF2opUvdkJ7cC7zrFyWuUuHbI0ok=
X-Received: by 2002:a05:6214:e8d:b0:67a:a002:70e6 with SMTP id
 hf13-20020a0562140e8d00b0067aa00270e6mr17430181qvb.20.1703699347204; Wed, 27
 Dec 2023 09:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-2-raymond.mao@linaro.org>
 <CAC_iWjJ7AQ5_=yh-0FPcFOQ2-8XmZ24eT2WtWtQ8gmmEOiMuvg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ7AQ5_=yh-0FPcFOQ2-8XmZ24eT2WtWtQ8gmmEOiMuvg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 17:48:56 +0000
Message-ID: <CAFLszTh=AZOYz5Ky3WdLZ1SjsmK9MAoYseUUA5T+uMaknKSsyg@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] bloblist: Update the tag numbering
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi Ilias,

On Wed, Dec 27, 2023 at 9:48=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Raymond,
>
> On Mon, 18 Dec 2023 at 20:19, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Align bloblist tags with the FW handoff spec v0.9.
> > The most common ones are from 0.
> > TF related ones are from 0x100.
> > All non-standard ones from 0xfff000.
> >
> > Added new defined tags:
> > BLOBLISTT_OPTEE_PAGABLE_PART for TF.
> > BLOBLISTT_TPM_EVLOG and BLOBLISTT_TPM_CRB_BASE for TPM.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Align bloblist tags to FW handoff spec v0.9.
> > Changes in v3
> > - Add TPM related tags
> >
> >  common/bloblist.c  | 18 ++++++++++---
> >  include/bloblist.h | 67 +++++++++++++++++++++++++---------------------
> >  test/bloblist.c    |  4 +--
> >  3 files changed, 52 insertions(+), 37 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index a22f6c12b0..5606487f5b 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -36,16 +36,26 @@ static struct tag_name {
> >         enum bloblist_tag_t tag;
> >         const char *name;
> >  } tag_name[] =3D {
> > -       { BLOBLISTT_NONE, "(none)" },
> > +       { BLOBLISTT_VOID, "(void)" },
> >
> >         /* BLOBLISTT_AREA_FIRMWARE_TOP */
> > +       { BLOBLISTT_CONTROL_FDT, "Control FDT" },
> > +       { BLOBLISTT_HOB_BLOCK, "HOB block" },
> > +       { BLOBLISTT_HOB_LIST, "HOB list" },
> > +       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> > +       { BLOBLISTT_TPM_EVLOG, "TPM event log defined by TCG EFI" },
> > +       { BLOBLISTT_TPM_CRB_BASE, "TPM Command Response Buffer address"=
 },
> >
> >         /* BLOBLISTT_AREA_FIRMWARE */
> > -       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> > -       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> >         { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
> >         { BLOBLISTT_TCPA_LOG, "TPM log space" },
> > -       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> > +       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> > +
> > +       /* BLOBLISTT_AREA_TF */
> > +       { BLOBLISTT_OPTEE_PAGABLE_PART, "OP-TEE pagable part" },
> > +
> > +       /* BLOBLISTT_AREA_OTHER */
> > +       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> >         { BLOBLISTT_SMBIOS_TABLES, "SMBIOS tables for x86" },
> >         { BLOBLISTT_VBOOT_CTX, "Chrome OS vboot context" },
> >
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index 080cc46a12..92dbfda21b 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -81,7 +81,7 @@ enum {
> >
> >  /* Supported tags - add new ones to tag_name in bloblist.c */
> >  enum bloblist_tag_t {
> > -       BLOBLISTT_NONE =3D 0,
> > +       BLOBLISTT_VOID =3D 0,
> >
> >         /*
> >          * Standard area to allocate blobs used across firmware compone=
nts, for
> > @@ -89,42 +89,36 @@ enum bloblist_tag_t {
> >          * projects.
> >          */
> >         BLOBLISTT_AREA_FIRMWARE_TOP =3D 0x1,
> > +       /*
> > +        * Devicetree for use by firmware. On some platforms this is pa=
ssed to
> > +        * the OS also
> > +        */
> > +       BLOBLISTT_CONTROL_FDT =3D 1,
> > +       BLOBLISTT_HOB_BLOCK =3D 2,
> > +       BLOBLISTT_HOB_LIST =3D 3,
> > +       BLOBLISTT_ACPI_TABLES =3D 4,
> > +       BLOBLISTT_TPM_EVLOG =3D 5,
> > +       BLOBLISTT_TPM_CRB_BASE =3D 6,
> >
> >         /* Standard area to allocate blobs used across firmware compone=
nts */
> > -       BLOBLISTT_AREA_FIRMWARE =3D 0x100,
> > +       BLOBLISTT_AREA_FIRMWARE =3D 0x10,
> > +       BLOBLISTT_TPM2_TCG_LOG =3D 0x10,  /* TPM v2 log space */
> > +       BLOBLISTT_TCPA_LOG =3D 0x11,      /* TPM log space */
> >         /*
> >          * Advanced Configuration and Power Interface Global Non-Volati=
le
> >          * Sleeping table. This forms part of the ACPI tables passed to=
 Linux.
> >          */
> > -       BLOBLISTT_ACPI_GNVS =3D 0x100,
> > -       BLOBLISTT_INTEL_VBT =3D 0x101,    /* Intel Video-BIOS table */
> > -       BLOBLISTT_TPM2_TCG_LOG =3D 0x102, /* TPM v2 log space */
> > -       BLOBLISTT_TCPA_LOG =3D 0x103,     /* TPM log space */
> > -       BLOBLISTT_ACPI_TABLES =3D 0x104,  /* ACPI tables for x86 */
> > -       BLOBLISTT_SMBIOS_TABLES =3D 0x105, /* SMBIOS tables for x86 */
> > -       BLOBLISTT_VBOOT_CTX =3D 0x106,    /* Chromium OS verified boot =
context */
> > +       BLOBLISTT_ACPI_GNVS =3D 0x12,
>
> Any idea if we have users that would be affected by this value change?

I suppose it is possible, but bloblist has so far been intended for
internal U-Boot use, so perhaps not? In any case, there isn't much we
can do about it.

Regards,
Simon
