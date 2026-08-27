Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF111C61DC7
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 987C780ECB;
	Thu, 27 Aug 2026 19:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xZXgUCMz7YDn; Thu, 27 Aug 2026 19:50:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860242;
	bh=k6vrGsStRsTRVZfgw/McKMdal07vV7H5P60AIWEin7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J6yPSZwSRTCu7U3t6MNlkwh+Y6hvguJDhI4F/psiI49ZHF6vzb1xex1yg9iQv6Sqx
	 y2VypxR/LpKPYNbpgT4TGOSO5WV+dJdwzGYrkFXF4FYQP5UHkS/MYH/2RTkwof6SB5
	 B7LnTZQqEDLAnDWc0shNVUsZubZDLHHj9wJAVKKbDwYyLlGimRaYnOcX6vpnipi24N
	 VosXx9+a1cibj/OUC6KeM7yXac7echP840lj3rVZ/lRmck3nF8tKlEUkalPDJY/3qI
	 TDGdL1RNkbnI3UkvH1rXjcOU74syfx2vPhAnCPU1WegcXN2OYP9tcwiwcnqbP7esyG
	 qnuLdVE9CzaCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AFF480E52;
	Thu, 27 Aug 2026 19:50:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CC50334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 16:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B447607CB
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 16:04:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFVtP765GNYv for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 16:04:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=X0d1JddL
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97D7A607C5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 16:04:57 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso10520595e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787846695; x=1788451495;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k6vrGsStRsTRVZfgw/McKMdal07vV7H5P60AIWEin7k=;
 b=X0d1JddLh4NtYs25+YB0lSCjAh0ijtlLxzs3BLsHlPQS8hYytjNK8f5tIeVLPBPHRh
 6w2OVJlmK/0H5x+qI7Dw0KGG8livAcJvlH9yafK19TgKcQRoN9G7bmQNV0ImHPxED34w
 M2A+WwoRYIUmcvUrb+dzAr1cHpD2hXtsYEwqIt18Iv+CRvmpmY6ZgYd/v7yZ8xma3qAi
 mP1HS0+JP4lLKPEKTMh7buU/wlePp+KjvVYD/FZgHc4Le8PY1Y0R4fgmBnGQQO1dX3XI
 KphZrHOB20d6OD7DeLQSWHPWR/aO4aOu1mKbyZc1FQStknlJopjCixQiKh2Bds/itxeS
 zJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787846695; x=1788451495;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k6vrGsStRsTRVZfgw/McKMdal07vV7H5P60AIWEin7k=;
 b=GdDYjFxcKj66MHLqOP798UOWN3eXIrji5znokxL2yw/aphVIEyNvkTYek4pA5cwNco
 iPAIluDtMemXdhFS5zHqAI1kS9scI8qmNlxVaqFu9FO9f8O8DQxt9fiBrz8VegeNiDx2
 e/ZD/6duRgrAK9z2bRjU/GKGfy7RP9gviRMcZcNxjheNmQS3bC/lNoj29pIr6pizrwno
 FA/iCUEYQFm6gYOa6uC18TN+Z0qZjXjHwKbjLvy8y5BVoLB77uarHYTuCwEdV+S2Lg81
 8rdEogYn7MeajJjZ58MWyTnzPamMd5k7EBvDlrMz4GSXfdGW7TR9C/ERm/s7bmfD0Iaq
 SdAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLm98rmbrymg48Ch9LsjNUMAIpVdZ8zf9LEXVjkh5WuJHjIkK4F7pRk2qtXulnUFNynkkYt7E=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mp3oPTovJCQveNBAIN41hdSps8H9+XHn6V2dM7Cr22qgfVzkOd
 VdWNI5LyN0bj0Lh+2D5qe5FtCyNtbTHbxoNFXR3ebT9FN/Ru0h8m6m6SFXdN2Q==
