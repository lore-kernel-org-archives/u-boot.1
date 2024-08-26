Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37E3C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 11:45:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6FA8895B;
	Mon, 26 Aug 2024 13:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sdINgs/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA9678895B; Mon, 26 Aug 2024 13:45:14 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E59871C9
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 13:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so35964665e9.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724672712; x=1725277512; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5x9hWv+87clhphkZt2Zy6sacwxJRBrdfWjl/hMerkfs=;
 b=sdINgs/+0JVndOtzpSvOOQr4C/csePJ91jBQAO64LrW6bgmNkR72rYu/W630ARRFSP
 YQs4taGZUYFYE7Bxa7JidTSTRngelgCmHdIOPObSzMX+D4/vNIsiFRCIDiA17Yk0cLu1
 qvBwpCEPECi1C6JunD0x0gcRnU6iLRLBw8ZgiRoDs2qMQqJeE5voR48QP/M3CRGXDYT7
 PJ1noL0sK9eGTAzhLFODeyYoJUrwioNZio/dTuMROqvU9wzXndAHNXfXDpCx7Rc/mZM2
 4VrLTxNB6rxuo6RfyuT5jqnjtBl3UTHFxlXMFcEWAZSpjQtIFXFSWDM53hFGbpEseUro
 YU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724672712; x=1725277512;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5x9hWv+87clhphkZt2Zy6sacwxJRBrdfWjl/hMerkfs=;
 b=DNiLr2GoL1c57+nFykkul7B+0IHiJvZs4Why/d6uitADGbcHJ9cEbytF0z95eWO+Q7
 4XTyBFaTV38H5L4nuKmZaYjL2gKILikoJ4j0R6uC0pkj/VDMSOEa3szDOm1b1q7Wtsy/
 isIRH+wzafPheOavseJHQ5LvrbygiwG9eM7lwxV4U21jkTAO4OnYmuXRkIMY0v87LE6O
 7US8Opq/9ODF2hZilyBeXHLzwiQ8ynvV/9xSCb8x8VP9Wol8Vda7Bu5rVky31nN6B9Ll
 gd48ekBfVlhQtaflY+v3vIoFOLJN29G7MEeUsKCzS56AXE1NsF06u3ZZgqQdfsvr08Kl
 E3Kg==
X-Gm-Message-State: AOJu0Yzti/O6tVK1inBeVm+jtozxcLlnyB55xPxBYcr5wNnwRiMVoiBU
 kNGhjDHDJe8IXgyeWR6J+YgQlRf7hJQcPE52WE+YUq5CpsQoSGYjXJ9PjIrxtiQ=
X-Google-Smtp-Source: AGHT+IHUJuBuUl2WYNF8Kxe7zWNoO8gSL/e3i2O9UoHNJc+LSK7pUI9uuk1EEPtnwXsDvfcQtSmRLA==
X-Received: by 2002:a05:600c:45c8:b0:428:10d7:a4b1 with SMTP id
 5b1f17b1804b1-42acc9fe370mr64345955e9.25.1724672711682; 
 Mon, 26 Aug 2024 04:45:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:600f:f83:7439:fd9c?
 ([2a01:e0a:3cb:7bb0:600f:f83:7439:fd9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730815c90esm10577217f8f.56.2024.08.26.04.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 04:45:11 -0700 (PDT)
Message-ID: <12d558ef-6c76-4ae5-9aa3-7e34eb5e2a60@linaro.org>
Date: Mon, 26 Aug 2024 13:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/23] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <20240823211825.GZ1626301@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240823211825.GZ1626301@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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



On 8/23/24 23:18, Tom Rini wrote:
> On Fri, Aug 23, 2024 at 03:48:04PM +0200, Jerome Forissier wrote:
> 
>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>> stack [2] [3] as an alternative to the current implementation in net/,
>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>> reasons for doing so are:
>> - Make the support of HTTPS in the wget command easier. Javier T. and
>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>> so. With that it becomes possible to fetch and launch a distro installer
>> such as Debian etc. using a secure, authenticated connection directly
>> from the U-Boot shell. Several use cases:
>>   * Authentication: prevent MITM attack (third party replacing the
>> binary with a different one)
>>   * Confidentiality: prevent third parties from grabbing a copy of the
>> image as it is being downloaded
>>   * Allow connection to servers that do not support plain HTTP anymore
>> (this is becoming more and more common on the Internet these days)
>> - Possibly benefit from additional features implemented in lwIP
>> - Less code to maintain in U-Boot
> 
> As an odd thing, the series leads to ethernut5 failing to build,
> strangely over the RTC driver it uses, for me.

Weird.

> I did have to manually
> merge the CMD_WGET related patch, 

Weird.

> but I don't think that was what went
> wrong here.

Could you try to build from GitHub perhaps?
Branch https://github.com/jforissier/u-boot/tree/to-upstream/v9 builds
fine here:

$ ./tools/buildman/buildman ethernut5
Building current source for 1 boards (1 thread, 24 jobs per thread)
       arm:  w+   ethernut5
+===================== WARNING ======================
+This board does not use CONFIG_DM_I2C (Driver Model
+for I2C drivers). Please update the board to use
+CONFIG_DM_I2C before the v2022.04 release. Failure to
+update by the deadline may result in board removal.
+See doc/develop/driver-model/migration.rst for more info.
+====================================================
    0    1    0 /1              ethernut5

Thanks,
-- 
Jerome
