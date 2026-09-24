Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BFDC9830D
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 03:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02206819FC;
	Thu, 24 Sep 2026 03:14:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YmEEx_8zXkTq; Thu, 24 Sep 2026 03:14:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E92C4819F3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790219690;
	b=Il5oJH+Wa9fHUPYijIVwSSSrHo2eU7+hM5bZUjR8RWO+94EmFbgTJRGHy7/VV5TRwk/0
	 Dv4LC9MUdV4xRcngPlNk6xdPqYFQYD87fP4W2+9Z92O1Q+58bcXrpQSGoPtzqXOn5qD40
	 tEGd4f5yp3U/alPx/fFw2SBYoB8meiXT96SBW9VNLFdgmfrXEDgd2XAssQE38HrkqLL5N
	 cSBoVYCNVeMj0TXDk3cvg/v3vrykXUHbaKkWHNrqsYCZ4zZvaXvF52Wg21nekBmSdXRd9
	 /TnHT/EAKWBY+WH+flIkfMUMb7Ue/IhfTxY0tM5mJCWj+iZt/ZYk5SobNAAlpSoqWWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790219690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/vu8mh58GGAlm+LcHARrm4cBM+Y1krDOfecjJSJfelE=;
	b=Q/X797CMQ5gxIMr+4rt56NFI/qTVHhwj8tymNZjkmUKNknNIKvrz4YXO3479tVqlAf/y
	 /cLwx4PsVsgugEcsCiWYxY+rXlIRN195rOLrAFxI/RdGNeV3qN82QiID1tWxmAyka7uOA
	 ded8yYQrNX93dhYBHLqpfSlhusg69rWw7543+iKr6fMB5aVehZaDcE8lYnDHw1V0XZ652
	 EYE2h7MXOb3695yecOYHLK3zVw0o8j4/fUNaD9vCcdQYRrevPZUARwNWfz/pZ+s0K2T3L
	 UX3CeonNjueWfNQYTnkA452H6C++jVMfK4liXG5PTPx7wLlSawFciJxMIaLTN/2Niog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=FQBy5sn6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790219690;
	bh=/vu8mh58GGAlm+LcHARrm4cBM+Y1krDOfecjJSJfelE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mQkXVQ3UyG6phvXKic1ndEvJUOFwkbHnoeFJhfdugPtDXm/54VeK+OxpgqnGW3eGl
	 GxhWaKEs4FPQw6WgdQHKSR24Z0ZGyA2KmuuUtRomvaNzFlrA8DdRwW7t2ykJdSm9sH
	 Qr12NQqAer1cGPL2f9k2MPmClwpsN2J64zY3YVG55d865E1AIHXDgw7BQfhI0ytsnW
	 C3mXfzowavTrwkUzEkODoJhE2NSje3GLDAzXfvcR9iXGKc2Z+jGV6jCHcTl2ntqS2W
	 J96SgUbCZ9nQNmjd6O3uHLk/7gYxfszFuk9dVvfyyN7AtRy/wY8rMoYSzQtWYyCnnd
	 PJoYcp2X9vYNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E92C4819F3;
	Thu, 24 Sep 2026 03:14:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9C9C392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB41D819F3
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:14:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tDNIXHErP4oK for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 03:14:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 85B17819ED
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790219687;
 b=r3SKq6538JLUOQsgrOr4zkVyv1dqKIjoKYKVSjiZQlr0z0SytstNMxzccdpA9aL0BuMk
 JFayeW9lKcrSpQJBlBSVPjC/Jok2Mbld47vkQxbW3KNUkvvzkvp4NnL6LpSU30c4nZbtw
 LAO+aGOwz5+t847WcFNotbrG1czmlHrVVGWtea+ufPuXeiYrgWHl8RiJ+S0lkVskeZW3J
 0v34mwoeYxCi9Eo7PkEOxu1scrRp/vvI3OrCslu0NYrCjexWck6MS6CWLqIPuXqsKddTS
 frdDJxtrSVeTXfAa6jWLK0d0n++uPLfLekXF/uUzNxMoMg8ttfNWU9R0NHS2RXCxG1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790219687;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=/vu8mh58GGAlm+LcHARrm4cBM+Y1krDOfecjJSJfelE=;
 b=EUuIKM69IUDvPaQ25Qa2MG7FbR3U1ucv6bfL/DOCGcOdgOoItSJMX6oHLbMQh/cKJW5j
 OpfKGri47yRHs6Zi1h8G6MwzgJyU82R9J7rhq+hE5I3F7ZXGmDJsRp5TYiHchB0tN+kv0
 NWNaYjXaQh1091ggWZaljr4+nJfSOB1GZzLW+Ka4hdJN2vUSNDO8GTKew2b3/NnahK3zk
 HXu8NHjvsIxepiIDuyPzbb5+ucTDj5nR9X6n4Udi8FLlFrywc95aPr8LmrEr+MdD2f1A/
 7z3X7uEXlfll2un0gc1uMGJTKHrSmPKVMvxMSMGAvS0x5a1tJ/B9Bzx2aGjVv3eIFDg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=FQBy5sn6; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=FQBy5sn6
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85B17819ED
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1790219650;
 bh=/vu8mh58GGAlm+LcHARrm4cBM+Y1krDOfecjJSJfelE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FQBy5sn61XEVOv0yK36Kwfr9MlEwK2vpRYfMfUwhSL50LEsWY2P2LhrBTXMxkYptt
 bRFPJ/P1CC8G/WIxafsoOuSQSnkPsFwBlW80O47uLUskSNw85jB1kXDEiMq7eUW7yP
 FIDGx/p4dEu0rV7AUIZdD5Dd8N/8ioRfyggpAMlllC979HCIl42fDsHmircZPAL62N
 A04NWZ+j3Wbbi/eEdY3p5px2+d0bi2MiDVhVmseYezWhXCjYZKy5ab8YluK4eHu/K4
 C94mNgADUTqT8++DCjCylDQ3nSOZAG9nBgu8/iH4ailUbDU4WwwEIjetjZcK18M3YQ
 SdjiLFi/MthWw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 434D8B22044B;
 Thu, 24 Sep 2026 05:14:08 +0200 (CEST)
