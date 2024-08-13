Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A0AC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 13:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D336B8898A;
	Tue, 13 Aug 2024 15:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L3GhpQVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4870C8898A; Tue, 13 Aug 2024 15:02:45 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B104388842
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 15:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b7af49e815so32435286d6.0
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723554161; x=1724158961; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3GI+yONvmWqtXSYytFHgXf/dpWRXUrwp+RnFotGImZc=;
 b=L3GhpQVThiNASfjoGPlnEds+Ny0ktdxWONfGBDGjHYoZCz3liFFeayBAHhKmnOlwOk
 WPGbEDdn+OoOF2KeLkEpmZUtdTOzKWPtgM8xEB8srCr5AjoapjKUb7BF0CP+t8Bd/wb8
 EXuwAllzeldILYBEZ4rydaAet9rZ1MyJnHMIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723554161; x=1724158961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3GI+yONvmWqtXSYytFHgXf/dpWRXUrwp+RnFotGImZc=;
 b=V8cTPl8LVtgF36iKLfWqY46ef6REuyADwSDp4EWcMQp0xLuA6oNQUrlabwEDrS/I9I
 YuWLcbAUkEwbY736mebCJsew0DZ5ZssJ9+tyRDqYBFW3O6Bk2RSP6tWGq8NLU/vW2krL
 YMekvJt0/j6tBVOniOVN5rx8+RPSMW9Figd3fMed/nUeerxCyaal8zsCSNgd8MKlerUH
 w8YIBJRcASgsyJjqgTPaWiG72N/sv6zXhTM2AuauKYUc8GQbSTMGpjN4yrZOAji/Y7Fj
 +U1wbxeNaLhqAaBxJfopuNRjZcsiKkoxKQWUy6SbEdIMQ9d6mYIvW8Ts0j6b+vC46lnL
 DexA==
X-Gm-Message-State: AOJu0YwoIcG1xWpFV1whlx8OHx9czvwyEt6KI8xRKhdkcvEyXoNqHVss
 19iRsT46vDpZALMbEiQRUOtenlyenLTHA+O0k1TlhlbzXUA2aoC9dZLGwhvGJXml+WsHDBgqqC+
 WLKcD5qNx3Eipj3ULT2+p9KwYT2Z/pv42Yw1K
X-Google-Smtp-Source: AGHT+IGJX+DDtl7tT0GVoVgWWXc6nmpJSHzLI+rmW9W+1vQE0ALqy/UELvKuwGQlKLEwOt6BJQSXV3ZTOSnYYc564Ag=
X-Received: by 2002:a05:6214:5c43:b0:6bb:c25d:48f1 with SMTP id
 6a1803df08f44-6bf4f7fc22bmr38200286d6.33.1723554161541; Tue, 13 Aug 2024
 06:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-7-sjg@chromium.org>
 <4d3f9b1c-5be6-454d-8cd4-28bd67ded364@cherry.de>
 <CAFLszTj-szBqxPVi8CiWb2jDnKdcx128C8Xk7XUL0a2QoccWbA@mail.gmail.com>
 <c7483e63-f51d-4b8c-9340-acf75e1f04b8@cherry.de>
 <CAFLszTjjKkJdTE90AYJN1S05xsf3Bso_fDiQN-4UcQuJNR4aYA@mail.gmail.com>
 <6ac92261-8515-4884-8cf6-357e8356bb4b@cherry.de>
In-Reply-To: <6ac92261-8515-4884-8cf6-357e8356bb4b@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Aug 2024 07:02:30 -0600
Message-ID: <CAFLszTgZFFv0iZs8GebLhjWtRzrh2=tGZi7KMDsBv=2bYNCq4A@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] mmc: Use logging instead of pr_err()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Quentin,

On Tue, 13 Aug 2024 at 06:29, Quentin Schulz <quentin.schulz@cherry.de>
wrote:
>
> Hi Simon,
>
> On 8/13/24 2:16 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Mon, 12 Aug 2024 at 02:58, Quentin Schulz <quentin.schulz@cherry.de>
wrote:
> >>
> >> Hi Simon,
> >>
> >> On 8/11/24 4:50 PM, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Tue, 6 Aug 2024 at 08:10, Quentin Schulz <quentin.schulz@cherry.de>
wrote:
> >>>>
> >>>> Hi Simon,
> >>>>
> >>>> On 7/21/24 5:25 PM, Simon Glass wrote:
> >>>>> Use the log subsystem instead of dev, to avoid including function
names
> >>>>> in the code.
> >>>>>
> >>>>> The CONFIG_LOGF_FUNC option can be used to enable the function name.
> >>>>>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> >>>>> ---
> >>>>>
> >>>>> (no changes since v1)
> >>>>>
> >>>>>     drivers/mmc/mmc.c | 49
++++++++++++++++++++++++-----------------------
> >>>>>     1 file changed, 25 insertions(+), 24 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> >>>>> index b18dc331f78..b0105afe5d6 100644
> >>>>> --- a/drivers/mmc/mmc.c
> >>>>> +++ b/drivers/mmc/mmc.c
> >>>>> @@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int
timeout_ms)
> >>>>>
> >>>>>                 if (status & MMC_STATUS_MASK) {
> >>>>>     #if !defined(CONFIG_SPL_BUILD) ||
defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> >>>>> -                     pr_err("Status Error: 0x%08x\n", status);
> >>>>> +                     log_err("Status Error: %08x\n", status);
> >>>>
> >>>> Please don't remove the 0x prefix (will not comment on other patches
in
> >>>> this series if it happens again, please check :) ).
> >>>
> >>> OK...hex is the default though.
> >>>
> >>
> >> Can you please clarify what you meant by "it's the default though"?
> >
> > U-Boot uses hex by default, so anything printed out or entered is
> > normally in hex. There are a few exceptions, not all of them correct.
>
> Gotcha. This actually has been painful to me and I've made the mistake a
> few times already, e.g. writing 256 blocks instead of 100 (100 aka 0x100
> instead of base10 100). Are you aware whether this is made explicit in
> the docs somewhere? So I could refer to it if I ever need to explain
stuff?

I believe it was in the old Denx manual. I found it in a Digi one [2]:

Numbers used by U-Boot are always considered to be in hexadecimal format.
> For example, U-Boot
> understands number 30100000 as 0x30100000.


Perhaps we should add something like that to doc/usage?

>
> > I did send a series to allow decimal numbers but it has been deferred
> > for a while now[1].
> >
>
> Interesting :)
>
> Cheers,
> Quentin

[2] https://hub.digi.com/dp/path=/support/asset/u-boot-reference-manual/
