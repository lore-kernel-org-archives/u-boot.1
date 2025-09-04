Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5F3CA1002
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 15:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDA3E83865;
	Thu,  4 Sep 2025 17:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bkE3Bchf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B10B8809A5; Thu,  4 Sep 2025 17:05:10 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA4048386D
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 17:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cHjSv4Dcsz9tR0;
 Thu,  4 Sep 2025 17:05:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756998303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EnX5K//hBlHNPl/KqAsTiFks0GhmImJABIltURQeW4A=;
 b=bkE3BchfVVBJOT8AkKbE9kS2Ok4hOGbVkPmg1raf1CDIihnvx+cUI4rUA1ZT8WpPmqTKvJ
 vMvy/Ag2UsVixQY5Ap6ijBY8D8eDVgzjmlMfICo9UEnILEBKA+wuggag3//Dx5bFCW14R9
 BBBYyLQhHakupGRSeQZb15vejl2LTVLUMaMJQxrBz9eieEWVnox9oePjAdCZl9Aq7ZbVLX
 mJ7EVv1IWHnk0QdWYw8q7odefKRXQIt74V4sclGKHwPjRXtSF1JKGmhMrhBw224uufyT5C
 7aOo2pzIc9+QAeXMR5CqNV28493XAiSJO+qSwpyde9nvvCOaPBzvZRxmiL1F8g==
Message-ID: <99ad1032-3048-4e4b-bd4a-91dc2a20c2d5@mailbox.org>
Date: Thu, 4 Sep 2025 17:03:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/5] Image size checks: Deduplicate Makefile
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-5-pro@denx.de>
 <937b1be4-68cc-4853-94e5-2f14cbcef194@mailbox.org>
 <aLlOG9of7r4sdLok@aristophanes>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aLlOG9of7r4sdLok@aristophanes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mnix1eyh3e3pp4onkqcs6tomwjrpsho6
X-MBO-RS-ID: 33bfdaabc5ffc35001c
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

On 9/4/25 10:30 AM, Philip Oberfichtner wrote:
> On Wed, Sep 03, 2025 at 03:02:20PM +0200, Marek Vasut wrote:
>> On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
>>> Deduplicate some redundancies within the SIZE_CHECK code in the toplevel
>>> Makefile. No functional changes.
>>>
>>> Note: To make this work for the special case of SPL, spl_size_limit.c
>>> has to print an empty string "" instead of zero when there is no size
>>> limit in place.
>>>
>>> Signed-off-by: Philip Oberfichtner <pro@denx.de>
>>> ---
>>>    Makefile               | 45 +++++++++++-------------------------------
>>>    tools/spl_size_limit.c |  4 ++--
>>>    2 files changed, 13 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index a17d8b57196..b6f01591ee9 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -428,8 +428,9 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>>>    # Check ths size of a binary:
>>>    # Args:
>>>    #   $1: File to check
>>> -#   #2: Size limit in bytes (decimal or 0xhex)
>>> +#   #2: Size limit in bytes (decimal or 0xhex), always return OK if undefined
>>
>> You should be able to use the HAS_ variables to correctly test for and
>> handle the undefined case .
> 
> In general, I agree. But this would mean to reintroduce the multiply
> duplicated Makefile bloat à la:
> 
> 	ifeq ($(CONFIG_HAS_BOARD_SIZE_LIMIT),y)
> 	BOARD_SIZE_CHECK= @ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
> 	else
> 	BOARD_SIZE_CHECK =
> 	endif
> 
> 
> That's why after all I preferred my "test -z" solution. Is there maybe
> a third way I am missing out on?
> 
> What do you think about giving size_check another argument, i.e.
> call size_check,$@,$(CONFIG_HAS_BOARD_SIZE_LIMIT),$(CONFIG_BOARD_SIZE_LIMIT)
This could be an option , yes .
