Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62C5C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 17:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F79587F74;
	Sun, 17 Mar 2024 18:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ezLaUDjF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mCXCpBd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D557F87F24; Sun, 17 Mar 2024 18:10:42 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E38EA87916
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 18:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TyPdD4qYTz9scy;
 Sun, 17 Mar 2024 18:10:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710695440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyTc95fP5JuBK+qm/FhXQu0aT10oZRiostkoIu71+e0=;
 b=ezLaUDjFuLy3DhE+6JietP41uBLm2pLCgxDW8W3wnWudlJcad6A2vgsMCwxnuWCEYdHclo
 a6/YX+hRLesst1kQuAWAtshJfBEN6Sgu871CUv4RsBN54QHhL2UrJgThk97rOQnw9XuR/z
 xgGMA1g47KHnaqT6XR6/MpVx/aTBL170bX46nM7z4bk/B5/8zvedd1/tV8ag6ujsxu+FvC
 Poy/bgbF+e1EQasmYngwd/tNbxJDgeFs3rRaZkXtJRepYWhrRIi/+/8fgs+aqx09z1ue5m
 E8IIW9/lAjbH8LX7ZI/DexswQpMMpU77SGv+nKIawMmvl0/Sr+UdDUeCrFFzEA==
Message-ID: <248242c5-7010-4b83-a9f1-0decdbec4829@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710695438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyTc95fP5JuBK+qm/FhXQu0aT10oZRiostkoIu71+e0=;
 b=mCXCpBd1SWl04yWskQ4c6sSo1v4WnLOGPrBaMf9kSx/vo2oFREoFwT0V07aUAyg6SSrgIE
 wbjTwImawHtB0S/MRttBOBvuTh7A7rh6q8qT+aK3fLctx6HYeV28yvWAvx55CgRkcMSiIg
 gSFUp+TPKR6etxYzqjb2pDj/0duecUJllnovUaN1/UsRgqzCJuArW7aMsjk10mtrzQJJBM
 B05fP4b222kJIi0Sxokt/fOOYWc8eV8e2r7RvAL6op27tXmFUpPOcbbW1uA1vF3TkiyQxV
 OuIyvcBGZe3TcuG52BHT8W9f0lnqqiKJcGiyfABCGEV4JZvYKcELnK0ByS/+RA==
Date: Sun, 17 Mar 2024 18:08:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] boot: fdt: Move usable variable below updated comment
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
 <20240317061730.654893-3-marek.vasut+renesas@mailbox.org>
 <20240317112903.GG9082@pendragon.ideasonboard.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240317112903.GG9082@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a7f854d157af3e2d1d0
X-MBO-RS-META: 37y9p3nk9duwkidnt3ep8ot31n7qdpkb
X-Rspamd-Queue-Id: 4TyPdD4qYTz9scy
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

On 3/17/24 12:29 PM, Laurent Pinchart wrote:
> Hi Marek,
> 
> Thank you for the patch.
> 
> On Sun, Mar 17, 2024 at 07:16:31AM +0100, Marek Vasut wrote:
>> Move the variable below comment which explains what the variable means.
>> Update the comment. No functional change.
>>
>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>>   boot/image-fdt.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> index c37442c9130..16cd15e7e44 100644
>> --- a/boot/image-fdt.c
>> +++ b/boot/image-fdt.c
>> @@ -218,12 +218,12 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
>>   			if (start + size < low)
>>   				continue;
>>   
>> -			usable = min(start + size, low + mapsize);
>> -
>>   			/*
>>   			 * At least part of this DRAM bank is usable, try
>> -			 * using it for LMB allocation.
>> +			 * using the the DRAM bank up to $usable address
> 
> s/the the/the/
> 
> Is it a u-boot convention to write $variable to refer to a variable in
> comments ?

I don't think there is any convention so far, but some convention would 
be good to discern what is a variable and what is a regular word, esp. 
since 'usable' appears in both forms in the comment. Kerneldoc @usable 
could be an option, shell $usable could also be an option.
