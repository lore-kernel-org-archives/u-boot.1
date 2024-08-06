Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988D9C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C62A88C3D;
	Tue,  6 Aug 2024 23:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fKRhnjr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E5288CDC; Tue,  6 Aug 2024 23:51:56 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4024388BCF
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb4c584029so918436a91.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981111; x=1723585911; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2/0HZDerBjDWX/sJBTr/OWEsPlV/Z1br67e1iNWgMyA=;
 b=fKRhnjr9tSAbw+psOrggYzKJykQd8pfspyb9vgfKdV7xTJfVEwYujg04mGeK1CT+fO
 WSdnTrF7QD7nZnJjJZC9Q3gbIDpmWKBR0jIiU9k4UCOlDRvXs8KIZKPY85FMAdA+M39K
 Knb6NEQoJXIMCyijrRv1w/S43LcYB346bvBvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981111; x=1723585911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2/0HZDerBjDWX/sJBTr/OWEsPlV/Z1br67e1iNWgMyA=;
 b=JfO0lW6ba5L3eJGLju4KuqODmieKySeuagOIi7ggGLInxs92/byCS5QF2QeMP4aSEF
 NsrZCfv9MenkpRGyn/cpRec/BLwf4PWeMDkIZ4cueQb6MieYj8XCpcv1zAw6jOysZRGG
 SJuKZgQJ0fBcRk2IwLpSqAjiW/3gYVUK1Ot9fxYM3Y+R7YR1X/sK9z24efejRrtKzFgl
 aGZgbFiZQ7+J3VIfiehqAAoHhKlDKAQL1LcywtOICxIqG6bJLNz8WkKscdfKd9K3exMx
 /3SgflqgzuJho+0uu6S6KgzDztNeye2g98ZEdkIwZuJajr4HfATOy7H//ID2P3Ttsysm
 4IIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViAedfIZmLoP1DI/XhcAKd9YnYZxlySenyfFAZSyEvEnm2Yr2Txl/a7SKeMg+Yfblktyz7Q8Qo+ROnowBak/+5bu0P/Q==
X-Gm-Message-State: AOJu0YwZS+1XO64DwuIEdF88v95q4PUUFpx62a21Q96TtSBIWj+DGocj
 x0soo4qq2JpkkgEY+N4SW4lP892OdeYrJiaD0GGeQz3f10XqH/yMUdVtMk5QKK1VWrb9zUx6Qov
 /kNdIH3LkA6Z39oWb0XXrJQnTbxgIxnR+X+HP
X-Google-Smtp-Source: AGHT+IHiyBtGTNh9n3HaS2lZR+5NnLyotuFCQUNtTWKJKfkHmrjtf2cTqTIJ7SfQWl+N53VtCLZQWen8Ja8Zb9BksFw=
X-Received: by 2002:a17:90b:384:b0:2c9:815a:80cb with SMTP id
 98e67ed59e1d1-2cff9444f23mr14903250a91.21.1722981110698; Tue, 06 Aug 2024
 14:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1722615735.git.jerome.forissier@linaro.org>
 <20240802183249.GO3794063@bill-the-cat>
 <CAFLszThqMXGifQakKdWDwOYv0WXymk1C_3YVDvkKMgEsgS3Eyg@mail.gmail.com>
 <20240806211902.GC1626301@bill-the-cat>
In-Reply-To: <20240806211902.GC1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:51:39 -0600
Message-ID: <CAFLszThrSsdW4Tsjhe8YmoU74YoACSyqra-FhqiocZ2-eMjD0w@mail.gmail.com>
Subject: Re: [PATCH v7 00/20] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Eddie James <eajames@linux.ibm.com>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
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

On Tue, 6 Aug 2024 at 15:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 06, 2024 at 03:12:47PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 2 Aug 2024 at 12:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Aug 02, 2024 at 06:26:27PM +0200, Jerome Forissier wrote:
> > >
> > > > This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> > > > library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
> > > > stack [2] [3] as an alternative to the current implementation in net/,
> > > > selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> > > > reasons for doing so are:
> > > > - Make the support of HTTPS in the wget command easier. Javier T. and
> > > > Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> > > > so. With that it becomes possible to fetch and launch a distro installer
> > > > such as Debian etc. using a secure, authenticated connection directly
> > > > from the U-Boot shell. Several use cases:
> > > >   * Authentication: prevent MITM attack (third party replacing the
> > > > binary with a different one)
> > > >   * Confidentiality: prevent third parties from grabbing a copy of the
> > > > image as it is being downloaded
> > > >   * Allow connection to servers that do not support plain HTTP anymore
> > > > (this is becoming more and more common on the Internet these days)
> > > > - Possibly benefit from additional features implemented in lwIP
> > > > - Less code to maintain in U-Boot
> > > >
> > > > Prior to applying this series, the lwIP stack needs to be added as a
> > > > Git subtree with the following command:
> > > >
> > > >  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
> > >
> > > On Pi 3 I'm again / still seeing:
> > > ========================================== FAILURES ===========================================
> > > ___________________________________ test_efi_helloworld_net ___________________________________
> > > test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
> > >     assert expected_text in output
> > > E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 200000'
> > > ------------------------------------ Captured stdout call -------------------------------------
> > > U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
> > > Using smsc95xx_eth device
> > > TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> > > Filename 'EFI/arm64/helloworld.efi'.
> > > Load address: 0x200000
> > > Loading: #
> > >          883.8 KiB/s
> > > done
> > > Bytes transferred = 4528 (11b0 hex)
> > > U-Boot> U-Boot> crc32 200000 $filesize
> > > crc32 for 00200000 ... 002011af ==> 2b466005
> > > U-Boot> U-Boot> bootefi 200000
> > > No UEFI binary known at 200000
> > > U-Boot>
> > > =================================== short test summary info ===================================
> > >
> > > On a configuration that works fine with the legacy network stack.
> >
> > BTW the "No UEFI binary known at 200000" is that hack that I would
> > really like to improve on, by updating bootstd to keep track of which
> > images are loaded.
>
> I don't know, if I think about this I get worried that "bootFOO
> $address" needs to know something more than "look at $address and check
> if it's valid".

Yes, that is the problem with EFI loader at the moment. But basically
it just wants to know what device the file came from, which we can
(over time) clean up so that it is part of bootstd and uses proper
APIs. Random loads within scripts are perhaps another matter...

Regards,
Simon
