Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EC1E6748D
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5197483D3C;
	Mon, 22 Dec 2025 12:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xzeMGJtk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24EC283DEB; Mon, 22 Dec 2025 12:38:16 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4368483B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dZbjw2rPsz9tSR;
 Mon, 22 Dec 2025 12:38:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766403492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtyPz8j1HnFoNrlXY+jzo90D2bcLDs0IN4ABdw078YI=;
 b=xzeMGJtkIVe2HxSAihtO5gsLjJVodjCe5eoCErGNwLHAv1mAaNDVnBetotfc0EW090Syp9
 F7hpMlFCQSZlm7RCQNqE70cNRZTftetCwyJ2W5Lj86VjsVgOEzfkM7JOfRYo8O/Y0muiOJ
 5SYzWCezU/zOUPqpVMog3o7qzCNa7amIbeA9jLSUDV6KY7VaTAA3QHXCTwSgtmiRjJqEb+
 14PrOy+VRl+rB6obeUOFMfdEcBj2spNkxZmclnp8dIFvHsC8PtoQcuN/FbewikYWH+FxYZ
 kbwWPzGVudLIRlOk8TEoZCsmNJKzNLVpE0lHgodNj6bCx6ehcqvQTjwqeKIqkA==
Message-ID: <4b813bef-21d6-4a0f-8ff7-bec702e1b37b@mailbox.org>
Date: Mon, 22 Dec 2025 12:38:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] arm: mvebu: db-xc3-24g4xg: Remove
 marvell,nand-keep-config
To: Chris Packham <judge.packham@gmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20251218225936.2016920-1-judge.packham@gmail.com>
 <20251218225936.2016920-3-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20251218225936.2016920-3-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8kesn71m7wdjgrb1z3yudsd6bceoo9by
X-MBO-RS-ID: 35a65699c9285361743
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

On 12/18/25 23:59, Chris Packham wrote:
> nand-keep-config is used to retain the NAND controller configuration
> from an earlier boot stage. In U-Boot's case there isn't an earlier boot
> stage so reconfiguring the NAND controller is required.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
> 
> Notes:
>      Changes in v2:
>      - None
> 
>   arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi b/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
> index dc20643bfa37..ad64813e7704 100644
> --- a/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
> +++ b/arch/arm/dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   	status = "okay";
>   	label = "pxa3xx_nand-0";
>   	nand-rb = <0>;
> -	marvell,nand-keep-config;
>   	nand-on-flash-bbt;
>   	nand-ecc-strength = <4>;
>   	nand-ecc-step-size = <512>;

