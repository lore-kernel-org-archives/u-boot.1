Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F107CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 059CD86F08;
	Wed, 18 Oct 2023 05:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lv/1HyZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94EE486F0F; Wed, 18 Oct 2023 05:31:00 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD17F86B05
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53d82bea507so10995716a12.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599858; x=1698204658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2c1jUlEZfRAbWBkOJKU8AlllQcim8z2qmUkt8HDeqhM=;
 b=Lv/1HyZla1WYjTf5uHb9lAe5Luj179TPOMb48ndoS7J/0Cny2yh8riRfpWfDDxWGAC
 1a/xjJzUqFtkOdRW4yL9JHrrf//F71tNqhvziDtJ85bYp9H64QMxXdtBJlBSZ/iLvZR8
 PgZyj9ZRJ/+SkVwk+F739ZJ8tAjQpvJRnYPjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599858; x=1698204658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2c1jUlEZfRAbWBkOJKU8AlllQcim8z2qmUkt8HDeqhM=;
 b=L/MbJwGdk2zHf0F4NgEEsL+q8LviRbziQklJ0eHfQfT1WM9VYm+2GFXI35cysVKXmM
 Rm09bGrlmzq8USwnsZUkx62yAko1Vjdo0GavY3ZvJ7zwMpj4m/E9Au3qS38OuTw2ugoQ
 1bukph2I8bYAYpY/cpFXYPYkgyCkfhH/7ZZrXNND6LGpHLaWFPfD3rPizGK+aGJIkn3M
 2sMm4jCvcvHxeoY6CtvKptP5IyLSG7EY1HiJQTUBhYHkIaH8bt+RBumjekX4UGy9JeD5
 6R1Si/BvCOrLi4TLnUYxYMfifSF+xhhfKkIIE6wl9r7L2aFSNHkJmGkVOnwP2fA0AcIc
 JG8A==
X-Gm-Message-State: AOJu0YxNV0tn7sNbArcsOtd/9eWhkowWzyVxGv8CvNJbcON4CTmTDfvb
 OtdLdDCelIp0DXfmNh8sFSSNiLhrh4h9NV/3Ul19ig==
X-Google-Smtp-Source: AGHT+IE3xKQ7Lj3wpBd1s4QmTANCIzoesGXYLOG5PlHIE+Hx1lt5iIkmH1q5lkYTsmQeddvhYlaT+7X59cjZS9xchko=
X-Received: by 2002:a17:906:6a08:b0:9ba:33ef:fe4c with SMTP id
 qw8-20020a1709066a0800b009ba33effe4cmr3031464ejc.64.1697599858057; Tue, 17
 Oct 2023 20:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-5-sjg@chromium.org>
 <20231017133231.GT3119521@bill-the-cat>
In-Reply-To: <20231017133231.GT3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:30:46 -0600
Message-ID: <CAPnjgZ3VWAfma9E19OSydhvKGXDk4mBA7KWL=uqVXZzD7Uxt+g@mail.gmail.com>
Subject: Re: [PATCH v3 04/32] cmd: Add a few more dependencies on CMDLINE
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

On Tue, 17 Oct 2023 at 07:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:27:55PM -0600, Simon Glass wrote:
>
> > Add this to some more commands to avoid build errors with sandbox.
> >
> > Note that this is a temporary solution to expose more problems. A later
> > patch puts these behind an 'if CMDLINE'
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> We're doing a bunch of churn here that I'd rather just get done at once,
> make the current #27 which guards all commands with if CMDLINE happen
> earlier in the series instead.

Yes I did consider this when reviewing this patch for v3, but got
build-bisect failures. I cannot move #27 earlier, since all the builds
fail. Allowing #27 to pass is the point of this series, in fact.

If we can make progress on the thrust of this series then I will see
if I can somehow reorder some other patches to drop this patch, or
move it later, or cut it down, or something else...

I also don't agree with 'bunch of'. This is 6 lines, which enables
another 20 patches which clean everything up. Are there other patches
with churn?

Regards,
Simon
