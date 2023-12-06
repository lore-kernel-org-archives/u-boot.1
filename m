Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3515C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 10:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A21F870F4;
	Wed,  6 Dec 2023 11:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hufU5nXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B09B870F4; Wed,  6 Dec 2023 11:54:14 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E081E870DE
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 11:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ca02def690so43544921fa.3
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 02:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701860050; x=1702464850; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nKnEoRIHwfSsn6df1Tv69R/x0VMy/fw3inI2I48cUC8=;
 b=hufU5nXETVj+qqC8R0ioaYxoc752+agFVbYlcMCq5j4gsOBmVjiU/nNtJMrQT6rlKJ
 Zb2oydkfJTr9ii6EX+m3bG15lbNnTQfrquUKs2qJbPkgmld846ZdmpXIHowYHA8IE6SS
 IO3mw75NZcVYGjh+1RTHiEP6mUllJTMFfwlrGKPmFfRw5yGgFHgOwrx4hw0wAo8FhVeh
 4wF2nyBRtMixasa4YH72Gz+Twbd8fr8x3jr7dQe/5muekG9MXSk9Rfj8MDjmB06Yp09j
 ZwbeLL/jY3qbPqTExrTgeb6Gkt/s8YMluvhOj3v8SJS+cLbLDrYRCTeo03ZHYInZY2Pq
 iLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701860050; x=1702464850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nKnEoRIHwfSsn6df1Tv69R/x0VMy/fw3inI2I48cUC8=;
 b=KcBvn69GB/IF/hDMTBxAT5OpxxJqkp9rgzs/6h2uJCmqPMwvuyBgHjxv3RbkVx3JId
 D7tN5vfX/Txr9q6lmsbu38YDQbeH9HgEVC2LOLhvxvnKFx3+rj86BHIvW8c4F+ZzKQzR
 jROair9wySee1CZ2RpM+4IhMkOzemaxQJDFjFLfHQBS83cX7zDtukSE3UOsncYOPVd75
 o/ckEcgo+80ODERnZDqw8AxTSRzPIIQEl6HV80Mx2Aazf/EyuScWTgOD3hkcGiBoEfqf
 zJsHtXFxmo8lLNEPlMWjZoacYywAx/ZZHrltddiYxigtdTg6YEEx+N18MAigrI05g/m0
 nn+g==
X-Gm-Message-State: AOJu0YwvAEvTvqjr6auRGj79lqIb3QBqaaWI2dtwwqVDO0CyVywoi9OW
 WrFdiWwDpdMZCPDW7gTT+aB4hK8llrSN9m7Ut4QnlA==
X-Google-Smtp-Source: AGHT+IH/pWa6BKV+xGSX2joNIfbdtw+Ln69ybqJCDYdqS/0In2I2ovmuNFvzaykdWw5EBFDqifE0OVjBxR5cKPgiv/s=
X-Received: by 2002:a2e:b019:0:b0:2c9:e50f:710a with SMTP id
 y25-20020a2eb019000000b002c9e50f710amr445593ljk.82.1701860050195; Wed, 06 Dec
 2023 02:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-2-raymond.mao@linaro.org>
 <CAC_iWjJ8qkOGVVqDa-_vg4x2W2rocb=ysQDPJhEgE0rOnwox6w@mail.gmail.com>
 <CAEfUkUK0nwVwKkh6E9fHu9oRRX67bQdzVTsLuWeB16vYkv+2Pg@mail.gmail.com>
 <CAC_iWjK_CBOccm_n4N7ZwYg-6=VFr_qOJ=kpuStOpBQCNE+cKA@mail.gmail.com>
 <CAEfUkUJtmiPLVkvJ6Ambjwzz4Vj2aSbrt95_oBWVf0u6eaiwxw@mail.gmail.com>
In-Reply-To: <CAEfUkUJtmiPLVkvJ6Ambjwzz4Vj2aSbrt95_oBWVf0u6eaiwxw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Dec 2023 12:53:34 +0200
Message-ID: <CAC_iWjL7_QOB+bGDR32mNEXwinFy6oZeYmfx_sdaAgE7kd3t2Q@mail.gmail.com>
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

