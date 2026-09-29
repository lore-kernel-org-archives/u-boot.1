Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015E7CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 05:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84C0640577;
	Tue, 29 Sep 2026 05:10:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QTjEuiNyAVy; Tue, 29 Sep 2026 05:10:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AD35540557
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790658641;
	b=iY1AopQCLL8vLBmd8tzFARHTW1eHPWFfttVtOynpN0PtfB+kk1IZ43udOmZQjnTxZfm/
	 cu/hq0ddTXY+9HbGnzNe9AkpYN5cBDtnwp5kcBC7xbxKuptqP5dSf8KD4yarxeWznVPH4
	 9LrGf1XD8sVtW3s5i0zJ1DV0qNZEgx3u39fINy/jTURP2LHjdwSzKN97MRtwRqNyyJQFs
	 IbILoWiDRSz1bvRtVdU30kilTTFvnXblN7X0z4WP/ZuXTgxqHooSQLGjdZdxouMT3/tjm
	 YarAKRE62lqjC5WqC6pPdHZ7i4KsRhrGYRmkJeLWk33JT4rqsb/MRRFdD96MueRcuWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790658641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s5J8mUtSrtM5MLRERB94ilbkrUiODARDUgu6wsIQoTI=;
	b=Yzi5ILMfdsHj+TNgSDepAONUdtbkv1kerL9LshEbmJrU54c+YMWRrsoEz4W+OsFH0FWz
	 ASK0sCgCEgkCd0+7v7A+1EkuohA1AUeBYBzuig1d+EQc+0rwCI5iFN4PLdwHldHUhxjzn
	 riG1sGuqEhMyCDmRTLachyPkP+IfzgHakkz1CqUmyGDTn7Tu4OLwMYWUC1lfavb44jQs3
	 7MFsz4J187niGG0BXHzixy3zYnconRMZVqlYLRP1X04LpH9QcFFWWi0RtvXj5g32xn8lf
	 i37siL+WnScQIOAVbj2qZtVH7H1S/0qdGZB2PizK5VDAAFmkC0+0fTeAfV9uarEGWzg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790658641;
	bh=s5J8mUtSrtM5MLRERB94ilbkrUiODARDUgu6wsIQoTI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VGaKIN8eDjwFoRNpDSVfh7jVHv3oRLAtNB5jXu9hz7aFUkPsIayq3uBzwMQYhLU7N
	 rXSAtiletw9Q7qbPLA1i3OB1ef7ZcwWHq3GjHUAANawraYJ5E6Ao2AYLgJDPDangaN
	 AdGR+2FmB8BQ05PjWuf9L+Ny+ggK38LcHeg3nTEOr2NLhuKlDzwZeQVnIVbWmrlxd/
	 rDV8shqOJvIFdcOMpazyZihh64XfSoid+LLG2eV9qMuLpRes7fkIPlX2jg8ay/GKU5
	 uA5LuEvqJsZDf/DvD+qsgDGLBDwHXahhPARqMhLLOr+f39p64VwDtMrkPKAWIiQ0c6
	 EiBfw4QFn5C/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD35540557;
	Tue, 29 Sep 2026 05:10:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B75332A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20CF76070E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:10:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqKuN5IftfoF for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 05:10:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2AF0F6070C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790658639;
 b=Nh1qOaqCJqAZX+tAH7IZ0iBiRiLqyjxBNoKr2FE9chGKz2A1vC5feB7/XYkGPTjJ1G6A
 1MufC3GsNv4GD8w/jXMBxcj4OlQUCNLAl0wvy+UjBcY+NvE7SdxvA+4HucOGvEYfKSuAL
 DsMEWLvbbp1i632zr8gOOMXCvBb98k/Aj0lF2Vs06eL3opVI4shnDSZ3lT63yCG6GnAyi
 C1t5ziX4W4VNjPDhf3ZZ14MClMzM25LWGBX7HRMP1zC/Ablf0irdjHTkdS3QYJN6OpEbE
 3jrDnP5THCqz65NY9HUiHpmNGyXo/hVgbsjEXw2Y6uQJs9CX60XmGrUsvyMeJuOSYhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790658639;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=s5J8mUtSrtM5MLRERB94ilbkrUiODARDUgu6wsIQoTI=;
 b=qFmgDN4O8GVsqPUxljEpifwoHSroehhxc1PP+CXgwL0bq4Uikb5Ia9jLzDIlS2P+DPbt
 fV2HEWgWXgyVUPaYcRtkeHXv6tDWZee1dZggg1bST+FLs6iwk+4FF//kv+3nNVbPPy3EO
 yEStO/tzNzT6bMnmOP8KFvt7YtOWaIH3L8BeUTQiJojDMcV9tDY/+evuTl1bI65Trz88v
 pXf6R6RD6pilz5/tDepYcnZVX+/xHEYohZduvgGxlWzFFymoKBPbf3c+0xZPiY9E4roHk
 2Cxfk3amFwDmCxMVAuglKbZKrIFuJezrTARsQ4YDnImogxU7GUCBUgTZQLnetGeFVNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=jeftfMDi; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=jeftfMDi
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AF0F6070C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:10:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 63427105038; Tue, 29 Sep 2026 07:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790658632;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=s5J8mUtSrtM5MLRERB94ilbkrUiODARDUgu6wsIQoTI=;
 b=jeftfMDidPH2cNJ3Ta7fg9dn+gHNPHW+x87rc79U5mgJM7oAnTSiKF9i4ELTmHSGv4TOlP
 m5q4to4aaGiNgFOj6JeHTwofLydZDrIYzKJ4wrsqpnIUc80RWSden4h+jon8yxR6e7XpEF
 fL6NN5kLE4wI68hfdi+JOckku+h0Z+q0kDLk+5i6ZLYikcuZXdgUOTUGtAzzpG39uICMON
 XXemFwI+u4bPYQm7ZSmP5U66sZiXOBY5+xgwj4AEEk8RNkBZlyAtYJbAybiEcsZqwaGpWH
 9b2na74nGyauOtdy/LWF/L09si2uUPk9RHw3/dhqwo+tVgGEoo2kQrF6c7Bv2w==
