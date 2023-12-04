Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619D7C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2676878AB;
	Mon,  4 Dec 2023 09:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fRH12ssA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97CF58788D; Mon,  4 Dec 2023 09:28:04 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AD3A878AB
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50bf1e32571so1107984e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701678478; x=1702283278; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ol/6IkQAs2SvaatQI7mjIj0SLpZLbBcKrQB1qUhK1BY=;
 b=fRH12ssA4pUqR7o+/uDgzegKJGiS97Gr1CPNFk0PQk8TUtvAvnDM/LT+w1ZNo4YtoG
 rl7Ub/T8TS748adOz327Wgla5XjOktt0fpfOkzUa84JeKauHKQ9Iga37Uvsixz8zQoqn
 LfmWP4xCXyb9kZkacByDvOg6RoJ6ZpZ670tn9j+uvns6l2I2aYdxfXp+AUdHc+83d7Jl
 DMpK9DOiy8tP4y2drfzAMvqxu+4GjoTMPzBSSMqEaGBUCKS/XtYtGVXHAilfX3eP4SfO
 BmJQC5HKHutJ1RW6n0nmpOLTTzG8F6NC/kzmI3LGJY7zlwKtltaj2CGWup3+UVqO7nqN
 pvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678478; x=1702283278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ol/6IkQAs2SvaatQI7mjIj0SLpZLbBcKrQB1qUhK1BY=;
 b=KCIL7qXl7yLQmDa8uo3mc3MFgsrzaeTl+T8E7VOeps5o7soc5ncrniqL2iYRPDrnD9
 pCmduIgdBGotJ/CYseuZA9I+9cQ14xZuEDTnMkUCTFQqB4ynHlKMw5vWkrvNgrmrlRX7
 +0KO4YZCmi1SztOxzyyn1NJPCUciWSe15fN8X1xgLjF94BQyyr5tfZDdmHpH6Bfmb7YZ
 CWESmnUMFNoT7VQSpjoh2ULhsq2yObPA65Z1JVhkDoQzb78g0X9P+6VW0gLb0YKcvyHc
 RupU8t4SVb2EIpdgemJ5k8Z46+gUNX2adMNtj2OeszTRe7tPqu5QuagbrawmXkqPUEAu
 QsKA==
X-Gm-Message-State: AOJu0Yxt3y8vTY6F6Iz0TZOH1RnXvP4m8fhvvEMUIOlTH5ibtcgInFGX
 SmjCVi4czB0fi4l74gfO+AenLRfvrux1xqZFY3aBvw==
X-Google-Smtp-Source: AGHT+IFFidNrUwTgECcCyayJTnpdda4DcP3EtaDHcWh9vEPJPv7ZI3tQFadE+QKEQw4+0BqbjxHjjnkAH3v3egEMscA=
X-Received: by 2002:a05:6512:1089:b0:50b:fd41:85e with SMTP id
 j9-20020a056512108900b0050bfd41085emr253148lfg.109.1701678477805; Mon, 04 Dec
 2023 00:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-4-raymond.mao@linaro.org>
 <CAPnjgZ0Y+unk18YHXJALs-pBNOb3dU6WwrM_vsmBT_RBCq4UvQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ0Y+unk18YHXJALs-pBNOb3dU6WwrM_vsmBT_RBCq4UvQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 4 Dec 2023 10:27:21 +0200
Message-ID: <CAC_iWjLzUuzyH3+uUbU3bqnTSxB0fyDwhc4pB4bRQtzA9Us76Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] bloblist: Change the magic value
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson <seanga2@gmail.com>
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

On Sat, 2 Dec 2023 at 20:33, Simon Glass <sjg@chromium.org> wrote:
>
> On Mon, 27 Nov 2023 at 12:52, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > This uses a new value with spec v0.9 so change it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Update the bloblist alignment to align to FW handoff spec v0.9.
> >
> >  include/bloblist.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> But you will need a later patch (or update this one) due to [1]
>
> >
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index 1e4f1a6342..30441f922b 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -75,7 +75,7 @@
> >
> >  enum {
> >         BLOBLIST_VERSION        = 0,
> > -       BLOBLIST_MAGIC          = 0xb00757a3,
> > +       BLOBLIST_MAGIC          = 0x6ed0ff,
> >
> >         BLOBLIST_ALIGN_LOG2     = 3,
> >         BLOBLIST_ALIGN          = 1 << BLOBLIST_ALIGN_LOG2,
> > --
> > 2.25.1
> >
>
> Regards,
> Simon
>
> [1] https://github.com/FirmwareHandoff/firmware_handoff/pull/24
With this change
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
