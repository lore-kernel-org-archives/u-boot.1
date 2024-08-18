Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABE4C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 20:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE8618785E;
	Sun, 18 Aug 2024 22:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fHVDZJNP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xp+GuMRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 296F28708B; Sun, 18 Aug 2024 22:06:50 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 422C787CF8
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 22:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wn6FM74y4z9sl9;
 Sun, 18 Aug 2024 22:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724011608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PUr5AbxkML1acysXCOcdsQOn4vPlKVymEwrWd3GGza4=;
 b=fHVDZJNPt12GZisE1X3vxn6TSo8nvyev5C/v8wr6rnIOgRqKKvEF+SGBAYoIBOzFKHdJNL
 Evn/TV6uHZmhB29b3vsk1LDEE2WhjSImsxWlElwIw5AZsMz9C9B5Bknfno4haHhim1i+uI
 746YpHAiAiFZCyBh48N+hscPEj9T9EIhjYHbHVt2BPQHjuWHxSBdNwP3TkUaURek29IWLb
 MLQo3NEKd9unu4fRIyVvS8pl7hCvDqrAB+Iz1yuvcQRwbNwTJ5kOM+fix25+6JY79gbnlv
 n3IvV47j9jmiLq0duLawXZz3znUSDfUCg157CFfVAkk1LP0XiiK2a3lieJZ3OQ==
Message-ID: <b54bbe9e-ab67-4dda-bd43-9ab945db1468@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724011606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PUr5AbxkML1acysXCOcdsQOn4vPlKVymEwrWd3GGza4=;
 b=Xp+GuMRESFeZaLsM1EgX0lEbBX5uZ8hQ6lNew67zC0To96OBZqsMPfmTksi4SxqChp5FVY
 F0VFZpbZ/CL0EE0iglG8T4FjUhVEkQAmSQVJe9fEnpdyopF1Hbly+prXrsgJJnwo9ob3FL
 xHBrQwuS542RipnulCBd8wFIGTdEWqllNV1xsuvoZd+UZUCiRpLeFEuP+AOS9zHPrk1Exx
 2aq3TqWoJixjrB0fC3hPCy8dVMtsYHZPaKXxep4KriByQr+MX3ExWeX6SCnLOKnC/Pvjs/
 a+7Uot92R3maSt2mdjMoqwpLOLLgFxEniJfsvYjzdqLRyc87e3P59MayeYoPQg==
Date: Sun, 18 Aug 2024 22:06:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] net: phy: Replace PHY_ANEG_TIMEOUT with Kconfig symbol
To: Francesco Dolcini <francesco@dolcini.it>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
 <20240531164733.192105-2-marek.vasut+renesas@mailbox.org>
 <20240601092154.GA4383@francesco-nb>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240601092154.GA4383@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ub1fcet6f6shosq6om7cnsdr4tennt6t
X-MBO-RS-ID: 24f67378987891bb572
X-Rspamd-Queue-Id: 4Wn6FM74y4z9sl9
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

On 6/1/24 11:21 AM, Francesco Dolcini wrote:
> Hello Marek,

Hello Francesco,

> On Fri, May 31, 2024 at 06:47:17PM +0200, Marek Vasut wrote:
>> Switch PHY_ANEG_TIMEOUT to CONFIG_PHY_ANEG_TIMEOUT Kconfig symbol.
>> This removes one more configuration headers option finalizes its
>> Kconfig symbol conversion. No functional change expected.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
> ...
> 
>> diff --git a/include/configs/apalis_imx6.h b/include/configs/apalis_imx6.h
>> index 0df3917e200..6fd43511ee4 100644
>> --- a/include/configs/apalis_imx6.h
>> +++ b/include/configs/apalis_imx6.h
>> @@ -22,7 +22,6 @@
>>   #define CFG_SYS_FSL_USDHC_NUM	3
>>   
>>   /* Network */
>> -#define PHY_ANEG_TIMEOUT		15000 /* PHY needs longer aneg time */
> 
> You should remove also the line before, after removing the define it's
> just a stale comment.
> 
>> diff --git a/include/configs/ds414.h b/include/configs/ds414.h
>> index 9446acba792..f1921dac5e7 100644
>> --- a/include/configs/ds414.h
>> +++ b/include/configs/ds414.h
>> @@ -55,6 +55,5 @@
>>   
>>   
>>   /* increase autoneg timeout, my NIC sucks */
>> -#define PHY_ANEG_TIMEOUT	16000
> 
> same here.

I hope those should all be fixed now.
