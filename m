Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA388CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 21:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47CC183893;
	Thu, 30 Oct 2025 22:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uj0iaeo7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38E06838C7; Thu, 30 Oct 2025 22:25:24 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9148183677
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 22:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cyHFq4pTRz9spt;
 Thu, 30 Oct 2025 22:25:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761859519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDNWwf1VDL7ikBgcZxu72eI7mknteI6X8Wl4aO3vDqY=;
 b=uj0iaeo7sl636omQMMxqKhQ187PRhywUX7Q+FDNjy5fEhwyhJilmu2tP33/T1CYnfhPS8C
 vTVXzxfyPOzHzjFadyApLbco2k8ka+WiCJ8M9SPPQ6EK2pa+I5ViQTzWm3Sl1fnRmVDjF6
 5Mcl6rV3ETLY8DTkrVN1+a/c/KTxRqTY6v/b2Im7TVvSDw/9UC/7AO7s8WZFCDIbtegWlS
 /SZNBMdW2tLfG5pAw7i0YADAJfcDLNR4Gk2JYMDXEPfrOc29vAPBvwxUYu5qQords5lgu0
 OVS/uKYbFo/iOhwS98nJVDqh0PPYO7q6xoU189IWLQw47PibV2gNBPjBT5Hjeg==
Message-ID: <84bb96a4-5e97-4174-97cb-c3728922e236@mailbox.org>
Date: Thu, 30 Oct 2025 22:25:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor-ids: Reformat the table
To: Vlim <vlim@gigadevice.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, "havish.mutya" <havish.mutya@amd.com>
References: <20251028004729.119349-1-marek.vasut+renesas@mailbox.org>
 <SI6PR06MB7813347A75CE48B5924DF36EBBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
 <20ee9a4e-9d66-4507-9c88-6efacef85297@mailbox.org>
 <SI6PR06MB7813BEE2045C178C32397BCABBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
 <1f163d6d-bd46-4dcf-afa3-2cc246461bfe@mailbox.org>
 <SI6PR06MB78132750D9E159847DA0F798BBFAA@SI6PR06MB7813.apcprd06.prod.outlook.com>
 <SI6PR06MB78137361B12B205406D76AB3BBFBA@SI6PR06MB7813.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <SI6PR06MB78137361B12B205406D76AB3BBFBA@SI6PR06MB7813.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c1551403638902031d4
X-MBO-RS-META: 8d8dc4djjafendjb5m7gf44uubcse6sp
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

On 10/30/25 7:00 AM, Vlim wrote:
> Hi, Marek,

Hello Victor,

> I am ready to add a few new part numbers.
> 
> Do you have a preferred format yet for the table?
> 
> I can upload the patch for the new part numbers and address the format in the future.

I would suggest to coordinate with Tudor, he is the expert in this 
field, so his recommendation takes precedence.

-- 
Best regards,
Marek Vasut
