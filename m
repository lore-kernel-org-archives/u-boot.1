Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3538ECA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 05:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AE2D80C16;
	Tue, 29 Sep 2026 05:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dnwIgNk_VkWZ; Tue, 29 Sep 2026 05:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9A54980BE7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790658373;
	b=UvEMUPaiAlf9muvyDegxoi62eATqMsT1nbUGaNL6uuuuWxiYn2d4H1Bu5kB1wdBGcKsR
	 oh4GAuNHe0iQJ62ccy9oD4BiULaipkLcOHXtdfcMOf50KuoJLi+3xgYRgpgwxjBZhZdul
	 YuNymgZ1b6EZce+eWdJuyIxlzOw2JuNRdKX/N5b1T90GhZmBLpIUYHZrfdixRpn8k7+e5
	 b7AYJbRFrcCDVYnuTphwOIjeJoAIG5YhHKAOGV5kJZauJs2tZaER9QwkBx/wgiPZbTO98
	 PZ+1hPW+k48uDcScYjM1byMrcCuo1h+LEyQ+4343nzTOZBSkuyYMGILkQcBC8czvN1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790658373;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VKTTwypkLypEtuAmyQhSJq43JI9I7guOnN2w5yvSSLA=;
	b=Ftmo0vvQBYSHIHFYztUtVnq3Oz5Yo/DGnwEIcDzuJEwAKjxtwV6kP8GgRcpp24nBhIJH
	 eBxN0h/LKgigM67+JGzAIDSWjXCl+Ef9Pb1+94DkI2izokD9EJNTXSzpH9MKL/nyJVklC
	 n/RegGQF3tg7fFh6OBkrrWAj/78vN5FwGH4aX9wUVUhfOselvIeTVxlpqr1IwrfPgJzhU
	 7Uk5mMb+enDQG+GWafhwJbSLymt/4wMNG1iZqO3qWjFuC9/WLpnFXEYMUpIrCgJmpcRZ+
	 txsAY2pSqF54K+Uvs8470NO9lnOzuRPLEzDRHoxSCBV2q6MHlQlZ42pEFapo0SKkrBQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790658373;
	bh=VKTTwypkLypEtuAmyQhSJq43JI9I7guOnN2w5yvSSLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yYHq+vw+BQTF4gwGOMaa1pznj2F+cavav9MtETaTUTV+0r9ojQ+QxEpdJ2jFOq43y
	 xzw4sbPBCfT7/c9n6o4BphTZjK1cjajZFsOLen8Gb1D4YtMiF/kbpUU2pg1ddb193P
	 JklnYaICLUClF4UiulYslM0gb7b9EyEgXpl8iijg9cz9+aF2SC20xBSiLHLq/UadXR
	 ZoD4O6hwO9/rTkNL2JCCfyklcyXgIyMbhqgZeFdKLtvCoCTxMpfVpSHn6/uDPSsdsu
	 F4iBpALyjFHWWcbpeUgZrboyBPjRIRx8RalGrAFk2m4lz87xjPOnlO2VqtEgSD0BVH
	 HVtTwJ8HD0gmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A54980BE7;
	Tue, 29 Sep 2026 05:06:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 72AE93D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54A4F6070E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VA-dNPW4oIBT for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 05:06:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 181256070C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790658370;
 b=pqx+ta4IeroKF9qDqu5v+e4gZOOc+CceNSitvM0oDaAO4JJm1vfLNt9/fZ+/pgLeZbYI
 ghVmEW42JRRTtsTYXIc7WrPS4/nE5hdHT4FLvOP9sLG5IRqzfETOKb7kycxvXAkotd4tL
 tmjbxcUwurVVNslq2MHvmZ5eVJ3qoR2B2alO7yeXwIxsoqLYubHVxdLdq8mn4QuuKU7VQ
 CoDCmZ+uoQy8VgV6fpLCclmfhRAEOx/G9HHtCQ4lwCSSGe4xXGDvsB36zHnJUxK8OIg/l
 YR27e1q+FSO+XKvA+FOw5oi0d9KLReVXfOmzSvlID/eX9bpKRDN6I5aeRmjYRT09XfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790658370;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=VKTTwypkLypEtuAmyQhSJq43JI9I7guOnN2w5yvSSLA=;
 b=DlOiVtcgOwS+1naL+y44U+QcuxLpzW7VdJ6Vqt3rB3GXwiTfsrBMtZcaJLMUOJESAR5h
 zS5V/+T42fDylFhJKQHBKhm3KizOP5LrxoNbRwSJm1muVy8fac7fJjJ2WT2cyLWbzfIAR
 V8/t3Abi+4x5wTS4HFUivFubGHsco6cfnjpWTK0IWQCdhPlGloqIqp42F9E+hc+V4Oltf
 hHnBmR90TkhsXxzuFOL/o0HAjjZawu3YRhL0Ae+YrbHTze2C9vU32ZxOXK6Oc8HnUnXrx
 Xfr4Xy/IhgN0iMsLWrHhBYhFwORFjguG2T5PcMP5eM5T0efwbIioNaq5L7o1CM5/91g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=EXnO+ggc; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=EXnO+ggc
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 181256070C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:06:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F562101EB9; Tue, 29 Sep 2026 07:06:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790658363;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=VKTTwypkLypEtuAmyQhSJq43JI9I7guOnN2w5yvSSLA=;
 b=EXnO+ggc+xMHRWXf3fo58WyOIhsZpo5fD9umQTEwV+t6Ek30VbYIXLnZHh+qPruvvbo/Ma
 wudApsbcyVzahNPIHe2I2TjzNvzLIC7T1xcUmDAdELeyZWXq1Zg23DFr+MHegBR4g3diqn
 dYdeRsmWX2LeYmtnE/FljtRIiSG2xHVtl2dXTYuyivgXfF1Qzl68tcZo1V1D0pjn6zRyBP
 HGCeXrIxaaGqUX6Av58Vku3FAlR9FyM9oseF1Up3Yro6CMcnivzN2/dwdUAn1BlmulnhWu
 LAlnNTZTxC+20W8jyVmP2zJwGiKTFTiDQ9Xa1IyKRUu2NTAQQfq1AIFp9NIhdA==
