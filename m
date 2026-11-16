Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB1606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CDuZIb/c;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=Wioc3cVL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C330881028;
	Mon, 16 Nov 2026 17:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jyvOBjZ1lTt8; Mon, 16 Nov 2026 17:01:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9535C80FA6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794848479;
	b=NMJUQT+y/Cj5+P5l7p9pE7TtOt7t4zKYjiRqkAJqHg0eKe0NdsEHOHRdccm5M7XXnhYb
	 meou+zXPC37yFezNWjkenGjoTkZag8UD5hnsddIdOOFRhcGw1fsEGsdpWAgJPfLFUj/ug
	 4CktEnP7tY2UKVlcnPsOtjw31OWQ0ZYqmqVzGH9QvXQqf7YKv6hWxkljkRu1PrZTcFtdQ
	 02dg1RK+Wu75BrKF/aTjmOvGrH0SG5BPCw8ZdEfA6RSyWNTS4IN8Jl77rDPkdl/jBEFh2
	 Orf0gv8eMC+13mxZIqZ8P6T9QUlt1qIWwA4+F03g/9gRdMi2+sOanYoN44gdHy1Qylw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794848479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3A7QdOgRBkhy7zgWN1Qbu38I4lTmT+OnFK0lS9EWcAc=;
	b=VHCtX3JTx8LaIsr56P/QWEkXiwpIKnR9smZmvHrULiR/qatD+Lk5xMhuP0uZ1tvTXPmR
	 /m0wfwtIagTo1p/Z/R80tdHicaA9yb10aOZtCuNRxhj4a7RImcSzzxDMY7X/H8o6Uq6+1
	 0+djv9F0YN6rf1JCivREJsLXuOsyeQqSYHHhZTtfKP8hvyMpZZ4jEpCuj3f62v+539iwO
	 Tmw1hgstOWRbSvWA0/Ntv3jjvSy350CL8KhuD24MMSKfRilP/FoLEQNF8efZpYucFQk0O
	 LffHnG5awF+G7zIuJKrREkfle8Q5776EWDFfazH9yem9BTgSIVUJIgvAkDR1XtBkGoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=Wioc3cVL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794848479;
	bh=3A7QdOgRBkhy7zgWN1Qbu38I4lTmT+OnFK0lS9EWcAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CDuZIb/cNz5JNeAJ6/sJchpM3pvAPRHxKn5SEbiP3/4hpny9/e9Q775T9nuzGOV38
	 Ft65rxWIJIIwsRDBrqNyyG3rJdkqMAgi8ud2zs/1n4lT0zb+OKIYtegIEbWCA1KbsK
	 Y3xah2UYyzXR7i/Hek6VLZHHXjF1Ac3/GKUW0JU4rpcCunAMJMmeDI3xgAKikrA1BW
	 5D0NviaqP+TFZlP72VhF+H7vrJUM4mZKYqPLDxLwuVxDiw+CvniXGtAH0ks/58tziB
	 vE7SrA9oTTisPN29JB6kweVZ3TbVh7G0z/DYb2gv1Xzc8KrQ3rcQbqU75M45zHcwlV
	 X7Bisd5/sv54w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9535C80FA6;
	Mon, 16 Nov 2026 17:01:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 725834DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EB5E80FA6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:01:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5PXpV_3bInJ for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:01:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16B1F80ED9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=84.16.66.175
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.175;
 helo=smtp-42af.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=Wioc3cVL
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16B1F80ED9
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:01:16 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSvJn665hz2rJ1;
 Mon, 16 Nov 2026 18:01:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794848473;
 bh=3A7QdOgRBkhy7zgWN1Qbu38I4lTmT+OnFK0lS9EWcAc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Wioc3cVLrAdkF+eibR9E7BwIXNDrYfX8IpKVunIFelGdL772oh/ZJfjrTI6X790F+
 UsO20mtfHvcSEjPhkJvkSNoI/IWnM+1SIGLUHT6OyKSSuAxShxtEFVQgAK/cEVDgbS
 UaWJUvst/+y+rJ5XAaDRP0JHe77XwdHJ56a/Pjb7KUi+3P9bsNypKAgqwGlNJonNIz
 NTgBBUyC1+hqNQ0tfYPYf+KNCSUjSRLWzRHTVgpYVogAh6q6BLcqjrMVQjN83PDNXp
 SwD7QuvVtij6somhhERHAtnQgnTRm/XWRPcvweeqo5/3zq/oLkfgeIrSNbZg7pxIuv
 ly0GVuLbCaD3w==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jSvJm2vwxzQwc; Mon, 16 Nov 2026 18:01:12 +0100 (CET)
