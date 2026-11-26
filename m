Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EBC606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BdJ1PKKC;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=Q4nviia7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4A2A60A55;
	Thu, 26 Nov 2026 17:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0_T8xjJcJM7v; Thu, 26 Nov 2026 17:11:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64B6A60A77
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795713063;
	b=VI1QOWqmMPMAN78q24+MUwFEEXPZj8c/Wmetrp3I0W7Qt6B4vDWDPmGOWVs8fwAMtsEW
	 dlFac+9iwECiHmFSeqvV2XR6/e9nLP++sMQMQBlQ4lPutrRjTvDKXlx8NmLjvJn8w+uRg
	 POB0bBq9n0X5W8lBtjDDgASx5bZMhGYbq4zduLKKef/65r+UqYZgmJncvCAAhXeDqhzI+
	 Ue0D/GZx+oQtlY3icjFTuyKTR7Unn2PYTuXsSaruP8YTSespytsONvbB43sa7IhAZTjG2
	 6OlUygw6RVfNYOHoB785u7mjWjR9Ysio7azoquqFxGQn1VyKy4Xshfv5BLGrlCzGA/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795713063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4fcp0d5lM/3tV5zrNldM2DA3NX5OumR8W7xN9Pw4deI=;
	b=YIgH5K0ceFVNBhW9TO1jLZxTNa1XVXqxdJDP+zYy5AW3SVn6lbGjX7w8gfVchQJLhi5C
	 gixboaC0EGQldAI+4pDIh6zY2Px9uce1VH3/ceGb+hdJifQCI8ZEjTKTjvC4ZQyHJRWVz
	 taChMT3aiQWb13akZICjhkvNc/UmguIAXhH9yqn7ZA/0ZByzuWzZ3HSapMH1diefCQ6dX
	 QQuOKWXf7oy/nu4dN2Ix0TKTT5k7Okdkvcobm1AqCCQ3y7VkAqaqmSa4lXTgAXv/aGvyS
	 bA0MbcgjKK0I5ZksSWj/vv0dBuStssTPkO87+UkdVpBz4+SyEWaNtPZFudzVN5zGCQw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795713063;
	bh=4fcp0d5lM/3tV5zrNldM2DA3NX5OumR8W7xN9Pw4deI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BdJ1PKKCLTjhm9KhBzxlxkVCX56+AeIonjLK7Teu6w69bJ2T2OS7wWi0ln9xn9LBm
	 doJ8tZC6gB3oKyDbkY/DkqAJvHzr18SD0yP4JpZxX6o7gpzzyMbldqF1WFqYPic0SX
	 z1secyZ6fAGKAnkluXq/MLG9qa1KiLjDUZZN1mj//NMhjAHkIOk2eeNA61teXvGiRT
	 657nbXYrwl0WO51R0t/nsCKFp57tt9zgEV0bxt+X2Lv3W3EKp2Z8uYqXO4nhlC+GMy
	 QizRvTjqBOodfvCim+vz9oA87mnHxwuau+HnV+MDIQKx12+pLhOFfJVTuJMyzmWUbS
	 reRyQa74LYjIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64B6A60A77;
	Thu, 26 Nov 2026 17:11:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BD3E311
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50A794053D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:11:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BW3GaU7GTidH for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 17:11:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F2B9E400E6
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=84.16.66.174
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.174;
 helo=smtp-42ae.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Q4nviia7
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [84.16.66.174])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2B9E400E6
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:10:58 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-3-3000 (Postfix) with ESMTPS id 4jb33M6PmDzfrc;
 Thu, 26 Nov 2026 18:10:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1795713055;
 bh=4fcp0d5lM/3tV5zrNldM2DA3NX5OumR8W7xN9Pw4deI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Q4nviia7PF8UaUl1e6H524u/plz6hHBL07//zS//05jCLcWDTe/vEkU1hOlEpK0m2
 ihWS+PDI51OGi8LHNwyfoyk2KmQhSF/R3kJr8MR2HsFDxxg56CHB8oTXC47Qb8A/xN
 6fot189EQbTx1Nb2PuYzCIUubVQ38xVGU52W2Nh61/udKDUvy4n9rhZB03NKC5GysY
 JapO2f2dWKxzim/Vxsn+oKAxCg0R1G7N+MiS6qxm8hz9uuUL9XjcgLIJEaoXdFaW32
 gH41bmvJamGNeyC9hYRQN563BF8sWEsf62eOV3s8N30pvPa/7AfUDw1+/CVGeYX/49
 4JfBN98U66JsA==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jb33K5s5tzB36; 
 Thu, 26 Nov 2026 18:10:53 +0100 (CET)
