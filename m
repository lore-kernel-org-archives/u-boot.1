Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC67CCF2CA
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:33:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13E77812F1;
	Sat, 17 Oct 2026 17:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5FrU3uSWZH5e; Sat, 17 Oct 2026 17:33:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55C63812D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258393;
	b=hFKOwezm2XDqTj9NcClBeis4zf+DNFNtkmx377QsN8cPnmLrwV1Cn/zAgsCJMQunyDJ5
	 g1RIW6tQc+SJbCeZD7xGeiX6gfLyStOe9KKTO2Eq4M5HLsylczUftpWn9S/9GxYpAJYP4
	 97dtIAEWSHzIpflz0LKj5SRui+Ubr4OZ0PRi71wPUIY7lNJLDsivilNdGO/eDD+ULGVpS
	 mJbczcDuJb+WeYCV4RQyGYDPHxhgFsLzZxs6itzde60x8kPqB7u1cktllgu4/dsU7m46s
	 aIqak7gQRC4qLrncrG8RkB4EzcL4F7D37TDKKbwfuFOQhd28RcxQVt/1eTGESSOln8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FZb++Gt7smqa5Y6MlbPw4WWjV2X2ifBN8rUqBiX8dFg=;
	b=A4ItW4r0Gvwlrj8EGbK7EIZqk2uAhhH1KuyM2VdneyuZL+kCokS/yknAuhQTbUwLjUb0
	 zKvvkbKfsEyePCGHOp7YngPv+1nvyisBpZYZB/HM/FFbW0SPUwBhkrn1zFZp6K7eEFvoZ
	 kbLs1InCQX/X7m+4FExeZekLH3L3lHgborMyCNqsB9tD73PBYZO/0JKYXZntfhnK5hbpY
	 ckkyEN1d3aRKtLY9jloSOlof84wHXwUXu7COyiCqIi+jQ6IPjo5go0ZCKSIgQ0/k/kOIZ
	 bFO4Cp+cG3793c0eMn6xADXOYcfOAee0rPdBTzEjRd4w77S2NqxfRvzKi/DxpbBLI5Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258393;
	bh=FZb++Gt7smqa5Y6MlbPw4WWjV2X2ifBN8rUqBiX8dFg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x4Q4EnQ1Vtn1/q80W4fulgRjXp3AfSK2FjVzQP/ukejtsNgIKcSEOH1bzxjSnefSa
	 epCVJHpMdLewNppfrxRNQmxeNEj1oQLow6AdSSVV8cdQ3Bm//H6x2s5QmdQI2+Rx53
	 fzw4S9lxJCCBz924ais+N564iXvA3356nQ5aADwMH1015TYCElT/PnXFVJXUZU0UWM
	 K2xgVXID3tVc4bEndJspbtvSPax2Y+2X65Hfs48OsjJ0WihjgGuEZpqVyreTobie1d
	 fVt3///Chhh1Kv4cGfHh4FpwIlkknG6n1KKdCxhQV5PJs4Wm1nmOy47MBz4V0SATSC
	 7OTWd8OBe03xQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55C63812D9;
	Sat, 17 Oct 2026 17:33:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBA782A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0B7860638
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kt0r4tvcPSwa for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:33:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DDBCA6061A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258385;
 b=CHqia2PnU3ivqZuBiQulqtwxYeZZNAo8QbY0/wCAWSt5q1gfKeAuv/E+Pgalwdqi8PH3
 QziA/XLhWYrAv4411JhtL2jV1Ovq1+oDyEAkwq2oFL7mm8xKt6nw8y+OuqOlW2CwO8Jgw
 EW8i/S7GDbaANxmvXv0Wab2wzlQJdSWm6ra6cA4sfiW/S8U26JhjKNdMyZQuHgjEEP2uO
 OFiXjnGN3Df10/Ih+jXilYwrxx9eEl+CizFZ5smV3kOjNFm9qjxi6mtTxGsu7vvy7M5z7
 yKH05tYNxtPGizb7fC9fP3jJIgBb1qEltBkDPKYMIgcrbr1hb7mW72RyzkJCnV/BAZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258385;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=FZb++Gt7smqa5Y6MlbPw4WWjV2X2ifBN8rUqBiX8dFg=;
 b=TZm42D0s3tixZC8bMUVuAaUlTg+UC4QZwKDztiSywHEl3q8uwkeU4T/HZ+dGx1KKMOUv
 qujSqH183U7S/wIwcCNZRhd8ZeVGPZSOsVSa/yhs4Vwy9lEISSpIEmR5wKTbP5A01JBzP
 Nch7oCQYAwaHwSCO/k5c2pYPaT0kyzpCQvhFRBQBsfX9c4qZnd4G71IFTREBEYa/aeJhL
 U7wuq2pDzOZ1vshCqasPRwHHmBAVueFooal5oAmrWqCJYz/3DQE/8J6HLNL1hOq316VT7
 YOw8cmfMffB+TSYk1CRHsJ+6QC7OvWzprUvD0SeWlHMlo8j2VMhTby+f70o8xMQMOCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=xgPgXHDl; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=xgPgXHDl
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DDBCA6061A
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:04 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j6TRH5vLhzMlHJ;
 Sat, 17 Oct 2026 19:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FZb++Gt7smqa5Y6MlbPw4WWjV2X2ifBN8rUqBiX8dFg=;
 b=xgPgXHDlKX0mo7qFxUMYPgidVX9qDkVYIa1may/q2jeqVJEpgp/FL/d3J1YhcVY8Ge2JEK
 3KNMlzcbVTLWh8m5KaRB8aDzfor8LCSp7NSnu8WxeEuQJbS/efg94bf6++YQzddMh2o9Uy
 5FGXaQfk+AyjgnzmEBllqYrW3BgBE/RVwlZD9wx/xUzymBM0sRja/J2r3U7+nr4w7uxrEK
 TICQGnPWaRURCigKNIiEfo92m8/JBEcmHU9FlshnzQ/thwnfqSmAr41fb5YbqHZNRi8ppR
 12/UAwuXsG9K7ayFNCS6Thgih6tq7rp/ctZOQ6Nmx/7z1SGfhuTxmrLDR6N1VQ==
