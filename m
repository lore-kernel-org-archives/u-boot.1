Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A32C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD5F68798F;
	Tue, 24 Oct 2023 20:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ivRkMJ/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D2EF87988; Tue, 24 Oct 2023 20:02:39 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841E787973
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso685033666b.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698170552; x=1698775352; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ftX2NFosZ2tE87CllENgMBPMXfGC7yIcvtZnKcSg3w0=;
 b=ivRkMJ/wnGalDOQBqOcuKCft0iih9To9d9fARnBQNBUZdslzEpcbT1RuXmjZYYCXIi
 OOAiWSJ6lOi0KRE4IW5a9FbPSf/2gLIfmhCcc/ONBn93Sk7u6ABkUVWFW918d7Ur7xoQ
 Gq32qV9oP9KdmRgqHpQl7I+Y4gr1R51+PrEHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170552; x=1698775352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ftX2NFosZ2tE87CllENgMBPMXfGC7yIcvtZnKcSg3w0=;
 b=usk35EZ9hmmbfhmvaJJZiLm3vLkxr8Hg+3mt9gHrb/JaSAa4vnnOZWZ3nY4H7+RjKh
 wKvxWcM0o/bRbSIhBm7DB6oE7NrCMwgOe7B/HIP5myb6H+v78+kaBkf53wbL2nY3EgkE
 infPSht6FC0o63nW3M1/Y3eiXBXo31mhwsltPdEZAeZWxqM/RyCSfib+A7kwIwfZmAo4
 mXmTH7VrZ17wg6v0tY3rXt5UswQgsRjBw6dupUK90Co4JbxRAcSOWShtyKf+43cW5Chz
 wbIeoJINonCAHDsLFuFBQelXQAigVEnB6PV3AxGTnzINfXjFFUdXapo/pBhqw4i3/gM8
 sLlw==
X-Gm-Message-State: AOJu0YzPZMhnZ7lzBK8M5UhXExO2l8koMi/9peFQ/O1Gaz2O7gRjsxDU
 ueS3XUKVf4pP4kRDFUf9perc1YEWlP6VHpA6TxZ24g==
X-Google-Smtp-Source: AGHT+IFc6cd35cEpsa8OpdnzXXh3LivfBdHyoignk3DZx9CCLzFsQiF7gPfcFbIVKFA/5m69mHDib4pI44B64V7X86o=
X-Received: by 2002:a17:907:97d4:b0:9bf:63b2:b6f0 with SMTP id
 js20-20020a17090797d400b009bf63b2b6f0mr9588023ejc.29.1698170552083; Tue, 24
 Oct 2023 11:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231019150105.714407-24-trini@konsulko.com>
 <20231020215302.3511807-1-trini@konsulko.com>
 <20231020215302.3511807-2-trini@konsulko.com>
 <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
 <20231021183438.GB53397@bill-the-cat>
 <CAPnjgZ2bKVTwEKcjeawootxXr-+iEmiowtctA52-=v07p+xBUQ@mail.gmail.com>
 <20231023133728.GH496310@bill-the-cat>
 <CAPnjgZ06w+uaSZr6PWo6NFoWfxiNuu-bar4e3zn+bVL-4wPvUQ@mail.gmail.com>
 <20231023172757.GV496310@bill-the-cat>
In-Reply-To: <20231023172757.GV496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 11:02:06 -0700
Message-ID: <CAPnjgZ3G8T3ZjRNMdu=Jr_1OgijgQXNARQwAMQUFNy7ng4_zqw@mail.gmail.com>
Subject: Re: [v4.1 2/2] CI, pytest: Add a test for sandbox without LTO
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Mon, 23 Oct 2023 at 10:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 23, 2023 at 10:13:52AM -0700, Simon Glass wrote:
>
> [snip]
> > BTW buildman supports -L which disabled LTO using the NO_LTO=1 option
>
> I worry about putting sandbox-specific flags in buildman.  Outside of
> sandbox, targets that enable LTO require LTO, just like any other CONFIG
> option.

Some problems with LTO and why I don't normally develop with it enabled:

- build time
- code moves around all over the place so it is hard to compare size growth

At least for my IDE flow, I use -L in most cases. Yes there are some
boards which won't fit without LTO, but I don't see them much.

So this is mostly a dev convenience / productivity tool.

Regards,
Simon
