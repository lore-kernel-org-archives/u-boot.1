Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23833CE7AF4
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 11:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E8B83F33;
	Fri, 14 Nov 2025 12:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="o75v61TQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3571E8409E; Fri, 14 Nov 2025 12:49:54 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C5F383EF5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 12:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1A6723FCA1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763120990;
 bh=bbyxxH7zTZ8IWOU8hcPuNeq3UlssIVNsOyVsT0Gn5bc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=o75v61TQR17RsZE6vimceCdduUyUzLz3Pkza61wif1L7QgckD1hc500nH6G41feC3
 1PBQuu5fNvAQZR1WGgZ8qHhqCGDb9qVkpwfxb5XV1ERnfe5qzUvdBNGiJDYkVFCjvx
 N09NhvreCVPjloLIe7knq/mR6zgdVPF8YXWu/mhWuNTPOZ+HdIbofBq3c3D2f1Osfq
 oqfkEMTpGZpY0kdaVYdF97SimllEVL17Q/Xihnh81OqeU9zoAHAPsBiPtFPBhiXQJe
 AThB5/cNay5u51Zh/ourr5gfqYTM5ho3hzEPFXOSCkNPXG7kG6CDQH1L/RDLWX0eIX
 ynIPrbCI6dTOZ5nSzjvyQ0oRxuHWFPNSs4QzYoxIDOZ2tocqLgOc8DWrXrxfQIGbKO
 XigOtStEAijShFYFUNVaQhY84wdOVg5qU7TtsGHH7uOjHGJgV/vEtZjTQn5r1P+uat
 T4f6zjHE2jbgInJW8C58PjY/xJD3AUXfIQZcUaa1QzbnoR4Ekc/C46RWBruJHDvXXr
 zkC4PjR5znf4/qOO5fajssmQ7i1SPiNjGOP0Fy8mYE/qi6JRMLJI7AFVVWTcaE7/LG
 DgCVftX4c4PL3op2Qbd+uhSQEJwjxOIiV3sY4hbdxW7451jrXRlHXKxgmD9ynHV2iW
 hYNY0HXbRyyzv4Uz2loPKfIs=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso13018705e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 03:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763120989; x=1763725789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bbyxxH7zTZ8IWOU8hcPuNeq3UlssIVNsOyVsT0Gn5bc=;
 b=d+A2o/c1zFBWBQ7xfqBMAMlPIBxj40t3DvTgdaCNG9ja7OHajXwKprzQ94+Jfgcyo4
 86hW44WFbCqOdt1YjF7WF6rcV2x4V/f+DlP7HkND2TsmoeV49Sv8X/TCn/Od40P+RXoh
 HgPhCJcB5KULM2JdbEhpd6NBDA8AAlEXtjaMSIXUlsKAzMTB8efh1z+lyXb6mmCUhcVq
 ShVMzqpPT+J1C+yM2PZklNwszuKxHp4lZI4oG9tSArRwDJaDzcrtcJPTU8XP4KFCkCWX
 SwDN4HSHP4arLQ619SVnRMBgTDXA2iC2GdQC1rgFuyWCoUA2Pr5CLkp5wgAz/7SgdrKJ
 aGyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx5E9H6i8T+qF8Dy7s2wV+cNbounI+Jk+E2yPC1NOHxTAvdyHlpqoJJShcP/7QmOhTuR8u6S8=@lists.denx.de
X-Gm-Message-State: AOJu0YxIHXpcm7TCpPXvVgi+QpRR2KuAa+HpsJDcSZfTO5jQg60FL3g3
 EBabeYXvGE+hX2FUgH/JS09EAcImhBZT86Xndi86ED/KhwxLpuCaSQWhk7peAUVIKHrZgnkDBgJ
 11INCK/1w3hmj1hKHLTObodXEq+sMwhaxcZO+bR87MUaUpkND+AmB9L/y/uS4qlmZR0fvHLV1hk
 5M0uzaag==
