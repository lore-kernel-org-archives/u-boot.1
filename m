Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D72C3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 04:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CC4988936;
	Tue, 30 Jul 2024 06:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fouzaOAm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EAE88936; Tue, 30 Jul 2024 06:26:30 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B14088955
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 06:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U4QLWJ029280;
 Mon, 29 Jul 2024 23:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1722313581;
 bh=RuahPi2RnFyBBDV77xns/biDfbQfjQF47Aw0IQ2RQEU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fouzaOAm2CCA1nTLOb8VJ7Q2ZLnEom6T/AIiG11doq+FPnwZiNtbRdViXHI6q8cNN
 9uTGCSDk+12iCMHeB79nL3Jt0VVvuqucXXwejSiXzZqIJ9hy2rj4ks/VKpK69tnv12
 JOqWWmR+nm+/VMEtk7EbS4L3dED5vLtI1z2gfBAU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U4QLuk006590
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Jul 2024 23:26:21 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 23:26:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 23:26:20 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46U4QHpx091627;
 Mon, 29 Jul 2024 23:26:18 -0500
Message-ID: <5d3e0528-4e78-4592-b5eb-7adeb7a6c31a@ti.com>
Date: Tue, 30 Jul 2024 09:56:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] binman: Correct an error in the FIT-template example
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Massimo Pegorer <massimo.pegorer+oss@gmail.com>, Peng
 Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, Tom Rini
 <trini@konsulko.com>
References: <20240720104950.2730773-1-sjg@chromium.org>
 <20240720104950.2730773-3-sjg@chromium.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240720104950.2730773-3-sjg@chromium.org>
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

Hi Simon

On 20/07/24 16:19, Simon Glass wrote:
> The example contains references to an non-existent node. Fix it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/binman/binman.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 872e9746c8c..0cafc36bdcb 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -1211,7 +1211,7 @@ Templates provide a simple way to handle this::
>   
>           spi-image {
>               filename = "image-spi.bin";
> -            insert-template = <&fit>;
> +            insert-template = <&common_part>;
>   
>               /* things specific to SPI follow */
>               footer {
> @@ -1224,7 +1224,7 @@ Templates provide a simple way to handle this::
>   
>           mmc-image {
>               filename = "image-mmc.bin";
> -            insert-template = <&fit>;
> +            insert-template = <&common_part>;
>   
>               /* things specific to MMC follow */
>               footer {

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
