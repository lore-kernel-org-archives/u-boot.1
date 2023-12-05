Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86360C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 04:24:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E191D870D2;
	Tue,  5 Dec 2023 05:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u0GggTQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 808E9876A3; Tue,  5 Dec 2023 05:24:57 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D745870D2
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 05:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B54OrDN084205;
 Mon, 4 Dec 2023 22:24:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701750293;
 bh=ZMwZ7vqy0rc2GY96CHNP5HiBbSvm/qxY0mwlkdqrCJo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=u0GggTQ2fNi4QubYTmFkeKCvTzHoAYOnY1sXprliW/XLCFctm/byqm6VXfi6MJcQ2
 sxvGBHobNnPIqYp8yduA6wFYEcjZJRj1RCJrd2AKBKL1m+0i3YdZcm90aj7cZeeTbH
 ntPmo24LIT+XWx/h9uPJonhRZZBdNacI9NM/9N6E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B54OrBc011814
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Dec 2023 22:24:53 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 22:24:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 22:24:53 -0600
Received: from [172.24.20.156] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B54Oo49022049;
 Mon, 4 Dec 2023 22:24:50 -0600
Message-ID: <cd79d1ea-86ba-4c67-8132-40b067bb31f1@ti.com>
Date: Tue, 5 Dec 2023 09:54:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-j7200-r5-common-proc-board: Set parent
 clock for clock ID 323
Content-Language: en-US
To: Reid Tonking <reidt@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <m-chawdhry@ti.com>, <bb@ti.com>,
 <a-nandan@ti.com>, <vishalm@ti.com>, <u-kumar1@ti.com>
References: <20231201213320.1876892-1-reidt@ti.com>
 <20231201213320.1876892-3-reidt@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231201213320.1876892-3-reidt@ti.com>
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


On 12/2/2023 3:03 AM, Reid Tonking wrote:
> From: Apurva Nandan <a-nandan@ti.com>
>
> This virtual clock mux configuration enables the use of dynamic frequency
> scaling on A72 clock ID 202 by setting up the required register.

IMO, dynamic frequency scaling should be supported without this patch.
But this patch allows to set freq at different rates other than fixed division.
I request to update commit message.
Rest LGTM

> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Reid Tonking <reidt@ti.com>
> ---
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index f0a73605020..018faaa13b6 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -24,7 +24,8 @@
>   				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
>   		resets = <&k3_reset 202 0>;
>   		clocks = <&k3_clks 61 1>;
> -		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
> +		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 323 0>;
> +		assigned-clock-parents= <0>, <0>, <&k3_clks 323 2>;
>   		assigned-clock-rates = <2000000000>, <200000000>;
>   		ti,sci = <&dmsc>;
>   		ti,sci-proc-id = <32>;
