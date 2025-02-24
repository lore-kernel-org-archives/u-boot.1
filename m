Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC16CC021A6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 10:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B9E380F88;
	Mon, 24 Feb 2025 11:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CpE0UxHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8954980017; Mon, 24 Feb 2025 11:13:43 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EBA48081A
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 11:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D94E41231
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740392020;
 bh=ssapG8ALrGq9Y4ltCOJPgC33iBHA7P/ULJd5vLGasEc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=CpE0UxHYAvPv7jZVIvMxakUPtNxsbxxT0cc2qWzBix9H3zJVl6Wuh9KMYs86Pe5vc
 vmFxN/a1kOL3ZyORKbnXm5ZVZMngSoXyQ/3qh+9Ocw3rBlcmZBJ6T44aOwxYt5BZIl
 HS5vJlN62UoGFV+4WQDhlC0+rlN5XPNP3Y7q36ZZZshhdgL3YGqwaaJEgSMIoTDNCj
 /0bDHY/PfHQ2I0StrLTNZw9eLjcbCXqjepdsvrjNIXOB4KmMkyIiLepzO5IBiE8+2K
 qzIoUfXKQPTe2Sq99MFvnQcP6G10RmgOR2Z2Wl4J6wl085yvSVGftDClzbTuBLMZSu
 K854FLK5u+E3A==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43988b9ecfbso19896885e9.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 02:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740392020; x=1740996820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ssapG8ALrGq9Y4ltCOJPgC33iBHA7P/ULJd5vLGasEc=;
 b=q/wjbZGoAwjf5Ok1RSlgOoHR7rRkmtceUdqbAHrsnwjom11wtueKRu8y+U35mAo8xs
 KXwd4h8DuHS0rJzCAOv6JeBNgcOAtG/kTcwUZ8+rjoFy+46yDmY4Kbc9dWeIOgsx5ogL
 dOr1c9fmGuXZ5pjtyXUUYzhDZoVmSVFXDb9DhS/SRia6SzqILuVOUFf/fC4ZjjkUAH0g
 BnTrOmjbDDpbix3+wX3CrJ+GMyTO+ougRHPQ/f7Zd2WzVtoBQ4CtelWbE4s+V/bAbyxX
 XzDvLGeM+NnNeRa4izqMBuDeBMsf/HaHdU13U4QW5+HLb+Pu7f6yrebb2UB6X3R1nsYD
 hNjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8a55DekmuuayXsaEkqB67mqpJoitpoQWmjqt1LxJoiTPAXEnoRz9PNQTfz1gM1fEPFC0EUsY=@lists.denx.de
X-Gm-Message-State: AOJu0YxohjLg3qzKCoYi3tZAjpBxF7WxIiZ5aPcejIAfyaCukKsFiguz
 WDAtlJfX26rDQB4aCgMzJiuv0FhX748qCsmFyEMRZiPxcNZ+jmXBoLnG2gMY8/E2M0YbFlBSg2j
 tyVfO4hi69sdPNR5DOZ1Xi2pVFShYpq3ZYuHNmTgdOpBpy82/qB02zfEiitxfvGK+J1Y=
X-Gm-Gg: ASbGncvSFzMJMn1MHYZ4MwzwGuzAOEhN3M/mGrWUYCdbbGLLjLp+VGyt8+7HuFH0CZH
 84TK8gmUHeP9iqMA1l2oEyGRLEoZB0dktUsCjOWbAygMFlqEioA5jHb1WOCZte0uz6CbhmnSU2a
 xsBj8mZGaYhrW3qAAYJ+lOEAw+/B+jko42KDZxOujT0Caozwe4OSCKT4MKPP6hDWGEqOjEYf2ys
 ou+NCnON0kkkkn/o0LXuADy+bL+4YUqR7lw87ztoB0+zUgvU+gzEYpdqASsCP1gzfyxGX+Mv4vc
 PWi5yAbV7N+uChXVklb554qCtQFR5SvvjUVw7AHTu3Awe+MgR6o0VPfZ2az3Odfo/2FIY+BgkAU
 lTOI+kMu+yW74