On Mon, 4 Dec 2023 at 20:55, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> What is the difference between the new added XFERLIST_EVLOG and the existing BLOBLISTT_TPM2_TCG_LOG and BLOBLISTT_TCPA_LOG in U-Boot?
>

I am not really sure what the existing options are supposed to mean.
Having discrete options for v1 and v2 makes little sense since the
EvenLog format already contains that info.

The newly added options is supposed to
- Hand you over an EventLog from a previous stage boot loader, so you
can continue extending that instead of creating a new one. We do that
already parsing for tpm_event_log_addr, which is what TF-A fills in.
In the future we need to add the bloblist option.
- Tell you whether you need to replay it or not.

Thanks
/Ilias

> Thanks and regards,
> Raymond
>
> On Mon, 4 Dec 2023 at 12:52, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> On Mon, 4 Dec 2023 at 18:25, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Hi Ilias,
>> >
>> > BLOBLISTT_AREA_ARM is now holding the ones we already defined in the FW Handoff spec for TF-A project only.
>> > The TPM eventlog related ones are undefined in the spec yet, they stay in the group BLOBLISTT_AREA_FIRMWARE.
>>
>> We did define them past 0.9 [0]. So I think we should add them regardless.
>> They are part of the main doc now [1]
>>
>> [0] https://github.com/FirmwareHandoff/firmware_handoff/pull/16/files
>> [1] https://github.com/FirmwareHandoff/firmware_handoff/blob/main/source/transfer_list.rst#tpm-event-log-table-entry-layout-xferlist_evlog
>>
>> Regards
>> /Ilias
>>
>> >
>> > >  /* BLOBLISTT_AREA_FIRMWARE */
>> > >- { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
>> > >- { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
>> > >  { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
>> > >  { BLOBLISTT_TCPA_LOG, "TPM log space" },
>> > >- { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
>> > >+ { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
>> >
>> > Thanks and regards,
>> > Raymond
>> >
>> > On Mon, 4 Dec 2023 at 03:25, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>> >>
>> >> Hi all,
>> >>
>> >> [...]
>> >>
>> >> >  common/bloblist.c  | 16 +++++++++---
>> >> >  include/bloblist.h | 65 ++++++++++++++++++++++++----------------------
>> >> >  test/bloblist.c    |  4 +--
>> >> >  3 files changed, 48 insertions(+), 37 deletions(-)
>> >> >
>> >> > diff --git a/common/bloblist.c b/common/bloblist.c
>> >> > index a22f6c12b0..349ceddea5 100644
>> >> > --- a/common/bloblist.c
>> >> > +++ b/common/bloblist.c
>> >> > @@ -36,16 +36,24 @@ static struct tag_name {
>> >> >         enum bloblist_tag_t tag;
>> >> >         const char *name;
>> >> >  } tag_name[] = {
>> >> > -       { BLOBLISTT_NONE, "(none)" },
>> >> > +       { BLOBLISTT_VOID, "(void)" },
>> >> >
>> >> >         /* BLOBLISTT_AREA_FIRMWARE_TOP */
>> >> > +       { BLOBLISTT_CONTROL_FDT, "Control FDT" },
>> >> > +       { BLOBLISTT_HOB_BLOCK, "HOB block" },
>> >> > +       { BLOBLISTT_HOB_LIST, "HOB list" },
>> >> > +       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
>> >> >
>> >> >         /* BLOBLISTT_AREA_FIRMWARE */
>> >> > -       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
>> >> > -       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
>> >> >         { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
>> >> >         { BLOBLISTT_TCPA_LOG, "TPM log space" },
>> >> > -       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
>> >>
>> >> There are some TPM Eventlog related entries that are missing here.
>> >> Can we add them?
>> >>
>> >> > +       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
>> >> > +
>> >> > +       /* BLOBLISTT_AREA_ARM */
>> >> > +       { BLOBLISTT_OPTEE_PAGABLE_PART, "OP-TEE pagable part" },
>> >> > +
>> >> > +       /* BLOBLISTT_AREA_OTHER */
>> >> > +       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
>> >> [...]
>> >>
>> >> Thanks
>> >> /Ilias
