Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B81FD2E001
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 00:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8905489074;
	Wed, 23 Oct 2024 02:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QVPx78/H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aaWetYdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBE789085; Wed, 23 Oct 2024 02:58:51 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB3E488FF6
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 02:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XY9fG4M8tz9svs;
 Wed, 23 Oct 2024 02:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729645126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9d0bE0620anuwQdUS97w6uy6aKtJCAwls404clyfV0=;
 b=QVPx78/Hm6ynfniPJRgEz9rXHCt1OwPgssePH5wEHgoz8RKl10r14xrgDWPf7Hez6wbwm6
 upEBL9d7kLuUBdsMJg3Sf6xiF1eNqrBtVJg9vOzpruppuTnhbuxHN0Up7Zu9MHhlvCdeBr
 pjI4oIaIIFcJeLhJ1FAbEJjH5lnxz/OR0IOkMeV4pBIY/NdtQiTo1oxq8ND7geGpGVt39B
 +4cRy7Rp6mtVaFh6TpkdNnLp8R1Bz4mX0iX4twM/Uz6fEYXeNTmeQgx7qObiGlmWSIRH/l
 OMsjJfcoqumd1gB6ZIL0chuITFhj8YpZSHV8xvCTR4r9YMRDssnri6VyOZwE/A==
Message-ID: <a0a7bc7a-2ea5-49a9-aa44-fe78f830661c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729645124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9d0bE0620anuwQdUS97w6uy6aKtJCAwls404clyfV0=;
 b=aaWetYdJhuLRI6CBQBmNErZbLqhVBFEf9+PUO7qWqI6CTNLRISFLk9s+Ad/sqMpJhoxs8r
 VCNgCJpSn5wpbmTOnr/yG2wmd96A6T781MSTRVfUDpoz/cNI4+53MKIPbif20smCU0Ft2U
 InDjgECXqK/FFCV+RPjWprgNCV1+EVKV3ZvDyU+Hjp19tcuE5M1yrHGvOzys4CJUNO5s9/
 xS2g0cuvRi4XAN0ADB3lonnrybeC7RtdyRItdZTLm8DJxPdF1b5R7qvuKxnJQBF5FykuQd
 FpAeZup3NqM9Dxm1OtupgGVOv0nnmGJ1e3zpfI/BRh6qbczeYQi8vfxWFGc4kQ==
Date: Wed, 23 Oct 2024 02:58:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
References: <20241018075148.2783-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241018075148.2783-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: r711gn61qe66cjm89q9a8qh9b66qww5b
X-MBO-RS-ID: 6497ac90218b2a6719a
X-Rspamd-Queue-Id: 4XY9fG4M8tz9svs
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

On 10/18/24 9:51 AM, Paul Barker wrote:
> After the recent dts/upstream subtree merge, the sdhi compatible string
> used in the device tree for RZ/G2L family SoCs is "renesas,rzg2l-sdhi"
> not "renesas,rcar-gen3-sdhi". This broke the ability to access the eMMC
> and SD card devices on RZ/G2L boards.
> 
> Fix this by adding the new compatible string to the sdhi driver.
> 
> Fixes: 136b7b6d2e98 ("Subtree merge tag 'v6.11-dts' of dts repo [1] into dts/upstream")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>   drivers/mmc/renesas-sdhi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 23db2a75c444..916182cdadea 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -863,6 +863,7 @@ static const struct udevice_id renesas_sdhi_match[] = {
>   	{ .compatible = "renesas,sdhi-r8a77970", .data = RENESAS_GEN3_QUIRKS },
>   	{ .compatible = "renesas,sdhi-r8a77990", .data = RENESAS_GEN3_QUIRKS },
>   	{ .compatible = "renesas,sdhi-r8a77995", .data = RENESAS_GEN3_QUIRKS },
> +	{ .compatible = "renesas,rzg2l-sdhi", .data = RENESAS_GEN3_QUIRKS },
>   	{ .compatible = "renesas,rcar-gen4-sdhi", .data = RENESAS_GEN3_QUIRKS },

That should be placed here _after_ rcar-gen4 if we want to pretend the 
list is at least somewhat sorted.

With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
