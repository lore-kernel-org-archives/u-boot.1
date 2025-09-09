Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35044CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 11:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFB5483106;
	Tue,  9 Sep 2025 13:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yzM8xZl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2688F8313B; Tue,  9 Sep 2025 13:16:12 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0222F830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 13:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3e34dbc38easo2338988f8f.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757416568; x=1758021368; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RII/C/evaQNkvtmegimO82rN+7nStGrRen3/b4S2a+w=;
 b=yzM8xZl4OG119VUMXqXk6SyqwgWZQiJJpDX5y187idEd7G1ziMho5IsR1HSZqm4N6o
 eNlzEJ8rCTV4zGjWNtIL96YskyA/cdEgrUME5vEeuyezsutW7BfqRojiG/fcMQiOnCwv
 TKE+Uq3Gr5Nd9RgaCgWKX7rNb6cQVjA7VDEqbqbDu+cUX/Rr2fX5uDpkXXS13Fz+rWrW
 6qyknETex6Ol8aMj+zvG1dBoJyepYKSmUKqAKHdVnSayPVi+HAAbJvdRybM2Av3/AD6B
 FyrlrHAdOAJQEVCf880qfLvmbcMsAW3W304m5MH8Fwg3TNY6loMB8Bxpa+US8+vaBW/Z
 G5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757416568; x=1758021368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RII/C/evaQNkvtmegimO82rN+7nStGrRen3/b4S2a+w=;
 b=r7/ukCwnPeaZEFacxgpSoX5nT6bSObCJVhviQO4eJToXDl7LtzcW9v+IJn/iEYTdn9
 IN4E1UZ8YTJWRTO/LAxTduvwzd058sYvm14ku1pjStuDe3R/WRxTr+x6zjYJdvL7uZ7h
 M9POZEwZw/z56C2W+TuF/VoztmKS4iiFy9PNUxFwcBrBHPF0y94mJFIngij/qR6fENjD
 k+qOjPPuBldpJTarToTk9e0rWHnSH3o2D3gsO8OlTqWsnspOhLbw9ERBhAafL1k867Lf
 FlrMuYZuOY4lXczxHxFCVDwIYdx8fyfhqF9sHvlFPOOqjjkhAdLL5iosDNM3syYJeyLa
 vMww==
X-Gm-Message-State: AOJu0YxRakk1B9iTssSBCE6ojxfL3Vz40nzzAU27urjuRILs99n+q0P/
 k8JXLAP89X9yLEPrMp/8yweoGYkbwJ0nTXqE3Y1V5phfPqsEl/c9ivGCOEN4Vr5OgQU=
X-Gm-Gg: ASbGncuOi19VDCwIlGX6y29t+pJCqt1UXBLTsXLnrEFVxBTnTJygT5mCS0DgnpL6rlD
 DZ/XepeBNr2Qrs3ll+6rJrlu/bx/nuL2M6B0LnHXMBAMAJlhiMWZX0PX2xCr3IvAtDeenA+ki/Z
 1ugNo1wXVkimwnJpplYRNmRCbkT3ISxmjBR0gRXLlxiJsaKJR1yk1qrsbXkkcaWWHcunVJGrH5y
 ZfdlRfY8IW523c7QPf0ZjigSah9qovLs+N1WR3Oo+IIumYZ9KIiqcJ69a710qc6M861JQL45QRh
 w1SoFZ0NiPNS6uQ1JWmzZpLjH8jZqodxj0FKH9hfaSvhs6XrqOAxzlJ+1KUtJhU4tQKiQN/U3D9
 CLWxor3Gi2/hDfzTXxYoYdGDTUkKtNo4DNTg/T/bMCPxCc8+VVUM2FjYt
X-Google-Smtp-Source: AGHT+IEglz54tUTxA/x3hJpLtoZd08pR42o7QjDZ89F8b7hiaSAsfrm5+VwyeIgXkSJwtFYq2a4ENg==
X-Received: by 2002:a05:6000:2312:b0:3dc:2f0e:5e2d with SMTP id
 ffacd0b85a97d-3e62a305f39mr8111805f8f.0.1757416568155; 
 Tue, 09 Sep 2025 04:16:08 -0700 (PDT)
