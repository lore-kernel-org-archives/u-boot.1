Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5172CC48BF6
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 18:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD4987C78;
	Sat, 24 Feb 2024 19:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hLYg1Ebu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C1887C83; Sat, 24 Feb 2024 18:34:41 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B17875FC
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 18:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41OHYaW8077936;
 Sat, 24 Feb 2024 11:34:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708796076;
 bh=eWYyGvgE1SiYpl3K9fwR/oQnPLFZUvl47ikXuny5FGU=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=hLYg1EbuH6NPcSSqgQVNb6LfknTgDhzyMeiWgsAw3tcj+v3ft2chUcYWitQE5u49z
 x/0H7tAzMyJQ1CGh3ccLEsZrSWy678vw3dbzdxPBe8M+JmFjW+/uZbjzp8PBJzJeZu
 1Bb0Yg3MQOGy6nMJpXTqg7qtU2YFwqy8/e9SQ/sA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41OHYaXC004788
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 24 Feb 2024 11:34:36 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Feb 2024 11:34:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Feb 2024 11:34:36 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41OHYaSY126119;
 Sat, 24 Feb 2024 11:34:36 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/2] arm: dts: k3-am642-evm/sk: Enable OSPI support
 in SPL
In-Reply-To: <20240224135959.GC3040305@bill-the-cat>
References: <20240224001702.2283727-1-j-humphreys@ti.com>
 <20240224001702.2283727-3-j-humphreys@ti.com>
 <20240224135959.GC3040305@bill-the-cat>
Date: Sat, 24 Feb 2024 11:34:36 -0600
Message-ID: <86o7c5rck3.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Sat, 24 Feb 2024 19:59:15 +0100
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

> On Fri, Feb 23, 2024 at 06:17:02PM -0600, Jonathan Humphreys wrote:
>> Add bootph DT tags to enable OSPI in SPL.
>> Set OSPI regs for R5 SPL to address OSPI's boot region.
>> 
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> ---
>>  arch/arm/dts/k3-am642-evm-u-boot.dtsi | 16 ++++++++++++++++
>>  arch/arm/dts/k3-am642-r5-evm.dts      |  5 +++++
>>  arch/arm/dts/k3-am642-r5-sk.dts       |  5 +++++
>>  arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 16 ++++++++++++++++
>>  4 files changed, 42 insertions(+)
>> 
>> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> index b843078243..60b219c0be 100644
>> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> @@ -182,3 +182,19 @@
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
>> +	};
>> +};
>
> So this gets back to what I was asking in the first series, is this
> needed in SPL or full U-Boot as well? The bootph-* properties are
> supposed to be transitive, but originally the tooling didn't handle this
> and now the tooling handles SPL but not full U-Boot. Which also brings
> back the is this _needed_ question and is bootph-all right, rather than
> just the big hammer?
>
By "this", are you referring to the original phypattern partition nodes,
or the ospi0 node itself?  The partition nodes are not needed at all, so
removed.  The ospi node is needed in both SPL and U-Boot.  In that case,
using the bootph-all tag is the proper way, correct?

What do you mean by the 'big hammer'?

Please advise and thanks.

> -- 
> Tom
