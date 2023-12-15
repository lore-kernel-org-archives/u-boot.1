Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01264C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 19:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9BF87C4A;
	Fri, 15 Dec 2023 20:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DxLpzmtg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE96E87C6F; Fri, 15 Dec 2023 20:22:26 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA9487C45
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 20:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8DF4D3F5F0; 
 Fri, 15 Dec 2023 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702668139;
 bh=u18/5lFC0XIL+NSLRVYOPSDAdlePlnRIS0NlorStt8U=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=DxLpzmtgo1TX2UR2ZGy/s/hvRSh3Ly2k2C+2DMqDk12XwuNjbSQvZk3ytmwBORZiG
 ZgDhVHHruWN2Ln23aJWlUFizbkUoB8VCI7SOUpfJ8FQUc8chnsHS/UOMNfaqc/qHP7
 5cOBCgg2PXVpwgeQk6UnIqHRgo3DyTr9UVMRQE3RTlNCnUHgYqOa453Y166K3UP6lG
 vXNIUY8BkeyBaIuwOJbM/xWPaFlGYrqREoS8rtgwKiP1wCABfl/QkzY1D2m4H2uD05
 Q6SwnavTRqBBwepjwHu11vbnS0FzBzt0eZEmxXnRhYQFqj2rPAQhC+CUYsCgWB00Uj
 5NmmWS8IvBGaQ==
Message-ID: <a3e003c8-1681-466f-a224-4098d1ef7b22@canonical.com>
Date: Fri, 15 Dec 2023 20:22:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cmd: acpi: check HW reduced flag in acpi list
Content-Language: en-US, de-DE
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20231215164016.137794-1-heinrich.schuchardt@canonical.com>
 <20231215164016.137794-4-heinrich.schuchardt@canonical.com>
 <ZXyRDStdm4J__CIX@smile.fi.intel.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <ZXyRDStdm4J__CIX@smile.fi.intel.com>
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

On 12/15/23 18:46, Andy Shevchenko wrote:
> On Fri, Dec 15, 2023 at 05:40:16PM +0100, Heinrich Schuchardt wrote:
>> On non x86 platforms the hardware reduce flag must be set in the FADT
>> table. Write an error message if the flag is missing.
> 
> ...
> 
>> +	if (!IS_ENABLED(CONFIG_X86) &&
>> +	    !(fadt->flags & ACPI_FADT_HW_REDUCED_ACPI))
>> +		log_err("FADT not ACPI hardware reduced compliant\n");
> 
> I guess it's half baked solution as this, HW reduced, flag adds more
> limitations even on x86. If you want a good validation it should be done
> in a separate function taking others aspects into account.
> 
> But since it doesn't affect my area of interest in U-Boot, I won't prevent
> you from doing this way, it's up to the U-Boot maintainers how to proceed
> with it.
> 

This flag is checked by Linux. It won't boot at all if the flag is not 
set on arm64 or riscv64. See arch/arm64/kernel/acpi.c and 
arch/riscv/kernel/acpi.c, function acpi_fadt_sanity_check().

Once you have booted you can use the Firmware Test Suite (FWTS) to check 
the rest. I don't plan rewriting such a validation in U-Boot.

Best regards

Heinrich
