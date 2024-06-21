Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F33C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 09:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 222F5880AD;
	Fri, 21 Jun 2024 11:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mCUVtP6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762308839C; Fri, 21 Jun 2024 11:44:40 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4407B88013
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 11:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57d0eca877cso2060495a12.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 02:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718963078; x=1719567878; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xvYWExG+a0K8fVDEL5cE0K9xp5Sd1TSW/wSjo6GbYi0=;
 b=mCUVtP6PUD44CSUROWkzMJRP2DcjUMaLKAPHdJDk53tnLy5RdkwFuMDBPuUgvzzGZu
 lMD0ZDd39TbKpVncqgQzTvPpyMjybzKOrcPjupidQ1+rK4jdAsS+rKvkMeTdhybAejI9
 XkkUBJTJLvWyijmSrF2wDJLQwjTuQQfVBrxpruvNpcf0sd/gQ2l1GXFp1z+xO2phM5Cw
 Q0/qfujsd+/JAjR8I1M+kq3VShgcMuQH5IlhoozfjLzjzH1deLoqJW4JTu4oFTrBA8sI
 id7jaXJKHoIgBndUPxe55ZLMLSzHz8ltZnds598nh285QDGZ+h3Hj/5NncKla8gAfRRj
 NHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718963078; x=1719567878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xvYWExG+a0K8fVDEL5cE0K9xp5Sd1TSW/wSjo6GbYi0=;
 b=q+DTLvTiYt7jgJNC9rwTunE9TJsG42GQdG4EI8T1oC83iSj40y+Th0warmpKo+/XxJ
 ix9LqkSMo0GTCZsf6AZ7voUygbFPGA9tAQvLxJAnZFurtrSXZhS27QvBK4Qr0dP7996q
 DqOVXS9FS3mUjSZqXKp2Yfxnd1VPDDW6Eyl2OJ7dBLUmpSS5ebHYZOv35VBtATFAcXLA
 Z+kkP1K0AwT2dLnacSWrelmuToeJacvFKaLhzc43+5ikrJofjomb9hIQq7f+rpduh6kt
 q/Yr3ibExoYD+qOEVuL6lgrHLhlnh5zc4EeSfL2ENIJmqrwQ/iKcDi5Yl9WczXQAjfQG
 eqmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq/OUvMVCfYysxIxGW8LRcwCZ3mUUyLphQxiRiUaFTMFIyzD7Db4F99gtxjR+rf+yH+1/on6iow54Ohci852T9HEjn+g==
X-Gm-Message-State: AOJu0YyIl6+U7oz7nDHIgEQdY1YAG8M44ah57IzaQaaTRRKeBW7Egvo6
 CrPKoF/LPwnpB8BVxsJfWA1GNOIwvDIlVsRasveI+0+/62MjTt77pN3dZjpiaUg=
X-Google-Smtp-Source: AGHT+IGHMn8JOy/f7FmiOriqbNxXRBi8esJThyLxNKu7akHYYESLQF09ecDU2NbLZ4ePIAyF5dzsyg==
X-Received: by 2002:a50:cd97:0:b0:57c:80bf:9267 with SMTP id
 4fb4d7f45d1cf-57d07e6ecc1mr5713635a12.6.1718963077450; 
 Fri, 21 Jun 2024 02:44:37 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::ebdd? ([2a02:8109:aa0d:be00::ebdd])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303d80f7sm689207a12.8.2024.06.21.02.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 02:44:37 -0700 (PDT)
Message-ID: <ceba95fe-32d4-4bbc-99e7-b76fed9ebb2a@linaro.org>
Date: Fri, 21 Jun 2024 11:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: move default environment to a file
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240617085629.1744017-1-caleb.connolly@linaro.org>
 <CAFA6WYM1Rah1=Ktxk-64YhhwLQV7m9D0ixvErcMh7DDv7ssgVg@mail.gmail.com>
 <d64e6ce3-0bc5-4175-af7c-6146d4402c60@linaro.org>
 <CAFA6WYOZjm6akShXbL2UG+Cs=CAxZAmdG+WkiVt=KESOvvbc+g@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYOZjm6akShXbL2UG+Cs=CAxZAmdG+WkiVt=KESOvvbc+g@mail.gmail.com>
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



