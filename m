Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF46FC3ABBF
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281BA820E8;
	Tue,  6 May 2025 01:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t7Mgccy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45ACE820EB; Tue,  6 May 2025 01:18:26 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE0F7820E1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 881984EB86
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 23:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746487102;
 bh=x3P1qc3S7v25Z8RBzx1nb1DrQrU7/RI8FOSCnyrJT0M=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=t7Mgccy8kpDbtiDtIRS6umfkEAHszEYY3VX6rYrz2Y2/0jyE7VwdagMvfY6uHwpN4
 qvmCXQcW95FgLANdYX5gQRnM2lNg6ROkwIhZPEpyTnivoYIWThpOTn5SO3M4VAtDt7
 va/GMjq4v22JZBcriZZ3KqdakO8vNNj6G/kVN1sz1Yn7wchstVz/rBEu2x2IzjekJQ
 iYD10tLOwSRJA8sHlZ8QpqrFMA2yCsRSuE3LtPfsjdiMUbSriZEtx9hYgruJXH25FJ
 llc2i6y0YzHSRLz2btpfTBFN/lR9O2t9X6YPjoL0kZ4L9e8iS2y4VUDUeF/Y90OHb7
 5HcBby6E7oyjA==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e6caac1488so5398359a12.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487101; x=1747091901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x3P1qc3S7v25Z8RBzx1nb1DrQrU7/RI8FOSCnyrJT0M=;
 b=TOfAVqzw+qCctPrNpRnA7nmDArVrszvXfXoSKrLr/ryBIhkXea5uR76wFnERo1/+GT
 r3prj60zwD6b6akoS68kKHi9ljFMeEoXR2KWqUz16jAv4kYhkq7AZPR+1ftG0HJUTi4e
 V+EOJn5eVJXfDsaV+Ul0HFnh5VN2z0aMGskfGICk33nr3v6GpjRaT5nvAc0MV4GOeMGn
 6MQmZciJp2Ioi8kcqXjj58kC9XKDIIdAclYrfUELVh1wKTy+uFuQ3Gwf5mllhs02t5S1
 2mcfk9XDfuW243tsi94OZws0CkIhNDLW4j4I4wVFsa56DsrTlfdqdzzYJBMOeYmEBAHh
 VZgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdNXdrtkFoZp+FTf1NF2we04ZzS4aPyBAFujrGdhOWDtIvMiLk7ZTThBFz5UHUYxQR0WQ5exU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0qzwI9WYFLldPu06Ig5Sbdrgt9Rem1TiF3qlZeC7oAdGSyxow
 4878MR7CFX777C6s7r4FVgMFbRWhTgPcwh+ei0lSHx+zUXfmNJGRh4VOkUplu0FABwjfS9p8DIA
 ZPWE9L9j3NFLZ3sVKAkJDkqOFUSN7YRUJCRmsFaMqiToVVQz3ABU9cmAcxU4nJXh6ass=
X-Gm-Gg: ASbGncvLrNE0QicADl8O9GnbjOoSNDUpXtTvdB02lYniOLBCxlrW5wtpHj3jAZN5hcs
 eSrz0Lmt5uAlMCb5yksSff+kLEGagqKO1/jkV2fpnhK4553sUsBah41GBiPEmnadZxdkVl+VuYj
 HTv1Z7sJgNS0BMFjVMzHNzprkUmVwFfVUjAuCOZ6ngbiap/cRupHLVM3oHuvLzmiGXsy2mn+LrG
 nY81tu8Yzka4y6Lh+l5ynihgWFcU3pRw8WPOFOVUl+heWhSaghlE6cPiBQGoc8VzK9oC9/BoJJ7
 Z8vBktQGNXVq343M+3yuGiu+Jq/n5KgX
X-Received: by 2002:a05:6402:280f:b0:5fb:5be8:3e2c with SMTP id
 4fb4d7f45d1cf-5fb61730d1amr983539a12.9.1746487101116; 
 Mon, 05 May 2025 16:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZHRW3/E5M+Hg9Xjt2Z1Mr+pZgu3dXiT/m9et4Sj/m/ukAz3u4Z3vffZymywIkCFw9Qx/Trg==
