Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0594E7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 09:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B24A9896B5;
	Wed,  4 Dec 2024 10:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="L97jJQbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85686893A3; Wed,  4 Dec 2024 10:34:17 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C0F8967A
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 10:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 73E6740CE3
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733304854;
 bh=Hi8nrJIAqrK9WxG1WILDXQLarCrcCACXf73qNwb7lT0=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=L97jJQbSZkS7gPMdMfTKEXplYiTO9KUktDUDVv3F+xQW+LHtvaBxAl5lm30N/RZYR
 kBCPInvNd1oEIybW+zc8EJGwVbnDGLmneQXpwM/pfWvWZDMam/UiQzjkC1jmZfLxcW
 9WxHHU3OLyYBHINQZ8597BA8BPA0Y8QtjNRgSsyxCEG4vurJJ8rguyF0T7twmAo8IZ
 0mEmmgoG3NCwze9Y4tg3YiO1bKzTC0/hneq8YaNcNDbaDAc4nKJOTskferpeqbUfTz
 FLueSWCaA7IZlV+orH2TTPP7mtjvmfFMvHxEB/8XG/bqBjtuI/yqFNksAYwT3/4pCC
 6J9g0eu04qBhA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d7d51ac8so3043882f8f.1
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 01:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733304854; x=1733909654;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hi8nrJIAqrK9WxG1WILDXQLarCrcCACXf73qNwb7lT0=;
 b=BlpCLCrquoK3GcM+QJPHK9lS+hoX2UOp4aXMKyMpetumgYkfjAxQPwtNiHIffziO7/
 dUkZFjS+rK1ZXcVnNiu3i5izquz3SSd6voXR18bagbH+MqbYSPIotx7k0SbDbVa5/A/W
 fn/0mi8XM3cJuVHpAKaM29hcweFk3iPUyC3nv+f/5JoqovBPAO6zowOfwCYiCwOlJByA
 s8ts/DoBswuIz2uWN/1xI26cof0xm86ssKO89YB7RuXbL2RBllHpJLleUe9zOeVf+iFb
 L8tC2XfwC2g8ZSfXRmqTwLbC9ZL8s2VxLy/VXw3tXNWub86g2KjDI4fa1OhuR1ZTiHMD
 mjgA==
X-Gm-Message-State: AOJu0YwZa4zsGNDG0VZVYO3JBfl18gPIOovXi+29EKpAaFmf3TFOsbSf
 aCkBdfIonxLI8XGltllBxUSlUpgThRV0H06LeaaNi8ArZ2Ywg3OkyolQGt0wnTxXdGVVTlVAxhj
 GBNcUYLK3wb/UYfeLPSCn7108+53sLuUwXczo/4mkYZ1QhLj0P0rKVjDGoefK7vY7jlw=
X-Gm-Gg: ASbGnct3LiG9bPNn0v+wh76bnjOpp2pYLTU2DlV47NC+W2c9Az5cAS5H75kOX+ptNNz
 FZnkgL6hHTU8EOjPA6pQWHv1/p2sN8klxyA+lFRP8GJqYFFzv7NzNuHGU8RPBXgq6/eKtuh3OMy
 C7+dkEFoF6qu4pTwgdIqq5qwW4hD0qnMkT6klVkShOVfBc6++pEnlWe/avywjLmborDyv16BXPH
 IxRKt8kUWGN1TYRtZYjpwZNyH61/Uq0qa7QbRUKS+tN4FzX4LQIlb7vCqexUj5UeX0vDut5Egl3
 g8Uel7NBrFBnzp7yFOCeswSUdAWwB54DfXNqQXq2
X-Received: by 2002:a5d:5f45:0:b0:385:e4a7:def9 with SMTP id
 ffacd0b85a97d-385fd532811mr4171106f8f.50.1733304853934; 
 Wed, 04 Dec 2024 01:34:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHUxflqK3O4cwjfHSwbyg/wgc2gsYekk7SoXA162wAJHzvkFVcSXsd8+pSb6sFSqN8J2vBDg==
X-Received: by 2002:a5d:5f45:0:b0:385:e4a7:def9 with SMTP id
 ffacd0b85a97d-385fd532811mr4171080f8f.50.1733304853567; 
 Wed, 04 Dec 2024 01:34:13 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:9b8a:adf8:337c:7d0b:35d9?
 ([2a02:3035:6e0:9b8a:adf8:337c:7d0b:35d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e4617a61sm12290929f8f.3.2024.12.04.01.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 01:34:12 -0800 (PST)
Message-ID: <5b3c6ca3-c49c-490b-81b3-0b243bfa7af9@canonical.com>
Date: Wed, 4 Dec 2024 10:34:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add cross compile dependecy info for ARMv7
To: Peter Polgar <ppeter.bme@gmail.com>
References: <CAF2BDb_g8385y8WpAw0epu-oSE5Wx2Nab0NvQ1mf+=hOVowZmg@mail.gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAF2BDb_g8385y8WpAw0epu-oSE5Wx2Nab0NvQ1mf+=hOVowZmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 28.11.24 17:48, Peter Polgar wrote:
> This commit adds info about the needed package to cross compile
> U-Boot to ARMv7 (32 bit) architecture on Debian based distros.
> ---
>   doc/build/gcc.rst | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
> index d8fcfdc4bf..c552e7b590 100644
> --- a/doc/build/gcc.rst
> +++ b/doc/build/gcc.rst
> @@ -19,6 +19,12 @@ You could install GCC and the GCC cross compiler
> for the ARMv8 architecture with
> 
>       sudo apt-get install gcc gcc-aarch64-linux-gnu
> 
> +For the ARMv7 architecture (32 bit)  use the below command instead
> +
> +.. code-block:: bash
> +
> +    sudo apt-get install gcc crossbuild-essential-armhf

crossbuild-essential-armhf depends on
gcc-arm-linux-gnueabihf gcc:armhf, g++-arm-linux-gnueabihf, g++:armhf, 
dpkg-cross

But gcc-arm-linux-gnueabi is all you need for cross-compiling 32-bit ARM 
U-Boot.

Adding an example for every architecture seems too much to me.

Can't we simply update this sentence pointing out the the arm 
cross-compiler has a suffix.

"On Debian based systems the cross compiler packages are named
gcc-<architecture>-linux-gnu".

E.g. add

"gcc-arm-linux-gnueabi is the 32-bit ARM cross-compiler package."

> +
>   Depending on the build targets further packages maybe needed
> 
>   .. code-block:: bash
> @@ -118,6 +124,12 @@ Assuming cross compiling on Debian for ARMv8 this would be
> 
>       CROSS_COMPILE=aarch64-linux-gnu- make
> 
> +Also on Debian but for ARMv7 it would be
> +
> +.. code-block:: bash
> +
> +    CROSS_COMPILE=arm-linux-gnueabihf- make

U-Boot supports  ARM SoCs prior to ARMv7. U-Boot doesn't use floating 
point. So arm-linux-gnueabi is the right choice for all 32-bit ARM boards.

Best regards

Heinrich

> +
>   Out-of-tree building
>   ~~~~~~~~~~~~~~~~~~~~
> 

