Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF7CE7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 22:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF90A88E18;
	Sat,  7 Dec 2024 23:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cjhBOJ7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871AD89323; Sat,  7 Dec 2024 23:46:15 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F62188B6C
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 23:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa5325af6a0so500388866b.2
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 14:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733611572; x=1734216372; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MwQaIUZe3NGVzie8XjQkhJzpDbljHkJO2sqsX4dFWA0=;
 b=cjhBOJ7nIuKENtTDYYuz/LA7z1743O5PZR7BWlO6PhlD8vMTUeeiJ91PygBpNYm/fu
 Ac+uiJGthki55CiF29Apf0xfFyx9xXokN3X5Aahs8vy9kSNdoEm+RVxSeBmXgFXdpGXC
 G/nhrgvd3hMp5IXljCn9LaFpNrLTww0hLkLfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733611572; x=1734216372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MwQaIUZe3NGVzie8XjQkhJzpDbljHkJO2sqsX4dFWA0=;
 b=FmZbRsdY57MmWYEI5/jFJtg1eb14rYWEylLAAOOYYXyB+hEycJ1+r2px9ChjoW3fa1
 Ezj4A+LF3bW2hYxSF/3sKpwwdLZozrfsB4BuCaF3JX04Uxmvtp7hikMk8LK62BT7tdAc
 6VzOa4tWhSde+2WZ2/GDYkj5fhbeiDLCpC/9G81wH/uMjA/Gn1MwmpNMNVGVE1qhwScF
 07oWW5NzC5bhVMENZVi5nbUXaYCAiE/DUUotUe5yth7dm8kfdg1S2GC9CZiC3wAnAJFv
 MEGQiA/VSoVEnxutIVvKj40Ke7jriX7RAixfX2bdtW9J3fmkZoVXysYs/8mJZWZBSRvs
 JMQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIE47qwnO9wO9LIAjiFoIPRMWjpAG0Qt/e/rog/n9haIlwAbXw+jIP2rDMJY0LdLSJOjFmqok=@lists.denx.de
X-Gm-Message-State: AOJu0YzejxCg5QvFvaNJ1BZRCmnLs93j4hOmb0xwUXXwehLlyDSxn0tD
 jOFN6l32CsPReA2EHttBg5l2M3Wf5PftiBECO/xVjNcJBQwupi64+QRDv2csXhofTcAd2UMPqPa
 VRwhkobqW2lMKGcVNx/OJ35UJV+eGU5dcLDTs
X-Gm-Gg: ASbGnctfKaX9jVE0swLKkdtuu02qTZqyEIJjXE1dVYfgRH/NzeaGwKtZ2fXPZE8JuYS
 kbsWTjoP8ROeDDBW3wP4yxZ0Sr4iwT6Dh
X-Google-Smtp-Source: AGHT+IFzra72uu2aGjbZkmTwT4B4niipQqdZ0vnPcjSsu+Cc/iuEBbZvIXMd3hGD0ijKaX4BgIb79+efReYXpKbveN4=
X-Received: by 2002:a17:907:7809:b0:aa5:2575:e75d with SMTP id
 a640c23a62f3a-aa639fb0e31mr701357966b.2.1733611572535; Sat, 07 Dec 2024
 14:46:12 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTgnwTtUdgSHu6-1AC7cFU-oBNSp3oHAFTzisG5LmWs4gQ@mail.gmail.com>
 <20241207212749.GF2457179@bill-the-cat>
 <638B58C8-3E91-4EE6-96B0-13AC610F42C7@gmx.de>
In-Reply-To: <638B58C8-3E91-4EE6-96B0-13AC610F42C7@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Dec 2024 15:46:01 -0700
Message-ID: <CAFLszTg6U7RQw5rYFEn2a_mX_=aSCwh8uXQ8rWcSObj9v5APUQ@mail.gmail.com>
Subject: Re: UEFI messages on startup
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Heinrich, Tom,

On Sat, 7 Dec 2024 at 15:03, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 7. Dezember 2024 22:27:49 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Sat, Dec 07, 2024 at 01:48:41PM -0700, Simon Glass wrote:
> >
> >> Hi,
> >>
> >> I see these messages on startup with a rpi_4 - what can we do about
> >> this? It happens on every boot.
> >>
> >> ** File not found ubootefi.var **
> >> Failed to load EFI variables
> >> ** Unable to write file ubootefi.var **
>
> No, ESP was found to write ubootefi.var.
>
> >> Failed to persist EFI variables
> >> ** Unable to write file ubootefi.var **
> >> Failed to persist EFI variables
> >> ** Unable to write file ubootefi.var **
> >> Failed to persist EFI variables
> >> ** Unable to write file ubootefi.var **
> >> Failed to persist EFI variables
> >> ** Unable to write file ubootefi.var **
> >> Failed to persist EFI variables
> >> ** Booting bootflow '<NULL>' with efi_mgr
> >> Loading Boot0000 'mmc 0' failed
> >> Loading Boot0001 'usb 0' failed
> >> EFI boot manager: Cannot load any image
> >
>
> Neither mmc nor mmc has an ESP with EFI/BOOT/BOOAA64.EFI.
>
> I think these messages should be debug only.
>
> Best regards
>
> Heinrich
>
> >Please elaborate on what your boot command is and what's on your SD
> >card. I don't see that with just "bootflow scan" and I think an older
> >Raspbian on the SD card.
> >
>

This is with Ubuntu 22.04.5 LTS on a rpi_4

Indeed, there is no ESP.

Regards,
Simon
