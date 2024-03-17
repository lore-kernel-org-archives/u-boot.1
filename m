Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85398C54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 17:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF9C387E64;
	Sun, 17 Mar 2024 18:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kWCxdx2n";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QTAlTKbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63FD687EDF; Sun, 17 Mar 2024 18:10:40 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C45587916
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 18:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TyPd91wX2z9sS4;
 Sun, 17 Mar 2024 18:10:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710695437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMnNSTgq1tF+v1h2dgbFJgFuAybONthrtlHGcduZXb4=;
 b=kWCxdx2n7rb9g85Y50jEO1rcM9VZ0ofvpMt2plUP/1TWKowO7/II8VRQJwZjFpHPy25x9P
 dB63wnBKArpIVBXDvvBh37k8paZlDJicDih9aZsTZYd/I9gKn4dfEcDzzb0AoqalV+EhIc
 1H7pspr1nWI57Ar/wio7MQqgl6TnWZUReHl/g8dIwPHpiXzHgcNKZVZb4j9wsjKpMDsEsS
 7Ms7a1kDi7h3twNd2AbSe4y7OEy/9LXjfEaovbImdr5OduEYRbCe01DlgIlqREG6SydzP9
 k1dQkhz4eI7XI43XCKE6svfBQj5jx11aOXAVTRzSVd6/lL+Lof+UQ4z2yA/fig==
Message-ID: <f60355b8-e18c-42b3-a76d-b9a2530a186d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710695435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMnNSTgq1tF+v1h2dgbFJgFuAybONthrtlHGcduZXb4=;
 b=QTAlTKbYrDsJjInUXw1ovx5V23jSgyQOoQAY2h6TLuLu/H7aJCHUlZ/ZD1cQS8YaBKgiJG
 V2vCzcnJQ5RED2DWbfERoScVqW9fW7HQISqKaAUWi6VuH6R8XHkH8xlDftnb0u/h+iTOVY
 vc1Gcvo/L0xnKqFth0QLXGge0bh7qntDs1netslBvVzjaQ+33fzPEaqkXO7sKWNmXtetHA
 hwsmW96qjTvDNxydW5smyVROaRTxdNI6Fe44psQYZVksxSRrRkGPfQjj9N6ddbEUvKfSgn
 O6v1Z/cs/QYXGlufjgu2vWzmPP0QIV8S0LvHdM23AGA/J10q0W9LpD46muJpQg==
Date: Sun, 17 Mar 2024 17:58:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] boot: fdt: Change type of env_get_bootm_low() to
 phys_addr_t
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
 <680c7c9d-5f34-4646-b624-490f934f4a1f@gmx.de>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <680c7c9d-5f34-4646-b624-490f934f4a1f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bbesiu6h334hwo3hooei3zww33ogw5fn
X-MBO-RS-ID: d96f7c2c5d6c0542afe
X-Rspamd-Queue-Id: 4TyPd91wX2z9sS4
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

On 3/17/24 10:08 AM, Heinrich Schuchardt wrote:
> On 3/17/24 07:16, Marek Vasut wrote:
>> Change type of ulong env_get_bootm_low() to phys_addr_t 
>> env_get_bootm_low().
>> The PPC/LS systems already treat env_get_bootm_low() result as 
>> phys_addr_t,
>> while the function itself still returns ulong. This is potentially 
>> dangerous
>> on 64bit systems, where ulong might not be large enough to hold the 
>> content
> 
> Isn't long always 64bit when building with gcc or llvm?

C99 spec says:

5.2.4.2.1 Sizes of integer types <limits.h>
...
- maximum value for an object of type unsigned long int
ULONG_MAX 4294967295 // 2^32 - 1
...

Simpler table:
https://en.wikipedia.org/wiki/C_data_types

So, to answer the question, it might, but we cannot rely on that.

Also, phys_addr_t represents physical addresses, which this is.

[...]

>> @@ -553,8 +554,8 @@ int boot_ramdisk_high(struct lmb *lmb, ulong 
>> rd_data, ulong rd_len,
>>           initrd_high = env_get_bootm_mapsize() + env_get_bootm_low();
>>       }
>>
>> -    debug("## initrd_high = 0x%08lx, copy_to_ram = %d\n",
>> -          initrd_high, initrd_copy_to_ram);
>> +    debug("## initrd_high = 0x%p, copy_to_ram = %d\n",
>> +          (void *)(uintptr_t)initrd_high, initrd_copy_to_ram);
> 
> Void * may be narrower than phys_addr_t.

When would that happen, on PAE systems ?

> Shouldn't we convert to unsigned long long for printing.

Printing phys_addr_t always confuses me. I was under the impression that 
turning the value into uintptr_t (platform pointer type represented as 
integer) and then actually using that as a pointer for printing should 
not suffer from any type width problems. Does it ?

Since this is a debug print, I can just upcast it to u64.
