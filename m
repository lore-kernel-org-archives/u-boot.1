Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A450C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C48987CC4;
	Sun, 29 Oct 2023 16:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592196;
	bh=UWq2z2NFvAlEyf0vT3uIl33SxO+JU107xKHJC3VibSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q7MyAfbOXPhYPmgySFQdMI5Gqe8UPKgO0cVLO9eZiJozOc7uPooE/8RTenvwHtcvT
	 l3JNfJDXHdMCOTt4icBrrYRRiIRYsbXaWqylUT3kvnogrlw/bzmzbruwoW2dWvIodH
	 fRqXTsQfR9q+GbdE3BNDdc5bSwe57LW7JWeb61zOPpNj4vvjflpK9HZzZzF/K4vWAv
	 EG9cIiJMEd0U/B1BygKoUCkbqi3D34gpcfuMzCTSUZlLIoTxKs+xf4orLMkximWVp1
	 nUilab2oC6azsBLnLRwpu5pTF5qcYSGoDpp+9N910RUF53ATwygTj60A40miKnotQv
	 J/r3p8YPiGoxw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1F8A387954;
 Sun, 29 Oct 2023 16:09:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592189;
 bh=UWq2z2NFvAlEyf0vT3uIl33SxO+JU107xKHJC3VibSU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kyWGK8e88idULhrbxZmNgXnVHCrtPoCpD+VkPhX+J4+dpqXBh89u2J11JK/5gwfjS
 2V0WTB8kkCFUgf12mGb6xPFhX9tQqnJYh0vcLpwf5mWjTXkbtYLREErW8SmSNb9UQS
 Lk6LWYkOiXbQXPc00l6AARwND1Si5fw+Bm+1VDKoGZdS+NQHD4BiwzXKqqJy+0duzK
 36e1bEnGTH3OOKTnXbhMRi1NLJMVSXmDiTywbub5Gcjh4eYGFEbiCe9VJKweVKSlO/
 qV6nmcRX7yBDvQe8okCLQLfKo6jPsE7frPW0L8qULLtYgrstbOWUEvXMbexEpcqqH3
 DaICOJ02Gs6vQ==
Message-ID: <afe9aef0-fac7-465d-802f-afa79e22bd00@denx.de>
Date: Sun, 29 Oct 2023 15:36:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] usb: xhci: Add more debugging
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
 <20231029-usb-fixes-1-v2-8-623533f6316e@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-1-v2-8-623533f6316e@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/29/23 07:37, Hector Martin wrote:
> A bunch of miscellaneous debug messages to aid in working out USB
> issues.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   drivers/usb/host/xhci-ring.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index b60661fe05e7..dabe6cf86af2 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -214,6 +214,9 @@ static dma_addr_t queue_trb(struct xhci_ctrl *ctrl, struct xhci_ring *ring,
>   
>   	addr = xhci_trb_virt_to_dma(ring->enq_seg, (union xhci_trb *)trb);
>   
> +	debug("trb @ %llx: %08x %08x %08x %08x\n", addr,
> +	      trb_fields[0], trb_fields[1], trb_fields[2], trb_fields[3]);
> +

Could you please use dev_dbg() instead of debug() ?
That way you'd also get the device prefix in the output.