X-Received: by 2002:a05:600c:3515:b0:439:9828:c422 with SMTP id
 5b1f17b1804b1-43aa4c44c11mr28135265e9.18.1740392019702; 
 Mon, 24 Feb 2025 02:13:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgz4RsvDw0/YDiaIxicb71akpFdATvloJBBD64caGuxvAp5QtgQDNRt9gY2r5J6iDvRJLnFQ==
X-Received: by 2002:a05:600c:3515:b0:439:9828:c422 with SMTP id
 5b1f17b1804b1-43aa4c44c11mr28134845e9.18.1740392019290; 
 Mon, 24 Feb 2025 02:13:39 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b031b9basm101442045e9.38.2025.02.24.02.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 02:13:38 -0800 (PST)
Message-ID: <18b4e1c7-b61f-4c84-858d-26cecaaaff16@canonical.com>
Date: Mon, 24 Feb 2025 11:13:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] board: starfive: spl: strip off 'starfive/' prefix
To: E Shattow <e@freeshell.de>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, Sumit Garg
 <sumit.garg@linaro.org>, "Leon M . Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, H Bell <dmoo_dv@protonmail.com>,
 u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>
References: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
 <20250221095856.36530-4-heinrich.schuchardt@canonical.com>
 <79f87309-a4a4-4332-8ea1-9a9df0174186@freeshell.de>
 <f1252523-0ae3-4b8c-932a-de36fbbdac05@canonical.com>
 <55917f4e-b354-4ff4-9708-417b5b9aa670@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <55917f4e-b354-4ff4-9708-417b5b9aa670@freeshell.de>
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

