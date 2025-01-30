Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EC9C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 10:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6CE820A1;
	Thu, 30 Jan 2025 11:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738233454;
	bh=GE1CdFbtgzFBAAOfMKDHq/SJelFIbGMm9Ql2DYuORvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z/J54+xvllEYowKdmgLzd2Zme//xJtwCmw5eO4lENwlOYAmmZ5/uKN7Sj2xSc9sZC
	 tO7orvKNYCJl9Kai6dR3ypUgL9nGY3PdoEkpGPhi3m8UR23MsrVyJMXoclFGd62pAC
	 U3j7/SpXvqzS92XYdBwEqpTZW584c02+nHbRF7APWA6OGqP1h1vsyd3SYH9IAfHMD4
	 fJZ310K6erKaqqwrNWWkMZdDcvVO/xe8p5xQdecN/w8zdF6BJDqpFPgEG5NvJuyIsl
	 daZDb5iLV5E1OiSMyhsyGVr6OECsEluyQuj81mX5TWQOF1mxBO7G7V5YjfjG5V8qGN
	 lkvtV8MxJc9Xw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB6F820A2; Thu, 30 Jan 2025 11:37:33 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 347BA801A0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KD9akzhN"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4BDED10382D0A; Thu, 30 Jan 2025 11:37:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738233450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GE1CdFbtgzFBAAOfMKDHq/SJelFIbGMm9Ql2DYuORvA=;
 b=KD9akzhN1S3hUZUKGWbQQ/Mw9jUwPIHWDZak2FaKn/tmGTHzwFihTbGihUm9p50UkNkj0O
 PTVG9fCEN2F46uS4s4Zk2v0YqApvfq2wjxhb77baTo5XAf0FJc0YDiCnR6yXn6gG58Qy+x
 f1tU3TjBOwTTOrLRw4gEwDsiI29RAanVJ0kdCbb5oXW+s3lDgzcUcrHsPKmhjCx6RqhuXf
 4GZqazKXmpf2Rfjcr3grfzUYyWzNMxzSKGH40b/QNnw+qbYiqZfRiuTKsuPP7F1tSrMet6
 Ut3b0vsMuPvF0k26ie2IHS7hALlONIZsdQCQJGwpdbJvQk2xzTcJp33s6lMvEw==
Message-ID: <0cd7e315-b15a-4e0f-848e-75da3f80887a@denx.de>
Date: Thu, 30 Jan 2025 11:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootcount: zynqmp: Extend ZynqMP specific bootcount
 support
To: hs@denx.de, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
References: <20250130013726.337914-1-marex@denx.de>
 <4f7e2e18-57bb-f7e2-1202-663240668ef1@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4f7e2e18-57bb-f7e2-1202-663240668ef1@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/30/25 6:24 AM, Heiko Schocher wrote:
> Hello Marek,
> 
> On 30.01.25 02:37, Marek Vasut wrote:
>> The PGGS area contains four registers, each of which can hold up to
>> 32bit of data. Extend the boot counter to support storing boot count
>> in either of the four registers with arbitrary mask to avoid limiting
>> the boot counter only to the PGGS register 2 LSByte.
>>
>> Drop U_BOOT_DRVINFO() as that would instantiate the boot counter even
>> if there is no DT node associated with it, that is undesired behavior.
>>
>> The boot counter configuration is implemented using three new DT 
>> properties:
>> reg - PGGS register address, fallback to PGGS 2 at 0xffd80058
>> u-boot,bootcount-reg-mask - Register mask, applied on PGGS register
>> u-boot,bootcount-mask - Boot counter mask, applied on boot counter
>> u-boot,bootcount-magic - Boot counter magic, applied on boot counter
>>
>> Example configuration of 16bit boot counter with 0xb0010000 magic in 
>> PGGS0:
>>
>> &amba {
>>     bootcount@0xffd80050 {
>>         compatible = "u-boot,bootcount-zynqmp";
>>         reg = <0 0xffd80050 0 0x4>;
>>         u-boot,bootcount-magic = <0xb0010000>;
>>         u-boot,bootcount-mask = <0xffff>;
>>         u-boot,bootcount-reg-mask = <0xffffffff>;
>>     };
>> };
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Heiko Schocher <hs@denx.de>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/bootcount/bootcount_zynqmp.c | 79 +++++++++++++++++++++++++---
>>   1 file changed, 71 insertions(+), 8 deletions(-)
> 
> Nitpick: Should there not be a change in a file where the new properties
> and the compatible entry is documented?

Do we have one ? I don't see one with git grep, but I can write one.

That said, I would very much like to get feedback from the CERN person, 
to make sure this change does not break their setup.
