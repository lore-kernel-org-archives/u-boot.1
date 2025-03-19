Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D812DC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A467D82033;
	Wed, 19 Mar 2025 16:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d1OHh2Rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E264F80FF0; Wed, 19 Mar 2025 16:04:13 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF4EC82033
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso1690292a12.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396651; x=1743001451; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bw4JP66cGwYWu/n/ckSzL/a+7yOwIB99VPw4zub/fOE=;
 b=d1OHh2RqyoMGM6f1KYoXM7XWwiIiUFLw74vJ4Y1Mi4AZ4HyIapdzR5+R0vxhXAur/t
 Js4V5j50zISaxS1r9D+5+nSg7dbXdN3yfoWqb7IaUXEJRTIafrYwf9aWu73Sz4xu1p0l
 CfdJANIk2oAXoI7MnYSgmzW5hTDl7Ter7YQZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396651; x=1743001451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bw4JP66cGwYWu/n/ckSzL/a+7yOwIB99VPw4zub/fOE=;
 b=WpX07ERrk6iwt+GoV83+mBj2TnJJ+KiVTDw9paiOR8ZbhJcX4NKfJVIsKxrHUppafs
 BS4pjzbiJETsM1Q+ZPqSUMXyYvmUKuaeq8rxd7iG4nAx0VwkFw5OW0Qf/ixUEymAer2Q
 QUydgIw6ZgVGkLOBfQN/eTUvUleysiC8/UFWySIzXgEPj6O3vPpPkbadHctDyAvHcuef
 qO4yIL7EMIhmJVtY+mg/p7IhwHzcX18436DS1Hmucrsjo/E4Wqc40bA819q0MYDz1oZJ
 CeZNfhSLLuaN4DdepeC25O2PWqERs1Qu6+ZqZPXq5lwIF1NGuQGPD+aenCM1QcJ71z9B
 ElPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsVgZfPtRysyLL6ayMwnrFZG8d1YRSQRNO+wCUXNvNRJDldCFLKq209x88CW4lmPtzg1WJwek=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2VySFqOYvCY64RY+vL5LJFmC0Km1TwVR1P1JZ+YfdCGEC6VvF
 Ra9/kLiTRWCWU86WLMMFoITyd2HFuE3E6AgjF7d977kYC2VNoU6Ll5ZXGTsxlvH+MDFLZbWIRT0
 pPmPljuUVOWz0+YT4cnWy6f6QEzaz85W16ZMy
X-Gm-Gg: ASbGnctQlQeUwpMHhcwSceTqUdJgM8HquLt+4S5Tdocu2AA65G7dIfqkfaEgDk2zKqu
 /yL41YRLd1QgWWgQEbu9YPf9HVFDniTDVOmde/cIocqkMnDglp0TlxormQxuULMPUqS7E1Zbhhb
 v6yqPkfiZCUkK4pFdjwPqdcLu6elYAv/xwvv/QoA==
X-Google-Smtp-Source: AGHT+IHfCVtBCsitmjvT2Q60OjjUGdmTCW6HJQ0Qc1k+EMvpTudaPZtchJPlQ7z/bI+OoZt35nPQdFz8Mqaa00Wf1Xo=
X-Received: by 2002:a17:907:f50a:b0:ac3:3e43:f451 with SMTP id
 a640c23a62f3a-ac3b6abe286mr334000066b.5.1742396651123; Wed, 19 Mar 2025
 08:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
 <20250318104659.1114340-11-jerome.forissier@linaro.org>
 <95cadc8b-2922-4bd2-8a0c-8ecdb5885bed@denx.de>
 <e6549ff5-b2dc-4e32-9a6b-c18ed963945a@linaro.org>
In-Reply-To: <e6549ff5-b2dc-4e32-9a6b-c18ed963945a@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Mar 2025 15:03:57 +0000
X-Gm-Features: AQ5f1Jqnv9LP2tYzfc3pDSElxe4Rn1c73bD23rT1G5qmsZ9EtqR6bhtyVNSuNns
Message-ID: <CAFLszTji6M4s4Q0u0=Wf57oQUwy8Hxnkzf_x8p4HVP8iU=YfQw@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] dm: usb: move bus initialization into new static
 function usb_init_bus()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Jerome,

On Wed, 19 Mar 2025 at 11:44, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hello Marek,
>
> On 3/18/25 13:20, Marek Vasut wrote:
> > On 3/18/25 11:46 AM, Jerome Forissier wrote:
> >> To prepare for the introduction of threads in the USB initialization
> >> sequence, move code out of usb_init() into a new helper function:
> >> usb_init_bus(). No functional change.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> ---
> >>   drivers/usb/host/usb-uclass.c | 88 +++++++++++++++++++----------------
> >>   1 file changed, 48 insertions(+), 40 deletions(-)
> >>
> >> diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
> >> index bfec303e7af..cc803241461 100644
> >> --- a/drivers/usb/host/usb-uclass.c
> >> +++ b/drivers/usb/host/usb-uclass.c
> >> @@ -287,9 +287,55 @@ static int usb_probe_companion(struct udevice *bus)
> >>       return 0;
> >>   }
> >>   +static int controllers_initialized;
> > I'm afraid this won't work, you will have to track the controllers in a list somehow, because it is possible to unbind DM devices even using the 'unbind' command from U-Boot command line.
> >
> > Also, why not simply track the controller state using DM in the first place?
>
> I'll keep controllers_initialized local to usb_init() and use device_active()
> in the second uclass_foreach_dev() loop.

Could you please take a bit of a look at collecting the USB-scanning
state into a struct?

We should be able to call it using iteration:

struct usb_iter iter;

usb_iter_init(&iter);
usb_iter_process()

It could collect all the devices it finds into an alist and then the
caller can take a look.

The reason I am keen on this is that it will potentially allow removal
of the time delays in the USB stack, so we can deal with sticks which
take longer to respond.

I may have this wrong, but it seems that the primary delay is in
usb_urb_submit(). So what we really need is an usb_urb_async() which
enqueues the urb and then another method to poll it. That would
perhaps allow much faster USB since all devices would be scanning in
parallel, including individual devices on the same hub.

Turning the USB stack 'inside out' is how I've made bootstd work. I
means that devices which are found can be reported as they are found
and we can potentially wait a long time for the long-tail devices,
while still returning immediately to the cmdline so the user can
continue.

Regards,
Simon
