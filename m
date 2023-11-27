Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA96C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 05:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA1D6874EC;
	Mon, 27 Nov 2023 06:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="ZAEHpRIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D363B86FB4; Mon, 27 Nov 2023 06:57:49 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4613C874EC
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 06:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id F2F4242499;
 Mon, 27 Nov 2023 05:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1701064664; bh=f6sRTeWV7ZtLqJ12N5Tz+hJlC+JbG1y4cq/rmpNK8FE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ZAEHpRIaENrYjvKcqgG88kxsXukeZJBnIvEWp6OWn/G0ARIIgMXME0njLnrRX9489
 ciCuXeaxn+It+bqp32TdWVNCDN6R0YavPF7K9Kq76+dkKAq3v7mOyd/OlEfhVUrGkt
 sy3auooh7bFn1kdjWwNMg2u1AuTYyV2TrPZrvw4pUHLQtAoF4ucqyZ9pzaqYsY7mKx
 mp9cIIxhrB7q3s7zj8bb3jWEC0mTlXkgzrtamO6XtBluaMExP3ZPiDjgQ1Ib3xhKWj
 tSGA2cxTNIC29Hk+TOcyuDvuHZFW4lH0aRym4qNC47I4NbSG7ixOmuP4A+L4nH5buH
 6t6rtnSFUf/3w==
Message-ID: <5df7617c-e8db-4067-83a3-a6601a72d334@marcan.st>
Date: Mon, 27 Nov 2023 14:57:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: Replace terrible formatting with different
 terrible formatting
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
References: <20231122235056.78672-1-marex@denx.de>
Content-Language: en-US
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20231122235056.78672-1-marex@denx.de>
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

On 2023/11/23 8:50, Marek Vasut wrote:
> Replace one type of terrible code formatting with a different
> type of terrible code formatting. No functional change.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Hector Martin <marcan@marcan.st>
> ---
>  drivers/usb/host/xhci-ring.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 

Lol.

Reviewed-by: Hector Martin <marcan@marcan.st>

> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index dabe6cf86af..be3e35102d6 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -543,9 +543,8 @@ static void reset_ep(struct usb_device *udev, int ep_index)
>  	if (!event)
>  		return;
>  
> -	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
> -		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
> -		event->event_cmd.status)) != COMP_SUCCESS);
> +	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != udev->slot_id ||
> +	       GET_COMP_CODE(le32_to_cpu(event->event_cmd.status)) != COMP_SUCCESS);
>  	xhci_acknowledge_event(ctrl);
>  }
>  
> @@ -578,8 +577,7 @@ static void abort_td(struct usb_device *udev, int ep_index)
>  		field = le32_to_cpu(event->trans_event.flags);
>  		BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
>  		BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
> -		BUG_ON(GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len
> -			!= COMP_STOP)));
> +		BUG_ON(GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len != COMP_STOP)));
>  		xhci_acknowledge_event(ctrl);
>  
>  		event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
> @@ -593,9 +591,8 @@ static void abort_td(struct usb_device *udev, int ep_index)
>  
>  	comp = GET_COMP_CODE(le32_to_cpu(event->event_cmd.status));
>  	BUG_ON(type != TRB_COMPLETION ||
> -		TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
> -		!= udev->slot_id || (comp != COMP_SUCCESS && comp
> -		!= COMP_CTX_STATE));
> +		TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != udev->slot_id ||
> +		(comp != COMP_SUCCESS && comp != COMP_CTX_STATE));
>  	xhci_acknowledge_event(ctrl);
>  
>  	addr = xhci_trb_virt_to_dma(ring->enq_seg,
> @@ -605,9 +602,8 @@ static void abort_td(struct usb_device *udev, int ep_index)
>  	if (!event)
>  		return;
>  
> -	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
> -		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
> -		event->event_cmd.status)) != COMP_SUCCESS);
> +	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != udev->slot_id ||
> +	       GET_COMP_CODE(le32_to_cpu(event->event_cmd.status)) != COMP_SUCCESS);
>  	xhci_acknowledge_event(ctrl);
>  }
>  

- Hector