X-Gm-Gg: AR+sD13FZmm1vbnSqzFsUBmrnbmOJ2mEAr58UsWXEnjjKw77Z2pvHzEKHk2Sj/btJAi
 fLGvZT78A4ObpLb0ioszDEU++viJj5duuZko44JJ0Bcy/WaJ+ToWntwymfTnf5pK49zLhwUYD4t
 denybuQSQpRXaUy+bY3+rx4gU6B4X34nPXtDSi/EjoSIYp8pAE0kBkJoLrnj2ktbivTk9yieT0c
 JCDeyYNAB1BK6Yb2i3eDu9WqHZ87rgUe8XukTSt5d7I5nrMz5Wo+tAEuvPgoyHEJPp4Vlldxlkm
 enJl7o7ogqaBOrky2KwLwBRqQ1r7y1FODnvJJOsCuC1tos8UV7m3eGCgd2zNV2764hZUBSNfUl6
 KAG4/2AHNF/izJ42xYCzTS5qsnr570b3pXWktaVjCObqWw6WEJpI9cDMFg+wkuRkpefRNU/VVvT
 Mqouu0Qg4hk8prrbMuRZvMYqX9iJ4xjE95+od1iV8VNfDE2cYDYnGqAkYTrTtb5QoK3MmhNPQjQ
 7ef0L5glLgQvONOieGJOcVv6xouWX6jAKjgjo/o6uPjiruxpadgMVJVC9m8hbKR4hU6JDVkl8Pn
 UJyPT2W3Cm0OkYskfsWdZwQ0kaLNJu2V+1qmELBfo4iWaeQDWb24xr4Cts8jgfMlXWJDKWSK51d
 eOtc=
X-Received: by 2002:a05:600c:4e14:b0:499:ae94:be05 with SMTP id
 5b1f17b1804b1-49b91bd78c0mr1031955e9.0.1787846694874; 
 Thu, 27 Aug 2026 09:04:54 -0700 (PDT)
Received: from ?IPV6:2a02:8388:e6ca:5780:880a:5aae:e8c6:da04?
 (2a02-8388-e6ca-5780-880a-5aae-e8c6-da04.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:880a:5aae:e8c6:da04])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49cc6446sm55110985e9.7.2026.08.27.09.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 09:04:54 -0700 (PDT)
Message-ID: <638029f8-37a7-46e9-aa3e-9defe840c639@gmail.com>
Date: Thu, 27 Aug 2026 18:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] board: sophgo: add support for Milk-V Duo 256M
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
 <20260822091510.3253162-1-andrey.lalaev@gmail.com> <ao2Iqsq-Xp4dQK4c@hiagonb>
 <e3ac37d0-be2a-470a-aaa1-0cdcb3b7b45b@gmail.com> <apA3hSs_P_NYkOCM@hiagonb>
Content-Language: en-GB
From: Andrei Lalaev <andrey.lalaev@gmail.com>
In-Reply-To: <apA3hSs_P_NYkOCM@hiagonb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 19:50:39 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Hiago,

