Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DC5C021A8
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 06:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FEFB80A55;
	Thu, 13 Feb 2025 07:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lEkheDkN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B79480BAA; Thu, 13 Feb 2025 07:58:48 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 965A7806FE
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 07:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51D6wgZv689143
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 00:58:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739429922;
 bh=y0owxHyVfURnZL+kUKRYylf51su9CJ3A9qXpHh6UNrg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lEkheDkNB48btGNpodk7mOcDU7LgaE+xcvJ5+CkMnFVPfTB2I1rBuJPNJ10z61xml
 xhramjrNvVhe0t19PA56VyKcLJiJr4zyjlb0aHxU/dsX44FWYSXejrkLhukpt4P3/F
 Z+vVc/El6LyweW/TnA0SxpgDJ2D9HKTHj+iu1xJo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51D6wg7v119131
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Feb 2025 00:58:42 -0600
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 00:58:42 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Thu, 13 Feb
 2025 00:58:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 00:58:42 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51D6weeh053894;
 Thu, 13 Feb 2025 00:58:41 -0600
Message-ID: <554578d6-7be1-492b-a927-d19cc1e1b488@ti.com>
Date: Thu, 13 Feb 2025 12:28:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: binman: ti_board_cfg: Fix pylint error over 'br'
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>
References: <20250212222333.684437-1-trini@konsulko.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250212222333.684437-1-trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On 13/02/25 03:53, Tom Rini wrote:
> With a newer pylint, we get a warning that 'br' could be used before
> assignment. Fix this by declaring br first as an empty bytearray.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  tools/binman/etype/ti_board_config.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
> index c10d66edcb15..cc7075eeebec 100644
> --- a/tools/binman/etype/ti_board_config.py
> +++ b/tools/binman/etype/ti_board_config.py
> @@ -119,6 +119,7 @@ class Entry_ti_board_config(Entry_section):
>              array of bytes representing value
>          """
>          size = 0
> +        br = bytearray()
>          if (data_type == '#/definitions/u8'):
>              size = 1
>          elif (data_type == '#/definitions/u16'):

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