On 2/23/25 15:18, E Shattow wrote:
> 
> On 2/23/25 04:55, Heinrich Schuchardt wrote:
>> On 2/23/25 02:33, E Shattow wrote:
>>>
>>>
>>> On 2/21/25 01:58, Heinrich Schuchardt wrote:
>>>> The configuration descriptions generated by binman contain the vendor
>>>> device-tree directory. Instead of adding it to all match strings just
>>>> strip
>>>> it off.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
>>>> ---
>>>> v3:
>>>>      no change
>>>> v2:
>>>>      no change
>>>> ---
>>>>    board/starfive/visionfive2/spl.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/
>>>> visionfive2/spl.c
>>>> index 22afd76c6b9..d63eb1abe6a 100644
>>>> --- a/board/starfive/visionfive2/spl.c
>>>> +++ b/board/starfive/visionfive2/spl.c
>>>> @@ -118,6 +118,10 @@ int board_fit_config_name_match(const char *name)
>>>>          product_id = get_product_id_from_eeprom();
>>>>    +    /* Strip off prefix */
>>>> +    if (strncmp(name, "starfive/", 9))
>>>> +        return -EINVAL;
>>>> +    name += 9;
>>>>        if (!strncmp(product_id, "VF7110", 6)) {
>>>>            version = get_pcb_revision_from_eeprom();
>>>>            if ((version == 'b' || version == 'B') &&
>>>
>>> Let's insist on logic statements in board_fit_config_name_match()
>>> callback that begin with literal items (no pointer math trickery) from
>>> configs/starfive_visionfive2_defconfig:CONFIG_OF_LIST and in that order:
>>
>> Thank you for reviewing.
>>
>> Unfortunately your sentence starting with "Let's insist" does not
>> provide insight into your reasoning.
>>
> 
> On first sight I do not like "code golf" of pointer math on the function
> parameter in-place. It seems to be okay here but does get my attention
> to look closer.
> 
> On closer look what I do want to see is 1:1 continuity between what is
> in configs/starfive_visionfive2_defconfig:CONFIG_OF_LIST and the overall
> form of this logic block so that it is uncomplicated to add more
> variants to this board target. We assume there is a pattern "starfive/"
> here but there is no such thing, this is wrong to do that. The
> originating list in the Makefile may contain literals that do not have a
> "starfive/" prefix.

The starfive/ prefix is given by the vendor name of the SoC. Linux will 
not accept device-trees for JH7110 based boards into other folders. This 
is why we will continue to have 'starfive/' in CONFIG_OF_LIST for all 
future JH7110 boards.

Binman copies the dtb name into the description field of the configurations.

> 
>> Why do you want to add the 'starfive/' to each of the strings we compare
>> instead of checking the common prefix first and the remainder next which
>> results in a smaller binary?
> 
> What are the limits on binary size, here? How important is the need to
> create this assumption of "starfive/" prefix?

The SPL size is limited by the cache size as SPL contains the DDR init 
code. See symbol CONFIG_SPL_STARFIVE_DDR.

Best regards

Heinrich

> 
>>
>>>
>>> #if CONFIG_IS_ENABLED(LOAD_FIT)
>>> int board_fit_config_name_match(const char *name)
>>> {
>>>      if(!strcmp(name, "starfive/jh7110-milkv-mars") &&
>>>         !strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
>>>          return 0;
>>>      } else if((!strcmp(name, "starfive/jh7110-pine64-star64")) &&
>>>         !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>>>          return 0;
>>>      } else if((!strcmp(name, "starfive/jh7110-starfive-visionfive-2-
>>> v1.2a")) &&
>>>         !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
>>>          switch (get_pcb_revision_from_eeprom()) {
>>>          case 'a':
>>>          case 'A':
>>>              return 0;
>>>          }
>>>      } else if((!strcmp(name, "starfive/jh7110-starfive-visionfive-2-
>>> v1.2b")) &&
>>>         !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
>>>          switch (get_pcb_revision_from_eeprom()) {
>>>          case 'b':
>>>          case 'B':
>>>              return 0;
>>>          }
>>>      }
>>>
>>>      return -EINVAL;
>>> }
>>> #endif
>>>
>>> Not sure about code style so that is simply an example of keeping the
>>> sort order the same as how it exists in
>>> configs/starfive_visionfive2_defconfig:CONFIG_OF_LIST
>>>
>>> Mars CM (and CM Lite) logic may be dropped since those targets do not
>>> exist at the moment in starfive_visionfive2_defconfig:CONFIG_OF_LIST
>>> however, I do anticipate to submit for review into Linux upstream soon
>>> and to begin that process. A donation board was sent to me so I now have
>>> Mars CM to test as well as Mars CM Lite.
>>
>> As you are planning to upstream the boards I suggest to keep those
>> lines. You could already use them by manually copying the device-trees
>> into the upstream dtb folder and adding the files to CONFIG_OF_LIST.
> 
> Yes, this dead code can be some removed with other cleanup, it does not
> have to be this series.
> 
>>
>>>
>>> Are the duplicate string definitions and logic in
>>> board/starfive/visionfive2/starfive_visionfive2.c:set_fdtfile() etc.
>>> still appropriate, could those now be factored out? I think Simon's
>>> suggestion (in reply on IRC) of CONFIG_FIT_BEST_MATCH could replace that
>>> functionality? -E
>>
>> $fdtfile is used for loading a device-tree from the ESP. I can't see how
>> CONFIG_FIT_BEST_MATCH which controls choosing FIT configurations is
>> related. We cannot set $fdtfile from SPL.
>>
>> Best regards
>>
>> Heinrich
> 
> I've now tested CONFIG_FIT_BEST_MATCH and it works as suggested:
> 
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -33,6 +33,7 @@ CONFIG_RISCV_SMODE=y
>   # CONFIG_OF_BOARD_FIXUP is not set
>   # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>   CONFIG_FIT=y
> +CONFIG_FIT_BEST_MATCH=y
>   CONFIG_BOOTSTD_DEFAULTS=y
>   CONFIG_BOOTSTAGE=y
>   CONFIG_QSPI_BOOT=y
> 
> also delete function
> board/starfive/visionfive2/starfive_visionfive2.c:set_fdtfile() and
> where it is called from within board_late_init(). Then $fdtfile is set
> not defined so the best fit is selected, or, if $fdtfile is user-defined
> then the user-defined path is loaded (same as before). The difference is
> there is not any $fdtfile env variable defined for the typical situation
> but it does apparently have some kind of heuristic and loads something
> appropriate, I am not sure if it is from U-Boot or if it is from the
> search path. This makes sense to me since we're OF_UPSTREAM now. Anyhow
> we can drop a lot of unnecessary duplicate logic and code this way. That
> change could as part of this series or as a follow-up.
> 
> -E

