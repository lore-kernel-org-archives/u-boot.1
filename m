Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40C9CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 06:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D2D7403EA;
	Tue, 13 Oct 2026 06:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id reyNWqSnBhf4; Tue, 13 Oct 2026 06:12:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02DB24034F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791871942;
	b=mD8VZWMWOcL8BaUus2aB3Eor4GjRqsqerCBQsTUQr+Nai5Bm66harU1i7zZ4h77tIVmy
	 A/IyRn3LbO6nM6QYfzRr9QCg5ciTBVC5NRK2qeSnVeWA1JGQfPxuO8MQ8nov83I5xVhHh
	 x33ialp9BkPw0Qitwmc+67h84KlwIChGcJ8s94bI01O9ebKJoROK+GMX1HX0hRey+ku7h
	 dxmEsRiZGTXoM4ImWMo+M52+Nf9DaBznkeDpecB/30Rt0GpIHIBJTfyiWMSHhbVgAOUP4
	 Y7l+LYe8ekWw9uIZ35bJMoFErr2RsJqjRsPPNdCsjRRVT71clNhbCe55maaRD+kSwhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791871942;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:From:To:Cc:References:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q/EZUlOpo8sW7tk40IhUbztqVsd5RFU/d1iNZihBoYA=;
	b=fl+5nYJ4zPm8HZFjjN4y0N8vrgEmcZpbGno+QD4Rzn/iWsY76V+Ucz1/v2eZJ738ipap
	 Ic2zCP8OS3Xdot9XA9Os4BmevH4dsKjT0G8DzHips9+IvzdEkX6pbEsc38tQ76hSJwlPD
	 P4UXfN4TUPZDoyM+u/Vz+Px/RJZ6FkfvVpvpCUgiF+Ad7Y7zy6WZwGcu5YjU+TopM0B5/
	 ZtH3/K5zRDOteyvTbVAR7/2V/6g4yS5mEtLnuPz7C6YBVH1SyXTfsx8f60PfoCTiQh2vr
	 H3uQNlLVuhlRWZG4O1mBmOnStPVTRxqdCyf/Hc/N57WHw431qBEdIaQQQbyrDBezFOQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791871942;
	bh=Q/EZUlOpo8sW7tk40IhUbztqVsd5RFU/d1iNZihBoYA=;
	h=Date:From:To:Cc:References:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vOSUdoRoqTDYH3PJS0aWzeKYlTJ/ExuP+PRHvvb/Pu9ai30Bi76mwDJdIFoIkAEA9
	 kcJxM/xGef2Tl3LxSi3Ze83xVv5glqIocTKut8nQfE2E6CyjV2dBL5Tv2WzJ/LbBOt
	 F3y0C6R5yPD4yz0HGgRV1dziJxeWDN6nbbLdxkrTZpcylZA5KCNx63AUEOXTe1aWhf
	 zeqwU/O47pquFMQL8bHIf3zAF3pYcMlpkiXSV+LAOtVJsqxeZkOx2QPOdDrGhXJGBZ
	 adhuRT/CKOzB2dhziLusIEMgJuh2wfhagcNws9JS1qlVIkV0czt8AxSQrIabCht/9V
	 GF7lOifF5vlBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02DB24034F;
	Tue, 13 Oct 2026 06:12:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A07664DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 865D0605DA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gj962FU9XGsm for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 06:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E927605AC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791871939;
 b=RyoD5CX9GU9lb2SDsrUM8p0iAMjPaoqIYW22d/NGbfrmVUTBGjZCcNaa7IjpIvkBOeKq
 DxzDHT8irmrd27eQvGh8J6SEojM/Etp7p5hwzQfERCay9QJf3IBihsr4PwkVxEqgRS4tB
 fc9r/NPSe5eJzBFV6CdPR60o3kg3qUcGoPFaUWiHKR05J4o+VaUywBE9OZ7ULpv/hEHpK
 WqmNMOXOfaZ3xwClUaB1cxqipkiYynMnJiB7nCKGAITea0RsGSUBfLAQaUz4iLfzRmC3q
 oBG6j+t6czlF2EX+Fi7keXJvbUPZD4AaoMsX/1UEURYV4dK1K2HCWEPpwYI9xX6Tk+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791871939;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:From:To:Cc:References:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=Q/EZUlOpo8sW7tk40IhUbztqVsd5RFU/d1iNZihBoYA=;
 b=AcbwPduHsu3k5Xe/kQYwaeQlu6JuXvlXy6ntF3FHIPWVfBAILLY6A9GyC9GjT78+3tFO
 lFAXzSwavOp06ajCpj63VybxkNIYNLK/nhpM8x5jYoWLQLd5vrZoJpB7MwFh0e0/beXTq
 chJrbxdKYnmVBMEeNqkXKhHYh//eOow5GK/cS267iW0ycdolatiWh9zkHvFQFUQNnUyS+
 ctJ87iac+86KdykYwf1sHno9F9uMRBmNHEApgIqHINi0UUZ3Mbtg+Yvc9qlJOwMDdiKip
 Z3FaTMSPVN5ZRXZ4IU8kyXQTbB1wH/mCVVXmmyC2l3ZkX2sOzWyPH7AzVdiF783cVbw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b="WCq/XDOh"; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=WCq/XDOh
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E927605AC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:12:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 31518108FC3; Tue, 13 Oct 2026 08:12:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791871932;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Q/EZUlOpo8sW7tk40IhUbztqVsd5RFU/d1iNZihBoYA=;
 b=WCq/XDOhbfDD/mzT6p3diDg0gYJM8jV5XT9SW5kpaY6U6eo8VnSwS2VzPLEDvepLrs1aBT
 ZOhSYv3SJUfw0Wm5oktcY/Uoz4XOvawxoeI/yFl+0WZePyGL55o0JL4OEPL5j18Hu7zTw2
 GrloNTdMXWMMWOpzb9jutlOjzdsDenkCLpqz7w6KQ/heMGsWt4KTVhGpb0THhc6Wr5YKeN
 xITDjQCQYTkF8HGvEqOTixC6u4Gx5NDldXuKJss9zA50kuQnxGjx4hID4Le4q7CYtuum//
 zStFJhttbnFC6nyjhs0re03G/7A05rGTR98eye18kksibOE9+OADoAle5wIv2A==