Message-ID: <6ef4b457-51c8-4821-a54f-ec30c14c7a27@0leil.net>
Date: Mon, 16 Nov 2026 18:01:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/37] rockchip: Miscellaneous RK35xx clock fixes
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261011222930.1085075-1-jonas@kwiboo.se>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/12/26 12:28 AM, Jonas Karlman wrote:
> This series fixes a few trivial copy-paste mistakes and other misc clock
> issues for RK35xx SoCs.
> 
> Some of these fixes have only been compile tested as it involves clocks
> or rates that are rarely used in U-Boot.
> 
> The 'special pll handling' should ideally be moved into clk_rk3588
> driver, something that can be done in a future follow-up series.
> 
> Similarly, any refactoring has been held back for a future follow-up
> series.
> 
> Changes in v2:
> - Add patch to fix automatic PLL fractional calculation
> - Add patch to request a working rate for saradc on RK3528
> - Split "Fix trivial clock configuration errors"
> - Update commit messages
> - Add fixes tag
> - Collect r-b tags
> 
> Jonas Karlman (37):
>    clk: rockchip: pll: Fix fractional PLL rate calculation
>    clk: rockchip: pll: Fix automatic PLL fractional parameter calculation
>    clk: rockchip: pll: Always write the dsmpd flag
>    clk: rockchip: pll: Always write the k parameter
>    clk: rockchip: pll: Use PLL_FIXED_MODE flag on RK3588/RK3576 PPLL
>    clk: rockchip: pll: Limit special rk3588_pll handling to RK3588
>    clk: rockchip: rk3568: Use correct clock id for GPLL
>    clk: rockchip: rk3568: Fix PWM0 parent selection mask
>    clk: rockchip: rk3568: Use PWM0 divider shift
>    clk: rockchip: rk3568: Use correct PLL rate for CLK_MAC0_2TOP
>    clk: rockchip: rk3588: Use GPLL rate for CLK_TSADC
>    clk: rockchip: rk3588: Use correct PLL rate for SCLK_UARTx divider
>    clk: rockchip: rk3588: Fix ACLK_BUS_ROOT divider encoding
>    clk: rockchip: rk3588: Set ACLK_BUS_ROOT to 375 MHz
>    clk: rockchip: rk3588: Remove redundant PLL register macros
>    clk: rockchip: rk3588: Rename PPLL register macro
>    clk: rockchip: rk3588: Align BxPLL entries in PLL table
>    clk: rockchip: rk3588: Use SPLL_HZ constant
>    clk: rockchip: rk3576: Use correct mode register for VPLL
>    clk: rockchip: rk3576: Fix ACLK_TOP_MID parent selection
>    clk: rockchip: rk3576: Fix I2C rate selection
>    clk: rockchip: rk3576: Fix CLK_I2C8 rate change
>    clk: rockchip: rk3576: Use correct clock register for CLK_SARADC
>    clk: rockchip: rk3576: Use correct TSADC clock register
>    clk: rockchip: rk3576: Use correct PLL rate for UART fractional clocks
>    clk: rockchip: rk3576: Use correct PLL rate for UART divisor
>    clk: rockchip: rk3576: Rename PPLL register macro
>    clk: rockchip: rk3576: Remove unused BPLL register macro
>    clk: rockchip: rk3576: Group LPLL register macro with CCI macros
>    clk: rockchip: rk3576: Align BPLL entry in PLL table
>    clk: rockchip: rk3528: Return correct rate for CLK_PWMx
>    clk: rockchip: rk3528: Fix VOP clock configuration
>    clk: rockchip: rk3528: Align PPLL entry in PLL table
>    clk: rockchip: rk3506: Return correct rate for CLK_I2C0 and CLK_I2C1
>    clk: rockchip: rk3568: Drop unused GRF syscon lookup
>    clk: rockchip: rk3588: Drop unused GRF syscon lookup
>    adc: rockchip-saradc: Use 3 MHz clock rate for RK3528
> 
>   arch/arm/include/asm/arch-rockchip/clock.h    |  2 +-
>   .../include/asm/arch-rockchip/cru_rk3568.h    |  1 -
>   .../include/asm/arch-rockchip/cru_rk3576.h    |  5 +-
>   .../include/asm/arch-rockchip/cru_rk3588.h    |  6 +-
>   drivers/adc/rockchip-saradc.c                 |  2 +-
>   drivers/clk/rockchip/clk_pll.c                | 75 ++++++++++---------
>   drivers/clk/rockchip/clk_rk3506.c             |  2 +
>   drivers/clk/rockchip/clk_rk3528.c             |  7 +-
>   drivers/clk/rockchip/clk_rk3568.c             | 12 +--
>   drivers/clk/rockchip/clk_rk3576.c             | 26 +++----
>   drivers/clk/rockchip/clk_rk3588.c             | 35 ++++-----
>   11 files changed, 82 insertions(+), 91 deletions(-)
> 