X-Gm-Gg: ASbGncvuKhJieTujvUaiEWIN6HTXcBND2JmEXNdSJ9wzd2Q47y6VlCOR1zRG7haOzod
 0lJdZdxMSD1ayJi7nTh09h7QrqKqi3MzMnjc633YzOvpHjsPacmPInU2swGFyVN6E8la9LxPSzh
 aPlEL1VlxbB1ujtTa3EzU0kumI04r048qszsFGVlYLucuvPO7OlXTLCNYDflbvInyHOoQIxvy7M
 yo1F0/4MgHrtFTPoZOUhcqcI9KptqPt68CXjsI5abIFg9SvkTlRJnlkGa8pEVXfvFb80wMGFR/P
 zU47HrhKcEhZJCVRfKTF9tyOgsfb5A2V/t9/GsVefjwD0AbSc/Vn/11AQpyWMyJPYPrD3nigoN4
 yKNwEukQX8wY3in347MASlrWNbpzwu+nuqyq2WQ8F8xiyXatPipqvQrQ3nGJNJlCHrQQgIX+/
X-Received: by 2002:a05:600c:4503:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-4778fea8b8dmr25878575e9.22.1763120989450; 
 Fri, 14 Nov 2025 03:49:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7hQRsiC6mJ15LAmj5U+5pSXyYnfN4HaHAVK6xD1uWW1PejCfa+IDR4lYaXVOKGmYzuY4ePQ==
X-Received: by 2002:a05:600c:4503:b0:477:a9e:859a with SMTP id
 5b1f17b1804b1-4778fea8b8dmr25878265e9.22.1763120988931; 
 Fri, 14 Nov 2025 03:49:48 -0800 (PST)
Received: from [192.168.103.118]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e6a1sm137965465e9.11.2025.11.14.03.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 03:49:48 -0800 (PST)
Message-ID: <3090dfe9-8f44-459f-b2c5-193b9ccda5a2@canonical.com>
Date: Fri, 14 Nov 2025 12:49:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] fat: Separate fat.c from fat_write.c
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 Simon Glass <simon.glass@canonical.com>
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Claude
 <noreply@anthropic.com>, Tom Rini <trini@konsulko.com>
References: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
 <20251113064656.245394-3-heinrich.schuchardt@canonical.com>
 <GV2PR05MB11941F7E4872C47E87283CCDB83CAA@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <GV2PR05MB11941F7E4872C47E87283CCDB83CAA@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/14/25 11:55, Maarten Brock wrote:
> Hello Heinrich,
> 
> Don't you run the risk of getting into namespace problems when you make these
> static functions and global variables non-static? Esp. the ones without the word
> 'fat' in them seem to be in danger here.
> 
> E.g. downcase(), cur_dev, disk_read()
> 
> Kind Regards,
> Maarten

Thank you for reviewing. You are right. These functions should be 
renamed with a "fat_" prefix.

Best regards

Heinrich

> 
>> -----Original Message-----
>> From: U-Boot<u-boot-bounces@lists.denx.de> On Behalf Of Heinrich Schuchardt
>> Sent: Thursday, 13 November 2025 07:47
>> To: Tom Rini<trini@konsulko.com>
>> Cc: Simon Glass<simon.glass@canonical.com>; Gabriel Dalimonte
>> <gabriel.dalimonte@gmail.com>; AKASHI Takahiro<akashi.tkhro@gmail.com>; u-
>> boot@lists.denx.de; Claude<noreply@anthropic.com>; Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com>
>> Subject: [PATCH 2/6] fat: Separate fat.c from fat_write.c
>>
>> From: Simon Glass<simon.glass@canonical.com>
>>
>> Currently fat_write.c includes fat.c directly, which is unusual and
>> makes the code harder to maintain. Use the internal header file to hold
>> shared functions, to avoid this.
>>
>> Co-developed-by: Claude<noreply@anthropic.com>
>> Signed-off-by: Simon Glass<simon.glass@canonical.com>
>> Tested-by: Heinrich Schuchardt<heinrich.schuchardt@canonical.com>

