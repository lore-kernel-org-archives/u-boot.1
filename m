Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6545ACCF9F8
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 10:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9377783B5F;
	Thu,  6 Nov 2025 11:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ApbuKe58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 350B183B63; Thu,  6 Nov 2025 11:22:16 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D7DC83B49
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 11:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso3214995e9.1
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 02:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762424534; x=1763029334; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L/gX6j1dheFaJUmWAdhRVo4b9KdRDoMhjGsvMyt3X0I=;
 b=ApbuKe58ba1bkFG/kc8Ph+uDdZzYUTd5UJt853Mjk2SPBL2aT2IdvcJtNB5wf1oOJP
 6jUbU+sHVePsiz75H/TQMkQtsX6Ra0cHbrQfoA9rbArd+dxfLbZp080LqWgAky3tBucW
 v0C6uVwVxJbfXSNZvFALylG8bpp0tsC0fPhtBKfUJHe9szSsOdqjrLMlmsrZnqlp33eo
 vnRI3n9+Kuxfc7urs1VNyLHqijc8dRFWNVM+mk4BdA03knfFTL46CstHFdAt+UbusHq/
 /1S/gGuHEPvqKt4SJewX4INkDdrmwwCevfsMdNJD+B0sdPKoTUiYwTRme72xPI2UYfu8
 5lOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762424534; x=1763029334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/gX6j1dheFaJUmWAdhRVo4b9KdRDoMhjGsvMyt3X0I=;
 b=sHvYsAcOqrrd/TJrJQsKWgCetgOA+2dlQCrsJEEhyB3xbpC4kLbI8c18ZUg93C6yQk
 gqV2TWdYECZDg1YfYE3gKkyMrc9I5hZPiK5rM/hUgPAh1jTj8xT8T+/NvaeGDwLwQ7CT
 aDy1i8xJzeImXG9Ph3yKpR+uyP2YfYISw0Zdf/LlCDtXSRQ5FNIQdbqHO4EeQTWrFB/4
 I+TljKkaxUjmMOqQt53vyly2zi7QBqOImm56VyQmqv2VHCS0EcmViednqauhUmySp2JP
 oH4JpsLNM5Jkt2vW0vCGVm6P22EqUj46rjd2coH8A3ls5c5zpS1A9hnbJRXk+uXZER1W
 nZgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+/7QAfhNTqh8mc56VApiw4nQZGtTjGYFi5eMb1b9Gg+GBkbyLtOpvY52z5DBUiAxNeLP6Sa8=@lists.denx.de
X-Gm-Message-State: AOJu0YxOE8I2Dnt2cb1wKQSHJYC4FUlenxfFwXO1awq1/Id84Df4ROmR
 LwM7SW3J39Sn0sdwFNWW5uZ6FikQ4ZXeRpTSbmFf3bvG/e5ibqnz99pp
X-Gm-Gg: ASbGncsLAgNtb/lF65v99v4m5csWSnriM2W7szB7rNfECHShuBj24lw68EYI65JyFK2
 HP4cIrfmP1+ALrouCzt1+rwS/ZWizXAmf1IkaznwCh2e0zkPxiKGpp/aKvduQfXRyJzLv6+CZB5
 DAG5TPdB7xlSWJH3551oVfhHyR6uoCsnrMElSIg0yh90HSWQ1OZsEFfP1/gL54uiFZcQtN4YWKc
 9OKhTUcD8MaTphskIFR3IBRQjCT1Wc54EVUyVp9QG/1DJbrVNrcM2yNby6a8Hf/LFvYCqbU9zSc
 R255NhElxDqgm2GB8ztrKE+Dx2QVYYvkoBk3Gy5EYrwMGwgjbzv6kfPaO9tR0wjnKoXECYHheSb
 j4Ua6CZ2LdRTTCHKQcK6rsUBG0G+OdiP8y/KXdwEhsDfF6CY5n+tyqQM+fLP1+WQqfbrE7LHBYp
 mDwj92iqRpPDJnhA6R6cc6xubQJQWOK4Od4OgqLZBM4zqo1jT5FA==
