Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA86D78785
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 16:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FF18967B;
	Thu, 21 Nov 2024 17:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eWRhopPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 466ED8968F; Thu, 21 Nov 2024 17:05:51 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112AB89658
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 17:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A9ACE3F5BA
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732205148;
 bh=8dpXHKhaefn94cxcCE+P/e4PKekDhZCqiDCuGL6w/sI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=eWRhopPcJIACr/mx/jAbsZYS+vlxHCZ3Bv2IezQ77G+m82zWSEmCGuHb7lKzoASpi
 pFA0IydwrTUo7wRcJyJAJhX6Yu5wdlYyAmJ77zMzm1B5QvJJXcTeLkXIYSyFqOJKAE
 gqhASnB+1mQLnss9FPREpTWKMtt42beGUw6S1f5rUKRr9sE6pzvbv5LxxK0SuP7o8J
 m+NkLh6JA1KN5dU75tZ3WauCNseehsdYWPCx3HndhPSFVCIh0xSAS1C0T6itL6i6b2
 kGqh+KkyZy0eine+wYEbizhCN4KPADwnwI58yBGH9vD4hIhte0s5EfI4vHVNK0iNmc
 v73W6+nysartA==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa209443786so218479166b.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 08:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732205148; x=1732809948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8dpXHKhaefn94cxcCE+P/e4PKekDhZCqiDCuGL6w/sI=;
 b=CpINezBbpmAUug8Vrzzy17r4rWaUokCQOvh9PcqzHKeuZh5P4Eyze0Gl8yEPgjBKcN
 s7mZwDzsz8Ha8Rqv1cllvhmR3Zb2zu3kdFMDJS1cRbCmGaUduuaFBUEpjZUMCLywUpCy
 9GXkXBLJMT+/W1ZbdEOX7vwjsTc4YM/YbDwWFmeb/izn2xCvQnAzOhG279Qgq1G267Ju
 lwFHkm3wLYzeuuopp1zLAojSMfi+wOiWVe9As8ZsYLvlwAPEg2HPpdsI7EPq1A3Bza6n
 9o4POrNauWOtGWZSFZQX+2pO//NSlw608emg8078XKeJlnQu44VNjrLWxKuZpyo1hEr3
 GPQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/7mVGWOu57VsVOnihCLTjAuilWVo5/ZahIeGOKrezDl6QsP77G3ki4mF53S2bbg3pMUj3T+I=@lists.denx.de
X-Gm-Message-State: AOJu0YwcGwQ3POxVy4uAUpKuDOiRfVsSuNPqav6AC3x+H62uuXV6TnB5
 VcLgFdd8csnr4qukMd8cOL7Svxfb1fRITety0MI/MefSpzVIk0tZcsbDNxupwKwxeqn/nV9slPD
 zXase6peB1F8idF8W84QsFWrZLO41JKC3pc/kIVqcTQ77O5uZ1FCPVZ/ASpsBGDX/RZE=
X-Gm-Gg: ASbGnctXTeCApixqbcatlebtO25sps61I5l6KjILWVGFyJy9BhMsE7V2qYIaD+Mj+i2
 bJeys39/KDZumCdquE9iVevVSE8FXkC0U7y4A39QG8c02eBUbSon95SJxwgL1rfTshepHzctbdF
 whK7VDJ92M+nX3Bq5yQgLu/8pWNLio2swec12fn3NoOtwa8ZQM+PEptNGHyl6lC6TlLBx4+iMxT
 tidTSKy4MQdN20bdF917XN8Mfoq2Vz1qHccBaxCkbg5BLQ6edTNQ5xgU9nqaQVWyRtY28o0Zm8J
 5LqSpJXNr33Tj1BxzrJU7lXoxS3uf9sVrPLVH4Jgx5Udzho=
X-Received: by 2002:a17:906:da82:b0:a9e:c266:4e82 with SMTP id
 a640c23a62f3a-aa4ef96a5ccmr427392166b.6.1732205148155; 
 Thu, 21 Nov 2024 08:05:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFU7fLTITgvTRPzvy930VujU1nSqjCz1c8+RCDObQ5nzKoM7U2r2AWbZg4vi9Oi7vKc7VknA==
X-Received: by 2002:a17:906:da82:b0:a9e:c266:4e82 with SMTP id
 a640c23a62f3a-aa4ef96a5ccmr427372366b.6.1732205146267; 
 Thu, 21 Nov 2024 08:05:46 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa4f4153720sm95729666b.4.2024.11.21.08.05.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 08:05:45 -0800 (PST)
Message-ID: <a6a1d0cb-c363-47bf-aa91-b3c2ad2fd5b9@canonical.com>
Date: Thu, 21 Nov 2024 17:05:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER
To: Andreas Schwab <schwab@suse.de>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Nam Cao <namcao@linutronix.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de
References: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
 <mvmjzcwobi0.fsf@suse.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <mvmjzcwobi0.fsf@suse.de>
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

On 21.11.24 16:24, Andreas Schwab wrote:
> On Nov 21 2024, Heinrich Schuchardt wrote:
> 
>> Our MMC driver for JH7110 boards only supports reading to the low 4 GiB of
>> memory. Booting boards with more memory requires EFI_LOADER_BOUNCE_BUFFER.
> 
> That doesn't change the situation with the booting problem I have.
> 

Do you relate to
https://lore.kernel.org/u-boot/mvm8qtnv310.fsf@suse.de/
where you had some problem reading the FAT file system and which was for 
as system with only 4 GiB of memory?

In E Shattow's case on a board with 8 GiB the file was read without 
error but then reported as not being an EFI binary.

Best regards

Heinrich


