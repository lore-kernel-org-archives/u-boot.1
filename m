Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB6AE7AD4A
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDEF87460;
	Tue,  3 Oct 2023 15:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PvvcywQz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I/gXEcPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 691BD8745D; Tue,  3 Oct 2023 15:40:52 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC318724A
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S0Jqk2gcBz9sqN;
 Tue,  3 Oct 2023 15:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ft77+2o7U7dJH1F/5yD3qsJXLo/pCid1pVe49ndmncU=;
 b=PvvcywQzZluuH8D4qH1H53xzbNZG+N2WKhXQ2G17yGkHSl1hIBCk2uUS6TyC1RzqkMtm7R
 ux77oesbUJOex4a0abCtpQC+5l+bsUCHNOzWIFsRIgBai4MJJTAyLX822E4anEFkXT6wL0
 8kKJJDkQqvsJXuzGGVXk6a+OqkE5n25+LgLHFvtl8/iHYrG/V87ZpM9rSmpQqaGusyq/TA
 h8GNlukc1HUixtV/d5jN85/WAb/aZwRm/278BWhukYZahB+TNJFogCS7QlN3HAd4uMW5Ye
 1qTdu6YJgQA14t1AXcE2ILTxbMXfKpyHVFbyXTrhI8GexAhYodvQnKNcrode4Q==
Message-ID: <f39461fe-cbfb-2bef-b012-0ca5c546520f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ft77+2o7U7dJH1F/5yD3qsJXLo/pCid1pVe49ndmncU=;
 b=I/gXEcPaPzMz1pxsJm7NpTkHo85nam3GX5NwX4wBfQqvXlS/yufMZ7rY+ZqZqz3gyJXwEb
 /LxGuag/m9U5YFDbxBHm25YNeKcnl4rFK+i9wap9V7AOrsp0LRMRD+oenLiq7T+/AY4hXa
 tkPM1fO9sEaAC21oKwgz+F8OSIyWr+Yx4jg5jTqXNXO8ZEXbz8yns+5/M/quXJZPl2gGqf
 GK9IZCsT1L6XYqOOgLk9HTwLGp/nUX3VC8VFnqZB0prhV1ApI6RiqYsN9JbVzPBVzyndn1
 Pvn53rP1aMUg4qpW6So7d6t5zTzxeK64bnHcGB1ZDpTzflVEoitnr5sHE6Zzzw==
Date: Tue, 3 Oct 2023 14:46:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 06/16] arm: rmobile: Add basic R9A07G044L SoC support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-7-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-7-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b52c8e14c7a95f2a3b2
X-MBO-RS-META: 7b4578mejs3cacbexab47msoszzit5r3
X-Rspamd-Queue-Id: 4S0Jqk2gcBz9sqN
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

On 9/20/23 14:42, Paul Barker wrote:
> Add a config option for the R9A07G044L SoC used in the RZ/G2L so that we
> can make use of this in the subsequent driver patches.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   arch/arm/mach-rmobile/Kconfig.rzg2l | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobile/Kconfig.rzg2l
> index 37ff6cd34160..266f82c18085 100644
> --- a/arch/arm/mach-rmobile/Kconfig.rzg2l
> +++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
> @@ -3,6 +3,11 @@
>   
>   if RZG2L
>   
> +config R9A07G044L
> +	bool "Renesas R9A07G044L SoC"
> +	help
> +	  Enable support for the R9A07G044L SoC used in the RZ/G2L.

I was under the impression that RZ/G2L is a SoC family, so the 
R9A07G044L is part of that SoC family ? Maybe just reword this paragraph 
and the commit message a bit to make it less confusing.