X-Google-Smtp-Source: AGHT+IF3CGyYmEsnLSX2W45bBbPsSX62kelGXThf0YdeCfmJYDqZ765CRviMVK8iS3zbqNSREMh8Dg==
X-Received: by 2002:a05:600c:a12:b0:477:e09:f0f with SMTP id
 5b1f17b1804b1-4775cdad66emr49648025e9.8.1762424533401; 
 Thu, 06 Nov 2025 02:22:13 -0800 (PST)
Received: from ?IPV6:2001:b07:aac:705d:2f96:d64c:2149:c32?
 ([2001:b07:aac:705d:2f96:d64c:2149:c32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775ce329a4sm99426835e9.14.2025.11.06.02.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 02:22:12 -0800 (PST)
Message-ID: <3ab1b3a6-b9ab-4571-a7c8-8288d4a8d290@gmail.com>
Date: Thu, 6 Nov 2025 11:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
To: uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, u-boot@lists.denx.de, u-boot@schwermer.no,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
References: <20251027115638.1186252-1-festevam@gmail.com>
 <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
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



On 31/10/2025 02:48, Fabio Estevam wrote:
> On Mon, Oct 27, 2025 at 8:56 AM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> From: Ye Li <ye.li@nxp.com>
>>
>> The change in commit c1af358cf51a ("imx: mx6ull: fix REFTOP_VBGADJ
>> setting") is not correct. According to latest i.MX6ULL fuse table,
>> the REFTOP_TRIM[2:0] fuse is defined as below. So the previous codes
>> are correct, only need to fix the comments.
>>
>> Set the REFTOP_VBGADJ field in PMU_MISC0 register based on the
>> REFTOP_TRIM fuse:
>> '000" - set REFTOP_VBGADJ[2:0] to 3'b000
>> '001" - set REFTOP_VBGADJ[2:0] to 3'b001
>> '010" - set REFTOP_VBGADJ[2:0] to 3'b010
>> '011" - set REFTOP_VBGADJ[2:0] to 3'b011
>> '100" - set REFTOP_VBGADJ[2:0] to 3'b100
>> '101" - set REFTOP_VBGADJ[2:0] to 3'b101
>> '110" - set REFTOP_VBGADJ[2:0] to 3'b110
>> '111" - set REFTOP_VBGADJ[2:0] to 3'b111
>>
>> Sven Schwermer reported:
>>
>> "These are the symptoms: Very few of the thousands of devices that we
>> manufacture (< 1%) fail to decompress a large XZ archive once in Linux
>> userspace. We have not found any form of memory testing or other load
>> that reproduces this issue. Reverting the offending patch fixes this
>> behavior on the affected devices."
>>
>> Revert the offending commit to fix the regression.
>>
>> Reported-by: Sven Schwermer <u-boot@schwermer.no>
>> Signed-off-by: Ye Li <ye.li@nxp.com>
>> [fabio: Fixed checkpatch warning and added Sven's report]
>> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> 
> Applied, thanks.
Hi Fabio, Ye,

At Toradex we have been struggling since quite some time (back to 2018) with
the temperature readings and the thermal shutdown behavior on i.MX6ULL. The
issue we observed is that the thermal shutdown seems to trigger too early.

I have investigated the history around this topic and verified some internal
notes in our bug tracker. With this revert applied, and on the devices we have
(all trimmed with value 0), the reported temperature increases by about 10 °C
compared to before the revert. The absolute accuracy of the readout is
questionable: for example, on a device kept at around 20 °C, the temperature
readout was ~19 °C before the revert, and ~31 °C after the revert.

Consider that for devices with fuse value of 6, there is a -10 degrees offset
after this revert (so, the other way around).

I understand that for Sven this revert improves stability during large XZ
decompression in userspace for few devices, but for us it means that the
thermal shutdown happens roughly 10 °C earlier, which is a serious issue in
our case.

I would kindly ask NXP to double-check how these devices were trimmed. My gut
feeling is that there might be an inconsistency, either the trimming scheme is
not backward-compatible (e.g. old and new devices behave differently, and the
code should cope, I don't know how, with this), or this patch must be reverted
(because introduces a regression).

Thank you and kind regards,
Emanuele
