Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750B9C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 16:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A8987640;
	Wed,  6 Dec 2023 17:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sgJ9hzif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1BD8763C; Wed,  6 Dec 2023 17:23:35 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11CBD87688
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 17:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6GNSph012700;
 Wed, 6 Dec 2023 10:23:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701879808;
 bh=GrmNkTB109sZ7yKhZWnYXTl4xQ/T0rA/BhwG23EK54I=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=sgJ9hzifJLaR6gN4AiIaMF/SJycpPyNMPOc7mHwTVbZ/u0tVYPdmJZ9vJPvKQwb47
 aHd/A/jhTQs/avgb8dcW4gU2mMKv2no/nnR5Fc7PzFTs1EWCtwPdQyCuC9frF4jbj4
 skxAprPF4WOeG6FEDmtaKY0C4Zki2DsVt8S3rcMM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6GNSTt028045
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 10:23:28 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 10:23:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 10:23:27 -0600
Received: from [10.249.36.163] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6GNLfY044099;
 Wed, 6 Dec 2023 10:23:21 -0600
Message-ID: <b1a71eef-1464-4b33-8f43-f72f11ed59f7@ti.com>
Date: Wed, 6 Dec 2023 10:23:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] binman: j721e: Add firewall configurations
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>
References: <20231206-binman-firewalling-v6-0-e7fce13a6dc1@ti.com>
 <20231206-binman-firewalling-v6-4-e7fce13a6dc1@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231206-binman-firewalling-v6-4-e7fce13a6dc1@ti.com>
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

On 12/6/23 3:51 AM, Manorit Chawdhry wrote:
> The following commits adds the configuration of firewalls required to
> protect ATF and OP-TEE memory region from non-secure reads and
> writes using master and slave firewalls present in our K3 SOCs.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/dts/k3-j721e-binman.dtsi | 196 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 196 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
> index 5ddb474e3a41..f428aa81a6c1 100644
> --- a/arch/arm/dts/k3-j721e-binman.dtsi
> +++ b/arch/arm/dts/k3-j721e-binman.dtsi
> @@ -146,6 +146,202 @@
>   
>   		fit {
>   			images {
> +				atf {
> +					ti-secure {
> +						auth-in-place = <0xa02>;
> +
> +						firewall-257-0 {
> +							/* cpu_0_cpu_0_msmc Background Firewall */
> +							id = <257>;
> +							region = <0>;
> +							control = <(FWCTRL_EN | FWCTRL_LOCK |
> +										FWCTRL_BG | FWCTRL_CACHE)>;
> +							permissions = <((FWPRIVID_ALL << FWPRIVID_SHIFT) |
> +											FWPERM_SECURE_PRIV_RWCD |
> +											FWPERM_SECURE_USER_RWCD |
> +											FWPERM_NON_SECURE_PRIV_RWCD |
> +											FWPERM_NON_SECURE_USER_RWCD)>;
> +							start_address = <0x0 0x0>;
> +							end_address = <0xff 0xffffffff>;
> +						};
> +
> +						firewall-257-1 {
> +							/* cpu_0_cpu_0_msmc Foreground Firewall */
> +							id = <257>;
> +							region = <1>;
> +							control = <(FWCTRL_EN | FWCTRL_LOCK |
> +										FWCTRL_CACHE)>;
> +							permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
> +											FWPERM_SECURE_PRIV_RWCD |
> +											FWPERM_SECURE_USER_RWCD)>;
> +							start_address = <0x0 0x70000000>;

7 levels of indentation, impressive :)

This start address should always match CONFIG_K3_ATF_LOAD_ADDR, any way
you can just use that here?

Also this seems like a lot to add for each SoC, and much of it looks similar
(at least for Jacinto class devices), could be an opportunity for templating.

Andrew

> +							end_address = <0x0 0x7001ffff>;
> +						};
