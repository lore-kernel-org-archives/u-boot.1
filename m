Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DECC3DA6E
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 18:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C090875E3;
	Sat, 23 Dec 2023 19:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QbP+ba5+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98F2D8765A; Sat, 23 Dec 2023 19:23:58 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF27875A0
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 19:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inindev@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-427bde635ddso5767461cf.2
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 10:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703355835; x=1703960635; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nq8+Mi3IxijZZgM1dpOdIWhMiQKSw5vP4NMaL3LAsas=;
 b=QbP+ba5+Wekxs3x0jpZ2uKp70YDjKXcdMk4F2ocKHEWa+OyeiM4C3dMsYF4nefQyA1
 FwVtVoNzcTHwWIcldMUFy9gsuOn/ggjM8wKYwdjVtlJGsTMPzl/4ejrgt4PMcYoORGiN
 xMoG200wvSQLWaTh91sQDxHK3HN9gPtLbmctJoOpzb1tRP+g0TWu1nTgVL3HVsQhhCzW
 roAr0NnUSpHHjCNb+ciWDybhq5FqQA+Z9EoJlEHcQW/mAg+17F32CXrR+lUC/0Imdl4/
 EpPylg+xVSyAW4FaW/dWE6y39gVDTiZtPutvnaHmG+Bm5EX/vVdJMhGUgqkCIV5iaTJJ
 vLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703355835; x=1703960635;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nq8+Mi3IxijZZgM1dpOdIWhMiQKSw5vP4NMaL3LAsas=;
 b=biVc866AMMvzDVQ31KtjbOiowIO6J3MGF/61Z9994oXGMaTaM098OY+uTeRevn68q8
 Gs/0OtBxOWLyCsExQasqHl+ZIf3ywCYubFpojq5jX/737Z9A/MGHpbGK1cVRu7htvzkO
 HHIb1i9XrEBi9pwi0QwmXIOU+T6+kCwDU9cuqkjVC1Y+KjSnk0W2zDCnolJlEvLPiKrv
 tFfHGiAhrsHEXZ1DMifJr9ILhppM0u+cCD8LRDDoMNLh/iyhKdx1v0f6qIO/q+9somqJ
 t4EdqD7yYzoSWMa16rEtDvt6FPhhloKsTOuxdl4gIKQpI4qRNQzd+VYOY8cdhOA5OJjP
 v5qg==
X-Gm-Message-State: AOJu0YyVfsYY90d7b6HX4u6jSWRwrBBC64vYNWJJJTMxjghQ5frQkDpX
 irT/iYBaVWn7ITb9guCn33H12zPf4aM=
X-Google-Smtp-Source: AGHT+IEHdoCGXE5JOxC7FK3HztwUjlobHXFDjeTaSnBsH/P28OKVNCh/mPSgVAr3JXgzG7Vx/a0eTg==
X-Received: by 2002:ac8:5782:0:b0:427:a4eb:d7ce with SMTP id
 v2-20020ac85782000000b00427a4ebd7cemr4352512qta.119.1703355834657; 
 Sat, 23 Dec 2023 10:23:54 -0800 (PST)
Received: from [192.168.20.212] (107-015-241-140.res.spectrum.com.
 [107.15.241.140]) by smtp.gmail.com with ESMTPSA id
 df24-20020a05622a0ed800b004275e9cdf15sm3003445qtb.11.2023.12.23.10.23.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Dec 2023 10:23:54 -0800 (PST)
Message-ID: <695c715c-5913-1458-2646-b2bae406772b@gmail.com>
Date: Sat, 23 Dec 2023 13:23:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] rockchip: rk35xx: expand space for decompressed kernel
Content-Language: en-US
To: u-boot@lists.denx.de
References: <20231223121310.43790-1-sigmaris@gmail.com>
 <20231223160908.GF2652760@bill-the-cat>
From: John Clark <inindev@gmail.com>
In-Reply-To: <20231223160908.GF2652760@bill-the-cat>
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

On 12/23/23 11:09 AM, Tom Rini wrote:
> On Sat, Dec 23, 2023 at 12:13:10PM +0000, Hugh Cole-Baker wrote:
>> An uncompressed 6.7.0-rc1 Linux kernel Image built with the arm64
>> defconfig is about 40MB. This does not fit in to the space between
>> kernel_comp_addr_r and fdt_addr_r, so when uncompressing an Image.gz
>> to this size, the FDT will be overwritten. Move fdt_addr_r and
>> ramdisk_addr_r higher in memory to allow 96MB for uncompressing kernels.
>>
>> Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
>> Cc: Kever Yang <kever.yang@rock-chips.com>
>> Cc: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   include/configs/rk3568_common.h | 4 ++--
>>   include/configs/rk3588_common.h | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
>> index 1b7d3437b1..da5b38803e 100644
>> --- a/include/configs/rk3568_common.h
>> +++ b/include/configs/rk3568_common.h
>> @@ -20,10 +20,10 @@
>>   	"script_offset_f=0xffe000\0"	\
>>   	"script_size_f=0x2000\0"	\
>>   	"pxefile_addr_r=0x00e00000\0"	\
>> -	"fdt_addr_r=0x0a100000\0"	\
>> +	"fdt_addr_r=0x0e000000\0"	\
>>   	"fdtoverlay_addr_r=0x02000000\0"	\
>>   	"kernel_addr_r=0x02080000\0"	\
>> -	"ramdisk_addr_r=0x0a200000\0"	\
>> +	"ramdisk_addr_r=0x0e100000\0"	\
>>   	"kernel_comp_addr_r=0x08000000\0"	\
>>   	"kernel_comp_size=0x2000000\0"
> I think this shows the real problem is that the defaults here need to be
> re-thought with functional maximums in mind. There's a practical limit
> of 128MB for the kernel so we should have the kernel, then the kernel
> decompression buffer, then device tree and overlays space, then ramdisk
> at the end.
>
kernel_comp_size needs to be adjusted with this change

