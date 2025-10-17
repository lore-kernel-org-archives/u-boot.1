Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17C1CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 18:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2638383F;
	Fri, 17 Oct 2025 20:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PhpNh03A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC9D483837; Fri, 17 Oct 2025 20:00:26 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9596183829
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 20:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3937C3F7B8
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1760724023;
 bh=7SfCr0VN+tbrZlZ8sISilxbS0W8hMdvSAATq50WbkA8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=PhpNh03AogjnVwTD+0U/7Th3U4IoI/V4j225XXLiiQu/OGXvfJWma7dIdRC+gtFKb
 58YYDY49Rqky1RbP3ttJg1rQUt9Jik5L/TlVb4A8hwiJGsxhZb0eR3An6L7NwBPwgc
 d9GNUPE6IJLi2qMFAAT3DTYrcMhL699EuuE3fHvCHdwJeJWq1HJErIYijcLN3Tk6FX
 S3XVdn675PlmYCZm7aAbYC6hjy2GNBjoJajFURxONa/nIM1iq/nDUGkKVrYZ+kqby2
 HimO6RFmXIAgqormH4JBD/RDR0HXovXuCZ44LL8MxFF9Ne8l6lusMaJBzLxzeWFHIf
 3NnIr3H02ID4F2L1HgmfYt7pc++8JD/5ymHcn2f+MDIXg0icz8C6kcNAMtJR46LKRR
 EMTPsBXrDoWEqdYiE5AMvZRpvuX9kbTERDtPfPDATSn91BcXssibEYwbohSPmcx8gU
 W5z5xuy9Lye+3LP5attGu/HmY/tK4rEZVuw2eAQoDVQwrW5YpQyDGO4c5qtT1EcmH6
 eWDb987Fa0k8rrXroLPyi6ilZSYts7+xmq7R1+LIl8Q5U2xUDJHClWLqsTQ/GGGM4U
 0txXiWtbXDV1mZEVDsr5srOpwMofcSxxkLiUDGUOFRjgMYZBHFW+SR9VZ5xVmKcj8r
 9zfZdTbt+dQkgzmXwZpyhr3s=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-426ce339084so2102110f8f.0
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 11:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760724022; x=1761328822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7SfCr0VN+tbrZlZ8sISilxbS0W8hMdvSAATq50WbkA8=;
 b=pMZHc1NmmZy4Efm/AzBDxaU5lcki+yH3yzmnM1ZxnmFZ7WxApmxvsZwvrU7GO3kXXP
 6U3CYTceXn0BXVLtRVq1ENqY9QeoY28/pyhAWhi25Cb6MJti+vvSPXhhZvl68FEdEjtK
 rOKzsQfbhu9uuaw7aQlz4K7yeYR6zRhQ19PynicbC2vl6EnI00TQB02y6xxj01sh2nUK
 NFvGGY94iUqxPYEmxeWFBc4Gs5CDdm3FJXXtnyQcGXiQVge9e6voF/rb1j7BRiwu6Yh9
 3R8uizmjozy4K3Bb9wUPTPMwrsrywyED5W082O25LNIH3dp3rk1fEfX8COPHzjjRWgSJ
 O3og==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6+Gwl1Bg/Rflc9U0NlOhXPIrmEjNwCYeMcJfX5h1CBqGAtu4Wn352XNgZWuDwI2lLncV6aGM=@lists.denx.de
X-Gm-Message-State: AOJu0YzfXkI+M8ex5af7q22mBdC1DQqgFb9PjBs39ViIsAWJ805to3x2
 9Bm75FJcskuupncBbNyaco7RolcCydLWKKQHQBNs5NptLdZjzCnWEH72CUN4a//VY2QC9bKI7BB
 rvJB1vBpgkXvZ+FyhcdPTfDtIO/8MHByMaoppc2IgIb/lMQRQZyB/gSDkboFyv2lCptE6QiE=
X-Gm-Gg: ASbGnct6j0udKe7PUSg7VuHUhqQ4USpsru8RXBlVrj+XawnbT7uL6dMPSGNHOXWUTVH
 NyiUC+uA3GC3EOBMIO8mgR6Ag15ZMZ3aglETVzlzmGdwlYoV9g2FI/AqpIQjUdkIZRVJK64cO+I
 L6Ln56eJsGSORPPwDn+SlGi3dkJ1wa8n/60L47EaHq4KXBa3FUoOhTFNLdONWF8SG2vsRxNp7YK
 7MoHFU7aDu05AX5o4nH2Gyh/jBUnq6vmYtf1JfYb38YZDuawNdeI1EwN+F3bZLuADymmhP63DMI
 xPVnRwx7PAv+F5F/ngt7ZVjBSuOEoeTabWmtkXdxe/YFOF+EvGNmMzE0mR9H8AXhhiIH/HkMoVC
 kSxTf/33vI6gMh0hwCOqelm96HM55k0/FG6/O3l7k3r43+86y747ohfGNQ7ZiYdrQl64=
