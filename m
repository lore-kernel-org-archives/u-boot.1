Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD28C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 16:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC38820EB;
	Fri,  2 May 2025 18:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="a49oUNah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADDA5820F6; Fri,  2 May 2025 18:09:02 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880E4820E2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 18:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C85083F682
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746202139;
 bh=WoA9AbX4BDLQY1ilhI9o/aDPJHSfdxhAw26s3nhMpO0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=a49oUNahQUeyv7Pkx8bADnHFlXLSfRAcjywBEdlKZxtzOxFqjeU1n3rTnsfndI0rl
 2twezkFkmRr41zAHpRoDK/N2KIEUYKUrSvMEcdxoEkNpOEwu1aaosDP7PSelSmkOss
 UGjTnLzDF4ibf55MrG3RgUz8wzUGQHqnuL4PFL+EYUQkMV76ilNJSLznTsLyUhTaZT
 ixEjAkzLBTM+dtqLSS9iFbqd3zfNkSnG7KsFeCUWNzJ6D3dNTtnLKsR5uymS3ywLMj
 tUhcWIJPCDb7KmsEMVQ1e+7J4Kx8J3bXlsDh+NUlqSA11enI1Pmcd4fRCqcWBR1SYh
 xpyl1NcvYJX7g==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so12235385e9.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 09:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746202139; x=1746806939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WoA9AbX4BDLQY1ilhI9o/aDPJHSfdxhAw26s3nhMpO0=;
 b=VOXf7XPT+5xSojgw5ZStBqIAvtizbgVuWYVkChjFvBy78T6ajm+r7LMsaJl5wvow/G
 U04SMGnb7SxjRYXK7hVZySctCPzbMuAhnGHMP7KzG+ppJNcu3GJCvKHcO8dttugiB3im
 fxkH+aowLtadLaeH2bV9IM4IJVlhazBCNDJ4bdf4F99BRzpWrBf1P9Ubb9/Ze7+JaPnc
 mWPvGKYsDBnhMeaG4zP/7eLAeM50BH9kraJkJtvNUs4vhCROKpNzpGptzKBDf7k8aVBX
 cSe4OmmeB+ftI+1oRTD7fRDrl3Wv/eHzTeZZJNNlju444MyZ58BZc5kU0zZ32n7IkRaA
 aHmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZH5Ds9pJFSMU7QlB99DU4ATN6Feu70AM9Ew5WVCOxuaf6rA1Vq0sFidvFIybRbIWyEhX5Svw=@lists.denx.de
X-Gm-Message-State: AOJu0YwEf+EqUFlJdfkDRGgcUyl3FJ8AwtLoZRXxmp4DJdov0mbcAglU
 gkU44GpEDbQhaLQMV4VqL0QR6FIav6CQx1ImLmYdYuY0iVDEnCxr9zSOEVR+Dq5tEOzwBXXRz6S
 +6iQGxCroXtVhlGzMI0FIW7BTjCMrxSfCAVSkL1TbZXxALx59NIKvDocn35Lv7Lxy4Gs=
X-Gm-Gg: ASbGnctHzWMnbIqNU5rdd2eJqbmPk9rGBdCoMG1KXRsNsHfHL9a30N3+YsyaygWyD3I
 FEX0FMW1ulJT0RqvyZnABXUkt/1zTY1yrISgJEYFDqd8qXfSBNnvGHp5THDJSFS82IvFD3dhutT
 9NBLES4NHb824lPny+6+8PyDXEPeoxcOXFTfvHFqlVl51Ww3i5CLUx9mLyrMn35q0ka48S4RaYk
 9o7+o8hDLS6FkhRdiq25sTCSBbzy/aA7LtISBZHpYbLKNLSjnsge/ZNVIKIwXEX+/L6uEbbUsbz
 El654c4QQJYEbdx0ZiXx57P6TIyhA1D+4BW+Fr9EbkGVWlFu3wKbJXP5lFBniAixgUgtj/3q8W8
 =
X-Received: by 2002:a05:600c:8711:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-441bbf2cc8dmr25067655e9.20.1746202139125; 
 Fri, 02 May 2025 09:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWTr9nUZt/CoVrKDOMKoMgG5rl2qGX0eqSbRyD7CShNR8p0NzXcne2gSLhqyXS3a2qvTVn6Q==
X-Received: by 2002:a05:600c:8711:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-441bbf2cc8dmr25067175e9.20.1746202138628; 
 Fri, 02 May 2025 09:08:58 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:3644:2de:dbee:fb2f:9ba3?
 ([2a02:3035:6e0:3644:2de:dbee:fb2f:9ba3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad784asm93785515e9.7.2025.05.02.09.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 09:08:58 -0700 (PDT)
Message-ID: <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
Date: Fri, 2 May 2025 18:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
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
>> The EFI boot manager bootmeth does not require variable BootOrder to be
>> preexisting. It creates this variable.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/bootmeth_efi_mgr.c | 21 +++------------------
>>   1 file changed, 3 insertions(+), 18 deletions(-)
>>
>> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
>> index 42b8863815e..1669cbed5bd 100644
>> --- a/boot/bootmeth_efi_mgr.c
>> +++ b/boot/bootmeth_efi_mgr.c
>> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
>>
>>   static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>>   {
>> -       struct efi_mgr_priv *priv = dev_get_priv(dev);
>> -       efi_status_t ret;
>> -       efi_uintn_t size;
>> -       u16 *bootorder;
>> -
>> -       if (priv->fake_dev) {
>> -               bflow->state = BOOTFLOWST_READY;
>> -               return 0;
>> -       }
>> +       int ret
>>
>>          ret = efi_init_obj_list();
>>          if (ret)
>>                  return log_msg_ret("init", ret);
>>
>> -       /* Enable this method if the "BootOrder" UEFI exists. */
>> -       bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
>> -                               &size);
>> -       if (bootorder) {
>> -               free(bootorder);
>> -               bflow->state = BOOTFLOWST_READY;
>> -               return 0;
>> -       }
>> +       bflow->state = BOOTFLOWST_READY;
>>
>> -       return -EINVAL;
>> +       return 0;
>>   }
>>
>>   static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow,
>> --
>> 2.48.1
>>
> 
> How do we know if the board is using EFI bootmgr? My understanding was
> that this was a way to find out?

The boot manager must always run.

The check for the BootOrder variable introduced in commit f2bfa0cb1794 
is a bug.

The boot manager handles in sequence:

* Try to boot as indicated by BootNext.
* Try to boot as indicated by BootOrder.
* Try to boot default path for available media.
   This will add Boot#### entries and update BootOrder.

Best regards

Heinrich
