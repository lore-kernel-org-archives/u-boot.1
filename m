Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CCFCCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 11:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D9D383D86;
	Tue,  7 Oct 2025 13:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TMuVueXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD7983F56; Tue,  7 Oct 2025 13:14:09 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 851ED8363D
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 13:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b40f11a1027so1095216566b.2
 for <u-boot@lists.denx.de>; Tue, 07 Oct 2025 04:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759835646; x=1760440446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6/x5SG4a0Vv+3EUdbL31diXq7jmSnsHDLdlas8M1uM8=;
 b=TMuVueXGhlPOzQkFepDb8ELE1nmXfiXQo4hZ5uSOB1Ay6AePM57kxUYwv4bHecnw7s
 muLODFO9ISqiQ8coe+JvAdkokG1J5chI9YzQzN3zDHvopSP8PSJT3w8VN0TZ1IavrI21
 k+1xg5bg+4xy+UAt1Cc01sM2nl5gE06uz58yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759835646; x=1760440446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6/x5SG4a0Vv+3EUdbL31diXq7jmSnsHDLdlas8M1uM8=;
 b=NRd8myjyAECba94KKRC/oDJVHXy94XiGjRZLeHb29PsjHZBue+IQqK+6L9mo/ZpEZh
 rW5cGIf1rL71TnVdh3Pz70SioNisnr0XwMWaRITiiDmJduPSd1NzC/rMsx+TiWRS0OSF
 ZAHzozG87TBUhhwWQ4kSm54DRUg7r7OMEwQHSV9YDfNzjWSHvn7OLSwHxCYvLrCkudDU
 3JYV9+B9P7lFgt7mzbvjQB6su1YedwZluYMSLJvxqJfVzMxtUty7+wgZSuWa/KyxXE99
 +nPMrw+f/sISzRhkqYN0Wc3/oqFTpQWaj2/auitu/CWqjMFiCP1h6U4kCUKmOoDMx4YD
 HJtw==
X-Gm-Message-State: AOJu0YzNhPj6CXQORslZJDyv101qMm90pnrBYNakiuprq0WWZa6MSpCk
 4SyK+VF11KdrfwIEU8SzOXC6gJk4NJ11IN7t6iSij6VeMrcVMrW7RoWWf1e3a8dSbSansxEy+aO
 mkAaEWoguq4MkoNm1dbYbFSq6Us2HGWXRFsNdzYqd
X-Gm-Gg: ASbGncudxLuNd3a3K0A0JwqmHdgPQQKoW4hMFqiAvJNMt/Wgc1NgPm02bfFZC6SAm3A
 QQcJfgfCnytTqFS61zx92sB1KQ8HDaPVU6XlSpHhP6PLUxhsvdJY5VEyo8+NW5eD3OKxa6tThlq
 NnfAIN/v96OM8xA13B1QC+A2u9uM4QqFphxFnFeSB51y6qt2ZfHZ+yt4HWil+oMtSf6/zTfF7+o
 NJGOqKENOoIagrFYhQCrPdiwFcEog==
X-Google-Smtp-Source: AGHT+IFqppGiH7t+J2RzyYfsk+P9e178aC5moW030Lm3IU8w0AYdMCHwgZ6wm20jROTpnaJ/cetXJjvgig52/X56I5U=
X-Received: by 2002:a17:907:948f:b0:b3c:3c8e:189d with SMTP id
 a640c23a62f3a-b49c3932c56mr2055839466b.32.1759835646561; Tue, 07 Oct 2025
 04:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-6-sjg@chromium.org>
 <20251002201537.GO6093@bill-the-cat>
 <CAFLszTigwz2mVfS=C6yXDnTMvdGxw=FsD36QCrpS2VOVSr+7nA@mail.gmail.com>
 <20251006234500.GG298503@bill-the-cat>
In-Reply-To: <20251006234500.GG298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Oct 2025 05:13:55 -0600
X-Gm-Features: AS18NWDFjkZ7KvFQYMT0OKPLhgJa_F5-_j2nzJSRbCFrST37Mr-j2j832EUNSfo
Message-ID: <CAFLszTgEoEN=+QocxEXewkwe-wjOKeNRMn5YWSvHcOcaLR2qsA@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] boot: Move showing of bootflows out of the
 command
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Hi Tom,

On Mon, 6 Oct 2025 at 17:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 06, 2025 at 05:30:23PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 2 Oct 2025 at 14:15, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 01, 2025 at 03:26:30PM -0600, Simon Glass wrote:
> > >
> > > > It is helpful in tests to be able to show the bootflow that is being
> > > > examined. Move show_bootflow() into boot/ and rename it.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Add a log_err() for an invalid state
> > > >
> > > >  boot/bootflow.c    | 57 ++++++++++++++++++++++++++++++++++++++
> > > >  cmd/bootflow.c     | 68 ++--------------------------------------------
> > > >  include/bootflow.h |  9 ++++++
> > > >  3 files changed, 69 insertions(+), 65 deletions(-)
> > > [snip]
> > > > +     case BOOTFLOWST_COUNT:
> > > > +             log_err("Unexpected boot value of bootflow error %d",
> > > > +                      bflow->state);
> > >
> > > A small thing, checkpatch.pl catches that this isn't aligned with the '('
> > > here as it should be.
> >
> > OK. I'm unsure whether I really want this line anyway, since it
> > increases code size.
> >
> > >
> > > A larger thing, and please correct me if I'm wrong, but on reading the
> > > whole set of changes, this move + rename just means we're putting more
> > > info in the test output, and nothing else?
> >
> > It will also appear if you have CONFIG BOOTSTD_FULL and use 'bootflow
> > list' or 'bootflow scan -l'.
>
> But that should be the case before this patch as well, yes?

Yes, that's right. This is just moving the code into a place where it
can be used from tests.

Regards,
Simon
