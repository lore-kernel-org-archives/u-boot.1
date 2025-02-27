Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49526C197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 21:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6088142E;
	Thu, 27 Feb 2025 22:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CEcIDO+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 290CA814B6; Thu, 27 Feb 2025 22:11:05 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6FEF81429
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 22:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51RLB0Y11863531
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 15:11:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740690660;
 bh=OvI3ElLWnKK+YdgW7OJepvew2nPPV4gUK5etT/8UURs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CEcIDO+kNmb6Rj8sv7HSHRESOXB5olQKSTq/s8DDg3lv1B4duBiwNZ/bB7r4wnjbH
 LqAQGm19iJ5NZn6BCj2PNHc+wn+kcMKDSj6q5wqBP58joMmu4/4pzI0BPlTZvOswWn
 gsGoKgMo+mwTCcPjrp237wUYAnDJlHr4745F+KAw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51RLB0nY116106
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Feb 2025 15:11:00 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 15:10:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 15:10:59 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RLAxKq034770;
 Thu, 27 Feb 2025 15:10:59 -0600
Message-ID: <de56be1f-bb18-45a8-b837-e10e520bb093@ti.com>
Date: Thu, 27 Feb 2025 15:10:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: common_fdt: create a reserved memory node
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20250227-reserved-memory-v1-1-638a6328884c@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250227-reserved-memory-v1-1-638a6328884c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 2/27/25 11:14 AM, Bryan Brattlof wrote:
> Some device trees may not have a reserved-memory node. Rather than
> exiting early we should create a new reserved-memory node along with
> the memory carveout for the firmware we (U-Boot) have placed.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   arch/arm/mach-k3/common_fdt.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
> index 4a01671156687..361b0c0b31b09 100644
> --- a/arch/arm/mach-k3/common_fdt.c
> +++ b/arch/arm/mach-k3/common_fdt.c
> @@ -122,10 +122,8 @@ int fdt_fixup_reserved(void *blob, const char *name,
>   
>   	/* Find reserved-memory */
>   	nodeoffset = fdt_subnode_offset(blob, 0, "reserved-memory");
> -	if (nodeoffset < 0) {
> -		debug("Could not find reserved-memory node\n");
> -		return 0;
> -	}
> +	if (nodeoffset < 0)

We could also reverse this check and put the node deleting logic
below inside this block. Same effect but removes the need for
a goto for flow control here (goto considered harmful etc..)

if (nodeoffset >= 0) {
     /* Find existing matching subnode and remove it */
     ...
}

Might make the intention a bit much, so either way is fine with me,

Acked-by: Andrew Davis <afd@ti.com>

> +		goto add_carveout;
>   
>   	/* Find existing matching subnode and remove it */
>   	fdt_for_each_subnode(subnode, blob, nodeoffset) {
> @@ -154,6 +152,7 @@ int fdt_fixup_reserved(void *blob, const char *name,
>   		}
>   	}
>   
> +add_carveout:
>   	struct fdt_memory carveout = {
>   		.start = new_address,
>   		.end = new_address + new_size - 1,
> 
> ---
> base-commit: b78f8677cde8b1dde31b66f5b780f2e9b62fba7f
> change-id: 20250227-reserved-memory-85f5d409e6a7
> 
> Best regards,
