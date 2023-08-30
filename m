Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0AAC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 00:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1FD8650A;
	Wed, 30 Aug 2023 02:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C9D9Sw9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A7E8650A; Wed, 30 Aug 2023 02:30:24 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC5086511
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 02:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52a39a1c4d5so6469049a12.3
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 17:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693355421; x=1693960221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wKkubAYJnrFhUzRWB/stXZzTVRheC7hfnrcTM7Gd/ZU=;
 b=C9D9Sw9MU7rb2xYnh0/mXXlQS5CwKiYhXj/nuq5eVqsUkT1oDfxTYgCgOfDyXyO3Xt
 7stteVH1MDz5wPMZsnzGCnBzNtk+spop0/RzC/Y204115zlCcCFeCQp7dRTtCwX2CNuj
 WtYQKmmS7yQiFfjYTV8+BscmZeivXu0S5z1uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693355421; x=1693960221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wKkubAYJnrFhUzRWB/stXZzTVRheC7hfnrcTM7Gd/ZU=;
 b=SxFuoeS3I05+HVZyPhuK7QvUFyt+J771LaVLPu6IKYWrR57L7X7s00H41abdvYqBXq
 BynSc1pcvxMvmji/FaKP+lJTcFVmfXvvKqKawaHEfY4C7vugtD0ntklXYa/zDCJbnpZG
 CTuHeNPafw31VVlkIlFB28OYpvE7RHsHYfsZ6MSMv/y2oWgNMgWkdsDGy60RTdiSZPlI
 AMKsk8gjKBaU6PDJng8Rj3gMTfenJluFA2R997WwQOE1zSf6BYLdPGsGqHmOezIn7ARo
 gdp8elOx1HzbFT8fs9npBMCILzXQ4p7i1ElnuRIxrxLXVatkLOEQ/nQdjtM6N/X6IpvA
 cdJw==
X-Gm-Message-State: AOJu0YyzviXnw8d2AQmffcX7uijja+Vb/awoLK619SXtYZPJPR1DKkDz
 R5mETQiGRGZUgebbdSPi1+DJyvm5MN1ATzdp8jXuDg==
X-Google-Smtp-Source: AGHT+IFjTtsPN2ny/qsY//vc8oSgnf5bHw8eZo6jZSXU1Rb0KP3bmckZYqjBiGvMmkZjkw245++SNxYrnD9yGIn1ybg=
X-Received: by 2002:aa7:c0ca:0:b0:523:33d7:e324 with SMTP id
 j10-20020aa7c0ca000000b0052333d7e324mr593822edp.38.1693355421072; Tue, 29 Aug
 2023 17:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230822174008.626239-1-sughosh.ganu@linaro.org>
 <169334277324.3085284.3185028999789447095.b4-ty@konsulko.com>
In-Reply-To: <169334277324.3085284.3185028999789447095.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Aug 2023 18:30:09 -0600
Message-ID: <CAPnjgZ2_3qVdA2bJd5fUuxZQ43VKGkNM9DfZ7NZgkkLLn5=fZg@mail.gmail.com>
Subject: Re: [PATCH v11 00/15] Integrate EFI capsule tasks into U-Boot's build
 flow
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>
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

Hi,

On Tue, 29 Aug 2023 at 17:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, 22 Aug 2023 23:09:53 +0530, Sughosh Ganu wrote:
>
> > This patchset aims to bring two capsule related tasks under the U-Boot
> > build flow.
> >
> > The first task is related to generation of capsules. The capsules can
> > be generated as part of U-Boot build, and this is being achieved
> > through binman, by adding a capsule entry type. The capsules can be
> > generated by specifying the capsule parameters as properties under the
> > capsule entry node.
> >
> > [...]
>
> With v12 of that one patch and v11 of the rest, applied to u-boot/next, thanks!

It's great to see this in!

Regards,
Simon
