Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FB3E92722
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 02:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6322D839DD;
	Sun, 28 Dec 2025 03:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="p/RCoHen";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E02839E2; Sun, 28 Dec 2025 03:04:41 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F5F083981
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 03:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4df2jK3mP0z9sc2;
 Sun, 28 Dec 2025 03:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766887477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRfqvaVKB1uTpWtSm8E6VAT/2rKCwPrtSNkF3b/bc2A=;
 b=p/RCoHenkT/425DhqiHBxEXe0R0B1VMkwtpEueJNdMPJkTAsXn3BOhvo0wll8FKTD8VnzU
 71rwO7LDFJIUXvHWzwwKMU3SRr4cqZQoqv8MFAQXhmFbjJzT0WWUpjZLreCDjY9uZingED
 /mDDn0yRo9scCotAmIIkSO7hv6xzc29ZTsyZwpUs6chVu3vsfK2UiIKVhBSitUDNmhU1hH
 RFGm1KrHvlsE/VelkUvN5rZbxUG5YbK7C/ZyCC5r/E0aJNW6Haqfbp/SPUO/Gn5PMlMX5d
 Tiiw2D+vaPtNO9HlZ2B346YgjRNovBdfHCgQDH0azMwilUa+wtcU4lJE4D9WVg==
Message-ID: <a0c985d7-9a8e-4820-89d1-5f491247869e@mailbox.org>
Date: Sun, 28 Dec 2025 03:04:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] clk: renesas: Do not disable realtime modules on
 R8A77995 D3
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251228010327.2836161-1-niklas.soderlund+renesas@ragnatech.se>
 <20251228010327.2836161-3-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251228010327.2836161-3-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c31813091ac01e5a93c
X-MBO-RS-META: uy6pycpi3bh15t9ny1xbm8xfab7r63gi
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

On 12/28/25 2:03 AM, Niklas Söderlund wrote:
> Later versions of the datasheet makes it clear D3 do not have any
> realtime module stop control registers (RMSTPCRx). Remove the
> manipulation of them from the module clock table to match this.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>   drivers/clk/renesas/r8a77995-cpg-mssr.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> index 0a59a19cb227..736812e04d0b 100644
> --- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> @@ -216,18 +216,18 @@ static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[2] __initconst = {
>   };
>   
>   static const struct mstp_stop_table r8a77995_mstp_table[] = {
> -	{ 0x00210000, 0x0, 0x00210000, 0 },
> -	{ 0x03e01000, 0x0, 0x03e01000, 0 },
> -	{ 0x000e2fdc, 0x2000, 0x000e2fd8, 0 },
> -	{ 0xc00014df, 0x400, 0xc00014df, 0 },
> -	{ 0x80000004, 0x0, 0x80000004, 0 },
> -	{ 0x40d20004, 0x0, 0x40d20004, 0 },
> -	{ 0x08c0008c, 0x0, 0x08c0008c, 0 },
> -	{ 0x09941c18, 0x0, 0x09941c18, 0 },
> -	{ 0x00801087, 0x0, 0x00801087, 0 },
> -	{ 0xf143dfc0, 0x0, 0xf143dfc0, 0 },
> -	{ 0x063e1820, 0x0, 0x063e1820, 0 },
> -	{ 0x00000000, 0x0, 0x00000000, 0 },
> +	{ 0x00210000, 0x0, 0, 0 },
> +	{ 0x03e01000, 0x0, 0, 0 },
> +	{ 0x000e2fdc, 0x2000, 0, 0 },
> +	{ 0xc00014df, 0x400, 0, 0 },
> +	{ 0x80000004, 0x0, 0, 0 },
> +	{ 0x40d20004, 0x0, 0, 0 },
> +	{ 0x08c0008c, 0x0, 0, 0 },
> +	{ 0x09941c18, 0x0, 0, 0 },
> +	{ 0x00801087, 0x0, 0, 0 },
> +	{ 0xf143dfc0, 0x0, 0, 0 },
> +	{ 0x063e1820, 0x0, 0, 0 },
> +	{ 0x00000000, 0x0, 0, 0 },
>   };
>   
>   static const void *r8a77995_get_pll_config(const u32 cpg_mode)

You likely also need this part to avoid any RMSTPCR access:

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c 
b/drivers/clk/renesas/renesas-cpg-mssr.c
index 39ff4541c1e..4b07dbb3277 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -127,7 +127,8 @@ int renesas_clk_remove(void __iomem *base, struct 
cpg_mssr_info *info)
                                 info->mstp_table[i].sdis,
                                 info->mstp_table[i].sen);

-               if (info->reg_layout == CLK_REG_LAYOUT_RCAR_GEN4)
+               if (info->reg_layout == CLK_REG_LAYOUT_RCAR_GEN4 ||
+                   renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77995)
                         continue;

                 clrsetbits_le32(base + RMSTPCR(i),
