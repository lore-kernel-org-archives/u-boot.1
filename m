Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01665606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zGk8HZ/n;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=l8iIWPHp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F0A9407E8;
	Wed, 21 Oct 2026 07:37:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sbl-VkYcC2DK; Wed, 21 Oct 2026 07:37:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D1C98407D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792568271;
	b=ezWKy13QEfKkVOCi20WcywzW7cGZccyCUVoGfaQ0yFGem6pxrh9h63c0YjBV1fA0tG2k
	 jpuiKXRYIntniJ3fm2rIi6dcynK5zG6vK8a3K14t6cn5NLU6gTyhvfaQz7o+mrcDxxg4X
	 gtOXlAHMkM2TKCDWBfGKJDs+vCgmzdNl7pgU4M6IbadlPPJDVv5Fb9CsilAOMwqLEytJ1
	 Qs/K7QP09TaVTN+q1HrKVzf9BirnI7ls+dDwJaoI1gkqq1qnt6GVlf+oUDSqKDxcE31ir
	 NAdE8OyHXumGs+k6N6M7zYIFQvuViUk9PH9fDOQuEY68dAQOtQpGJOvpJrQdK54c+Iw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792568271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jb5SXbMy0ExIJu0JOrTCQ94yXzdnhxCRuHh3hI+Oxoc=;
	b=jvMmDroR5bjcfEgEFmhgvfTHAMoEPplX5ZxWpJFLNMXAv4YBFKlQvohpC4hoD9aNMFEE
	 1FRJI3bqVJPzZDwShXTeKoQ7jNGuaWxdGrbZAMUdCtTwSli3zI/wQXb3WpxfLWF9lr+4B
	 h945wt0GB6uN/L6jnAbKy7Riu99fNGdTWMQTMuGt5Z+8kBDQ0btRN1n/oiKeVBU2OsccY
	 CSOUQSxMxYG5mZ0ykCRRavfKxpUfW3QIhqyyoj2bim2Q+nn03r/LpCb3DUFHW6bZUhhZ0
	 67a6h77BEvlf8ljPYHXo3NVNUXNLKirz2AY6wTEwfFWujeXavo6lv69i60cuzFZxdLA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792568271;
	bh=jb5SXbMy0ExIJu0JOrTCQ94yXzdnhxCRuHh3hI+Oxoc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zGk8HZ/nUDq1YqG4bYjGDuNXqJE6cVIPWLDKYnT5OAccPLhZL6+5ERN1AWEPvpOhS
	 yzkjfm+JNhN24UyPgWhF52iC/Rqn6rZEZ7dZjE4Ug26leRaZxzgYqYedqOq5h+IJtq
	 tasfEmGm+GPMA/cYTVpk92nwyZg9sqDWJsSpmz4FLZnjL+6Kzlw+hNKO1Vqjj+KqG0
	 z/gqx1c+WpLFVI9BawRrx+l8hl/8OcIwCuA3TeanoGxBQgglKfo6Lvx4QE0jDsu8wN
	 8lHxoJRJxVWtkxw3CO+ZVpVPXN+Za/Ty+OJgiGBrJpwE0a19VNfvvFGx4+wL0zoblz
	 g5VBu/OEfJ9fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1C98407D0;
	Wed, 21 Oct 2026 07:37:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F650380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7584240077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vMjtk_Su8sTx for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 07:37:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3C8D540060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792568266;
 b=bkmWD09pFGRVlNbDs1pc5mflVHrzEG7idd5jSN8dLzqTHGUQ8qhj49ilxaUUov+0zJLq
 IgY3h6mNPTMgZPi5WK4tWLpgfV5U2LAsexafgYDfgroc0dmRNmqSyXVmKx+rxnqE8ni9a
 PtjqHT6zV6St+AYCF7J58Dm6xXr5DNAAgs5Hr+kyGazbp33BSuxDMVMDOg2SycHWEk1eo
 tGzfAZbXm6snNryOJEFR21gWGb2whPQqPUJLiUZNlSeTzfuRoHe2jvCg0IyXgnvKo9F2Q
 brJc2ueL5UX8GIzsZkMSgaX+J2YxpznyeE7fbNyGtkAjLdiew5CfFNo1/9jhrEWMdSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792568266;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=jb5SXbMy0ExIJu0JOrTCQ94yXzdnhxCRuHh3hI+Oxoc=;
 b=j5vrZNjFXzVNCzG+hL+9s9zrMYdcX6oNE9N+3xBslEvtkE6ICZBmjmXlbCSWBL+UQyM2
 O2EQ0YUVnS+jH2wLXjyZfvc7Y6Y9YUp38m/ESej8zpKPtQaUMHROkZTYIeqTK6BrOuSMY
 tdSnmQ8o9x+XdWKyoQQc210y9/iAfPEdY8PVgpxbbjsaK94xdyfNb7pSZos1v8yAv/ZOY
 FsW5UlQMUavLOrEznQgcAdsoTT9MOgiv3VQcKMDoXE/pHEfhm+utwmrwrW5Rx1IGEbo/r
 VgJnO/jc78LZUzWvv9CaGsEN00Gmx2S9t2Lo4xqP81BKpnzhJek92NjjgSzOzUkkwgQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=l8iIWPHp; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=l8iIWPHp
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C8D540060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792568239;
 bh=jb5SXbMy0ExIJu0JOrTCQ94yXzdnhxCRuHh3hI+Oxoc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=l8iIWPHpyfvlYpU9r/cCVoWakYw9H1rNhfkcHuCtNib1+y0RKOQwrRUL+/ZSZJE/B
 QRHxLTtxp7NyWrdRaOW/NdOh7j/lygG7OOdQIV6fe82xJVOvvMFjg4UrLxyRK6E3pQ
 LoF3h3Jw+H06K0ao8ockXLrRsVA/8Cb/lMGZWNABS2M8iPw9duNvBB97kuxRtx0EB1
 h2Ygva5HsQ4isqamNDToJDIH7/nDejRmRQM/EuKFuvV2O6UyO4ja3WHdwgB0KLzC2g
 Iqi6tpkqGsbS45ABcK4vSQd7/GsrSFbLp5TsRX6pqbX+FgEyJ08dbyVdeOCbd3I9Pw
 D3kPh6IW0Qgzw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 68450B221DC4;
 Wed, 21 Oct 2026 09:37:18 +0200 (CEST)
