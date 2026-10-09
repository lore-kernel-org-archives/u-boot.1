Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98879CA601D
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49DF5408B2;
	Fri,  9 Oct 2026 16:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nk2NLrJA6h1D; Fri,  9 Oct 2026 16:53:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 36D6540877
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791564786;
	b=NL0ONp5lzLD3CWYdHegNy4oVcVl8vvZxJn/rrQ1Z0ZpVuAtoGWdWGJwgzczwqRvY/nFl
	 1b03YDsDhLe+dd0WgjCPl6VNpivswbP0gDxInNJEhcmP2fgTA0BZciu5Dx5N8FUqeME2F
	 KxJHoDBS+3E6cekNTC1vfWir9hSqanY5i1ZqMDrb32rVfYPW4of6f6B8fkpdOZUMsFmnl
	 0FbXWkVPO5bC+o/VS9Yop2ilIVow7sN9KT+w4cVAmDc0a0XyIFGwcLUi06+n4gV8uz0//
	 vd6ljTAXzJvuCu9L8X60ssAQfBWO39Ew8fyAGa0keJoL6De5b9tPxEi9eLMAvXAekUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791564786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GKUrs0DiPidh0oCR6t2HoErvfoUNb09Qd1pAal6Rj7E=;
	b=BvmXBQT/zJpLxlIZkrTQ8q7kcwtFx1IxISegaFOf3/2ruSzuIPlKmB7R+iYZi5zX6ZNx
	 Ct+wvFSHIK2uZL819742uZgHi+0s270ioig/IersLq2I+eAUO5vpB1s+usiepC6Wdt1nM
	 sOsUgXCBqSz88Ji39QL3lyKLtjdUJ7R13Krh3wpauRAu0SDi47f8PVoeR6jP5XHftIOBF
	 PsWef3+x4V+18pV5wgUR0fhZ0mfZ/zEOWXiou7VKdGhNkISZfss/B4DlYWpHXkI9yK/pG
	 OnfR2fVctAWyI00hBJvSGcBV1L1W+kgrXNiLwttZalce9FmB2NhrS1SE/xjXhCc6cgw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=AsnKaxVN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791564786;
	bh=GKUrs0DiPidh0oCR6t2HoErvfoUNb09Qd1pAal6Rj7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rKCndVUDowxlRDEU30B7uiKrFFAUue71Uu2e3qBqTROLvj6VKq6UohSAW/EO196zG
	 Tg9nPmCUdU56lVbUeONSABAzSBWawWvBKCAWJ8PqNUTtIg/NjxzW4JsTQrc1/Phsts
	 tS8YlPTWC2XsUUVk27WEXP2wN1cy66Ao5MuF68fxpinkGW/LoBmgrmq/UPpTXvEwbN
	 0Jqt1tbUqR0gdrASu06OCazf+8lBh8obiYpwndva4y4dxj2AkpNBuGy4Z97Rh5dnrL
	 N4JgzqRGZ4RK3ddAAjQ/zUdysqoctT1GnTx97JgCVMG5+G0BW7sJzljfJm24ZgCju/
	 Dmmq5bXyFZkVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36D6540877;
	Fri,  9 Oct 2026 16:53:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B28E72AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3F8540877
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:53:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eopw9V3aOPoz for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:53:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5126540874
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791564783;
 b=gsnwWPzyb9bKcwtR0akmgAWCAv9p7FPAssJYjsklqVnCPxNuO7pwYHjc5wJ9NqveBG5m
 wX8Qwbvgn8M2ecqKeoKAzivOs4ffh6utbzfKNYR897XfSPdegYjSRNurgXyJZ/VknumRS
 RNdfT3FPCyBBN6OPNn+72cTJdrBfd8J2C5zvUm0RTyb7VodpWgoZIeQOddov+ArsuAkaq
 YQT9M50kEZt255CFpoXquE6udYtsR3cEQ6Isz+c2wQU4qJh2iyS29ac0wYOEdp+V8GwM+
 lfkTg+Goqu+pwpKGtLToD6K4Jrs4ZEUbv6cfJe2LHOGZoqagEct4LwjmA7DQKywKFrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791564783;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=GKUrs0DiPidh0oCR6t2HoErvfoUNb09Qd1pAal6Rj7E=;
 b=bFaF3+KRkgYYkMg6EUHUUswV3iU2MHmSkYOIV1VbT7sEAxnigzmtV0R6bzLBCwOoyRYV
 brb3izaXJj7PE+HuK5ccBHS+jq7cFzgKKVPi1E6jvMwhtozsy1e2kvnoGm/qhoV7gSZvZ
 GWCFne1qFXA9+slqxKu3VVQNj2NUqGfail3cSdgQxxT9iW4IlboGGCs4hvwzyKFjBAtlr
 efxjTP4cD2Q8eQuOsQmG7QPLQfBCegd07I/I/spH/UR/wILx6qb4uP4MJF2sPoRQhYzVN
 zRs4YsLmQRNIVBezQnmvdENVIbPHtU5MpH8g3BNa0mKMB7g2hIP1GeasPTWS7g1Qq2Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=AsnKaxVN; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=AsnKaxVN
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5126540874
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:53:01 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C54CF4E41151;
 Fri,  9 Oct 2026 16:52:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7C8CF60754;
 Fri,  9 Oct 2026 16:52:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1545311D7071B; 
 Fri,  9 Oct 2026 18:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791564773; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=GKUrs0DiPidh0oCR6t2HoErvfoUNb09Qd1pAal6Rj7E=;
 b=AsnKaxVNwz2064LXoXvTWrzcB4cBl9JB61wpatXNhDXN7WR4Gq4Ep4u6m+jbr7ZNwUqxkq
 60SaTjTo1AWWALCQ86VnDqqtyCqIV0Qh+chVXsLmUQwOt8b3PDTl5T6UnVWvnp3h/Ane+L
 nnXH5SMyRGmx+Q2GM+ifZdDwKHD3A0u0vrS/9E+wkxJD0mLC22t26YoG+1+9jQwWAXmte7
 t14oFDBxNzPwrAG/Om3pSL6XIg9ObTlq4k/j94g3DBU6nxIEDGuu8gEqv/qqDf5tx93q6v
 bV2XZAm6t7sP7ovjSTkDhfhezYzY6bDjpUJG8xAgcgSo1kQdiOH2T9y/P60JFw==
