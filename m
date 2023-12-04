Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F85C10DC1
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 18:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24C888772C;
	Mon,  4 Dec 2023 19:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iFhnrzIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F0DC87600; Mon,  4 Dec 2023 19:55:59 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FF2F8772C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 19:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6cde4aeea29so3238088b3a.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 10:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701716153; x=1702320953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6pO1qHgXNm0AYWyAuiov8koxhvYJMGjlKRb43eVgiv4=;
 b=iFhnrzIl8/fN7ERB1D+djesbW4VycP6XOj+23wvwfTtoXvWzpGU+k2MAyv47h2KjNu
 iP4Zg/qCgvIZRVclHPy+a87FRv+H43iwlfBmIXQadxoUaw+iILRyC/24n71CEQ953KOQ
 M92kcpQS0eL9HfrEwSyZVmIy+lW3JYRmaf0BWZ2xFsFb+kUZMP5itZ56jY6qEIVK7VzC
 wU0eFb7wOOClvZl8pRBnMe7SRAYSGPLyTrBkQyIvVgvF1ZzVYvgZEQnkGBQSwE5hHfNY
 OCiGwXHabumYwboa6t2Jr7FPBZBkFIutYBj81A5Uol3AWQZzEtb6hIlHh9xVnvv7OSjI
 LMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701716153; x=1702320953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6pO1qHgXNm0AYWyAuiov8koxhvYJMGjlKRb43eVgiv4=;
 b=MmNRzg9/AR65Ev7qRsy2mlt7N5tqpqdqU3GPmiqbPaW4eI3NQFWjyK27zgA1g7wIgw
 xQct5c0Ne+fE35zaXdB7bN4Vgehu2AXdfX2OhnaSbDSgCJQp80qcloQJl2lAjNP161pn
 yavPmPFgIed0HCRMaHuBosKMEer65ZtxMAi+NohsbFiH48En9H1tM48qAwIYtG5FUul3
 Jfh4WDzq3lomuHlIV0tbso4ix6hMnGpr3PfhIhurzPuRvnFD+ra5v86pocCDbm/sYFiT
 SavZaq8/0bpbVmqc3YrMrreQHC66/GeU5F2Q9iQKxmlNc6Y+M1c6+ei5RVf5s15zcejv
 ejlw==
X-Gm-Message-State: AOJu0Yw3Xjne+YrvClPoYxWXaMuBpmO++tZhauY9X+t36Js98t/9PBbW
 HrIQFurxe7+bn2ZsX3AS8+8CwIahHh+v92MvRoaruw==
X-Google-Smtp-Source: AGHT+IEay0jthwLg/BjR4Oa4vGL3JG9MXD9CEYun6wij8sca/TOD//TSoRqblus7h6702FILcsguOfgRzfiKN5KXV88=
X-Received: by 2002:a05:6a00:13a6:b0:6ce:50bf:45ef with SMTP id
 t38-20020a056a0013a600b006ce50bf45efmr11700pfg.43.1701716153433; Mon, 04 Dec
 2023 10:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-2-raymond.mao@linaro.org>
 <CAC_iWjJ8qkOGVVqDa-_vg4x2W2rocb=ysQDPJhEgE0rOnwox6w@mail.gmail.com>
 <CAEfUkUK0nwVwKkh6E9fHu9oRRX67bQdzVTsLuWeB16vYkv+2Pg@mail.gmail.com>
 <CAC_iWjK_CBOccm_n4N7ZwYg-6=VFr_qOJ=kpuStOpBQCNE+cKA@mail.gmail.com>
In-Reply-To: <CAC_iWjK_CBOccm_n4N7ZwYg-6=VFr_qOJ=kpuStOpBQCNE+cKA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 4 Dec 2023 13:55:43 -0500
Message-ID: <CAEfUkUJtmiPLVkvJ6Ambjwzz4Vj2aSbrt95_oBWVf0u6eaiwxw@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] bloblist: Update the tag numbering
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>, 
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
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

What is the difference between the new added XFERLIST_EVLOG and the
existing BLOBLISTT_TPM2_TCG_LOG and BLOBLISTT_TCPA_LOG in U-Boot?

Thanks and regards,
Raymond

On Mon, 4 Dec 2023 at 12:52, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Mon, 4 Dec 2023 at 18:25, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > BLOBLISTT_AREA_ARM is now holding the ones we already defined in the FW
> Handoff spec for TF-A project only.
> > The TPM eventlog related ones are undefined in the spec yet, they stay
> in the group BLOBLISTT_AREA_FIRMWARE.
>
> We did define them past 0.9 [0]. So I think we should add them regardless.
> They are part of the main doc now [1]
>
> [0] https://github.com/FirmwareHandoff/firmware_handoff/pull/16/files
> [1]
> https://github.com/FirmwareHandoff/firmware_handoff/blob/main/source/transfer_list.rst#tpm-event-log-table-entry-layout-xferlist_evlog
>
> Regards
> /Ilias
>
> >
> > >  /* BLOBLISTT_AREA_FIRMWARE */
> > >- { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> > >- { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> > >  { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
> > >  { BLOBLISTT_TCPA_LOG, "TPM log space" },
> > >- { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> > >+ { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> >
> > Thanks and regards,
> > Raymond
> >
> > On Mon, 4 Dec 2023 at 03:25, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi all,
> >>
> >> [...]
> >>
> >> >  common/bloblist.c  | 16 +++++++++---
> >> >  include/bloblist.h | 65
> ++++++++++++++++++++++++----------------------
> >> >  test/bloblist.c    |  4 +--
> >> >  3 files changed, 48 insertions(+), 37 deletions(-)
> >> >
> >> > diff --git a/common/bloblist.c b/common/bloblist.c
> >> > index a22f6c12b0..349ceddea5 100644
> >> > --- a/common/bloblist.c
> >> > +++ b/common/bloblist.c
> >> > @@ -36,16 +36,24 @@ static struct tag_name {
> >> >         enum bloblist_tag_t tag;
> >> >         const char *name;
> >> >  } tag_name[] = {
> >> > -       { BLOBLISTT_NONE, "(none)" },
> >> > +       { BLOBLISTT_VOID, "(void)" },
> >> >
> >> >         /* BLOBLISTT_AREA_FIRMWARE_TOP */
> >> > +       { BLOBLISTT_CONTROL_FDT, "Control FDT" },
> >> > +       { BLOBLISTT_HOB_BLOCK, "HOB block" },
> >> > +       { BLOBLISTT_HOB_LIST, "HOB list" },
> >> > +       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> >> >
> >> >         /* BLOBLISTT_AREA_FIRMWARE */
> >> > -       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> >> > -       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> >> >         { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
> >> >         { BLOBLISTT_TCPA_LOG, "TPM log space" },
> >> > -       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> >>
> >> There are some TPM Eventlog related entries that are missing here.
> >> Can we add them?
> >>
> >> > +       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> >> > +
> >> > +       /* BLOBLISTT_AREA_ARM */
> >> > +       { BLOBLISTT_OPTEE_PAGABLE_PART, "OP-TEE pagable part" },
> >> > +
> >> > +       /* BLOBLISTT_AREA_OTHER */
> >> > +       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> >> [...]
> >>
> >> Thanks
> >> /Ilias
>