Message-ID: <e4c84eac-01e6-4955-865c-56d8fb733498@freeshell.de>
Date: Wed, 23 Sep 2026 20:13:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: spacemit: k3: Enable Ethernet support
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 fanyi zhang <fanyi.zhang@mediatek.com>, spacemit@lists.linux.dev
References: <20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org>
 <20260924-02-k3-ethernet-support-v1-2-b8e1fafc9249@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260924-02-k3-ethernet-support-v1-2-b8e1fafc9249@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Yixun,

On 9/23/26 18:53, Yixun Lan wrote:
> Enable the SpacemiT platform glue for the DesignWare Ethernet QoS
> controller together with the generic PHY framework, Gigabit Ethernet
> PHY support and the Realtek PHY driver.
> 
> Enable DHCP, MII, ping and PXE commands for network configuration,
> diagnostics and network boot. Allow U-Boot to generate a random
> Ethernet address when no valid address is provided by the board.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  configs/spacemit_k3_defconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
> index 6ca41aecc41..3a70a0a4858 100644
> --- a/configs/spacemit_k3_defconfig
> +++ b/configs/spacemit_k3_defconfig
> @@ -24,10 +24,15 @@ CONFIG_SYS_PBSIZE=276
>  CONFIG_HUSH_PARSER=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
> +CONFIG_CMD_DHCP=y
> +CONFIG_CMD_MII=y
> +CONFIG_CMD_PING=y
> +CONFIG_CMD_PXE=y
>  CONFIG_CMD_PMIC=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_FAT=y
>  CONFIG_CMD_FS_GENERIC=y
> +CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SYSCON=y
>  CONFIG_CLK_SPACEMIT=y
>  CONFIG_CLK_SPACEMIT_K3=y
> @@ -35,6 +40,11 @@ CONFIG_SPACEMIT_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_SPACEMIT_K1=y
>  CONFIG_MISC=y
> +CONFIG_PHY_GIGE=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_SPACEMIT=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCTRL_SPACEMIT_K1=y
>  CONFIG_DM_PMIC=y
> 

Please also enable for this series: CMD_WGET DNS NET_LWIP

We can intentionally leave WGET_HTTPS behind when there is no
hardware-specific DM RNG driver implemented yet. I do not see a reason
for the legacy network stack instead of LwIP; LwIP appears to be working
well.

In my test I start a simple HTTP server on the local network host:

$ python3 -m http.server 8000
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...

Next from a Sipeed K3 Pico-ITX 32GB board and your mainline u-boot series:

=> dhcp
ethernet@cac80000 Waiting for PHY auto negotiation to complete........ done
DHCP client bound to address <10.20.30.40> (38 ms)
=> wget http://host:8000/mini.efi
##################################################
87962624 bytes transferred in 7414 ms (11.3 MiB/s)
Bytes transferred = 87962624 (53e3400 hex)

With that,

Tested-by: E Shattow <e@freeshell.de>
