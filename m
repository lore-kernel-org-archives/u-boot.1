Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947F5CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDBB18495C;
	Mon,  1 Jun 2026 16:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DT41fA2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF1A084976; Mon,  1 Jun 2026 16:59:17 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC8238493E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bdf8add254dso944093166b.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325955; cv=none;
 d=google.com; s=arc-20240605;
 b=ZaGKY1k/gox+OWz3B4R1afe3UAXgfdVnYjFrVl4h2K2XxmUfAzN9xUloVGv9ZEdmZZ
 NV1owtBCFSkaoF4xBfhLGUZGdcxRSAv/rXfiNPBa3HohiGuCuNcmu0orLQfzibUVmQHx
 fMuAFx5hVL8TKU96OwDTwe9SXOy6Qcz+NX1olsJAgU4C6rZRYO7SbDAaIaH9B/F+myi1
 lHmr8iQSPwytvRk79dudC+Z04SM+geaPF910hxRJQOKZpAKbeIYasDkW4AuSOxixzq4E
 v4Y+hob4pZxsZwxL+Xxayht4hwZ5RTGaKszF/dMFJfwkUmr1z79KMDbpAw/pxjoI64vI
 dJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TItHaMj3zNExdNKQKPRBwQzVsSYCwrDuz6GAFnkc5Hc=;
 fh=57GziyhBKKyAimfawPt0uH0vpQVmu109TFROrjnzxYM=;
 b=Wc6G0DtKXENgC4/xvX3niYfowA1NqKnrl/2CyxY7Ya9GQSYy5GH6r7tV+BLsyb/wIt
 lqyj0T/mtnoyrIrJp7pZGkxY8FEpQfeYiuLUPo25p+h7TTug5Vc2Pi/Gq4Jn8vVAKog5
 Tk3Uuq8h+K8VSF9CrO9KM+6q/xaUQFX3sB3j6nSCE5ticQ/LP34hGwK5+2/WQQS57Onw
 jexuAsZKP/OdhR1g3GX4OwXbXHYoSEirWeDc9Mcs5FmhmrnenlIYu2aKCgQqVm7Mq/55
 qkVruNLzMY6An9M4k9tXkH7L4RR3ea29u513jiSPoQJ4UJXesyE6iR4S0SXaWLYukZo4
 P0WQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325955; x=1780930755; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TItHaMj3zNExdNKQKPRBwQzVsSYCwrDuz6GAFnkc5Hc=;
 b=DT41fA2WpV/Ti3m+s2ekfde/pRyLP7A51B4gw6CXVjDDKJsNJkcyrm0mHNQDpDEfpz
 n8MJDYlTjgXk0YFe60y+dTTq+PjWczjiC2cz4XUTjU37VBUo71cym7N1u1z7XEGpnNRL
 NvsOUxQxloKCilYwfTeHYMjQk8PhO87va5qRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325955; x=1780930755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TItHaMj3zNExdNKQKPRBwQzVsSYCwrDuz6GAFnkc5Hc=;
 b=RR75AtYDzKddsgp+ZLQzaGcwF908mjv5F5L9lTqxhrV1Fp/7pYAJhY+rW0MBu8fTLB
 YhGM193UGuxPuFKz2a6ovvnyaiNW/uRlsHlvKzcYm3jZvhpBl/NxXWCngzhUla5ntaUd
 6k1sgHmsrf5fm7iSHNUf/qxYMJ2G8aOmINsA7bJac025kbJqS+8lnehbxZ2EuEPuNLuA
 B/X4/IfKbjw7l6lO1Dx1fHSthLOcc1azwMwcDk/s4Sm5QXTvs0SnG2QE5oYi1nkMTERX
 2yMMk/w6/juYOJ2cY0tleZmxpSZniOpEC/NzzMHxxGnTXYaOmwTkGTVzq2CfBMVQTIzv
 gz4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bBlNv5y4nvX30ZFaNs0FEOjKXbAQjA5YPAfwDkxq6Li+r060cey8rPCU+55xJcvKb65DsGkk=@lists.denx.de
X-Gm-Message-State: AOJu0Yww2cbJQSRSuxaU+VQ1PEwPZNN1arTmA/ahnOhVctrRszCg3RUo
 an6yL7O7AyyfsK+x1f7FWT++7nchNAczTrcVc5iqfqogV1J8aJzBssL81kXgtW+q9eP1rNfL1pM
 Ya0i8TRoSiWD7v8J5jg60uLYtFCOlyDpWI1i08L2Z
X-Gm-Gg: Acq92OH2RG3hvwyoy2fsQCGH6kxyrmnEDAX0VG89/GeqZdKtOf0cSEPLTtnSLtVd4pF
 JV5w88qvANEd5Z6hXWgRan9V03uHwS6KjfQ44Ino6ktQ3B7NXqWXPDlEbaqebj8xXQVxH2IN9Pb
 BslmkxZYJr9e5w9s79wZzCKyEsb1CCS/aONhKZJ78aJ/Oj+hyDcUx672PqsQY83IzN7XQJ0bedp
 nnfnct8YTKdvcEJ6gUUlfTIjNguejbBP2GVPOOrWMmUjQwRMAkAIXkCvk3AdB0qajU79Tk5pChV
 4pCcZgWQoh3qFjfm
X-Received: by 2002:a17:907:5c9:b0:bdc:8c6b:4842 with SMTP id
 a640c23a62f3a-beab17ab054mr608123066b.30.1780325955348; Mon, 01 Jun 2026
 07:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260523055000.1059981-1-daniel@thingy.jp>
 <ahU5WIYwWLxeM9oY@google.com>
In-Reply-To: <ahU5WIYwWLxeM9oY@google.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:59:00 -0600
X-Gm-Features: AVHnY4JXI0EM4wc0SKiI1V5iSn7qbtp4_g6lqnhiXSmL9eyRXR12UqxwZBiJJVE
Message-ID: <CAFLszTjLtBuvAjS5YE4StF4JqyzA30Zr9-0OOXG=-91dNb-VjA@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio: Add driver for virtio gpu
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Daniel Palmer <daniel@thingy.jp>, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Tue, 26 May 2026 at 08:10, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Hi Daniel,
>
> On Sat, May 23, 2026 at 02:50:00PM +0900, Daniel Palmer wrote:
> > Add a basic driver for virtio gpu. This allows for a video on
> > qemu virt machines.
>
> Cool! Thanks for doing this.
>
> I was also planning to look into adding support for some other virtio
> drivers, but I've been traveling recently and haven't had the time to
> finish them up.

That's great! Let's coordinate a bit - I have virtio-scsi and virtiofs
locally - I just send a precursor series with a sandbox emulator too.

[..]

Regards,
Simon
