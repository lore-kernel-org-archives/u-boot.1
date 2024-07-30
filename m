Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AB8C3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 04:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 185B788970;
	Tue, 30 Jul 2024 06:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="atpXWuaI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2854588971; Tue, 30 Jul 2024 06:32:11 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B2AA8896C
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 06:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U4W5WU071095;
 Mon, 29 Jul 2024 23:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1722313925;
 bh=0KXPv0ocoN6otwnvp0+qObD5HIJwIRa9cG+wPz+3neA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=atpXWuaICXCyTWKocam1CJEZPLfWc3GseRVuzI3qd3ZLsV7WYqy2vpu3rLWqyBoAo
 Tj42Gq4mAa6+NoWHMXR/7svBAnDTzL4Y8Eup27YM7APq0G5uxMFg4HZcjWgTtzgLrD
 76VjZfyI7/plLk9O0CaJJBYSFq/XInS9QlyML2qU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U4W5Wd013121
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Jul 2024 23:32:05 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 23:32:04 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Mon, 29 Jul
 2024 23:32:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 23:32:04 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46U4W16G038621;
 Mon, 29 Jul 2024 23:32:02 -0500
Message-ID: <10739d00-2c44-48d6-a8fe-d61aa500e92e@ti.com>
Date: Tue, 30 Jul 2024 10:02:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] binman: Write the compressed output to a file
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>, Tom Rini <trini@konsulko.com>
References: <20240720104950.2730773-1-sjg@chromium.org>
 <20240720104950.2730773-8-sjg@chromium.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240720104950.2730773-8-sjg@chromium.org>
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
> When an entry is compressed, write the compressed contents to a file so
> that it is possible to see what was produced. This aids debugging with
> new images.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/binman/entry.py | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> index 219d5dcecab..752c584c9a3 100644
> --- a/tools/binman/entry.py
> +++ b/tools/binman/entry.py
> @@ -1199,6 +1199,9 @@ features to produce new behaviours.
>               self.uncomp_size = len(indata)
>               if self.comp_bintool.is_present():
>                   data = self.comp_bintool.compress(indata)
> +                uniq = self.GetUniqueName()
> +                fname = tools.get_output_filename(f'comp.{uniq}')
> +                tools.write_file(fname, data)
>               else:
>                   self.record_missing_bintool(self.comp_bintool)
>                   data = tools.get_bytes(0, 1024)

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