On 27.08.26 15:30, Hiago De Franco wrote:
> Hi Andrei,
> 
> On Tue, Aug 25, 2026 at 08:01:37PM +0200, Andrei Lalaev wrote:
>> On 25.08.26 14:24, Hiago De Franco wrote:
>>> Hi Andrei,
>>>
>>> On Sat, Aug 22, 2026 at 11:15:10AM +0200, Andrei Lalaev wrote:
>>>> Hi Hiago,
>>>>
>>>> Thank you for the patches.
>>>>
>>>> From your cover letter I understood that SD card is supported.
>>>> However whatever I try, I always get the following error:
>>>>
>>>>     U-Boot 2026.07-00002-gbd5e3de2ed6a (Aug 22 2026 - 10:27:48 +0200)milkv_duo_256m
>>>>
>>>>     DRAM:  256 MiB
>>>>     Core:  20 devices, 13 uclasses, devicetree: separate
>>>>     MMC:   mmc@4310000: 0
>>>>     Loading Environment from nowhere... OK
>>>>     In:    serial@4140000
>>>>     Out:   serial@4140000
>>>>     Err:   serial@4140000
>>>>     Net:
>>>>     Warning: ethernet@4070000 (eth0) using random MAC address - 16:21:8c:10:cd:96
>>>>     eth0: ethernet@4070000
>>>>     Hit any key to stop autoboot: 0
>>>>     milkv_duo_256m# mmc info
>>>>     Card did not respond to voltage select! : -110
>>>>     milkv_duo_256m# mmc rescan
>>>>     Card did not respond to voltage select! : -110
>>>>
>>>>
>>>> I tried 2 different SD cards and got the same result.
>>>>
>>>> Am I doing something wrong, or is there something else I need to configure?
>>>
>>> You are most likely missing this patch:
>>>
>>> https://lore.kernel.org/all/20260507234836.284918-1-hfranco@baylibre.com/
>>>
>>> This is needed in order to make the SD card work. This patch is already
>>> merged on main branch, as commit 3a4a8963aace ("mmc: cv1800b_sdhci:
>>> honor 'no-1-8-v' DT property").
>>>
>>> Check this patch and let me know if it works now ;)
>>
>> Thank you for your response:)
>>
>> I also tried the latest main branch (so all patches are definitely included)
>> and had the same problem.
>>
>> I guess I somehow managed to fix the problem, so below I'll describe what I did
>> and would like to hear your thoughts about it.
>>
>>
>> When I generated `fip.bin` using precompiled binaries from fiptool repo [1],
>> it started working most of the time. Previously I was using an FSBL manually generated
>> using official SDK [2]. However, I would still occasionally get
>> voltage select error and timeouts.
>>
>> So I started comparing FSBL and U-boot from Sophgo (2021.10) and
>> I couldn't find any differences that could explain this behaviour.
>>
>> Today I found out that the kernel DTS configures the SD0_CLK pin to a different value [3].
>> By default, we have 0x48 in IOBLK_G10_REG_SD0_CLK register, but if I set it to 0x84
>> like kernel does, it magically starts to work all the time.
>>
>> I understand why increasing the drive strength fixed timeout issues, but I don't understand
>> why I don't see the same problem with the U-Boot from Sophgo (2021.10).
>>
>> 1 - https://github.com/sophgo/fiptool
>> 2 - https://github.com/milkv-duo/duo-buildroot-sdk-v2/tree/main
>> 3 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/sophgo/sg2002-milkv-duo256m.dts#n68
> 
> Thanks for digging into this.
> 
> I made some tests here on my milkv-duo 256M and I might have the answer
> you are looking for, hopefully.
> 
> 0x48 is SoC reset value, based on the TRM. This is what I read on my
> U-Boot (main branch, like yours):
> 
> 0x03001a00 SD0_CLK = 0x48 pull-down, 10800 uA  <-- reset value
> 
> So on my board the BootROM already does everything Sophgo's
> cvi_sdio0_pad_setting() does. SD0_CLK is the single register nobody
> programs, exactly as you found. I also checked the FSBL and it never
> touches SD0 and never touches drive strength, from what I could see.
> 
> I am not able to reproduce your issue, it works every time for me. I
> suspect there is a difference on the hardware here: maybe your board has
> less margin for the drive strength than mine, it works at the stock
> 50MHz even with the CLK drive strength at its minimum.
> 
> To trigger the issue, I had to force SDHCI divider from N=4 to N=2, so
> doubling the clock. With that, I triggered your issue. Of course I am
> not sure if this is the same issue that is triggering your, but at least
> now with the double clock I was able to increase the drive strength by
> writing 0x84 (the kernel value) and it fixed the issue (which makes
> sense).


That's interesting. Thank you for your investigation.


