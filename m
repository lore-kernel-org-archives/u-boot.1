Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2881CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 21:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 879AB8406D;
	Thu, 13 Nov 2025 22:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Gyutwkft";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u0pEA3AA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 010A684067; Thu, 13 Nov 2025 22:57:53 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280CB83FFC
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d6vJt6r2sz9spd;
 Thu, 13 Nov 2025 22:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763071071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eI0BvbTsnw/+p35Xu1GJR7uC68kiDRO26xiINp4Z8aU=;
 b=GyutwkftA3WdwVgRoNgLZIPS0HWWZFlB3i7saXvOuFw88/9ruVDhW2umnmtj6R1e7wpsAO
 cVOg/7DmO6NiUflYQfmXthmCt9WVv972vACLQ15pe36zbIOkkEQj+b5edKRzExbLWALjrf
 5N+IsTmJUiKvRxkctxD3euKVM1zDsVkSKu3o9mqFS9EmxMQGr0HVsPe77RePGTZJiYOMSY
 Sps38IoKjWpW8blNxE6QZ28vbvQeQut8+GfzPOGlJwlytSCWhxselu8oyEZ4+t3+E97X7v
 F7T1BQEY6qSaxtyXTUdK363PKO8jRkMdM6CmWegnuQYxrIDI0Ig1+EbvsxVeLg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=u0pEA3AA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <7a083302-1096-47fa-90a9-aa350eea6884@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763071069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eI0BvbTsnw/+p35Xu1GJR7uC68kiDRO26xiINp4Z8aU=;
 b=u0pEA3AAj8M5PyMmGN5n/wv+u317rkzB/dptSknvkunQek/zqTLQsjIpK2D5ObTr2Iz0oF
 1LhTBTnz+ojjDBCNmSAMc/MMahbBKL4M8JASIli44tTRsrx9L4ECy4jUhR5lLX6q6Lb1iB
 e78hdW/aCspo8FkHjAqzPnYz45aBxkR9dRaTTgR8+Gys2WY+g61ee+dE/E86UB2AVeGq4g
 GhOagA+qQgEKlt3NYmrFSdXeRgumgcMkPLHFUaJBc0Rx2VLQaJefiAoqDmht+kFX1YD+Aj
 iNEsO5AnGeEtP+qncxcsM/WO3TPHAaEb53aG/GQhp3glYUa0v75MLOBCk6lSHA==
Date: Thu, 13 Nov 2025 22:51:25 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] dm: core: Check ofnode_to_offset() return value
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-2-marek.vasut+renesas@mailbox.org>
 <CAFLszTigJHK9H18rZG=AHRo09RPqKGHQmmVrHZ40mHPk-KkwqQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTigJHK9H18rZG=AHRo09RPqKGHQmmVrHZ40mHPk-KkwqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6253110a2a2b33f2641
X-MBO-RS-META: 6cks1hx3ggrur9ih1apgptb79zgr4mu6
X-Rspamd-Queue-Id: 4d6vJt6r2sz9spd
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

On 11/13/25 8:33 PM, Simon Glass wrote:

Hello Simon,

>> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
>> index 071d998a0a5..55c2b3a10bb 100644
>> --- a/drivers/core/ofnode.c
>> +++ b/drivers/core/ofnode.c
>> @@ -335,7 +335,7 @@ bool ofnode_name_eq_unit(ofnode node, const char *name)
>>   int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
>>   {
>>          const u8 *cell;
>> -       int len;
>> +       int len, off;
>>
>>          assert(ofnode_valid(node));
>>          log_debug("%s: %s: ", __func__, propname);
>> @@ -343,8 +343,13 @@ int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
>>          if (ofnode_is_np(node))
>>                  return of_read_u8(ofnode_to_np(node), propname, outp);
>>
>> -       cell = fdt_getprop(gd->fdt_blob, ofnode_to_offset(node), propname,
>> -                          &len);
>> +       off = ofnode_to_offset(node);
>> +       if (off < 0) {
>> +               log_debug("(not valid)\n");
>> +               return -EINVAL;
>> +       }
> 
> Ugh this is really horrible, sorry :-)
> 
> Better to put a wrapper around it than add all these checks, extra
> code size, etc. Also in many cases the ofnode is known to be valid(TM)
> so it might just be a waste.

How would you propose the wrapper should look like ?

Keep in mind, not everything is fdt_getprop( ... ofnode_to_offset() ...) 
in this patch.

-- 
Best regards,
Marek Vasut
