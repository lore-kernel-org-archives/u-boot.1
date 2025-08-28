Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4594CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 21:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CBD18328F;
	Thu, 28 Aug 2025 23:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JLkpeaqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD32783327; Thu, 28 Aug 2025 23:44:58 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B993783192
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 23:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cCZgT5Mgfz9t3P;
 Thu, 28 Aug 2025 23:44:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756417493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZYGGU6loOG5/nR3QhyE7w6TrW1Zh4zLTbAZsOdUKrY=;
 b=JLkpeaqv2Vo64ZTFsnXS330E5vrS+/QbL/p4sVV2AxyauPH73TSqmZ0GhqTyMyLgxOKyVj
 cShIVOy3SGeHatF+hoLq4hxoJKmCjP6I8R6t3rSiTCp1nfBwTB04CENpTaJr9tnZlt6geQ
 0sYuORADqNxAJoGKuK6cjCh/56msnLIRYRmeIRs8ZvDJ2ECR1F3dPJ3iizCA49etwuX9SH
 QCpEt+8hdNkF3S55qKzl7JE3D7Ol2W7gy7gb+r++zptFU8amFkHi+OSaEflTE80BaBJflD
 MrDJ4tfDNs/BC3KbrMx9P9UkT0TaFQ3KUCIOzcgwKwpA164R26u/Pwxf5uuskQ==
Message-ID: <83fd6db4-dc76-4f5d-9abf-9673b81eea14@mailbox.org>
Date: Thu, 28 Aug 2025 23:44:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
To: Philip Oberfichtner <pro@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
 <20250807162115.GZ124814@bill-the-cat>
 <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
 <20250807201142.GC124814@bill-the-cat>
 <4813ce12-ad82-4170-999c-e5f816a42708@mailbox.org>
 <20250807232421.GD124814@bill-the-cat> <aJmuxlTEFT4R7HR_@antares>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aJmuxlTEFT4R7HR_@antares>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: edd29c5172d5152f707
X-MBO-RS-META: 5yskqo5ucwnptnhmraa8ct7ftcurejwk
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

On 8/11/25 10:50 AM, Philip Oberfichtner wrote:
> On Thu, Aug 07, 2025 at 05:24:21PM -0600, Tom Rini wrote:
>> On Fri, Aug 08, 2025 at 01:15:45AM +0200, Marek Vasut wrote:
>>> On 8/7/25 10:11 PM, Tom Rini wrote:
>>>> On Thu, Aug 07, 2025 at 09:41:34PM +0200, Marek Vasut wrote:
>>>>> On 8/7/25 6:21 PM, Tom Rini wrote:
>>>>>> On Thu, Aug 07, 2025 at 03:41:38PM +0200, Marek Vasut wrote:
>>>>>>> On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
>>>>>>>> CONFIG_HAS_BOARD_SIZE_LIMIT is obsolete, if we interpret the value
>>>>>>>> "zero" as "unlimited".
>>>>>>>
>>>>>>> This sentence makes no sense. Is the variable not obsolete if its value is
>>>>>>> non-zero ?
>>>>>>
>>>>>> This is phrased oddly, yes. How about:
>>>>>> By making the code treat a size limit of 0 as unlimited we no longer
>>>>>> need to guard asking about having a size limit on the platform.
>>>>>
>>>>> 0 shouldn't mean unlimited, that is just fragile ...
>>>>
>>>> That's a standard unix thing? ulimit -c 0 is unlimited.
>>>
>>> This is a really bad argument, because then the counter-argument is, that
>>> size = 0 is also a valid size and it shouldn't be conflated with SIZE_LIMIT
>>> validity.
>>>
>>> My take on this is, don't conflate size-limit "enabled/disabled" with
>>> size-limit "value" , these are two separate config options. Mixing them is
>>> not helping.
>>
>> I still think it's fine, but it's not worth arguing further over, and we
>> can just make sure to gate all of the symbols rather than 0-is-disabled.
> 
> The idea of treating a size limit of zero as unlimited has been common
> practice in mainline U-Boot since 2019, where CONFIG_SPL_SIZE_LIMIT has
> been introduced. The same logic has later been applied to TPL and VPL
> size limits.

That still does not make it the correct approach.

> If we want to consistently stick to the HAS_*_SIZE_LIMIT approach, we'd
> have to introduce four extra Kconfig options alongside
> HAS_BOARD_SIZE_LIMIT:
> 
> 	CONFIG_HAS_UBOOT_WITH_SPL_SIZE_LIMIT

What does this one do ?

> 	CONFIG_HAS_SPL_SIZE_LIMIT
> 	CONFIG_HAS_TPL_SIZE_LIMIT
> 	CONFIG_HAS_VPL_SIZE_LIMIT

This is fine by me.

> Furthermore, the extra lines of code in the toplevel Makefile, which
> could otherwise be removed:
> 
> 	ifneq ($(CONFIG_BOARD_SIZE_LIMIT),)
> 	BOARD_SIZE_CHECK= @ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
> 	else
> 	BOARD_SIZE_CHECK =
> 	endif
> 
> 	ifneq ($(CONFIG_HAS_UBOOT_WITH_SPL_SIZE_LIMIT),0x0)
> 	UBOOT_WITH_SPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_UBOOT_WITH_SPL_SIZE_LIMIT)
> 	else
> 	UBOOT_WITH_SPL_SIZE_CHECK =
> 	endif
> 
> 	ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
> 	SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
> 	else
> 	SPL_SIZE_CHECK =
> 	endif
> 
> 	ifneq ($(CONFIG_TPL_SIZE_LIMIT),0x0)
> 	TPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
> 	else
> 	TPL_SIZE_CHECK =
> 	endif
> 
> 	ifneq ($(CONFIG_VPL_SIZE_LIMIT),0x0)
> 	VPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_VPL_SIZE_LIMIT))
> 	else
> 	VPL_SIZE_CHECK =
> 	endif

This code is already in the U-Boot Makefile .

Maybe tools/spl_size_limit.c could be somehow extended to deduplicate 
the above ?

> Is it really worth adding this much of extra code?
Yes, because 0 does not mean unlimited .
