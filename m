Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67601C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 10:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E67928329F;
	Tue, 12 Aug 2025 12:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lat4uvuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755DA832DA; Tue, 12 Aug 2025 12:18:55 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8614A83287
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 12:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CAIjdA1800820;
 Tue, 12 Aug 2025 05:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754993925;
 bh=Kj1z3VRnFEcGqrBIFklgEB0duVcauWjqteJ0TyhpiPQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=lat4uvuFep02sc5vjKkFgMzLw5xp3ACrb8dBc1bd6fAElKVa40UIbWvAWz1erA7OI
 1G7x4T0BhawxIH4WG89kRhuLKnaxbHBxbkcV0SjBL4zSuD2HHEan1Tl50eU4yHqflg
 WbwQTozvJVDu8kruGzL1tMeKPQhJK2whTtpBelDc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CAIjqr3746132
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 12 Aug 2025 05:18:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 05:18:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 05:18:44 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CAId3r191508;
 Tue, 12 Aug 2025 05:18:40 -0500
Message-ID: <52fc7042-f7c2-4161-b044-ba4000e13ef0@ti.com>
Date: Tue, 12 Aug 2025 15:48:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] binman: Fix FIT image overlap issues
To: Aristo Chen <jj251510319013@gmail.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <al.kochet@gmail.com>, <paul.henrys_ext@softathome.com>, <bb@ti.com>,
 <y.moog@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>, <afd@ti.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <ravi@prevas.dk>,
 <carlos.lopezr4096@gmail.com>, Aristo Chen <aristo.chen@canonical.com>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-2-aristo.chen@canonical.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250729125022.4220-2-aristo.chen@canonical.com>
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

Hi Aristo,

On 29/07/25 18:18, Aristo Chen wrote:
> Fix three binman tests that has memory region overlap issue, the test
> cases needed to be updated to use non-overlapping memory layouts.
> 
> * Tests fixed:
>   - testFitFirmwareLoadables
>   - testFitSignSimple
>   - testFitSignNoSingatureNodes

nitpick: s/Singature/Signature
> 
> * Changes made:
>   Updated DTB test files to change U-Boot load addresses from 0x0 to
>   0x2000 to avoid overlapping with ATF in the 0x10-0xfc range:
>   - 276_fit_firmware_loadables.dts
>   - 340_fit_signature.dts
>   - 342_fit_signature.dts
> 
> An upcoming commit will validate if the memory region is overlapped
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  tools/binman/test/276_fit_firmware_loadables.dts | 4 ++--
>  tools/binman/test/340_fit_signature.dts          | 4 ++--
>  tools/binman/test/342_fit_signature.dts          | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/binman/test/276_fit_firmware_loadables.dts b/tools/binman/test/276_fit_firmware_loadables.dts
> index 2f79cdc9bb8..d344036a11a 100644
> --- a/tools/binman/test/276_fit_firmware_loadables.dts
> +++ b/tools/binman/test/276_fit_firmware_loadables.dts
> @@ -19,8 +19,8 @@
>  					arch = "arm64";
>  					os = "u-boot";
>  					compression = "none";
> -					load = <0x00000000>;
> -					entry = <0x00000000>;
> +					load = <0x00002000>;
> +					entry = <0x00002000>;
>  
>  					u-boot-nodtb {
>  					};
> diff --git a/tools/binman/test/340_fit_signature.dts b/tools/binman/test/340_fit_signature.dts
> index 9dce62e52de..1c25d52cba4 100644
> --- a/tools/binman/test/340_fit_signature.dts
> +++ b/tools/binman/test/340_fit_signature.dts
> @@ -20,8 +20,8 @@
>  					arch = "arm64";
>  					os = "u-boot";
>  					compression = "none";
> -					load = <0x00000000>;
> -					entry = <0x00000000>;
> +					load = <0x00002000>;
> +					entry = <0x00002000>;
>  
>  					u-boot-nodtb {
>  					};
> diff --git a/tools/binman/test/342_fit_signature.dts b/tools/binman/test/342_fit_signature.dts
> index 267105d0f68..2ac600b1c70 100644
> --- a/tools/binman/test/342_fit_signature.dts
> +++ b/tools/binman/test/342_fit_signature.dts
> @@ -20,8 +20,8 @@
>  					arch = "arm64";
>  					os = "u-boot";
>  					compression = "none";
> -					load = <0x00000000>;
> -					entry = <0x00000000>;
> +					load = <0x00002000>;
> +					entry = <0x00002000>;
>  
>  					u-boot-nodtb {
>  					};

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
