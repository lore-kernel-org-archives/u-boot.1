Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EF1D637B3
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 21:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E192E8392C;
	Tue, 16 Dec 2025 22:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="GulFiqzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A26F83984; Tue, 16 Dec 2025 18:08:27 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555268309A
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 18:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0C19326390;
 Tue, 16 Dec 2025 18:08:25 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ppHaNxCA5AO; Tue, 16 Dec 2025 18:08:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1765904904; bh=zW8UZ50F4K6mpSebHxJkyXgzfWL+PMgvIABkOEb1ZpI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=GulFiqzh9io5t008uxhaD08dniXm7M+7lsQ8EY+E0fyO9ypcEyI6xFR9UAfAuT0p5
 1werfYB5CW2Vnu2d7Hn+c2aAQ3Id9QJVl9wflU9PzkBefLyx8EvpPF0jgcSLxDFz29
 1WPrFDSTOZnEpDoLMZaDUchlFER6K1wtvAks4qEqP44x5KqUQeX9CjYxBUUJXw4QRq
 DA0qj2zTwu6kiDys30CqeSBcJBwO2QOx35lDx4Z8CWWRaCgOajI8rxyMImhVsOqrob
 bYd+lhZm9DmVKtz9xx1KRiFj3sdDeBPfA7vbQiDTb/1zC/5DizStdVCqDwSegE+nIt
 fIQpWEHHPS5Dw==
MIME-Version: 1.0
Date: Tue, 16 Dec 2025 17:08:24 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Jonas
 Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, Minkyu
 Kang <mk7.kang@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 2/2] usb: dwc3-generic: add support for exynos7870
In-Reply-To: <89608e43-92ab-41e1-b5c3-79ca01f0360f@mailbox.org>
References: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
 <20251017-usb-dwc3-exynos7870-v1-2-fe46e2ed1908@disroot.org>
 <89608e43-92ab-41e1-b5c3-79ca01f0360f@mailbox.org>
Message-ID: <8ab651a86f646035edfa06f7e79e45b1@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 22:20:31 +0100
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

On 2025-12-16 11:13, Marek Vasut wrote:
> On 10/17/25 5:30 PM, Kaustabh Chakraborty wrote:
>> Exynos7870's DWC3 glue layer is quite simple, consisting of a few
>> clocks, which is handled by this driver. Add the compatible string in
>> here.
>> 
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>   drivers/usb/dwc3/dwc3-generic.c | 1 +
>>   1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>> index 1967594f48ab40963463e6f17ed58ec45ce5867c..622847a9daf8e3c5cba4e4a9414b50e8a050df55 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -710,6 +710,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>>   	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>>   	{ .compatible = "fsl,imx8mq-dwc3" },
>>   	{ .compatible = "intel,tangier-dwc3" },
>> +	{ .compatible = "samsung,exynos7870-dwusb3" },
>>   	{ .compatible = "samsung,exynos850-dwusb3" },
> Please keep the list sorted.

This is... already sorted?
