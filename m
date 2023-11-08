Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642B0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFCDC871AD;
	Wed,  8 Nov 2023 16:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lLXJN4c2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0292F86F7E; Wed,  8 Nov 2023 16:30:34 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FF03871AD
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6754b4091b6so43317996d6.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 07:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699457429; x=1700062229; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RoZpg4LSUB5IJM1KPjpSyxTlqY6GymYYfI1XdxI5kx4=;
 b=lLXJN4c2PQGOAlATvV9I+9hnt0LP7FTK40DffJCgzlEIm2dvzYdCYiiXWPESjHhHti
 UqDDSEmH9pAK4ZvKB/U1alfsgsHVTNZR96BEySIsboWOGxgWoFeZw4X8yCdXm/ImvyW8
 uhnev+B7k7pFmZZTBBrcW6sa+beGIggNmhfhzcrcyQOXZxuIHpv0FsAVxMRBrZGoF3CQ
 nEktvHdQLeQitt13wHOfN2Sb+4kVTy0yS1AWhG7AZtHjSVv68bAD42DToAV1OkkFi9Md
 n86Mio0hL+xe6v1ssE93MrD3NZpFwixYbR7DtI6ht3hv5ZZjLfLeyXIW7IfDfFF42UKg
 TX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699457429; x=1700062229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RoZpg4LSUB5IJM1KPjpSyxTlqY6GymYYfI1XdxI5kx4=;
 b=Du1QUXdKMQcA4MrMHBCJsh/BlLOe4ZNs3+ax8Vow9IbU9WDUbhgvwITuYUYCJ59TU0
 bQPx450olOm5gjVCo4Co73cJsFjPmkk/kUWMMckAY8S/CTxEOJTpxRJomsgZ8Bd5IxLZ
 OF+OhXmgkP1q0aS/cN+GgNiRPETBehuQ5NVETXXTAXRPH9IQ5FRzpBfN2Tzv0SO+BMsz
 8kVrA1RYIIpDb4jkZkc+g333t5nrg5rRxncE6tuX4lSs/hEtKPH5AYQAKXqzQ+BojPJb
 ITMp1vHnyxJJszGOYzbY9oJEKQkIDaYFvsLWGf5Hana27L64YKBUv1z+U+xCB1YSxWLi
 Filw==
X-Gm-Message-State: AOJu0YwFDTISz3NrJyLTws78bR7bt9ArtB/dIjFRamK4FZx13Zl8RQZ8
 jYte53W41MvA0PLooglb4Mg=
X-Google-Smtp-Source: AGHT+IHcibKXC9SM5QDBDcIEtLzzVT5gS28Tip3qqTuv0cdK93STYc9Hvre3si9XTgQajQYzSk0dyw==
X-Received: by 2002:a05:6214:1c86:b0:675:815b:4a01 with SMTP id
 ib6-20020a0562141c8600b00675815b4a01mr1803165qvb.50.1699457429270; 
 Wed, 08 Nov 2023 07:30:29 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 mk23-20020a056214581700b0066d20f29e5fsm1179965qvb.35.2023.11.08.07.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 07:30:28 -0800 (PST)
Message-ID: <ae5214e2-63c1-6c10-e8f3-a5cacc6930ac@gmail.com>
Date: Wed, 8 Nov 2023 10:30:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 05/25] spl: Remove NULL assignments in spl_load_info
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, =?UTF-8?Q?Marek_Beh=c3=ban?=
 <marek.behun@nic.cz>, Marek Vasut <marex@denx.de>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Stefan Roese <sr@denx.de>,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-6-seanga2@gmail.com>
 <CAPnjgZ1efoJtQCZPO1Nb0u_B5fS6nhH=8k8AcS0Ank3pQe+JpA@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ1efoJtQCZPO1Nb0u_B5fS6nhH=8k8AcS0Ank3pQe+JpA@mail.gmail.com>
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

On 11/7/23 23:23, Simon Glass wrote:
> Hi Sean,
> 
> On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>>
>> Remove NULL assignments to fields in spl_load_info when .load doesn't
>> reference these fields. This can result in more efficient code. filename
>> must stay even if it is unused, since load_simple_fit uses it.
>>
>> Signed-off-by: Sean Anderson <seanga2@gmail.com>
>> ---
>>
>> Changes in v6:
>> - New
>>
>>   arch/arm/mach-sunxi/spl_spi_sunxi.c | 2 --
>>   common/spl/spl_fat.c                | 1 -
>>   common/spl/spl_mmc.c                | 2 --
>>   common/spl/spl_nand.c               | 4 ----
>>   common/spl/spl_spi.c                | 2 --
>>   common/spl/spl_ymodem.c             | 1 -
>>   6 files changed, 12 deletions(-)
> 
> This makes me wonder if we should have a function to clear it out
> (using memset() and perhaps a bl_len parameter)? Having said that, the
> info-field use is pretty self-contained with these files.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

It would be simpler, but this series causes bloat in other areas and this
is a very simple way to reduce text size.

--Sean
