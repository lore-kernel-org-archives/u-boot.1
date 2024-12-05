Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0293AE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D8DC8907B;
	Thu,  5 Dec 2024 20:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DleL0Ohb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560DB89567; Thu,  5 Dec 2024 20:55:29 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C200E8954D
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa531a70416so203927666b.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428526; x=1734033326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m0VQNJhTRmhtB+IGQPlHVz130dHD9vjzOG2oOPUxyE8=;
 b=DleL0OhbAAz8vcoAOl/tnoigHxDd7t1yB7ZCxSHXfBbqUIfSeKKVa91t2K3eA9IC7p
 T49+eY+cZlvuEp2OMw72O4iPwBtM9iFFT9OTNkR445q0STdTTnuPMapIArltocvxCbqL
 l8gMLD7EFhPJicQfiIQ6Y61T+3OM+QTHVnGMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428526; x=1734033326;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0VQNJhTRmhtB+IGQPlHVz130dHD9vjzOG2oOPUxyE8=;
 b=CvgvMaKE6q9sfA9gVzgPLrWcWIN+HxJfE78pXRAV40HmJgDmz9d85INOtkNfCuX7yp
 oSFR4cz+vhjZAlorLaGmtaZBvq5IVj5RyGMiRUm9hCezny9QhkpEmIfBzIKzEDZEZVXY
 qReYoxdBuIXnRlNjokR3NbIns3BSbeHNZ3mmYWe2eSOo8BQz9q3UDYSpDxki4I6JGt/d
 R889r2xoVhP8JLClV3a+m1eSk6wbuXskK+MXC2JbMc5/tKA38f1c/QW36vsV2hJmXWrq
 hQTg5Mc1GbCTnwNYU/s1S7oxHBvBd9b4DXAdrQ684a+ebJkqMxX8lmGdKT4ZAEH39rat
 T4Sw==
X-Gm-Message-State: AOJu0Yy5/PYl5JsynrhAO2UE8Ed3gfraiLyGKkirRbBZYJzhwuv6GtmS
 vZbOgWO3GXOfiJhmr8DTz2uki+HqU9vuTV+dwhxHnv+md3fneTTQ4CquT/ffeOozTBOyJL0g2bc
 gj2NyrKBCHNCLCVdXY1m6Mihe2mlq7njLQgUp
X-Gm-Gg: ASbGncvf//fUTEvwbId5bPWTK0wQibefnd3lvJTTzWne3r34ddLH2TElodTU9Myh08C
 aFiWkvNc9sGbGWx5UMYkvlRx50rVgpSHD
X-Google-Smtp-Source: AGHT+IFq+3ItZb0jEg+5ruZx4hhVNUpAKQYGNhIu2iVwsB7gPfHigzGe9diMsCP3d0sd/hqmh2L70gr0XJIn1quL1fw=
X-Received: by 2002:a05:6402:518f:b0:5d0:fb56:3f with SMTP id
 4fb4d7f45d1cf-5d3be67fe48mr615432a12.12.1733428526294; Thu, 05 Dec 2024
 11:55:26 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 11:55:23 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241203003538.GM2457179@bill-the-cat>
References: <20241203003538.GM2457179@bill-the-cat>
 <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-2-sjg@chromium.org>
 <20241201164017.GS3600562@bill-the-cat>
 <CAFLszTj=8ux3kjM-gCa+MZrOja-Qh+VLYoB0VKRy3gabv5pqmQ@mail.gmail.com>
Date: Thu, 5 Dec 2024 11:55:23 -0800
X-Google-Sender-Auth: aWMYqopaoqtdK78w41_-xBHINQo
Message-ID: <CAFLszTjkkUQ=e30X7HzMb1tQ9qwXEyeCXLOFwP6jb=i5s2PTTg@mail.gmail.com>
Subject: Re: [PATCH 1/8] CI: Drop extra condition for sjg lab
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>
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

On Mon, Dec 02, 2024 at 05:20:12PM -0700, Simon Glass wrote:
> Hi Tom,
>
> On Sun, 1 Dec 2024 at 09:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 01, 2024 at 07:42:29AM -0700, Simon Glass wrote:
> >
> > > The rules part of the template makes sure that this doesn't run until
> > > specifically requested. Drop the check in the script itself, so it is
> > > possible to trigger a run manually without re-pushing the tree.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > You don't need to re-push, you can just manually re-run the pipeline and
> > set the variable to 1 on the webpage.
>
> OK, well I don't want to have to do that :-)
>
> Are you wanting me to change the commit message?

No, please drop it, it's not required.

-- 
Tom

Applied to ci/master, thanks!
