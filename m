Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C8DC83F13
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 22:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E37BA831BE;
	Sun, 27 Aug 2023 00:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Ry5pGbEL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g6V7dC3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85FEF8144A; Sun, 27 Aug 2023 00:18:36 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1635780B98
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 00:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RYB6b5jyrz9srs;
 Sun, 27 Aug 2023 00:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693088311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yk8T7DUjjRkboaeukdyZb337mr/LxGo6jGKdvONPAiw=;
 b=Ry5pGbELk8+9A+gsAp5oz66byiFqCgMgLhnJxfcmX9zp/lUDQ51Iqw4EKkMSHvyctkLPWV
 ActeT5Doz6ZsHqx3eW36mrfE8GcT7fNUga9EeSklC9boPbio1wD2hakLczg+uY4XKtxuEg
 v6lVpaJwBpwi78Th7wLilSgHa1t2zVzCrgng/5O0T6a/y1GVJA9h5emGJG+aFxen/ygg8l
 9M/1p//7QMcfEtfE2ldmjQN8F14ham7JN4LlFR1jhro/VcJefm+BTspv8LxcoFNpJ5TRuu
 /gLaPLr4l9Dthf0+JegmbuU/kwKCHR/ld29lM46w701XJvkTlXmYK5nCzg2t5Q==
Message-ID: <6633e897-3cad-fe6e-816a-498102b49481@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693088309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yk8T7DUjjRkboaeukdyZb337mr/LxGo6jGKdvONPAiw=;
 b=g6V7dC3qu5rEFCQG5YaSFz25+CEZS1KbU5tlyiEk9K+V51nbOTGe4xL3BbWctK9JtSCFjk
 SGB/Kp/E2hdCW+bMViNkdzMyQo7hjJ2pPOEVZk1ZQJ5YcWFaG0J/rnzYjXXdrmaIKCdhJi
 /TUeMO10LLrqlym8Oq2edY1zci0KdzN+cgPNKE/h8se7ix2A13+nTTwEfB2qLyVVM35Ug3
 92ZJ1WRUyJI7guPmFsMLZoe5ytn1Cd6exMToj7AtLyD7iRSaVXPJ2C1aV2hyM5So8UafGe
 uIHU6Ol/olsnBKw9UxssfsxntmZBgGGCINsN4ylAT1EWEfPkzbYNZPR2/xZk+g==
Date: Sun, 27 Aug 2023 00:18:26 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] serial: sh: Fix compile error when lacking HSCIF
 support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>, Simon Glass <sjg@chromium.org>
References: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
 <20230822181025.339748-2-paul.barker.ct@bp.renesas.com>
 <e6fc0067-b5bf-bbd0-57de-0f71d20d2e63@mailbox.org>
 <3aef873f-4ae7-edcc-c4a7-8a795a77802b@bp.renesas.com>
 <0e1bbf84-eb5f-c462-7372-d813c3b1f813@mailbox.org>
 <66e5acee-fc2e-c169-ce26-8792d47d5626@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <66e5acee-fc2e-c169-ce26-8792d47d5626@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d1787276c39621aca5d
X-MBO-RS-META: zj8suyktijafyfd6acubenw1pdygrthh
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

On 8/26/23 14:03, Paul Barker wrote:
> On 23/08/2023 12:22, Marek Vasut wrote:
>> On 8/23/23 08:25, Paul Barker wrote:
>>> On 22/08/2023 22:38, Marek Vasut wrote:
>>>> On 8/22/23 20:10, Paul Barker wrote:
>>>>> If we attempt to compile serial_sh.c for a system which lacks HSCIF
>>>>> support (e.g. R8A7740), we see the following compilation error:
>>>>>
>>>>>        In file included from drivers/serial/serial_sh.c:20:
>>>>>        drivers/serial/serial_sh.c: In function ‘sh_serial_init_generic’:
>>>>>        drivers/serial/serial_sh.h:429:35: warning: implicit declaration of function ‘sci_HSSRR_out’; did you mean ‘sci_SCSCR_out’? [-Wimplicit-function-declaration]
>>>>>          429 | #define sci_out(port, reg, value) sci_##reg##_out(port, value)
>>>>>              |                                   ^~~~
>>>>>        drivers/serial/serial_sh.c:62:17: note: in expansion of macro ‘sci_out’
>>>>>           62 |                 sci_out(port, HSSRR, HSSRR_SRE | HSSRR_SRCYC8);
>>>>>              |                 ^~~~~~~
>>>>>
>>>>> To fix this, only try to support access to the HSSRR register for SoCs
>>>>> where it actually exists.
>>>>>
>>>>> Fixes: bbe36e29ca2c ('serial: sh: Add HSCIF support for R-Car SoC')
>>>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>>> Cc: Hai Pham <hai.pham.ud@renesas.com>
>>>>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>> Cc: Simon Glass <sjg@chromium.org>
>>>>> ---
>>>>>     drivers/serial/serial_sh.c | 2 ++
>>>>>     1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
>>>>> index 20cda5dbe272..cd9bcf4f0a25 100644
>>>>> --- a/drivers/serial/serial_sh.c
>>>>> +++ b/drivers/serial/serial_sh.c
>>>>> @@ -58,8 +58,10 @@ static void sh_serial_init_generic(struct uart_port *port)
>>>>>     	sci_out(port, SCSPTR, 0x0003);
>>>>>     #endif
>>>>>     
>>>>> +#if defined(CONFIG_RCAR_GEN2) || defined(CONFIG_RCAR_GEN3) || defined(CONFIG_RCAR_GEN4)
>>>>
>>>> You can use CONFIG_RCAR_64 instead of GEN3+GEN4 test.
>>>
>>> I'm going to be sending patches for the RZ/G2L shortly which enables
>>> CONFIG_RCAR_64 but lacks HSCIF support. Testing for RCAR gen3/gen4 now
>>> will avoid the need to make another change here.
>>
>> The G2L has no HSCIF ?
> 
> No, it has SCIF and SCI interfaces but no HSCIF.

Ah, thanks for clarifying.