X-Received: by 2002:a05:6000:2503:b0:425:825d:2c64 with SMTP id
 ffacd0b85a97d-42704d6c822mr3552452f8f.17.1760724022360; 
 Fri, 17 Oct 2025 11:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ALe29bCDVd5JpfwHX/qIjOvlaKi1vw5MxgW/QaCQdTwhKMcnas+l0hPb8h6j+tXLU3e3DA==
X-Received: by 2002:a05:6000:2503:b0:425:825d:2c64 with SMTP id
 ffacd0b85a97d-42704d6c822mr3552423f8f.17.1760724021868; 
 Fri, 17 Oct 2025 11:00:21 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:a41e:f8c8:edd8:6a03:dd62?
 ([2a02:3035:6e0:a41e:f8c8:edd8:6a03:dd62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b985esm402716f8f.34.2025.10.17.11.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 11:00:20 -0700 (PDT)
Message-ID: <2b8c5ccf-5ed8-4ea2-a149-e37f9ed8943f@canonical.com>
Date: Fri, 17 Oct 2025 20:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Sean Anderson <sean.anderson@seco.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
 <20251015162858.GA669557@bill-the-cat>
 <632340c9-6a6d-4f46-b731-e766f8517f7d@seco.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <632340c9-6a6d-4f46-b731-e766f8517f7d@seco.com>
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

On 10/17/25 19:08, Sean Anderson wrote:
> On 10/15/25 12:28, Tom Rini wrote:
>> On Thu, Oct 02, 2025 at 10:36:07AM -0400, Sean Anderson wrote:
>>> On 10/2/25 05:52, Heinrich Schuchardt wrote:
>>>> On 10/2/25 11:39, Andrew Goodbody wrote:
>>>>> After calling a function that can return an error, the test to detect
>>>>> that error should use the return value not a different variable. Fix it.
>>>>>
>>>>> This issue was found by Smatch.
>>>>>
>>>>
>>>> Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
>>>>
>>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>>> ---
>>>>>    fs/semihostingfs.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>>>> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>>>>> --- a/fs/semihostingfs.c
>>>>> +++ b/fs/semihostingfs.c
>>>>> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>>>        }
>>>>>        if (!maxsize) {
>>>>>            size = smh_flen(fd);
>>>>> -        if (ret < 0) {
>>>>> +        if (size < 0) {
>>>>
>>>> The ARM specification (https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdeveloper.arm.com%2fdocumentation%2fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d%2d0x0c%2d&umid=f17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=1759398729&auth=d807158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8fa50ef84918) has:
>>>>
>>>> SYS_FLEN (0x0C)
>>>>
>>>> Returns the length of a specified file.
>>>> On exit, R0 contains:
>>>>      the current length of the file object, if the call is successful
>>>>      -1 if an error occurs.
>>>>
>>>> Please, consider that the file length on 32bit systems may exceed 2^31 You must not consider this as an error.
>>>>
>>>> %s/if (size < 0)/if (size == -1L)/
>>>
>>> This cannot occur because on a 32-bit system SYS_FLEN only returns
>>> 32-bits of information. The host must detect files that exceed 2 GiB in
>>> size and return -1 (simulating EOVERFLOW).
>>
>> OK, but this is for 64-bit systems too, isn't it?
>>
> 
> Sorry, I worded that poorly. What I mean is that the spec says
> 
> | On exit, R0 contains:
> |     the current length of the file object, if the call is successful
> |     -1 if an error occurs.
> 
> which implies that R0 is a signed integer (otherwise they would have

The only thing that is certain here is that the register will be filled 
with (unsigned long)-1L if an error occurs and that any other value is 
not an error.

Everything else is your personal interpretation which does not match the 
existing implementation by Linaro in QEMU.

> specified 0xffffffff or 0xffffffffffffffff as the error value). So
> negative values (other than -1) indicate a negative file size (or are
> unspecified).
> 
> However, both OpenOCD and QEMU just take the return from stat(2) and
> copy it into R0. With a 32-bit host there is no problem since stat(2)
> will itself fail for files over 2 GiB. With a 32-bit target, this
> produces erroneous values for files larger than 4 GiB. Files sizes
> between 2 and 4 GiB could be recovered, but I don't think we should do
> that. On a 64-bit target, there is again no ambiguity (at least until 8

You still don't provide any reason why you don't want to support files 
in the range [2 GiB, 4GiB[ on a 32 bit system.

Instead of restricting U-Boot we should add a fix in QEMU to report an 
error if the filesize exceeds ULONG_MAX - 1.

This is the only way we can ensure that a 5 GiB file is not reported as 
1 GiB in U-Boot as we see it today.

Best regards

Heinrich

> EiB file sizes).
> 
> I don't think we should try to interpret negative values because it's
> ambiguous in the spec, the hosts known to return such values do so
> because of flaws in their implementation, and large files themselves
> have dubious merit.
> 
> --Sean

