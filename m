Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A946C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 11:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E487C8118A;
	Fri, 28 Feb 2025 12:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="b9+GrrFO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HT9M/9zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF928118B; Fri, 28 Feb 2025 12:08:35 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E7AF810EB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z456n2Xs4z9sWt;
 Fri, 28 Feb 2025 12:08:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740740913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRtgmYkoRe5E402rX1QE2wSHJyTfgjMVavBv9W2mPpY=;
 b=b9+GrrFO6XlOGpCLvO93a85ehg2Krj7z4BVS1A7cnIkXxbtv8pmm7QqRa+C+njb/fkky/S
 GnLbZB9BBRan0clAT8jBlBWmsvyf9rDkM49bh2p8Ll8imDFZ6hWLa6CONj/YgiZKXGwahJ
 oYw8kCZzO9qU5z3lBYdo18JVJ3Amx365K4ciKj+lAfEwkG/jOtkxvFcpDGSe2EoXcWPx01
 jhhKMMgB475G77E+AygY917LSYwW0jrn28TgOdpUrRSYqY2ejbUOmDlP8e2LqiLOup/uCP
 IYDPZQxOdQord5Z2ItWn/Drc6WcGVFd1CgTq7kKi5RwN8fTSSZVW/Vh1qEL2XQ==
Message-ID: <dd24dc78-8e4c-4e23-8afc-8c5318e988f3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740740911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BRtgmYkoRe5E402rX1QE2wSHJyTfgjMVavBv9W2mPpY=;
 b=HT9M/9zrcpe1GtfderymtIFNct73A1SGV8ZkJ/nEG7ep2BeHnvvu2cKu4H8d97Gy1w7CMf
 Rj9st0hiFlep96dGEg7ohvuPdxlLIw7D/jKCJfacIcD09xOexMdcegrRP0Hu+OwEQOOy+i
 BDYqfxLiX2LaJ4eSR2cYFtpezp21VHNwFyQTaAiEpqwlC+hk0Iq8dkaieKTEJlFWD61CzZ
 vhPMdl5O8tdgXqpCwD+rPIJAMR4iWhFm+sR1a53bJsqAxI9VLEGE9z/bNTYdoXZc2QjMGm
 IkyDPmBLJOErbeL9WovjZNnCUIC7f1O5jNsXjorZZg20VRqt5pURwOsiPgMmyQ==
Date: Fri, 28 Feb 2025 12:08:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] pinctrl: renesas: Fix RZN1 symbol name
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
References: <20250227234335.157217-1-marek.vasut+renesas@mailbox.org>
 <91e5b433-7001-4ddc-a613-9c98b1045ea9@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <91e5b433-7001-4ddc-a613-9c98b1045ea9@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jf44nydxpcmr5k5r8zb68pasjnmgowdk
X-MBO-RS-ID: 820987ca4c44741099e
X-Rspamd-Queue-Id: 4Z456n2Xs4z9sWt
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

On 2/28/25 11:26 AM, Paul Barker wrote:
> On 27/02/2025 23:43, Marek Vasut wrote:
>> The RZN1 symbol name is CONFIG_RZN1, there is no CONFIG_ARCH_RZN1.
>> Fix the symbol name so the pinctrl driver for RZN1 gets build.
>>
>> Fixes: e4aea57fa773 ("pinctrl: renesas: add R906G032 driver")
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/pinctrl/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
>> index 634047a91f4..0d5798b0634 100644
>> --- a/drivers/pinctrl/Makefile
>> +++ b/drivers/pinctrl/Makefile
>> @@ -15,7 +15,7 @@ obj-$(CONFIG_ARCH_MTMIPS) += mtmips/
>>   obj-$(CONFIG_ARCH_NPCM)         += nuvoton/
>>   obj-$(CONFIG_PINCTRL_QCOM) += qcom/
>>   obj-$(CONFIG_ARCH_RENESAS) += renesas/
>> -obj-$(CONFIG_ARCH_RZN1) += renesas/
>> +obj-$(CONFIG_RZN1) += renesas/
> 
> I'm a bit confused by this one.
> 
> In arch/arm/mach-renesas/Kconfig, config RZN1 is behind an 'if
> ARCH_RENESAS' condition. So if CONFIG_RZN1 is set, shouldn't
> CONFIG_ARCH_RENESAS also be set?
Oh, good point, it is set. I was under the impression RZN does not set 
ARCH_RENESAS, but it seems it does. Let me prepare a V2.
