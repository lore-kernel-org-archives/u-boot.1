Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111B606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qf2tpI0z;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qL+ZPlNb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 147D640728;
	Tue, 20 Oct 2026 16:29:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wZVLdDrqzVkI; Tue, 20 Oct 2026 16:29:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 53D704072E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792513744;
	b=X5ezCQVjz4akjIiakBOn3LrDS5vM8X212mDvGHHRTqDW5114zYtVmpPqPABe+Dml2nam
	 qX0ytuiOSAun6CfTTI5gyp+KmVK/2ZLIlx0qQHkuALl05LXlFUdatzcOINcaI2di2fkBM
	 WuX0Tog5GTAKNF+5y0TJx5wikGcxxF5MdjNxX/UQAXmx0tYDzCSyxBRB7g4R6kiZC1liV
	 QWnZ02CPEAs5fyopz7wT3aeIkA5yW6TImewm1LPVQR5YW6uJN6nSJRb+McMuTiG3/A+vo
	 aRfD1RXmJi55rvxM4RjUwwEW06N/x61gl6Fdmw/ZLUf8i52eHldpcFlA4WHoE97ZQtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792513744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gP8fGm191VRcCklC+wdT88rvwlA3ALle+FrQEPCqJCU=;
	b=svo1BnlheitnNcmOUucJ+cxGJwEzGPNclxOf9xA9o67tWxI2gVbtw3GpbrDqABTZ3rnF
	 I6XoX0ZQsQQQSuaQ45tWArUI3MBHzoEJ+iR0stAG1N/mx3LcHsPs61+lutRPmL9Kz+ope
	 GjT4o5IO3sct3a2jWzP+cRONXn5W2+3IFXN19IBmE/aHZ3GJKgt5tSglpr35c/l+5/mfr
	 tBH2r9bSmsEeDtmUVhoyy/Lb2EuiCFEi5s7sEV1eGkYqiY+DBNfwtFTFf+HbXrXLcWAEI
	 tfeHBCYgGf3EfW7Z/MLhaHXBweLTDzyfQTaOCsJ83ej0KnQsRuCi8YC150dp4QCnHLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	spf=fail smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=qL+ZPlNb;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792513744;
	bh=gP8fGm191VRcCklC+wdT88rvwlA3ALle+FrQEPCqJCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qf2tpI0zzZs155rmed2aatsgpoDTdNosThR1nGXCCJhYQTz8lHil0LO+Vh8wMWy55
	 D5/T3sbWcqxYh5V6VPNj9bxZjPm9bAvLAk6/7+P3aFxf8rLIK+/qXKFWjGG/Inh1qj
	 fp14B0CT0Hve+zepaaRqEzpk+ad+i9sfQPfCm9LaPFoAuoiyks7Z8k0UTmo7Wwzk8X
	 ONIraGCP7sSJ4bOMemR92v42tOimW+HwMd+/OAd4drcTW1icjmXuzGS5tSOsp3o7AM
	 CYC9W3sz8COu/cLyL7LGPVDZeQQKdwwQmvEE6R7+uOvsOkW1y/TwZAFHI8G0kuYPQG
	 CtIEHvQmPQh3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53D704072E;
	Tue, 20 Oct 2026 16:29:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1D6F930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A353A4072E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rSPjgipIuJN9 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:29:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD698406D2
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792513741;
 b=SCu82/SeHkGSrJLOHibGF3BwLeRxsBeiK5NVb4UF6BDJtwZqNxWi+H8f0tRK76g1D2NP
 Va5N1S7mgDu4FpT87DwzwWSQVAxIfoGwGJwRkvphMS/6skLKZjZpVv8mzSIGkAQOjGtbn
 v/Ug7CTJFKM2f08MvJNzVug4WOTOcUcFZ3x8W4y8T7PcZUL9knsQ4f1XXULxzNBy1DOpX
 pnxbtb00Kjw+RMSrBFHE5VGgS3Ve/iwiIIO2asDM/zHlNu7M+cftHkcH6LOEY66RYgLly
 jTfr4gRAC0AXWc0WWZo7T2tY1Mc8EeX05xeDkNyNyJxP0/oYePY2B68zjdQPmQOY7MA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792513741;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
 X-Virus-Scanned:X-Virus-Status;
 bh=gP8fGm191VRcCklC+wdT88rvwlA3ALle+FrQEPCqJCU=;
 b=NnK8osT65JMswfUtd2bdDB2G6V6ufTdZcelwlBXFaAIqpEdrSt2QMFsMqfwE7YJq53JF
 S1GzqOphHWgJ7ZWjhE9GuiMAjPqGz+ueo1n4Zl/yKu+0n21k4eBFqEARyVaoZ888D1xzr
 IMac8MvJcCPowW5+TGK0l7wHnA/ee1qMtNyTMTE9nYKVDH80Xw6pT/dDmoWSx11nvl6gr
 fuLm/eGeeQv9WYYZzk126e7zUIj1Zm4TdIPm9aI0uMCjUuYZwaZwutJuAOZfFL/AKPz7L
 fdaMZfbYawuP8huzA5BjiiB/u1MJXZ8ooJqm024l4c6MHhikNrnJ1pNcq2UIgQjLQEA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 spf=fail smtp.mailfrom=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=qL+ZPlNb; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=qL+ZPlNb
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD698406D2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:28:59 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A61F844F6; Tue, 20 Oct 2026 18:28:57 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9953C8056B
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 18:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j8Hsr5z1gzMlqY;
 Tue, 20 Oct 2026 18:28:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792513728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gP8fGm191VRcCklC+wdT88rvwlA3ALle+FrQEPCqJCU=;
 b=qL+ZPlNb26woFRJwGZN2W5qMRKi6FJPCwWdkbieGu8uJRi93PzKixV5hu7TWIIQPC4N31K
 D9Wc7MqRw1rXssISGLKCL8uL6HjjBFUsE8GdHCxSuz/bmM3DoM5mwWOQmk6eKF9MQcPB6G
 DL3zIXkT1CzvMsGW5lPZiScJuAM6SZWcp96qSvo02kNQkTvYSUkR4XMNtqawoPE7mSYnhb
 dKo9xsdgL19E/p//1WJNCUAYyZLvnkiHDOeYG2s5HX+IRZvY2fSLrLEZUapakMG9168FLf
 uKN74oJC4bzHgjzfVdRqArLti96vI3PbINeryd1pADwjwZ0D65hWe3fx1bLFlQ==
