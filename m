Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD09BC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA7A87956;
	Wed, 27 Dec 2023 16:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uto4yITF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F813879AA; Wed, 27 Dec 2023 16:28:33 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B0487834
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d9bbf71bc8so537301b3a.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703690903; x=1704295703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bk3QrsrxvAV+1Kou3Ym3ygR6iKSFA4cPJdcoFqlj3D4=;
 b=Uto4yITFC7jsK9obwKdTRDk9NOGTtFkD8lKzzHeKCht1H81aFgEv1yTLGW0zty0fTy
 g7ngY1XNc88DVAd1YlEB6zVBHSd3VTNGYQcXzqVEqBzWmcDZ3t2NzXb9iROI2XyUUWIp
 ePwTdy5lzq4zeKRMuy6azy3NlJlYDKsTdBbpAAKaClGkz7nwg8AQJBGR9WbS38ou6BEB
 B9Ytg1JGNer7r80LGMZOQzE3Lwor8+DPazf2CdkA+5ItJGDYc4kdyfsfYcr2WB4H11S4
 MlgIRSqzYCzMDCHz2jFT5IM/bRUH2EElrMuSI2gv/F95PLc/YkiBzQNWB7Zd4sOlhm0H
 zKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703690903; x=1704295703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bk3QrsrxvAV+1Kou3Ym3ygR6iKSFA4cPJdcoFqlj3D4=;
 b=p/KR+62VcgLyyjHOqckzeCzxdijZJZqbmMJ3C4UT3DQ7Od20lRRyU07/qjm7ifo1G8
 KFBCQ0PrNvIMtSsdH/l5B6WEzdTItQ7Jm9uabwKLHASMlkEqWG4Gjz+EPlJE8V+LiVDg
 Ez1gvFC7xm+uCyqnsxt1NMeRsQENPWPbxzLoIqWe8Dlhi8dw7MAVMdn5qdS1F5m/6DX9
 ijFN2vfpKJZwfIwR2HuBPiUTshA2Ax4fst37BN7ugnDhNHgnsGx8vbjJHqmlUKQugKZo
 uvc1uH/1rjcK2fiL66hmzGJxd+Mh8vFIYRTEqIPBRPqfJCXXIifmERFhbh67DhqUkXoV
 QqvA==
X-Gm-Message-State: AOJu0YwDn5vB3Jrw18c/iSE1Kr8cbuodNu4h8I1j0LSn2QiIAapjxl2m
 DrbhwPso1u2sJ1sZuU53Uu4KJnRtHgNEWHqLkatMJfI19PqJ5g==
X-Google-Smtp-Source: AGHT+IE4xdmhdAWAbWW1Gf745IOeKviCjAj6jpyD2PgmAZY5vHHJsohn/6boz//45zUeqbVrxlsm4Nj13cWy0Hnt+/w=
X-Received: by 2002:a05:6a00:1404:b0:6d9:a9e9:28dd with SMTP id
 l4-20020a056a00140400b006d9a9e928ddmr2460645pfu.51.1703690903634; Wed, 27 Dec
 2023 07:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-2-raymond.mao@linaro.org>
 <CAC_iWjJ7AQ5_=yh-0FPcFOQ2-8XmZ24eT2WtWtQ8gmmEOiMuvg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ7AQ5_=yh-0FPcFOQ2-8XmZ24eT2WtWtQ8gmmEOiMuvg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:28:13 -0500
Message-ID: <CAEfUkUKFguiGZGQinGKBfxwcc+DfcVgH2Xo4a+zo_-84HCux9Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] bloblist: Update the tag numbering
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi Ilias,

On Wed, 27 Dec 2023 at 04:48, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

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
> >  } tag_name[] = {
> > -       { BLOBLISTT_NONE, "(none)" },
> > +       { BLOBLISTT_VOID, "(void)" },
> >
> >         /* BLOBLISTT_AREA_FIRMWARE_TOP */
> > +       { BLOBLISTT_CONTROL_FDT, "Control FDT" },
> > +       { BLOBLISTT_HOB_BLOCK, "HOB block" },
> > +       { BLOBLISTT_HOB_LIST, "HOB list" },
> > +       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> > +       { BLOBLISTT_TPM_EVLOG, "TPM event log defined by TCG EFI" },
> > +       { BLOBLISTT_TPM_CRB_BASE, "TPM Command Response Buffer address"
> },
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
> > -       BLOBLISTT_NONE = 0,
> > +       BLOBLISTT_VOID = 0,
> >
> >         /*
> >          * Standard area to allocate blobs used across firmware
> components, for
> > @@ -89,42 +89,36 @@ enum bloblist_tag_t {
> >          * projects.
> >          */
> >         BLOBLISTT_AREA_FIRMWARE_TOP = 0x1,
> > +       /*
> > +        * Devicetree for use by firmware. On some platforms this is
> passed to
> > +        * the OS also
> > +        */
> > +       BLOBLISTT_CONTROL_FDT = 1,
> > +       BLOBLISTT_HOB_BLOCK = 2,
> > +       BLOBLISTT_HOB_LIST = 3,
> > +       BLOBLISTT_ACPI_TABLES = 4,
> > +       BLOBLISTT_TPM_EVLOG = 5,
> > +       BLOBLISTT_TPM_CRB_BASE = 6,
> >
> >         /* Standard area to allocate blobs used across firmware
> components */
> > -       BLOBLISTT_AREA_FIRMWARE = 0x100,
> > +       BLOBLISTT_AREA_FIRMWARE = 0x10,
> > +       BLOBLISTT_TPM2_TCG_LOG = 0x10,  /* TPM v2 log space */
> > +       BLOBLISTT_TCPA_LOG = 0x11,      /* TPM log space */
> >         /*
> >          * Advanced Configuration and Power Interface Global Non-Volatile
> >          * Sleeping table. This forms part of the ACPI tables passed to
> Linux.
> >          */
> > -       BLOBLISTT_ACPI_GNVS = 0x100,
> > -       BLOBLISTT_INTEL_VBT = 0x101,    /* Intel Video-BIOS table */
> > -       BLOBLISTT_TPM2_TCG_LOG = 0x102, /* TPM v2 log space */
> > -       BLOBLISTT_TCPA_LOG = 0x103,     /* TPM log space */
> > -       BLOBLISTT_ACPI_TABLES = 0x104,  /* ACPI tables for x86 */
> > -       BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
> > -       BLOBLISTT_VBOOT_CTX = 0x106,    /* Chromium OS verified boot
> context */
> > +       BLOBLISTT_ACPI_GNVS = 0x12,
>
> Any idea if we have users that would be affected by this value change?
>
> BLOBLISTT_ACPI_TABLES, BLOBLISTT_TPM2_TCG_LOG and BLOBLISTT_ACPI_TABLES
are being used by x86.
BLOBLISTT_ACPI_GNVS is being used by x86 and chromebook.

Regards,
Raymond
