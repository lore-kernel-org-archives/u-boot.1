Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D94C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 18:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE34B87240;
	Wed,  6 Dec 2023 19:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ATNmt/IV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2F4875F5; Wed,  6 Dec 2023 19:39:58 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74AFE87227
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 19:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-286c01bff06so116139a91.1
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701887993; x=1702492793; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1y/6N4EtqgsQVBvhmFyXJ283TZc7xvh6/iitRUWe19U=;
 b=ATNmt/IVdtIuV+NM8iNU3SRZNoZ686t3fm36guu0IZS8N4F2o5L7AMsd93WZ9MMCEU
 dRzQB+ZfPrZubWOqp8ow4AoWpkioVOcRLqnhdy50+/iKHAmlF7EEnXdAM3fuqY5nXd+0
 BPQNn3pTfC9tNtIelp0/85KY8ck0/caENZ3qlFXqSz2PwnDCf6S8JfFqO1yTxgN/7vLq
 SNx/DvDoCVQPkDfLU4HYegJMZiYJGfWa5KJHqs8afLWcxTsyLsdfcPx91S4pFSRO9oPr
 R8YUsc3p7CAYu/WY3XrPN1pXngEfqlSsC7EvRlrcsRN2Mwe6h9kIWsAb6z5LMzDcGvgw
 dpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701887993; x=1702492793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1y/6N4EtqgsQVBvhmFyXJ283TZc7xvh6/iitRUWe19U=;
 b=OQ3MPmuwbFYpHLLRiALlsbdZaz5bSyA0UCoWIRheZt3A/EBibN5cPi9wswTedIUZ30
 AyDaULPkOawssWk4+5AQ+RIo/ggl2p5T3aoLRZPaAsx0CR8t9KWMWPvtNBKmA15A1Dwd
 KrmTOKASF8OQVsYm9RKda1dOIEQOOh0++03czeOEGHRfMXjdMjXXySChUN69JnCFnXJW
 qxWlkzkWZZ1eXhlWqkuuMt1Nxo6yLW+ugkBKtJ9CLpMiyu+R0Avkwe5HJhxES8Z7+UA5
 f+qmojwxTCyiaww5MdR+uw3ARFp+33wxmSIgPVnn+1uMKjgZkBoFB3o+HOTxpN5ubAV5
 4GsA==
X-Gm-Message-State: AOJu0Yzlv33iz84Ae6Gmlz3FijyqpEjO/S80L7lGchFyy+0IeF81ugyi
 Z4ngnYCaHRhNPu7Es9192hphpf7zdcJrGvTxQwpZsQ==
X-Google-Smtp-Source: AGHT+IFXCjC8SrFXv3HEH2VnouxihSHQIqXBd5/BL0/r5ntgOjpLpXfckDBG4oApdkgBNWuXCT0QjXihnCIxLbVJLQI=
X-Received: by 2002:a17:90a:fb43:b0:285:bc26:ffa6 with SMTP id
 iq3-20020a17090afb4300b00285bc26ffa6mr1090121pjb.25.1701887992636; Wed, 06
 Dec 2023 10:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-2-raymond.mao@linaro.org>
 <CAC_iWjJ8qkOGVVqDa-_vg4x2W2rocb=ysQDPJhEgE0rOnwox6w@mail.gmail.com>
 <CAEfUkUK0nwVwKkh6E9fHu9oRRX67bQdzVTsLuWeB16vYkv+2Pg@mail.gmail.com>
 <CAC_iWjK_CBOccm_n4N7ZwYg-6=VFr_qOJ=kpuStOpBQCNE+cKA@mail.gmail.com>
 <CAEfUkUJtmiPLVkvJ6Ambjwzz4Vj2aSbrt95_oBWVf0u6eaiwxw@mail.gmail.com>
 <CAC_iWjL7_QOB+bGDR32mNEXwinFy6oZeYmfx_sdaAgE7kd3t2Q@mail.gmail.com>
In-Reply-To: <CAC_iWjL7_QOB+bGDR32mNEXwinFy6oZeYmfx_sdaAgE7kd3t2Q@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 6 Dec 2023 13:39:42 -0500
Message-ID: <CAEfUkU+dxGmEDor=-LF9jTBACtBJWBM+hrnH9YWhpvTW9K3eCw@mail.gmail.com>
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

I will add both TPM_EVLOG and TPM_CRB_BASE.

Regards,
Raymond