Received: from [192.168.7.92] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7522387acsm2226284f8f.40.2025.09.09.04.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 04:16:07 -0700 (PDT)
Message-ID: <0f65b701-c8d6-4f7d-8124-65d5b5477f35@linaro.org>
Date: Tue, 9 Sep 2025 13:16:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] doc: phytec: imx8m: Style and firmware update
To: Yannic Moog <Y.Moog@phytec.de>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Teresa Remmet <T.Remmet@phytec.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 Benjamin Hahn <B.Hahn@phytec.de>, Yashwanth Varakala <Y.Varakala@phytec.de>,
 Jan Remmet <J.Remmet@phytec.de>
References: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
 <20250908-imx8m-optee-enable-v3-3-14bfe249b3c6@phytec.de>
 <c2da0d18-9ce0-4c0f-8495-977ad7d8ca5b@linaro.org>
 <bd26f72ce7e0676c81d829aaef335aa4e60f582a.camel@phytec.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <bd26f72ce7e0676c81d829aaef335aa4e60f582a.camel@phytec.de>
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



On 9/9/25 13:12, Yannic Moog wrote:
> Hi Jerome,
> 
> Am Dienstag, dem 09.09.2025 um 11:58 +0200 schrieb Jerome Forissier:
>> Hi Yannic,
>>
>> On 9/8/25 08:34, Yannic Moog wrote:
>>> Use single make command for compiling blobs and U-Boot.
>>> Update the imx firmware version.
>>>
>>> Signed-off-by: Yannic Moog <y.moog@phytec.de>
>>> ---
>>>  doc/board/phytec/imx8mm-phygate-tauri-l.rst | 27 ++++++++++++++--------
>>>  doc/board/phytec/phycore-imx8mm.rst         | 28 ++++++++++++++--------
>>>  doc/board/phytec/phycore-imx8mp.rst         | 36 +++++++++++++++++---------
>>> ---
>>>  3 files changed, 56 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
>>> b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
>>> index
>>> 7efc9392361b4a867ce2bc18db11aacf31208800..4dd82cd9785fa585ed216664a25f593d4e
>>> 723dbb 100644
>>> --- a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
>>> +++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
>>> @@ -21,9 +21,13 @@ Build the ARM Trusted firmware binary
>>>  
>>>     $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
>>>     $ cd trusted-firmware-a
>>> -   $ export CROSS_COMPILE=aarch64-linux-gnu-
>>> -   $ export IMX_BOOT_UART_BASE=0x30880000
>>> -   $ make PLAT=imx8mm BL32_BASE=0xbe000000 SPD=opteed bl31
>>> +   $ make -j $(nproc) \
>>> +          CROSS_COMPILE=aarch64-linux-gnu- \
>>> +          PLAT=imx8mm \
>>> +          IMX_BOOT_UART_BASE=0x30880000 \
>>> +          BL32_BASE=0xbe000000 \
>>> +          SPD=opteed \
>>> +          bl31
>>>  
>>>  Build the OP-TEE binary
>>>  -----------------------
>>> @@ -32,8 +36,9 @@ Build the OP-TEE binary
>>>  
>>>     $ git clone https://github.com/OP-TEE/optee_os.git
>>>     $ cd optee_os
>>> -   $ make CFG_TEE_BENCHMARK=n \
>>> +   $ make -j $(nproc) \
>>>            CROSS_COMPILE=aarch64-linux-gnu- \
>>> +          CFG_TEE_BENCHMARK=n \
>>
>> This CFG has been removed from optee_os since 4.2.0 and has never been enabled
>> by default, so I would think there is no need to set it to n here.
> 
> Thanks for the info, will remove it.
> Should we remove it from the optee doc as well then?
> https://optee.readthedocs.io/en/latest/building/gits/optee_os.html#build-using-gnu-make

Yes, good catch. I will submit a PR to the docs project [1]

[1] https://github.com/OP-TEE/optee_docs

Thanks,
-- 
Jerome

> 
> Yannic
> 
> 
>>
>> Thanks,
