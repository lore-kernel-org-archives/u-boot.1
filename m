Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B68CCDE004
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 05:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B126283E8E;
	Fri, 14 Nov 2025 06:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cbuETYZM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jXDRxyhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BBF583EAC; Fri, 14 Nov 2025 06:17:34 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36AD283E83
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d754C6kpcz9v4c;
 Fri, 14 Nov 2025 06:17:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763097452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6CspUaAq9CqCrRhA0/zrkY86hcqt/cVC1GnTgUj3Bc=;
 b=cbuETYZMig5BrVeYDIDlZwYUm2QGSY3GQmeV4hmB7Jar7cgL+gs0Hp81J65BTH7UyG8q1l
 a5ZAQLuTfgkWwM0Fpt5iG3diL/4vRFuEybT9GdSIi8rJvFzgTQWvIz6LRjP7nlKgjwIU5W
 cRSBKBEvCtkQLVzK+3CWLJVvSKCusTL8M12PlStQIcnmZwTRMhZ6+7vt9kD0qgDzr4ESR6
 xueyVV3yk6iI+dW43hcZubfO47jz0BYn1hDGalweczHH81BMlBMV49CE1JCg+KisWw8uon
 nqEfAicftl4JGQV6Hu7msox9MLKWeXIDEySvDPXQtUydhKfv1aXwg+//+IVLGg==
Message-ID: <fd30d6ca-fdfe-4096-8057-a952a6a4bb7e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763097450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V6CspUaAq9CqCrRhA0/zrkY86hcqt/cVC1GnTgUj3Bc=;
 b=jXDRxyhsFi7srS2WbCG6hcmkuhY1+hsOT4qIzPiONcdAsA61yerqavJ9eciKuqKxAo/MSp
 um7tL4DCyakb7mgVHc8iMOhnP7XlQRcWlT4QmWAFQHE2K3adQzM9amhZXckjp14fMXNG19
 GfAjVwA9IEuScxdumZ4hYAhhlo4D3/R+uASH9VKZRDTnPlVZ+tRNCLWbpRKpHW8gwc4j6l
 iiH2HPdzhFlMq88XK0OE5pK0llxYVECPr8055Q99uY3Xh1BfDLikUzN9p7zuQz+Ru8EZzG
 gVsVdN6yfDiIAPJlDDTUiJiJcomjauUHXVwHMie/Fa0gYGwx1eKm/J/I0KC4BQ==
Date: Fri, 14 Nov 2025 06:17:27 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] dm: core: Check ofnode_to_offset() return value
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-2-marek.vasut+renesas@mailbox.org>
 <CAFLszTigJHK9H18rZG=AHRo09RPqKGHQmmVrHZ40mHPk-KkwqQ@mail.gmail.com>
 <7a083302-1096-47fa-90a9-aa350eea6884@mailbox.org>
 <CAFLszTjktw3yS9Dp9KGC=BAnpJAHg46f--NRRfnzXApQVOiuUQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTjktw3yS9Dp9KGC=BAnpJAHg46f--NRRfnzXApQVOiuUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: z69c57qce9s9xxbzyxut6b9s86rw3msa
X-MBO-RS-ID: 7db64c671ca385d7c47
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

On 11/13/25 11:46 PM, Simon Glass wrote:

Hello Simon,

>>>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
>>>> index 071d998a0a5..55c2b3a10bb 100644
>>>> --- a/drivers/core/ofnode.c
>>>> +++ b/drivers/core/ofnode.c
>>>> @@ -335,7 +335,7 @@ bool ofnode_name_eq_unit(ofnode node, const char *name)
>>>>    int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
>>>>    {
>>>>           const u8 *cell;
>>>> -       int len;
>>>> +       int len, off;
>>>>
>>>>           assert(ofnode_valid(node));
>>>>           log_debug("%s: %s: ", __func__, propname);
>>>> @@ -343,8 +343,13 @@ int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
>>>>           if (ofnode_is_np(node))
>>>>                   return of_read_u8(ofnode_to_np(node), propname, outp);
>>>>
>>>> -       cell = fdt_getprop(gd->fdt_blob, ofnode_to_offset(node), propname,
>>>> -                          &len);
>>>> +       off = ofnode_to_offset(node);
>>>> +       if (off < 0) {
>>>> +               log_debug("(not valid)\n");
>>>> +               return -EINVAL;
>>>> +       }
>>>
>>> Ugh this is really horrible, sorry :-)
>>>
>>> Better to put a wrapper around it than add all these checks, extra
>>> code size, etc. Also in many cases the ofnode is known to be valid(TM)
>>> so it might just be a waste.
>>
>> How would you propose the wrapper should look like ?
>>
>> Keep in mind, not everything is fdt_getprop( ... ofnode_to_offset() ...)
>> in this patch.
> 
> I was thinking of
> 
> my_fdt_getprop(fdt, node, propname, lenp)
> {
> if (node is not valid)
>     return NULL;
> return fdt_getprop();
> }

We would need a wrapper for almost every libfdt call, which isn't really 
better.

> What does fdt_getprop() return when the offset is -1 ?
If can_assume(VALID_DTB) , then crash on NULL pointer dereference .
If not, I think FDT_END (premature end) or an error code.
