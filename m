Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FAACA9EC5
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 01:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30B786071E;
	Tue, 13 Oct 2026 01:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Sco4vTQWm6j; Tue, 13 Oct 2026 01:23:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 44AF26060E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791854617;
	b=ghfjWu45f61VvKLlemmbAtVUvGKL8P9FNgMlHSp4BneIAZdMVqvQLgqCT4/Jnw5F3gip
	 WxaDFVzATM6Gfk3htx1OxD90p2n3YWutQvOLBwzjGL3glKCu7d/ng7Spx6/sM/Av4UIr9
	 dCdHiELcnvXfMRNH4U28NU2yav8Iyxn146FwCuX04cbs0RhVZ+2K4tyiWlZd4392buyEz
	 EULJayHCyZV46VpSlkBGorc2G8RhBX38BcWbjB1sArI90GLPMeBpPMfLUuQCDnMqkC3xY
	 rmLbRK4hlldzzqzmGoCM5TR63bCYBZyeC+5zvq0lRwQj+hMSNLyRNehnHZqlmujJBqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791854617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7Vq8N40CHMgh6oC7cxIBtsL4O7wGDcDFFtsfeqyT60A=;
	b=BTcFUat5QDNlME31iD5RREz5kZ6bTmixnsqawjAjkI8fNYSi+jwd/nkE3NfmmUyCoMOL
	 ppS4xue2e6mh0uf/+8QWaovKlAPWynRM+hV/CvXgB3PLHY+lkD6CiU+ndDV04zqRWIn7U
	 0wmkNQs/w7z3uTX9GE+DUYHdziw6lwbIkzTe2jccJhdvZfVPqbFuB5/VakQtRWhk3uXKt
	 izZxa8pLXy71TW68ShOb8o8KugOPHGemItoCrlWg05mdIAVfYdk9GoEXtNBEiZHk3PlTi
	 um1BFC8KTCZUZLZd8hQQQUnI4QIRrxSclWljsCqEYfX1+EFFnj1Z4eymmNoaxiKHUhg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791854617;
	bh=7Vq8N40CHMgh6oC7cxIBtsL4O7wGDcDFFtsfeqyT60A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KItrBdrBSymlhooyTy/9bc4y6VTxL1axB1duQ9gKVch8rzHGsgKeZADFSYSmAi3jU
	 5KZkKP/KYd49uQXCf/GHbYULKoiaX3cA3rJeSMXZRsFGixPaHp17PqX6MyEstOcpgs
	 J2I/eN2jP3iyiFABzEJ3keasHIo0R0tP6t0dMEG8ARYplJtQVbXhVUwOSNh6ZtlNX5
	 +DBiOlUFD/gvdrxYp8ZXkaDKm2pWJt3BPZ6fXE9A3qFvBv8LGcZapE1ImCglqyb5qV
	 s994Zqz+40ctgjAzodp8caFdJfqJ5u3P4zWeyJCF/G8irLpW7LYACbYgafcdTLKOAf
	 F5J0kwq/AsdlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44AF26060E;
	Tue, 13 Oct 2026 01:23:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0A332A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92EAB404F4
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIn0TSYTsmVt for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 01:23:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 66F02404F2
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791854615;
 b=R1umPvcoMuGjRWL+zEKmN3uNebdz+j9LTonqNrdtzIwFbsFvN6T8RRtiFj9SFmdzMo2J
 urQZvxoeWo1rjzp5BgksnUmZOCVIAbho9BGnLyMsHXZmxTtfIJlks1Y/VQFXhV4Jyrclm
 idd/OabHVI1bHkh4yqX7tP5Fum8m5W5+yFSif0yOsB+xKsfajFHS0s82M/V0V1LY/U1Mq
 9qE+UmOH9LZ8OzXf/cNz72lJvJOxKSPrkhcozc3t/og+6WCU8aY7VcMYc9V124r5oKNKd
 EataWMkbsvj3+Hp5OmJGC7O88VWmGM6VDw/dp7puoQxq3xPtj+m/H64aS3ogI8DU+Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791854615;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=7Vq8N40CHMgh6oC7cxIBtsL4O7wGDcDFFtsfeqyT60A=;
 b=jayWBQwaGRhgy8RMKw+kIEMPOx4C7k84Iz2SQViYHbJerFkr+rmzFw7bXvnyipg3LoQz
 4X9lWEV29xBwMu0LaZOk/u2LOIS8YIPJMIQmcl8aml42v3oodo4TTa18RJLeENPLEQ+jJ
 m6NisX4CDbEj8GgOIuJ5Yv9338dSIlHfbJj4TLITW7oRUgVzefaI86K1HCyR1MQZ7YfU6
 n7070PGW6n9jG2I3xFzuWvcMURx6KpW8ON1ZQWCHFk9DgwyprqAc1GcT2fKJ5NudasLG1
 qWbBJVi0DcrCHFMqfTUNAAe4puI85W4OisBu9TrP3q4rYU9DNRHqHRa/4Ba+0aZCcng==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VFRkPdvX; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=VFRkPdvX
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66F02404F2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 01:23:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B88CB108F15; Tue, 13 Oct 2026 03:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791854612;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=7Vq8N40CHMgh6oC7cxIBtsL4O7wGDcDFFtsfeqyT60A=;
 b=VFRkPdvXx7dDyPg3yBaT/Y2Y1HiK/9U7rXLvebMke36mi5Rlo0H3bBHGvroIfnIAvjciut
 ZnonYFF+cboASWmnOW1E/9V5hrVpo5XWAA2J/wpYKJjLR6+Inxo50SB97uCoZEB+VcDHHt
 0Mbmx2+yYlYVblEIDKGwnC1WeKlLaI1zgbNQctHc5aulTR3y05LkQmSYwKJaACWENM18ta
 UizGtdPm0Ck2dDWR1Hh1UwJatNRyqlCRHhBgYXGa2E60s0Jr/LDN8kt4TX0w+cEWzrOjZg
 CS6nre60CdgKjzgqR6W+PKPiiqBHtjfWLiePEOhIPdL2HFuI45A7qoNhdzAMwg==
