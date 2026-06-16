Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45130CD98CF
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7ED84119;
	Tue, 16 Jun 2026 11:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i3PGJWVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E90E846A4; Tue, 16 Jun 2026 11:16:04 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 743AF84105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 050EF600AB;
 Tue, 16 Jun 2026 09:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F9C1F000E9;
 Tue, 16 Jun 2026 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781601360;
 bh=ruIa8YKqFq8uw2rMlG6RtXA15TSM73u0MN+l98g/hTc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=i3PGJWVkiHxCq3AP7Hj62ZxLbw7Ws4Oie04kvq1/gl86uJE+BsW0s09+xihkbiDV5
 xSM8vZKtCdu7LEsdo4RHNJgR7yVWj0L/g4zCYQyHYCyGHC6yzFo0OxqG1jx5MBUfY+
 9h1FdOYPtzgmz3Tp9Je0Pxx+Mj8/0xEH1/tcURpE3TBJ7ZHQW05rVyX4y7OGNYot1+
 jvAIce3QwCFkwVmMJN64H+EeZZG4cEMHgDWPEKD3Rbj9AJNG/bOfxbIM2Eyik0PY5T
 6t73Qly3dr8N2VTlS9rT4/MHxWCuBo3i4THHjG0Ia+sWph16lJunZsL7nCX5Jv9Pw9
 dZPi2m4+aD97Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ye Li <ye.li@nxp.com>, lukma@denx.de, mkorpershoek@kernel.org,
 u-boot@lists.denx.de
Cc: festevam@gmail.com, peng.fan@nxp.com, uboot-imx@nxp.com,
 ye.li@oss.nxp.com, xu.yang_2@nxp.com, jason.he_1@nxp.com
Subject: Re: [PATCH 2/3] usb: ci_udc: Update usb request status
In-Reply-To: <20260522075512.1291485-2-ye.li@nxp.com>
References: <20260522075512.1291485-1-ye.li@nxp.com>
 <20260522075512.1291485-2-ye.li@nxp.com>
Date: Tue, 16 Jun 2026 11:15:57 +0200
Message-ID: <87ik7ihmlu.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Ye,

Thank you for the patch.

On Fri, May 22, 2026 at 15:55, Ye Li <ye.li@nxp.com> wrote:

> usb request status is not set in ci_udc driver. However
> in ci_ep_dequeue, it checks the request status for executing
> complete callback, so upper layer is not able to free these
> enqueued requests when calling usb_ep_dequeue.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Fixes: 26cc5129ee64 ("USB: gadaget: add Marvell controller support")

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/gadget/ci_udc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index a62e5ea5658..0baad83ef90 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c
> @@ -680,6 +680,8 @@ static int ci_ep_queue(struct usb_ep *ep,
>  	if (ret)
>  		return ret;
>  
> +	req->status = -EINPROGRESS;
> +
>  	DBG("ept%d %s pre-queue req %p, buffer %p\n",
>  	    num, in ? "in" : "out", ci_req, ci_req->hw_buf);
>  	list_add_tail(&ci_req->queue, &ci_ep->queue);
> @@ -754,6 +756,7 @@ static void handle_ep_complete(struct ci_ep *ci_ep)
>  		ci_ep_submit_next_request(ci_ep);
>  
>  	ci_req->req.actual = ci_req->req.length - len;
> +	ci_req->req.status = 0;
>  	ci_debounce(ci_req, in);
>  
>  	DBG("ept%d %s req %p, complete %x\n",
> -- 
> 2.37.1
