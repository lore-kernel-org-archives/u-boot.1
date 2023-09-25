Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205FBCE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA1F86BFF;
	Mon, 25 Sep 2023 15:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LCFxNj/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377CE86BE8; Mon, 25 Sep 2023 15:11:14 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1152486B93
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53348be3fe1so6676872a12.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695647471; x=1696252271; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N366F5O9Gs/5hcjRWqDd0Xm1O7F74UZH4Z/CWudT0Pg=;
 b=LCFxNj/+eBTUQHbbA3VkXezy8xfIG48nXcOIsNQL4wZu+J2prhRCY5Pw43iOdtJQP+
 odfGLXDjwEnHlm2Q223u3FOUeIz+HRQXQBn4xv5DOR7/7z3ZtzfCHJ2PnPVuOQE+bsgI
 fxLFd8dOdLqmjZyP0zG0W3cf+X0Om0v5FYA4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695647471; x=1696252271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N366F5O9Gs/5hcjRWqDd0Xm1O7F74UZH4Z/CWudT0Pg=;
 b=XV/67DVQRvf8xTim16UsF0kjurain39DJ2DJnZ8WrvVKDrEV6K0BQ8iqSLsIthafzn
 C9Q4/gP7usbhXUHg9jOmFfLp4IcrsFRaAJ2n2CRtlL10FkQRCAGRArEUeV9McFqBOyL6
 mUncyTzrK+AQucJySnoX/UGuYoJ7WHG895slSggAjOMcIsvzKVvikpEVONO0yAVTrIU6
 ibe0Jou68HDUYJwERhNwoeDPpYE7sV7WUErL5n0d78R+QHe2QiszkPUJjxmvVD9cuMd4
 6zu8Pd8gGJElsBZl0r6OXwtuGnlM06vI9R/Ie0a8sqwTsk6dFSK10G6CkXSKNzl4IxUN
 ACQA==
X-Gm-Message-State: AOJu0YwgNecF+jcGFHxCamV674DXrYFwORD8M4SDwUuY8ZrKgyzxTscc
 3klHlnOVArHOskNi9eLcT+0EtANJTP0X2Mjhsd/jAw==
X-Google-Smtp-Source: AGHT+IGPQeedCULpqi9tBxdFZuZEY66AzqIzjiti30SrKlX0o3h6YGISnAPeA+miM7qSV3QI6P0ZZM/FkG59SrVAxDo=
X-Received: by 2002:aa7:d043:0:b0:530:92f9:57fc with SMTP id
 n3-20020aa7d043000000b0053092f957fcmr6419793edo.28.1695647471343; Mon, 25 Sep
 2023 06:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
 <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
In-Reply-To: <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 07:10:33 -0600
Message-ID: <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
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

On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi Simon,
>
>
> On 9/23/23 20:13, Simon Glass wrote:
> > Current alignment which is using 16 bytes is not correct in connection to
> > trace_clocks description and it's length.
> > That's why use start_addr variable and record proper size based on used
> > entries.
> >
> > Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - s/start_addr/start_ofs/g'
> >
> >   tools/proftool.c | 31 +++++++++++++++++++++++++++++--
> >   1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > Applied to u-boot-dm, thanks!
>
> FYI: I have merged it to my tree and already sent pull request to Tom.
> Without it I couldn't pass CI loop to get all reviewed features in.
>
> https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7d40c4f5@amd.com/

Ah OK, well that's fine. It was in my patchwork queue still, which
suggests that the patches were not set to 'applied'?

Regards,
Simon
