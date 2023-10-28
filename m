Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DA5C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 12:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60DE687850;
	Sat, 28 Oct 2023 14:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FQSzevcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B88D387885; Sat, 28 Oct 2023 14:29:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6007487800
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 14:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5253460CA4;
 Sat, 28 Oct 2023 12:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA2FC433C8;
 Sat, 28 Oct 2023 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698496149;
 bh=stYw0A/o1YbMGzL4GnDdivvbWN40go3lw6FZDOrSfwE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FQSzevcGknwtT1UQ4xi3oJFzvObi1wBByGDVeQbDIBeKwJLk3EXlvOoRQh+Iveort
 OWWmGtNDFhrY+0JSGC5pf7AEErOcyyuHMNFuw0bMugnfzxX7usc69LuiDudNJR2BAw
 kxem7lfEcd0iEo1Fu0Ok2UEBfjxHuxYimX5QH7ioqmBZMmTFTQ0Ez8LsXlnmHt6pVU
 umabcuaG4xlEKa8vOcoDkhv0ZcGZ2WsNP5z44ddaSXA+AHzOd3mMzI8lDKb8sMGijo
 OEwNrzLf8TKf7j/qdgSR30vr7BPrN5H3uVs9lNMpR2xPY+ay4YT+w8IljiU4Iq0xnB
 ET4/MmDPu+Uqw==
Message-ID: <626e3742-291d-46ad-896d-1b3b02c22057@kernel.org>
Date: Sat, 28 Oct 2023 15:29:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm: dts: k3-am625-sk-u-boot.dtsi: Update main_bcdma
 and main_pktdma nodes
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, "nm@ti.com" <nm@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Cc: "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20231027134630.244886-1-rogerq@kernel.org>
 <20231027134630.244886-2-rogerq@kernel.org>
 <4e0911734e574ace2f9edbac9b7f49c1ee4515e0.camel@toradex.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <4e0911734e574ace2f9edbac9b7f49c1ee4515e0.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 28/10/2023 11:10, Marcel Ziswiler wrote:
> On Fri, 2023-10-27 at 16:46 +0300, Roger Quadros wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> Update main_bcdma and main_pktdma nodes for native configuration in the
>> absence of DM services.
>>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>> index b78d34b459..7186f0830f 100644
>> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
>> @@ -154,6 +154,33 @@
>>  	bootph-all;
>>  };
>>  
>> +&main_bcdma {
>> +	reg = <0x00 0x485c0100 0x00 0x100>,
>> +	      <0x00 0x4c000000 0x00 0x20000>,
>> +	      <0x00 0x4a820000 0x00 0x20000>,
>> +	      <0x00 0x4aa40000 0x00 0x20000>,
>> +	      <0x00 0x4bc00000 0x00 0x100000>,
>> +	      <0x00 0x48600000 0x00 0x8000>,
>> +	      <0x00 0x484a4000 0x00 0x2000>,
>> +	      <0x00 0x484c2000 0x00 0x2000>;
>> +	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt",
>> +		    "ringrt" , "cfg", "tchan", "rchan";
>> +};
>> +
>> +&main_pktdma {
>> +	bootph-all;
> 
> I believe that property would usually be added as the last item of a node.

OK. I'll move it to the end. Thanks.

> 
>> +	reg = <0x00 0x485c0000 0x00 0x100>,
>> +	      <0x00 0x4a800000 0x00 0x20000>,
>> +	      <0x00 0x4aa00000 0x00 0x20000>,
>> +	      <0x00 0x4b800000 0x00 0x200000>,
>> +	      <0x00 0x485e0000 0x00 0x10000>,
>> +	      <0x00 0x484a0000 0x00 0x2000>,
>> +	      <0x00 0x484c0000 0x00 0x2000>,
>> +	      <0x00 0x48430000 0x00 0x1000>;
>> +	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
>> +		    "cfg", "tchan", "rchan", "rflow";
>> +};
>> +
>>  &cpsw3g {
>>  	bootph-all;
>>  	ethernet-ports {

-- 
cheers,
-roger
