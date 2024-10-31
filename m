Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B82D767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E7F89293;
	Thu, 31 Oct 2024 19:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZCo+P5B1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD29F8929D; Thu, 31 Oct 2024 19:00:24 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE54588B55
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso134855866b.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397622; x=1731002422; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Am76qSSAvQW2xhelfC7MrQOk2ldqErPoW8p3YMIYPYg=;
 b=ZCo+P5B1ya4btehHhW/kkPGjXPinGv823fI4Ca3xPhUgesRMJZeucNpd1SLtbLAxE+
 ysRNzvI+zCu82AGK6ISbSpxD8mU5uXgxMSEEfeqBbxuKV+GfeWmjNvlBt43ZXtyBTePc
 +wykB67qmgw0PMaxg6uZ8fTwctj7NeBjKYYwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397622; x=1731002422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Am76qSSAvQW2xhelfC7MrQOk2ldqErPoW8p3YMIYPYg=;
 b=rePpyu459/anWGSmaEHDD+jJlSQJK5jnxor2mchbmMjVCG1XZi7qDzTvltiC6g43lD
 khy2R0mjR7mGjDZMXtt1EmVb/djc8YoC9gs10tjRWMPc8W+0kCHSINQTIea6RTe5mFCn
 b0t5rL6UD4oGjirbhX//HycQ1QxJ59dC5aoCYhK4Rv1MPEIwaKgpCHAH+vQbXBVlucNd
 RKe25ZhDHApMoucVn7mp9LGeQjtKBniNYvgCY69Ack6StTryUgyYqF3oOefB+RqsaAKS
 owOnMx0oPhrbw9zmh7TE+3Ph6gk+xr1ysoL98evKncAzIT0ljCY7sUEXCbT3pDuOZMBu
 D80g==
X-Gm-Message-State: AOJu0YyJXUK5A65R7DklOHmXIu1X8EYSfs5XUlZbflUNP+TfXHcCzsUH
 hpTQcl2IBvEmvyi9HzO604CaYQ8hiHOfs0woVK+63ynDCH8I5AVxvf7GB5178lyzL+PxIXvpGo2
 qySwb7QSQ8uenNX3CKEt28EyGRHoYhQkoHkTABd80AqrFavL0bQ==
X-Google-Smtp-Source: AGHT+IHjH+C5YQ7x2y+/Pdt2irqw3C4L32RWSZjN2ky+8Tt5DziGZADl4dRbpc6BJyxpaUJhF8xctQETNWke1c/mVkw=
X-Received: by 2002:a17:907:96ac:b0:a99:5d4c:7177 with SMTP id
 a640c23a62f3a-a9de5d6f1f7mr2059032066b.6.1730397622424; Thu, 31 Oct 2024
 11:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-2-sjg@chromium.org>
 <20241029235257.GB2558755@bill-the-cat>
In-Reply-To: <20241029235257.GB2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:00:10 +0100
Message-ID: <CAFLszTjBbODQh+Vv=3cckGUyRt2MwXnLQKFcpyMVSgFzB67gWA@mail.gmail.com>
Subject: Re: [PATCH v7 01/11] test: Allow signaling that U-Boot is ready
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 09, 2024 at 07:51:35PM -0600, Simon Glass wrote:
>
> > When Labgrid is used, it can get U-Boot ready for running tests. It
> > prints a message when it has done so.
> >
> > Add logic to detect this message and accept it.
> >
> > Note that this does not change pytest, which still (also) looks for the
> > U-Boot banner. This change merely makes it possible for pytest to
> > believe Labgrid when it says that the board is ready for use.
> >
> > In several cases, the board starts up and Labgrid receives some initial
> > output, then pytest starts and misses some of that output, because it
> > came in while Labgrid had the console open. Then pytest fails because
> > it doesn't see the expected banners.
> >
> > With this change, Labgrid handles getting U-Boot to a prompt, in a
> > fully reliable manner. Then pytest starts up and can simply start
> > running its tests.
> >
> > But, again, this does not prevent pytest from handling a banner if one
> > is provided (e.g. if not using the Labgrid integration).
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I _may_ see this myself sometimes, but I'm not sure.

OK, but it isn't really necessary for you to see it yourself. I've
described above the repeatable problems I have with this approach.

> But I'm not sure
> where the bug would be between us and labgrid. Looking at
> test/py/u_boot_console_exec_attach.py we grab the console and then reset
> the target. If the spawn hasn't completed, especially before the power
> cycle has completed (which in labgrid defaults to 2 seconds) we perhaps
> need our own delay. But as I'll point out further on, NOT counting the
> banners means we aren't able to verify other functionality. Even if they
> are tests that I think you don't like because they verify the
> functionality of resetting the device.

Yes, that's a use case that needs special support. If a board is
booted from USB, then resets, it will run whatever it can find,
perhaps just hang. Labgrid doesn't know the board is resetting and
cannot therefore ensure that it sends the firmware over USB a second
time (or sets the recovery line on the board). Resetting a board works
OK using SDwire and some other cases, but will fail on quite a few of
my boards.

Regards,
Simon
