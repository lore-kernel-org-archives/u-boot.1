Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F06C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 04:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B60E88418;
	Tue, 27 Aug 2024 06:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G7Jo2eHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C91388418; Tue, 27 Aug 2024 06:01:49 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4006841BC
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 06:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf6bf3a536so2636986d6.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724731305; x=1725336105; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=75USNbWEzxhZVj9Xxgam8e32O1Uxq+Q7L+LtFlgNv5k=;
 b=G7Jo2eHl58EWWhLqfamQQOMbrAsQkkn/U9afGmTcf6SSePxz/blUyBgvY2/Kl0upAi
 rr/F5U+OQxlLMd5jaVerTqnEeraJ4QEnueu6OBbeycmJy+7Qm7nZLwNkEEPUGQGuH3qN
 K/gipzKg9AzMWfNp8YFGypwe/7hM7wG7zZbNGWCVKEuTWqcJxOBc4GWjzw8vY8xSYdiR
 EHgoxc02dJgNSPq/j+jsMK+vWds7lmfB/CO6pi1dBW6i24LixrQR/dpL38KBEU45oMxr
 3xZqRN6Jw4ivHSmVGIbKv0vj8dvwRTxnjqaRI82jhf8599YAEe+ZG4452jEKPN3rDO9c
 YOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724731305; x=1725336105;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=75USNbWEzxhZVj9Xxgam8e32O1Uxq+Q7L+LtFlgNv5k=;
 b=HECjUyXt5hRCqj4OZDxe89cYATnU5VYWhXE3CGmdE2LKxZXME7RoWhcCuM0zzUWguO
 AKbwzPyfzoVlRVO0lDFruf/ULfMAWM0KITX/XH0+oI4/VGFu/LPghQFw8kbK4NI1MwBR
 tJnyYh05/Dx9dF015bG05xAugm36baVNMISi7ayIKGxAiN12ai/nzzWMgj8LXPQDIZoL
 F1KtwCJdWnwOPtiCKoC5gv1J47H2uuuHgaX8ELsKyums5t3ARsON9BjLgaJKV5z8e9Un
 JEwx2d+YoTdSu9D9nIR6aPwuny/c5UaxtJz/4bt7Mbiqcq1HABgo/bW6bwfhCncsYHRE
 gQpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXLPdXN73RgtRnwOSBJvsKdo+GmkUJMJF9m8zlnYbgfvJqBYUkWb4skwHiW9IjNk4soupHXj0=@lists.denx.de
X-Gm-Message-State: AOJu0YxZMH4egr0OAzaCynJ6fnMVgKwQ7LlK6sf/iQUQnIuAW0RHvvha
 NusAQwOnoBNhKkgnG553ggFT7AzLCBtRRTUXT5lXmcuoBbrWxlkr
X-Google-Smtp-Source: AGHT+IEFGEOLzfoM24VSthlCYHZtCeDIqEXJ0Kq3dJ6D/Rp2Ai/nVuinwhhBS/5cymGx+usjZNEDZA==
X-Received: by 2002:a05:6214:19e6:b0:6bf:6722:aab3 with SMTP id
 6a1803df08f44-6c16df386f6mr92410486d6.5.1724731305399; 
 Mon, 26 Aug 2024 21:01:45 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d4a003sm52525316d6.35.2024.08.26.21.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 21:01:44 -0700 (PDT)
Message-ID: <edbb4c96-ad6f-03e5-54ea-9195936b04f1@gmail.com>
Date: Tue, 27 Aug 2024 00:01:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Assistance with U-Boot Compilation Error
Content-Language: en-US
To: Reyders Morales <reyders1@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAJueRn0OQknOW986AzmBEs-+LShGn0WimfHckjfoSKFpZiz_5w@mail.gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAJueRn0OQknOW986AzmBEs-+LShGn0WimfHckjfoSKFpZiz_5w@mail.gmail.com>
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

On 8/26/24 19:18, Reyders Morales wrote:
> Dear Tom,
> 
> I hope this message finds you well.
> 
> My name is Reyders, and I am currently working on compiling U-Boot for
> am335x_evm_defconfig. However, I have encountered a compilation error.
> I greatly respect the work being done on this project and would be
> very grateful for any guidance you could provide.
> 
> Details of the Issue:
> 
> Environment: Ubuntu 20.04, arm-linux-gnueabihf-gcc 9.4.0
> Target Board/Architecture: am335x_evm_defconfig
> U-Boot Version: v2024.10-rc3 or main
> Error Message:
> ---------
> LD      spl/u-boot-spl
> arm-linux-gnueabihf-ld.bfd: u-boot-spl section `__u_boot_list' will
> not fit in region `.sram'
> arm-linux-gnueabihf-ld.bfd: region `.sram' overflowed by 156 bytes
> make[1]: *** [scripts/Makefile.spl:532: spl/u-boot-spl] Error 1
> make: *** [Makefile:2095: spl/u-boot-spl] Error 2
> ---------


Well, it's just what is says. Your U-Boot doesn't fit in ram.

> Additional Context:
> 
> I've been able to successfully compile the v2024.07-rc5 version. I
> think that this is the last one that works.

Try increasing CONFIG_SPL_MAX_SIZE and then use linux/scripts/bloat-o-meter
to see where the growth is.

But the main thing is that U-Boot is tested with the latest GCC, and older
versions tend to have worse optimization.

The easiest way to get a newer GCC is to download one from [1]. Since you
are on focal, you could also try [2] (but that only provides GCC 11).

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/
[2] https://launchpad.net/~dristan-viburnums/+archive/ubuntu/toolchain

> I was compiling the u-boot just for learning purposes. Sandly, I think
> that I do not have the knowledge to fix it. If you can guide me in a
> certain direction, I would greatly appreciate it.
> 
> In addition, I would greatly appreciate any insights or
> recommendations you might have to help resolve this. If you need
> further details or clarification on any point, I would be more than
> happy to provide them.
> 
> Thank you very much for your time and for all the hard work that goes
> into maintaining this project. I look forward to any advice you might
> offer
> 
> Thanks in advance,
> Reyders
> PD: I wrote to you because I use the get_maintainer.pl script and they
> show these names.

Please CC the U-Boot mailing list.

--Sean
