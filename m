Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC4606A329
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gFl6mXQC;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=lss+aGhR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B267E60AC2;
	Fri, 27 Nov 2026 11:36:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRTSkT_-bZXh; Fri, 27 Nov 2026 11:36:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E96C560AC4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795779406;
	b=gfXvuziYqfzeK0bmy+xPucRHF3DXOJ0FSEjAiDUjVKZKc+gMFTd8C/M7A14HYC43Z6RV
	 fJGr3x1Xx+3moGq7H4kDK7+9cONXmMLD6XEiJ2684isQ77KttARKUosspNcLn55zamW1c
	 R08Gw8ZoMFijE4kYe504Ir8xX1z6f8zw98CEb/IJDYWdI6nA5B1TLRdBYF3GHVo6XktUe
	 XubhGMI1Acxd3/XNnW7Nc6TbU7SGDpSLdkgaV+JSWjhlh4Feyj7YEd7bnaYlPJU/GkCy1
	 jZVItIrkXtTmW728vd7YsXvCKsa+NHuH3Cenf3mb0iVwFwNZ4mqAPF4hFSs7fX/No/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795779406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=S5RgeOdoa6499ssTBO9GKLOJi58g1QSIdcenZbee6NA=;
	b=IaQIAMzAgl0+qdd1fgbg2hVpNarLmstHLvtYAnnYRE9VWxwBW9ZveWRDl3OItoq0Yyd6
	 gaPA3E0cIpvt1fU0HKQZCp+XVuC97R/h3bjmSArE2jFPgAdj8U/r/RPr8Bd/MGTu+IKjp
	 od5x4tlfDUCvSCE8nehnQNIDAixs6kd3pAyyTBOe0lUtLzp5cv4XQyxmTbSnd+dMinOWO
	 w/R4LwYGM+LQzxl3B43qtLTlMt4wC105Oax7OBkt/BELNlB5/pGhIeX5YVoTVkED6CTDO
	 zszxNLeqZFCvvPKQw7Mif9x+F2gmQikB5LjRpN48otpeH+rzp77J0yZlyxgKYyyAuQw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795779406;
	bh=S5RgeOdoa6499ssTBO9GKLOJi58g1QSIdcenZbee6NA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gFl6mXQCY07tKc+Vf1mz+NjY8AF2LTOlqnXWqVDcxu8JxeKsZpIyY20CAJeMC/z1H
	 rMCqqo6GmxBUHjCtO7QpsU7YX+KBv2XZa1SiV7srkB7kUDG5R0gbNWyV18i7JRcCtd
	 sU2/bJinoWHP8Ikl3fDjalWzRHLb0vRsd51XQweHkKSbQe90De253zmHWtCunzOAWJ
	 05Ox65dIOMQJaMgeZ4lTw9KUNDODofYnh2Cz9w5EQ35tpYFonQrNgHTOaFep05eRfy
	 /gJyGwL2nmUddW9r8c6zeMVIgHrqu9JSYXGymsCJ+ku17gFxcXG10wCngcPVl/JIuO
	 FYkFA1ODXyn4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E96C560AC4;
	Fri, 27 Nov 2026 11:36:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E764266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F3894008B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:36:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2yEWPRHniAf7 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 11:36:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5891A4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=lss+aGhR
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5891A4004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795779379;
 bh=S5RgeOdoa6499ssTBO9GKLOJi58g1QSIdcenZbee6NA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lss+aGhR71v3747faerKjDMgC/CBzdK4YuIBtVblNUEhAZahnng2jdDlO5L9hcCRq
 6L1/vDm2XqehiyxokIdJq+tfVuv/DjLGDW16nDkES6ZDxecEC3MKn0uLISOqpMCDLW
 5Y6oKp27jv0aMYJhalNT1xW0M6ExEZ1yyJVjOyEX2hmJD6kyHWO1E2Wu019V6vF0nR
 YOorLmHcEhOdjxv26xQRosOE6RnqHISOhjcGHMNVZ32nH8L6lwgpwA3CwWCC3Ekt4z
 N2mbnKO97mcGdBP8e+MoRIsxT0bEmv36lEcbeggvjLZs8C9umbUn9c9lqIGs6uxy/W
 /RTNIW8R62bwQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 6B883B221A3C;
 Fri, 27 Nov 2026 12:36:17 +0100 (CET)
Message-ID: <859fa13c-0cb1-4fdf-885d-0d36e9946860@freeshell.de>
Date: Fri, 27 Nov 2026 03:36:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/13] clk: spacemit: k1: Add GPIO and AIB clock
 support in SPL
