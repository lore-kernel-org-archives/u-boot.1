Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF412CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 04:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6C286E54;
	Thu, 12 Oct 2023 06:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q7I9kdCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84BCF86D4D; Thu, 12 Oct 2023 06:18:49 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C5586D4D
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 06:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41810cfc569so3599631cf.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 21:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084326; x=1697689126; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W2tcmVoHggu64NpuiSKD4rrpwdCHtBlI5DQcVLboOV4=;
 b=Q7I9kdCknqynAzTnj/IBqRAlFzXoxawt3wMVFLfUN5gd8rrDFuHomCnOSA3PKugI+3
 +G6/l9ZxLoftXdRvvBkujzN8Pvzt2PzyYfhG6MGS/My6IC9ctjUZ6lkUN/2jEGw+GDS4
 wlb7vux2R36D6B7oL9MN/QQHzR28xD43JJfZRIJu8GaOeTw/qAjVz+3wgtYZlZ0jtX8U
 oe2WjsHu+g17v2olcI+ttdzeuYVDL1zrw+1ckksC887JZ+sg3zY0Sd0qcI/Awxjp0y+R
 fwY8HnQRlJ8yvFB3AR1LNMK3+eCh2QWqrFG0DaaGSE4h40hpPKurlyLX1O6UzNCatr5/
 b5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084326; x=1697689126;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W2tcmVoHggu64NpuiSKD4rrpwdCHtBlI5DQcVLboOV4=;
 b=v+lE8/0ejs6VDm4lYDUkDyMv13RHHrnN7IZdbq7tpkGSJMNN47f+5mbQWsswxfUs1E
 oOxY9imnf2k/i6UTcwubW7FhwURq2LkTmZY4i5OyPpWTudMIarLJLFFsplBBFunSSNIi
 SL5A7I+X4KgRZAy5rhL0v+NYvVOVO6FEiBAlk4eLtnod6Cl+CrLq2BJASsU+QIcH0F5H
 8y5yO4FLacHmGBnr+k3kYuHKAIv8DQGZw3/cx9H92o6MJlqucVwPRwOLjdVLFvZ4ZH6V
 z1eifcpTTRZCLnkkgFKwJ1lh24Fl2Bphi2u3BLczNS71jGska2PcQGvbU131X1zSRRlh
 Mzyg==
X-Gm-Message-State: AOJu0Yy5rGhQwgUrpIgepcGvYttJco/zYK2pr/TfdpqyuHRx9fOF0ngd
 Tar5zMATTXIFRlnKZ//NzXk=
X-Google-Smtp-Source: AGHT+IFGmUDksFUpIHubedMYPAPdBRlAUnMjijpieArJsJ5yh7rBiV/TZXQ5+gPhwkyZ/Doy0n63tQ==
X-Received: by 2002:a05:622a:512:b0:419:52a9:9ffc with SMTP id
 l18-20020a05622a051200b0041952a99ffcmr26980281qtx.35.1697084326073; 
 Wed, 11 Oct 2023 21:18:46 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 z1-20020ac86b81000000b004198f248e8dsm5896705qts.76.2023.10.11.21.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:18:45 -0700 (PDT)
Message-ID: <c8fd9934-279a-1e4c-fd4c-8388f9ebb348@gmail.com>
Date: Thu, 12 Oct 2023 00:18:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 16/26] spl: Don't cache devices when UNIT_TEST is enabled
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-17-seanga2@gmail.com>
 <CAPnjgZ1_cS9ABEr=2zgZVjhkdk=XWgdkWZiAMT__C_E2QozA7g@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ1_cS9ABEr=2zgZVjhkdk=XWgdkWZiAMT__C_E2QozA7g@mail.gmail.com>
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

On 10/11/23 23:41, Simon Glass wrote:
> Hi Sean,
> 
> On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> Several SPL functions try to avoid performing initialization twice by
>> caching devices. This is fine for regular boot, but does not work with
>> UNIT_TEST, since all devices are torn down after each test. Disable caching
>> so we don't use stale devices.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>>   common/spl/spl_fat.c | 2 +-
>>   common/spl/spl_mmc.c | 3 ++-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
>> index c6e2526ade1..8bec9cce5ca 100644
>> --- a/common/spl/spl_fat.c
>> +++ b/common/spl/spl_fat.c
>> @@ -24,7 +24,7 @@ static int spl_register_fat_device(struct blk_desc *block_dev, int partition)
>>   {
>>          int err = 0;
>>
>> -       if (fat_registered)
>> +       if (!CONFIG_IS_ENABLED(UNIT_TEST) && fat_registered)
> 
> These sort of things worry me, since we are bringing test code /
> conditions into the 'real' code. Is it possible to pass this as a
> parameter, or adjust the value of fat_registered?

At the moment these variables are static, and I would like to keep them that way
to avoid size growth. We really are doing an unusual thing with UNIT_TEST where
devices which were previously valid can be free'd and then recreated later. This
is why I decided on using UNIT_TEST as the determiner here, since nothing else
should cause this situation.

--Sean

>>                  return err;
>>
>>          err = fat_register_device(block_dev, partition);
>> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
>> index 67c7ae34a58..a8579e29dee 100644
>> --- a/common/spl/spl_mmc.c
>> +++ b/common/spl/spl_mmc.c
>> @@ -417,7 +417,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
>>
>>          /* Perform peripheral init only once for an mmc device */
>>          mmc_dev = spl_mmc_get_device_index(bootdev->boot_device);
>> -       if (!mmc || spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
>> +       if (CONFIG_IS_ENABLED(UNIT_TEST) || !mmc ||
>> +           spl_mmc_get_mmc_devnum(mmc) != mmc_dev) {
>>                  err = spl_mmc_find_device(&mmc, bootdev->boot_device);
>>                  if (err)
>>                          return err;
>> --
>> 2.37.1
>>
> 
> Regards,
> Simon

