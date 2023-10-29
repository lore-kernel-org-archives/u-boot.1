Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C381CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A830E87CB8;
	Sun, 29 Oct 2023 16:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592194;
	bh=GXsUdL7K310j7FQC4ZqiezFkr+SRUUoIp8Ag5DWS3/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vHBteU2/tyDeQO/7EA3qYJmBoPCJNKWted16gC+G2mgFpFDMYBoBbnMzpgKpbV2UX
	 aEm9y5LkPqpLYPiw2jF7KVdd+0UPEtyFOm7LPftHKTD+kGGS5b4LYZsSHvHN0icx/9
	 e7bM31h8o2GiRaBZSXR2nfspvlyGpDc/WhxsJTuUZlfucxQEbtbs1if5tSmxlnbEMR
	 /q2fti+h/e2O1hDCqzkID93ZUBQ2xAaVctpBuz22UZuHDxShFIC0pW0kIZ0u7FzQOQ
	 REhn5D/Nfq7jS1JuDrjUNLM8gHFjUV+qEMqEkrKpntJZAnCs1oqit3rMaHzFLBx+mB
	 1HvQExhWJF5PA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5BFD587C8A;
 Sun, 29 Oct 2023 16:09:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592187;
 bh=GXsUdL7K310j7FQC4ZqiezFkr+SRUUoIp8Ag5DWS3/g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FnzGMtpGUPbP8BPahhSomC4hsewHuZJ4XwBrA9gMA8MU+xsXyrCV6Ih+aQgUnTBLD
 d9ZsRguTxIuUE46IyLrborepD1PUNIyg3n7WgKPBvBf0iNDjkgQMFDcIUYiiD2qXBq
 +itVzQR9U+aooRGvMPJc7eQqEKQkneF1fkXAtG+n95sVoD1RuMVg4+c005oy1OdsCD
 bBARkfTca5nstKlg6Pu7cP8lbLkv/3vIdzrJHgmwhMCrc5P/HnJge+CzNsawY+pQVY
 sTuGD1s4L5MrkUNWBDGQA19nJeTB8ZvFMoSMQmGM8bRJCz1YMpj4BPszMnxfYJODum
 12CRPKK6wUP9g==
Message-ID: <197877a7-5317-4c87-936c-ade49537a215@denx.de>
Date: Sun, 29 Oct 2023 15:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] usb: xhci: Fail on attempt to queue TRBs to a
 halted endpoint
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
 <20231029-usb-fixes-1-v2-5-623533f6316e@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-1-v2-5-623533f6316e@marcan.st>
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
> This isn't going to work, don't pretend it will and then end up timing
> out.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   drivers/usb/host/xhci-ring.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index db8b8f200250..a969eafdc8ee 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -243,7 +243,8 @@ static int prepare_ring(struct xhci_ctrl *ctrl, struct xhci_ring *ep_ring,
>   		puts("WARN waiting for error on ep to be cleared\n");
>   		return -EINVAL;
>   	case EP_STATE_HALTED:
> -		puts("WARN halted endpoint, queueing URB anyway.\n");
> +		puts("WARN endpoint is halted\n");
> +		return -EINVAL;

Reviewed-by: Marek Vasut <marex@denx.de>
