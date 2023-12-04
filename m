Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358BAC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 17:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66B7D87712;
	Mon,  4 Dec 2023 18:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EYB00vJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D52A5875BF; Mon,  4 Dec 2023 18:52:35 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B05087718
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 18:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50bffb64178so549468e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 09:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701712352; x=1702317152; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mfgsx4PJP+gtj1STNAHSpZCrcEmpIWu1APib8Q9Kt+w=;
 b=EYB00vJiGUKbMoCS6SmBN14w86vLeNgQ1saNxl2d/lET6u8BVPCunqfesW9UiEyVfk
 MLvyLwPSP6PWQhaxANVX1ty+PgTsJKKRcU1/QZeTACndcbZvzmZzM/qQI36vc/UpXh5f
 jrf/Avu/jO7zb6j0qCSA9C2+kW92vHAcSP9c9G4wlZFmQ46oG+mj8RYc3nxfez1l4WCl
 aovUS30vyLXQ2VCCCbXEktVf56QhmmDzTjBTezUCSDCfuNElyb18D+7aYmbFthXCvU7I
 gPXt2GKUMpC0H5DZ6UqW2mRz1hmkF37wwSI4g9/vnWfredHysaM1Sa4qZdUQZicsR8d4
 ek1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701712352; x=1702317152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mfgsx4PJP+gtj1STNAHSpZCrcEmpIWu1APib8Q9Kt+w=;
 b=nnWPZWe9lw6Ix/PGnKrej22kisc8vK9KKKsz6ubgGS22XAhQf919zFVlmUBAD+U2Xe
 hXgCPRTH+FBSxjf+2hlyO6sGW5HuSdYqqDz5Dr7LTSXLyf3mQrK3LQBNMT9QYM0fPH7b
 e1fMnS/qv+YumDzHEwxCi2I33Q90D+8OCxMgXMuJquV//ofOD/T8ps/IhPW7gALv3clh
 BJLm4fw+2pOl4nGkHNyRAhmOSHRn8TxVw2SqvjimQbmUqtis7yDTKapnKVD4hTvCNkbp
 o+gB7dtLaB/SAtaAEOcqrqzj2FDEP+d9x5aaMAx+dhRx465dGmRU+5oy55CslXwf5e6/
 uMNA==
X-Gm-Message-State: AOJu0YycJeIze1vJmcV+Thb7oMUVMiRVeEFo0LKcf/Fe148APj8LOjQn
 LLeQ/q8L3ocIstd+lAfGg1IWu5t2SvLfPXQbn7MqeA==
X-Google-Smtp-Source: AGHT+IGj/ncSXVn/KnAE2kQjVO0W4nJzPNTcOMu71ElH2h/hNEJMoGOk8Twua9UQU7F6G2LCnf1hcuDSloAuFWel7T0=
X-Received: by 2002:ac2:4a6a:0:b0:50b:eb55:11f2 with SMTP id
 q10-20020ac24a6a000000b0050beb5511f2mr1324849lfp.67.1701712352521; Mon, 04
 Dec 2023 09:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-2-raymond.mao@linaro.org>
 <CAC_iWjJ8qkOGVVqDa-_vg4x2W2rocb=ysQDPJhEgE0rOnwox6w@mail.gmail.com>
 <CAEfUkUK0nwVwKkh6E9fHu9oRRX67bQdzVTsLuWeB16vYkv+2Pg@mail.gmail.com>
In-Reply-To: <CAEfUkUK0nwVwKkh6E9fHu9oRRX67bQdzVTsLuWeB16vYkv+2Pg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Dec 2023 19:51:56 +0200
Message-ID: <CAC_iWjK_CBOccm_n4N7ZwYg-6=VFr_qOJ=kpuStOpBQCNE+cKA@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] bloblist: Update the tag numbering
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>, 
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 4 Dec 2023 at 18:25, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> BLOBLISTT_AREA_ARM is now holding the ones we already defined in the FW Handoff spec for TF-A project only.
> The TPM eventlog related ones are undefined in the spec yet, they stay in the group BLOBLISTT_AREA_FIRMWARE.

We did define them past 0.9 [0]. So I think we should add them regardless.
They are part of the main doc now [1]

[0] https://github.com/FirmwareHandoff/firmware_handoff/pull/16/files
[1] https://github.com/FirmwareHandoff/firmware_handoff/blob/main/source/transfer_list.rst#tpm-event-log-table-entry-layout-xferlist_evlog

Regards
/Ilias

>
> >  /* BLOBLISTT_AREA_FIRMWARE */
> >- { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> >- { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> >  { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
> >  { BLOBLISTT_TCPA_LOG, "TPM log space" },
> >- { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> >+ { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
>
> Thanks and regards,
> Raymond
>
> On Mon, 4 Dec 2023 at 03:25, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi all,
>>
>> [...]
>>
>> >  common/bloblist.c  | 16 +++++++++---
>> >  include/bloblist.h | 65 ++++++++++++++++++++++++----------------------
>> >  test/bloblist.c    |  4 +--
>> >  3 files changed, 48 insertions(+), 37 deletions(-)
>> >
>> > diff --git a/common/bloblist.c b/common/bloblist.c
>> > index a22f6c12b0..349ceddea5 100644
>> > --- a/common/bloblist.c
>> > +++ b/common/bloblist.c
>> > @@ -36,16 +36,24 @@ static struct tag_name {
>> >         enum bloblist_tag_t tag;
>> >         const char *name;
>> >  } tag_name[] = {
>> > -       { BLOBLISTT_NONE, "(none)" },
>> > +       { BLOBLISTT_VOID, "(void)" },
>> >
>> >         /* BLOBLISTT_AREA_FIRMWARE_TOP */
>> > +       { BLOBLISTT_CONTROL_FDT, "Control FDT" },
>> > +       { BLOBLISTT_HOB_BLOCK, "HOB block" },
>> > +       { BLOBLISTT_HOB_LIST, "HOB list" },
>> > +       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
>> >
>> >         /* BLOBLISTT_AREA_FIRMWARE */
>> > -       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
>> > -       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
>> >         { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
>> >         { BLOBLISTT_TCPA_LOG, "TPM log space" },
>> > -       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
>>
>> There are some TPM Eventlog related entries that are missing here.
>> Can we add them?
>>
>> > +       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
>> > +
>> > +       /* BLOBLISTT_AREA_ARM */
>> > +       { BLOBLISTT_OPTEE_PAGABLE_PART, "OP-TEE pagable part" },
>> > +
>> > +       /* BLOBLISTT_AREA_OTHER */
>> > +       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
>> [...]
>>
>> Thanks
>> /Ilias