To: Anand Moon <linux.amoon@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
 <20261127103030.4647-5-linux.amoon@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261127103030.4647-5-linux.amoon@gmail.com>
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 02:30, Anand Moon wrote:
> The SpacemiT K1 GPIO and pinctrl controllers require their functional
> and bus clocks to be enabled before accessing the controller registers.
> 
> These clocks are currently only available in U-Boot proper, preventing
> the GPIO and pinctrl drivers from enabling their clocks in SPL.
> 
> Move the GPIO and AIB clock definitions outside the SPL conditional
> and register them in the SPL APBC clock table.
> 
> This allows both controllers to enable their required clocks during
> early boot.
> 
> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Suggested-by: Junhui Liu <junhui.liu@pigmoral.tech>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/clk/spacemit/clk-k1.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
> index 20b8595aa3c..646c81a2d60 100644
> --- a/drivers/clk/spacemit/clk-k1.c
> +++ b/drivers/clk/spacemit/clk-k1.c
> @@ -379,9 +379,6 @@ CCU_MUX_GATE_DEFINE(CLK_UART9, uart9_clk, uart9_clk, uart_clk_parents,
>  		    ARRAY_SIZE(uart_clk_parents), APBC_UART9_CLK_RST,
>  		    4, 3, BIT(1) | BIT(0), 0);
>  
> -CCU_GATE_DEFINE(CLK_GPIO, gpio_clk, gpio_clk, "clock-24m", APBC_GPIO_CLK_RST,
> -		BIT(1) | BIT(0), 0);
> -
>  static const char * const pwm_parents[] = {
>  	"pll1_d192_12p8",
>  	"clock-32k",
> @@ -499,9 +496,6 @@ CCU_MUX_GATE_DEFINE(CLK_TIMERS2, timers2_clk, timers2_clk, timer_parents,
>  		    ARRAY_SIZE(timer_parents), APBC_TIMERS2_CLK_RST, 4, 3,
>  		    BIT(1) | BIT(0), 0);
>  
> -CCU_GATE_DEFINE(CLK_AIB, aib_clk, aib_clk, "clock-24m", APBC_AIB_CLK_RST,
> -		BIT(1) | BIT(0), 0);
> -
>  CCU_GATE_DEFINE(CLK_ONEWIRE, onewire_clk, onewire_clk, "clock-24m",
>  		APBC_ONEWIRE_CLK_RST, BIT(1) | BIT(0), 0);
>  
> @@ -584,9 +578,6 @@ CCU_GATE_DEFINE(CLK_UART8_BUS, uart8_bus_clk, uart8_bus_clk, "apb_clk",
>  CCU_GATE_DEFINE(CLK_UART9_BUS, uart9_bus_clk, uart9_bus_clk, "apb_clk",
>  		APBC_UART9_CLK_RST, BIT(0), 0);
>  
> -CCU_GATE_DEFINE(CLK_GPIO_BUS, gpio_bus_clk, gpio_bus_clk, "apb_clk",
> -		APBC_GPIO_CLK_RST, BIT(0), 0);
> -
>  CCU_GATE_DEFINE(CLK_PWM0_BUS, pwm0_bus_clk, pwm0_bus_clk, "apb_clk",
>  		APBC_PWM0_CLK_RST, BIT(0), 0);
>  CCU_GATE_DEFINE(CLK_PWM1_BUS, pwm1_bus_clk, pwm1_bus_clk, "apb_clk",
> @@ -655,9 +646,6 @@ CCU_GATE_DEFINE(CLK_TIMERS1_BUS, timers1_bus_clk, timers1_bus_clk, "apb_clk",
>  CCU_GATE_DEFINE(CLK_TIMERS2_BUS, timers2_bus_clk, timers2_bus_clk, "apb_clk",
>  		APBC_TIMERS2_CLK_RST, BIT(0), 0);
>  
> -CCU_GATE_DEFINE(CLK_AIB_BUS, aib_bus_clk, aib_bus_clk, "apb_clk",
> -		APBC_AIB_CLK_RST, BIT(0), 0);
> -
>  CCU_GATE_DEFINE(CLK_ONEWIRE_BUS, onewire_bus_clk, onewire_bus_clk, "apb_clk",
>  		APBC_ONEWIRE_CLK_RST, BIT(0), 0);
>  
> @@ -672,6 +660,19 @@ CCU_GATE_DEFINE(CLK_TSEN_BUS, tsen_bus_clk, tsen_bus_clk, "apb_clk",
>  CCU_GATE_DEFINE(CLK_IPC_AP2AUD_BUS, ipc_ap2aud_bus_clk, ipc_ap2aud_bus_clk,
>  		"apb_clk", APBC_IPC_AP2AUD_CLK_RST, BIT(0), 0);
>  #endif
> +
> +CCU_GATE_DEFINE(CLK_GPIO, gpio_clk, gpio_clk, "clock-24m", APBC_GPIO_CLK_RST,
> +		BIT(1) | BIT(0), 0);
> +
> +CCU_GATE_DEFINE(CLK_AIB, aib_clk, aib_clk, "clock-24m", APBC_AIB_CLK_RST,
> +		BIT(1) | BIT(0), 0);
> +
> +CCU_GATE_DEFINE(CLK_GPIO_BUS, gpio_bus_clk, gpio_bus_clk, "apb_clk",
> +		APBC_GPIO_CLK_RST, BIT(0), 0);
> +
> +CCU_GATE_DEFINE(CLK_AIB_BUS, aib_bus_clk, aib_bus_clk, "apb_clk",
> +		APBC_AIB_CLK_RST, BIT(0), 0);
> +
>  /* APBC clocks end */
>  
>  /* APMU clocks start */
> @@ -1309,10 +1310,14 @@ static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
>  #if IS_ENABLED(CONFIG_SPL_BUILD)
>  static struct clk *k1_ccu_apbc_clks[] = {
>  	&uart0_clk.common.clk,
> +	&gpio_clk.common.clk,
>  	&twsi2_clk.common.clk,
>  	&twsi8_clk.common.clk,
> +	&aib_clk.common.clk,
> +	&gpio_bus_clk.common.clk,
>  	&twsi2_bus_clk.common.clk,
>  	&twsi8_bus_clk.common.clk,
> +	&aib_bus_clk.common.clk,
>  };
>  #else
>  static struct clk *k1_ccu_apbc_clks[] = {

Reviewed-by: E Shattow <e@freeshell.de>
