Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8F7C531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 10:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE923408DB;
	Thu, 23 Jul 2026 10:33:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bx5Uoo6PlcV1; Thu, 23 Jul 2026 10:33:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D1A94089B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784802830;
	bh=Id8d9yI4/kLcHZoHk/xBWaOPkSJepQMMshABiXyJ00s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=es9aJtEO32AbFU+MZGBI0ZqLerLA8uy9pKxJ3ISHVpx0Bjtv+zz3eq2u6V3J/yopP
	 ltgAShsKxEVGn0PhqgWBtva5BTQQpEKEiB0pJri4PFq2zb/V0zKttvOWgSlESqlVCs
	 ajhu7VTnXdOLO68Lu2yAm/bv14Bfh4KaZK5uOdfHnTsSkxDw/N0aNyOdk56voaCR78
	 exnbyDiU3WWzt+L/K9dJKMpR2LNP76p8PthSRtmpb6zhSGV8wWrlp/1tzkLyr7ERsi
	 qqm1eTub7VNjvJLFUwpgmIU7fto/4DUkhjAPnn3HEbg0ZUyq+zCsrAazxif3g5LdCY
	 esOIuIP6C/MfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D1A94089B;
	Thu, 23 Jul 2026 10:33:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 680082E5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 598B480F59
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o6K01GN5wdoQ for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 10:33:48 +0000 (UTC)
X-Greylist: delayed 424 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 23 Jul 2026 10:33:48 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 38DC180E02
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38DC180E02
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38DC180E02
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:33:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00BAE1595;
 Thu, 23 Jul 2026 03:26:39 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 0D34C3F86F; Thu, 23 Jul 2026 03:26:41 -0700 (PDT)
Message-ID: <a93b75ce-5dd1-481c-8de6-06d58e6d2715@arm.com>
Date: Thu, 23 Jul 2026 12:26:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sunxi: Fix mod clock register offset for the A80
To: =?UTF-8?Q?S=C3=B6ren_Hantel?= <fugininsane@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?S=C3=B6ren_Hantel?=
 <fugininsane@googlemail.com>, Claude Fable 5 <noreply@anthropic.com>
References: <20260722162126.2790195-1-fugininsane@googlemail.com_quarantine>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260722162126.2790195-1-fugininsane@googlemail.com_quarantine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1784802403; bh=V5ODkwPbMxVLCBk8AFF6g8f2jkPsosSjHEpNZsa1xhA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=awW57CbSzRd2sANL2oxKi3VpR/3xZ4dpzDt5oXlJ2Tr49sL7g0aDEU+LnXsyJjfA9
 tLr/tBHGvvG2b5DzsK7ofu3OAOjKz0S7EN1Q4oy+5DGwHRnk/SXvmgk70Kmu/lOP33
 LEi9n/p05p9K5AXKvc9OWH4kSnYMgTQa6+NRKn4k=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=awW57CbS
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Sören,

thanks for sending this!

On 7/22/26 18:21, Sören Hantel wrote:
> get_mclk_offset() checks CONFIG_MACH_SUN9I_A80, but no such Kconfig
> symbol exists - the A80 is covered by CONFIG_MACH_SUN9I. The check

Ouch, it's not the first time we have this issue, I remember fixing a 
misspelled guard in the past. And recently found another one.

So since you have a tireless and non-complaining helper at hand, can you 
ask Claude to hunt for those misspelled/non-existing config options, in 
the sunxi code? So all drivers used by sunxi and the board/sunxi and 
arch/arm/mach-sunxi directories. Maybe also look for CONFIG_MACH_SUN.*I 
like symbols. It's hard to do this with just grep and friends.
As a motivation: it should find at least one ... ;-)

> therefore always fails and the function falls through to the default
> offset 0x88, which lies in a reserved region of the A80 CCU. All mod
> clock writes from U-Boot proper end up there and are silently lost,
> so the SD/MMC controllers keep running at whatever clock the
> SPL/BROM left behind.
> 
> For the eMMC on SDC2 that means card identification runs at the
> ~48 MHz the SPL used for loading U-Boot instead of 400 kHz: short
> responses still limp along, but long (R2) responses are received as
> all-ones, CMD2/ALL_SEND_CID fails and mmc_init() returns -110. This
> went unnoticed for years because the SPL uses the legacy code path
> with a hardcoded mclk address, so booting *from* eMMC still worked -
> only U-Boot proper could never access the eMMC on sun9i.

Ah, that's a good find, I was already wondering about that, since I 
think I briefly tested eMMC on my A80 board ...

> Use the correct Kconfig symbol so the mod clock writes reach the SDC
> clock registers at CCU offset 0x410.
> 
> Tested on a Cubietech Cubieboard4: eMMC identification now succeeds
> and distro boot from the eMMC works.
> 
> Fixes: 0237b3047e25 ("mmc: sunxi: Refactor mod clock register offset")
> Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
> Signed-off-by: Sören Hantel <fugininsane@googlemail.com>

Thanks, looks correct. Will take it ASAP.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>   drivers/mmc/sunxi_mmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index e28c81af..623393fc 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -663,7 +663,7 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {
>   
>   static unsigned get_mclk_offset(void)
>   {
> -	if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
> +	if (IS_ENABLED(CONFIG_MACH_SUN9I))
>   		return 0x410;
>   
>   	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))

