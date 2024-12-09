Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3F9E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 23:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05E2089788;
	Tue, 10 Dec 2024 00:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UZLt+Ira";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C93889787; Tue, 10 Dec 2024 00:27:43 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D2F89788
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 00:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa696d3901bso198893366b.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 15:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733786860; x=1734391660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=inIHLblj2cfy7VzjbV7+PP83QcsA3zrNKOvKbP7Ipmo=;
 b=UZLt+Iravl6flcNhtJxQ72yZaqJF1ZSaZk+rSqwEL0U71WqqhlvaVT7M4GFL97gGZb
 hjpob+NyA6FbiRc/0oG8+rESDjxYJhKb9njJHTTpI+MJPWs67KcCySRjBEv8VpEc1gW+
 m19xXUjf8o2RMGsX4M1+olXzdSITLCW7ca/pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733786860; x=1734391660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=inIHLblj2cfy7VzjbV7+PP83QcsA3zrNKOvKbP7Ipmo=;
 b=UduJloA36K+2MUNGohG4/ntNptWlBADMn9qVEE6aqnnviVHy4LHAtM3xz5RmVXcDs7
 VXr8QVZ5yGahsd1aEwFsTxG3Nx3glJ+6Q7pEovXBQ0bMSymdMyQ6wpmAvq2P3L8CTx+n
 bat9sefVsWVXylbmUOfq12VsCXfrBt8UMVRssbztgj7k9PI5YoqUqcx/1no5O7s42+xF
 dp6/9iytk1VeJlobS2DTzFatDgEmS8hxALHFIWzkHhBQIbHsoIleNRmA/FPW4uuS4/kq
 YJLK8OeUoCmRYgioIDuPzxwBdiI184GBo1pZ7AWFwycK7wl7h8eghHxiplkbtGqcsIP4
 MtNg==
X-Gm-Message-State: AOJu0YxqbtmX6c06yLUfqCjmKoQkmj6ioJf/E7UT6SBtFIyDgMdw+25P
 dYgW3ZYgIJeFAzvpIcCI5rQX2/EPPav8WBn68Ay9OMKEAdr13kzp+gyuDlXfMsEwl8mbBzjS5Yv
 lmLOp/VbN7GkvaIVtE7UOsuRqa6/t4TgS2V2g
X-Gm-Gg: ASbGncvjajcrQuPbNhrGFKo0KxjcRwSFARCzdVNFd07L5M3Igc80OQcfH9+fKGU4HJp
 JXvjck1PYD+Mx7YOLnbB9hF0GjA64hOMUOa6r
X-Google-Smtp-Source: AGHT+IHxd4L0GMIk0VnWXCG2J1wfPdOpBob2mgzed6Z39ufVKCHZ4fH0/TSaYIHaqvhprntPDYsUX/2JxZ3bAwRnDzc=
X-Received: by 2002:a17:906:cc2:b0:aa5:27d4:980a with SMTP id
 a640c23a62f3a-aa63a242b13mr1222436666b.49.1733786859852; Mon, 09 Dec 2024
 15:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20241209182002.671953-1-sjg@chromium.org>
 <CALeDE9O6Z448edqH4MubyB03yqip_c5qrE00_Ynx9mHvrn5dCg@mail.gmail.com>
In-Reply-To: <CALeDE9O6Z448edqH4MubyB03yqip_c5qrE00_Ynx9mHvrn5dCg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 16:27:27 -0700
Message-ID: <CAFLszTiuUovE8-ex_J7QPAwyWDMpQPwSvQ_kihRZusv5+2m9fQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rpi: Tidy up booting
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

Hi Peter,

On Mon, 9 Dec 2024 at 16:06, Peter Robinson <pbrobinson@gmail.com> wrote:
>
>
>
> On Mon, 9 Dec 2024 at 18:20, Simon Glass <sjg@chromium.org> wrote:
>>
>> This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
>> ramdisk, by expanding the available space.
>
>
> What version of the RPi hardware have you tested this on?

Only rpi_4 and rpi_5

The U-Boot change itself is tested on rpi_0 and rpi_2 but not actually
booting a kernel[1]. I don't seem to have an rpi_1 in my lab.

>
>>
>> It also tidies up some strange behaviour with the provided FDT, where a
>> separate pointer is maintained to it, even though U-Boot has copied it
>> and placed it in its own space. This avoids strange bugs where it
>> accidentally gets overwritten when loading a file into memory.
>>
>> The patch to expand the devicetree was dropped, meaning that people
>> should be careful to unset fdt_addr in the environment.
>>
>> Changes in v2:
>> - Add new patch to make myself an rpi maintainer
>> - Add new patch to set bootm_size
>> - Add new patch to drop fdt_high and initrd_high
>> - Drop patch to allow expanding the devicetree during relocation
>>
>> Simon Glass (5):
>>   rpi: Add myself to the list of maintainers
>>   rpi: Set bootm_size to 512MB
>>   rpi: Drop fdt_high and initrd_high
>>   rpi: Update environment to support booti and large initrd
>>   rpi: Use the U-Boot control FDT for fdt_addr
>>
>>  MAINTAINERS                   |  1 +
>>  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
>>  board/raspberrypi/rpi/rpi.env | 24 +++++++++++++-----------
>>  3 files changed, 22 insertions(+), 23 deletions(-)
>>
>> --
>> 2.34.1
>>

[1] https://ci.u-boot.org/u-boot/u-boot/-/pipelines/82
