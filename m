Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F7606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QikBNtzC;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=KMpw8yrF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12BB6607B5;
	Tue, 20 Oct 2026 17:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9jxmNhyXcZxC; Tue, 20 Oct 2026 17:42:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C2DB6075F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792518169;
	b=hzLHfc1vKjnjWzJRMys+j6dYHIsrvXeTaVc1PM1bWiva276AKcb+BsmUSfs/l4cgD/jV
	 9lpxv1uKywDq3+oHebtz3e2wJ8zMdGU0RoTLpaiwpaONXv3b5ynuyTSDvgrOOfOhUk+WQ
	 TJ3C1vVuXL+IaGMKehfiulY149Y0gWOVYntk9w/4ESTlbfH46OHUEMh3CwgP58jCjPTAq
	 mDVacZyQc+H2cjL4+CTX1vMUDGr3qu4EA5Ax/JRottvYynhfJRbI2T9YgLq1konCioBu1
	 OhvYTMMpaq+S85tqphF9IFjsz2hVzLj3o2h8dxbkFBjPP8VyPj8TTynvEaG9O3OlMCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792518169;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nz4HT7uxIQylEqFtZWkLpIFVsT4tFYeVsdGclJC0W8c=;
	b=MVkDgotzLbJMKEXorIeL9r3nd1ngpil144OphQNB8j4EAHIlsFiNj6qQWQQQTDbHh1dV
	 yox8q3saZqHVbJCAjPQ2Opyb5kYw8Klz63CtSPtoO3y5KLNpc8skdAkZoiLnUCT1QBcFB
	 qs/1oOJlaRlw+GgISnSO9vF15MGiwoWqR8Z1gNg48dVOk5hmgFt4WYFuuEPow8qdE/zT4
	 C22Hf30MGsxGW2FG/Ru7Jzojt9DfbI/Nm9nuYvCjCr5cn46A1+dwdqr9LfmfA9ZreKUdv
	 rWqb2C0iFti4xsayJyG5+tUouNgGulxRhVoZ6rqMns7ZOSfnXc9EYZxE3SjPvq5Lc7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792518169;
	bh=nz4HT7uxIQylEqFtZWkLpIFVsT4tFYeVsdGclJC0W8c=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QikBNtzC3/HdF/PXG+x33lR7VWsE4nfwzldBk9iYLepGKr6oJkjA9ZCUh5Whg8PeX
	 wM+V1z/A32un+hmtN8OVLx3/NQSAIx5ltyTzjdu2QYAJbWu9uI/lxdi51ySOW4zRE4
	 mqypFti9wEfc17KcyWEK1uGZAHRN8Ts8X/AUjVo3KTshAz7piP+XJli3VGUI7f0BUh
	 wODQ0EZAAYV0E+1F3sAQ0xZse4mwQfUdNqm+frLQg20/QZV8aCsTt5aZc5E4W8P4ec
	 cA1msn3hO+J288XEGrrHM8FRsFZhejYEORZQFW1Y7RqmKz64gsSqRxkfzDbrOrgt2v
	 ms5TFFW+EflHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C2DB6075F;
	Tue, 20 Oct 2026 17:42:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31F033A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17D9E810C3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:42:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ti5582vFuPWW for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:42:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5DBCC80298
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792518167;
 b=DLh09ROH84w3PrFabuuSkXtYWeTCraoOkkCGCzt9hERajXPBO3i0lMg9KYoMolP2cV13
 pHEfULtZNzzSzBIKWqE73zAaw/iBhTscb9nJcwEKXTl38EjPp/7hbC8v2w+Zgw+7jFdFs
 hJetH/aLCiZZxnwv4O/ulBQrLr5CT9WWyi0ovXZVzGXJnTg7WV/y0lNWlaVTn39Z0k39A
 ovaGPr6WIhh75tn/iVWx0VeXc72fUrJiTT8cONjF9YNZ5/Hf9TTXouKD5xO1mawwu0v5A
 9osCXkA0YIPty+/rF5nwCMlI4A4h2q2gTs4FyKBlf/5NE6rGPQFGHtodO3AFu5VOkjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792518167;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=nz4HT7uxIQylEqFtZWkLpIFVsT4tFYeVsdGclJC0W8c=;
 b=Oohkqbtxz5xi7NTp+v8wBttK4JSBJslll9RtltpnhAKAqWxFzRuDO5eLwTXDxf3wxzVJ
 Co4H3L6oVXL2rE04f8gb8jA/vBBqD4QqNEpu/Qw8AzHl0xtXUUmm1vsG/fbn5SA5uiKPR
 9BuMknyGCyf+DIJc5FisvL5DahrDj29MaOjssWiOZ80atygRjFTY786gaax9jBDR13qyc
 +T0htsZT7bi6apSZ7UuKfKRz7LDxYGjr2FGCKbkYd5IlmcUpgJWQK14cy3xRhO0MfUPNz
 IFPWDCEWOWuN8qTdnkAkE1w9NX2BZ4DCEdUg6cTmtsVWF9HKPWk1SWMyiHyl3wKzXaw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=KMpw8yrF; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=KMpw8yrF
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DBCC80298
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792518064;
 bh=nz4HT7uxIQylEqFtZWkLpIFVsT4tFYeVsdGclJC0W8c=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=KMpw8yrFL+agFMB4lvzLPx2XDj+yoHr+ZjaPB/Yb0xIMR7rGaQUfTCAQVn03C3F29
 VPeGLTJeNGfGVkO74nOsYsq+yujhFy5TNcOoqkrggo0tY+DLo/4vOm3Zw8VvQ9NowZ
 8Lbz3CyBk7nsOlf62yPq+aqsJhXYWzKN01cv4a4/XdLtezA8a2PiUYicUn+pBHabgW
 pY9bfjZc33gEjI4tqxPVkuEoZ08LV4b/+/WiLz/DkGLZ8JzhvKB9hxTzpTlCb5XUgQ
 Chxs5ElAYs+brSg2Q9Sujopy15KVWiTFOXHaleAFOLeLldb/9tiNKcqRn38Ynk+U1m
 9qB7gf8T1LMpA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6C2A4B22008E;
 Tue, 20 Oct 2026 19:41:03 +0200 (CEST)
Message-ID: <3da64f01-7fb3-4da6-a069-469fd5912dd9@freeshell.de>
Date: Tue, 20 Oct 2026 10:41:02 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: spacemit: k3: enable eeprom tlv command in
 main app
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
References: <20261019014044.698294-1-e@freeshell.de>
 <20261019014044.698294-5-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261019014044.698294-5-e@freeshell.de>
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



On 10/18/26 18:40, E Shattow wrote:
> Enable "tlv" command. SPL is not yet upstream so this is only in the main
> app.
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  configs/spacemit_k3_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
> index 586305c62322..66d1a36c79c3 100644
> --- a/configs/spacemit_k3_defconfig
> +++ b/configs/spacemit_k3_defconfig
> @@ -22,6 +22,7 @@ CONFIG_SYS_CBSIZE=256
>  CONFIG_SYS_PBSIZE=276
>  # CONFIG_BOARD_INIT is not set
>  CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_TLV_EEPROM=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_DHCP=y
> @@ -44,6 +45,7 @@ CONFIG_SPACEMIT_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_SPACEMIT_K1=y
>  CONFIG_MISC=y
> +CONFIG_I2C_EEPROM=y
>  CONFIG_PHY_GIGE=y
>  CONFIG_DWC_ETH_QOS=y
>  CONFIG_DWC_ETH_QOS_SPACEMIT=y

Tested-by: E Shattow <e@freeshell.de>
