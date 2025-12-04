Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC39D1F9CB
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25DFF83FA5;
	Thu,  4 Dec 2025 13:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dz4/exoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA76C8400F; Thu,  4 Dec 2025 13:01:32 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F8B83A94
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 13:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42e33956e76so457718f8f.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 04:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764849690; x=1765454490; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U5Kgjp8IIOFl0WY1OD8A9Jh91/hZ2aozGCoLPlZMnfc=;
 b=Dz4/exoa3/NHzCLLqAbpNTp50LhBTyXBB8Skto245qoxanrqSJ9J6lMZRblvEMcBW3
 9c1bnKhyPwEnrdIbiPLjQDN+xwFmgkaWpZvZhopCYY15Z7YgkXlzT4cxU/G0OEjZJZ1G
 j7g690l7CkVzbSImVeu3UxHRZkuBtb5nHBOh/h7k5xxY2NU3bdxw/AycWiu/dHgTB18M
 3dqZRyuL44qI8wLjeNqPlFYDv2/1MCgZO030bHrYU1l7xJveeHqw8h32Mx7m+y9c617l
 YEMxpTPUMxSkbUe78mHw52KD+WzFn9HKbZnLBbfQn0fAtI/DQZpH5hVqFGm7hNXrrkd8
 3wvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764849690; x=1765454490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5Kgjp8IIOFl0WY1OD8A9Jh91/hZ2aozGCoLPlZMnfc=;
 b=TcCStjtWnqOdXx8HdKC9DY2yOL2NaKtUO4jEiFwi5ZT1NB/oSmR0SuTOpJum15fwaK
 1aHkD/pyL04bN3/o2ql+vm2f/NDy+q5wrZe8ZgJL7X0eaZsTlBXgMljPn4nHG3qhnKhQ
 m+zvzY081UwjmQtYenu3xM9VTzbZUJj2mIUVuzOWVe227BEQdSABlOvUt1m1XJk7WgC0
 N6phrCyHm/eDYyyhWDAZRTX3Yq69+2bb9kkwl2bJEaIZ5HnW4zue2y2W8H1g3BDck66D
 nhDfE7woIoJ/9XgC4Ben7+Vzb+SFRrnm69XatihPwJhGa3zEUk67Y+jK63hpBee/L+ga
 QM7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqMOvvy1Lr0Jrw+9RqgRt0O8IqR2uqOMhhODj/yA+GGvGBx7hOeX80iCeypX5cEJLq6QTgqxQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzlLAGYUPR/RxBOzqSv26qhQrF7a94DcIDP8rr0i8s6qIRUL2Ld
 YGHCFAnG01dn9me0DVR4b+Dqm8Ds+I/A9fP1qv+fmF3tZ807Gfq23F6j
X-Gm-Gg: ASbGnctB2XHpGyo6aM9ULZdCjkTpfD4rK1DxYEx/DaBkX0vB0OIiPba+3fr+prYMRMw
 gZUGW2SA2NWXjwvZAlQ5lFBi8QlzGJnRW4ZT2jKCNwEAcDNJyZ+G+TQrPpWPgdfNyo2d4ORaoaa
 yiG8FcEue1cNVkjSJrRA7hguplGIuGtxHOPW/PEhtrs2Ii9K8mBRwj0ANXQSZOd1guxGDQZW2vB
 e9yY/kLUlyEVVAFNQArt7SKv5shl2Ilu9ITEMDAwm0szO0tA9MQVdWabfJn6lj4v9nm+7axERan
 /zpU3PM6bnbJqYVv23avMkexjQVp2VxEK0kc8qlF2n4dK23ODQXPSdy/3X2YrL+dbEcThPOwAVe
 xt4u1Ig7hOnrZlF/aFxxBpvPhMkTOcwhPJzs+uptw3T/70lyAlcMhAlVnRGwQwh26FPwKqxB+FU
 hI3HDceLaADuxs33maciJFyoVerYt3WHIHaegNyBvczFWnoZ2EhGe29EI=
X-Google-Smtp-Source: AGHT+IGK2kh5nqRBkAik9jOhWToGQHDsrMnFDN2+sDeOvN2TLRW7uWodobrxV63RXXO63dELIibAcg==
X-Received: by 2002:a05:6000:22c4:b0:42b:2de5:251e with SMTP id
 ffacd0b85a97d-42f73187118mr6107478f8f.26.1764849689714; 
 Thu, 04 Dec 2025 04:01:29 -0800 (PST)
