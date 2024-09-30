Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C884FCE8347
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 13:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DC4880D8;
	Mon, 30 Sep 2024 15:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G0Fo/dxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E056088F32; Mon, 30 Sep 2024 15:50:14 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE32880D8
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 15:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A54FAA420FA;
 Mon, 30 Sep 2024 13:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EE4C4CEC7;
 Mon, 30 Sep 2024 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727704211;
 bh=yE3Cqc0FsPX+YgxKEpPEJH5Sqd1C1lolVCIIA8tiN6M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=G0Fo/dxY2IQltNML5ARt6f0e5ebXeY45VVK0z+ks8IkodWRwBDRUhVzpbL+F/PoTx
 39JVPpT6+EsluQ1ocJEcqOaEHl4HjebONGbQpFjGz9k4i5cucyXRaf13ZQttpRL8dA
 gxyylvVqKAUYLXY4yfkvbM+zpb7K17LjgRTj+USyJiDxFe3TLaaUJ/9ut1Ka6o7Xjv
 LwbaIWx384oJtebxCIH1vW7oN6EvTfknqZOGl8tL8KLHJc/DiotddRpmTaHwf6rkxu
 qnlcXq8U3gG0qujFCQd6SOmeujdrpWUgfpqyrKzwLkk49f4dC472iYzf1XfWA6egp5
 ef9dBx2ppt6cg==
Message-ID: <a10c16c9-1049-4b2b-b938-3e8555aecd7a@kernel.org>
Date: Mon, 30 Sep 2024 16:50:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: cdns3: Fix missing cache operations for
 non-zero Endpoints
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 lukma@denx.de, mkorpershoek@baylibre.com, marex@denx.de, vigneshr@ti.com,
 jjhiblot@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20240930093407.2998969-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240930093407.2998969-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 30/09/2024 12:34, Siddharth Vadapalli wrote:
> Transfer initiation and completion for the non-zero Endpoints are
> handled by cdns3_ep_run_transfer() and cdns3_transfer_completed()
> respectively.
> 
> Failing to flush the cache associated with the TRB Pool within
> cdns3_ep_run_transfer() results in the transfers never being initiated.
> Similarly, failing to invalidate the cache associated with the TRB pool
> within cdns3_transfer_completed() results in the transfers never being
> completed.
> 
> Fix this.
> 
> Fixes: 7e91f6ccdc84 ("usb: Add Cadence USB3 host and gadget driver")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
