Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14F7C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 05:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33CD488150;
	Mon, 15 Apr 2024 07:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713160558;
	bh=T2E1wntKgb2kZ6i7gPyPcUOE51FuUZnRLxbaFeJXnrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=odb8rR4g9m76mlN8I1EST4FENlI8/CR6OR8o5lcweeFYD8oPtobOFuGKKfwcpJpkC
	 QeeSWn5O0nfc5qtM/JoovreRNK1LvNa9BptgmnUYmruc1AJ+pQ0xBlmU3F7CTwmQyG
	 y0IPEE6Vq6/M45T7DDHhaRlSl11leq7jf4eP1Z68FoeXIbJB2QOtiF1+3ez9+dojrU
	 5Ggym4ByveW0sAhaLvuwhZygDOOfld5NipohqngFcHqdUS2xlCcIdBWaKwt8XNWCX2
	 0JlGQSdKOoiQxeOZg3pQnJeQj+e8xEB+Kif5p3v27mxlBSWfNoBxoE5nhjErrozZeG
	 j9xU4ZY2WhvQA==
Received: from [192.168.1.107] (87-97-108-29.pool.digikabel.hu [87.97.108.29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 60FE387C82;
 Mon, 15 Apr 2024 07:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713160556;
 bh=T2E1wntKgb2kZ6i7gPyPcUOE51FuUZnRLxbaFeJXnrM=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=iucFh8TacN6rqpahvPP03nYxHYe2vONW7VCAVkHV36Y/Gqwqfky/G1rVrh0Ij8ylZ
 DEHk2EjmWqLNXhOr8+PP6QvzY4OVAgLqYRwq9hmNv5voaQXw13J7bx0FCtvaH5jsn6
 5X7eGeWCZVYjJsrxifY3Tel/XumdZml1b3Vq9jHn/SEMK3lF16UN/2Iqq6yUQCWm9L
 cuaKwEtJQyn9+3EB6tptYYILh81O5BrTAT/imAcvqfOciKUB/s8eGWtQPGPMD2Xg/t
 11C5mNO9WVrEO+tcdKoAiKHRl3DBQhZAg6foenGICk8RasmEps3Xx4P8W0U/dwgjSV
 Y6OCncetxP0FA==
Message-ID: <dc245d6c-de67-4757-faea-5a6aa65142b0@denx.de>
Date: Mon, 15 Apr 2024 07:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ubi: Depend on MTD
Content-Language: en-US
To: John Watts <contact@jookia.org>, Kyungmin Park <kmpark@infradead.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240411-mtd-v1-1-fe300f6ab657@jookia.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240411-mtd-v1-1-fe300f6ab657@jookia.org>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello John,

On 11.04.24 07:05, John Watts wrote:
> UBI required MTD to build correctly, add it as a Kconfig dependency.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
> While working with UBI on my SPI NAND patch series I found it was
> possible to enable it without enabling the MTD subsystem.
> Add a Kconfig option to solve this.
> ---
>   drivers/mtd/ubi/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
