Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E401606A323
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NDD1PXtx;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VT4M0fAc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B09640AC6;
	Fri, 30 Oct 2026 06:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qNSgV4Z7S4dM; Fri, 30 Oct 2026 06:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7937840ABE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793341022;
	b=lavKEsxzJgkqgZO2z/WY+iOr6LUWKnzq3PheqKq9KbEj8cd7H45PwVGCYqw1q5EOQ5F/
	 WVvTKdtl4EbsOiHlBjngd3mBdy0X+OGZK18t6oWO/6bVKe/laC3uk0AkcegUGuevuzcyw
	 jQ4jZQ5RI88nfLVogOnVSatUj/RtIDqIWLqnevjujPIH1p7TRU6+wixHtu+PpfEqR0MDm
	 TmV/1UXS9PBeN5DHc7mFA3tRcNnqPYdKMxbk+2Cg6jWH4uaozjfKDGT4IUav80U8aGf6K
	 fa6corln5EiOGM/TSkkh+mWF1PnRajpZTX13l+hd11DT/IJPLw9pks0dz4TTo6/XA0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793341022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JRav53oVn9CAWHhslCXh/jiaMqP+5hREw2uKCchmiCk=;
	b=KCp3MhK7Kyb6qvHSWZx9AtZR6q+IdL8VWzaTz60z4x6DidcOJIi+8eYFTNhfZ6uy+Ba/
	 uaXdV9B5c96REae+GArGrFhiLT9qHE9LAu/ptqzXvV4/57TyXAJMrpw9uQRywNyKC+Rgy
	 fI1sVN35eEfc0IV1JDoUaGJJe4gDc0B7Lk62tE8b5VtTGrRtlIdg5netePeIVeHLfmi+Y
	 EBvlWZ4bBMGSoUNjEVgfwpE3Xz5U+9m3oyPvmVgGahvd7Y2kAZCdjd3yu32QQAtOuJh3F
	 Q2jg/begEGEoNKTabK8L3L6k41vKYzNZKe9lO/cNYGASdDnJp9bNvRZlruRyN1Erc0Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793341022;
	bh=JRav53oVn9CAWHhslCXh/jiaMqP+5hREw2uKCchmiCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDD1PXtxI/6G72nnuNBA412UpFDCZr8TaswZbeFLTjR4ImJ7oJjdnUlzLonOwH4ff
	 +m/Ec1vak96YXHlr0EMW8IoFEj+8vwqwbUpG7JQkf77zo9nH4mjoTNjka4vitqs5xf
	 gFpyl1gwBju92GuUoS8Fzf3kwfZZtVQ/SiQT6G3RUFKPa00jRXfZpIOEzyrvk9GfBv
	 vX756qLE5I2Pneraz7md/+DgutPARsfchWwV/xn749HQ1KlJxLcoOD/9QMZEuJ5KQS
	 YpRL0TAAnbwdoMbHM48cQd/70/SaC0QSzNel9zA1znzTm/mUxtyoL6itAVfb0xgb86
	 XxgV3LSJAQqTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7937840ABE;
	Fri, 30 Oct 2026 06:17:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 448D9712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A99960690
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S7CbouqZFIr7 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 820FD60667
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793341019;
 b=D1tt3LSCGGFlaLc3LtGo3QKSRCNumDQJt6H1dUoZkPSrcgpaYzFNaNbOTigR91x+JPMd
 g9U2MkyWGQW/Mqjo7MUGLVVMKEHHboEOZ7SZCW8MVJg+ZfkxSRorsYz1XKv3KXNrHwUH5
 /8/LvBnaDQ4pjNdLbXsxgi5rKDruX59cu5onDvNUmUWzfQgWZlVvxQpcmZEWHkfxtFovk
 9QPyZICGTZubuVgx077b4o0SvNavEtNX1TQOug9xI7IN8xtPmpUD8NKKy1nII3zSqka1l
 45coqu5+Jhey+1vfH4K6pQOqt2h0DF8n1KUL+9LS8OGynThPOUI6YIpoJj/9yrsAV0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793341019;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=JRav53oVn9CAWHhslCXh/jiaMqP+5hREw2uKCchmiCk=;
 b=WETqp/C3dJGPq/0yWVo0aexTVidjJQ5p+EFkKYGX5/8VZtb4JwDD4r5OPU+E03hM5zkL
 qrdY94zx9ZL9x3wxe6Vc6PzAUO6CY3fOfx2CluPPUJGviRBVm0pDL2OqWUWCtlK5TfFuk
 N9gLDCfewpunNVP37FDn+pWr+Br7c/bdcSfxGE4dgAYyUdkIEPmoxqdSRB8ooBleujfFn
 vQzLRh/sIRkw+evtssr0lkLJDBQpnd73eTFhElR9uIBMXAzNWpb3fS7qcmvqHFtTUiBvw
 cBAMklaLD9bWOkclbk40SHIanewJSwAR/VFq8V1DTJoadXqufrUy5L2m4cc+fn1Rhdg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VT4M0fAc; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VT4M0fAc
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 820FD60667
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:16:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F20F842A7D;
 Fri, 30 Oct 2026 06:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BEA1F000C1;
 Fri, 30 Oct 2026 06:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793341017;
 bh=JRav53oVn9CAWHhslCXh/jiaMqP+5hREw2uKCchmiCk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VT4M0fAcGSjW42Rrn2EAN3wyZimDq4MZBQtlLXnY2cBmvo7G2//wc8AVNbu3i6RvH
 kS1rAT73M1hs/Ugc2G60Gyhu9ku3bZSSGrz8fsRctkydm9IlS0XYUXQ+D6BkdRxiTf
 GWnO4EVVBxouQVmPDsgxvUpx1AVcw4S6TXUE93LPqvbVya6yDa3zXBNAxVoOlzjn8i
 M932fpqgklkhHGvYD/Y9jZNsv7NlxEsRdi7X+tmpH++untiNO0vDxTuSGaNwD4KWoB
 7lx6Kx4TdIeXyq61OyF5buIl8m+wE1OIrS5uX0y7BE3EpzQHYZDgH4wyaXWcuL7PrU
 ZK4vl5iM1OLXw==
