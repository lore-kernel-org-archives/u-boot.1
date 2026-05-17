Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A32CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 20:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B949E8465D;
	Sun, 17 May 2026 22:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UiSBnl2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A2584683; Sun, 17 May 2026 22:50:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52168845E3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 22:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5134=DP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779051039;
 bh=V0myB3aVD6qC7w3d1nAWJjvz7CXTQkZqtcb7K1xdaBI=;
 b=UiSBnl2Fwk58y6JxRf+xwCzf5jg/PQ+OF6eTiMfxQIdrALmYPet597H1mtoHuacnIJ99uldCY
 qhbvrY4sszU5I9euH4BfU2Axk4r/YsFNZ4RtuRt8qrjYGRQmWK3+U4oD9XUos0i5VvDWVpKHToA
 Xxt8DljKS5T21Em9tQNI1HGfbPxx10bsg0TNXHs9caoLRojf38Jd5qDMwIPO2sVQpUK/E/FT5GO
 Z+WV/7obnnsjukq7nJlRzwztkc3THb+OzeMPtoAhdFzjMM6+zPIcHYiAd26thh7g8V02yklKFxs
 iNYlkmIwEEOWmkmWUKqdFOKk9/gtBF1jXn/Z+21ZZnUg==
X-Forward-Email-ID: 6a0a2a1c66ad49e327c5ceb0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c25a393d-5352-4be7-beb1-a995aa389b5a@kwiboo.se>
Date: Sun, 17 May 2026 22:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/18] rockchip: rk356x: Add register spaces to DMC in
 u-boot.dtsi
To: Pavel Golikov <paullo612@ya.ru>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
 <20260517-rk3568-raminit-v1-13-a24e16302a13@ya.ru>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260517-rk3568-raminit-v1-13-a24e16302a13@ya.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Pavel,

On 5/17/2026 9:24 PM, Pavel Golikov wrote:
> Add UTPCTL2 and DDRPHY register spaces, both needed for RK3568's SDRAM
> controller initialization.
> 
> Signed-off-by: Pavel Golikov <paullo612@ya.ru>
> ---
>  arch/arm/dts/rk356x-u-boot.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 738b9673d35..b9f300a3274 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -16,8 +16,11 @@
>  		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;
>  	};
>  
> -	dmc: dmc {
> +	dmc: dmc@fe250000 {
>  		compatible = "rockchip,rk3568-dmc";
> +		reg = <0 0xfe250000 0 0x10000
> +		       0 0xfe800000 0 0x10000>;
> +

Please define these as constants in the driver, no need to waste space
or time adding these TPL only information unless we also have a proper
dt-bindings for the dram controller.

Regards,
Jonas

>  		bootph-all;
>  	};
>  
> 

