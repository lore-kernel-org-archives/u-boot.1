Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1C8C83F2C
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 15:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE6886591;
	Tue,  5 Sep 2023 17:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nM7qd4cR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD624866DC; Tue,  5 Sep 2023 17:22:27 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE0186568
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 17:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 385FML44008582;
 Tue, 5 Sep 2023 10:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693927341;
 bh=5o1U/l3FkP8rsIk8Sw5wyR0q7ynhrX6vPAyyPHmuM5w=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=nM7qd4cRSI431zmn7UXg6jCC9EkRjJjRgx0tDJC9FRzUnDZwme7EYPJ8MRHcDX4Nt
 5Qp5psS4Xc42Si2PZo6RHJa5A+JP0AKNclSO6EtxxKBWaWlQDC1yJBUCzk0UfQ9s89
 78dxcp1S8DpjVtWJItrXg0OhbVeyf1T6qmkDVoFY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 385FMLN3006926
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 10:22:21 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 10:22:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 10:22:21 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 385FMKti121934;
 Tue, 5 Sep 2023 10:22:21 -0500
Message-ID: <72516776-1b6f-cd79-2e00-a28b920f722f@ti.com>
Date: Tue, 5 Sep 2023 10:22:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/2] binman: j721e: Add firewall configurations for atf
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>
References: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
 <20230905-binman-firewalling-v1-2-3894520bff8a@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20230905-binman-firewalling-v1-2-3894520bff8a@ti.com>
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

On 9/5/23 3:21 AM, Manorit Chawdhry wrote:
> The following commits adds the configuration of firewalls required to
> protect ATF and OP-TEE memory region from non-secure reads and
> writes using master and slave firewalls present in our K3 SOCs.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/dts/k3-j721e-binman.dtsi | 161 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 161 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
> index 4f566c21a9af..0569a592597e 100644
> --- a/arch/arm/dts/k3-j721e-binman.dtsi
> +++ b/arch/arm/dts/k3-j721e-binman.dtsi
> @@ -330,6 +330,73 @@
>   					ti-secure {
>   						content = <&atf>;
>   						keyfile = "custMpk.pem";
> +						auth_in_place = <0xa02>;
> +
> +						// cpu_0_cpu_0_msmc Background Firewall - 0

I don't have a personal preference, but I see most comments in DTS
are C style /* */.

Also it might be easier to understand if you put the comments right before
the properties that they relate to, i.g.

firewall-0 {
	/* cpu_0_cpu_0_msmc */
	id = <257>;
	region = <0>;
	/* Background, Locked */
	control = <0x31a>;
	permissions = <0xc3ffff>;
	start_address = <0x0 0x0>;
	end_address = <0xff 0xffffffff>;
};

For permissions, I wonder if it would be easier to read if we add
some helper macros:

#define FWPRIVID_ALL 0xc3

#define FWPERM_SECURE_PRIV_WRITE      BIT(0)
#define FWPERM_SECURE_PRIV_READ       BIT(1)
#define FWPERM_SECURE_PRIV_CACHEABLE  BIT(2)
#define FWPERM_SECURE_PRIV_DEBUG      BIT(3)
#define FWPERM_SECURE_USER_WRITE      BIT(4)
...

Then you would have:

permissions = <FWPRIVID_ALL |
                FWPERM_SECURE_PRIV_WRITE |
                FWPERM_SECURE_PRIV_READ |
                ...
>;

> +						firewall-0 {
> +							id = <257>;
> +							region = <0>;
> +							control = <0x31a>;
> +							permissions = <0xc3ffff>;
> +							start_address = <0x0 0x0>;
> +							end_address = <0xff 0xffffffff>;
> +						};
> +
> +						// cpu_0_cpu_0_msmc Foreground Firewall
> +						firewall-1 {
> +							id = <257>;
> +							region = <1>;
> +							control = <0x1a>;
> +							permissions = <0x0100ff>;
> +							start_address = <0x0 0x70000000>;

This address might change if one moves ATF, might work to use CONFIG_K3_ATF_LOAD_ADDR?
Not sure how you would get the end address as we don't really know ATF size..

Andrew
