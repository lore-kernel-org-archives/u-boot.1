Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6E4C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 20:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9FD1881CA;
	Thu, 11 Apr 2024 22:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tQFjmmIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB16878AA; Thu, 11 Apr 2024 22:31:15 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29F288573F
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 22:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43BKUxRj031110;
 Thu, 11 Apr 2024 15:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712867459;
 bh=gBfPEPFdAaG1pqPtXWTVhNV1/LNkQ9S3MINIHw9KtQY=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=tQFjmmIR72u3roZQtFe06q/CkTuSXSi5fyXBC86uqCfHuaV1JqA8N0AnhhERHqfSU
 ViAX+IKxbGgT/EKOUyKv2oRw2c1bUGNu/lGb9EzUExwwh9ozL1vIWd79EL1vRWWu1y
 +PPK7onOnqHkJigKzW7W9trRWxSpPfYJMO/Uhrao=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43BKUxl1022763
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Apr 2024 15:30:59 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 15:30:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 15:30:58 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43BKUwRN012876;
 Thu, 11 Apr 2024 15:30:58 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 "Christian Gmeiner" <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, "Neha Malcom Francis"
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, "Maxime Ripard"
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 12/16] arm: dts: k3-am625-sk-u-boot: Add
 sysreset-controller node
In-Reply-To: <87cyqwe3lt.fsf@baylibre.com>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-13-j-humphreys@ti.com>
 <87cyqwe3lt.fsf@baylibre.com>
Date: Thu, 11 Apr 2024 15:30:58 -0500
Message-ID: <86edbbzlod.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 11 Apr 2024 22:31:40 +0200
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

Mattijs Korpershoek <mkorpershoek@baylibre.com> writes:

> Hi Jonathan,
>
> Thank you for the patch.
>
> On lun., avril 08, 2024 at 17:31, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>
> Please consider adding a commit message body.

Got it.  thanks.

BTW, the next version of this series will drop this patch as Andrew has
submitted another patch removing the need for this one.  See
https://lore.kernel.org/r/20240402160908.508974-1-afd@ti.com.

>
> On the TI vendor tree, there is a similar patch with a commit message:
> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04&id=c5296d943c2c84dd6dcb3b91305d006ac46f3157
>
> Before patch:
> => reset
> resetting ...
> System reset not supported on this platform
> ### ERROR ### Please RESET the board ###
>
> With patch applied:
> => reset
> resetting ...
>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on am62x sk evm
>
> Andrew also suggested to me that if we are interested by A53 reset only,
> we can PSCI reset instead for all k3 architecture:
>
>  --- a/arch/arm/Kconfig
>  +++ b/arch/arm/Kconfig
>  @@ -784,6 +784,9 @@ config ARCH_K3
>           bool "Texas Instruments' K3 Architecture"
>           select SPL
>           select SUPPORT_SPL
>  +       select PSCI_RESET if ARM64
>  +       select SYSRESET if ARM64
>  +       select SYSRESET_PSCI if ARM64
>           select FIT
>           select REGEX
>           select FIT_SIGNATURE if ARM64
>
> Has the above been considered?

I am not aware.  I would think that you want full reset, unless you are
thinking about specifying a reset level?

Jon

>
>
>> ---
>>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>> index fa778b0ff4c..35bfeae75a0 100644
>> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>> @@ -46,3 +46,12 @@
>>  &cpsw_port2 {
>>  	status = "disabled";
>>  };
>> +
>> +&dmsc {
>> +	bootph-pre-ram;
>> +
>> +	k3_sysreset: sysreset-controller {
>> +		compatible = "ti,sci-sysreset";
>> +		bootph-pre-ram;
>> +	};
>> +};
>> -- 
>> 2.34.1