Message-ID: <2a7285ce-bc12-043e-8fe6-674d41d1f275@nabladev.com>
Date: Tue, 13 Oct 2026 03:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 4/5] sandbox: spi: let a slave point at the emulation
 it needs
Content-Language: en-US
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
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAFLszThWnBLQVZvpDAdD_zD_xDPe0x8ed4peMXpfFF6a13=rrQ@mail.gmail.com>
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

On 09.10.26 09:08, Simon Glass wrote:
> Hi Heiko,
> 
> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
>> sandbox: spi: let a slave point at the emulation it needs
>>
>> sandbox_sf_bind_emul() binds the SPI NOR flash emulator for every slave
>> on the sandbox SPI bus, whatever that slave is, so a device of another
>> kind cannot be emulated and cannot be tested.
>>
>> As with I2C and PCI, a slave can point to an emulation node via a
>> sandbox,emul phandle. Its compatible selects the driver. Without the
>> property, the flash emulator remains bound to the slave node as before.
>>
>> Rename sandbox_sf_unbind_emul() to sandbox_spi_unbind_emul() while
>> here. It is no longer specific to SPI NOR, and the old name would
>> mislead every new caller.
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>
>> drivers/mtd/spi/sandbox.c | 65 ++++++++++++++++++++++++++++++++++++++---------
>>   include/spi_flash.h       |  2 +-
>>   test/dm/sf.c              |  4 +--
>>   test/dm/spi.c             | 10 ++++----
>>   4 files changed, 61 insertions(+), 20 deletions(-)
> 
>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>>   #ifdef CONFIG_SPI_FLASH
>> -int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>> -                      struct udevice *bus, ofnode node, const char *spec)
>> +/**
>> + * sandbox_spi_emul_lookup() - bind the emulator standing in for a slave
> 
> The generic part (following the sandbox,emul phandle) now lives in the
> SPI NOR emulator, inside #ifdef CONFIG_SPI_FLASH, as does the only
> non-weak sandbox_spi_get_emul(). So emulating an SRAM, or anything
> else that is not flash, needs SPI_FLASH and SPI_FLASH_SANDBOX enabled.
> Please can you move the phandle lookup and sandbox_spi_get_emul() into
> drivers/spi/sandbox_spi.c, replacing the __weak version? The flash
> emulator can then supply just the fallback for nodes with no
> sandbox,emul property.

I add this in a v3.

>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>> +     if (!ofnode_parse_phandle_with_args(node, "sandbox,emul", NULL, 0, 0,
>> +                                         &args)) {
>> +             ret = lists_bind_fdt(bus, args.node, emulp, NULL, false);
>> +             if (ret)
>> +                     printf("Cannot bind emulator from node '%s' (err=%d)\n",
>> +                            ofnode_get_name(args.node), ret);
>> +
>> +             return ret;
>> +     }
> 
> lists_bind_fdt() returns 0 and sets *emulp to NULL when no driver
> matches the compatible, e.g. with CONFIG_SPI_RAM_SANDBOX off. NULL is
> then stored in state->spi[][].emul, sandbox_spi_get_emul() succeeds,
> and sandbox_spi_xfer() gets -EINVAL from device_probe(NULL) with no
> hint about the cause. sandbox_spi_unbind_emul() would also pass NULL
> to device_remove(). Please check for a NULL device and return -ENOENT
> with a message naming the node.

I add this in v3.

> 
>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>> +static int sandbox_spi_emul_lookup(struct udevice *bus, ofnode node,
>> +                                const char *spec, struct udevice **emulp)
> 
> This binds a device rather than looking one up, so the name is
> misleading. Also, I2C and PCI do not bind on demand: their emulators
> are bound by the normal DT scan under an emulation parent node, then
> found with uclass_get_device_by_phandle(..., "sandbox,emul", ...). If
> SPI did the same, you could drop the lists_bind_fdt() call, and tests
> would no longer need to unbind the emulator by hand before devices are
> destroyed. Here the emulator node is a child of the slave, so it would
> also be bound twice if the SRAM driver (or the MTD uclass) ever
> scanned its children. What do you think?

I take a look into it, but sounds correct.

> 
>> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
>> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>> +int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
>> +                      struct udevice *bus, ofnode node, const char *spec)
> 
> The unbind function is renamed because it is no longer specific to SPI
> NOR, but this one, which now binds any emulator too, keeps the 'sf'
> name. Please rename it to sandbox_spi_bind_emul() so the two stay
> consistent.

Of course.

> 
>> diff --git a/include/spi_flash.h b/include/spi_flash.h
>> @@ -136,7 +136,7 @@ struct sandbox_state;
>> -void sandbox_sf_unbind_emul(struct sandbox_state *state, int busnum, int cs);
>> +void sandbox_spi_unbind_emul(struct sandbox_state *state, int busnum, int cs);
> 
> If this is now a generic SPI helper, it should be declared in
> include/spi.h next to sandbox_spi_get_emul(), not in spi_flash.h under
> DM_SPI_FLASH.

Indeed, move this in v3

Thanks!

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