Message-ID: <4adf147b-2309-4ca4-a7c1-783af3c74891@mailbox.org>
Date: Tue, 20 Oct 2026 18:28:46 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: socfpga_de10_standard: Fix raw partition
 booting from SDMMC
To: Tom Rini <trini@konsulko.com>, Nimesh Acharya <nimeshacharya197@gmail.com>
Cc: u-boot@lists.denx.de, hsnaves@gmail.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@altera.com
References: <20261020091125.4015-1-nimeshacharya197@gmail.com>
 <20261020140834.GH720525@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261020140834.GH720525@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 29cb5e2d590d0279e26
X-MBO-RS-META: ui6tn14xwj4ktpmo3mnfxwu9xp9zuyn9
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 4:08 PM, Tom Rini wrote:
> On Tue, Oct 20, 2026 at 02:41:25PM +0530, Nimesh Acharya wrote:
> 
>> When using the default meta-intel-fpga configuration in Yocto
>> 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
>> U-Boot from the raw a2 partition on the SDMMC device.
>>
>> This change configures SPL to locate the raw U-Boot image using the
>> partition type and data offset, rather than relying on the
>> default offset relative to the beginning of the SD card.
>>
>> Signed-off-by: Nimesh Acharya <nimeshacharya197@gmail.com>
>> ---
>> Changes in v2:
>>   - Remove CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=0xa2 since its already the default.
>>
>>   configs/socfpga_de10_standard_defconfig | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
>> index 04f9d6c8494..f01667420a0 100644
>> --- a/configs/socfpga_de10_standard_defconfig
>> +++ b/configs/socfpga_de10_standard_defconfig
>> @@ -70,3 +70,7 @@ CONFIG_USB_GADGET_DWC2_OTG=y
>>   CONFIG_USB_GADGET_DOWNLOAD=y
>>   # CONFIG_SPL_WDT is not set
>>   CONFIG_SYS_TIMER_COUNTS_DOWN=y
>> +
>> +# SPL Fails to load UBOOT without these!
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x200
> 
> This needs to be run through "make savedefconfig" which also means no
> adding back comments to it.
The comment is unnecessary, but yes, savedefconfig would help here.
