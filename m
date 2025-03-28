Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E34C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D1C81F45;
	Fri, 28 Mar 2025 14:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kg2hlS5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B05A381F6B; Fri, 28 Mar 2025 14:11:07 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FFD581F44
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52SDB1RG2125595
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 28 Mar 2025 08:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743167461;
 bh=ZbXhgr4GUk1r9G5K4PgiF/kgdmu7UNuBEG9QSUmU2z8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kg2hlS5R7QEyXHePwjl3qL3/eo2wScKRbt3smlmBsFmR6hFIRG4b2qp2AzVwDMJ6P
 tKgOWe0QVfx+LCk7Nd61xMJ+5njJEVnFXjfQweptuYmQqghHHKHENfS6wtb6plmw2l
 E1GCDjCFzKMtGX2MoUYDb4qWarbTWx+QR+12CK9A=
Received: from DFLE20.ent.ti.com ([10.64.6.57])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SDB1QG066112;
 Fri, 28 Mar 2025 08:11:01 -0500
Received: from flwvowa02.ent.ti.com (10.64.41.53) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 28 Mar
 2025 08:11:01 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Fri, 28 Mar
 2025 08:11:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Mar 2025 08:11:00 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52SDAwgF068669;
 Fri, 28 Mar 2025 08:10:58 -0500
Message-ID: <b80b75b7-c1bf-43f9-b005-1731ee7edfe8@ti.com>
Date: Fri, 28 Mar 2025 18:40:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Fix a typo in elf.py
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>, Tom Rini <trini@konsulko.com>
References: <20250328130214.2607633-1-sjg@chromium.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250328130214.2607633-1-sjg@chromium.org>
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

On 28/03/25 18:32, Simon Glass wrote:
> Fix an 'EFL' typo. It should be 'ELF'.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  tools/binman/elf.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/binman/elf.py b/tools/binman/elf.py
> index c75f4478813..6ac960e0419 100644
> --- a/tools/binman/elf.py
> +++ b/tools/binman/elf.py
> @@ -28,7 +28,7 @@ except:  # pragma: no cover
>  # BSYM in little endian, keep in sync with include/binman_sym.h
>  BINMAN_SYM_MAGIC_VALUE = 0x4d595342
>  
> -# Information about an EFL symbol:
> +# Information about an ELF symbol:
>  # section (str): Name of the section containing this symbol
>  # address (int): Address of the symbol (its value)
>  # size (int): Size of the symbol in bytes

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
