Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D201606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fakHuvKK;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=UoVnl5KT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D653407FC;
	Wed, 21 Oct 2026 15:48:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UAoO16One8wT; Wed, 21 Oct 2026 15:48:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5110740801
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792597706;
	b=EMG9Em1mXan255JTYvpAq/PguUfpnAFiv3XsTiiMAtsiZMuKGq9AsUfPmUK6RY7JbQxO
	 qZhNRVJHG7J+96aAdnNtRWTPD86wM2HXRWhThbSyOBNvGbm4uV1i0w5MX/dE9zKOEQmS2
	 w3vJkuRLPCaRdCO3ExVx0iHnHXpxQ6ilG+qbECeIGg8IH9mt9G5iLLfbD10JQRMRsiwKz
	 KumVs964TX5cPuqBCRG+mX7/lOW7GmjS9x9tDijzbjyZOuTcQd4uRg3jwfP2ADPHTNk+c
	 I5UfjSoeA8l60L7g1GtObza2BG/Km0PitKThXCROtcZJw5VJs86a2mLG2/CQLXZQvbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792597706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yxozBhcbncoOTvZFVOgGs0LUejcI3j8lVJQgSkreGaI=;
	b=PVmE1rFOjsn99x+hl/RTTflTXAetGNVXNK0C5PhzVlz/Ldd4kLEuBtR6L8fexqaR+ZK5
	 PAlDkiYmU+UNFu5aSW8MiJ219xhk/4MySXHeZcSAqPlJa6hFXkyVyZOfgZr/bTxnb9DyL
	 TVt8ZtdtmRnpkuKcnKcrx20Xp/QDC7gh73ZL7gCgbHIp5Ge68SWdPHaE6JdYWzYyGqhRq
	 jajlz6sJNwQaBMuSkFw8CaTAutFF94oOTwi8oAeYfaamFJunWaX0uE/79YacOMcMvwKDl
	 OuxVHYOZgZwWoC1CChgImLvvtNhVqYswWw4sZGPU1M+pHbYnO7av9z/TdTRebvAgijA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792597706;
	bh=yxozBhcbncoOTvZFVOgGs0LUejcI3j8lVJQgSkreGaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fakHuvKK01Ef1dlA9VRBm5OU3ELOxOm5+5t/Z1EG8m1KMWuLa9QEynV0sVqCl18WY
	 DDebETb0U18AFg+pJMnbuzbajmiWZIrUjD7TWzeKKZwjj9ArRXw4OtXc5Jz8CmXe0Z
	 gq0cUNhfTkZfVbRNy9nsFylFDr+irKDPuNuaQNkzk8+AtzdyAOME1puvPM5ieOBD/D
	 Qyz4n/A1h/ZhOjKmc3sYx1OGQg7Cye20+zmr91Wx3XqxD3QPWeJB9VOFQYeRVwWQnM
	 z+nKxzYtIvtK0xTC8u2XrKNwkMaUK0HtgSYO4wkqv+mtfHlMG6zvqtOFZZ9vYdA7F+
	 CuKknU3AlHopQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5110740801;
	Wed, 21 Oct 2026 15:48:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FBEB1E11
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35A3660848
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:48:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TYEEkxvVxR6G for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 15:48:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2EC4960846
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792597703;
 b=G2tsdeensIB6UpJYCgzu8A1y9uH0T5eAzGwGZzxTILxv9hBJ38YIumtYgz+cthCbiC4D
 PbyUmanLf1SRM3hYeDvzYZsiw8VhgxXAsIHgnSGM1aac6oECiDQmlglmvd5mklbiXcFid
 qg5hN+zIGD8KdepSjVY5ci2FfWzBds+tZ0cQhVzEUdtdaJN96BCmxl0oVoABIDTrQYDCx
 1KbK+NKa60r1ZwosH8BVsjhg4q/9ZdQOrj3/m5fve8xmYo9gYw+g/zmXYF6ioh9WaM1hI
 rPL7moV2jWlYVE4NcB+pyRt7Abt0DeTOYwQA+BeRWURbcGEzB9u4xK6c3QdNxpWcDyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792597703;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=yxozBhcbncoOTvZFVOgGs0LUejcI3j8lVJQgSkreGaI=;
 b=qUGhrlvW1rwrMQpvQ0gIvqNMmy2uPVLse6J4qIuiO/2fcuDwGrZus34YNT04oRMGYfQm
 5tFBmXI1Sl+aLIXXh9o28rDb5OdRgQTtfdtoJt5skcAuXatQXr1WuNiWYep4SwGqorxQd
 Kj/AeMbaeinH8Ozjrpr0uuqiZ9GW7CmZhW4wXLGWlUiXSBNBfxiKNGq0qKOyWBhjKwEFQ
 jkXSrpAOtHLKQEjdS4eFB36P7sIDMU4p0mdEuf9+YwrV7G+QHTnkdGCQPYDTLe96xPhHV
 lnwQ6KYi1twYhPfSBfHGlgmZ3869pkHBWHQqXi4eb6QMUMxEraLXxWdhMebfVOAMfkA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=UoVnl5KT; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=UoVnl5KT
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EC4960846
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792597679;
 bh=yxozBhcbncoOTvZFVOgGs0LUejcI3j8lVJQgSkreGaI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UoVnl5KTg+/mC4mGSRxwtIHC26GVFhPzLFXsUZciJ5dnGh4xnAJxDFYB+LEqSelz0
 IJkpnaGO2FCVpojn4GPFIrehBrtK9R8sWH7BNF7fPbMp9UVEZALYbTsNucUBYzKhKu
 4urXCJCSotG8kM1EHVKX+czrFPAGlkwHvvSUhlW2R/wcclrOI2zGTD3Os/soLbtX82
 FQm2hSCxzvZPTcs48sc+PS5+fOpLrUyeGkmrTJfpeGeH2HyogqOBHHXXPYG4UJ3X8N
 8eASZMY+3LNay5fg8MnlJEwR0KCmuMeTn65ZCXPU8kUmBOET35dvDqoP38GhFcVEEj
 P8Ow59aaB84bQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 644B5B220B98;
 Wed, 21 Oct 2026 17:47:58 +0200 (CEST)
