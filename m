Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E47FEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFDF864C5;
	Wed, 23 Aug 2023 13:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Updi2158";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uKH96j57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B21864C7; Wed, 23 Aug 2023 13:22:35 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DC9864A1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RW3j56Df8z9spv;
 Wed, 23 Aug 2023 13:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692789753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hesNwN4P+jELbwkRJ7axNzXqjugnnTzwk74ThryPV8=;
 b=Updi2158CkQsF0jTIUzAxGivY5EaFzSrB8ZVMcYRKw/tZNEqFiBJqtdTS6VzCeUX23cTHf
 K1Fo7mkR7JzUSHMvghznGoXofm+nLOJCSKQyc3/tAT36QrJMc8opnjNofVxb3m1kzOkyZa
 yofzBbGEXEV0xCgvr2Mq7uHovOvLUbwrma/oLR2ahhpL/lhQpULVuI5yMQksJL3wzn1CNJ
 EmcaFF7EIencq73xHE8vmKo1alCMZGeO8qGBHsPHoIL8LpXSwvVbssqEEx+q5LU8TT9tXJ
 Kz6l/hVjWiFIk3DdLe4StLi/w4ENiTMthorgUDpNIEA2KDWEQhTopXdVaCvA+g==
Message-ID: <0e1bbf84-eb5f-c462-7372-d813c3b1f813@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692789752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hesNwN4P+jELbwkRJ7axNzXqjugnnTzwk74ThryPV8=;
 b=uKH96j571kjGWatSo5M+wEvOyMo0hyJC//rlq0+KrDjpsIe2kZheQ4NOmdrc0sT53MiGch
 vAFlfDfj4HCBJjAByLnWd/IA032SSwT4yYQCgQBOcgMAzd61nbYzisX8L7BMi1lifI/oIx
 PqT9+rXaF1IX3l9cryf/CU2rljRAlPrHvTlYzWHtshh5suJDvKGll80aOCwVCPLHUiKKzy
 ujNP+OxjhzGPV6QWnFuY+o2f8JzSgBxfYeVRINGVPX9VOc1w/nOAL5DW4vKaW1QV3Wavsx
 0zFvHy02DtzSiFdkrJ7BHA9Jd7GNeW7MAwWLODVqt2eeFLLLWpJxZpbuXGM9Lg==
Date: Wed, 23 Aug 2023 13:22:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] serial: sh: Fix compile error when lacking HSCIF
 support
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>, Simon Glass <sjg@chromium.org>
References: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
 <20230822181025.339748-2-paul.barker.ct@bp.renesas.com>
 <e6fc0067-b5bf-bbd0-57de-0f71d20d2e63@mailbox.org>
 <3aef873f-4ae7-edcc-c4a7-8a795a77802b@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3aef873f-4ae7-edcc-c4a7-8a795a77802b@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e88f4cee3e09e61b2a3
X-MBO-RS-META: axpoh7rwfccn46sauo9ojixgpuymkmjs
X-Rspamd-Queue-Id: 4RW3j56Df8z9spv
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

On 8/23/23 08:25, Paul Barker wrote:
> On 22/08/2023 22:38, Marek Vasut wrote:
>> On 8/22/23 20:10, Paul Barker wrote:
>>> If we attempt to compile serial_sh.c for a system which lacks HSCIF
>>> support (e.g. R8A7740), we see the following compilation error:
>>>
>>>       In file included from drivers/serial/serial_sh.c:20:
>>>       drivers/serial/serial_sh.c: In function ‘sh_serial_init_generic’:
>>>       drivers/serial/serial_sh.h:429:35: warning: implicit declaration of function ‘sci_HSSRR_out’; did you mean ‘sci_SCSCR_out’? [-Wimplicit-function-declaration]
>>>         429 | #define sci_out(port, reg, value) sci_##reg##_out(port, value)
>>>             |                                   ^~~~
>>>       drivers/serial/serial_sh.c:62:17: note: in expansion of macro ‘sci_out’
>>>          62 |                 sci_out(port, HSSRR, HSSRR_SRE | HSSRR_SRCYC8);
>>>             |                 ^~~~~~~
>>>
>>> To fix this, only try to support access to the HSSRR register for SoCs
>>> where it actually exists.
>>>
>>> Fixes: bbe36e29ca2c ('serial: sh: Add HSCIF support for R-Car SoC')
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> Cc: Hai Pham <hai.pham.ud@renesas.com>
>>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> ---
>>>    drivers/serial/serial_sh.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
>>> index 20cda5dbe272..cd9bcf4f0a25 100644
>>> --- a/drivers/serial/serial_sh.c
>>> +++ b/drivers/serial/serial_sh.c
>>> @@ -58,8 +58,10 @@ static void sh_serial_init_generic(struct uart_port *port)
>>>    	sci_out(port, SCSPTR, 0x0003);
>>>    #endif
>>>    
>>> +#if defined(CONFIG_RCAR_GEN2) || defined(CONFIG_RCAR_GEN3) || defined(CONFIG_RCAR_GEN4)
>>
>> You can use CONFIG_RCAR_64 instead of GEN3+GEN4 test.
> 
> I'm going to be sending patches for the RZ/G2L shortly which enables
> CONFIG_RCAR_64 but lacks HSCIF support. Testing for RCAR gen3/gen4 now
> will avoid the need to make another change here.

The G2L has no HSCIF ?
