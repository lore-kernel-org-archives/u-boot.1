Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2471D65C7E
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D34589206;
	Thu, 14 Nov 2024 18:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o7o6taFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F8089241; Thu, 14 Nov 2024 18:13:36 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E128788AE8
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so125230866b.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731604413; x=1732209213; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IbdZzZZhNpVybTPAcGQN4RMW2ONsC7YXU+4rKiVfnTc=;
 b=o7o6taFWAWtv+e/X/tq4Id1yGTD1m/V8EO9FIaTYGYHblEVv7RHqM74y6RMJ+5CRNK
 AWMi+5y9JoT46LhIKMwTREMYEeXa8n2r5FcnTGaqKuEUFBarYxf6OgPLQQErIx9MS/uC
 iAcVvwJVqhZ2vIMH6OH6jIVl2q0/dyDWNIPjmp0IaMrNcdd/+gLr3yOVeNF4T4AbvZ63
 6VaGp42doFsMI63pT971FbBiQxbjqciST1m/Bua2Vi5v1OXox9b3pv6zdky3h3Is2Wng
 2MEZzkmlWUjai0bljkFR/nANaqcgey1Xm2gKWtq64R0dKBLJaOUa83ZzRdcnAeUCFihK
 2bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731604413; x=1732209213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IbdZzZZhNpVybTPAcGQN4RMW2ONsC7YXU+4rKiVfnTc=;
 b=j0qOPDtF18O5HT8542VrGvkXYo518sNMln/aqwBL7Yjk5Vsc6Cpsxb6sCZHXfLevVo
 UxK177P9HPTuOO5moB5MR5Gh9IF3RH4hgEwE6NZRDIZ0HQSosZmDHVPk/rBHv0KcwKSo
 DtR54miChizwhvCIsIH3TmKsD6MP5DIOfECrbV+p13dHr3wQ3gNYj+sUeVGD++tRo9V7
 ROhApBP+fkcIhHwO0JiIMxn5vSNLX+3IuY0CW8jaN4Bx6ygF9QpLNSBXGEjhQX+MmGme
 maR2pGS3jNXDFLWn4YPPTSdsEEQ6F9hGZ0ZuRxrcaekNSG7bilR8o6negk0lNVaRvkzI
 DULg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD20Hfd88e98pockBPxNR/9KLGYbZh3GlPLw0HIKF9Yi8IBda8KrrCuKyvIC8P5G/FucKcY/s=@lists.denx.de
X-Gm-Message-State: AOJu0YzW50nWvfyzTZsn48/MBmVf3kV0L2qUXFliIMjulnI/oCP9ryqr
 ZukPQEInpaJJQFvFu/wWuNTGou3Q20JqfikV8coV/ojT+neF/GkyfAMdktc2a0m+WLhPOte4oqT
 BYw8=
X-Google-Smtp-Source: AGHT+IG19AYAdgtWBJbuspJnz893xNJQuIIABDvwFC7yHgeJBDlZZ5h63QihzaOvAHBWDQas8b6CdQ==
X-Received: by 2002:a17:906:fd83:b0:a9a:49a8:f1fa with SMTP id
 a640c23a62f3a-aa1f80589e0mr689416166b.23.1731604413112; 
 Thu, 14 Nov 2024 09:13:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6dc2:e776:8a06:3912?
 ([2a01:e0a:3cb:7bb0:6dc2:e776:8a06:3912])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df50ab9sm83705666b.51.2024.11.14.09.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:13:32 -0800 (PST)
Message-ID: <8c43d506-bb1b-447d-97ac-8fe789a071fc@linaro.org>
Date: Thu, 14 Nov 2024 18:13:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] dhcp fails to download file with CONFIG_NET_LWIP=y
To: Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: E Shattow <lucent@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <7ae3c2a0-2a9f-413c-8fff-bac18421c335@canonical.com>
 <CANV2PTNScpCfP3vuwHFchR7ZgP5oDGUe1-9Lg5u2v8-cU48Pig@mail.gmail.com>
 <654f78ed-18db-4f77-a732-69ef32c8c7c4@canonical.com>
 <20241113235918.GA3600562@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241113235918.GA3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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



On 11/14/24 00:59, Tom Rini wrote:
> On Sat, Nov 09, 2024 at 04:22:26PM +0100, Heinrich Schuchardt wrote:
>> On 11/9/24 16:12, E Shattow wrote:
>>> On Sat, Nov 9, 2024 at 6:20 AM Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> Hello Jerome,
>>>>
>>>> Using the old network stack U-Boot's dhcp command can be used to
>>>> download via TFTP. This fails with the lwIP stack:
>>>>
>>>> StarFive # dhcp $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
>>>> ethernet@16030000 Waiting for PHY auto negotiation to complete.... done
>>>> DHCP client bound to address 192.168.1.47 (233 ms)
>>>> StarFive # tftpboot $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
>>>> Using ethernet@16030000 device
>>>> TFTP from server 192.168.1.103; our IP address is 192.168.1.47
>>>> Filename '/vf2/grubriscv64.efi'.
>>>> Load address: 0x40200000
>>>> Loading: #################################################################
>>>>            #################################################################
>>>>            #################################################################
>>>>            #################################################################
>>>>            #########
>>>>            4.1 MiB/s
>>>>
>>>> We should try to provide the old functionality to make the move to lwIP
>>>> seamless.
>>>>
>>>> In the CI QEMU instances we already have
>>>>
>>>> test/py/tests/test_net.py
>>>>
>>>> to test tftpboot. We should add an equivalent dhcp test.
>>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>
>>> It is useful to have dhcp assignment without the side-effect of trying
>>> to load files. Your script can be updated to:
>>
>> The dhcp command was explicitly built to support booting by retrieving a
>> filename from the DHCP server and then loading it from a TFTP server. The
>> recovery of many routers and IoT devices depends on this feature.
>>
>> There is an environment variable autostart that controls if the file is only
>> loaded or booted.
>>
>> If we want to change the behavior, it should be via a well reviewed patch
>> and not as a side-effect.
> 
> Yes, lwIP needs to match the long standing behavior here.

This is an oversight on my part, sorry. I just sent a fix [1].

[1] https://lists.denx.de/pipermail/u-boot/2024-November/571786.html

Thanks,
-- 
Jerome
