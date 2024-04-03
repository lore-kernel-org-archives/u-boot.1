Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81D3CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 14:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E11B881CA;
	Wed,  3 Apr 2024 16:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B0SmLafu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996ED88240; Wed,  3 Apr 2024 16:21:18 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54EBB8815D
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 16:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433ELCFX096128;
 Wed, 3 Apr 2024 09:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712154072;
 bh=qmD/W3FnxoniYGxUpOYFNrVzjfqlZDxbJLbY+6/kr28=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=B0SmLafuQ9NJriD6ibqp73AthS4kPyWKGYvRSIXSZhdSS+TgxPKHlsO+AbItd2Hpm
 ZCIYr4GCVN+ARKbgqpEdyYETdNG6fZbCuWMlV7b8G4gyz8hM3kiB/MqCO4/QbX0hWm
 /FEKBG3/m9S3K+648RqHV0wtorAZQnsj6NoZ8PS4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433ELCtc051414
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 09:21:12 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 09:21:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 09:21:12 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433ELBDQ049465;
 Wed, 3 Apr 2024 09:21:11 -0500
Message-ID: <7ae26e05-125f-4391-8a2a-761914fce904@ti.com>
Date: Wed, 3 Apr 2024 09:21:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3: Remove unneeded ti, sci-sysreset binding
 and nodes
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240402160908.508974-1-afd@ti.com>
 <20240402160908.508974-3-afd@ti.com>
 <0d8d5123-dccc-4b10-808b-5ce9d4f66a99@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <0d8d5123-dccc-4b10-808b-5ce9d4f66a99@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/3/24 1:37 AM, Neha Malcom Francis wrote:
> Hi Andrew,
> 
> On 02/04/24 21:39, Andrew Davis wrote:
>> This extra binding is non-standard and now unneeded as we bind the
>> sysreset driver automatically. This matches what is done in Linux
>> and allows us to more closely match the DTBs. Remove the binding
>> and all users.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  7 -----
>>   .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  7 -----
>>   .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  |  7 -----
>>   arch/arm/dts/k3-am62a7-sk-u-boot.dtsi         |  4 ---
>>   arch/arm/dts/k3-am62p5-sk-u-boot.dtsi         |  5 ----
>>   arch/arm/dts/k3-am642-evm-u-boot.dtsi         |  7 -----
>>   .../k3-am642-phyboard-electra-rdk-u-boot.dtsi |  4 ---
>>   arch/arm/dts/k3-am642-sk-u-boot.dtsi          |  7 -----
>>   .../dts/k3-am65-iot2050-common-u-boot.dtsi    |  4 ---
>>   .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |  4 ---
>>   arch/arm/dts/k3-am69-sk-u-boot.dtsi           |  7 -----
>>   .../k3-j7200-common-proc-board-u-boot.dtsi    |  4 ---
>>   .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  4 ---
>>   .../k3-j721e-common-proc-board-u-boot.dtsi    |  4 ---
>>   arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  4 ---
>>   .../k3-j721s2-common-proc-board-u-boot.dtsi   |  4 ---
>>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |  7 -----
>>   .../sysreset/ti,sci-sysreset.txt              | 29 -------------------
>>   18 files changed, 119 deletions(-)
>>   delete mode 100644 doc/device-tree-bindings/sysreset/ti,sci-sysreset.txt
>>
> 
> [...]
> 
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> 
> Why not have Kconfig set this as default y if TI_SCI_PROTOCOL set using same argument?
> 

Good idea, and the same could probably be said for most TI-SCI based drivers.

We might also look into adding more of these as "imply" under config ARCH_K3,
all K3 boards will want/need these. Should help simplify our defconfig.

Andrew