Message-ID: <1a9f27ab-d1d3-4454-8852-f6a9ae171e83@0leil.net>
Date: Thu, 26 Nov 2026 18:10:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rock-4c-plus: Configure IO domains in SPL
To: Shigeaki Asai <asai.6265@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Shigeaki Asai <y-asai.0816@docomonet.jp>
References: <20261106000815.217889-1-asai.6265@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261106000815.217889-1-asai.6265@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Shigeaki Asai,

On 11/6/26 1:08 AM, Shigeaki Asai wrote:
> From: Shigeaki Asai <y-asai.0816@docomonet.jp>
> 
> On the ROCK 4C+, nothing is printed on the debug UART after a cold
> boot until U-Boot proper configures the regulators, so the TPL and
> SPL output is lost.
> 
> The IO domains of UART2 (APIO4) and PMUIO2 are supplied by
> vcc_3v0_s0, which is LDO7 of the RK809. This LDO comes up at 1.8V
> at power-on (measured on the UART TX pin). U-Boot proper later sets

That's odd, the datasheet says 2.8V (but also that the reset value 
depends on the OTP value so who knows). It also seems it's off by default.

Can you check as early as possible the value of LDO7_EN, LDO7_SLP_EN, 
LDO7_ON_VSEL and LDO7_SLP_VSEL bitfields to triple check? Not sure how 
to do that though, as the easiest way would be to print the values, but 
oh well...

> it to 3.0V and configures the IO domains to match.
> 
> Enable the PMIC, regulator and IO domain drivers in SPL, and add
> bootph-pre-ram to the related nodes. The IO domain driver then sets
> vcc_3v0_s0 to 3.0V and configures the IO domains early in SPL.
> 
> With this, the output is visible from SPL on a cold boot. The TPL
> output is still not visible.
> 
> Tested on ROCK 4C+ V1.41.
> 
> This patch was written with the help of Claude (claude-opus-5-5).
> 
> Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
> ---
> Tested on top of the series "ram: rk3399: Fix LPDDR4 tRFCab for
> high-density devices", because this board does not boot without it:
> https://lore.kernel.org/all/20261101185441.755448-1-asai.6265@gmail.com/
> 
>   arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi | 32 ++++++++++++++++++++
>   configs/rock-4c-plus-rk3399_defconfig        |  7 +++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> index 7a6af430a6f..6094cda551a 100644
> --- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
> @@ -49,3 +49,35 @@
>   &vdd_log {
>   	regulator-init-microvolt = <950000>;
>   };
> +
> +&i2c0 {
> +	bootph-pre-ram;
> +};
> +
> +&i2c0_xfer {
> +	bootph-pre-ram;
> +};
> +
> +&pcfg_pull_none {
> +	bootph-pre-ram;
> +};
> +

issue: redundant

Already in arch/arm/dts/rk3399-u-boot.dtsi.

> +&rk809 {
> +	bootph-pre-ram;
> +
> +	regulators {
> +		bootph-pre-ram;
> +	};
> +};
> +

issue: unneeded

bootph- properties are propagated to all parent nodes, so bootph-pre-ram 
added to vcc_3v0_s0 should be enough.

> +&vcc_3v0_s0 {
> +	bootph-pre-ram;
> +};
> +
> +&io_domains {
> +	bootph-pre-ram;
> +};
> +
> +&pmu_io_domains {
> +	bootph-pre-ram;
> +};

issue: please reorder the phandles alphabetically

Cheers,
Quentin
