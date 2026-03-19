Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB301088E77
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 04:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A023D83AAB;
	Thu, 19 Mar 2026 05:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x3SLjQ7G";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TrSLASRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501E883C51; Thu, 19 Mar 2026 05:41:57 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 705F783B03
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 05:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fbtMQ0Dhtz9vBF;
 Thu, 19 Mar 2026 05:41:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773895314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Y1U/jSs2f6UiJdrCxIEUARASAsRrCw78Nw60oRNvW4=;
 b=x3SLjQ7GFXcsYR9rh85Gif4O9Lvdtc4xQLSkSuQd0YZGmeYh5B6bWCeZIX5JNyroNNfhI+
 79FXszyxck99p/bKA0goGzAoDRWURqG7yvlokhhzmEtl73wwtJhHyyt6fzZVBI9xvpBsl3
 EZE0Sp+0oH/y3qv3ickFFajABEIycScDXP3tMlNBYn5cdf7M5EBECoulx0b31sWwCEk5AT
 CoyFWCLXTUdJ0vn3KK2k1XZQtWOmlFWeDKQ4CU4EKnfY1a+9qSWSg81MjMTdLCoo4stnmO
 X5mgbyuQtmHiNTJ9TJ6HDi1pqvctJ1AZ6CFWdpIoZwnbPqIQ6dZpW+KWaVOCrg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TrSLASRK;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <bf3bb11e-e891-4703-ad47-04d53e21d7af@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773895312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Y1U/jSs2f6UiJdrCxIEUARASAsRrCw78Nw60oRNvW4=;
 b=TrSLASRKmocdBdVrWkV20kt0GpbCrpLSs6doueXUxeVnuqOGrRnP3rgn9L499QOcCGjVlC
 k3x7z8jCSVXHPkYLX5egMUG3LGNUda3Bql7lj5nfaQOhWsP8Smw+vzTFpRbwV1LyHGiLdY
 90+VRNFpZfLeN4TXFa+tAv0jsDY4K9C7hve2Yo5+QYKxLeyi42YfbxamqFrqEiRO4VKWQb
 p+L8GbN6eZjb1DDyhWv4L2ysUZa/xSisB+m1vGa428Mzbu1WlMUcKq7/1xGd/k20nRnCx2
 fnsLryQfiZz6BsijHyaVtsN51FpLCSjaZZj8mFFs5YdxvHaobD0D0uDTt4N7+g==
Date: Thu, 19 Mar 2026 01:50:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly
 more visible
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <bcaede64-7918-4eaf-9695-a155b1395e50@mailbox.org>
 <20260317134107.GR502704@bill-the-cat>
 <bbdd71c7-3276-402e-a9f8-98afffd10538@mailbox.org>
 <20260318012649.GG502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260318012649.GG502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9aapiwp3ukkx99wpak91x7uc8im8addz
X-MBO-RS-ID: 98a99650e0f817f4921
X-Rspamd-Queue-Id: 4fbtMQ0Dhtz9vBF
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

On 3/18/26 2:26 AM, Tom Rini wrote:
> On Tue, Mar 17, 2026 at 08:42:06PM +0100, Marek Vasut wrote:
>> On 3/17/26 2:41 PM, Tom Rini wrote:
>>> On Tue, Mar 17, 2026 at 03:34:36AM +0100, Marek Vasut wrote:
>>>> On 3/17/26 2:24 AM, Tom Rini wrote:
>>>>> As exposed by "make randconfig", we have an issue around
>>>>> USB_GADGET_DUALSPEED. It is possible to select this symbol (via
>>>>> SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency. As
>>>>> this is a hidden symbol, move it up within the menu.
>>>> What is the issue this is fixing ?
>>>
>>> Valid configs causing the kconfig part of the build system to note
>>> unmet dependencies.
>> Lemme rephrase, is this actually a fix, or is this some readability/ordering
>> improvement patch ?
> 
> Yes, it's a fix because randconfig finds problems that users may stumble
> on to while trying to make a valid config for a platform.

Is the commit message telling me, that "config USB_GADGET_DUALSPEED" is 
moved outside of the "if USB_GADGET" block ?

Because if this is something else, and the symbols are simply reordered, 
that I do not understand how this could be fixing anything.
