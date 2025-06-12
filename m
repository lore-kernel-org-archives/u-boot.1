Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F88C71149
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 16:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD3082B70;
	Thu, 12 Jun 2025 18:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hGYKyrWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EAF582B97; Thu, 12 Jun 2025 17:04:31 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF3B3828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 17:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-235d6de331fso12899135ad.3
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749740667; x=1750345467; darn=lists.denx.de;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp0b3EDOZos1UlSKbzQNZAy8fgEyIJkeDv15y3r6AzU=;
 b=hGYKyrWx0GkUl+VwWMBQSmVsoSM/htDUeAEqRzDYWF5UJ3dczgnZ8d2V1iAo7evqIp
 ATTmDckVe7qTH4ZZWPLsTgox6WItcgcz9Q1hXiwa6HA/kEXc7QcGGYqIW54nhNB3U1rS
 x3iEMO+GlHsuJf5qkRsDkaFAsxMwf2NYbEtjG668ZhYmr+qD6yACwwP7h9qnL4GevRex
 o5o5Iz3JmjYobgYZ99PSaSEJv6v6XRSoeK7sNecgBZe3qMh+0JDuP1tqPZkr/9IuvMru
 y0quNq6kJO6uTYHpjApxzEM72AtOuVBOSAgXOV20MkyBLF8RrmGV93Z/UPa6tErHkuUD
 ieJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749740667; x=1750345467;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rp0b3EDOZos1UlSKbzQNZAy8fgEyIJkeDv15y3r6AzU=;
 b=UCvzlF+h4+MA5gEJq/U5xiDm0WeBMfhXdw97/j4JgrfpjK589Psw1KC/36ihPC+ZFX
 ov5duR3re+UKMvf3e1U6owYvP66JMdsljjZa6yyj/Qzn5qi265QfzpbXMlxoV7rVPYHn
 NK5TGTGy42H76bZBSJVk0wdLGl63GmR2mFWC4Nme6m1qgz6BxpJK8fYQT6Odh1DmaagV
 lcrFhVAX6PBPXxLDTpG7rOMyLLkcjlx5WVSXQZZp/ieZFyXvgnxg4d50nQvu2bzgC8tx
 OYB1bGtItubky2IgGJa+rxzR6oFHNNN81NfvSyXDG70o8DnEd3F/qX/zxZrio8GMpToC
 QcZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTxuNZ6vfs3wm3wjR7xxM0Y4AxNmtOUAI098fUKS1YbEZVf/Vao0eAkV9KaJvqmmjEGapkiB0=@lists.denx.de
X-Gm-Message-State: AOJu0YxQy0F1AIxreEx/VzL1BNqI1YYCsG8RWy9mncAk7Kvi43rVYdgA
 MIO3lT+WjLobbzSxyFXLbB8ewMNSbAUeuKUtZkRwXkAScCz7B3Yx4KVY
X-Gm-Gg: ASbGncvfItkJlUqmne5AAKVTt0hvpsJnTUTanx10y3MkN9q2TWju0g/ofHcUbY8hkFX
 D8HQPk55UNrQ3OVe9P4WmM4LmgM/AI+LR7KY6ToBcuHY3MCCVusz8plDqjzgrV+s9uPUPaRsj/I
 lzIZPG6y1T5YX791LgD4aNk98L2W+M/KJKDQQCLcgXJtQoy/MCIQ1UVQAihtVZgzhuGqJRUt3+h
 s++lQqCCWeEpkvIqj8u9wNnkj+SDEAH/HPSoy1MCgfMp96zrQKC7flnWv0N0gZwtIvyzE1xlooi
 PFr02TpUJrcQ8oc/NwN7DBlohJ4kmS8SPktxzygE5/a0f7eAOkPFeI/4MMpRNw4q1Ai/94L65ZE
 ozcmWgK8OMYScYR/wCdem9S7+C/L3/2QYDHPo4aHbEzHM8i4=
X-Google-Smtp-Source: AGHT+IEJv5SD3qS79v5aO+Y5Z5K5Si/xRmweYGGa72RcR2VmjXw2G+NX+2NBJjYtV/S37p2dWgDnqw==
X-Received: by 2002:a17:902:f943:b0:234:ef42:5d5b with SMTP id
 d9443c01a7336-2364c8d0c0bmr43634945ad.16.1749740665792; 
 Thu, 12 Jun 2025 08:04:25 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2364e6db306sm15098085ad.97.2025.06.12.08.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 08:04:25 -0700 (PDT)