Received: from [10.193.174.228] (93-44-42-122.ip95.fastwebnet.it.
 [93.44.42.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331a4fsm2963524f8f.33.2025.12.04.04.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 04:01:29 -0800 (PST)
Message-ID: <bc75cd00-2372-4dac-821e-74bef5790e34@gmail.com>
Date: Thu, 4 Dec 2025 13:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
To: Ye Li <ye.li@oss.nxp.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, uboot-imx@nxp.com, trini@konsulko.com,
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de,
 u-boot@schwermer.no, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Jacky Bai <ping.bai@nxp.com>
References: <20251027115638.1186252-1-festevam@gmail.com>
 <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
 <3ab1b3a6-b9ab-4571-a7c8-8288d4a8d290@gmail.com>
 <CAOMZO5BcMu_94qn4vhDgxmdWVx0N-mCD9wYTvAPbXaK45EUFBA@mail.gmail.com>
 <b6b82482-ec7d-4703-ad93-ccdd7a651b57@oss.nxp.com>
 <e9c56d66-b2b9-456c-856e-2ef01a009e16@gmail.com>
 <CAOf5uwktScqh0LrWTaz-MRA-tDoAVb9Mo8UhxDKz0dauO21QQg@mail.gmail.com>
 <92d98692-5fd7-456f-b831-0986e6d499a9@oss.nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <92d98692-5fd7-456f-b831-0986e6d499a9@oss.nxp.com>
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



On 19/11/2025 08:49, Ye Li wrote:
> Hi Michael, Emanuele,
> 
> On 11/12/2025 6:07 PM, Michael Nazzareno Trimarchi wrote:
>> Hi all
>>
>> On Wed, Nov 12, 2025 at 10:57 AM Emanuele Ghidoli
>> <ghidoliemanuele@gmail.com> wrote:
>>>
>>>
>>>
>>> On 12/11/2025 09:16, Ye Li wrote:
>>>>
>>>>
>>>> On 11/11/2025 9:47 PM, Fabio Estevam wrote:
>>>>> Hi Emanuele,
>>>>>
>>>>> On Thu, Nov 6, 2025 at 7:22 AM Emanuele Ghidoli
>>>>> <ghidoliemanuele@gmail.com> wrote:
>>>>>
>>>>>> Hi Fabio, Ye,
>>>>>>
>>>>>> At Toradex we have been struggling since quite some time (back to 2018)
>>>>>> with
>>>>>
>>>>> Does this problem only affect early i.MX6ULL silicon samples?
>>>> Hi Emanuele,
>>>>
>>>>      I have same question as Fabio. Are these samples are early? Do you know
>>>> the time of receiving these sample? And could you show the part number
>>>> printed
>>>> on the chip.
>>> It could take a little to answer to the first two question. I can say that the
>>> SoM I'm using to validate the patch was assembled in September 2021. Let me
>>> know if this information are needed giving that I can report the marking on
>>> the chip:
>>> MCIMX6Y2CVM08AB CTDQ2107 1N70S CHINA QGDQCTA
>>>
>>>
>>>>
>>>>>
>>>>>> the temperature readings and the thermal shutdown behavior on i.MX6ULL. The
>>>>>> issue we observed is that the thermal shutdown seems to trigger too early.
>>>>>>
>>>>>> I have investigated the history around this topic and verified some
>>>>>> internal
>>>>>> notes in our bug tracker. With this revert applied, and on the devices
>>>>>> we have
>>>>>> (all trimmed with value 0), the reported temperature increases by about
>>>>>> 10 °C
>>>>>> compared to before the revert. The absolute accuracy of the readout is
>>>>>> questionable: for example, on a device kept at around 20 °C, the
>>>>>> temperature
>>>>>> readout was ~19 °C before the revert, and ~31 °C after the revert.
>>>>>>
>>>>>> Consider that for devices with fuse value of 6, there is a -10 degrees
>>>>>> offset
>>>>>> after this revert (so, the other way around).
>>>>>>
>>>>>> I understand that for Sven this revert improves stability during large XZ
>>>>>> decompression in userspace for few devices, but for us it means that the
>>>>>> thermal shutdown happens roughly 10 °C earlier, which is a serious issue in
>>>>>> our case.
>>>>>>
>>>>>> I would kindly ask NXP to double-check how these devices were trimmed.
>>>>>> My gut
>>>>>> feeling is that there might be an inconsistency, either the trimming
>>>>>> scheme is
>>>>>> not backward-compatible (e.g. old and new devices behave differently,
>>>>>> and the
>>>>>> code should cope, I don't know how, with this), or this patch must be
>>>>>> reverted
>>>>>> (because introduces a regression).
>>>>>
>>>>> Peng/Ye Li,
>>>>>
>>>>> How does NXP suggest we handle this? Were the early i.MX6ULL parts
>>>>> incorrectly fused?
>>>> I need to discuss it internally, will feedback you later.
>>>>
>>>>>
>>>>> Can the fuse be read and dynamically adjusted?
>>>>>
>>>> The fuse is locked by MEM_TRIM_LOCK. Emanuele, can you help to read it by
>>>> "fuse read 0 0 1".
>>> Colibri iMX6ULL # fuse read 0 0 1
>>> Reading bank 0:
>>>
>>> Word 0x00000000: 00320003
>>> Colibri iMX6ULL # fuse read 1 0 1
>>> Reading bank 1:
>>>
>>> Word 0x00000000: 00000080
>>>
>>
>> As is clear this problem was the same we had some months ago, so we
>> are on the same page
>> with Emanuele
>>
>> Michael
>>
> 
> 
> Can you help to measure the VDD_ARM_CAP and VDD_SOC_CAP on your devices with
> high temperature read issue, when REFTOP_VBGADJ is set to 3'b000 and 3'b110
> respectively. Provide the measured voltage and target voltage.
> And please read the Unique ID fuse of this device by "fuse read 0 1 2".
Running u-boot, VDD_ARM_CAP and VDD_SOC_CAP respectively:
- With REFTOP_VBGADJ set to b000: 1.08 V and 1.11 V
- With REFTOP_VBGADJ set to b110: 1.06 V and 1.08 V

Best regards,
Emanuele>
> 
> Best regards,
> Ye Li
> 
>>> Kind regards,
>>> Emanuele
>>>
>>>>
>>>> Best regards,
>>>> Ye Li
>>>>> Please advise, thanks.
>>>>
>>>
>>
>>
> 

