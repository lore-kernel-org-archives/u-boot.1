Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A585E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 19:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A8F80725;
	Mon, 23 Dec 2024 20:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MjC6nR8G";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iBx6qWEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 633E880741; Mon, 23 Dec 2024 20:49:47 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C5E80708
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 20:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YH7s46VXMz9snn;
 Mon, 23 Dec 2024 20:49:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734983384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ckx2D3FRpX2HbwCXvjg1Hjq4d16pttQj0AQdhZpQQg=;
 b=MjC6nR8G3vgxpfFprO7RIifY4GSzUXq71EXKHIcE7Rmyu57fKJeMoUyqFfrx0qOk5RhEi8
 F/PRyXT6CC3IKKlo0tG/KcW/GfLW6hOaBgNoCruV7cd0dzZMwcNYj3qM3GnC1GNyxM/XkK
 0zbUgC1hx7ZTwHdRKhDEKLW2S1x82ajap5r04Y1e9t1QY+MnkAzoGHgjhjha/pFlnfYYiS
 yMPFIoGu1boNSyQ8GL85Evgaxmyd03jCkCDIwOea/HzbvlH+cOZDEEawtetkq4e+MSfFb5
 O9ehn4DojovVRLsRInXkGTN+EtYwH+WPbNPtfDO8IyTvcpzdmbEekHNn4mciyQ==
Message-ID: <4165a5d4-da42-41fe-98c8-39db4b601457@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734983383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ckx2D3FRpX2HbwCXvjg1Hjq4d16pttQj0AQdhZpQQg=;
 b=iBx6qWEKPdZS1A6pMStda40+on41S/wOtb2IfNGvKz9YI1bnOyqc4mHhHng/dGL0bEBkEL
 PPR7mFfcpEIYfjH7NiJjgygup6lp2Ohap7vmeGtH9SeE5gA5blsR0pRtk80iE72qQXKRhV
 kK3pkKw5k5QFgmJ9NWJz5lWCNP0QfnLnukuby89EWJFB4uBA/KhLixvZqtFlyCZoSNUKVl
 lb49O4uSRTx/DzqIBzQJFTdrZN+zMgRF+2fNWRGC3DaiFtIoI/viz05hV4paqQl1ZeeBSy
 zGrC0FgpICXui5LhJYeMMS9mKq+lCTbzC646EwFFs9kuDIKnGqtyHD2CYwpwEA==
Date: Mon, 23 Dec 2024 20:45:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 01/16] pinctrl: renesas: Add Kconfig symbol for
 conditional build of full PFC tables
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
References: <20241221213443.115024-1-marek.vasut+renesas@mailbox.org>
 <20241221234701.GP1505244@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241221234701.GP1505244@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 58d304cf0015c30a91c
X-MBO-RS-META: ksa5r5n7e8z9xb47sr7itmzhk5u7uwnc
X-Rspamd-Queue-Id: 4YH7s46VXMz9snn
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

On 12/22/24 12:47 AM, Tom Rini wrote:
> On Sat, Dec 21, 2024 at 10:34:00PM +0100, Marek Vasut wrote:
> 
>> By default the pin multiplexing tables used by U-Boot are reduced
>> to keep the size of the bootloader low. This option allows build of
>> full pin multiplexing tables the same way they are included in the
>> Linux kernel. This includes pin multiplexing options for Audio, CAN,
>> CANFD, DU, INTC, INTC-EX, MSIOF, PWM, SSI, for which there is no
>> U-Boot driver. This option is disabled by default.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> [snip]
>> +config PINCTRL_PFC_FULL
>> +	bool "Renesas pin control drivers (full size)"
>> +	depends on PINCTRL_PFC
>> +	default n
> 
> The "default n" is the default when there's no default keyword. Please
> drop when applying, assuming no other changes are requested, thanks!
Fixed in V2, thanks !
