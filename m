Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52BFCCFA05
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 12:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 374FD839FA;
	Wed,  5 Nov 2025 13:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CF8Sr3Ic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162AB839F1; Wed,  5 Nov 2025 13:04:28 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E17783A03
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 13:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5BBEF3FB67
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762344265;
 bh=92j4dmyI5gofZkzNLGZcDSIhPxUTZpIdTZMEKI+yXRg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=CF8Sr3Icmv7RMwNMUNyf92GSWDh2jBb2zbdH0XtI0B/Fym7H3OtAofYV44y0T6Fr8
 arR4YEXx7KnF4lv8dyJp+xAq0tIPZm5f3uNRe1pI6V33Y/X3Ek0DhWGbmgvbpeKwkD
 y70+Krv71frmp77zT2RWj9KraZrfRAuzQSUrNRbbviIo86rfvoA5sZ5D0eSvjtGXJ7
 XEnlkFOG8pSPvOmpTBrOVm2mEfa7A9Au01z1J4UWoM03diqJBPnvAKL6y7n6uZFvb4
 qEXGwJ33mtB5NXziqLbUBXrfHcq8obCW9w8zQWBFvKVHrRNYu6ivROKAOoxkwIaR9e
 3SW14z7veJ7qYejaDYxgJXFXR9hkCBmPF7twH7v0bGypenSJyouJuyoUtUn3uyDH0Z
 dQ3gJQ+EM5LyFyit3ayTYh0aLvHhTcFLAp4QDGMRp6RXVj38YLgLAI8/uXNvFg7HSd
 TCBQE5FbgwdeKSuGOTUIiALGaeMiSouQex6hnRn01q7rkNK9Qvg9VjCpwPdEVlpLb4
 7tkoSBoKdfAibjU0AtJx/zmKnvuiHoq2GHz3WQDpK9PjI/Brb3Yy5etCKREap+/9Ne
 y8WMduiDBldkl3rTH9k3P/3isyurRJdM2Mz/x1r8Ri9blGfMkKoOm2/h046iIo0W83
 r7kkHjDQqqHIVCLcXl/71j/o=
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-37a34f910f8so18005731fa.0
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 04:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762344265; x=1762949065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=92j4dmyI5gofZkzNLGZcDSIhPxUTZpIdTZMEKI+yXRg=;
 b=htFWOJCJDMhdKSqTJfaI2e33sdTJupMSDir2z608maHCNYnapGgEsBjA1nKs2iDUK7
 +6FNIlslXwKcPRq3Ys2iX9VGHonmrQYLN2cphXHXjBVfHHW81z6OIRJxo6Nh+Hn/brD2
 Ey5Bxszuvrj2TG+ybvtaZCmfEvcCVn3RddSKMFyh9j5OdeHe85H5fPkjhrmyVRPnSncp
 Y8BqCnc3OrfgcKikSGWTYTbvLM0QekjPf4oUQcHiOFGiiqE2IuVqbkzFpAYCrB9eDUtZ
 L0jd+llPGIdAuxnEvdJ+iw1Afq6wBWerxMbjInOxEGtkOJBsc85Qn4Cj+EGaWnow7WWI
 pYjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTagbEmSBnruqfRPlGukKYYrQhiaeqKgjufaCdMo87wk+RIcDR/Sb1a81z7kSBtltgNXzpYnk=@lists.denx.de
X-Gm-Message-State: AOJu0YwDur97BHZ3WAJEwUB492qivLinIU5gjiGHBH3yBEwupNCxtpfi
 pDwSPC+yxXBi1tQReT1e4BF3yeDTZIptTeCl4m4CfZwLYE0+cX86OzSYT4ZqPmeEvkuWBtvJ93T
 JDF2juqzUvyxBHd6vmhExbDQqHgkHsEvfBHpvxMCKZEuFssTpB8syPpiQXOAK9E98zrgUffaXl8
 ihuq03Zntn
X-Gm-Gg: ASbGncsc36AUUcjn28aV+5rzcsqy7aNKrRmu2ZgiSr6sH91mV95FAI1OeM0ujNP2hj6
 VvCmfHr6SHuYUjz2XMB3SpX0mOkgB5MJhYTARDFOiqdC43jXlwob3/NK0SQr0+VmjMRda9rbkbv
 BrZYd1zBuj/+Q5vfcd29Pvh2uEHJ2pRdTh0GlAdkSI2j92f9oJVs9T4tAXeEdGdwGMpDrLFZKYB
 3jpq1obKDMXOaopxlIEAID7ggBYA/FsUTZKVlHew3dCAv6GoAUBz0t8EKu/+yCoDhSvIXeqswRn
 3utH0ZHmSyX1Ms4jNHXEYHtcONVcImhl9GruQrbiU0KAjGTq/R6UVhrKGRU/sENKpl0Tw02oARe
 rKkp0yqDL66B0iWe6uoyEQxGU7ISd/KUVz+Cz3jH0kzcZ
X-Received: by 2002:a05:651c:150a:b0:37a:46aa:f262 with SMTP id
 38308e7fff4ca-37a5147b011mr9392381fa.31.1762344264559; 
 Wed, 05 Nov 2025 04:04:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENBynh1MaMKCG3W+yYGAdEAdi+UXD3baSLYgjR44YK4cy2Duah5tcrWxK6qXRiqQAObUpZvw==
X-Received: by 2002:a05:651c:150a:b0:37a:46aa:f262 with SMTP id
 38308e7fff4ca-37a5147b011mr9392281fa.31.1762344264083; 
 Wed, 05 Nov 2025 04:04:24 -0800 (PST)
Received: from [172.26.194.12] ([93.94.208.154])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-37a41630bdfsm14961991fa.44.2025.11.05.04.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 04:04:23 -0800 (PST)
Message-ID: <a45e3f81-2b24-4e0d-8dfd-c7089fcdf3ad@canonical.com>
Date: Wed, 5 Nov 2025 13:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_driver: don't leak name in
 efi_bl_create_block_device()
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20251104232209.75544-1-heinrich.schuchardt@canonical.com>
 <CAEUhbmUPjAJHSd14VPZsTh9SkH_KigyDaCTT=ezNxXnwTu_h0Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAEUhbmUPjAJHSd14VPZsTh9SkH_KigyDaCTT=ezNxXnwTu_h0Q@mail.gmail.com>
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

On 11/5/25 12:08, Bin Meng wrote:
> On Wed, Nov 5, 2025 at 7:22 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> In case of an error always free variable name.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/efi_driver/efi_block_device.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
>> index c389b1920a8..7ce6a45a5f3 100644
>> --- a/lib/efi_driver/efi_block_device.c
>> +++ b/lib/efi_driver/efi_block_device.c
>> @@ -146,7 +146,6 @@ efi_bl_create_block_device(efi_handle_t handle, void *interface)
>>                                 devnum, io->media->block_size,
>>                                 (lbaint_t)io->media->last_block, &bdev)) {
>>                  ret = EFI_OUT_OF_RESOURCES;
>> -               free(name);
>>                  goto err;
>>          }
>>
>> @@ -171,6 +170,7 @@ err:
>>          efi_unlink_dev(handle);
>>          if (bdev)
>>                  device_unbind(bdev);
>> +       free(name);
>>
>>          return ret;
>>   }
> 
> free() should be inserted right after the blk_create_devicef() call as
> the success path also leaks the 'name'.
> 
> Regards,
> Bin

I could not see blk_create_devicef() duplicating the device name string. 
My understanding is that it should be deleted when deleting the device.

Cc: Simon

Best regards

Heinrich
