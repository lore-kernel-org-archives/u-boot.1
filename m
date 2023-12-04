Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D966C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 16:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 827A9875BF;
	Mon,  4 Dec 2023 17:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ht3hsXHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C476876DA; Mon,  4 Dec 2023 17:25:26 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DCDE875BF
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 17:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cfc2bcffc7so19118195ad.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 08:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701707122; x=1702311922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/YDNA1HrEWv/6nyfhEesPCBgf3ZxWXu/gk1o1/U/fw4=;
 b=ht3hsXHMmQcRQypirJ7uBhkooZcwvvzuy9k6J5RkwdVYZkvTf5LxOmktcsKNJSTR1B
 dqgctk9suJPTBFwRjDfDBDQT4JUdc3EKK1Esv7+6ojoxZXshrcnle1zR/Yq6IiZhCW6F
 cb5KFb3OsuDC+K0BITAgWPWSpTVz8m7v3pLBH2f+s1zZLZwVkZbWtdyVSKkwttFS3rqq
 0xUdPqdIOyCajpMzKK9//5+CsHujSGfJ0UySfIkWObY9kS9LCwuXzyXd/yKaUws9Qra8
 +xOh9hBeBJL2Z8fb8yNq0I5XZu58KAlCyLW5m6fys3mT4QUUwBerLg+0X5C+HCCYDk59
 Mdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701707122; x=1702311922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/YDNA1HrEWv/6nyfhEesPCBgf3ZxWXu/gk1o1/U/fw4=;
 b=Yqv9sliREENSLCiARPR/jIfsZ20z+AN+ggRcEFE6xvzeqHTMZm8pF8Zk6g8glDaefm
 JYoGceD8lKbCIaCA2QZO5b9pNlON4DItlR3ifx9mP7245QyfyE3gq/d/oZqXip0A+/v0
 NIpWE1BEz2IzHLiSnFJXZAgWi9r31I2KG1oUBMqll1NQrG3lU6jp9LzmPBk92isRixX4
 xK5sjuiS8HoQy4MtVzlJuQjm13WER1zt1/nw1eY1w8sswvfwt2LUpSv0YraFcst8gfCl
 XFVSWAzulEbRhzBqm2bI0fL1GamIL+pv/ZBmY+UopEJuRxOviZtWMnRUP3dwQVCfi4hb
 ehCQ==
X-Gm-Message-State: AOJu0YyJ5EXedPXYoWFMtRr4HK29GxmeaT43eu0BDJtmzIwabEyY1T/k
 HMa887J8169qhKWJPvvgeB0AqPF5ZG0hYLCAo47Ahw==
X-Google-Smtp-Source: AGHT+IEr9Pj770EbOAPGYxE6iYhsa3grih5HTmU1e1ubJYFv/NohyDgdi6EjVs0RJaZrQxhghVurBrxbONmLJ5feSqo=
X-Received: by 2002:a17:90a:c385:b0:285:a426:5913 with SMTP id
 h5-20020a17090ac38500b00285a4265913mr2046834pjt.41.1701707121779; Mon, 04 Dec
 2023 08:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-2-raymond.mao@linaro.org>
 <CAC_iWjJ8qkOGVVqDa-_vg4x2W2rocb=ysQDPJhEgE0rOnwox6w@mail.gmail.com>
In-Reply-To: <CAC_iWjJ8qkOGVVqDa-_vg4x2W2rocb=ysQDPJhEgE0rOnwox6w@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 4 Dec 2023 11:25:11 -0500
Message-ID: <CAEfUkUK0nwVwKkh6E9fHu9oRRX67bQdzVTsLuWeB16vYkv+2Pg@mail.gmail.com>
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

BLOBLISTT_AREA_ARM is now holding the ones we already defined in the FW
Handoff spec for TF-A project only.
The TPM eventlog related ones are undefined in the spec yet, they stay in
the group BLOBLISTT_AREA_FIRMWARE.

>  /* BLOBLISTT_AREA_FIRMWARE */
>- { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
>- { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
>  { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
>  { BLOBLISTT_TCPA_LOG, "TPM log space" },
>- { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
>+ { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },

Thanks and regards,
Raymond

On Mon, 4 Dec 2023 at 03:25, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi all,
>
> [...]
>
> >  common/bloblist.c  | 16 +++++++++---
> >  include/bloblist.h | 65 ++++++++++++++++++++++++----------------------
> >  test/bloblist.c    |  4 +--
> >  3 files changed, 48 insertions(+), 37 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index a22f6c12b0..349ceddea5 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -36,16 +36,24 @@ static struct tag_name {
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
> >
> >         /* BLOBLISTT_AREA_FIRMWARE */
> > -       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> > -       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> >         { BLOBLISTT_TPM2_TCG_LOG, "TPM v2 log space" },
> >         { BLOBLISTT_TCPA_LOG, "TPM log space" },
> > -       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
>
> There are some TPM Eventlog related entries that are missing here.
> Can we add them?
>
> > +       { BLOBLISTT_ACPI_GNVS, "ACPI GNVS" },
> > +
> > +       /* BLOBLISTT_AREA_ARM */
> > +       { BLOBLISTT_OPTEE_PAGABLE_PART, "OP-TEE pagable part" },
> > +
> > +       /* BLOBLISTT_AREA_OTHER */
> > +       { BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
> [...]
>
> Thanks
> /Ilias
>