Message-ID: <3c23732e-da05-e22d-ad22-c49213db23fd@nabladev.com>
Date: Tue, 29 Sep 2026 07:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/3] sandbox: spi: let a slave name the driver that
 emulates it
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Vignesh R <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>
References: <20260922060941.534035-1-hs@nabladev.com>
 <20260922060941.534035-3-hs@nabladev.com>
 <CAFLszThpVVk5ygKDGfGndZKKoBnmx0pUD_k4MBvL0RSw6m-Nrg@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAFLszThpVVk5ygKDGfGndZKKoBnmx0pUD_k4MBvL0RSw6m-Nrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Simon,

On 28.09.26 16:45, Simon Glass wrote:
> Hi Heiko,
> 
> On 2026-09-22T06:09:29, Heiko Schocher <hs@nabladev.com> wrote:
>> sandbox: spi: let a slave name the driver that emulates it
>>
>> sandbox_sf_bind_emul() binds the SPI NOR flash emulator for every slave
>> on the sandbox SPI bus, whatever that slave is. There is no way to
>> emulate a different kind of SPI device, and a test for such a device
>> therefore cannot be written.
>>
>> Take the name of the emulation driver from a "sandbox,emul" property on
>> the node of the slave, and fall back to the flash emulator when the
>> property is absent, so that every node in the test device tree today
>> keeps the emulation it has.
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>
>> drivers/mtd/spi/sandbox.c | 25 +++++++++++++++++++++++--
>>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>> @@ -518,6 +518,27 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>> +static struct driver *sandbox_spi_emul_lookup(ofnode node)
>> +{
>> +     const char *name;
>> +
>> +     name = ofnode_read_string(node, "sandbox,emul");
>> +     if (!name)
>> +             name = "sandbox_sf_emul";
>> +
>> +     return lists_driver_lookup_name(name);
>> +}
> 
> The property name sandbox,emul is already in use - see
> arch/sandbox/dts/sandbox.dtsi for i2c-eeprom, sandbox-rtc, the PMIC
> and the swap-case device, and drivers/i2c/i2c-emul-uclass.c /
> drivers/pci/pci-emul-uclass.c on the consumer side. Everywhere else it
> is a phandle pointing at an emulation node whose compatible selects
> the driver, and dtoc even hard-codes #emul-cells for it in
> tools/dtoc/dtb_platdata.py. Reusing the same name for a string that
> happens to be a U-Boot driver name will confuse anyone reading a
> sandbox DT, and it bakes an implementation detail (the C symbol of the
> driver) into the device tree. Please follow the I2C and PCI pattern:
> put the emulation in its own node with the appropriate compatible, and
> reference it here with sandbox,emul = <&spi_ram_emul>. Then
> sandbox_spi_emul_lookup() resolves the phandle, binds the driver named
> by its compatible, and there is no new schema to invent.

Ouch. Yes, I am not to deep in writing sandbox test. I try to rework
this part.

> 
>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>> @@ -530,9 +551,9 @@ int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>>        drv = lists_driver_lookup_name("sandbox_sf_emul");
>>        if (!drv) {
>> -             puts("Cannot find sandbox_sf_emul driver\n");
>> +             puts("Cannot find SPI emulation driver\n");
>>                return -ENOENT;
>>        }
> 
> Now that the name can come from the DT, the message should say which
> driver was not found - otherwise a typo in sandbox,emul gives the
> reader nothing to go on. Something like printf("Cannot find SPI
> emulation driver '%s'\n", name) would help, which means passing the
> resolved name back from the lookup helper.

Indeed, I try to rework.

Many thanks for your feedback and time!

bye,
Heiko
> 
> Regards,
> Simon
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
