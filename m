Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E3AC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF7CF87119;
	Sat,  4 Nov 2023 20:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kUpqfGF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24BF8712E; Sat,  4 Nov 2023 20:44:51 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDE787136
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54366784377so5146287a12.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699127061; x=1699731861; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwODeYxBZO+bydUMSX+ReMK4znq4CzHgrI38YUiTKjM=;
 b=kUpqfGF9hariV6EYNclS56FuXzTcB/2y7zgY5nsZ42f3qbHfMYgWa3/gczn+JiXmyc
 1gtz9uHdSB6PWqqEV9ECWlZw7jsb31ZUr9pM4dm1Qr7C7GQYQRa0L1i63pUmUkPW2uvN
 4Tl373RsCS4FQZQqsvEABatklQHfODKjQd6uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699127061; x=1699731861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwODeYxBZO+bydUMSX+ReMK4znq4CzHgrI38YUiTKjM=;
 b=iKkMd+jTPw6VBE9w97+vRAF8j21HemjT0YYBxhgOMLaaUPV5Lds8Xbz0g1RpufqvS2
 9kN+mtlJfl8VKJnUsSgbbpM0H5MW6vtuMd0mJOcnmZyjofT7DkJTvNNY5t1XYRhpYYjd
 YbOSZNREnkiSBvs2B7YKRlrku7uXDGhIvGTVMRPqYDc+HGhgVyy/r1j0HUrc1PJK4Zjb
 z/0bFtqVfR4gAXq635pjQGcmiZFA49f/Cfa3gOEja0uW1XZ52uZjA2Xd7jw9TxBaDgYM
 NJaPk7OSAiR4TO/0Hz0ZtgjlRoKEQeovIi0SBto4eBVNQaL0L38kl3XhqdIigDziuL1E
 emjA==
X-Gm-Message-State: AOJu0YwAnwBBEyMWvmySq6BHQVw4jBI39O+eWORLcTfKMQtPNZHK6foa
 jxPbEWhp1UqlUYN+NNWfqjdByvDKaaa0jfTtV3+GGg==
X-Google-Smtp-Source: AGHT+IFLVo3vFfszWAQt8P0VHvGlr66UXExMNeZgAVznJLvvqZxTFwlXn9FpwOTP6o74IIIjEPhbRLppFAbCQRm9sxE=
X-Received: by 2002:a50:9f21:0:b0:543:5b61:6908 with SMTP id
 b30-20020a509f21000000b005435b616908mr14249258edf.18.1699127061024; Sat, 04
 Nov 2023 12:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <DDC56A09-6749-48A5-A4E2-B58D2BD5C7D9@gmail.com>
 <CAPnjgZ2BaOKxCHa2D7GHpAQfg83DBjqrMT4vvPaRT7pNgKAJfg@mail.gmail.com>
 <CAEFUPH13Q2dtYxrB_NgScS=aEo7QJ7Dev2MO+oyL70ydh5cOSg@mail.gmail.com>
In-Reply-To: <CAEFUPH13Q2dtYxrB_NgScS=aEo7QJ7Dev2MO+oyL70ydh5cOSg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 19:44:09 +0000
Message-ID: <CAPnjgZ274iS=FjkbLT-XKJpVxpFRPaHx=OKvyA+E42CBEGz8xA@mail.gmail.com>
Subject: Re: U-boot env in binary format
To: SIMON BABY <simonkbaby@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 1 Nov 2023 at 18:58, SIMON BABY <simonkbaby@gmail.com> wrote:
>
> Thanks Simon.
> I will try this command. By any chance how do I find the environment part=
ition size in my target?

(please do try to avoid top-posting on the ML, and keep the ML copied)

I think this depends on your platform, but you might find the
information in the fixed-partitions node in the devicetree?


- Simon

>
> Regards
> Simon
>
> On Wed, Nov 1, 2023 at 1:22=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>>
>> Hi Simon,
>>
>> On Tue, 31 Oct 2023 at 17:07, SIMON BABY <simonkbaby@gmail.com> wrote:
>> >
>> > Hello ,
>> > Can I know if I could generate uboot env file in binary format as part=
 of my build process ?
>> > Currently it generate as a text file .
>>
>> There is the tools/mkenvimage program:
>>
>> mkenvimage [-h] [-r] [-b] [-p <byte>] -s <environment partition size>
>> -o <output> <input file>
>>
>> This tool takes a key=3Dvalue input file (same as would a `printenv'
>> show) and generates the corresponding environment image, ready to be
>> flashed.
>>
>> The input file is in format:
>> key1=3Dvalue1
>> key2=3Dvalue2
>> ...
>> Empty lines are skipped, and lines with a # in the first
>> column are treated as comments (also skipped).
>> -r : the environment has multiple copies in flash
>> -b : the target is big endian (default is little endian)
>> -p <byte> : fill the image with <byte> bytes instead of 0xff bytes
>> -V : print version information and exit
>>
>> If the input file is "-", data is read from standard input
>>
>> You can build with 'make u-boot-initial-env' to get a tool called
>> printinitialenv to run, which emits the environment. Or you can look
>> in include/generated/ to see the env files from the build.
>>
>> If you would like to send a documentation patch, it could go here:
>>
>> https://u-boot.readthedocs.io/en/latest/usage/environment.html
>>
>> (in the source tree this is doc/usage/environment.html)
>>
>> Regards,
>> Simon
