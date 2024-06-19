Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7F2C27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 17:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3528844F;
	Wed, 19 Jun 2024 19:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LciNY3jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF16C8844F; Wed, 19 Jun 2024 19:19:46 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B784F88428
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 19:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ec1620a956so67639271fa.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718817584; x=1719422384; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zY5+VGmstmxGYjmiho6SykUZTlm0XGmbzYvax1JGggg=;
 b=LciNY3jlbKZzDUiv1/QHflqwvN8Cs4kP6/wYjDVvu/XnFXOT5gBwNuzhjpLQDHvXYl
 b5r4oiqypj07EZzIXyGvIYIdsvmm7aafJn2CwT83VASF//CniGSDyA9jKjHwoSQ18K0y
 Q0qOQ1qZ2NhY11rJ5Kau7a//MO4sho9x3jvOBwRZn2AX6bu8/k8pDmA9aCG9oZrIbfoz
 Qeg2uOXRAoNtLH4mDqZxqpy7t7x+YPuOQpL/01EB3qKzlLDYiUleRYxrWC5kTZk82aFX
 EWM6MMoHB/Y94QXPy/FZe5P2NQFdkb+Dpo91wLbuFuDVP5b+02FZdMQCb49XAi1eOgy8
 C/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718817584; x=1719422384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zY5+VGmstmxGYjmiho6SykUZTlm0XGmbzYvax1JGggg=;
 b=jwlt131CIfMoIrfu307TimV3ICUr2uusrhG5p7wBNvYqBox3u8XfJG94F66iE9Kmtf
 E2ek+JxTiG0UbRStku90PryP4VaA0Igp8jMRmYOEBmd4IfTVjHPN4JFgPZSWYTwKd0pz
 gvLBLQPVWOf88AwsvOwpStnwuqGqN8rNR5K5odH8xPnVfgEf9nWzCm5a58JGS+mj4HC6
 qe6hN4ZkeI2EyCh/AiNPL/OYIbCfEeFazwC6lGdR9Ms0BBD5mAd6S8TSO0Mt+mBi3cBB
 FNLsI5FlnOsAZxzd7vZOfpEwtcPWptOy+lbk4IOIupnU8J9jIRhuv7+M/VXrMT0zrc4J
 v7TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUgRXU3r81boSd1er4QkvXaOO6DEEpTnZAtycTU+p9mam1LlcfJc1iSn3EaEfn9wHam99wO0rid1rQc9CXH4j1ggqvrQ==
X-Gm-Message-State: AOJu0Yz+r4IXAxonAQwmXkbCYUv8auDFQQGSD9vsKO3SybY9xv0GWVrv
 vcSbxGDCLgalP/EynqLFstMnYD2ecXv/s5KHks7JZqwOKqR5N92wxUBRcH322SZO+WIx6Ske0Sa
 8YEwXkyTksuJ8x3HGngGxUAxhrrA=
X-Google-Smtp-Source: AGHT+IFFT3x8MkoF9LRf315wJQ2tjVLQjxyZE0aQLuFQQxAMfK7rub3XaYfjblaCw7L9SdVT/MWn8vKdHOvBMJaLR7s=
X-Received: by 2002:a05:651c:1a23:b0:2ec:3d5f:7a36 with SMTP id
 38308e7fff4ca-2ec3d5f7c1fmr22656031fa.23.1718817583673; Wed, 19 Jun 2024
 10:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <20240618202123.GW68077@bill-the-cat>
 <CAC_iWjJt=ie4jD2yUbCNXU-WEGUmvo_GToCwfWsOTWot3+r8Vg@mail.gmail.com>
 <e43d7a84-0348-4655-80d8-f91b9232bdbe@linaro.org>
In-Reply-To: <e43d7a84-0348-4655-80d8-f91b9232bdbe@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 19 Jun 2024 18:19:32 +0100
Message-ID: <CALeDE9OPyePDvkf1t0rPSRZzVrYL5uhWN=C7m8g03-J9+vgDuA@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>
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

On Wed, 19 Jun 2024 at 16:06, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 6/19/24 09:24, Ilias Apalodimas wrote:
> > Hi Tom
> >
> > On Tue, 18 Jun 2024 at 23:21, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Mon, Jun 17, 2024 at 05:32:52PM +0200, Jerome Forissier wrote:
> >>
> >>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> >>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
> >>> stack [2] [3] as an alternative to the current implementation in net/,
> >>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> >>> reasons for doing so are:
> >>> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
> >>> has some additional lwIP and Mbed TLS patches to do so. With that it
> >>> becomes possible to fetch and launch a distro installer such as Debian
> >>> etc. using a secure, authenticated connection directly from the U-Boot
> >>> shell. Several use cases:
> >>>   * Authentication: prevent MITM attack (third party replacing the
> >>> binary with a different one)
> >>>   * Confidentiality: prevent third parties from grabbing a copy of the
> >>> image as it is being downloaded
> >>>   * Allow connection to servers that do not support plain HTTP anymore
> >>> (this is becoming more and more common on the Internet these days)
> >>> - Possibly benefit from additional features implemented in lwIP
> >>> - Less code to maintain in U-Boot
> >>
> >> So, on a Pi 3 (rpi_3_defconfig) I see this now (and it passes normally):
> >> ========================================== FAILURES ===========================================
> >> ___________________________________ test_efi_helloworld_net ___________________________________
> >> test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
> >>     assert expected_text in output
> >> E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 200000'
> >> ------------------------------------ Captured stdout call -------------------------------------
> >> U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
> >> Using smsc95xx_eth device
> >> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> >> Filename 'EFI/arm64/helloworld.efi'.
> >> Load address: 0x200000
> >> Loading:
> >> Bytes transferred = 4528 (11b0 hex)
> >> U-Boot> U-Boot> crc32 200000 $filesize
> >> CRC32 for 00200000 ... 002011af ==> 2b466005
> >> U-Boot> U-Boot> bootefi 200000
> >> No UEFI binary known at 200000
> >> U-Boot>
> >> =================================== short test summary info ===================================
> >> If I disable that test, it moves on to failing the same exact way for
> >> grub. If I disable the grub test too. After that, oh, a bunch of other
> >> tests get skipped because CMD_NET and similar aren't enabled now, and
> >> the tests are wrong. I'll post that as another patch by itself. After
> >> correcting for that, we're seemingly noticeably slower as I need to
> >> increase the timeout for tftp'ing my 83MiB FIT image I use for kernel
> >> testing. We no longer have the estimated speed message, so I can't as
> >> easily say how much slower it is. After increasing the timeout, the
> >> kernel boot test does work.
> >>
> >> I can note that normally it takes ~18ms to get a dhcp reply, but with
> >> lwIP it's now 132ms, and previously the kernel loaded at 2.7MiB/s
> >> (which, not great) but if that has a similar level of slowdown, could
> >> well explain it.
> >>
> >
> > Thanks for taking the time. We'll run the pytests before v5. That
> > being said, my wget tests were faster with lwIP last time I checked.
>
> The reason for the slower TFTP is the block size. lwIP supports only the
> default (512 bytes), while the legacy stack supports the 'blksize' option
> and sets CONFIG_TFTP_BLOCKSIZE=1468 by default.

This number looks like it's derived from standard ethernet frame
(1500) minus default packet sizes to get to 1468. Does LWIP have a
concept of MTU? I would have thought it would be better to use MTU if
so because it then means it's not hard coded and it can change based
on what the driver/HW supports?

Peter
