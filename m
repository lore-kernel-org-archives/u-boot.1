Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A86ACA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 17:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42296801BE;
	Mon, 18 Aug 2025 19:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ND67mdpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A631801DD; Mon, 18 Aug 2025 17:58:02 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A55E80107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 17:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76e2e613e90so3105448b3a.0
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755532678; x=1756137478; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/MmvxRinNvuuXRtYB0CKMsB9SSGgYe0IybFm8N3OFio=;
 b=ND67mdpisR7kMyCpRaGD6tESegMkqJzo+U2rirMA8Gk1e/FoPBy1SbLIciE44kLj6n
 bnZk50gCADMYMtTplhFLw2tkShDSYCFHZ7W0zacEgUb1jGK8iiWFK0Rs1UEcXiSKgn8l
 fZ9bVLC6ozEvIQkly1J6FPHqmdpIuDh1c3x05pFfjYT3lE2Bpr6WFYDf+vTKnd54pmef
 +dORhtkp3YfuUPDwtiHCW1RijOWKNHqaIXd2zOYmHvJWPmh5K4MXUZ4d60uGeqYjMO0B
 Xuwc/LRf2f7tbp5lUdOak5VwxhjJq3cVtuWea9To57KdvhOrtI0lISjvNTUZzvg8yCv8
 d6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755532678; x=1756137478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/MmvxRinNvuuXRtYB0CKMsB9SSGgYe0IybFm8N3OFio=;
 b=azUcaOkq8SVasWjRgpBCSNUenfCmNrMOScWenDyOTK297zjntWR5pk+bDs0VeALyYg
 9JYSdCSdzEyoUSl2rbtKJvB1nSP2V7piDIuMqXqdzIVe391ddP2FD/oI7nuyC0TYyLWo
 KaGby509/DVXFg0L2ZXInSiNqU/B0lA2wwOYhkd9PqzbGuUF/68rs31S4R2KOpdxouEd
 kf0rE98owfPIMKFtGo4szPPqGzOAluvUdMLPBsM5kzCF10JoUbCaTJnBpWi2Ou2QzKbc
 UtRXYsvIa2QKamyYKwdgn5QsPQmYuWytVUK1pqCwXq6Yj3FRdrh9Ypq5RmgW8js6oFMO
 fv/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHyvoSobrbGjTN6aLl0csc30sZ/CUriwewvupU1o2HnnUq6ij3UgJAdyAfoSFbHue6Iq99YsY=@lists.denx.de
X-Gm-Message-State: AOJu0YzyUMmcxSw4sCpsTs+pNFfeGZnW7oPIo5qb0yX6fB6MMttUGngz
 pgUhHla9tz7wYrH3ot9UUv8Plmjptrb4MNS8497KFCsMFsv+y/fT9tbW
X-Gm-Gg: ASbGnctj5cLIeWk07x1hqpfe8pl/ABwOwgWkVlLeoDzOcJ53+pitf3cYmR1U+iFJ6qy
 rPXKXHumEqKcXeBZEzqpOuEWmb4IFNRQc7veiowZinD/F2GmsGa0T6rliD3VNiNlp/P33tqqi+d
 6bldmhF400QOX/jaDgHnNNLULALA6TWsg9nhcf1UUZpFOX9uo6l6YpoMdUNpTnqSjRhf/XFebMY
 KTbxk38pWpsjbQhVJSrCOs8rD2p9qeIUI7CVcQsnfNmBFbQP5PhVqJyCVKvPP3n2gtUH9TVsJsn
 XgYPXhv5JA+szNQ65Qjoq2vQ3UH+oxepFG2jUXtIB+zXnBW2AT15aLRtoxdzmEr7isZaHQZ/xlT
 tORF/oBMQfEI7wM++nLLmYRQtNOpsA6+X2MnbcDbp+hdJFza7cA3Ee+yus580mHMKkkS82RBqZF
 BKluZScyc=
X-Google-Smtp-Source: AGHT+IHtJ22GyUtQ6rfgETgzOstV6rGEBCeCEoawLHWPFBjUrgT/2BVwMKCGYW4spKdnGF5gkwxlaQ==
X-Received: by 2002:a05:6a00:2192:b0:740:afda:a742 with SMTP id
 d2e1a72fcca58-76e44565015mr16361036b3a.0.1755532678497; 
 Mon, 18 Aug 2025 08:57:58 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e4558b021sm7438899b3a.96.2025.08.18.08.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 08:57:58 -0700 (PDT)
Message-ID: <6bfb72dd-7488-4534-8e4c-1e67196976d2@gmail.com>
Date: Mon, 18 Aug 2025 23:57:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v6, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com,
 daniel@makrotopia.org
Cc: lucien.jheng@airoha.com, frank-w@public-files.de
References: <20250817150203.52850-1-lucienzx159@gmail.com>
 <5cb388f9-d488-4091-9556-c0063f637aed@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <5cb388f9-d488-4091-9556-c0063f637aed@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Aug 2025 19:41:42 +0200
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


Marek Vasut 於 2025/8/18 上午 07:00 寫道:
> On 8/17/25 5:02 PM, Lucien.Jheng wrote:
>> This commit introduces a new API,
>> request_firmware_into_buf_via_script(), to the fs_loader framework.
>> This function allows firmware to be loaded into memory using
>> a user-defined U-Boot script, providing greater flexibility for
>> firmware loading scenarios that cannot be handled by static file
>> paths or device/partition selection alone.
>>
>> Key features:
>> - The API runs a specified U-Boot script (by name), which is responsible
>>    for loading the firmware into memory by any means (e.g., load from 
>> MMC, USB, network, etc.).
>> - The script must set two environment variables: 'fw_addr'
>>    (the memory address where the firmware is loaded) and
>>    'fw_size' (the size of the firmware in bytes).
>> - The function validates these variables, copies the firmware into a 
>> newly
>>    allocated buffer (using memdup), and returns the pointer
>>    via the provided double pointer argument.
>> - The maximum allowed firmware size is checked to prevent buffer 
>> overflows.
>> - The environment variables are cleared after use to avoid stale data.
>> - Detailed error messages are provided for all failure conditions to 
>> aid debugging.
>>
>> Usage example:
>> 1. Define a U-Boot script in the environment that loads the firmware
>>     and sets the required variables:
>>     => env set my_fw_script 'load mmc 0:1 ${loadaddr} firmware.bin &&
>>     env set fw_addr ${loadaddr} && env set fw_size ${filesize}'
>>
>> 2. In your code, call the new API:
>>     void *fw_buf = NULL;
>>     int ret = request_firmware_into_buf_via_script(&fw_buf, 
>> 0x46000000, "my_fw_script");
>>     if (ret < 0)
>>         return ret;
>>
>> This approach allows board integrators and users to customize the 
>> firmware
>> loading process without modifying the source code,
>> simply by changing the script in the U-Boot environment.
>>
>> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> Thank you for all this hard work.

Hi Marek

Thank you for your detailed review and suggestions.


