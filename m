Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1665C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 16:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 426D6820EB;
	Fri,  2 May 2025 18:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IWVu6PYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB6A82102; Fri,  2 May 2025 18:16:17 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A919820E2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 18:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BDA63FCB1
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746202573;
 bh=j/c5AkVBPS0STNwt0a49TzZtXpy4WrSXGKYHbdVrJ/U=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=IWVu6PYvKpROtrZDecNlfVRhtLGeryby1fuQ/lUz+RfjnkyT2IvBimM0kcphDcNBV
 AwybUyHJg8fpt0loa7s23ocFynkH6phT3Nm/6ZXXPRkHOJ4XuRPAIG8fpn8SMRhccS
 bZef3BL0fxgexzXIoIOv0fCAbprfzOoBgl3dfMrY9/h+nxnf10XLFzH//xq6APFmGI
 e93HYsU/f19XBUSlNPRIe7e2xI4m3WifjNDrUxFN8Hhu/9TuHaaAkk+cqbva5J8jqI
 J6y7wsh/DCJ9ZmEFcZUDA7XI1wjG3Q7py+NbeT6bjzcXhZVFXr8fpQbv0lylzMLkFy
 oUstxnN6Nw5aQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso9657195e9.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 09:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746202573; x=1746807373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j/c5AkVBPS0STNwt0a49TzZtXpy4WrSXGKYHbdVrJ/U=;
 b=nsN59UYbcz6aKJqw85WrQzgfCpSrmFSwMSIYDKkQgPu03Iq+nWVu5A7BDdXEtMcrSm
 7TJcZlldlZObXmaI4Aw3Zk8w77hORGhEWV/jd3uq3J5HYzEOoxA342M/54L7wpeaBU/g
 sYfJMezVFSwgu6iSkmmgvhh9KdScka2ROn0rOxNgZKGzO9CZLHCkZxqhSHCm7ugj4CTL
 WvzFxby0IXm1InhJK7gxilcRvDO8IlezE5Yn4uQUKGU8THUOfPEIHB3taDoAbPbLFKIb
 p+xa0DJr3Dok2hSaciJBk0Tbha7jRTERmRlAsmW/vIl90aLbdmnLKL6741f681XtLHVV
 L6aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWXYXaAzRQwmo15kWf6joYH6uW6TTqEwjwmMogy+MhSWkk0pbVvxSS/xIiwFUPuay+9V13BpI=@lists.denx.de
X-Gm-Message-State: AOJu0YwOcsgJaop4Ic9Xc7FH8ZhvBljjuvWGsjP7cM/c6kK9MqiE/din
 y9UfJyqjTgpIvx3YdoXnTMQC1t/4tFiPHJXbhvaQ5Nt+21athsR1IQHwsNGli04QMAbn+lylTCE
 I/yO48sh8zJ0dJkA/FgwEMn4orEv+OOqxS+GgwYxu/gsrkXRLlxcmmH+VCwF81Oz1nAk=
X-Gm-Gg: ASbGncvolBnsVQZBnvHz8vZkKZWPXUn8aqGDXISMUCowMbYv6gPWE3VuJVP5c1K5dfk
 gIIvEPOb57eCGIFB/KKHtk/xiL1YTu542/AzYUfPxWxJVDosFvr8GzWL2hyc2Jf2CjsxEy49qVZ
 9uqW80PvBPAxndsA8OOwXQSauE5BHtUO4QOsCt8tDN8/UVa1gdzCcR0L8dSTsdxktyiAyBB+tZK
 iL52vhcU+8LTEMzEavk6xo4wFOYFYBU38aifLWNfi0oxrzSDBKKjAE/4DOJBLi1MQMX3GGs13qJ
 bFl5VEyznVxeV+UgCd6fJN/uwhY+YXL1GUIvalYsTAyyOuWbdyLijcsxlEa7wG0ZySK8V4g9uu8
 =
X-Received: by 2002:a05:600c:6748:b0:43c:fabf:9146 with SMTP id
 5b1f17b1804b1-441bbec4095mr37244395e9.17.1746202573228; 
 Fri, 02 May 2025 09:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWlWLHvqQ7zAC/QdYxW35dDz4Q65uuN5qCADiWaGDNuSIp0rOHqhibOy8Pj5NwhUzzaTIwFg==
X-Received: by 2002:a05:600c:6748:b0:43c:fabf:9146 with SMTP id
 5b1f17b1804b1-441bbec4095mr37243935e9.17.1746202572897; 
 Fri, 02 May 2025 09:16:12 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:3644:2de:dbee:fb2f:9ba3?
 ([2a02:3035:6e0:3644:2de:dbee:fb2f:9ba3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89d1358sm48917435e9.10.2025.05.02.09.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 09:16:12 -0700 (PDT)
Message-ID: <27c7a370-ad40-4935-8b2a-f27468a01467@canonical.com>
Date: Fri, 2 May 2025 18:16:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/8] boot: make BOOTMETH_EFILOADER default=n
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-4-heinrich.schuchardt@canonical.com>
 <CAFLszTjcCXDnjOjpD88tGcvSz1AOAouyHKsynzCC3tngDqzOvQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTjcCXDnjOjpD88tGcvSz1AOAouyHKsynzCC3tngDqzOvQ@mail.gmail.com>
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

On 5/2/25 16:49, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The boot method is deprecated as the EFI boot manager covers this
>> functionality.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/Kconfig | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index 71ddb37f6bb..b973d9eb0a7 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -595,7 +595,6 @@ config BOOTMETH_EFILOADER
>>          bool "Bootdev support for EFI boot"
>>          depends on EFI_BINARY_EXEC
>>          imply CMD_TFTPBOOT if CMD_NET
>> -       default y
>>          help
>>            This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
>>            launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
>> --
>> 2.48.1
>>
> 
> As mentioned on the other patch, we need to keep this enabled and it
> isn't obsolete.
> 
> Regards,
> Simon

Please, read the UEFI specification especially chapter 3 "Boot Manager".

* The functionality is fully covered by the boot manager.
* The current implementation of the method does not comply with the UEFI 
specification. Especially if run before the boot manager.

Best regards

Heinrich
