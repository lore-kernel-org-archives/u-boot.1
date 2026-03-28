Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DB210BA424
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 06:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C85383FA7;
	Sat, 28 Mar 2026 07:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BexMMgoP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ETHkDoma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6982483D17; Sat, 28 Mar 2026 07:44:11 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33EBD83FA7
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 07:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fjSfJ6b8Nz9v10;
 Sat, 28 Mar 2026 07:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774680248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GESmPza8VvUTTuHBSDa/hXrzBxb9DaNxXNRRJeGms0Y=;
 b=BexMMgoPCYNScao/QwL9bjH8m8HJTOij7S1Gz3hj3EF38Hi42vRrbfsqu5EvPDCIlTG0Pe
 /WSOjWxGZuh4S4L8D6Pi3+Yrhe7iBChiVCgq7ENpwtRBFe159IRM04agE85pZ7Ym6YK0kF
 fsMIOfWrZptb3bn6rtXyg2p5SSeGrC/hxyUrHN+WCZZzjYo2b3o1OkdX6m04ht7dg/dgYQ
 uHD0BCtDvmfWlEIMdytWjtdQozLIo7S/Hg2FypZ0dWTtBgndQC08aPwScI3mDBn5W9KpJM
 jRIaiSI8uwRbNn4nAPcEnGzLs3yQi7J0QP6s2u7owznMzZn94hMcnqLdGWUoKg==
Message-ID: <edbe864b-2c76-4ac2-8a1e-69f527f1316e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774680247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GESmPza8VvUTTuHBSDa/hXrzBxb9DaNxXNRRJeGms0Y=;
 b=ETHkDoma4mOADQy1JchbMGV54C2DpN7XopioPFwnbqT/WdyTZPagDSu9sv1/Vn/mCa7zmz
 vtdeIh+1NK3AgSm2PzgoYq/dx/+OTgnbGp8/vlitI87pqEvsqK6g3MxxAcd57LEjRKbKsg
 lJp3AJcPnIAHM94j1w6Qf3TABfX88z98pdDO6W8AtLacn0YslMCPGLJbbFpIaQwgEpyfZ9
 FruyoQ1i1mz+oLhiAvVdqpiYWs6BzIVIl6g7rcgiB4t+iFjPSLYrAcxx9mxkJn/UO5ob4R
 aho2o/8K0PWXN5mbCmdf6LZL+/Qe/1N5oLiQrb5i3Nm3fZugQ5LXA4pX/aUFjg==
Date: Sat, 28 Mar 2026 01:09:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/3] common: Allow relocations on the top of the last
 bank
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
 <20260326115111.1631261-4-ilias.apalodimas@linaro.org>
 <6f6f1fc8-56c5-405b-915f-269d789b43e3@mailbox.org>
 <CAC_iWjK5-5Nn8+-OOQWuPSDwd6ckHyPY2Na-7eGO2tc_1XsLxg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjK5-5Nn8+-OOQWuPSDwd6ckHyPY2Na-7eGO2tc_1XsLxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: y6sz5rahw8od4sxyoudochzpmxfu3ufr
X-MBO-RS-ID: 50daa450782d5fe194b
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

On 3/27/26 1:23 PM, Ilias Apalodimas wrote:

Hello Ilias,

>>> Add a Kconfig option and allow the common code to relocate U-Boot
>>> to the top of the last discovered bank.
>>
>> The commit message should really clarify the current pitfalls of
>> enabling this symbol, including the part where ethernet transfers above
>> 4 GiB used to work because of the packet buffer built into U-Boot, and
>> they will break because the buffer is now relocated above 4 GiB too.
> 
> Shall I just add your note from the RFC with a few adjustments? I.e
> 
> NOTE: This currently might break platforms. If the ethernet
>        controller cannot DMA above 4 GiB, and once U-Boot does
>        get relocated above 4 GiB, the packet buffer which is built
>        into the U-Boot binary is also relocated above 4 GiB.

This patch should not be applied in the first place, this DOES break 
things. I think when this patch is safe to be applied, the note will not 
be needed.

[...]
>>> +++ b/common/board_f.c
>>> @@ -321,6 +321,8 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>>                 */
>>>                return 0;
>>>    #endif
>>> +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK))
>>> +             fdtdec_setup_mem_ram_top();
>> Return value may need checking ?
> 
> sure, but should we panic ? Or print a message and silently keep the
> old reloc address?
Print a message and relocate below 4 GiB , for maximum compatibility maybe ?
