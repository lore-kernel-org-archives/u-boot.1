Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B757EC28B28
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 03:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 530BF81100;
	Mon, 10 Mar 2025 04:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741576065;
	bh=3KjAhOY/M1uGCu2fKwZl38uuAvgkaDY7OvtFrrs7HEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UwuFeK+Nb1XQ5RU6yfb+1wlOOlGu+77jbI32LCE/rmLBk3PaGpMbfH/VjNjEgNR06
	 qubzkzHI/oj4zgjZfjXNpQCAH+/lqLE6LoOJ4s0DrJ7ufa4ohtcZ0gc09UiZASB/+3
	 pA1jpnVFchVtCYx3B9mWkjTXIlGQUd/YrHSxLqEaS3SxMM1b56pxPIkQJudu95rgzF
	 DDbikvPB0VufuGZRsChwT2TfWLlekRxWY/wXVeLb4kopCeU70z4pQfs0J9PTBFnvYN
	 edvqdFrzyDI7EuZ1O/20a9+t4heCy07Zsq3yv1bz+x1l+IuICLgDgZTsdzq0u8vDiB
	 OsCc7FWg1FcCQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6797E81545; Mon, 10 Mar 2025 04:07:44 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8B180E93
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 04:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="acj/WitU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2CF31102E6338; Mon, 10 Mar 2025 04:07:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741576060; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3KjAhOY/M1uGCu2fKwZl38uuAvgkaDY7OvtFrrs7HEw=;
 b=acj/WitU6KPhJF+cjnfxdwTu5lxJsUOL9LtI1Jj1gz36ZPLndcbK0m0Fggd2oJzMG86Xdu
 baegxyyfUeKxrCp/BzZ9+ugxXYhDbtfVrfubmYJWB6tGnZp48oHCPdmiQXBYqWGGGhF/qL
 5I7ZVSWRNnCxCoG3b2CfynH0ImXF5zDNv5ElC4Q4RdrhJMgH/o9anhCCHXXfQZCaRralQl
 IDYBRWS9TvBqGUryDO3F8pzL5X53Ng78jogUR2nVmIgJIiwcd6+252vnf3/L7/wYzR9fnw
 hSl1aOQ+0+sq5iuRORAM9dRIRB7v2K84NnVsfhn1iAgLrkJ3KCCkYCrjY8D2PQ==
Message-ID: <aa93e408-ad8b-4ac9-b853-05cc8ca190a2@denx.de>
Date: Mon, 10 Mar 2025 01:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: add i.MX Messaging Unit (MU) driver
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, trini@konsulko.com,
 sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, alpernebiyasak@gmail.com
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, viorel.suman@nxp.com, ye.li@nxp.com
References: <20250304065740.2732356-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250304065740.2732356-1-alice.guo@oss.nxp.com>
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

On 3/4/25 7:57 AM, Alice Guo (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This patch provides a driver for i.MX Messaging Unit (MU) using the
> commom mailbox framework.
> 
> This is ported from Linux (v6.12.8) driver
> drivers/mailbox/imx-mailbox.c. Its commit SHA is:
> 39d7d6177f0c ("mailbox: imx: use device name in interrupt name")
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
> 
> Changes for v2:
>   - remove support for i.MX8ULP
Why ?
