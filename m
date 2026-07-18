Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065EEC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 02:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A8780517;
	Mon, 20 Jul 2026 04:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dxL4yaRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9B183FF5; Mon, 20 Jul 2026 04:58:18 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D5D80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 04:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h3QF20v32zMlFs;
 Mon, 20 Jul 2026 04:58:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784516294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c67RPxR4cADdGqeLzKNwb8BmyJm06l4OUdtd5OUeKSQ=;
 b=dxL4yaRuskCXC6Hj/YhCoyry2Xjebb2o0GDmoDT3WJJ8yWO+SdSq0c3Dv0DRPBHIfg1m4Q
 2d2fq4pAP/DvrfKZ2H2IthbZZFK3UrOmyJRu3d/9CIrum6xYiPxHfEXhgH5XC+YC+T4Umz
 8qApP7Ilofl42fqPMvG19dE8fERs42aCm47YWH+rwbm3TF8/Cwtp7FF2Bwdu6X8B7woyVH
 Z9qFyiVY4IFeheTl/Go9mfgdiL/FWnD8SQMmcOKnVnAqyNALwKpkLPuEAwdbVdVfPAZAVp
 lN+ae9PT/7CIRAm0rMP+PFo46NaI7yB2qHF5PUoxvkkCjQ4shVHbYsP2OQ7Llw==
Message-ID: <6f37728a-901b-4f39-9923-3852cbe95061@mailbox.org>
Date: Sat, 18 Jul 2026 22:17:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: mtu3: wait for TX FIFO to drain before disconnect
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260718-ccaione-upstream-mtu3-tx-fifo-drain-v2-1-837345048224@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260718-ccaione-upstream-mtu3-tx-fifo-drain-v2-1-837345048224@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d7cb9bf9063e5e26534
X-MBO-RS-META: fiiiwst9h8b7ar9durohezf4a8rtny9i
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

On 7/18/26 12:37 PM, Carlo Caione wrote:

[...]

> +static int mtu3_wait_for_tx_fifo_empty(struct mtu3 *mtu)
> +{
> +	struct mtu3_ep *mep;
> +	u32 value;
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 1; i < mtu->num_eps; i++) {
> +		mep = mtu->in_eps + i;
> +		if (!(mep->flags & MTU3_EP_ENABLED) ||
> +		    !list_empty(&mep->req_list))
> +			continue;
> +
> +		if (readl_poll_timeout(mtu->mac_base + MU3D_EP_TXCR0(i),
> +				       value, value & TX_FIFOEMPTY,
> +				       MTU3_TX_FIFO_DRAIN_TIMEOUT_US)) {
> +			dev_warn(mtu->dev, "%s TX FIFO did not drain\n",
> +				 mep->name);
> +			mtu3_ep_reset(mep);
> +			ret = -ETIMEDOUT;

You could get the ETIMEDOUT return value from readl_poll_timeout().

> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   /* set/clear the stall and toggle bits for non-ep0 */
>   void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
>   {
> @@ -261,8 +290,14 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
>   		set ? "SEND STALL" : "CLEAR STALL, with EP RESET");
>   }
>   
> -void mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
> +int mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
>   {
> +	int ret = 0;
> +
> +	/* QMU completion may precede transmission from the TX FIFO. */
> +	if (!is_on)
> +		ret = mtu3_wait_for_tx_fifo_empty(mtu);

Shouldn't this bail early on ret != 0 ?


[...]
