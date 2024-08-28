Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF22BC7114A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 21:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268088857C;
	Wed, 28 Aug 2024 23:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NlpEnyZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 462868857C; Wed, 28 Aug 2024 23:25:14 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A7C88855C
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 23:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6bf9ac165d3so1956d6.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724880311; x=1725485111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S4DosyCKvMON4F4Ktx0Qjx9pqA8VICcoq8Agrea0z8I=;
 b=NlpEnyZkeKQmL8oTzqmyoqrZGcGUQJHtgPY+A1zmGTGFksge1GMz8LJS0EYb0CWCwH
 0kwD7nzQAriJCwqUACgobtQzm04P0nDZbKB0HNbEbi0JPrSAJ82me6PATPzUIluGNkrM
 rngK608ozN2/Z9horrAyw540i0vmtBFZ3YmOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724880311; x=1725485111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S4DosyCKvMON4F4Ktx0Qjx9pqA8VICcoq8Agrea0z8I=;
 b=TZ9WLLajnZ44mzMUODyzBvEucMQakrMK3rrQO8sxwZXGgetB5UdZNIzn5NquUVUdR4
 0Xp7FcQwX9TJPSnyrTS8ldbFXn0my7rUMT4D6n94U3+/HovpOy/zUxmxIEtt6QT8r71J
 QybZCq7hKwPxAVT0AeBlbQ09kb6k7LOk+itnpJBqjds30xjqhD+Ncn+RqPyab15FEKWW
 VSUpMxFixzwp1u5mImDqYjBNi+lsE8GrE9tboV1Vaa/0GPieL2KhtoZOE6AIRC5NN+Tn
 uI9A60JhH+ud4rFsCVcG0205cqbC5SKXwOitWQDRU9dk9tHOCyg/5np4pWNyYzK3q5gv
 1VvA==
X-Gm-Message-State: AOJu0YzfK0AvRbFug/g8L3MESr4fbNqtNdN9FR5cFR3/oyQ0AlNqZHbA
 Zvctz8StO0N5ZSGPC90Wc+9B0u/r5AhXH/BbCG0ZzcSrtn4xOf+Z2KpbUDG0vXzrIBT0ciU5qJX
 /z1G/RJzIT+9rZ579V9Wx2+FDiBfeE/cFf36hoQnoA3E19IM=
X-Google-Smtp-Source: AGHT+IG2szprOXQJP0aE7W2kOTvWBkUMrPmyzgxDLNE8O11Gg+TJYGGf9RF9yEriVoz+DoxXdRbQj6V6xmd3Tin42I0=
X-Received: by 2002:a05:6214:5781:b0:6b4:b179:8eea with SMTP id
 6a1803df08f44-6c33e5e4ed8mr9428296d6.3.1724880311182; Wed, 28 Aug 2024
 14:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <20240828201912.GV2479150@bill-the-cat>
In-Reply-To: <20240828201912.GV2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Aug 2024 15:25:00 -0600
Message-ID: <CAFLszTjzH9kiM3SEzfjfhCWMCMnLLeBy1UipH9kW0-z3s-1xxA@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
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

On Wed, 28 Aug 2024 at 14:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 28, 2024 at 10:45:23AM -0600, Simon Glass wrote:
>
> > With Labgrid we don't need to specify the various methods, except for
> > the console, which simply calls labgrid-client.
> >
> > This allows supporting any boards in your lab, without adding per-board
> > configuration to these hooks.
> >
> > Provide ellesmere files as an example.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> I think maybe we call this version "labgrid-buildman" and make sure the
> documentation emphasizes using buildman to provide U-Boot. This will
> make it easier for me to provide a follow-up of say "labgrid-external"
> that requires the binary to be provided, similar to our other hooks.

It can be used in this way. The 'ub-pyt -B' does a bootstrap of the
board without doing a build, if that helps to show the path through
the code.

If you don't pass --build to test.py then it won't do a build.

If you like, you can pass --build-dir (and with the testb series
--build-dir-extra) as you do now. The binary will be written to the
board as is.

>
> My thinking is that while it would be good to be able to expose labs to
> CI, and I would like to get mine showing up as well it's also important
> that I be able to keep doing the type I do where I extend the normal
> defconfig with additional features to test.

Let me know if this doesn't work for you. It is certainly an important use case.

Regards,
Simon
