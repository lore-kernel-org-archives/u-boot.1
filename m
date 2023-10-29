Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5E9C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C72B87CBB;
	Sun, 29 Oct 2023 16:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592195;
	bh=zy/fjZnJg9QgiNAjp+LoUE9AEAUlTb3BUXVF0XZR46A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nMwfG2KijKHHItmLkJbMLybnxt0FBkwFsjFqPrJ3lposTf3mu7bZWLXMaQgiddIdQ
	 M6XJK9CE/JOXE3X8pkKdUB/vZ3X1Joea8/bvoLbJ49DbpcWUiC8P0EJFgcAsDkIkvg
	 0avJhbrLmlyVp9yswLGtryfA8/262B/5Zygu8KqVEKR2ujmdghTOagd7IYhvgwZ7eY
	 Zz80jIGmsuVuIi81hK2GeVCaHCfdeccC8AjrI0H/bO7fjnCKSLSW80g40v/8ZNfYxn
	 FH8GmD4fE0BX+vylDjYhHArRRcbBhm20/PYDTZHtBlj74VjzTjzLjZ42/jw2bCpGxg
	 5FF8+xhzx1nDw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EB63787C8F;
 Sun, 29 Oct 2023 16:09:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592188;
 bh=zy/fjZnJg9QgiNAjp+LoUE9AEAUlTb3BUXVF0XZR46A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=J38LTYfe32AR9XVDdkq+EzKpFZB7GK3XAMDln7gig3hwlpPLNz9JToHxdhIRkyrER
 tDedato1hL5NbmbT5euxpk8PUEjRyxSG2AkJ416061ZvSEM3ffhYFRB9DyQ6K7cAzt
 0oQ8HkXEubaWrRk7pfgvTkpQcc4Aqltl5o4goRDv8LqFBrHRP3zdxmHghsbV0pAqnB
 YBy5ahssQPxvF6ka34IKYKVRV67GIrGJUeGz5HMackz4ShTOAifOvyAN7dR5asmEju
 rAsPPZX0z7uUtyx0kEM6T7A5W5Wa3rms52SRA0CvMKfO2wyW8Go9GfFyZHhXk7Ml/k
 BKUIsA1gkh5/A==
Message-ID: <c2190c72-c319-41fc-8177-0080a9893f95@denx.de>
Date: Sun, 29 Oct 2023 15:35:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] usb: xhci: Do not panic on event timeouts
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
 <20231029-usb-fixes-1-v2-6-623533f6316e@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-1-v2-6-623533f6316e@marcan.st>
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
> Now that we always check the return value, just return NULL on timeouts.
> We can still log the error since this is a problem, but it's not reason
> to panic.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   drivers/usb/host/xhci-ring.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index a969eafdc8ee..ae0ab5744df0 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -494,8 +494,9 @@ union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected)
>   	if (expected == TRB_TRANSFER)
>   		return NULL;
>   
> -	printf("XHCI timeout on event type %d... cannot recover.\n", expected);
> -	BUG();
> +	printf("XHCI timeout on event type %d...\n", expected);
> +
> +	return NULL;

Reviewed-by: Marek Vasut <marex@denx.de>