On Wed, 6 Dec 2023 at 05:54, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Mon, 4 Dec 2023 at 20:55, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Ilias,
> >
> > What is the difference between the new added XFERLIST_EVLOG and the
> existing BLOBLISTT_TPM2_TCG_LOG and BLOBLISTT_TCPA_LOG in U-Boot?
> >
>
> I am not really sure what the existing options are supposed to mean.
> Having discrete options for v1 and v2 makes little sense since the
> EvenLog format already contains that info.
>
> The newly added options is supposed to
> - Hand you over an EventLog from a previous stage boot loader, so you
> can continue extending that instead of creating a new one. We do that
> already parsing for tpm_event_log_addr, which is what TF-A fills in.
> In the future we need to add the bloblist option.
> - Tell you whether you need to replay it or not.
>
> Thanks
> /Ilias
>
> > Thanks and regards,
> > Raymond
> >
> > On Mon, 4 Dec 2023 at 12:52, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >>
> >> On Mon, 4 Dec 2023 at 18:25, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> >> >
> >> > Hi Ilias,
> >> >
> >> > BLOBLISTT_AREA_ARM is now holding the ones we already defined in the
> FW Handoff spec for TF-A project only.
> >> > The TPM eventlog related ones are undefined in the spec yet, they
> stay in the group BLOBLISTT_AREA_FIRMWARE.
> >>
> >> We did define them past 0.9 [0]. So I think we should add them
> regardless.
> >> They are part of the main doc now [1]
> >>
> >> [0] https://github.com/FirmwareHandoff/firmware_handoff/pull/16/files
> >> [1]
> https://github.com/FirmwareHandoff/firmware_handoff/blob/main/source/transfer_list.rst#tpm-event-log-table-entry-layout-xferlist_evlog
> >>
> >> Regards
> >> /Ilias
> >>
> >> >
> >> > >  /* BLOBLISTT_AREA_FIRMWARE */
> >> > >- { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> >> > >- { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> >> > >  { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
> >> > >  { BLOBLISTT_TCPA_LOG, "TPM log space" },
> >> > >- { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> >> > >+ { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> >> >
> >> > Thanks and regards,
> >> > Raymond
> >> >
> >> > On Mon, 4 Dec 2023 at 03:25, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >> >>
> >> >> Hi all,
> >> >>
> >> >> [...]
> >> >>
> >> >> >  common/bloblist.c  | 16 +++++++++---
> >> >> >  include/bloblist.h | 65
> ++++++++++++++++++++++++----------------------
> >> >> >  test/bloblist.c    |  4 +--
> >> >> >  3 files changed, 48 insertions(+), 37 deletions(-)
> >> >> >
> >> >> > diff --git a/common/bloblist.c b/common/bloblist.c
> >> >> > index a22f6c12b0..349ceddea5 100644
> >> >> > --- a/common/bloblist.c
> >> >> > +++ b/common/bloblist.c
> >> >> > @@ -36,16 +36,24 @@ static struct tag_name {
> >> >> >         enum bloblist_tag_t tag;
> >> >> >         const char *name;
> >> >> >  } tag_name[] = {
> >> >> > -       { BLOBLISTT_NONE, "(none)" },
> >> >> > +       { BLOBLISTT_VOID, "(void)" },
> >> >> >
> >> >> >         /* BLOBLISTT_AREA_FIRMWARE_TOP */
> >> >> > +       { BLOBLISTT_CONTROL_FDT, "Control FDT" },
> >> >> > +       { BLOBLISTT_HOB_BLOCK, "HOB block" },
> >> >> > +       { BLOBLISTT_HOB_LIST, "HOB list" },
> >> >> > +       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> >> >> >
> >> >> >         /* BLOBLISTT_AREA_FIRMWARE */
> >> >> > -       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> >> >> > -       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> >> >> >         { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
> >> >> >         { BLOBLISTT_TCPA_LOG, "TPM log space" },
> >> >> > -       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> >> >>
> >> >> There are some TPM Eventlog related entries that are missing here.
> >> >> Can we add them?
> >> >>
> >> >> > +       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> >> >> > +
> >> >> > +       /* BLOBLISTT_AREA_ARM */
> >> >> > +       { BLOBLISTT_OPTEE_PAGABLE_PART, "OP-TEE pagable part" },
> >> >> > +
> >> >> > +       /* BLOBLISTT_AREA_OTHER */
> >> >> > +       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> >> >> [...]
> >> >>
> >> >> Thanks
> >> >> /Ilias
>