Message-ID: <56382e4e-d25b-66bf-1463-5438588392a6@nabladev.com>
Date: Tue, 13 Oct 2026 08:11:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
From: Heiko Schocher <hs@nabladev.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Cole Munz <Munzzyy1@proton.me>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-5-hs@nabladev.com>
 <CAFLszThWnBLQVZvpDAdD_zD_xDPe0x8ed4peMXpfFF6a13=rrQ@mail.gmail.com>
 <2a7285ce-bc12-043e-8fe6-674d41d1f275@nabladev.com>
Subject: Re: [PATCH v2 4/5] sandbox: spi: let a slave point at the emulation
 it needs
In-Reply-To: <2a7285ce-bc12-043e-8fe6-674d41d1f275@nabladev.com>
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

Hi Simon,

On 13.10.26 03:22, Heiko Schocher wrote:
> Hello Simon,
> 
> On 09.10.26 09:08, Simon Glass wrote:
>> Hi Heiko,
>>
>> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>>> sandbox: spi: let a slave point at the emulation it needs
>>>
>>> sandbox_sf_bind_emul() binds the SPI NOR flash emulator for every slave
>>> on the sandbox SPI bus, whatever that slave is, so a device of another
>>> kind cannot be emulated and cannot be tested.
>>>
>>> As with I2C and PCI, a slave can point to an emulation node via a
>>> sandbox,emul phandle. Its compatible selects the driver. Without the
>>> property, the flash emulator remains bound to the slave node as before.
>>>
>>> Rename sandbox_sf_unbind_emul() to sandbox_spi_unbind_emul() while
>>> here. It is no longer specific to SPI NOR, and the old name would
>>> mislead every new caller.
>>>
>>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>>
>>> drivers/mtd/spi/sandbox.c | 65 ++++++++++++++++++++++++++++++++++++++---------
>>>   include/spi_flash.h       |  2 +-
>>>   test/dm/sf.c              |  4 +--
>>>   test/dm/spi.c             | 10 ++++----
>>>   4 files changed, 61 insertions(+), 20 deletions(-)
>>
>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>>   #ifdef CONFIG_SPI_FLASH
>>> -int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>>> -                      struct udevice *bus, ofnode node, const char *spec)
>>> +/**
>>> + * sandbox_spi_emul_lookup() - bind the emulator standing in for a slave
>>
>> The generic part (following the sandbox,emul phandle) now lives in the
>> SPI NOR emulator, inside #ifdef CONFIG_SPI_FLASH, as does the only
>> non-weak sandbox_spi_get_emul(). So emulating an SRAM, or anything
>> else that is not flash, needs SPI_FLASH and SPI_FLASH_SANDBOX enabled.
>> Please can you move the phandle lookup and sandbox_spi_get_emul() into
>> drivers/spi/sandbox_spi.c, replacing the __weak version? The flash
>> emulator can then supply just the fallback for nodes with no
>> sandbox,emul property.
> 
> I add this in a v3.
> 
>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>> +     if (!ofnode_parse_phandle_with_args(node, "sandbox,emul", NULL, 0, 0,
>>> +                                         &args)) {
>>> +             ret = lists_bind_fdt(bus, args.node, emulp, NULL, false);
>>> +             if (ret)
>>> +                     printf("Cannot bind emulator from node '%s' (err=%d)\n",
>>> +                            ofnode_get_name(args.node), ret);
>>> +
>>> +             return ret;
>>> +     }
>>
>> lists_bind_fdt() returns 0 and sets *emulp to NULL when no driver
>> matches the compatible, e.g. with CONFIG_SPI_RAM_SANDBOX off. NULL is
>> then stored in state->spi[][].emul, sandbox_spi_get_emul() succeeds,
>> and sandbox_spi_xfer() gets -EINVAL from device_probe(NULL) with no
>> hint about the cause. sandbox_spi_unbind_emul() would also pass NULL
>> to device_remove(). Please check for a NULL device and return -ENOENT
>> with a message naming the node.
> 
> I add this in v3.
> 
>>
>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>> +static int sandbox_spi_emul_lookup(struct udevice *bus, ofnode node,
>>> +                                const char *spec, struct udevice **emulp)
>>
>> This binds a device rather than looking one up, so the name is
>> misleading. Also, I2C and PCI do not bind on demand: their emulators
>> are bound by the normal DT scan under an emulation parent node, then
>> found with uclass_get_device_by_phandle(..., "sandbox,emul", ...). If
>> SPI did the same, you could drop the lists_bind_fdt() call, and tests
>> would no longer need to unbind the emulator by hand before devices are
>> destroyed. Here the emulator node is a child of the slave, so it would
>> also be bound twice if the SRAM driver (or the MTD uclass) ever
>> scanned its children. What do you think?
> 
> I take a look into it, but sounds correct.

I think you are right about the shape.

I will implement in v3 your other comments, and I think, that is a series
of its own about the sandbox SPI infrastructure, and none of it is about
the SRAM.

I would send it after this one, with the SRAM as the second user, and drop
the manual unbind from the tests there, where the change can be seen for what
it is.

If this is okay for you?

Thanks!

bye,
Heiko
> 
>>
>>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>> +int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>>> +                      struct udevice *bus, ofnode node, const char *spec)
>>
>> The unbind function is renamed because it is no longer specific to SPI
>> NOR, but this one, which now binds any emulator too, keeps the 'sf'
>> name. Please rename it to sandbox_spi_bind_emul() so the two stay
>> consistent.
> 
> Of course.
> 
>>
>>> diff --git a/include/spi_flash.h b/include/spi_flash.h
>>> @@ -136,7 +136,7 @@ struct sandbox_state;
>>> -void sandbox_sf_unbind_emul(struct sandbox_state *state, int busnum, int cs);
>>> +void sandbox_spi_unbind_emul(struct sandbox_state *state, int busnum, int cs);
>>
>> If this is now a generic SPI helper, it should be declared in
>> include/spi.h next to sandbox_spi_get_emul(), not in spi_flash.h under
>> DM_SPI_FLASH.
> 
> Indeed, move this in v3
> 
> Thanks!
> 
> bye,
> Heiko
>>
>> Regards,
>> Simon
>>
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
