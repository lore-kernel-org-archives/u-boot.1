Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7FEE7B5F9
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1624874CC;
	Wed,  4 Oct 2023 14:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bNhD6HDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31169874FC; Wed,  4 Oct 2023 14:12:29 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DEE86501
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4S0tqC3RKJz9sm9;
 Wed,  4 Oct 2023 14:12:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696421543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jQVFUtmRhu6jiaIDntP4GyIxbsxgDZEG0MjeT97kWJ4=;
 b=bNhD6HDknfPsYwp7i6awrhqFa93eMo2A19H7nBtblwk89664yDsDM/GAVQjj5yug4M/vIc
 bZVyHuYz5IGn5uPIa6V3eRhFtMxw0zAnSIISm60kLZMXvCgXc8WRTKDeNhEQsTjve1tyX3
 r2X3ls5MVcg4pGbTwDuA+UDLiydZwOGKTYJnDEIsn5AEOMtUqZ7u2yncji5P9sNiSkNqhz
 Kf1QdEVuZesM1v8R8IXivVpT+EVs08SKEHQUTUzcQwTKQG8DU/lyfmJHG0OFA/Zgh52YgY
 SB/GC5JrtfzPLtykbDjGd1jnuAJQJ9lmgyvDLumRSkdWPEggSZn4MplNzv0E2A==
Message-ID: <bf79d1d4-d4c4-4df8-afdc-ba2d42696e23@mailbox.org>
Date: Wed, 4 Oct 2023 14:12:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 01/16] serial: sh: Fix compile error when lacking HSCIF
 support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Simon Glass <sjg@chromium.org>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-2-paul.barker.ct@bp.renesas.com>
 <ce466f52-f91d-9fb9-fe18-b58cefac5b20@mailbox.org>
 <0f9a468b-a0c9-004c-6428-5d471ca667c8@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0f9a468b-a0c9-004c-6428-5d471ca667c8@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 65eb7c9c84271fc4cca
X-MBO-RS-META: m7438upp1wsggy5neggykxwit44y1jr5
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

On 10/4/23 09:49, Paul Barker wrote:
> On 03/10/2023 13:42, Marek Vasut wrote:
>> On 9/20/23 14:41, Paul Barker wrote:
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
>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> Cc: Hai Pham <hai.pham.ud@renesas.com>
>>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> ---
>>>    drivers/serial/serial_sh.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
>>> index 20cda5dbe272..5e543dbf3d58 100644
>>> --- a/drivers/serial/serial_sh.c
>>> +++ b/drivers/serial/serial_sh.c
>>> @@ -58,8 +58,10 @@ static void sh_serial_init_generic(struct uart_port *port)
>>>    	sci_out(port, SCSPTR, 0x0003);
>>>    #endif
>>>    
>>> +#if IS_ENABLED(CONFIG_RCAR_GEN2) || IS_ENABLED(CONFIG_RCAR_GEN3) || IS_ENABLED(CONFIG_RCAR_GEN4)
>>
>> There should be CONFIG_RCAR_64 for GEN3+GEN4, please use it.
> 
> In patch 5 of this series I add CONFIG_RZG2L, which selects
> CONFIG_RCAR_64 but doesn't have HSCIF support.
> 
> An alternative would be to use this here:
> 
>      #if IS_ENABLED(CONFIG_RCAR_GEN2) || IS_ENABLED(CONFIG_RCAR_64)
> 
> Then in patch 5 modify it to
> 
>      #if IS_ENABLED(CONFIG_RCAR_GEN2) || IS_ENABLED(CONFIG_RCAR_64) &&
> !IS_ENABLED(CONFIG_RZG2L)
> 
> I don't have any strong preference on which one to use.

I think, just keep the patch as-is and note the reason for not using 
RCAR_64 in the commit message (G2L has no HSCIF).
