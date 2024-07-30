Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EF7C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 04:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E1EA888B9;
	Tue, 30 Jul 2024 06:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M6pUry4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961CD88271; Tue, 30 Jul 2024 06:31:46 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 705B188958
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 06:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U4VfJ1071043;
 Mon, 29 Jul 2024 23:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1722313901;
 bh=O/dHnmLF7zLcI4Q3cyS/FTwZSlBYCSNhy31k+fX3tvk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=M6pUry4ENOS84tkMtEiPjcclT/HgwuXSDwr+cUWVrYmUjUVp5WLIxI89XBGuOc3wJ
 m4p0YWWGxRcxVnkJhdUOl40Xm0i6+gxUjSpu5bTrsy+ZzRteokFEHNdrtpHYPakXFx
 ZGiqSouxxfDXVGJz42BTPoydOvvaHQJTJvnUYO/g=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U4VfpP010587
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Jul 2024 23:31:41 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 23:31:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 23:31:41 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46U4Vc36102042;
 Mon, 29 Jul 2024 23:31:39 -0500
Message-ID: <b7262d1e-050f-4458-b92f-e41da4e777ed@ti.com>
Date: Tue, 30 Jul 2024 10:01:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] binman: elf: Add more debugging to
 LookupAndWriteSymbols()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>, Tom Rini <trini@konsulko.com>
References: <20240720104950.2730773-1-sjg@chromium.org>
 <20240720104950.2730773-7-sjg@chromium.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240720104950.2730773-7-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 20/07/24 16:19, Simon Glass wrote:
> When symbol-writing does not appear to work, it can sometimes be hard to
> figure out what is going on. Add some more debugging to help.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/binman/elf.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/binman/elf.py b/tools/binman/elf.py
> index 2ecc95f7eb8..a4694056391 100644
> --- a/tools/binman/elf.py
> +++ b/tools/binman/elf.py
> @@ -275,7 +275,7 @@ def LookupAndWriteSymbols(elf_fname, entry, section, is_elf=False,
>           return 0
>       base = syms.get(base_sym)
>       if not base and not is_elf:
> -        tout.debug('LookupAndWriteSymbols: no base')
> +        tout.debug(f'LookupAndWriteSymbols: no base: elf_fname={elf_fname}, base_sym={base_sym}, is_elf={is_elf}')
>           return 0
>       base_addr = 0 if is_elf else base.address
>       count = 0

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
