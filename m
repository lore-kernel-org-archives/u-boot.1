Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0F9C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F284E889BB;
	Tue, 13 Aug 2024 14:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OKtwigZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A292889A1; Tue, 13 Aug 2024 14:17:12 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E110A8899C
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b7a0ef0dfcso29345386d6.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723551429; x=1724156229; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4kuMFSm9xS/oBqervNMIVC3l8kkO6SpZLFlCGlqYts=;
 b=OKtwigZ/SAG3YX9JDBJo8UQT6CLSTj9Aqz8oInvJ9311MVLreegBTCypZB6jj3r6Hx
 2ihrD7orDWMH19y07OGNuhWL8t+MI5V3vvhXQOTgsVgntqRZ3CMoJvRs77rAloAtuy82
 vjftszbRjAcoK6En0/sewSn1SbMHVI622uTew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551429; x=1724156229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4kuMFSm9xS/oBqervNMIVC3l8kkO6SpZLFlCGlqYts=;
 b=xVoKskPirff8IlYHqMh+T1B+CKk9RA0udgbcBWzLmrPLO9QnzQWAvd5ICAZVHNvnlJ
 8HJ5zqJPuSCtzqm5qWvj8tNJXyGXVhbdrEEzRZhYZlqJk/4b8VJ7szc4T6P1ES7J4PtB
 O8nLF6imPVVv60CE9PQKZt8a3JF6U0suk23AOq4j8NnyvEjNe6j/7nrviN6vUxskwa6q
 c87vtCg48Z0p6Vgs4yS1HgkF2qlzMA3qWss2DfHRLGBhRvuoea5znBtXyJ7QCCkc3SVg
 P18OJTpK1RweT1LG+37syAiAtFF4UHPrKEYrzCQSsvaTF9WnYCK5l/NH++DqpT4OODJy
 VyYQ==
X-Gm-Message-State: AOJu0YzKG5rhz5YnvPeXdWYDAxkz11X6m8U41iCYKqLwlkQRMnX9VYTA
 XqitUZE7rdaFhM/emM2jfUki4Adt3kA+anFHt23u/nbIk4hUWpIxnuWjt2VDxUvomjYdnas3TtX
 g9JE5WyrpW05tkeRbfmyHnS0jpgcTTEEllAWU
X-Google-Smtp-Source: AGHT+IGuv5Pgy4j4WjjfaePo5xsYL/sVx/9+VL6OCbJeKty561HT6d8KXFlLEpYVLMrQnTAjZsTkwVW9o29/vlu40u4=
X-Received: by 2002:a05:6214:5783:b0:6b5:50:4427 with SMTP id
 6a1803df08f44-6bf4f66c4f0mr40499686d6.12.1723551428673; Tue, 13 Aug 2024
 05:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-7-sjg@chromium.org>
 <4d3f9b1c-5be6-454d-8cd4-28bd67ded364@cherry.de>
 <CAFLszTj-szBqxPVi8CiWb2jDnKdcx128C8Xk7XUL0a2QoccWbA@mail.gmail.com>
 <c7483e63-f51d-4b8c-9340-acf75e1f04b8@cherry.de>
In-Reply-To: <c7483e63-f51d-4b8c-9340-acf75e1f04b8@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Aug 2024 06:16:58 -0600
Message-ID: <CAFLszTjjKkJdTE90AYJN1S05xsf3Bso_fDiQN-4UcQuJNR4aYA@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] mmc: Use logging instead of pr_err()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

Hi Quentin,

On Mon, 12 Aug 2024 at 02:58, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 8/11/24 4:50 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Tue, 6 Aug 2024 at 08:10, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 7/21/24 5:25 PM, Simon Glass wrote:
> >>> Use the log subsystem instead of dev, to avoid including function names
> >>> in the code.
> >>>
> >>> The CONFIG_LOGF_FUNC option can be used to enable the function name.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> >>> ---
> >>>
> >>> (no changes since v1)
> >>>
> >>>    drivers/mmc/mmc.c | 49 ++++++++++++++++++++++++-----------------------
> >>>    1 file changed, 25 insertions(+), 24 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> >>> index b18dc331f78..b0105afe5d6 100644
> >>> --- a/drivers/mmc/mmc.c
> >>> +++ b/drivers/mmc/mmc.c
> >>> @@ -294,7 +294,7 @@ int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms)
> >>>
> >>>                if (status & MMC_STATUS_MASK) {
> >>>    #if !defined(CONFIG_SPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
> >>> -                     pr_err("Status Error: 0x%08x\n", status);
> >>> +                     log_err("Status Error: %08x\n", status);
> >>
> >> Please don't remove the 0x prefix (will not comment on other patches in
> >> this series if it happens again, please check :) ).
> >
> > OK...hex is the default though.
> >
>
> Can you please clarify what you meant by "it's the default though"?

U-Boot uses hex by default, so anything printed out or entered is
normally in hex. There are a few exceptions, not all of them correct.
I did send a series to allow decimal numbers but it has been deferred
for a while now[1].

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20210724150341.243074-13-sjg@chromium.org/
