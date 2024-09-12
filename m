Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB342EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 012AE88DFE;
	Thu, 12 Sep 2024 03:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P74BxN5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA7A88E0D; Thu, 12 Sep 2024 03:06:32 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E6E188DEA
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d4f8a1626cso348607a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726103187; x=1726707987; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8L8onyCiacCBMKaaM3gCoDrFPl8CzTsvHu8rUpr0lVQ=;
 b=P74BxN5HSoNqYrZWqcBsrr7ZqdR5D6zxm3MSI0gpSZkDIA5DxyXbG9XAZj+SBnKkVA
 nm2rYUeJA4bjctZR1Rfqo5zGgu3DweeXjjxKJpprTA+9tr7TTbzkaqh4wCUE3+g75die
 GTqNNJh10/kfIFfNS0nVTCrXyQvjyUemLvlJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726103187; x=1726707987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8L8onyCiacCBMKaaM3gCoDrFPl8CzTsvHu8rUpr0lVQ=;
 b=Cq+wJcSxXhUkkCdqLklJYzaLnaoXh3RmHeCsaVM4xDrc15/aC5Yu/X9QMaaZYCTYfv
 VieecKd3BsBQlmn01G5U94i/dxbPDSbCfW6B/w3cwugAFlv5VfVaP+HX0boBTdPMW9dy
 NDfWcJ63wgtj8vtweH529uVuguNiQBt5Jnsoo1uFalXPukJJK9RArZYhSwKUZvjBRaNh
 1OM1iEfrcOnVrl0eQ1zRbDgOaMGAk/QsUQGUPS9yGOD1+2sMWDetrIBy2SLzRmoOgj6V
 ZUGVjAtYLp7WrlS4DV2hsataNfhmO2Y0vBF5On+24vDME4lNiB4AJlk+CPY6ytSbuGAQ
 lhwQ==
X-Gm-Message-State: AOJu0YwbhrJLP2LKKOugJPa3632ylMa22XSgGu6Wn3ujQEz5b6yiRG+s
 c9bqQ1Z0sEaKntRVTg533Dw4u+K+nDf0Ko/tfEqipxreId861ShrUzfmHEjDB/+12Wv0cR1f4v6
 j1k+jLztwG8cRu0mkkBaMiQ7DBhPWURCNY2ii
X-Google-Smtp-Source: AGHT+IEnNJL6RcN5v8MKHLdVQgK9GxFm44XOjMcIrOtsEqUkzMwCQdrwRu5tnxSwKx3kmjtWIu1RrFgww3fUfLpgnkQ=
X-Received: by 2002:a05:6a21:2d8f:b0:1cf:4544:2581 with SMTP id
 adf61e73a8af0-1cf7620c9c6mr1334704637.40.1726103187125; Wed, 11 Sep 2024
 18:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhyRsC9TQ0qOSPG2acjnjH+QbWkYd7ATpyH1Z9KJ2wAXZcsyg@mail.gmail.com>
In-Reply-To: <CAMhyRsC9TQ0qOSPG2acjnjH+QbWkYd7ATpyH1Z9KJ2wAXZcsyg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:06:16 -0600
Message-ID: <CAFLszTiM4fjRse=tJUH96s87ArEwtqmoJRBc1OWHMQMWuM4BPw@mail.gmail.com>
Subject: Re: U-Boot SPL crashes after stack setup
To: Osman <aibaykaro@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Osman,

On Mon, 9 Sept 2024 at 21:20, Osman <aibaykaro@gmail.com> wrote:
>
> Hello,
>
> I am having a crash with u-boot-spl simulated in spike, to be more spesific
> the problem occurs after this line located in start.S:
>
> mv sp, t0

Which start.S and which architecture is this?

>
> and spike prints this:
>
> dmi_read(0x05 (data[1]) -> -1 because abstractcs.busy==true
>
> dmi_read(0x04 (data[0]) -> -1 because abstractcs.busy==true
>
> My first thought was that the memory was unaccesible but that isn't the
> case because i can see the contents of the memory through GDB (i will also
> attach memory.png that shows the address at the sp pointer) and i provided
> the memory for spl in spike like so:
> ./spike -H --rbb-port=9824
> -m0x80000000:0x20000000,0x90000000:0x100000,0x00000000:0x20000,0x70000000:0x10000
> $SPL_PATH
>
> My second thought was that maybe somehow the size wasn't enough and the sp
> just overlaps with some region but i checked the readelf (i will attach it
> as readelf_output.txt) but nothing seemed unusual.
>
> I am not really experienced in this topic so i would really appreciate it
> if someone can guide me on the right direction.

I'm not sure. Could the stack-pointer alignment be bad, perhaps?

OK I found that code in RISC-V.

+Heinrich Schuchardt might have some ideas?

>
> You can see the config files attached to end of this e-mail.
>
> Regards

Regards,
Simon
