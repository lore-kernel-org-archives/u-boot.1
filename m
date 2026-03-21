Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A955B1075269
	for <u-boot@archiver.kernel.org>; Sat, 21 Mar 2026 02:41:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C90A8403D;
	Sat, 21 Mar 2026 03:41:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nnx+gKgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C8BB83D71; Sat, 21 Mar 2026 03:40:55 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439FB84010
 for <u-boot@lists.denx.de>; Sat, 21 Mar 2026 03:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fd3Zq47KHz9v5q;
 Sat, 21 Mar 2026 03:40:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774060851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7/hCa7NePYBNgmP7gZN+FyHSynqxpIja1bxBAU/9Ao=;
 b=nnx+gKgRsXljNCzQvsD95oKnIH5NpfNQKYq4qOEb6WtJIcnHnSCnZqMD+4b7MbweHfplop
 js1135WHIiRVTHh2dLX5Ok8j751FXFNPQLa0QkofHqj/oUTCbcLeWk3G8PEZ5nUrDMCzqY
 FuImhi5+fiFTdreB+6eDimjX4RnJqPWupUY3ebPJt5Z2g5HKfK0twrZqMxNfUs1v03xM9h
 S6PwzWvAnnVikvuItsxEvEegxWG8WWVwTgkW3X6jU/+b80RteKyRJr3V5LN4r44nohMWT0
 EkHKEm5w7yBuPAvCNfHuuRivM4PGM0Uf1KM7JFi/2V+KxWnkdXf5ZeE0N/I4qw==
Message-ID: <2446be00-c67d-4dd7-b45c-da3925b23cd0@mailbox.org>
Date: Sat, 21 Mar 2026 03:23:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260317012443.4162600-1-trini@konsulko.com>
 <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
 <20260317134008.GQ502704@bill-the-cat>
 <58699be1-5414-4749-9975-7fdf0064b1a3@mailbox.org>
 <20260318012557.GF502704@bill-the-cat>
 <34a0c151-f8ff-4b91-92b3-d6f63097440e@mailbox.org>
 <20260319134128.GP502704@bill-the-cat>
 <11128ed2-a53d-4286-84cc-dc5c6d932405@mailbox.org>
 <20260320135616.GY502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260320135616.GY502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: oqkki58h3igqxuohh48ftbhdkpfnthq5
X-MBO-RS-ID: 51c4849a7a03306b6bf
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

On 3/20/26 2:56 PM, Tom Rini wrote:
> On Fri, Mar 20, 2026 at 04:58:13AM +0100, Marek Vasut wrote:
>> On 3/19/26 2:41 PM, Tom Rini wrote:
>>
>> [...]
>>
>>>>> So I think the answer is if you fire up menuconfig, and turn off
>>>>> RESET_RZG2L_USBPHY_CTRL and REGULATOR_RZG2L_USBPHY and DM_REGULATOR and
>>>>> then enable RESET_RZG2L_USBPHY_CTRL things will become mad because
>>>>> RESET_RZG2L_USBPHY_CTRL has select'd REGULATOR_RZG2L_USBPHY but we don't
>>>>> have DM_REGULATOR.
>>>> How is it possible to enable RESET_RZG2L_USBPHY_CTRL without enabling its
>>>> dependencies ? This is what I do not understand.
>>>
>>> The way I said in the part you quoted? If you don't like the way I'm
>>> solving the problem with the dependency graph here please propose an
>>> alternate. But it is possible to encounter this problem, or randconfig
>>> wouldn't expose it.
>> What I do not understand is, how is it possible to enable Kconfig symbol
>> without enabling its dependencies. Is that a bug in Kconfig ?
> 
> There is nothing ensuring that when you enable RESET_RZG2L_USBPHY_CTRL
> today that DM_REGULATOR is enabled. But since you're telling it to
> select REGULATOR_RZG2L_USBPHY it then will give an error.
Hmmm, I see it now. If I have both CONFIG_REGULATOR_RZG2L_USBPHY=y and 
CONFIG_RESET_RZG2L_USBPHY_CTRL=y in .config, and I delete 
CONFIG_DM_REGULATOR=y from .config , then I can select 
CONFIG_DM_REGULATOR=n .

But isn't the right fix the elimination of 'select' ? Linux Kconfig 
documentation now hints that 'select' should only be used for hidden 
symbols. So how about this fix instead , that should retain the 
transitive dependency on REGULATOR_RZG2L_USBPHY , which depends on 
DM_REGULATOR :

"
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2fd91d6299c..a7acd5cfa69 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -239,8 +239,7 @@ config RESET_AT91

  config RESET_RZG2L_USBPHY_CTRL
         bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
-       depends on DM_RESET
-       select REGULATOR_RZG2L_USBPHY
+       depends on DM_RESET && REGULATOR_RZG2L_USBPHY
         help
           Enable support for controlling USB 2.0 PHY resets on the Renesas
           RZ/G2L SoC. This is required for USB 2.0 functionality to 
work on this
"