Message-ID: <d3edafc1-8a7b-41a9-8805-c155ba799d54@bootlin.com>
Date: Fri, 9 Oct 2026 18:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/22] Introduce resume for J7xx SoCs
To: Tom Rini <trini@konsulko.com>, "Padhi, Beleswar" <b-padhi@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
 <20261008234037.GA1328652@bill-the-cat>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20261008234037.GA1328652@bill-the-cat>
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

[add Beleswar]

Le 09/10/2026 à 01:40, Tom Rini a écrit :
> On Thu, Sep 24, 2026 at 02:35:11PM +0200, Richard Genoud (TI) wrote:
> 
>> This series allows J7200/J721s2/J784s4/J722s to resume from suspend.
>>
>> On those SoCs, a magic value is set in a PMIC register by the DM
>> firmware just before suspend, then everything but the PMIC and DDR is
>> powered off.
>> At resume/boot time, the magic value has to be read back by U-Boot SPL in
>> order to know if we are indeed in a resume situation.
>> That's the purpose of j7xx_board_is_resuming() introduced here.
>>
>> Then, if the SoC is resuming, the DDR has to be brought out of
>> retention, at full speed and get out of low power mode.
>> Between those steps, the DDR_RET pin has to be de-asserted. But the
>> DDR_RET pins of all DDR chips are tied together on a single GPIO, so
>> it's impossible to resume one DDR chip after the other, they must be all
>> resumed at once.
>> That's why it's orchestrated from board_init_f() and not in the k3ddrss
>> driver.
>>
>> Once the DDR is fully functional, the next steps are:
>> - retrieve the LPM memory region from DTS
>> - authenticate certificates from LPM memory region and apply firewalls
>> - ask TIFS to restore TFA and its own minimal context
>> - start TFA on remote proc
>> - load and jump to DM
>>
>> Disclaimer:
>> ---------
>> There's a potential attack vector in this sequence, because OPTEE could
>> be modified before being reloaded.
>> Also, if the certificate replay is skipped, then TFA can be read from
>> MSMC.
>>
>> Patch 1 and 2 are from AM62 LPM series:
>> https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com/
>> Patch 1 adds support for DDR in self-refresh for am62/j722s
>> Patch 2 adds capability to call TI_SCI_MSG_MIN_CONTEXT_RESTORE
>> Patches 3-5 add LPM helpers for all SoCs
>> Patch 6 adds the resume detection for all SoCs
>> Patch 7 adds common code for DDR retention pin
>> Patch 8 enables GTC at resume
>> Patch 9 detects IO+DDR resume state for j7200/j784s4
>> Patch 10 stores the wakeup reason in MCU_PSRAM0_RAM for j7200/j784s4
>> Patch 11 sets the PMIC NSLEEP triggers
>> Patches 12-14 add the DDR resume sequence for all SoCs
>> Patches 15-18 add the resume flow for all SoCs
>> Patch 19 updates the pm-cfg and schema to a new version
>> Patch 20 removes now unneeded background firewall on DDR for j7200/j784s4
>> Patch 21 extends the firewall for ATF region to TIFS
>> Patch 22 add the resume flow documentation
>>
>> Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP
>>
>> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-min-context-restore
>>
>> It needs lpm_memory_regions described in DTS [updated to v4]:
>> https://lore.kernel.org/lkml/20260921145325.300025-1-richard.genoud@bootlin.com/T/#t
>>
>> It also needs a bootph-pre-ram property in PMIC-B for j721s2:
>> https://lore.kernel.org/linux-arm-kernel/20260429-k3-j721s2-som-bootph-pre-ram-pmic-4c-v2-1-31a0e7677216@bootlin.com/
> 
> Given these needs, should it wait to be merged until we can pull in a
> devicetree-rebasing tag that contains it all? Thanks.
> 
The bootph-ram property has been merged.
And for the lpm_memory_regions, I've talked with Beleswar during ELCE, 
he'll have a look at it.
That said, I agree that it should be at least fully acked in Linux repo 
before merging it to u-boot

Thanks!

Regards,
Richard
