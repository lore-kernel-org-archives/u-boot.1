Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45AECA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 10:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026E18323A;
	Tue, 12 Aug 2025 12:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jg+tFS2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092C48327A; Tue, 12 Aug 2025 12:59:41 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 520C783106
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 12:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57CAxXAs1428019;
 Tue, 12 Aug 2025 05:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754996373;
 bh=ib9M2xVAURbD8V4O8wXXt3X/T6yHlGL7l03X87wIomo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=jg+tFS2zH3gFK94duTZDbJ32xWhaOzf5kHRPGYuZ7ddkJ0cy4cTUZ7lMJH9CXBhoG
 SmjkC7UDzGa+PAj8ss3BYPNgOpSMyC4daXNh5CWLscjNHU3kQRZjrvG8ub9I9RSvxB
 4ronWwtGY2mSQcGWBaxxU5GaXaLZDzWh7womuVYE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57CAxXbk249521
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 12 Aug 2025 05:59:33 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 05:59:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 05:59:32 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57CAxR3D541796;
 Tue, 12 Aug 2025 05:59:28 -0500
Message-ID: <543ed0da-4313-4fc9-a9c9-b4c00ca50e21@ti.com>
Date: Tue, 12 Aug 2025 16:29:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] arm: dts: k3-am6xx: Fix FIT image memory overlap
 in binman configurations
To: Aristo Chen <jj251510319013@gmail.com>, <u-boot@lists.denx.de>, "Gole,
 Dhruva" <d-gole@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <al.kochet@gmail.com>, <paul.henrys_ext@softathome.com>, <bb@ti.com>,
 <y.moog@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>, <afd@ti.com>,
 <d.schultz@phytec.de>, <ravi@prevas.dk>, <carlos.lopezr4096@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-4-aristo.chen@canonical.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250729125022.4220-4-aristo.chen@canonical.com>
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

On 29/07/25 18:18, Aristo Chen wrote:
> Fix memory overlaps in FIT image configurations for TI AM62x and AM64x
> PHYCore and SK boards.
> 
> The overlaps occurred in two categories:
> 
> 1. TI firmware stub images (tifsstub-hs, tifsstub-fs, tifsstub-gp):
>    These mutually exclusive firmware variants were incorrectly assigned
>    the same load address within FIT configurations, causing overlap

I think this will break TIFS stub functionality which uses the "os"
property to figure out the right stub to pick from the FIT. See [0]

While I agree that ideally FIT images have to have non-overlapping
addresses, we may have to find a solution for such use-cases prior to
adopting this series/rule.

Require Dhruva to comment further on this TIFS stub load address change.

>    detection to fail. Adjust addresses with 64KB spacing:
>    - tifsstub-hs: Keep original address
>    - tifsstub-fs: Move to +64KB offset
>    - tifsstub-gp: Move to +128KB offset
> 
> 2. Device tree overlay images (som-no-rtc, som-no-spi, som-no-eth):
>    These overlay files had insufficient spacing between load addresses,
>    causing actual memory overlaps. Increase spacing to 8KB boundaries
>    to accommodate overlay sizes safely.
> 
> An upcoming commit will validate if the memory region is overlapped
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 22 +++++++++----------
>  arch/arm/dts/k3-am625-sk-binman.dtsi          | 16 +++++++-------
>  .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 16 +++++++-------
>  arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 22 +++++++++----------
>  arch/arm/dts/k3-am62a-sk-binman.dtsi          | 16 +++++++-------
>  arch/arm/dts/k3-am642-phycore-som-binman.dtsi |  6 ++---
>  6 files changed, 49 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> index a9bd5a2be84..4344cefeba3 100644
> --- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> @@ -234,8 +234,8 @@
>  					arch = "arm32";
>  					compression = "none";
>  					os = "tifsstub-fs";
> -					load = <0x9dc00000>;
> -					entry = <0x9dc00000>;
> +					load = <0x9dc10000>;
> +					entry = <0x9dc10000>;
>  					blob-ext {

[...]

[0]
https://elixir.bootlin.com/u-boot/v2025.07/source/arch/arm/mach-k3/r5/common.c#L349

-- 
Thanking You
Neha Malcom Francis
