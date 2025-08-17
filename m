Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F74BCA0EDC
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 23:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D85FE831E4;
	Mon, 18 Aug 2025 01:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mq1doYPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C907283939; Sun, 17 Aug 2025 16:19:18 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF3983824
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 16:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-24457fe9704so24233175ad.0
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755440355; x=1756045155; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EGb57e+5BH/BefwwFswqkulrFGXASJ+uAgOaVP9ccLM=;
 b=mq1doYPmVb9v6to6Pk1N9FsONf2KNvDJtjUi+JdhsqpjqU4qL/hkapJlLB2CaxB1X8
 LQWoCiPL5k3wkmH+PcI/7waU7gSm/X1UdsxVnhvZ/Ntr6x4+uo0CrKh8V26OJgfMRDcy
 aatBF/Dz1aA/IGkdV8yrBR4nP2aFtVdguE4ETUGUPpekfJDRLs6gRB224ybb6gBrYwfo
 9Wsei3jXwnbD9IDnhcck8It4TkclhP8A0SkufDRc2g1kSHQ0L6qQ7uT17k3UpjbMaMaw
 TmU/obTY0VCfTsrSLxWKu/Bh524vxRdM423IP/b5S6FJ/9TM6SB3OvMCnStBrz6qK3Gp
 Xyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755440355; x=1756045155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EGb57e+5BH/BefwwFswqkulrFGXASJ+uAgOaVP9ccLM=;
 b=PMd97+wcTwWXRU99rgVeJl8GrtS/rUiMxGczMKJy8gPhcKDN3mpbNF/MGEUmeLiqUE
 Sis8AMZLE5+b06PIqyv2aIRWRfBjMYSnriuwH0nHcqPepoE7MKcJfk0y7MYgFOWw4KZE
 HEt+aF5heXgCrSpBDE69RMAFvQd09RjpvzAAGhli0+EwPLfjYP406ul35odqIouea2sU
 Mnd4fXonNGHyvWIAZ8AZzTRF6UFz1V7185wQmxSYjDUCUsns9FlpJz5MC+zLuGy+Juy0
 ShKOQkFgiMg2f+rXWlA8a0o7Do2+cojSZ40zXVM9sSTx4QmeJyLlKD41So+JIj2mAxGQ
 aT1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqoKEtsLyDqlK8JB73ieI1DeL9RWxP6JceWewHwmIZDBToWmCKm026heNctNtEQLQGjtnLJHE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7wQRuW3siVC2dhH5Twlcx6j1eGglgDU1Z3pzBWrG5LglElgmn
 gtlVvq3+OcbayNSNe4qhzqDSTlzErDmB+yW3yP2Kxpq25H7CgMfNzjS8
X-Gm-Gg: ASbGncvsV5NRplKZHMRSTvtKu9wKIlJlFHXBLLard+XVTxbAW+JP7PpuKviL2ll2ZPp
 J+U3xasfM7AQSnekYDANtPnLPGYNoQMCBJywUZZrtqbAaZtvvt3xxUnwC3btESn1LKlqOEzQfrY
 JLiPhyGEI1RojMdEFDPwv63+TKuMzNTD7DGdaM42Ip25pCYotxSE17rpkxSLj1GDnmu2mmkAJor
 /PcPSKWCNO0Tt6ehbU8c1SNXq280QjzX3rrZGZwhbcfFdgOA0N2vaLnMBjxFLfJfzyVgf8EpF4a
 aPS592WEYOOoFlFdk+h2OEZw/51XDoK3v3uAC69+v+lJc3BNhIlS2s+JZV2lgrnk4Sk488g5inU
 KBXmUGryAwRoJZ7jufpoZi7PKI//DmmRmiqGO2UVqOdJ4bnRvMlb0KgglspJ14tmiU+sL8EjgRw
 1j4tb0qAQ=
X-Google-Smtp-Source: AGHT+IEUAMD0AL1SSbynCrr9MHJgm8ANprvhKP0FF/ML1jM8htYoxVdqOYv3LDRvo8OpRovTdAxiUg==
X-Received: by 2002:a17:902:f542:b0:240:483:dc0b with SMTP id
 d9443c01a7336-2446d973fbdmr139170215ad.52.1755440355001; 
 Sun, 17 Aug 2025 07:19:15 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2446d57e14bsm55939455ad.154.2025.08.17.07.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Aug 2025 07:19:14 -0700 (PDT)
Message-ID: <abf97008-1186-48f6-bf8a-feb56bcccaf8@gmail.com>
Date: Sun, 17 Aug 2025 22:19:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v5, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com,
 daniel@makrotopia.org
Cc: lucien.jheng@airoha.com, frank-w@public-files.de
References: <20250814151253.11053-1-lucienzx159@gmail.com>
 <ac2915fd-a91e-4b2c-a733-ee45e3f4f58a@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <ac2915fd-a91e-4b2c-a733-ee45e3f4f58a@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Aug 2025 01:09:31 +0200
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


Marek Vasut 於 2025/8/17 下午 08:27 寫道:
> On 8/14/25 5:12 PM, Lucien.Jheng wrote:
>
> Hi,
>
>> +    if (size > max_size) {
>> +        log_err("Loaded firmware size 0x%lx exceeded maximum allowed 
>> size 0x%lx.\n",
>> +            size, max_size);
>> +        return -E2BIG;
>> +    }
>> +
>> +    memcpy(*buf, (void *)addr, min(size, max_size));
> Do you still need the min() function ^ here , now that size is surely 
> <= max_size ?
>
> Besides that, I think the patch is pretty much ready.

Hi Marek

The min() function isn't needed. I'll make that change and submit a new 
patch shortly.

Thanks!

