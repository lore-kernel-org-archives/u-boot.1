Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74EEC5AE59
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 02:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A2DF82D2B;
	Fri, 30 May 2025 04:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HzOY31v/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TkcDP/PW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 377A782E26; Fri, 30 May 2025 04:17:49 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2655282B8E
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 04:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4b7n2K5GJCz9tKK;
 Fri, 30 May 2025 04:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1748571465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBXhYTYOtjmut9WEzwqm3kFftniwURdzwUHdBCoUYpM=;
 b=HzOY31v/zBOxWRb5Qw8hTHDq24cjCDk3lwtA1DJ7gqLxMYZjbBfJDma8IBdmZy4c/iiE5w
 Qgjzitkl9fLv/oPaJhm+Knu5cFDgvevGUTKT9N3vN4vMbyNbJK/C+hNSbNNKARn04yc+MP
 tQDcFlZ8J9BGetJUucNGccSS7as5xs/HKWOnC5qUgLW17mrgwMBg4bFtOhu7utrrejnAb7
 dKyP7ohqOkO4dze+UHbUbbvJzuHhQEMMVzLy2xo1rOape+2zb4XgaOszGk7UjZlG7U7IDX
 z7pzlF+iVX4FjoybXyR6gF/xuwx3RyMcGD67F5ijkl4h7tPT5ZtvaPH0z8GStw==
Message-ID: <032c25da-e093-4f44-9cd9-bbcf2c2c2156@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1748571463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBXhYTYOtjmut9WEzwqm3kFftniwURdzwUHdBCoUYpM=;
 b=TkcDP/PWW6Tqh1ULhFw8cAr4bUB4vBAFndFtptYm1GdHQjtvOIikxzrvWKrJstlUMdcD+q
 8cLqLYq8iT2voOMjd0HDxp8TUZzKMFbwo+53VPmJ9fog9pF/7njv06TRab/QG/TN81RDdC
 XXd8k+/QeMIB8GRY02/YMDxNxm0Nxv+ondcvmrct+qUIqE5lowAIhTyHucZ/EYlOFZBi0X
 Q2L0VGfEtcpY1CrJFjhBIpPyWSEXD0t4OVhBowE2e4zLVSEkw9cfMprZoJje5ZmH/AScL9
 3e5t7HSbYsP0i6mdeOK0wrfFUYvlWR/mmVgO66xrnfGbFV14ImnHWiPq+Nh4UA==
Date: Fri, 30 May 2025 04:17:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] renesas: Renesas R-Car Gen4 watchdog driver
To: smelamud@redhat.com, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
References: <20250530-us-renesas-watchdog-v2-1-b0d8f96c64dc@redhat.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250530-us-renesas-watchdog-v2-1-b0d8f96c64dc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: nf37bw43skgn9bro96w8gjp6hkbr9s5w
X-MBO-RS-ID: 4b823db5822a847612a
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

On 5/30/25 12:58 AM, Shmuel Melamud via B4 Relay wrote:
> From: Shmuel Melamud <smelamud@redhat.com>
> 
> Add support of Renesas R-Car Gen4 watchdog timer. Timeouts up to
> 8184.0s are supported (CKS1 register is not involved). The watchdog
> uses the clock type CLK_TYPE_GEN4_MDSEL, so handling of this constant
> is added to gen3_clk_get_rate64() function.
> 
> The timeout is set in
> dts/upstream/src/arm64/renesas/r8a779f0-spider-cpu.dtsi section &rwdt.
> 
> This patch was tested on real Renesas R8A779F0 hardware. If the watchdog
> driver is enabled at the build time, the watchdog timer is initialized
> when U-Boot starts. Under normal circumstances, U-Boot loads the kernel,
> it starts systemd and systemd continues to pet the watchdog. If systemd
> is not started before the timeout expires, the watchdog resets the
> board.
> 
> Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>
> ---
>   drivers/clk/renesas/clk-rcar-gen3.c |   4 +-
>   drivers/watchdog/Kconfig            |   8 ++
>   drivers/watchdog/Makefile           |   1 +
>   drivers/watchdog/renesas_wdt.c      | 172 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 184 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/clk-rcar-gen3.c
> index 375cc4a4930873ad0d5509c19ad04a0ea5545aa0..5745acf4023c9114f6fa13b5e4baa306c5b57d33 100644
> --- a/drivers/clk/renesas/clk-rcar-gen3.c
> +++ b/drivers/clk/renesas/clk-rcar-gen3.c
> @@ -68,7 +68,7 @@ static int gen3_clk_get_parent(struct gen3_clk_priv *priv, struct clk *clk,
>   		if (ret)
>   			return ret;
>   
> -		if (core->type == CLK_TYPE_GEN3_MDSEL) {
> +		if (core->type == CLK_TYPE_GEN3_MDSEL || core->type == CLK_TYPE_GEN4_MDSEL) {
>   			shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
>   			parent->dev = clk->dev;
>   			parent->id = core->parent >> shift;
> @@ -318,6 +318,8 @@ static u64 gen3_clk_get_rate64(struct clk *clk)
>   						"FIXED");
>   
>   	case CLK_TYPE_GEN3_MDSEL:
> +		fallthrough;
> +	case CLK_TYPE_GEN4_MDSEL:
>   		shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
>   		div = (core->div >> shift) & 0xffff;
>   		rate = gen3_clk_get_rate64(&parent) / div;

Clock driver change should be in separate patch.

I'll try to review the watchdog driver itself in the next few days.

Thanks !