Applied to 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip 
(u-boot-rockchip-2027.04), thanks!

[19/37] clk: rockchip: rk3576: Use correct mode register for VPLL
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/c823d81f321d5dda72913a8f55cf24cc16be599f
[20/37] clk: rockchip: rk3576: Fix ACLK_TOP_MID parent selection
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/08bfc9404d2119a411966cc5e2e2b7947b8f1da1
[21/37] clk: rockchip: rk3576: Fix I2C rate selection
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/667f289e5d6acd5c0ed21636841ded453dd4cf35
[22/37] clk: rockchip: rk3576: Fix CLK_I2C8 rate change
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/eb14d812d43f54736ae54c4f91bdbb495e2e77a6
[23/37] clk: rockchip: rk3576: Use correct clock register for CLK_SARADC
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/70b332b9f2506b0d9c3b3110fa02d2c1b8cfce90
[24/37] clk: rockchip: rk3576: Use correct TSADC clock register
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/76dafc2ec43e577d0cac76fd10b0554dcd6639f5
[25/37] clk: rockchip: rk3576: Use correct PLL rate for UART fractional 
clocks
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/5bddf9c424069880fd6ae944155a3fa1652930b8
[26/37] clk: rockchip: rk3576: Use correct PLL rate for UART divisor
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/cbf6a1861c39192dee3341c01dd303ea9abeef43
[27/37] clk: rockchip: rk3576: Rename PPLL register macro
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/edaf43c86c020f0773fffe567d3ee19aebaaedf5
[28/37] clk: rockchip: rk3576: Remove unused BPLL register macro
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/3275c34bf89ebaf3d674634ce22d77a72786b86d
[29/37] clk: rockchip: rk3576: Group LPLL register macro with CCI macros
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/85764f09df205cd52251f875f9db92e2eb1075e8
[30/37] clk: rockchip: rk3576: Align BPLL entry in PLL table
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/2da9803d9b697da4672e2fe5c834b43106149dcb
[34/37] clk: rockchip: rk3506: Return correct rate for CLK_I2C0 and CLK_I2C1
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/1a7307125f6bb7288735349b50305d05806ef7a3
[35/37] clk: rockchip: rk3568: Drop unused GRF syscon lookup
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/6dfb0b4ada2c3a13de5cc159e8058b23f606629c
[36/37] clk: rockchip: rk3588: Drop unused GRF syscon lookup
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/bac001a2402702f26d033ce435dc97185556cc41
[37/37] adc: rockchip-saradc: Use 3 MHz clock rate for RK3528
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/23066d3253419eeab5fe601d48d2c9df9b1526b1

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