On 21/06/2024 10:07, Sumit Garg wrote:
> On Fri, 21 Jun 2024 at 13:19, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>>
>>
>> On 21/06/2024 09:35, Sumit Garg wrote:
>>> Hi Caleb,
>>>
>>> On Mon, 17 Jun 2024 at 14:26, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> Make use of CONFIG_DEFAULT_ENV_FILE and move the default qcom
>>>> environment to a file under board/qualcomm.
>>>>
>>>> This is much cleaner and means we don't need to recompile on changing
>>>> the environment.
>>>>
>>>> Additionally, extend the environment to include a boot menu and
>>>> auto-boot using EFI instead of bootm. Since we now support MMC and USB
>>>> on most platforms, these are much more useful defaults.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>    board/qualcomm/default.env | 12 ++++++++++++
>>>>    configs/qcom_defconfig     |  2 ++
>>>>    include/configs/qcom.h     |  7 -------
>>>>    3 files changed, 14 insertions(+), 7 deletions(-)
>>>>    create mode 100644 board/qualcomm/default.env
>>>>
>>>> diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
>>>> new file mode 100644
>>>> index 000000000000..243aede77be7
>>>> --- /dev/null
>>>> +++ b/board/qualcomm/default.env
>>>> @@ -0,0 +1,12 @@
>>>> +stdin=serial,button-kbd
>>>> +stdout=serial,vidconsole
>>>> +stderr=serial,vidconsole
>>>> +bootfile=/extlinux/extlinux.conf
>>>
>>> Is this file used to perform EFI boot or is it redundantly copied from
>>> somewhere?
>>
>> This is here because there's a bunch of codepaths in U-Boot that
>> implicitly expect the bootfile environment variable to have something
>> useful in. It stops a whole class of null pointer exceptions.
>>
>> extlinux isn't used for EFI booting, but it's supported, and having a
>> sensible default here is nice-to-have regardless.
> 
> extlinux is a different boot method as compared to EFI, so it looks
> confusing to use extlinux as default when we want EFI to be the
> default. AFAICS, bootfile simply means the file to load and boot which
> makes it more suitable for Linux image ("Image") to be the default
> option.

Image? Why not Image.gz, vmlinuz, or vmlinuz.efi?

The value is meaningless, since all this does is stop U-Boot crashing if 
you run some commands without arguments.

The only times I've ever encountered bootfile has been in pxe or 
something related, where extlinux.conf was expected. Obviously this is a 
heavily overloaded variable...

Maybe I should just leave it unset to encourage folks to fix more of 
those unchecked accesses...

I don't think changing this to Image would be any more sensible than its 
current value.
> 
> With that change, feel free to add
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> 
> -Sumit
> 
>>
>> Kind regards,
>>>
>>> -Sumit
>>>
>>>> +preboot=scsi scan; usb start
>>>> +fastboot=fastboot -l $fastboot_addr_r usb 0
>>>> +do_boot=bootefi bootmgr
>>>> +bootmenu_0=Boot first available device=run do_boot
>>>> +bootmenu_1=Enable fastboot mode=run fastboot
>>>> +bootmenu_2=Reset device=reset
>>>> +menucmd=bootmenu
>>>> +bootcmd=run do_boot
>>>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>>>> index 80ad3b32e139..a9e3797bb39a 100644
>>>> --- a/configs/qcom_defconfig
>>>> +++ b/configs/qcom_defconfig
>>>> @@ -35,8 +35,10 @@ CONFIG_CMD_BMP=y
>>>>    CONFIG_CMD_LOG=y
>>>>    CONFIG_OF_LIVE=y
>>>>    CONFIG_OF_BOARD_SETUP=y
>>>>    CONFIG_BUTTON_QCOM_PMIC=y
>>>> +CONFIG_USE_DEFAULT_ENV_FILE=y
>>>> +CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
>>>>    CONFIG_CLK=y
>>>>    CONFIG_CLK_QCOM_QCM2290=y
>>>>    CONFIG_CLK_QCOM_QCS404=y
>>>>    CONFIG_CLK_QCOM_SDM845=y
>>>> diff --git a/include/configs/qcom.h b/include/configs/qcom.h
>>>> index e50b3bce5cdd..5b5ebbd844df 100644
>>>> --- a/include/configs/qcom.h
>>>> +++ b/include/configs/qcom.h
>>>> @@ -10,12 +10,5 @@
>>>>    #define __CONFIGS_SNAPDRAGON_H
>>>>
>>>>    #define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
>>>>
>>>> -/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
>>>> -#define CFG_EXTRA_ENV_SETTINGS \
>>>> -       "stdin=serial,button-kbd\0"     \
>>>> -       "stdout=serial,vidconsole\0"    \
>>>> -       "stderr=serial,vidconsole\0" \
>>>> -       "bootcmd=bootm $prevbl_initrd_start_addr\0"
>>>> -
>>>>    #endif
>>>> --
>>>> 2.45.0
>>>>
>>
>> --
>> // Caleb (they/them)

-- 
// Caleb (they/them)