Message-ID: <fee998c5-7f0a-4660-80b0-a4861d15a210@freeshell.de>
Date: Wed, 21 Oct 2026 00:37:11 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs: spacemit: k3: enable spi nor flash in main
 app
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>
References: <20261020195126.1325187-1-e@freeshell.de>
 <20261020195126.1325187-2-e@freeshell.de>
 <20261021071329-GKC65567@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261021071329-GKC65567@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

On 10/21/26 00:13, Yixun Lan wrote:
> Hi E Shattow,
> 
> Thanks for the patch
> 
> On 12:51 Tue 20 Oct     , E Shattow wrote:
>> Enable sf command and env storage in SPI NOR flash.
> ..
>> SPL is not yet
>> upstream so this is only in the main app, and depends on vendor SPL for
>> clocks setup ahead of SPI NOR flash probe.
>>
> This could be added as additional info, but I'd rather not put in commit
> meassage, maybe just put it under "---" scissors line for reference
> 
> For why depend on SPL for clock, reset setup.. I checked fsl_qspi.c,
> there is no clock & reset enabling support currently, although SpacemiT
> do provide those support, but I think it's another item need to improve,
> and we could definitely address it in a separate thread..
> 
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  arch/riscv/cpu/k3/Kconfig     | 1 +
>>  configs/spacemit_k3_defconfig | 6 ++++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/riscv/cpu/k3/Kconfig b/arch/riscv/cpu/k3/Kconfig
>> index 5474ac112437..07b490a718dd 100644
>> --- a/arch/riscv/cpu/k3/Kconfig
>> +++ b/arch/riscv/cpu/k3/Kconfig
>> @@ -14,5 +14,6 @@ config SPACEMIT_K3
>>  	imply RISCV_TIMER if RISCV_SMODE
>>  	imply CMD_CPU
>>  	imply OF_UPSTREAM
>> +	imply SPI
> Any reason to add this dependency?

It is a guess, that when SPL may be loaded by K3 SoC BootROM from SPI
NOR flash then there should be an 'imply SPI' for what is needed to have
SPI support in SPL here on selecting the K3 SoC or in
BOARD_SPECIFIC_OPTIONS.

> 
> I'd prefer to put this config in defconfig, As I see K3 has 
> no hard requirement for SPI support from architecture perspective
> 

Okay, no objection to to move 'imply SPI' as '=y' in
spacemit_k3_defconfig for v2 revision.

>>  
>>  endif
>> diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
>> index 586305c62322..b333e708d01b 100644
>> --- a/configs/spacemit_k3_defconfig
>> +++ b/configs/spacemit_k3_defconfig
>> @@ -4,6 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x80000
>>  CONFIG_NR_DRAM_BANKS=2
>>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x102300000
>> +CONFIG_ENV_SIZE=0x10000
>> +CONFIG_ENV_OFFSET=0xa0000
>>  CONFIG_DM_GPIO=y
>>  CONFIG_DEFAULT_DEVICE_TREE="spacemit/k3-pico-itx"
>>  CONFIG_SYS_BOOTM_LEN=0xa000000
>> @@ -35,6 +37,8 @@ CONFIG_CMD_REGULATOR=y
>>  CONFIG_CMD_FAT=y
>>  CONFIG_CMD_FS_GENERIC=y
>>  CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
>> +CONFIG_ENV_OVERWRITE=y
>> +CONFIG_ENV_IS_IN_SPI_FLASH=y
>>  CONFIG_NET_LWIP=y
>>  CONFIG_NET_RANDOM_ETHADDR=y
>>  CONFIG_SYSCON=y
>> @@ -44,6 +48,7 @@ CONFIG_SPACEMIT_GPIO=y
>>  CONFIG_DM_I2C=y
>>  CONFIG_SYS_I2C_SPACEMIT_K1=y
>>  CONFIG_MISC=y
>> +CONFIG_SPI_FLASH_WINBOND=y
>>  CONFIG_PHY_GIGE=y
>>  CONFIG_DWC_ETH_QOS=y
>>  CONFIG_DWC_ETH_QOS_SPACEMIT=y
>> @@ -61,4 +66,5 @@ CONFIG_DEBUG_UART_SHIFT=2
>>  CONFIG_DEBUG_UART_ANNOUNCE=y
>>  CONFIG_SYS_NS16550=y
>>  CONFIG_SYS_NS16550_MEM32=y
>> +CONFIG_FSL_QSPI=y
>>  CONFIG_TIMER_EARLY=y
>> -- 
>> 2.53.0
>>
> 

Thanks for the review,

-E