Message-ID: <3a9d3cf6-99cd-48fe-ac38-08474de79b8c@gmail.com>
Date: Thu, 12 Jun 2025 23:04:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: [U-Boot, v1, 1/1] net: phy: Add the Airoha EN8811H PHY driver
To: frank-w@public-files.de, Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com,
 pbrobinson@gmail.com, u-boot@lists.denx.de, joseph.lin@airoha.com,
 wenshin.chung@airoha.com, lucien.jheng@airoha.com, daniel@makrotopia.org,
 ericwouds@gmail.com, albert-al.lee@airoha.com
References: <20250511051400.29853-1-lucienzx159@gmail.com>
 <trinity-e740c5ff-b6cd-404c-82c4-eaf0642a13a6-1749722988086@trinity-msg-rest-gmx-gmx-live-b647dc579-66mhx>
 <20250612143641.GL1382132@bill-the-cat>
 <21560DBA-8398-47D3-95EA-719508A689A8@public-files.de>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <21560DBA-8398-47D3-95EA-719508A689A8@public-files.de>
X-Mailman-Approved-At: Thu, 12 Jun 2025 18:09:03 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


Frank Wunderlich 於 2025/6/12 下午 10:44 寫道:
> Am 12. Juni 2025 16:36:41 MESZ schrieb Tom Rini<trini@konsulko.com>:
>> On Thu, Jun 12, 2025 at 10:09:48AM +0000,frank-w@public-files.de wrote:
>>
>>>> Gesendet: Sonntag, 11. Mai 2025 um 07:14
>>>> Von: "Lucien.Jheng"<lucienzx159@gmail.com>
>>>> Betreff: [U-Boot, v1, 1/1] net: phy: Add the Airoha EN8811H PHY driver
>>>>
>>>> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
>>>> 100/1000/2500 Mbps with auto negotiation only.
>>>>
>>>> The driver uses two firmware files, for which updated versions are added to
>>>> linux-firmware already.
>>>>
>>>> Locating the AIROHA FW within the filesystem at the designated partition
>>>> and path will trigger its automatic loading and writing to the PHY via MDIO.
>>>> If need board specific loading override,
>>>> please override the en8811h_read_fw function on board or architecture level.
>>>>
>>>> Linux upstream AIROHA EN8811H driver commit:
>>>> 71e79430117d56c409c5ea485a263bc0d8083390
>>>>
>>>> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
>>>> I have modified the relevant process to align with the U-Boot boot sequence.
>>>> and have validated this on Banana Pi BPI-R3 Mini.
>>>>
>>>> Signed-off-by: Lucien.Jheng<lucienzx159@gmail.com>
>>>> ---
>>>>   drivers/net/phy/Kconfig       |  43 ++
>>>>   drivers/net/phy/air_en8811h.c | 852 ++++++++++++++++++++++++++++++++++
>>>>   2 files changed, 895 insertions(+)
>>>>   create mode 100644 drivers/net/phy/air_en8811h.c
>>> Hi,
>>>
>>> is there any progress? i see no review or apply (+tom in To-header).
>> I'm not super thrilled at the concept of having to load firmware from a
>> filesystem. But since we have to do this anyways in other cases, is this
>> something we could be using FS_LOADER for or no?
>>
> The filesystem loading was requested in mailinglist.
> Original version loaded firmware from emmc boot1 partition (current openwrt driver version) or c header file generated from the binaries (my version). I do not know FS_LOADER yet,but if this a more generic way to load firmware file it could be a way. Lucien,what do you think?
>
>
> regards Frank

I'm not very familiar with the FS_LOADER part of U-Boot, so I'll need to look into that.

However, based on previous mailing list discussions, it was suggested that I refer to the Aquatia PHY and its method of loading the PHY firmware from the filesystem on a block device.

Additionally, the recommendation was to implement a __weak default loading from a file on the filesystem by default.

This way, if a specific platform needs to replace its loading method, it can simply be overridden at the board or architecture level.

Thanks
Lucien Jheng

