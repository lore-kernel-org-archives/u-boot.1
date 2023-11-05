Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E9FC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 03:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F096A864C3;
	Sun,  5 Nov 2023 04:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qiCv+Ole";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2985E80422; Sun,  5 Nov 2023 04:47:48 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AF0D86EB8
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 04:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C079140627
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 03:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699156044;
 bh=vK7wZefNgSChQrA1Sx7wour2r+ZdbZEj26mthDhQUS0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=qiCv+OleyFF1NhTQCCnLCr3T49cWNzbZOiTymiPjYLfYlg5TRbovuF2LzLuq3fwiY
 JKCd5hU8GMXIKDuplhHcV/n2FAGrJAXVmJwdDtK+FlnE7Gq/U9/SoVRcJ2ZjCTxq2x
 OYKnI6gROlkhcgxTaaXOU4aqhCySZpJyUSPvGOl6U1c+1Mi/ejmNMIyGuQWBuk4uH2
 89nwNl/ZnQXWt4sWMzJlntZXgKc+OpX01CZExMZcotWcFRoiYhQjkftpexoGKdcqJE
 nZRSv2HBi3Pgq/o9WPEXH1k1nQM0EmuHsNM9lt+vyR0xn3OUcdn0h5Q8p0/ssa8zGi
 Gm1V0rweK739Q==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9cd789f0284so232945066b.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 20:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699156044; x=1699760844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vK7wZefNgSChQrA1Sx7wour2r+ZdbZEj26mthDhQUS0=;
 b=ppWfHJ/nQ0cTxHa7iPCZJc8BAAQaueXTbtCf0JbDPAXYdAaQRUturv80cJXVra68bj
 lDir6v7zQAlF7RfRPp/kTtoz5Bca5sH4BMlE7pm3Ig4H14ug6VtT9TyNz8mBQtLVG8B+
 3XH8H7OKqYJ55JyizJy/KDUNIlN9OX/+S43PkeL33vbuqF0+w89N0R0I2OKCnU1gzl9f
 UE6hVhuHPW7kTHPgzrrJGhykBKU3/LW62PwycpsTuAsNIi6ZCAe0vkPEbjUoR6PbpDB1
 KxAYMHw2CbyTgnxw47vry7/4wCPRZ7msmnnmosQuEMto/zQJRYvxIp7oMVqwibvRI2i4
 k6Lw==
X-Gm-Message-State: AOJu0Yz6YV6r8thZL/Y8Ywo9wRKBgVHM6NE+t2pcTLKFjLsr4A0csOAP
 zuz6Lj/foorVLfhLQTFycP6+sDhg7cTdWvmWpyDWOAIGIeTWXDxwifvphAjrImQMBOrAbad13al
 2uLYXkKO/l2SjVTrKxZiPoRE4qHRB6Iw=
X-Received: by 2002:a17:907:d19:b0:9bf:4e0b:fb05 with SMTP id
 gn25-20020a1709070d1900b009bf4e0bfb05mr10839409ejc.11.1699156044295; 
 Sat, 04 Nov 2023 20:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh/m9gruwMzVfiCLKXGBQTfFgt5B8LzXRsgtVlBUQ5pmq/NGilzS7nGprhbTGMhid3MJKUbg==
X-Received: by 2002:a17:907:d19:b0:9bf:4e0b:fb05 with SMTP id
 gn25-20020a1709070d1900b009bf4e0bfb05mr10839399ejc.11.1699156043837; 
 Sat, 04 Nov 2023 20:47:23 -0700 (PDT)
Received: from [192.168.200.42]
 (dynamic-046-114-039-028.46.114.pool.telefonica.de. [46.114.39.28])
 by smtp.gmail.com with ESMTPSA id
 gw14-20020a170906f14e00b009ae3d711fd9sm2591873ejb.69.2023.11.04.20.47.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 20:47:23 -0700 (PDT)
Message-ID: <874c3e34-56db-4f3a-acad-099d16735333@canonical.com>
Date: Sun, 5 Nov 2023 05:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rng: detect RISC-V Zkr RNG device in bind method
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Xiang W <merlew4n6@gmail.com>, Andre Przywara <andre.przywara@arm.com>
References: <20231104065107.23623-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ36uRkVGKicr_hD-=0HO+i9giQ7vRxo0uKD+BGQnLWdWw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ36uRkVGKicr_hD-=0HO+i9giQ7vRxo0uKD+BGQnLWdWw@mail.gmail.com>
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

On 11/4/23 21:42, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 4 Nov 2023 at 06:51, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The existence of devices should be checked in the bind method and not in
>> the probe method. Adjust the RISC-V Zkr RNG driver accordingly.
>>
>> Use ENOENT (and not ENODEV) to signal that the device is not available.
>>
>> Fixes: ceec977ba1a9 ("rng: Provide a RNG based on the RISC-V Zkr ISA extension")
>> Reported-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   drivers/rng/riscv_zkr_rng.c | 34 ++++++++++++++++++++++++++--------
>>   1 file changed, 26 insertions(+), 8 deletions(-)
> 
> This device should be in the DT, so you have some control over which
> RNG is used.

The device-tree provided by QEMU does not contain such a device as Zkr 
is an ISA extension and not a device. This device-tree is not under the 
control of the U-Boot project.

Best regards

Heinrich
