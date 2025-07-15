Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AD5C83F27
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 20:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DA7830F6;
	Tue, 15 Jul 2025 22:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="DxQaXfKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4670830C8; Tue, 15 Jul 2025 20:59:25 +0200 (CEST)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD43830B3
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 20:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ariel.dalessandro@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752605958; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Yz7xGksUg9S0lKOXsq9P/wuhcu0UDfqnDc3HZX5PhOn4V2eJ/cicm9QY5OZahfNxxHBEaZtpAg9mVKMM6pSwJqFx0N5lM+7PBYmR6FWQu17y0rTLoBYg0/9f1effjhJ4u9WEXPEdfyzDPojsvI6h3T7e053MMic8pRY/5oWBwOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752605958;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ky4LYg1cNGT3K4SILykWNX3d/MRXZFZCUPq0vyqKH6A=; 
 b=fFS0a1q/w/YN9NJh2hYSk8XgDvHTb9J3Jt77/8+E2ROricF/uFYGI7o6zVhA2hcelXftFwT2XBU+3b4X9gYIvh2P4JUEWajoDKUyrLjfPBmmamyff3x3oW8KP2HQ1by3Sr9ZxsmWwkBu1Fn221YpeY7NriTCTER4g5VFlA7YUzE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
 dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752605958; 
 s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Ky4LYg1cNGT3K4SILykWNX3d/MRXZFZCUPq0vyqKH6A=;
 b=DxQaXfKgCtyJN2CoW4wKV+SLyJA4mynsao4sv8IWmAjtbrLmPJ3k+07sGdXTzF5X
 BTdr2ecaqlKsYGv4It86PQKFdfAfUn3DO2CN5xZrEVqtmStZptWvjVr+V9LF2wmhpdF
 HxwSoYtL+I87VcNIKge8igOlFK16h2FdwaeDPtmk=
Received: by mx.zohomail.com with SMTPS id 1752605955991652.4544538694528;
 Tue, 15 Jul 2025 11:59:15 -0700 (PDT)
Message-ID: <a63599df-aa33-41b7-9998-8fdd4d283036@collabora.com>
Date: Tue, 15 Jul 2025 15:59:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: fastboot: Add support for SPI flash memory
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, mkorpershoek@kernel.org,
 jerome.forissier@linaro.org, patrice.chotard@foss.st.com,
 ilias.apalodimas@linaro.org, andre.przywara@arm.com,
 casey.connolly@linaro.org, mwalle@kernel.org
References: <20250715172311.265716-1-ariel.dalessandro@collabora.com>
 <20250715175025.GG193579@bill-the-cat>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20250715175025.GG193579@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 15 Jul 2025 22:27:46 +0200
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

Hi Tom,

On 7/15/25 2:50 PM, Tom Rini wrote:
> On Tue, Jul 15, 2025 at 02:23:11PM -0300, Ariel D'Alessandro wrote:
[...]
>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> index 70207573de2..0cf955ef53d 100644
>> --- a/drivers/fastboot/Kconfig
>> +++ b/drivers/fastboot/Kconfig
>> @@ -91,7 +91,8 @@ config FASTBOOT_USB_DEV
>>   config FASTBOOT_FLASH
>>   	bool "Enable FASTBOOT FLASH command"
>>   	default y if ARCH_SUNXI || ARCH_ROCKCHIP
>> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
>> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || \
>> +			(SPI_FLASH || DM_SPI_FLASH)
> 
> Why do we need to support the non-DM_SPI_FLASH case? It's legacy and we
> shouldn't add new features for it.

You're right, I'll drop that. My mistake as I based the implementation 
partially on what the sf command does, and of course, that part is legacy.

Thanks! Will submit v2 with that fix.

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718

