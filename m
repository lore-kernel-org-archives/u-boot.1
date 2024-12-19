Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48962E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A3A78030F;
	Thu, 19 Dec 2024 03:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f/GXYJ6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C1C680241; Thu, 19 Dec 2024 03:43:51 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A2EB8030F
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso57387966b.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734576228; x=1735181028; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RK/uYkdZsAwdBIV2ZWU9Wp7hQkMVgdsfAyeLPm9fXHo=;
 b=f/GXYJ6dMGA/aQ+QcQ5xi4zepTnJTKSn4j/0HbZPl1Nc7kC9DZcMgECPg2NTKdSInv
 BPCro/QYzauPAv7Gy8Gv/Z2pPAjyKO5QXYGna3gExtmt1xaXf7z4rxaQysKrQkSHlQ8F
 8hlSPyScspXXMiP+Whva5tWaXbGX2vUIDaWtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734576228; x=1735181028;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RK/uYkdZsAwdBIV2ZWU9Wp7hQkMVgdsfAyeLPm9fXHo=;
 b=dDde+9RHsU81pB6i5C3ZfGzreZgpCeNgiV5x4do6c1OcCqry+JkbWg71Nb4m5RaOpB
 G9vX5CvzIF1fqByTl2xprbHEkwdbekS5R0QlbvCyNqhpXygkrs3/WQmkg2tGL0UWETA1
 0/xPCqrTGqbNMLfwCGaCkiPw3cyBlLXTzSMxtr2SmyFy2YfLPfdjBdDlBbFweD2sAFfC
 DiVjie8YJ86b4fnQiPJsGkHXtCWld80Btfzoa5ep53aB4PZUS1G+eiDzIyyIxgGTVgzi
 PXuJbhnlcjHZDx0nmk0WrjjRUSPD6lb0UFbHKzW3lIH8QvzkizBFtZGKqjpuGwSotGpT
 6RQA==
X-Gm-Message-State: AOJu0Yw0sj8vWkh00vLAiQ+FnLD6xiMj44qhqG9FcdapHwVUjcf2gHqr
 12DsowPM32agEptYdD4aq1bDgZxCCYObx17nOmU64onfLew/mBXUKE5i1rnCyVCcER+offMfVI/
 IbOwheO6FVo2p+6Iyk6fFDrU1SA17It7xWAn9
X-Gm-Gg: ASbGncuPeTzAN3cxkx9NSXwd3Xdj/B4RfOB1sW8O0iL7hcgN0MR0tytjhlhlOEtZE3K
 ajRxs2eimii0SZdyYNNyeiacD6DX25U6yQ7Fr92A=
X-Google-Smtp-Source: AGHT+IG+8U1c4ecD78i8vuch8N5b6AWffq5NGTXHNXg2cc3rOD4HlRzg2JBYbhyTlj3JAI10g1njOyQ45PribQHrlRw=
X-Received: by 2002:a17:907:2d9e:b0:aa6:4a5b:b729 with SMTP id
 a640c23a62f3a-aac079611fdmr125152566b.33.1734576228628; Wed, 18 Dec 2024
 18:43:48 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Dec 2024 18:43:47 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTgQr-czmdwzHbNvZOxMzUzM0zb8EDUhVLq6ArM+DUe0Bg@mail.gmail.com>
References: <CAFLszTgQr-czmdwzHbNvZOxMzUzM0zb8EDUhVLq6ArM+DUe0Bg@mail.gmail.com>
 <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-5-sjg@chromium.org>
 <CAC_iWjKaywBv3qyk=fHNqH_anC3xT63Ua2=DMG2w1=LEt2vDLg@mail.gmail.com>
 <CAFLszTj8z+CL4FU_6yGjvN82ARYr3ZiWsGd7h9A=p6ObhEKcug@mail.gmail.com>
 <CAC_iWjJtG2qoHEWW8h7hVVU1c6+dPFJ3X7jYSe5H0UzXkSHxcQ@mail.gmail.com>
 <CAFLszTinZrL8VLiMSk-PxWP7oWdY=35kNNUYXXx3EfEz7Z72cQ@mail.gmail.com>
 <CAC_iWjL94RJCD4cM+SPS6FRAEM8VoK4kLSovOJFc6sJQ3FaSDA@mail.gmail.com>
Date: Wed, 18 Dec 2024 18:43:47 -0800
X-Google-Sender-Auth: Vd0R_bFhP7J1-pna2XHxgRFlPII
Message-ID: <CAFLszTi3CY2bt5CSCgOAPbv-KQBCJeFbquymfu-StMTohUH6cw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] efi_loader: Add a version of efi_binary_run() with
 more parameters
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Fri, 13 Dec 2024 at 05:13, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 13 Dec 2024 at 05:53, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 12 Dec 2024 at 08:45, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Thu, 12 Dec 2024 at 15:45, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Thu, 12 Dec 2024 at 00:49, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > This uses a few global variables at present. With the bootflow we have
> > > > > > the required parameters, so add a function which accepts these. Update
> > > > > > the existing function to call the new one with the globals.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > (no changes since v1)
> > > > > >
> > > > > >  lib/efi_loader/efi_bootbin.c | 29 +++++++++++++++++++++++++----
> > > > > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > > > > >
Applied to sjg/master, thanks!
