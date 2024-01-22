Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2854BC47422
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 00:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1C4878D0;
	Mon, 22 Jan 2024 01:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EIvOCDaU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jGwkQ11u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43DC48785C; Mon, 22 Jan 2024 01:48:55 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3073B878D0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 01:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TJBRm6szSz9sTc;
 Mon, 22 Jan 2024 01:48:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705884532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMLAkYVzVXEJwfIChV0AqFgZaRm1P4YrEXxInoMrpbU=;
 b=EIvOCDaUt+IV3cho/+PSTf3RdrpuEx+IWTn9IMicrhOZ5jBK2Bku46MfeH3JXndVEFGDH9
 bkfmWib19SIPbgOXCoKd3TmIfw/pblTGDW9zMylKppETE5vdvl3mo9V/uG1P8eeV+3Daxb
 LbnVbYcTyEUfHQNFh4MyrFDUTRMhUZsuuEmEBN2J8VP4cY+G9SJ8a3htAME+lc+gfOKhNn
 e69y8oS0eJ9zqz0fSzl5FvrnjY6cI9vYqoP3jZt1qM8l22GKxpNforAsIdosl04Ewu5l0W
 7AKT2pdeiaRzWOakHVZd4sW73vszLV262CabtZzZ0eCE+8gRtX9qFRltVMrbBQ==
Message-ID: <92da5e7f-c379-437c-b22a-8f80ea6a6f1d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705884531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMLAkYVzVXEJwfIChV0AqFgZaRm1P4YrEXxInoMrpbU=;
 b=jGwkQ11umDniH8IVrXe54OCp4N1IMJCPJAIE4mhEvtf5Qc3ktwOAOD8q1DmdKw/fVfGGfC
 s+N/wS8oFrdF4sXipQg1Wq4B6VxvVpP8/ik0VUY28hmUjCOVoDoQFqSN+jpvqlRIPjqwz3
 FSu6SbtIUU/x8IGw40A1/rVV8BpEfyKdHaj03bc5HjD9zgVdz5L59Behzrwu6Ps+G5NMt6
 Y/vSPiEvpHNxFKHUCPvW2ouWsKfdpLLTU+eYxBbFZ4AIsk2XubzRqapk8YK3diKUglU2xY
 abIRly01bmd8sOupbc2HhY8/RfS1ZUF6o6WPjCfPwnwqDWwHJOnVVFnWtScDLA==
Date: Mon, 22 Jan 2024 01:48:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 09/11] ARM: dts: renesas: Add Renesas R8A779H0 V4M DT
 extras
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>
References: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
 <20240121174340.279465-9-marek.vasut+renesas@mailbox.org>
 <afac41b9-fe68-499c-8994-d7254b8ed23e@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <afac41b9-fe68-499c-8994-d7254b8ed23e@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0c5228df6c99233790c
X-MBO-RS-META: 76q5cmo1bqt1ec7jspzeoaq4gjakeoum
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

On 1/21/24 21:52, Paul Barker wrote:
> On 21/01/2024 17:41, Marek Vasut wrote:
>> From: Hai Pham <hai.pham.ud@renesas.com>
>>
>> Add Renesas R8A779H0 V4M DT extras for U-Boot.
>>
>> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
>> ---
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>   arch/arm/dts/r8a779h0-u-boot.dtsi | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>   create mode 100644 arch/arm/dts/r8a779h0-u-boot.dtsi
>>
>> diff --git a/arch/arm/dts/r8a779h0-u-boot.dtsi b/arch/arm/dts/r8a779h0-u-boot.dtsi
>> new file mode 100644
>> index 00000000000..b2f7e054eef
>> --- /dev/null
>> +++ b/arch/arm/dts/r8a779h0-u-boot.dtsi
>> @@ -0,0 +1,27 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device Tree Source extras for U-Boot on R-Car R8A779H0 SoC
>> + *
>> + * Copyright (C) 2023 Renesas Electronics Corp.
>> + */
>> +
>> +#include "r8a779x-u-boot.dtsi"
>> +/ {
>> +	soc {
>> +		rpc: spi@ee200000 {
>> +			compatible = "renesas,r8a779h0-rpc-if", "renesas,rcar-gen4-rpc-if";
>> +			reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x04000000>;
>> +			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&cpg CPG_MOD 629>;
>> +			power-domains = <&sysc R8A779H0_PD_ALWAYS_ON>;
>> +			resets = <&cpg 629>;
>> +			bank-width = <2>;
>> +			num-cs = <1>;
>> +			status = "disabled";
>> +		};
> 
> Either the commit message or a comment should give some idea why this
> node is in a -u-boot.dtsi file instead of the r8a779h0.dtsi file itself.

I suspect this won't be in the initial Linux DT, so its kept as an 
extension here, so the GH board can use RPC to access SPI NOR . I 
suspect this will go away once the RPC node lands in Linux DT. I will 
add comment like that in V2 commit message.
