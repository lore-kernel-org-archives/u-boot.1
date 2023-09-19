Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3FFCD54A7
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 08:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D470886B0A;
	Tue, 19 Sep 2023 10:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jq0AE32T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279C886A49; Tue, 19 Sep 2023 10:31:00 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DDD86B16
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 10:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-530bc7c5bc3so3702358a12.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695112258; x=1695717058; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdL/3OFzagnPJ4/Xmy/FqXOKBeE96BMuQPoaitW+MKc=;
 b=Jq0AE32T6krBKp9KWESFurwLLhewiZ8k5Zu+ZFvl1Ri3jmqXaYJxkgqF8pRUUGnrmS
 rBidP0J7fIjtlwIfZd5gm3x8KMm3I3uV04bThSwlH+XSKpNUQlFkWNBZ9u9nPNn3z6vc
 Yupy7U2a1ODnVmB4FqJpG9oObie3Co5K5lHdDpm5cD7A6v7wls2ToHDXm0rri+NBvpxr
 NupNqSUNwGWrc1EWGeYbs+gFZtEasp+c2mkD/upmgS3SP7896mbInRorGj4rbl0m8Qqm
 X7eij8bvgJ4RSY/0HghPggiXchtyDPq+zQQbkMtyosrJ2DP2wP8XgoqvDIhQWZBsQimd
 Rr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695112258; x=1695717058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdL/3OFzagnPJ4/Xmy/FqXOKBeE96BMuQPoaitW+MKc=;
 b=O9wLXdeOFGnqDvr53dZAHIepwv9M5ttzmUaNGxErudQ9wwcNJfDSJ1hP+OypsY8R9K
 fzTCegMR1BXZEX30VtiLp8f6+BxTdBhiAsY3QIn9ATC6bODkr/MoWs2M7iCxX1DCzOXs
 1RRregnu2Gfqd3Y7T2vWgBM1uwG7geQq+lCq1VkTp5nHnY+s1vK7Bu1uqns6AAzBz8t9
 8pEExQf+AvA0M8g4mE1XG7r3LfyX1kfFGzups6nB7hkvsukdNIbGt+oW0dzljmnCrx31
 225Fjf1HxeoMgK5X47kPMn4EE4IzmqHlQp9eO1uqsVXElABrTstaL6v6w9oS/roI6Qxz
 01QQ==
X-Gm-Message-State: AOJu0YyoeU8Rsc/D+pZtK4Ww18Fs7DdTE7MTV5hhc3hAioAFHYXGHDTX
 CS6ZXAtHvFkoZyYg2Z5hpJlMqjr76NRKKTc1XZM=
X-Google-Smtp-Source: AGHT+IEWsm6uuqy2zZ5fNRyppObfuSL0WqjcbEdp5LgxcO48c4XBa6r+3b/GuMRrD2a2LTvP3WhA3BhL/UBAvxnVJ3w=
X-Received: by 2002:a17:906:518d:b0:9a5:852f:10ae with SMTP id
 y13-20020a170906518d00b009a5852f10aemr11047867ejk.60.1695112256835; Tue, 19
 Sep 2023 01:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230907155825.48056-1-sjg@chromium.org>
In-Reply-To: <20230907155825.48056-1-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 16:30:45 +0800
Message-ID: <CAEUhbmWVMs2D1hKq2mVEF7UA3L4O+ajexErZQbNwGDxJsa5c9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] x86: Fixes for chromebook_link64 and
 chromebook_samus_tpl
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 7, 2023 at 11:58=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> These boards have various problems which prevent them from booting. In
> the case of link there was a recent regression with PCI probing added to
> SPL. For samus_tpl it needs a few tweaks to get things back up and
> running.
>
> This series resolves all known issues.
>
> For v2, the 'Avoid starting up PCI automatically in SPL' patch has been
> replaced with a global_data flag.
>
> Changes in v2:
> - Add new patch to allow marking driver model as dead
> - Reword commit message for clarity and to fix typo
> - Add new patch to mark driver model as dead when disabling CAR
>
> Simon Glass (9):
>   dm: core: Allow marking driver model as dead
>   x86: broadwell: Show the memory delay
>   x86: Add some log categories
>   x86: samus_tpl: Correct text base and alloc sizes
>   x86: spl: Change the condition for copying U-Boot to RAM
>   x86: broadwell: Avoid initing the CPU twice
>   x86: broadwell: Set up MTRRs
>   x86: dm: Mark driver model as dead when disabling CAR
>   x86: doc: Update the list of supported Chromebooks
>

series applied to u-boot-x86/next, thanks!