Message-ID: <f5a4104e-3b26-4003-bfe1-642db8af80d1@mailbox.org>
Date: Sat, 17 Oct 2026 13:36:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/26] dm: add helpers needed by the resynced DWC3 code
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@denx.de, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <20260916123826.517181-3-anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260916123826.517181-3-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: pyfx5i13fx5mu3fo4qqzdywb1zj7fuz6
X-MBO-RS-ID: 7b5e5d813aebce402b9
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

On 9/16/26 2:38 PM, Anders Roxell wrote:

[...]

> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index d4ba4d0088a0..16c02260c111 100644
> --- a/include/linux/compat.h

[...]> +/* From include/linux/reset.h */
> +
> +struct reset_control;
> +
> +static inline int reset_control_assert(struct reset_control *rstc)
> +{

Should this call reset_assert() ?

See e.g. this, which should also be updated:

drivers/phy/cadence/phy-cadence-sierra.c:#define 
reset_control_assert(rst) cdns_reset_assert(rst)
drivers/phy/cadence/phy-cadence-sierra.c: 
reset_control_assert(sp->phy_rst);
drivers/phy/cadence/phy-cadence-sierra.c: 
reset_control_assert(sp->phy_rst);
drivers/phy/cadence/phy-cadence-sierra.c: 
reset_control_assert(phy->phy_rst);

> +	return 0;
> +}
> +
> +static inline int reset_control_deassert(struct reset_control *rstc)
> +{

Should this call reset_deassert() ?

> +	return 0;
> +}
>   #endif

[...]
