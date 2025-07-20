Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEAFC83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 21:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6458783043;
	Sun, 20 Jul 2025 23:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tNHAO9Ra";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SjmYZEbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF01B8304F; Sun, 20 Jul 2025 23:10:54 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28EB82D21
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 23:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4blbm96Rvfz9spn;
 Sun, 20 Jul 2025 23:10:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753045849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17+D6A0Zgo1rvwFpmJL/+OWjj9N/n+h1251ZryXsmYk=;
 b=tNHAO9RaAmopMv14NPGLA0tI1pUcnmv+AX3k4X1pLpmPIIalGsxmhCy1B0qmCILraMcTh4
 KiWbcT5MyMmhI2bMqhkYbejM2YeTBD1OLVEzIfMLQYQ4gbMecWuHqtchGm12xPaJ8JCPbG
 FBie+RFa51O7DfEKYLX0F7ikeAlaXf2UAPMb3oizGhP7SP4mAUQFV/qfbO9R9vwFaSl6V/
 D2zLUKgzlKHzTnHCFpkP7mU/2AtaXtka6QKZ55nmoQMGJ4Pnt0/zXlGLWPiYfK+xmFeUBU
 z+pu0R8KJiYxLo4PDppPs7WobvutKySBvCCIZk/PMN+4x5sHLkg729DiP4GXpA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SjmYZEbZ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <20d6634d-9490-41b4-9002-b3d2156573b7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753045848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17+D6A0Zgo1rvwFpmJL/+OWjj9N/n+h1251ZryXsmYk=;
 b=SjmYZEbZQ29AZrAg6QJHCVESErZmLlolZgffFy8WhGQ/SjOP7ppWbgaM4YjuAmt6BvXgLH
 aoDPsN5Eex9KoGluvmdWjf1rlU1aDCk/CdKUvRwFq5Rb3/6Bf8DuOPspB+29t02gMBP5eu
 C+EKh3yrZ5+/Xm/JGD9x09jC7Sqhi6i2B+lo5TepJQqhqZ4wKehC9bW+miQc8GZ7+6ZJC9
 yC3QpMbuYbIq6OikJU+p1SLJOGYokeZoylpZV2NwnqXLKmpO3tcmtfyCtTM9X+39hvVevG
 e7+3uZeUqcOGF+q1mnW7PxwUU6tjSpCe19dEJoyhxqYNfnvchP0uV4J8GD99IA==
Date: Sun, 20 Jul 2025 23:10:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] net: sh_eth: Cleanup the driver to remove most
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: marek.vasut+renesas@mailbox.org
References: <175223757242.14072.4447733023600486815.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175223757242.14072.4447733023600486815.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0f1270af53b30c8a72f
X-MBO-RS-META: oacyn9j3f88y8mkjtg7zjnje3izew5ho
X-Rspamd-Queue-Id: 4blbm96Rvfz9spn
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

On 7/11/25 2:39 PM, Magnus Damm wrote:

Hello Magnus,

sorry for the late reply.

Would it be possible to split this change into multiple easier-to-review 
patches ?

> --- 0004/drivers/net/sh_eth.c
> +++ work/drivers/net/sh_eth.c	2025-07-11 20:31:22.438699670 +0900
> @@ -29,6 +29,8 @@
>   
>   #include "sh_eth.h"
>   
> +DECLARE_GLOBAL_DATA_PTR;
> +

This shouldn't be required , why is it required ?

> @@ -236,34 +236,37 @@ static const u16 sh_eth_offset_rz[SH_ETH
>   	[FCFTR]	= 0x0468,
>   	[CSMR] = 0x04E4,
>   
> -	[ECMR]	= 0x0500,
> +	[ECMR]	= 0x0500, /* ECMR0 @ 0xE8203500 */
>   	[ECSR]	= 0x0510,
>   	[ECSIPR]	= 0x0518,
>   	[PIR]	= 0x0520,
> -	[PSR]	= 0x0528,
> -	[PIPR]	= 0x052c,
> -	[RFLR]	= 0x0508,
> -	[APR]	= 0x0554,
> -	[MPR]	= 0x0558,
> -	[PFTCR]	= 0x055c,
> -	[PFRCR]	= 0x0560,
> -	[TPAUSER]	= 0x0564,
> -	[GECMR]	= 0x05b0,
> -	[BCULR]	= 0x05b4,
>   	[MAHR]	= 0x05c0,
>   	[MALR]	= 0x05c8,
> -	[TROCR]	= 0x0700,
> -	[CDCR]	= 0x0708,
> -	[LCCR]	= 0x0710,
> +	[RFLR]	= 0x0508,
>   	[CEFCR]	= 0x0740,
>   	[FRECR]	= 0x0748,
>   	[TSFRCR]	= 0x0750,
>   	[TLFRCR]	= 0x0758,
>   	[RFCR]	= 0x0760,
> -	[CERCR]	= 0x0768,
> -	[CEECR]	= 0x0770,
>   	[MAFCR]	= 0x0778,
> -	[RMII_MII] =  0x0790,
> +	[APR]	= 0x0554,
> +	[MPR]	= 0x0558,
> +	[TPAUSER]	= 0x0564,
> +	[PFTCR]	= 0x055c,
> +	[PFRCR]	= 0x0560,
> +
> +	// according to RZ/A1H Group, RZ/A1M Group Users Manual: Hardware
> +	// Rev.6.00 Jan 2021, the following registers do not exist
> +	//[PSR]	= 0x0528,
> +	//[PIPR]	= 0x052c,
> +	//[GECMR]	= 0x05b0,
> +	//[BCULR]	= 0x05b4,
> +	//[TROCR]	= 0x0700,
> +	//[CDCR]	= 0x0708,
> +	//[LCCR]	= 0x0710,
> +	//[CERCR]	= 0x0768,
> +	//[CEECR]	= 0x0770,
> +	//[RMII_MII] =  0x0790,

/*
  * Please use
  * block comments
  */

> +static inline int sh_eth_is_gether(struct sh_eth_info *port)
> +{
> +#if defined(SH_ETH_TYPE_GETHER)
> +	return 1;
> +#else
> +	return 0;
> +#endif
I think the only thing which currently supports GETHER in U-Boot is 
R-Car V3H , so this could easily become:

return renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77980;
