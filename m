Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF14606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0CHtmGqE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EQw12ZUU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E64B380F8B;
	Fri, 27 Nov 2026 17:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xycNDY8C6Jpt; Fri, 27 Nov 2026 17:09:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF07381222
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795799398;
	b=NiK4eayvgpEz+5Gq/qz6F9zD3BFGDnUVODlkA2y+8cc7DkAG8bEGMgEc2NCB2KYV5Ed+
	 sB7rHZMrIcNUY1GzShJEPEq9gmAyFzB1YflLZZZMwTLXZoN1JtkvXRDwSgErwTZuBuVP1
	 hMCpGo77ZzdxARnml4b5EV+JZSN8y8/5hgXW7q8xDfJnjGTtDk6v4x/Vx/0hXJMbf7DC5
	 gCnXd31/sM/GJ1i1WS1CdZX+fPrHgYGCBGmPbyCvmu7JC7fQAEnKt5zmnCrGkPojAlhV3
	 4d5y3jNvRw0+s/ETR36bU9xk3Fjyh0jpZ+RbCepa4Cf9NzhlFUsgo5it6lPwU8O401g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795799398;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bXLwA9xrfo/BweMNLIP0N/LDdZV/qNmOa1BLEem6I1s=;
	b=B0xtxq2DPjRDCyZzTkaPsWpbFkEaGzWvblBAerIfY69uUtxYsrE1YZmlXRzG4nHRmZPw
	 wCLNO8aJsyUHCABipbug46osN3FA1jbalUDmrH61ER/w2LsxQk/ITkXJTCd1jW8SjODdL
	 QJvPQnVLWd7XtrnOXpsOS/KIAiGlZmyRKjaRdPyPgksJrmhcSLWuKQpWf0BK6q6Yzt/XI
	 sj2Fyd0ZEzU6NtJlNRXiw4DXaQ0yxBk0nBkTRSmZxpjy6wvfXkZkLVJvACH1XfkKkG/sZ
	 H5gEq1YsxcqYPbF0b5Ul1mnOu0+8FCqXzxnqGLmaqTHw1j4ocwV/5MF0tGijg+fBQxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EQw12ZUU;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795799398;
	bh=bXLwA9xrfo/BweMNLIP0N/LDdZV/qNmOa1BLEem6I1s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0CHtmGqE4u6JzLT3wZ9+UYJCZ8vV2Ct/wXT8A2Sd2BacyQe4vhFf6XfMrsz+GWV1N
	 ZGuPIrXgSr9UczHpJSxbCF5zXnmF7fqN7aussjzww7rurAuqMEA6aGHOxYplEdcJmM
	 +TsdpaMxtW1OT392QhRaLGO9dTPZflkK/p3WrL0tIf8LcoeBwUetFTH+yXBQdqX2DL
	 xm1fPZHBwcwig+NJQZi8WKuWuL78DyVlqw30kieZ0qA6knLbswuFVLfrgZI0/m5Kja
	 Ni/znRE4bN39ORFIgbH5ppLlGb/sYwIMxISK7VwtY2xAAAKQMTpBNQ1LW+Y0wS2UU7
	 vynGALaiLmdmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF07381222;
	Fri, 27 Nov 2026 17:09:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EE6526D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 349BD81222
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ooIgKadjbRSb for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 17:09:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CBF2F80F8B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=95.215.58.87
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.87;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=EQw12ZUU
Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBF2F80F8B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 17:09:51 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=nVtJWr8+5fUMY41S6hWWDHBZUMh0fhaJWk/8j3XhhJ0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795799390; v=1; x=1796404190;
 b=EQw12ZUUbLwtWdSsza5xwKWeGFc2cLf361sU/LUh7t3a1V/+sT8/7JfkUWb38ZGnj4LN6tuM
 ro1LdjyQYnCpLfpb9lqoX6/UztBnL0Bc6ZkJZ6+sn34GOB1HaN820VeZH8fKVsQJBMp0BQTGWOQ
 Z2GoCRnzk+pzgsnNS6RSHjGM=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 727bcf3c55617ef9;
 Fri, 27 Nov 2026 17:09:50 +0000
X-Mizu-Trace-ID: 727bcf3c55617ef9
X-Migadu-Flow: FLOW_OUT
Date: Fri, 27 Nov 2026 17:09:46 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Jaeyeong Lee <lee@jaeyeong.cc>
CC: u-boot@lists.u-boot-project.org, Heiko Schocher <hs@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_serial=3A_mpc8xx=3A_prevent?=
 =?US-ASCII?Q?_DPRAM_overlap_with_SPI_descriptors?=
