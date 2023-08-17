Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34202C27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6726786B24;
	Thu, 17 Aug 2023 15:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kA8l68y2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 478B086B26; Thu, 17 Aug 2023 15:19:46 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A716386B18
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so1422078a12.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692278383; x=1692883183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4LHVOBYYWD3Nu6ZJO0xiAeiahbgnYzBZvElkPf2yRMk=;
 b=kA8l68y2xNT3D8XcPcu0D3uTeVgeSx3IKn7KyhT7QLQ4LMH7SQYMK7obQeD+kMRLHT
 3Zier/TpmSjxLaBie2wc5MpZZ9mwJ7U8wBjoljNls1efdRLpyO2NpIij4hliIIjBxEJL
 //0cXa9YlInUVVG+hzbw4kLmsspfAhmxsb81M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692278383; x=1692883183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4LHVOBYYWD3Nu6ZJO0xiAeiahbgnYzBZvElkPf2yRMk=;
 b=Yvj9kepbsw1Ko7vxMvA9KVnPWzs/MUdqvM0E2B8+BjWWnSg1g9PNWILNEJqG9/+Aiz
 wHBklbptfOnLbJPK1eyALKuofT4X77h3AA3iZTU6YvgBV4yKXFPmIkr79PhOVB52KdGI
 Fi14WrSWqEyBRABuBCmxShwKDtlL0qZ43xoIEugetu1nZdECHdv672gp3v4D1m1SL8D5
 L/BUbnhSloem6bj9I3/r8RE4Z643Zd2QBd5fxAnSXH0hGfGvD0UIhOToF6rAeRqzNu9M
 HNxBQiwiDtsI3Mkm3uhjeau4+p0UZ2IWVACmbWJTfwF86vKJ4b0aWLKdpIJvRTza67uK
 YCHg==
X-Gm-Message-State: AOJu0YyKevwPPD5UmvncZuHQ1eibXv/rEYphsSF0jZZQA4l+TNJ2sbny
 AEpl0YxX1QTfBFrr+RWaU+PCAPKDSPA9OSrvGf2dI78TM036wE9r2BdyzQ==
X-Google-Smtp-Source: AGHT+IHMgGgdEekCNS9jPZ8oE9MczuvX5GeiPDKUV2UNqs2w+FyHb9o5D+kR6SDpKkxajNVenyZks4vkOMQUBG+vTFI=
X-Received: by 2002:a05:6402:1854:b0:525:69ec:e1c8 with SMTP id
 v20-20020a056402185400b0052569ece1c8mr3226194edy.40.1692278383014; Thu, 17
 Aug 2023 06:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2g9JMptku2ZMmWeYxvYeV_MXkFDknL3rTXueVJz3otYhE5hQ@mail.gmail.com>
 <CAPnjgZ1xraxjR56Peyqj8HL-HEg7pZ9EkrW2=NG+6vYG+qVfow@mail.gmail.com>
 <CAM2g9JN9J_i5G9ctaRrimGhSepLEoQ=c4c2VJAua+HzMkB25tA@mail.gmail.com>
 <CAPnjgZ2pcam0wMFnd43pRDwcDb3NEtckbgV6T_6CshPy4B2TdA@mail.gmail.com>
 <CAM2g9JM4M9HtNz5rXu57J0KNjz_BTmG_XmoSy+4EiHmW-J25qg@mail.gmail.com>
In-Reply-To: <CAM2g9JM4M9HtNz5rXu57J0KNjz_BTmG_XmoSy+4EiHmW-J25qg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:19:31 -0600
Message-ID: <CAPnjgZ2-CfyNkHJwaL4uPyBnRTofgfXhtix2uLpr+a=t912xkA@mail.gmail.com>
Subject: Re: FIT Image not working in U-Boot
To: Freddie <fpidev23@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Freddie,

On Thu, 17 Aug 2023 at 07:02, Freddie <fpidev23@gmail.com> wrote:
>
> Hi Simon,
>
> I'm quite new to this so sorry for asking so many questions but where do I run the 'dump_image -l' command and which code should I look into adding print statements to?

One thing is to add your reply at the bottom, not the top.

Actually it is 'dumpimage -l file.fit' to list the contents of your
fit file called 'file.fit'.  The program is built in the tools/
directory or your build, or you can

I mean if you are completely stumped, go to where the error is
generated and add lots of debugging around it. This is
boot_get_kernel() which is in v2021.10 is in common/bootm.c - so just
add lots of printf() stuff there, rebuild and run on the board and see
if you can figure out what is wrong. From my side I am really not
sure.

Feel free to share the FIT through a link if you like.

Also, you could try using a simple FIT without the signature part.

>
> I have also just looked into my .config file and this is the contents:
>
> #
> # Automatically generated file; DO NOT EDIT.
> # U-Boot 2021.10 Configuration
> #
>
[..]

> #
> # Boot images
> #
> # CONFIG_ANDROID_BOOT_IMAGE is not set
> CONFIG_FIT=y
> CONFIG_FIT_EXTERNAL_OFFSET=0x0
> CONFIG_FIT_FULL_CHECK=y
> CONFIG_FIT_SIGNATURE=y
> CONFIG_FIT_SIGNATURE_MAX_SIZE=0x10000000
> # CONFIG_FIT_RSASSA_PSS is not set
> # CONFIG_FIT_CIPHER is not set
> # CONFIG_FIT_VERBOSE is not set
> # CONFIG_FIT_BEST_MATCH is not set
> CONFIG_FIT_PRINT=y
> # CONFIG_LEGACY_IMAGE_FORMAT is not set
> CONFIG_SUPPORT_RAW_INITRD=y
> CONFIG_OF_BOARD_SETUP=y
> # CONFIG_OF_SYSTEM_SETUP is not set
> # CONFIG_OF_STDOUT_VIA_ALIAS is not set
> CONFIG_SYS_EXTRA_OPTIONS=""
> CONFIG_HAVE_SYS_TEXT_BASE=y
> CONFIG_ARCH_FIXUP_FDT_MEMORY=y
> # CONFIG_CHROMEOS is not set
> # CONFIG_CHROMEOS_VBOOT is not set
>
[..]

This has CONFIG_FIT and CONFIG_LEGACY_IMAGE_FORMAT is disabled (since
you have signature verification on).

Regards,
Simon
