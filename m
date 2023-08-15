Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22911C001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E08869CD;
	Tue, 15 Aug 2023 16:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K4OlORvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E23869D9; Tue, 15 Aug 2023 16:44:36 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA97869C9
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99cdb0fd093so748109166b.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692110673; x=1692715473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wBbjRzYBH4tZwuCH1qU2BliS6hDFHNu5WWakz1AVZao=;
 b=K4OlORvf94DjHOKXDfYITEwkTO4j/8gt3RIKWSEt+f03FDF5gSQSaVpQdsNVWOikXA
 2IsxgzY+bMhL58+nFS96HARjjercy9x9rI2IpmSkd3LgNY/CQFqY4LXZRQxFfmwif85E
 oNk8esZiZRKr/JnlnIf8Fe2nwzz3Y+KPVNgRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110673; x=1692715473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wBbjRzYBH4tZwuCH1qU2BliS6hDFHNu5WWakz1AVZao=;
 b=PK1uISVeeRWQqq8hXP2OPu3Vc/pe2K1HYcRRhbQm5B3JzIPXuyjcfyN/Kbgg3Ykytm
 H5rOiKWj3Vt32EAaK/AQVB1OzhepI7TQyqM3zoyHLnCLJ+ubt2MPTEPUwPrqysRniQ6w
 CwZFqJEXRD80vVAYYwjpoW2zu16FRLNrZQRMfBo0PTjN47Ljm1GrO+gj8H1UyCR5HeCO
 IWxszWqHBG2U1BiGNgKAPQCtIyUGkPz5R/rBZPVeIw3iSbL+7zxmVmSb9C4Q9O1iXRQw
 6Akm+gFpW3JoN/c8OQsSwaQoh7wXFjwWU0XqEVbs1lmKjCKxDGgvMHRDDz+S5uHf/6Vw
 8tFA==
X-Gm-Message-State: AOJu0YzwXq7nwOLEv10dvt2u7pn8zzYI3iFnDHgvotvhXeLqz33G4sRt
 mnfJnyf04efkXSOtf0CjQ0LE9gRAD78jzdAeVMv8dQ==
X-Google-Smtp-Source: AGHT+IHhaB8U4/BhMslJGTuqcJ/iusfTQS+q1KCntUg/tTFj3VrnOAo0RRmw/Ud5Xojwq9nbjBTdOQApH1JN0Q7BLH0=
X-Received: by 2002:a17:907:7853:b0:99d:bcc8:6830 with SMTP id
 lb19-20020a170907785300b0099dbcc86830mr3340409ejc.29.1692110672730; Tue, 15
 Aug 2023 07:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0Gj==Q-YOU+EoD=s3h25Waw5EYa0DEOD_comoAy_bRMw@mail.gmail.com>
 <20230813155208.GN3630934@bill-the-cat>
In-Reply-To: <20230813155208.GN3630934@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Aug 2023 08:44:20 -0600
Message-ID: <CAPnjgZ2_y3coEzTh=3Y=-w=B+qFAmxM5CbCYsKDWvCNaeO_-Kg@mail.gmail.com>
Subject: Re: Strange gitlab idea
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

On Sun, 13 Aug 2023 at 09:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Aug 12, 2023 at 09:14:45PM -0600, Simon Glass wrote:
>
> > Hi Tom,
> >
> > I notice that the runners are not utilised much by the QEMU jobs,
> > since we only run one at a time.
> >
> > I wonder if we could improve this, perhaps by using a different tag
> > for the QEMU ones and then having a machine that only runs those (and
> > runs 40 in parallel)?
> >
> > In general our use of the runners seems a bit primitive, since the
> > main use of parallelism is in the world builds.
>
> I'm honestly not sure. I think there's a few tweaks that we should do,
> like putting the opensbi and coreboot files in to the Dockerfile logic
> instead.  And maybe seeing if just like we can have a docker registry
> cache, if we can setup local pypi cache too?  I'm not otherwise sure
> what's taking 23 seconds or so of
> https://source.denx.de/u-boot/u-boot/-/jobs/673565#L34 since the build
> and run parts aren't much.
>
> My first big worry about running 2 or 3 qemu jobs at the same time on a
> host is that any wins get from a shorter queue will be lost to buildman
> doing "make -j$(nproc)" 2 or 3 times at once and so we build slower.

Yes, perhaps.

>
> My second big worry is that getting the right tags on runners will be a
> little tricky.

Yes, and error-prone. Also it makes it harder to deal with broken machines.

>
> My third big worry (but this is something you can test easy enough at
> least) is that running the big sandbox tests, 2 or 3 times at once on
> the same host will get much slower. I think, but profiling would be
> helpful, that those get slow due to I/O and not CPU.

I suspect it would be fast enough.

But actually the other problem is that I am not sure whether the jobs
would have their own filesystem?

Regards,
Simon
