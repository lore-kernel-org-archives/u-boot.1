Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773C8CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC02086D25;
	Mon, 25 Sep 2023 16:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nc9Fe7cu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D949286D27; Mon, 25 Sep 2023 16:02:04 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62DCA86C67
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59f6041395dso39731637b3.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695650521; x=1696255321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PDMpxSKY/ymI4GKkFJJF0TvRMYgsYZaZ18JWkJsVifc=;
 b=Nc9Fe7cuFQdThF67FcDdUYSj03wR68NKdl3gcb6A1XWtUYpDQfbHaAPupmync07hS6
 JRI14hZ+zL8t9Y8Yhpl6MWHiDx+c+GwYqXGY9YmfYNWJbD6WS+AH+r+YKRA031lmx4g8
 0wMX56HeMhTu7hQh6J7QAabWI/hIDZ0rQRsRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695650521; x=1696255321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PDMpxSKY/ymI4GKkFJJF0TvRMYgsYZaZ18JWkJsVifc=;
 b=psHM+LDoJER9v7ptZ35qzXz3JvbW2XNJY9etzAxsweodymUoxoyGyCOxDoIJHhkMP/
 BhO/4oU5GMSJs737v8sJhm1diH7DWRBidzCl0l4bj+cuYNg4lPGyJIbk29XEq4x24QKa
 fCLP19Du8bXLaA4THbqSKaEUcoVV/dQyNirDC6lX4OWpe540Ke9/P4Q3yLnjCCYXG69J
 4bkB3QUEBEmOxJ+CJZ2cJ2SLVmt1AUYLGsjXyX3MdYa/YMJPMIXmZ64qvp4HpXv90e7R
 jvVY7kjpBX3RFn+hSFvq6qNczltUZT+zMK31pC2jZh/+5+wTR57NygM0UvKTkpQ+tcEO
 opvQ==
X-Gm-Message-State: AOJu0YyQ2Sbnz2W6Oeyy1BrnFwwIwQQF9LX9MLd46gVr8AIZzOnE2dYW
 ROYxjLZRqVcN69lNEa3EmCY3YxgXbdnbXTlBOvgbyUHqiv8DO4Wxfno=
X-Google-Smtp-Source: AGHT+IFvyImr94lpb7yN++wRCODPuHDtWVZ7p+wxC0wESVHP9rrKzWP1Ze0VPTzvR+LHyxH1SM1x6NK611H4LSXKo9Q=
X-Received: by 2002:a81:4ed1:0:b0:59c:a68:d36b with SMTP id
 c200-20020a814ed1000000b0059c0a68d36bmr7190961ywb.20.1695650520818; Mon, 25
 Sep 2023 07:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
 <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
 <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
In-Reply-To: <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 08:01:41 -0600
Message-ID: <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Tom Rini <trini@konsulko.com>
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

Hi Michal,

On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 9/25/23 15:10, Simon Glass wrote:
> > Hi Michal,
> >
> > On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >> Hi Simon,
> >>
> >>
> >> On 9/23/23 20:13, Simon Glass wrote:
> >>> Current alignment which is using 16 bytes is not correct in connection to
> >>> trace_clocks description and it's length.
> >>> That's why use start_addr variable and record proper size based on used
> >>> entries.
> >>>
> >>> Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
> >>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - s/start_addr/start_ofs/g'
> >>>
> >>>    tools/proftool.c | 31 +++++++++++++++++++++++++++++--
> >>>    1 file changed, 29 insertions(+), 2 deletions(-)
> >>>
> >>> Applied to u-boot-dm, thanks!
> >>
> >> FYI: I have merged it to my tree and already sent pull request to Tom.
> >> Without it I couldn't pass CI loop to get all reviewed features in.
> >>
> >> https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7d40c4f5@amd.com/
> >
> > Ah OK, well that's fine. It was in my patchwork queue still, which
> > suggests that the patches were not set to 'applied'?
>
> I am not using patchwork. But I expect my reply to cover letter was recorded there.

Probably. If you reply to each patch, it shows up in the patch, but
the cover letter is hidden somewhere else.

If you are not using patchwork, how come you are a custodian? Is
someone else dealing with patchwork for you?

Regards,
Simon