X-Received: by 2002:a05:6402:280f:b0:5fb:5be8:3e2c with SMTP id
 4fb4d7f45d1cf-5fb61730d1amr983527a12.9.1746487100729; 
 Mon, 05 May 2025 16:18:20 -0700 (PDT)
Received: from [172.20.6.239] ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa777c7309sm6359228a12.19.2025.05.05.16.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 16:18:19 -0700 (PDT)
Message-ID: <c0c51cdb-107b-4ebb-abae-8494d9fc63ae@canonical.com>
Date: Tue, 6 May 2025 01:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <875xieanhm.fsf@bloch.sibelius.xs4all.nl>
 <CAM=mAOnFrM_wa5SSWYWROoY+839L87A0cSx8-X=Hr=cHB9y3Tw@mail.gmail.com>
 <20250505195452.GK5430@bill-the-cat>
 <CAM=mAOkXoXZm8Bag3SN0DYD0NG_UeYub_vkhnF6X5ODurbrttw@mail.gmail.com>
 <20250505221024.GR5430@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250505221024.GR5430@bill-the-cat>
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

On 5/6/25 00:10, Tom Rini wrote:
> On Tue, May 06, 2025 at 12:07:20AM +0200, Heinrich Schuchardt wrote:
>> Tom Rini <trini@konsulko.com> schrieb am Mo., 5. Mai 2025, 21:54:
>>
>>> On Mon, May 05, 2025 at 09:51:52PM +0200, Heinrich Schuchardt wrote:
>>>> Mark Kettenis <mark.kettenis@xs4all.nl> schrieb am Mo., 5. Mai 2025,
>>> 21:03:
>>>>
>>>>>> Date: Fri, 2 May 2025 18:08:56 +0200
>>>>>> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>>>
>>>>>> On 5/2/25 16:49, Simon Glass wrote:
>>>>>>> Hi Heinrich,
>>>>>>>
>>>>>>> On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>
>>>>>>>> The EFI boot manager bootmeth does not require variable BootOrder
>>> to
>>>>> be
>>>>>>>> preexisting. It creates this variable.
>>>>>>>>
>>>>>>>> Signed-off-by: Heinrich Schuchardt <
>>> heinrich.schuchardt@canonical.com
>>>>>>
>>>>>>>> ---
>>>>>>>>    boot/bootmeth_efi_mgr.c | 21 +++------------------
>>>>>>>>    1 file changed, 3 insertions(+), 18 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
>>>>>>>> index 42b8863815e..1669cbed5bd 100644
>>>>>>>> --- a/boot/bootmeth_efi_mgr.c
>>>>>>>> +++ b/boot/bootmeth_efi_mgr.c
>>>>>>>> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev,
>>>>> struct bootflow_iter *iter)
>>>>>>>>
>>>>>>>>    static int efi_mgr_read_bootflow(struct udevice *dev, struct
>>>>> bootflow *bflow)
>>>>>>>>    {
>>>>>>>> -       struct efi_mgr_priv *priv = dev_get_priv(dev);
>>>>>>>> -       efi_status_t ret;
>>>>>>>> -       efi_uintn_t size;
>>>>>>>> -       u16 *bootorder;
>>>>>>>> -
>>>>>>>> -       if (priv->fake_dev) {
>>>>>>>> -               bflow->state = BOOTFLOWST_READY;
>>>>>>>> -               return 0;
>>>>>>>> -       }
>>>>>>>> +       int ret
>>>>>>>>
>>>>>>>>           ret = efi_init_obj_list();
>>>>>>>>           if (ret)
>>>>>>>>                   return log_msg_ret("init", ret);
>>>>>>>>
>>>>>>>> -       /* Enable this method if the "BootOrder" UEFI exists. */
>>>>>>>> -       bootorder = efi_get_var(u"BootOrder",
>>>>> &efi_global_variable_guid,
>>>>>>>> -                               &size);
>>>>>>>> -       if (bootorder) {
>>>>>>>> -               free(bootorder);
>>>>>>>> -               bflow->state = BOOTFLOWST_READY;
>>>>>>>> -               return 0;
>>>>>>>> -       }
>>>>>>>> +       bflow->state = BOOTFLOWST_READY;
>>>>>>>>
>>>>>>>> -       return -EINVAL;
>>>>>>>> +       return 0;
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    static int efi_mgr_read_file(struct udevice *dev, struct
>>> bootflow
>>>>> *bflow,
>>>>>>>> --
>>>>>>>> 2.48.1
>>>>>>>>
>>>>>>>
>>>>>>> How do we know if the board is using EFI bootmgr? My understanding
>>> was
>>>>>>> that this was a way to find out?
>>>>>>
>>>>>> The boot manager must always run.
>>>>>>
>>>>>> The check for the BootOrder variable introduced in commit
>>> f2bfa0cb1794
>>>>>> is a bug.
>>>>>
>>>>> Well, at the time the boot manager did not attempt to boot the default
>>>>> path.  So there was no point in running the boot manager code unless
>>>>> BootOrder (or BootNext) was set.  And of course before that commit the
>>>>> boot manager didn't run at all on non-sandbox builds that had the
>>>>> standard boot stuff enebaled.
>>>>>
>>>>> Anyway, I believe the thinking behind that commit is still sound.  As
>>>>> I explained earlier, I think that...
>>>>>
>>>>>> The boot manager handles in sequence:
>>>>>>
>>>>>> * Try to boot as indicated by BootNext.
>>>>>> * Try to boot as indicated by BootOrder.
>>>>>> * Try to boot default path for available media.
>>>>>>     This will add Boot#### entries and update BootOrder.
>>>>>
>>>>> ...doing this all in a monolithic sequence isn't the best way to
>>>>> handle EFI boot in the u-boot ecosystem.
>>>>>
>>>>> Your series moves the boot manager further down the list because the
>>>>> third step in the sequence has to happen late.  But as a result
>>>>> BootNext and BootOrder processing will also happen late.  So what
>>>>> happens if you have a board with two OS installations:
>>>>>
>>>>> 1. A generic Linux distro that boots via EFI.
>>>>>
>>>>> 2. Something like Armbian that provides an extlinux.conf file.
>>>>>
>>>>> Currently such a system will probably boot OS #1.  But after your
>>>>>
>>>>
>>>> This did not happen with distoboot. So migration from distroboot to
>>>> standard boot results in a change that you want to avoid.
>>>>
>>>> changes it will probably boot OS #2.  And if OS #1 sets BootOrder or
>>>>> BootNext that will not change anything.
>>>>>
>>>>> So I think we need a solution where BootNext and BootOrder processing
>>>>> happens early, like we do now.
>>>>>
>>>>
>>>> As of today BootNext does not invoke the boot manager.
>>>>
>>>> If BootOrder is set the boot manager may fail because not all devices are
>>>> detected as "hunters" have not been running. E.g. nvme scan and usb start
>>>> are only invoked after the EFI boot manager.
>>>>
>>>> I originally suggested to probe all boot devices before the boot manager
>>>> runs, but users complained that this slows down their non-EFI boot flows.
>>>> This is why I now move it after all boot methods but PXE.
>>>
>>> Can we not see what BootOrder is and then ensure it's been "hunted" ?
>>>
>>> --
>>> Tom
>>>
>>
>> A load option may only contain the partition GUID and the file path. In
>> this case you wouldn't be able to tell whether it is for an NVMe drive, or
>> a USB stick.
>>
>> As numbering of devices cannot be expected to be stable, it is preferable
>> to use this short form of device paths for load options.
> 
> Ah, OK. So could we check and if not found print a human understandable
> error message, and continue on? I want to figure out some path that does
> not change the pre-bootstd behavior.
> 

In distroboot scan_dev_for_efi is invoked for every boot device and each 
time calls the boot manager. As usb start is only called in usb_boot 
this will result in behavior that is as non-compliant with the UEFI 
specification.

We should reach a behavior that complies with the UEFI specification.
Not changing former distro boot behavior is not a valid option.

Best regards

Heinrich
