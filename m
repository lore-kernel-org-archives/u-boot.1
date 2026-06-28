Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05E6C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 20:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B9B83FEE;
	Sun, 28 Jun 2026 22:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="XDEhr00S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28286843B6; Sun, 28 Jun 2026 22:21:13 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C73805D7
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 22:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EAB58118336; Sun, 28 Jun 2026 22:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782678070;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=RPqwGBWfTeT+KiHMUcHZqr1z+yW9SnngCPHNy0Ko+Wc=;
 b=XDEhr00Szz4fl9AVNF62gToL99fC3ojwaW6nlB9VC223IQM6bR1pq4H86so9398UhnNiQF
 sLh5/kvg2rT1oSo1EO7Bp5rhdtuEbyTQzXxvy6uwCUdJ1OyRi4zpOMKV5jIKiwZLNcAKZ1
 oaK8ULIvVPZiawk6qMnoidf3QOJxjSs9syAoXgwklXoU0svvFzXtbfhk5OXUoNQuv8ZXT/
 29KBucFoRDE2FschZfSnphS70Pyp/5zSwXbhMmYYtRqIOrR4nnmE7eRdpYH4n7sFf/oYub
 Q43nrdwF3wWZA46bXAxOAabd4XktBF3ztULKXzkfUoAGX+qC438lc3nI9Kwo5Q==
Message-ID: <6f745e04-2978-4474-940e-4cafd6f61851@nabladev.com>
Date: Sun, 28 Jun 2026 22:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mmc: sdhci-cadence: trigger tuning for SD HS mode
 on SD6HC (v6) PHY"
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, trini@konsulko.com,
 Jaehoon Chung <jh80.chung@samsung.com>, Tze Yee Ng <tze.yee.ng@altera.com>
References: <20260628185752.1504-1-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260628185752.1504-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/28/26 8:57 PM, Tanmay Kathpalia wrote:
> This reverts commit b42c67188c14 ("mmc: sdhci-cadence: trigger tuning
> for SD HS mode on SD6HC (v6) PHY").
> 
> The reverted patch added runtime DLL delay calibration for SD High
> Speed mode on the Cadence SD6HC (v6) PHY, gated by the device tree
> property "cdns,sd-hs-tuning". Reviewer feedback identified issues with
> the implementation, but the patch was merged without those concerns
> being adequately addressed or justified.
> 
> Reverting to realign the driver with the IP documentation and the SD
> Physical Layer Specification, as the underlying issue requires a
> different solution approach.
It would be good if the commit message went into details of those issues 
and explained the reasoning behind the revert. I.e. include details please.
