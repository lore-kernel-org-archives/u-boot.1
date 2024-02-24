Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727CCC5478C
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 00:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74DF487725;
	Sat, 24 Feb 2024 01:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ebI1OVRg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F99787BCB; Sat, 24 Feb 2024 01:00:23 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 471548785A
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 01:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41O003q2068555;
 Fri, 23 Feb 2024 18:00:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708732803;
 bh=dkWpDiePAow4uzG1JDG7YjdGDOYUYpH8ciIW1qFRE8g=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=ebI1OVRgCM4Ma/9XmJEOH788U9+/OIUM4w/noETDhhNE1zQCPOSCIItOfYTRvg405
 mDaB89DxaX9S7V9MER+fY5v4llo74gCCnjlRZkg3ZS6Xx5TVdlUE59hFvSE0DMBCMB
 gb5O58yI9Y6I5ionjonPNmovTN34pVh8eCmVUd3I=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41O003Og125919
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 18:00:03 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 18:00:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 18:00:03 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41O003Us047161;
 Fri, 23 Feb 2024 18:00:03 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] arm: dts: k3-am642-evm/sk: Enable OSPI support in SPL
In-Reply-To: <20240223164120.GY3040305@bill-the-cat>
References: <20240223052438.2013610-1-j-humphreys@ti.com>
 <20240223052438.2013610-3-j-humphreys@ti.com>
 <20240223164120.GY3040305@bill-the-cat>
Date: Fri, 23 Feb 2024 18:00:02 -0600
Message-ID: <86r0h2rat9.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Sat, 24 Feb 2024 01:47:06 +0100
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

Tom Rini <trini@konsulko.com> writes:

> On Thu, Feb 22, 2024 at 11:24:38PM -0600, Jonathan Humphreys wrote:
>> Add bootph DT tags to enable OSPI in SPL.
>> Set OSPI regs for R5 SPL to address OSPI's boot region.
>> 
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> ---
>>  arch/arm/dts/k3-am642-evm-u-boot.dtsi | 24 ++++++++++++++++++++++++
>>  arch/arm/dts/k3-am642-r5-evm.dts      |  5 +++++
>>  arch/arm/dts/k3-am642-r5-sk.dts       |  5 +++++
>>  arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 24 ++++++++++++++++++++++++
>>  4 files changed, 58 insertions(+)
>> 
>> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> index b843078243..f7ab9f9a30 100644
>> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> @@ -182,3 +182,27 @@
>>  &cpsw_port2 {
>>  	status = "disabled";
>>  };
>> +
>> +&ospi0_pins_default {
>> +	bootph-all;
>> +};
>> +
>> +&fss {
>> +	bootph-all;
>> +};
>> +
>> +&ospi0 {
>> +	bootph-all;
>> +
>> +	flash@0 {
>> +		bootph-all;
>> +
>> +		partitions {
>> +			bootph-all;
>> +
>> +			partition@3fc0000 {
>> +				bootph-all;
>> +			};
>> +		};
>> +	};
>> +};
>
> Do we really need these tags on the partition table? And if so, do we
> need them in main U-Boot, or just SPL?
>

Tom, these are the OSPI phy calibration patterns.  I added them as they
are in the J721e u-boot.dtsi and both use the same OSPI interface.

However, I dug into this more and the upstream Cadence OSPI driver isn't
calibrating the phys.

I will respin this series to remove the .dtsi nodes, and add a patch to
the J721e series to remove it from there as well.

Thanks for catching.

> -- 
> Tom
