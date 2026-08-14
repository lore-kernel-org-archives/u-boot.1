Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F6AC5DF6D
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E52E340C9A;
	Fri, 14 Aug 2026 22:44:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7PsBAiZ7t3zx; Fri, 14 Aug 2026 22:44:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABE2740C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747448;
	bh=TNfuPzIkOXDbTn7F01x5b+f0nNN9O6A7KTe8h2D3eLU=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SLd8p/sf07WntyGo/ZXJCgCfCS7RWLR42YaTQbradDirUvEd5y5xNMppTZc3ibU0M
	 Ks76iCFm2NBsvEQN1ZdFz2ZYhj9YJ13n7dII8m6HGBkXFli1N+inRtlZq6w6K+zbC/
	 poq2n9ZKgDkC04iE1kesVa2peBvNtshLn5cwIiZwNSTWlh9uVXtOa61br5o3zSuzY5
	 Z64zAKIVMeiN/lLGVlBm9WNaviBwWPu7lpFc+tmG3BS/p7kMRloqyTqvMge1bjIDrz
	 HNmLvLwv5lnTJnBUTIrVgbTX8+lMTXweI6y7Y5xNsNMOIEonI9aRY3Tz8rpyMbA6vP
	 Ib2wwLBO5y47Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABE2740C62;
	Fri, 14 Aug 2026 22:44:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CCF35139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B356C81289
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UpQy_SCmR3Uf for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 50467811B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50467811B3
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 50467811B3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:05 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hMHMl1L8gzKnSQ;
 Sat, 15 Aug 2026 00:44:03 +0200 (CEST)
Message-ID: <43fec897-24f2-40f6-b1d4-63a7a171a013@mailbox.org>
Date: Sat, 15 Aug 2026 00:03:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] spi: cadence_qspi: enable all clocks
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
 <20260814-rzn1-2026-10-spi-v2-1-973d5fa092f2@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-spi-v2-1-973d5fa092f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4wig8jinq7s9p3k945her99ttdux4tx5
X-MBO-RS-ID: 112d1aab26f0095ff3e
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/14/26 8:28 PM, Ralph Siemsen wrote:

[...]

> @@ -250,7 +250,11 @@ static int cadence_spi_probe(struct udevice *bus)
>   			return ret;
>   #endif
>   		} else {
> -			priv->ref_clk_hz = clk_get_rate(&clk);
> +			ret = clk_enable_bulk(&clks);

Some sort of clk_disable_bulk() seems to be missing.

Fail path which disables the clock seems to be missing too in this function.

> +			if (ret)
> +				dev_warn(bus, "failed clk_enable_bulk\n");
> +
> +			priv->ref_clk_hz = clk_get_rate(&clks.clks[0]);

Can the refclock be second or later (not first) clock in the list of 
multiple clock in DT ? If yes, then the clk_get_rate[0] will return 
bogus rate for another clock.