Date: Fri, 30 Oct 2026 11:46:48 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Abhilash V <abhilash.v@oss.qualcomm.com>, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@nabladev.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, varadarajan.narayanan@oss.qualcomm.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 05/13] arm: dts: shikra: retain QUP SPL dependencies
Message-ID: <auQ2UDmehpUEDvLF@sumit-xelite>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
 <20261029105746.3487456-6-abhilash.v@oss.qualcomm.com>
 <20261029165138.GE2976463@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261029165138.GE2976463@bill-the-cat>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey Abhilash, Aswin, Balaji, Varda,

Just wanted to reiterate the general OF_UPSTREAM DT guideline below.

On Thu, 29 Oct 2026 at 10:51:38 -0600, Tom Rini wrote:
>On Thu, Oct 29, 2026 at 03:57:38AM -0700, Abhilash V wrote:
>
>> Retain QUP, console, pinctrl, clock, power-domain, RPM,
>> and MMC dependencies in the SPL device tree so the firmware
>> loader can use the boot medium once probed in SPL.
>>
>> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
>> ---
>>  arch/arm/dts/shikra-cqs-evk-u-boot.dtsi | 44 +++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
>> index e807b91ef1f..c79c63ad732 100644
>> --- a/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
>> +++ b/arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
>> @@ -20,3 +20,47 @@
>>  &usb_qmpphy {
>>  	status = "okay";
>>  };
>> +
>> +/*
>> + * Keep SPL console and QUP dependencies.
>> + */
>> +&gcc {
>> +	bootph-all;
>> +};
>> +
>> +&tlmm {
>> +	bootph-all;
>> +};
>> +
>> +&qup_uart0_default {
>> +	bootph-all;
>> +};
>> +
>> +&sdc1_state_on {
>> +	bootph-all;
>> +};
>> +
>> +&sdc1_state_off {
>> +	bootph-all;
>> +};
>> +
>> +&sdhc_1 {
>> +	bootph-all;
>> +};
>> +
>> +&qupv3_0 {
>> +	bootph-all;
>> +};
>> +
>> +&uart0 {
>> +	bootph-all;
>> +};
>> +
>> +/* Retain the RPM clock and power-domain providers for boot consumers. */
>> +&rpmcc {
>> +	bootph-all;
>> +};
>> +
>> +&rpmpd {
>> +	bootph-all;
>> +};
>
>Why aren't you upstreaming these?

+1

Please don't push any DT overrides in U-Boot without any upstream path
to get rid of DT overrides in future. Always provide a link to upstream
kernel DT posting whenever any exception is needed to add DT overrides
in U-Boot. This applies to all the patch-sets adding DT overrides
especially in case of U-Boot SPL support series.

bootph-all is well upstream kernel DT accepted approach, so first go for
kernel DT updates always.

-Sumit
