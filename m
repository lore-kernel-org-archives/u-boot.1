Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF740E69E99
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 22:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E7D688D3A;
	Mon,  2 Dec 2024 23:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Jw4WS3cF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BFA8951D; Mon,  2 Dec 2024 23:54:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26B238945A
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 23:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=706d=S4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1733180078;
 bh=wU/r6wDw1ESOXaWAAt1ytVCZ4xUxWshVhQxRQr66rQ4=;
 b=Jw4WS3cFE16pcOgKqqdmQiLXfNYk7V4tXR2Ra52x+nKR+z4n2AwkpvANDKBijRtVPyB1xnl9w
 Cg6s3SVJyS/2IuxL3ydwtvvK2LRN+gmpeC27f5dQA4olj9bsc8fXknkfqKjAQUlLn23VtiANuz/
 N2Mh0cuGpLcynDDfTVZmSXdQxRheblBXWLzpJHO9POJ6JOA0nAdjnqEVQuiHOnSVwTXAT6vjSE0
 IO74tWv+b9qC7BsvSh/tOYd+Qx5g9OlEOkLiEIkjxffEX24VlTWeKmFUnPicURh/bCufjrwerFj
 y2XRq9/v1/vb3AmNUt3EmJCGG07NHLz+LvmAXhRff7hA==
Message-ID: <c92b3450-4b98-4bf3-8078-0caf410403d6@kwiboo.se>
Date: Mon, 2 Dec 2024 23:54:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] doc: remove redundant Rockchip bindings
To: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <71b804a0-ae2a-472c-84c9-ad7c6317e154@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <71b804a0-ae2a-472c-84c9-ad7c6317e154@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 674e3aa886eb3674dc8c1f52
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

Hi Johan,

On 2024-11-30 22:18, Johan Jonker wrote:
> Most Rockchip device tree related bindings are converted to YAML
> and available in the U-boot /dts/upstream/Bindings/ directory.
> Remove all redundant U-boot entries.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../clock/rockchip,rk3188-cru.txt             |  61 -------
>  .../clock/rockchip,rk3288-cru.txt             |  61 -------
>  doc/device-tree-bindings/clock/rockchip.txt   |  77 ---------
>  .../pinctrl/rockchip,pinctrl.txt              | 157 ------------------
>  .../thermal/rockchip-thermal.txt              |  68 --------
>  doc/device-tree-bindings/usb/dwc2.txt         |   4 -
>  .../video/rockchip-lvds.txt                   |  77 ---------
>  7 files changed, 505 deletions(-)
>  delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3188-cru.txt
>  delete mode 100644 doc/device-tree-bindings/clock/rockchip,rk3288-cru.txt

The rockchip,rk3288-cru.txt file is also removed in:

rockchip: rk3288: Use rk3288-cru.h from dts/upstream
https://patchwork.ozlabs.org/project/uboot/patch/20241109210427.884888-4-jonas@kwiboo.se/

Regards,
Jonas

>  delete mode 100644 doc/device-tree-bindings/clock/rockchip.txt
>  delete mode 100644 doc/device-tree-bindings/pinctrl/rockchip,pinctrl.txt
>  delete mode 100644 doc/device-tree-bindings/thermal/rockchip-thermal.txt
>  delete mode 100644 doc/device-tree-bindings/video/rockchip-lvds.txt

[snip]