> I was not able to properly answer the reason why Sophgo U-Boot works, so
> I used Claude to look at the code for me and compare the differences,
> here is what it found out:
> 
> "It is the PHY. cvi_sdhci_set_ios_post() has a DS/HS branch that does:
> 
>     PHY_CONFIG    (0x24c) |= BIT(0)          /* TX_BPS */
>     PHY_TX_RX_DLY (0x240)  = 0x01000100
> 
> The kernel does the same thing, unconditionally, in
> cv18xx_sdhci_reset() (drivers/mmc/host/sdhci-of-dwcmshc.c):
> 
>     val |= CV18XX_PHY_TX_BPS;                     /* PHY_CONFIG bit 0 */
>     val = TX_DLY(0) | TX_SRC(INVERT_CLK_TX)
>         | RX_DLY(0) | RX_SRC(INVERT_RX_CLK);      /* == 0x01000100 */
> 
> Upstream U-Boot does neither. cv1800b_sdhci.c only writes
> SDHCI_PHY_TX_RX_DLY from cv1800b_execute_tuning(), reached only through
> platform_execute_tuning - and that never runs on this board, because
> no-1-8-v caps us at High Speed 50MHz / 3.3V and tuning only happens in
> UHS modes."
> 
> I am not 100% convinced by that, but I will take a look, we might need a
> patch here on upstream to configure the PHY properly as the downstream
> u-boot and kernel does. Anyway, is funny that I can only reproduce your
> issue on this conditions, but these boards might not be something we can
> blindly trust ;)
> 
> Could you dump these on your board, at the U-Boot prompt on unmodified
> upstream main, before touching anything?
> 
>     md.l 0x03001a00 8      # SD0_CLK / CMD / D0-D3 pad config
>     md.l 0x03001900 4      # SD0_CD, SD0_PWR_EN
>     md.l 0x030001f4 1      # sd_pwrsw_ctrl
>     md.l 0x0300101c 8      # SD0 pin mux
>     md.l 0x04310240 1      # PHY_TX_RX_DLY
>     md.l 0x0431024c 1      # PHY_CONFIG


Sure, here is the register dump before `mmc rescan`:

  # SD0_CLK / CMD / D0-D3 pad config
  milkv_duo_256m# md.l 0x03001a00 8
  03001a00: 00000048 00000044 00000044 00000044  H...D...D...D...
  03001a10: 00000044 00000044 00000010 00000000  D...D...........

  # SD0_CD, SD0_PWR_EN
  milkv_duo_256m# md.l 0x03001900 4
  03001900: 00000044 00000048 00000048 00000044  D...H...H...D...

  # sd_pwrsw_ctrl
  milkv_duo_256m# md.l 0x030001f4 1
  030001f4: 00001209                             ....

  # SD0 pin mux
  milkv_duo_256m# md.l 0x0300101c 8
  0300101c: 00000000 00000000 00000000 00000000  ................
  0300102c: 00000000 00000000 00000000 00000000  ................

  # PHY_TX_RX_DLY
  milkv_duo_256m# md.l 0x04310240 1
  04310240: 00000000                             ....

  # PHY_CONFIG
  milkv_duo_256m# md.l 0x0431024c 1
  0431024c: 00000000                             ....

and after:

  milkv_duo_256m# mmc rescan
  unable to select a mode

  # SD0_CLK / CMD / D0-D3 pad config
  milkv_duo_256m# md.l 0x03001a00 8
  03001a00: 00000048 00000044 00000044 00000044  H...D...D...D...
  03001a10: 00000044 00000044 00000010 00000000  D...D...........

  # SD0_CD, SD0_PWR_EN
  milkv_duo_256m# md.l 0x03001900 4
  03001900: 00000044 00000048 00000048 00000044  D...H...H...D...

  # sd_pwrsw_ctrl
  milkv_duo_256m# md.l 0x030001f4 1
  030001f4: 00001209                             ....

  # SD0 pin mux
  milkv_duo_256m# md.l 0x0300101c 8
  0300101c: 00000000 00000000 00000000 00000000  ................
  0300102c: 00000000 00000000 00000000 00000000  ................

  # PHY_TX_RX_DLY
  milkv_duo_256m# md.l 0x04310240 1
  04310240: 00000000                             ....

  # PHY_CONFIG
  milkv_duo_256m# md.l 0x0431024c 1
  0431024c: 00000000                             ....

And if I try to rescan several more times (until SD card is detected
and `mmc info` succeeds), all the registers have the same values as before.

I will probably dump registers with downstream U-Boot and
tracing enabled this weekend.

> Meanwhile I will be able to investigate this further in a couple of
> days.

Thank you for your assistance :)
 >>
>>>>
>>>>
>>>> Best regards,
>>>> Andrei Lalaev
>>>
>>> Regards,
>>> Hiago.
>>
>>
>> -- 
>> Best regards,
>> Andrei Lalaev
> 
> Regards,
> Hiago.


-- 
Best regards,
Andrei Lalaev
