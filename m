Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CC410F6FBF
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 15:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF1883CE3;
	Wed,  1 Apr 2026 17:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vpiWor6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B4F83F7D; Wed,  1 Apr 2026 17:24:24 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A6B480517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 17:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fm80j1mVVz9v3P;
 Wed,  1 Apr 2026 17:24:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775057061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOkBfXSKcJydCjYHqNAc16T7nkmO1NZiwkXXW9trHmU=;
 b=vpiWor6AXVxzrhktkZBvvuDIJkh71fUSfgPTXCgDOlwVvtjELcGQojPKJbMCMEn2Swfi+w
 pXZGnJ93togZ3FzW51L8MpZLdT38L91aNtUsWG0Ktc4FO1NPKZ2rIIgfNUsNAaL9Cbd1vg
 0UTVzCnJQ0KoGYj/12KAEQLZsv58EuFj//k/+c5Kyn5hvZPGlhPbzLPFtZRITfw5NfdbO+
 r42d5PW2JCJpcmh9ZG2y5VTlW7ejnKBzd+pQiX53GfGSQ/N7EGpIB9jtiVFna2fhKrWI4b
 iiDmbVf1jaCgnvCwaN2RD2TLGxAtvqeyizWQYPVhI6E0WcCUx6DSQkDWuDgvgw==
Message-ID: <e8bcf2e6-9962-4c82-b38d-f803a69028d6@mailbox.org>
Date: Wed, 1 Apr 2026 17:24:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] fdtdec: Introduce fdtdec_setup_ram_size() to
 determine the memory size
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-4-ilias.apalodimas@linaro.org>
 <cbe4109d-7290-4104-8142-076b3296e13a@mailbox.org>
 <CAC_iWjLOJs-C4W=9EcY2DEVRde8Qqmmqb3b3h4+hGn1r9Pab+g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjLOJs-C4W=9EcY2DEVRde8Qqmmqb3b3h4+hGn1r9Pab+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 475071dcaa40c89cdc8
X-MBO-RS-META: 4a1yw1uwpy177u5z4xqs17k7s5reoeub
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

On 4/1/26 8:43 AM, Ilias Apalodimas wrote:

>>> +++ b/include/fdtdec.h
>>> @@ -965,6 +965,21 @@ int fdtdec_setup_mem_ram_top(void);
>>>     * invalid
>>>     */
>>>    int fdtdec_setup_memory_banksize(void);
>>> +/**
>>> + * fdtdec_setup_ram_size() - decode and setup setup gd->ram_size to the sum of
>>> + *                        all banks
>>> + *
>>> + * Decode the /memory 'reg' property to determine the memory available in all
>>> + * banks and populate the global data ram_size with it.
>>> + *
>>> + * This function should be called from a boards board_get_usable_ram_top().
>>
>> Is the board_get_usable_ram_top() really the right place to call this ?
>> It feels like it is being conflated with ram_top here too.
> 
> I don't think so. You are effectively calculating the top address you
> should relocate to. You should also calculate the difference in
> ramsize. Those two should not be separated actions
The address where you relocate to is gd->relocaddr, which is ram_top 
minus all the reserved areas, see common/board_f.c setup_dest_addr().

This setup_dest_addr() function does manipulate with gd->ram_size , but 
only to handle CONFIG_SYS_MEM_TOP_HIDE , which may not be the right 
place for it, I think it would be better to have a separate initcall for 
the ram_size calculation, which precedes setup_dest_addr().

With that, the function description can claim that each function must be 
called before that specific initcall, fdtdec_setup_mem_ram_top() before 
setup_dest_addr() and fdtdec_setup_ram_size() before 
setup_whatever_is_the_new_initcall_name().
