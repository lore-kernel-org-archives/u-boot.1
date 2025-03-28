Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920AFC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 087398070C;
	Fri, 28 Mar 2025 13:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OewTgRhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 567A7810EA; Fri, 28 Mar 2025 13:27:48 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47AD380079
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-394780e98easo1206793f8f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743164866; x=1743769666; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mxUwqnorOe8jEQ91JVf3i1bxoaLcG97CH2keoK4U7/0=;
 b=OewTgRhvDRZP755BOKe8vbtUCFnLfz1aJc1xss4ETWaWTYElLRiI10k+zacvEXpuww
 XuXTZL4d48pTEqf8PibLURXrrb6XxLd15Uyl7g0Zrz0w8pJeXP2rjeb8S3bGZaIyN2XY
 RyirIeCzfKV04P2jNagmwMe15eX0z8iE9Vt7pXLUFWUIBHAHAZjIIWrqOxvqAWvlZ+iv
 Z564QffZQkcOPGcSbglF10Iu/iKAgiOsiefUHUClVWzug41aEovAGJDYND0CREDuToOd
 QJBa/zb25nsjxM3k9H6wKh8T3zbl01r5JkPtpvExmV00KD7M+XZ6uS8fUxWz0oSkwgvY
 aGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743164866; x=1743769666;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mxUwqnorOe8jEQ91JVf3i1bxoaLcG97CH2keoK4U7/0=;
 b=GrSi0B27muqEDF21nldFfAwtihE8qvj0F2xp5UFm8t4D500PwgfP42QrLLeXz3DAxU
 nFVD9yYfgiEgJviREASdFS2b2np8VlSCOwnHKHz5oLBDWjR/82BGv60S1g05LwQnyuEW
 R3Ov/3mlZ6Hrx4X+6lmImMQUNdC/czfJliioU/ncMkmjq4/aPgBaCFAo2cUirzJY4gMX
 rEPg9bO/jaVhvCc8wA7WUaTvcbj2gioTYioA2Y7Ao+aSW9wE1zooKjnx3y285fzmvVpV
 Tcjmyc6hTHz5YeezMui1UMQ884G5+9LX+QyBOTFI2MfpGjq+5O24Chhwg2mWQ6nBAAtj
 Ez6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXur4AFavXZE27Fivba1yFP0MDQCFUe6Dq2pIiJmnn6S5E7cJm7nfoLvp84+/kmjRNEjbzLL7M=@lists.denx.de
X-Gm-Message-State: AOJu0YxdrQldexewnM+6MZYlyz/fgaVzGztTaZTQPLjyQ4II4FdYFI1q
 Y+NnsYG6Wv6UpO6Yzy+tFOSNe1ZMwsYHARYtiJx31v9ut4wNQ/U+wyPcfbnO13Y=
X-Gm-Gg: ASbGncuvLVcmaYpntLRvfQa2NPW4Zxy3G5yDJZ1XYkmoKHqTYXA5fbqMthWjqOOPDZr
 k6xj/q7BVho8pT2Pucu+KdKLOrkKP0FlhenjbJzxCeJR7/uBz0PLvnMlgLMl+W9aUq6iCh3n0DH
 TFKkEaW5JM+c6oc1ncs0B2D/YpXYEyoSD7GoHGDuLfKto/b5i1tOo1SnPNBY/mQuKxmLs29j6Wp
 BcVRfN527DWBU20LKVIxB/DwTtgY3mRy28ny4e5cobFd/BLk+xNev9asTM8eWcLdB4d7R8EF5h8
 nczNVNzWvzxF3nkw6qCIEQvjs9W3UzKdTSkUP+jkdXgNqiG0booJ9oe5dxgt2YWVPMAPOjXtK70
 =
X-Google-Smtp-Source: AGHT+IFKZ70hG1cED6Sjm34G+YongP3rkKa1KDlXUlIZrAnXCCiIBtSLbepAl2eX2FXrkp9w9MnYtg==
X-Received: by 2002:a05:6000:4009:b0:391:4743:6dc2 with SMTP id
 ffacd0b85a97d-39ad1750844mr7220308f8f.25.1743164865613; 
 Fri, 28 Mar 2025 05:27:45 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d900013afsm26128445e9.36.2025.03.28.05.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 05:27:45 -0700 (PDT)
Message-ID: <8857623f-e6d6-4da4-b9e1-f56b352279f9@linaro.org>
Date: Fri, 28 Mar 2025 13:27:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Ravi Minnikanti <rminnikanti@marvell.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <714a1d3d-7578-4fed-bc8a-c93eff3809c6@linaro.org>
Content-Language: en-US
In-Reply-To: <714a1d3d-7578-4fed-bc8a-c93eff3809c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 3/28/25 11:44, Caleb Connolly wrote:
> Hi Raymond,
> 
> On 3/28/25 00:13, Raymond Mao wrote:
>> When a bloblist is valid and contains fdt, it explicitly means
>> a previous boot stage is passing transfer list compliant with
>> Firmware Handoff specification, thus the fdt from bloblist should
>> not be overridden with the ones from board or env variables.

Actually, I'm a little confused here. Can you point to the documentation 
that says an FDT from a bloblist should always take priority?

I can see why this makes sense to lock down, but clarification would be 
good regardless.

Kind regards,
>>
>> Fixes: 70fe23859437 ("fdt: Allow the devicetree to come from a bloblist")
>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   lib/fdtdec.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
>> index f09c9926a7a..c38738b48c7 100644
>> --- a/lib/fdtdec.c
>> +++ b/lib/fdtdec.c
>> @@ -1708,7 +1708,7 @@ int fdtdec_setup(void)
>>                   gd->fdt_src = FDTSRC_BLOBLIST;
>>                   log_debug("Devicetree is in bloblist at %p\n",
>>                         gd->fdt_blob);
>> -                ret = 0;
>> +                goto setup_fdt;
>>               } else {
>>                   log_debug("No FDT found in bloblist\n");
>>                   ret = -ENOENT;
>> @@ -1752,6 +1752,7 @@ int fdtdec_setup(void)
>>           }
>>       }
>> +setup_fdt:
>>       if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
>>           setup_multi_dtb_fit();
> 

-- 
Caleb (they/them)

