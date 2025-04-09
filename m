Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B383C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 11:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74265836A8;
	Wed,  9 Apr 2025 13:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xa04EIFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7657F836A8; Wed,  9 Apr 2025 13:59:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8773B8363B
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 13:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf1=W3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744199940;
 bh=dBgyFT/LrPImkJkCAS0bB9XC2pw7CEOrzC/l3D8hQZs=;
 b=xa04EIFcQ3a4jkqdvep6LGd9m7LafKPh9ILTBGK7gmmlvIPhY6fs50HOs4b5MlXdFgUDRK/IJ
 fyuzOSkSnlCouq9cdPmSHOyERaTQevkexRZQlfO17/aOvmhsmSFuVUQAZiPzVoVf545DSzegMWE
 hT+dYjbEZ2J+HKEP79lQOMYEGMGdT9ui9HyVhm5qjiU+3YUlI9/E+zoxipSZK2Mn38kPo4KDzbU
 nPDh1mqJRS5oRADwP3G4m7iNo/du20GyhpuAYTYLOWup+sHFGQJO2TLZbsXoKGpFCvvyrAO2LXu
 Kv2g64vMIhI28f+/2wVhwOk1AuNh7Fd0h3V1ejvgqNiA==
X-Forward-Email-ID: 67f6610202fba845dcdf2ed2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <929feec1-413a-4d48-9664-f2bf75360a81@kwiboo.se>
Date: Wed, 9 Apr 2025 13:58:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] rockchip: binman: Create a template for the FIT
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-5-jonas@kwiboo.se>
 <d7bd61f0-40a5-4fde-9e47-529cbac28a94@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d7bd61f0-40a5-4fde-9e47-529cbac28a94@cherry.de>
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

Hi Quentin,

On 2025-04-09 11:39, Quentin Schulz wrote:
> Hi Jonas, Simon,
> 
> On 3/29/25 4:06 PM, Jonas Karlman wrote:
> [...]
>> -#if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
>> +#ifdef HAS_FIT
>>   		fit {
>>   			type = "blob";
>>   			filename = "u-boot.itb";
> 
> Use the template for the SPI here already instead of splitting it in a 
> separate commit?

I think the original patches was more involved, so I may have requested
a split. Could possible merge them in a v5.

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin
> 

