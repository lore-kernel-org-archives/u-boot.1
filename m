Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F12CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 23:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46B3383B03;
	Thu,  6 Nov 2025 00:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fIr+8PEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740C183B0A; Thu,  6 Nov 2025 00:07:37 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 734A183AD1
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 00:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6A82C40005
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 23:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762384054;
 bh=tdhtUPpf5KXtqtN0W/KJNXYjrPaSdCome9Vzjq5tvx4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=fIr+8PEwF0awRI4IUnLeCsNLo5kVNxmLN7Qb0HnTEnFQ2D+t5IA84aURixu/J1oPW
 2vCuSMraPJ00g7N423WvXRSGUxhdp3yX0nkkJK9fjpPFVqLLaeJXjRPlEKKZofLSyC
 UMRBwUITj1TqSg0Gv0Jzx41TdRAda8OkSyxotlww6CMyec8StOdJykadauTqBxWdQO
 bVyxkiuIhjSGW8X8XwURO6/dVR1R48zSp+i9AuI/v1Kqgfsds6zrQBj99FBiwF09nf
 6QkaOwG72fcOYABcmC2ZojxzWeWtHv5L7clOjkVRFie09ir82oGg2M/bDnl5NAWfBM
 HC4i1fF5BrNhLk8m7TOd4Pcr2Gy/hBhasnXtb0veHmIVQt9iWy5U+DBSlR7qlfsaUs
 Td13QaCeYSXMU4eDY7pvLWo+q6wZurF1RctftqNwOz5P5fE6qzjEnd4ebVC6EnLI4u
 Du2J2XSdYWDk/rPRLL6n8ybcg+pFXB78dFJhMEtY3V0FjnMQ3rIhTzr4S0YVuXCm98
 f5PdY75qddXDVUI3OrhvxFsc6V6ochZu8HK/10TvBvK9LTCDCA/OW5DdTqGjNSNQ+X
 g+FZ5cr/7XbReo9eeUiwgRwmF0k5E1zdeydBJadnRRVjIjzvcaUOsi/+YlFRe5hbKD
 e3B84Tpp+iG5NTjLS0ZBXtWA=
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-594285c6850so158800e87.2
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 15:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762384052; x=1762988852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tdhtUPpf5KXtqtN0W/KJNXYjrPaSdCome9Vzjq5tvx4=;
 b=WQ0BbXMb4W8nd9nltAEsUYa17YRLmoyqrinMUd+eenDPO/TbE0K11WqTGpj86jBHJd
 AkcadeB7OMs8LFfT1WoIdYpjccfYSpwVeO6arLtjBuymaaeOCOJIzodjK6XLPkLv+mUD
 2k5xsyUuk8zom/omz8JS7H5BlgFQo1ajeKSnvH0IsGEBRg1w4hgL+zsi9pKgYdWkVe+b
 8smNnqrKnDwubY6mLbOzGPd2phd8S/ZDtMu73NIsUEdxgAd8Ytl8gQ14ibyCfvpDOoNP
 h/+556lQSGwBv3o0Xx8AiYe2vnBUhwpFWcxBeWqjNg7UF6SY8Pke7Jg0zsRJ8zlIkhAK
 wDjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcQkKXaqE7+nPz3ud318Tz8EpgEBDwQxyLxxMe38JpIpLHrusOSDq3zApEiZ56KEu0BONdhuE=@lists.denx.de
X-Gm-Message-State: AOJu0YxtXld5g4/THFcZ7papWX/6omM1B12WNbGRZQIKp8R23Ezno7ue
 Qy8CvlfMK5u/fmnauHUu7ngvYbbPKmoJboCa+I7EhO2sEUo7ujVbcvriInO8fR8GOT7ZN9R7z2n
 LUHr3gQbKdfW63VRVHvVV0pxz8YoQHa0CQEolMegWgH/ev9XyTFVbIWMVcKAsuCJBTDCDXyg=
X-Gm-Gg: ASbGnctlIhVR2tlPyqZffZlwnO8aQIuvEjFwBIFFZK5UQBb0/nsmsctzBNzAKd/f284
 qVX1wounyv7kPtSwjtNjt2lpacV8ulESKceutcnJNj0SA6ygmcm/5YhjZtUjTFjCx9VeUv/50Mp
 3u2NCPd9NFUY9V9oXvQbiPkSlI5BzUkJHV92zwZ7Gd3dNvkFhaDMNx8HFb9+0mSazbxUM9AxjrZ
 7TwM17fL1swRhYUC43Ya7AtSJQBoaC5oduKhWU3FQImrPfD1YETksO5O89Jmizqu3Vx7pOPjF7O
 kq3tHqPMRhNJxFu/eQNePt+s9bOllY0lJh0jA9hjJt5y1H6TrKonCJ/OE39fY2I5PyiXhDBYIJL
 q73PTUTgxRCuA9cQ2p6aQmJYeVvdJ0ltfYxQpO7zGsYHk
X-Received: by 2002:a05:6512:3d04:b0:592:f8c0:c8de with SMTP id
 2adb3069b0e04-5943d74d75dmr1704999e87.13.1762384051938; 
 Wed, 05 Nov 2025 15:07:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO5BEsSvpTCKaqUUV91aOoxIt74dwWywnctwigypf9efMKIH2fTJpOcK2KTOJlgZEzi7LzVA==
X-Received: by 2002:a05:6512:3d04:b0:592:f8c0:c8de with SMTP id
 2adb3069b0e04-5943d74d75dmr1704990e87.13.1762384051501; 
 Wed, 05 Nov 2025 15:07:31 -0800 (PST)
Received: from [172.26.194.12] ([93.94.208.154])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5944a013bd8sm198842e87.1.2025.11.05.15.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 15:07:29 -0800 (PST)
Message-ID: <219a1f79-8ae3-4724-bf37-a7c5902aa9fc@canonical.com>
Date: Thu, 6 Nov 2025 00:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs: CONFIG_CONSOLE_RECORD=y on
 qemu-riscv64_smode_acpi
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
References: <20251031195931.622513-1-heinrich.schuchardt@canonical.com>
 <20251031195931.622513-4-heinrich.schuchardt@canonical.com>
 <CAEUhbmVCkjyPOyYtbABqEQZYeGV5QLwMUkO9xP4obFne7PryQQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAEUhbmVCkjyPOyYtbABqEQZYeGV5QLwMUkO9xP4obFne7PryQQ@mail.gmail.com>
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

On 11/3/25 12:07, Bin Meng wrote:
> On Sat, Nov 1, 2025 at 3:59 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> For testing ACPI on QEMU we need a defconfig that supports acpi command
>> test.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   configs/qemu-riscv64_smode_acpi_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

For some tests to pass we need to increase CONFIG_CONSOLE_RECORD_OUT_SIZE.

The sandbox uses CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000.

Best regards

Heinrich
