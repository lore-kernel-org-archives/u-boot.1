Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FAAC83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 16:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F378312A;
	Mon, 28 Jul 2025 18:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="StwrfRGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA0482EB8; Mon, 28 Jul 2025 18:34:11 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E505082D06
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 18:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2403c13cac3so969885ad.0
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753720447; x=1754325247; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lt1yB1TqjL1lxtLKh1DvguSg+5WMzgLjDt6xz5O/fHo=;
 b=StwrfRGnJTQKrcdi5br1mwWhtbFob61/Us/rcCQ7cdD/MjdhMjaMU+Uoc+oh43B0Al
 eNh72pm7YtCQNMo0n0CNoGW43cuo1pJTFAld/+HSDwU1P7XZb8buyffev7xaZFqNxpEk
 GMafFBYtTbNm/gAGRZqh+1+fR3wvE7Xs0vm35JMdzsrK+RbVURWkgnFu3AYFmbKpznTs
 LNPZKcPDnuFAoHZOzVFk3mh7OwtlBwZN9YGgRM7nTfYF7DRZ/IV29iBllwJ27O0WYiLs
 3WwvSG4EZo2Yf9rhCF4rLnG0Ee1KtM+o8JXztiLW9snbHyQEKCtslteJLfr75RY3zh59
 Cptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753720447; x=1754325247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lt1yB1TqjL1lxtLKh1DvguSg+5WMzgLjDt6xz5O/fHo=;
 b=k80Zp7USGeLHFMcJwk84rVThW0ZMtBNC9jw9MgJeBj9aS3ET1xKYqpu/kVK0zLOVnq
 5/a6Ml9V5O8Hl1wW/uDVgsop9Qo1BqPxmp9ic9sS1vlp7rfPGaUtwq2GetQT67nKuYrI
 CDHZf2eMhlZ53w3RlLbi/9WMOcIgosSf4uVo0X0F0uJEwvByl/sBZL17eSRgXC5zDxaF
 r21mMW2/Z88Svs7BSz9AbUEPsL8HA3rMILz9moy6RNOD+xcdWNfWpSSz8BNntsEyFTiD
 U1ecUBLtmApCV6VAQgugCdBAsFoPEu6/Kxr6KcpbafYSvnn/V/K3sQuPh0XmseZcQ1Om
 cdJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFePNwU+JhNZL0/AKdGvDmcUcchuA+zlagn0RuV1/5kROHiRnjYlqEQa3v7A81B/WSMKeavHM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjx7AG1jg8KGTRwXR77a/pWJrOcFdkBMUA70nRe9VxToB0Xgkq
 YMx/7+ibI1sLYO5vExmn5Bk1bzlKxrFUXPj/RemhzifIXJUvmNdRLzg3
X-Gm-Gg: ASbGncvgQh1Az/aEqihqDySeM3Dms1sT7YOgfkuTyj/zoPVhI9WgQHjNgO6qL8iBC/K
 3YuisxCLZNaW32UB4stqtjBhNicf3PprNn3/oLAJB+vT7iEFEzIYA9T7j2Xmkkomapr30MGhevN
 VKdzKpMmIvdqWY00lbu49e8zoVVylZqStO87+lfwulaMAuD5hmk1IX0BuHVPGJLhbEB4Mh/e61V
 ZF/YqLQvkvyi6uKgu2SNSnLsZftvKX2qfZepokknpIgFfdQe+7qxm2eEeWq1qg6EyGul1ec3wwv
 c0L00MS3gCZUFgrHv5xgfyDrsBIYvlJj5TwKQqxtLkBSpz6lwAMbKv/oWFwtAwMNIUO9egfBW5m
 gyqxS5eprXJ/0RaP0CzjJJP7IFcRgtVxZGXbnHB6Oyw+q9pMSrCbjWAWvWM8nLCdkTUWdTJxPDI
 3YjvZerAA=
X-Google-Smtp-Source: AGHT+IFuJeL9P+jNgsdw0A72ZVx2NdYZpufsaC+qcRMnJJJEiz5gdUocCPvEivag0UJiWPKd0PdYxg==
X-Received: by 2002:a17:903:304a:b0:235:f091:11e5 with SMTP id
 d9443c01a7336-24063d03a12mr2100715ad.10.1753720447292; 
 Mon, 28 Jul 2025 09:34:07 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2403f335075sm16284155ad.185.2025.07.28.09.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 09:34:06 -0700 (PDT)
Message-ID: <f4be2285-eb0a-49c1-8595-a73a231465e8@gmail.com>
Date: Tue, 29 Jul 2025 00:34:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v2, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org
References: <20250727141609.15425-1-lucienzx159@gmail.com>
 <2f6dcd69-1e18-4a9a-a07e-9b59f79212da@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <2f6dcd69-1e18-4a9a-a07e-9b59f79212da@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Jul 2025 18:53:53 +0200
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


Marek Vasut 於 2025/7/27 下午 10:46 寫道:
> On 7/27/25 4:16 PM, Lucien.Jheng wrote:
>> This commit introduces a new API, 
>> request_firmware_into_buf_via_script(),
>> to the fs_loader framework.
>> This function allows firmware to be loaded into memory
>> using a user-defined U-Boot script,
>> providing greater flexibility for firmware loading scenarios that 
>> cannot be handled
>> by static file paths or device/partition selection alone.
>
> Please run some 'fmt -w 72' on the paragraph above.
Got it. Will modify for the next version.
> [...]
>
>> I've validated this API on the Banana Pi R3 Mini. Here are my test 
>> commands and logs:
>> 1.  `env set en8811h_load_firmware 'env set fw_addr 0x46000000 && env 
>> set fw_size 0x24000 && load mmc 0:3 0x46000000 /boot/EthMD32.dm.bin 
>> && load mmc 0:3 0x46004000 /boot/EthMD32.DSP.bin
>
> The 'load' command sets $filesize variable AFTER the load completed. 
> The $filesize variable contains the actual size of the loaded data. 
> You will likely need to expand the script a bit:
>
> env set fw_addr 0x46000000 && env set fw_size 0x24000 && \
> mw.b ${fw_addr} 0 ${fw_size} && # Make sure the memory backing the
>                                 # firmware is initialized to some valid
>                                 # content.
> load mmc 0:3 0x46000000 /boot/EthMD32.dm.bin && \
> if test ${filesize} -lt 0x4000 ; then # Validate that the size of loaded
>                                       # data is correct
>   load mmc 0:3 0x46004000 /boot/EthMD32.DSP.bin
>   # Validate loaded data size here again
> else
>   env set fw_size 0                   # Indicate failure
>   exit 1
> fi
OK. I will expand the script you mention.
>
> [...]
>
> Looks pretty good otherwise I think , thanks !
Thank you for your great advice.
