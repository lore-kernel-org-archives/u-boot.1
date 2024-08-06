Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A115C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB30889A3;
	Tue,  6 Aug 2024 23:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a0EVYDIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3704888FB; Tue,  6 Aug 2024 23:13:02 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518C988A54
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b7acf213a3so5070646d6.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722978778; x=1723583578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xHCDICBPFquQzjy2QkEMXuQiJLZECGVwgHuRZllveIs=;
 b=a0EVYDIfBPJum/NM+FEH/W1ltfnRk3zK+X56rWBX+7+HSr2P1jUtccHgiH4azwaM93
 s7M5A6CJCDxgwVsofqTXmTyyPhwN3yc4gocpyt734GY4F6gp05cu9UHP48tTd5VBPouZ
 oCBuoYTA7xubNlx0bpkaoPFvI22LdxYc7iGLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722978778; x=1723583578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xHCDICBPFquQzjy2QkEMXuQiJLZECGVwgHuRZllveIs=;
 b=ZZUb/YjyUHQbndRYSX9GwtTDT1bvA6zmV/6nwsz0Nyhj5xGaT9vt8CHj+yzzKpejAK
 0Yd7tlRoWI1Vk1PdJBcS7vt7VrzXJzyjsqmRTCHi01e/H8IuOyhiOVq1RMoZuJ7cy/M4
 /nZsku6Y48Gqiky3KKOeEzeW8IfUL0+VuL5fYurl2jHoiiFgd2Xb5cJERN71rLWm75mD
 nJ7K8izWK23V1Hz+sMZZbfB91rjbsT9/xW4YbDJyjNGLHDuxsFxSZIZGtuzz8nBm+jzu
 wXWI9iaLnM6FPAuSna178mxKV6n/EMIE1L0hYb6Nq+hM13jqmNAprHaSAjOMuB7wBQhX
 iaAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdkjG3L9JIZUV1JH1ioK4DDAvaFXICzZHLBkLgWkgtJvToGVZLDQWZaJgk0xBHbzD2rceBfCE9VoUM7jFPAfTBdEau2A==
X-Gm-Message-State: AOJu0YxjbQ19v+UZkZhPcVNv04EWvu5KRgG0B3tDAAzoqIwirnmso7Im
 ji3fiRjK2Xl3eVHCVDMRR3MwEXTMg/dndyqLbvaZ7kapdUwItd+W5PczwJZTieIWmmBaRvcUABx
 qnxJ7nMw0sCShnIaM4K/qCJelJdG4ZhvbZEyF
X-Google-Smtp-Source: AGHT+IEi0yvUyNjLuYNZimnpQbFfXvWigaCKHdktuIfNO6WRVd8C4yZESD0trb9Zg+mKmekiSPoKmG7RSINsrghazHA=
X-Received: by 2002:a05:6214:3da1:b0:6b5:88:7cc8 with SMTP id
 6a1803df08f44-6bb9836f6e6mr183739326d6.7.1722978778316; Tue, 06 Aug 2024
 14:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1722615735.git.jerome.forissier@linaro.org>
 <20240802183249.GO3794063@bill-the-cat>
In-Reply-To: <20240802183249.GO3794063@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:12:47 -0600
Message-ID: <CAFLszThqMXGifQakKdWDwOYv0WXymk1C_3YVDvkKMgEsgS3Eyg@mail.gmail.com>
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

On Fri, 2 Aug 2024 at 12:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Aug 02, 2024 at 06:26:27PM +0200, Jerome Forissier wrote:
>
> > This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> > library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
> > stack [2] [3] as an alternative to the current implementation in net/,
> > selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> > reasons for doing so are:
> > - Make the support of HTTPS in the wget command easier. Javier T. and
> > Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> > so. With that it becomes possible to fetch and launch a distro installer
> > such as Debian etc. using a secure, authenticated connection directly
> > from the U-Boot shell. Several use cases:
> >   * Authentication: prevent MITM attack (third party replacing the
> > binary with a different one)
> >   * Confidentiality: prevent third parties from grabbing a copy of the
> > image as it is being downloaded
> >   * Allow connection to servers that do not support plain HTTP anymore
> > (this is becoming more and more common on the Internet these days)
> > - Possibly benefit from additional features implemented in lwIP
> > - Less code to maintain in U-Boot
> >
> > Prior to applying this series, the lwIP stack needs to be added as a
> > Git subtree with the following command:
> >
> >  $  git subtree add --squash --prefix lib/lwip/lwip https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>
> On Pi 3 I'm again / still seeing:
> ========================================== FAILURES ===========================================
> ___________________________________ test_efi_helloworld_net ___________________________________
> test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
>     assert expected_text in output
> E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at 200000'
> ------------------------------------ Captured stdout call -------------------------------------
> U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
> Using smsc95xx_eth device
> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> Filename 'EFI/arm64/helloworld.efi'.
> Load address: 0x200000
> Loading: #
>          883.8 KiB/s
> done
> Bytes transferred = 4528 (11b0 hex)
> U-Boot> U-Boot> crc32 200000 $filesize
> crc32 for 00200000 ... 002011af ==> 2b466005
> U-Boot> U-Boot> bootefi 200000
> No UEFI binary known at 200000
> U-Boot>
> =================================== short test summary info ===================================
>
> On a configuration that works fine with the legacy network stack.

BTW the "No UEFI binary known at 200000" is that hack that I would
really like to improve on, by updating bootstd to keep track of which
images are loaded.

Regards,
SImon