Message-ID: <ac781a95-2a81-dd6a-4942-86a6c73fb3d3@nabladev.com>
Date: Tue, 29 Sep 2026 07:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 3/3] test: dm: add a test for the Microchip 23LCV1024
 SPI SRAM
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Vignesh R <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Anshul Dalal <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 James Hilliard <james.hilliard1@gmail.com>, Johan Jonker
 <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
References: <20260922060941.534035-1-hs@nabladev.com>
 <20260922060941.534035-4-hs@nabladev.com>
 <CAFLszTi6JG=Xf8Q5Sz9hwrMr+nK6jbkwP4n02GHOVnUfs0mN4g@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAFLszTi6JG=Xf8Q5Sz9hwrMr+nK6jbkwP4n02GHOVnUfs0mN4g@mail.gmail.com>
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
>> test: dm: add a test for the Microchip 23LCV1024 SPI SRAM
>>
>> Emulate the device on a second sandbox SPI bus and exercise the driver
>> through the spi_flash uclass.
>>
>> The emulation implements byte, page and sequential operation and
>> advances the internal address counter the way the data sheet describes
>> for each of them. A transfer running past the 32 byte page of the
>> device therefore only comes back unharmed once the driver has selected
>> sequential operation, which is what its probe is for. The test asserts
>> that mode directly as well, so a failure says which of the two went
>> wrong.
>>
>> The erase is checked on both counts that matter for a device that has
>> nothing to erase: that the area reads back as 0xff afterwards, and that
>> the fill stops at the end of the range it was given rather than running
>> into the data next to it.
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>>
>> arch/sandbox/dts/test.dts         |  14 +++
>>   arch/sandbox/include/asm/test.h   |   8 ++
>>   configs/sandbox_defconfig         |   1 +
>>   drivers/mtd/spi/Kconfig           |   9 ++
>>   drivers/mtd/spi/Makefile          |   1 +
>>   drivers/mtd/spi/spi_ram_sandbox.c | 189 ++++++++++++++++++++++++++++++++++++++
>>   drivers/spi/Kconfig               |   2 +-
>>   test/dm/Makefile                  |   1 +
>>   test/dm/spi_ram.c                 |  96 +++++++++++++++++++
>>   9 files changed, 320 insertions(+), 1 deletion(-)
> 
>> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
>> @@ -0,0 +1,96 @@
>> +     /* Now erase the data itself, over more than one staging step */
>> +     ut_assertok(spi_flash_erase_dm(dev, SPI_RAM_OFFSET, SPI_RAM_LEN));
> 
> The comment does not match the code: SPI_RAM_LEN is 100 and
> SPI_RAM_ERASE_STEP in patch 1 is SZ_1K, so spi_ram_erase() runs a
> single iteration here. If the intent is to cover the staging loop,
> please raise the length past SZ_1K (or drop the staging step for the
> test); otherwise reword the comment.

Good catch... Hmm.. I rework this too, as I drop the erase function.

> 
>> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
>> @@ -0,0 +1,96 @@
>> +     bus = dev_get_parent(dev);
>> +     emul = state->spi[dev_seq(bus)][SPI_RAM_CS].emul;
>> +     ut_assertnonnull(emul);
>> +     ut_assert(sandbox_spi_ram_is_sequential(emul));
> 
> Please use sandbox_spi_get_emul() here rather than reaching into
> state->spi[][] directly - it already knows how to locate the emulator
> for a given slave.

I will do.

> 
>> diff --git a/test/dm/spi_ram.c b/test/dm/spi_ram.c
>> @@ -0,0 +1,96 @@
>> +     /*
>> +      * Since we are about to destroy all devices, we must tell sandbox
>> +      * to forget the emulation device
>> +      */
>> +     sandbox_sf_unbind_emul(state, dev_seq(bus), SPI_RAM_CS);
> 
> The name sandbox_sf_unbind_emul() reads as SPI-NOR specific, but after
> patch 2 it is used for any SPI slave's emulator. Please rename it
> (e.g. sandbox_spi_unbind_emul()) in patch 2 and update the callers, so
> this new test does not entrench the misleading name.

I look into it.

> 
>> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
>> @@ -1672,6 +1672,20 @@
>> +     spi@1 {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             reg = <1 1>;
>> +             compatible = "sandbox,spi";
> 
> Please add a spi1 entry to the aliases block above, so dev_seq(bus) is
> deterministic rather than depending on probe order - the test relies
> on it to look up the emul.

I add it.

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
