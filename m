Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2892EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B06288D1A;
	Thu, 12 Sep 2024 03:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I3r93ZtK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CFE88D02; Thu, 12 Sep 2024 03:09:07 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C156588D34
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7b0c9bbddb4so324797a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726103341; x=1726708141; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EJ3ODUKoPEzVO63hB6/iTlPDCDhzMVmZs5KyjtU4uDk=;
 b=I3r93ZtKNYe9GV5OA8To31FGHguHrLox60TLdSDeWVPo2bXYsteBBytNk0YkdCeaAl
 W2HjcXzKaF2A5ef41Kc/X3ePy9Fu5Ef/gb/kHMfoLJeW2LZX9HAIGGQIsNkV0Zz6G34h
 /yS3DLbNu6xuqFMfdg70/Q4sPbESaPqI9eYMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726103341; x=1726708141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EJ3ODUKoPEzVO63hB6/iTlPDCDhzMVmZs5KyjtU4uDk=;
 b=bSVxk2P9vUnfWi4C6ZYF8LtzjvhnEdlgPapyTcFi3ws80ROjxHIIUndbteCyTk0z/g
 nczEtmYCMqQ2CWhXRSUeLLy9PYsxtZ6aUhinbwfRIWOuudBx8463c/mPvEoye9FmbYxs
 bowlJ8ZvRXgSAMhmZHPyQD29FlQG8jhKxSiCi/zx5BwsSLpwdIGL8pXVZIKl60Q4Tc35
 NLGVS5wNTDGbMLkHzyGcj8UsHCe1chPBs05H95rxysa0cYY62uhInUCLxvyT8HKnLhTq
 ZpIFSCetE9MW3cVyFNOimj482vkFt5VjKHg5J53gUgFc69KnZRRgd+gaQPQba0Dyor6J
 FkBA==
X-Gm-Message-State: AOJu0Yyihc9g2Pc4tSt7C3nF/izxXeSNm3YHEjJB+YBhdKiqbPiJu0e1
 WlE9hxEOu/VFL2BrDy0a7NZYX0tZqp/yvLXL8d7q89ZJ0o+uWip3OHcLPnq09QnYSziXyEUeJr/
 Czq1woGn9wyPZlmVdvo9/p3kawJztQiK0XbdogNnJTs4AMFgTfA==
X-Google-Smtp-Source: AGHT+IEi3akY/5L9kzJP5qITKEGU/bUpYJWdKrSW4KADHfM9dBrywKVNTlX+GHGUrf0D5elC1uR+C2v8/idTS5ACX+U=
X-Received: by 2002:a05:6a21:170f:b0:1cf:440a:d447 with SMTP id
 adf61e73a8af0-1cf75e79812mr1604463637.6.1726103341285; Wed, 11 Sep 2024
 18:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAA411mfoFoZSAre8HefwrgW-Nn5Ya4O+YWeHvcPUnK=3HHKHiA@mail.gmail.com>
In-Reply-To: <CAA411mfoFoZSAre8HefwrgW-Nn5Ya4O+YWeHvcPUnK=3HHKHiA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:08:50 -0600
Message-ID: <CAFLszTg56ioMZdSYSuccjz08e76J9_HKE_K-XL4hsmdciBpN7g@mail.gmail.com>
Subject: Re: DE1-SOC LKM MAKEFILE ON U-Boot SPL 2013.01.01
To: aied bebar <aiedbebar2@gmail.com>
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

Hi,

On Mon, 9 Sept 2024 at 08:25, aied bebar <aiedbebar2@gmail.com> wrote:
>
> HII , I AM USING A DE1-SOC BOARD THAT IS BASED ON U-Boot SPL 2013.01.01
>
> THE BOARD IS :Altera SOCFPGA Cyclone V Board
>
> i downloaded the console version of linux os from terasic and its working
> fine on the board
>
> I am trying to load a simple lkm that prints "hello world" on the kernel ,
> and in the makefile we need to specify the source directory location. I
> tried all the options and examples of makefiles that I could lay my hands
> on , and nothing seems to work .
>
> in some cases it worked but when i try to load the module on the board
> using insmod command i get "invalid file format  "

The module needs to be built for exactly the same kernel version. Any
difference at all in the version number will cause it to fail.

>
> i tried to get some help in roketboard forum and in intel community forums
> without any success , so i thought maybe i can get help from you cause from
> what i understand the console ver is based on U-Boot SPL 2013.01.01
>
> i need to know the path where are the source files located in U-Boot SPL
> 2013.01.01

Perhaps this:

https://github.com/u-boot/u-boot/tree/u-boot-2013.01.y

That version of U-Boot probably belongs in a museum at this point! I
won't ask what version Linux it is :-)

>
> and if you have a make file that is tested on the de1-soc maybe for
> compiling linux kernel modules (device drivers) i be glad for any help
> ,thanks in advance

Regards,
SImon
