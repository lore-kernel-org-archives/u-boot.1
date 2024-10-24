Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2FBCE8E70
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 13:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3520888F83;
	Thu, 24 Oct 2024 15:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LCdpFCyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79FB788F27; Thu, 24 Oct 2024 14:33:15 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3889A88BBE
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 14:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6e35f08e23eso8203957b3.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1729773189; x=1730377989;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1SpmssS3+WBFXLW4vpeUc6BA0DyDFZSxLdZFQkc20U=;
 b=LCdpFCyCb+oxl48KbTUOkrgobQkxYQ2GTu/oj/JOUImVbOp2mDlk8QyXdzziyJjQuZ
 TS8/GtUKtXTXRNJ0+1KYlgPmpJ8KiLHkoCrxd/PMx5KZxY/gDiYOdsaFPBqTy4T8Ua6k
 w2dytQruKFfX99I/c2atCFz6KvTK3OTbMO3fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729773189; x=1730377989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1SpmssS3+WBFXLW4vpeUc6BA0DyDFZSxLdZFQkc20U=;
 b=cZu0xLQsFP/bTBekpyzTSQRbKDQ4gQynuG0DhOXIeAtGVlARGcdwb+87Fuz5SXet0W
 GsxJegSrY3M+x1L7bHxduE8oNcvpmXkJeFm14ct+7Q12u9X4h8UpPooWXtWFTb+lafbS
 gCgtkoefG/AjNbAeQOSIRvyGj3GySL8HWiMjaX49mJfNkQltC9++6HCJokMtJvagybq9
 ya8EiPQ4woM2SL80QmPd48uBrUXuF7flzIj9vFp0ajBYq8EQDeGgxneIafCzJKDRERv4
 F9a0vX4e/UR2WmO/OxY6rMnha5dLie9w5bINu4Ng51398tKSls4e6UWuRQ28J+FqSvTw
 6H+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxm+7CFMJYHvogbwumge+CUgw/FDn9W6HOFjfUHkfMw7xvIt9y5iO4HfRkK028sbusMn3Ters=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+IoOSQUWRR2PH/jIKdLWbzu86UHC0wAVNGX9HMUQpPjK0Yn2t
 HzKAMoPH0HeZArlKbWI7aXfx1qop4P9tkQE8DxIQvlAGSNbxBF6FadENIFGxi4nNrhj6815Pq5K
 qPoP/eSAHCVN5VrZWYPjHg9hYBhXklvB5//bq41BdFVwxl2vzQIg=
X-Google-Smtp-Source: AGHT+IH55W60t+RpoC5JOBThOnrzxuVoKe0yWBwk8y+2M6Bgbol0s4LUIKeyL6c9p1pc7LUzNr75t/zJsz4R2tH3nLw=
X-Received: by 2002:a05:690c:4b0a:b0:6e3:24c1:cdf8 with SMTP id
 00721157ae682-6e858180d4cmr20937857b3.22.1729773189073; Thu, 24 Oct 2024
 05:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240304161607.82759-1-marex@denx.de>
 <CAMty3ZB=s5ZNhgHZ2Q8vbzcvFCdO=62xHSY+dAeyr=y3ujkgWA@mail.gmail.com>
 <19a4f9fd-81c7-4ff7-a202-8f0f0c5857a9@denx.de>
 <CAMty3ZD0e1N_AQVOn_eCNkQQusib64QannFfx8Edku57WZWrfA@mail.gmail.com>
 <65ceb565-e84e-4ba1-a11d-7bd0ac98f7ee@denx.de>
 <9dd94d8a-0b83-480f-831b-e4bfd4a67333@denx.de>
 <089523ad-83e3-4717-a96a-a7bdf396e956@denx.de>
In-Reply-To: <089523ad-83e3-4717-a96a-a7bdf396e956@denx.de>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 24 Oct 2024 18:02:57 +0530
Message-ID: <CAMty3ZCc7-VmSSFBgGRDi9Eipg8UAAGgNFxvZYKL_RB1FJ_orQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Hai Pham <hai.pham.ud@renesas.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Johann Neuhauser <jneuhauser@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 24 Oct 2024 15:12:23 +0200
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

On Thu, Oct 10, 2024 at 8:59=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 9/25/24 7:05 PM, Marek Vasut wrote:
> > On 9/11/24 1:05 PM, Marek Vasut wrote:
> >> On 8/30/24 3:36 PM, Jagan Teki wrote:
> >>> On Sun, Aug 25, 2024 at 5:58=E2=80=AFAM Marek Vasut <marex@denx.de> w=
rote:
> >>>>
> >>>> On 5/24/24 6:05 PM, Jagan Teki wrote:
> >>>>> On Mon, Mar 4, 2024 at 9:46=E2=80=AFPM Marek Vasut <marex@denx.de> =
wrote:
> >>>>>>
> >>>>>> Some Winbond SPI NORs have special SR3 register which is
> >>>>>> used among other things to control whether non-standard
> >>>>>> "Individual Block/Sector Write Protection" (WPS bit)
> >>>>>> locking scheme is activated. This non-standard locking
> >>>>>> scheme is not supported by either U-Boot or Linux SPI
> >>>>>> NOR stack so make sure it is disabled, otherwise the
> >>>>>> SPI NOR may appear locked for no obvious reason.
> >>>>>>
> >>>>>> This SR3 WPS appears e.g. on W25Q16FW which has the same ID as
> >>>>>> W25Q16DW, but the W25Q16DW does not implement the SR3 WPS bit.
> >>>>>>
> >>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>>>>> ---
> >>>>>
> >>>>> Applied to u-boot-spi/master
> >>>>
> >>>> I do not see this patch in u-boot/master , was it missed ?
> >>>
> >>> I missed it, I will send it as part of PR soon.
> >> Is there a PR now ?
> >
> > Is there any progress on this ?
>
> What is the current state of this patch ?

It was completely, I was off due to other issues. Sorry for that.

Jagan.
