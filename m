Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF6EC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432ED86FBE;
	Mon,  6 Nov 2023 17:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="ni/8sQRN";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="nPYNIiIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F39C86335; Mon,  6 Nov 2023 17:51:26 +0100 (CET)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A66B86FBE
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 45fbae8a;
 Mon, 6 Nov 2023 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=0f
 vUM3QeGq3iUUZkBYobLRZoeSQ=; b=ni/8sQRNcc+OdkrTK7QzMK16Ba/oZd2u9N
 yai/jGzz8Riy4d3/pw8d8cK5mlDZNzgAcrWv2tZ9R5PRoQP9ib6PwmOhH2ljKLep
 wZcaDPX7Hwzie0mN79i6R2CMOTCFkIv0TFfMcldvaPloYlvaiRKLrXtuAIg6a+Yc
 XPHqxJJjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 fIo1JSr/LStC+/P+DXy241m9ChTWZnABlZ2+z2NLHXBdeYEd8rt+BrPGkzfI8I4M
 /CHm0BxkZhFqK+cNPeLhXO6DJSrCeLOGTTBm0ZS6wJ2FkgttUUL409vMoO40GJrt
 osliEuE0n/IqeozhEM5meTEJPp+bF2GNJ+G3j6EGUIs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1699289496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCnPjov6kvgTzHnndV45ri1J7lXTFn2Zqtvme2DR9EA=;
 b=nPYNIiITUrae0vH6oJAo2B2rS/I/JQ42MO3jrCBm/DTGqqBlWthRh7kHNzQZdBNpyNfzZA
 1F8ZPGxf1kEsAhtZVa9D/5uHPVtW6yHboTN3K32ZAe0PZlssPWSukUiR5f/I7zR36ar0bD
 WwZvua/iNC2jZqvoRL+l2AiSSRsfskU=
Received: from [192.168.0.2] (host-79-24-2-249.retail.telecomitalia.it
 [79.24.2.249])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 88022dc3
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 6 Nov 2023 16:51:36 +0000 (UTC)
Message-ID: <116b6beb-6271-322e-713e-08336bb72a3b@kernel-space.org>
Date: Mon, 6 Nov 2023 17:50:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 01/20] m68k: Remove CONFIG_FSLDMAFEC
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20231101162824.3755579-1-trini@konsulko.com>
 <63a7cd49-9491-6939-48af-62b2fc586cae@kernel-space.org>
 <20231106163230.GK496310@bill-the-cat>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20231106163230.GK496310@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

sure, i remove the unused dtsi,
patch will follow.

Regards,
angelo

On 06/11/23 5:32 PM, Tom Rini wrote:
> On Sat, Nov 04, 2023 at 09:58:07PM +0100, Angelo Dureghello wrote:
>> Hi Tom,
>>
>> Reviewed by: Angelo Dureghello <angelo@kernel-space.org>
>>
>>
>> Thanks for the cleanup, m68k boards build fine.
>>
>> fsl_mcdmafec driver is still referenced in arch/m68k/dts/mcf54xx.dtsi,
>> (from compatible field) but no board is including it.
>> You can remove the dtsi too if you want.
> 
> Thanks for the review.  I'd appreciate it if you went and did the rest
> of the cleaning of unused code around here as I'm not familiar with it,
> I just found this one as part of looking for common.h usage.
> 