Message-ID: <ed866aae-5434-4b7d-8732-bea60bb73cb1@freeshell.de>
Date: Wed, 21 Oct 2026 08:47:56 -0700
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
 <20261021080117-GKE65567@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261021080117-GKE65567@kernel.org>
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

On 10/21/26 01:01, Yixun Lan wrote:
> Hi E Shattow,
> 
> one more comment
> 
> On 12:51 Tue 20 Oct     , E Shattow wrote:
>> Enable sf command and env storage in SPI NOR flash. SPL is not yet

Okay, I will adjust the commit message. Thanks for looking at fsl_qspi.c
this is a good report to learn it will need some work.

I have carefully constructed a build of SPL from
spacemit-com/uboot-2022.10 that is reduced to a minimum of build config
options. I'll make the requested changes and send a short write-up of
how I build this reduced vendor SPL, for a baseline of testing.

>> upstream so this is only in the main app, and depends on vendor SPL for
>> clocks setup ahead of SPI NOR flash probe.
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  arch/riscv/cpu/k3/Kconfig     | 1 +
>>  configs/spacemit_k3_defconfig | 6 ++++++
>>  2 files changed, 7 insertions(+)
>>
> ..
>>  CONFIG_SYSCON=y
>> @@ -44,6 +48,7 @@ CONFIG_SPACEMIT_GPIO=y
>>  CONFIG_DM_I2C=y
>>  CONFIG_SYS_I2C_SPACEMIT_K1=y
>>  CONFIG_MISC=y
>> +CONFIG_SPI_FLASH_WINBOND=y
> I've also tested on com260 board which use GD25LQ64C chip, same 8MiB
> but need to enable CONFIG_SPI_FLASH_GIGADEVICE=y, the patch 2/2 also
> works on com260, so I'd suggest to make the commit message slightly
>  more generic? not specific for Pico-ITX board
> 
Great, adding this for extending support to CoM260, thank you.

-E