In-Reply-To: <f917b336-db53-4bfa-9caf-11827755ff03@kernel.org>
References: <179024275173.70674.16356876476594066413@proton.me>
 <179579209485.3201180.9953622119991566579.u-boot@jaeyeong.cc>
 <f917b336-db53-4bfa-9caf-11827755ff03@kernel.org>
Message-ID: <FF2851D9-8090-4FEA-913C-6C5F45FC133D@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27 November 2026 16:42:16 GMT, "Christophe Leroy (CS GROUP)"
<chleroy@kernel.org> wrote:
>Hi Jaeyeong,
>
>Le 27/11/2026 à 16:08, Jaeyeong Lee a écrit :
>> [Vous ne recevez pas souvent de courriers de lee@jaeyeong.cc. Découvrez
>pourquoi ceci est important à
>https://aka.ms/LearnAboutSenderIdentification ]
>> 
>> The MPC8xx serial object starts at DPRAM offset 0x800 while the SPI
>> receive descriptor starts at 0x840. The serial receive buffer begins at
>> offset 0x14 and is followed by the one-byte transmit buffer.
>> 
>> Limit SYS_SMC_RXBUFLEN to 43 when MPC8XX_SPI is enabled. A value of 44
>> would put the transmit byte at 0x840, and larger values also overlap the
>> SPI descriptor with the receive buffer. Add a static assertion to keep
>> future layout changes from reintroducing the overlap.
>
>Not sure we need something so sophisticated. No defconfig redefines it so
>everyone uses it likely with the default value of 1.
>
>Just limit it to 32 regardless of whether SPI is active or not, that
>should be enough. I don't like the idea of a dependency between the two
>drivers.
>
>We don't need that assert, it should be enough to put a comment close to
>the definition of CPM_SPI_BASE.

Not wrong. Thanks for the review

>
>Christophe
>
>> 
>> Link:
>https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fu-boot%2F179024275173.70674.16356876476594066413%40proton.me%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cdff89d20fc924d5d92df08df4c98563f%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639313889303482082%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2BX3U4TMa8vSsaduwcMtKmvbp9U8ghNs1OgNAws11K1k%3D&reserved=0

Uhh, your mail client is not doing good things Christophe :(.

>> Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
>> ---
>>   drivers/serial/Kconfig         | 4 ++++
>>   drivers/serial/serial_mpc8xx.c | 4 ++++
>>   2 files changed, 8 insertions(+)
>> 
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> index 9ebc251d891..73c36ea79b0 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -1201,6 +1201,7 @@ config SYS_SMC_RXBUFLEN
>>          int "Console Rx buffer length"
>>          depends on MPC8XX_CONS
>>          default 1
>> +       range 1 43 if MPC8XX_SPI
>>          help
>>            With CONFIG_SYS_SMC_RXBUFLEN it is possible to define
>>            the maximum receive buffer length for the SMC.
>> @@ -1208,6 +1209,9 @@ config SYS_SMC_RXBUFLEN
>>            If using CONFIG_SYS_SMC_RXBUFLEN also CONFIG_SYS_MAXIDLE
>>            must be defined, to setup the maximum idle timeout for
>>            the SMC.
>> +         When the MPC8XX SPI driver is enabled, the receive buffer is
>> +         limited so that it and the transmit byte do not overlap the
>> +         SPI buffer descriptors in dual-port RAM.
>> 
>>   config SYS_MAXIDLE
>>          int "maximum idle timeout"
>> diff --git a/drivers/serial/serial_mpc8xx.c
>b/drivers/serial/serial_mpc8xx.c
>> index 9ce3fc3d9ec..feb0c905594 100644
>> --- a/drivers/serial/serial_mpc8xx.c
>> +++ b/drivers/serial/serial_mpc8xx.c
>> @@ -36,6 +36,10 @@ struct serialbuffer {
>>          uchar   txbuf;  /* tx buffers */
>>   };
>> 
>> +static_assert(!IS_ENABLED(CONFIG_MPC8XX_SPI) ||
>> +             sizeof(struct serialbuffer) <= CPM_SPI_BASE -
>CPM_SERIAL_BASE,
>> +             "MPC8xx serial buffers overlap the SPI descriptors");
>> +
>>   static void serial_setdivisor(cpm8xx_t __iomem *cp, int baudrate)
>>   {
>>          int divisor = (gd->cpu_clk + 8 * baudrate) / 16 / baudrate;
>> --
>> 2.43.0
>> 
>> 
>
>

--- Thanks!
