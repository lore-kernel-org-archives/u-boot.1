Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F10C4451B
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 02:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4ED080517;
	Sat, 18 Jul 2026 04:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eQR3VSL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3B083E76; Sat, 18 Jul 2026 04:26:26 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A8D80433
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 04:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h29dC1T9WzMlKS;
 Sat, 18 Jul 2026 04:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784341583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZLd2zRyNsh+zbkGSJ8QUypD3vVfqmoiK36rVr3B1hs=;
 b=eQR3VSL1D5eSEhAK6f//vNSVqlqW7t8d1FUiJak+hBOb9m8VHl/vM5uUaw+hdwyxmgtOfG
 OOpPBtP1qOKBedQNjgygShW2q3WUQsJXiGj8eDxjhyAFXuovZSlQqe/nIjkN2XEmbayPaH
 oYLQJ7cgATzg+0J5giGRUwjCw8YVdFUNqM+5623EOlg0sshoAXK9RCY7eQSzygi00H4sDO
 18g7Ng26vC7gA/BwJaDYIXtmOzU3VDNovDpLPhHNlwFsGo2ylSV7+zUeLvjPT6Y9/zwb0J
 ESdVJ8Z9iYxvkUKD56CTTBcun7pcyqgxNLCwElJM2mWJhJ6xVRnibCQ6BSgVYA==
Message-ID: <804b4b7b-3c81-418b-81da-bacee46b8d46@mailbox.org>
Date: Fri, 17 Jul 2026 17:21:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: mtu3: wait for TX FIFO to drain before disconnect
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260717-ccaione-upstream-mtu3-tx-fifo-drain-v1-1-f867bdfc5d00@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260717-ccaione-upstream-mtu3-tx-fifo-drain-v1-1-f867bdfc5d00@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 444df4ed1947c37065d
X-MBO-RS-META: 7msk68ithp4h3jryutjihmd4hqx8dqq5
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

On 7/17/26 3:05 PM, Carlo Caione wrote:

[...]

> @@ -66,6 +69,28 @@ static inline void mtu3_ss_func_set(struct mtu3 *mtu, bool enable)
>   	dev_dbg(mtu->dev, "USB3_EN = %d\n", !!enable);
>   }
>   
> +static void mtu3_wait_for_tx_fifo_empty(struct mtu3 *mtu)
> +{
> +	struct mtu3_ep *mep;
> +	u32 value;
> +	int ret;
> +	int i;
> +
> +	for (i = 1; i < mtu->num_eps; i++) {
> +		mep = mtu->in_eps + i;
> +		if (!(mep->flags & MTU3_EP_ENABLED) ||
> +		    !list_empty(&mep->req_list))
> +			continue;
> +
> +		ret = readl_poll_timeout(mtu->mac_base + MU3D_EP_TXCR0(i),
> +					 value, value & TX_FIFOEMPTY,
> +					 MTU3_TX_FIFO_DRAIN_TIMEOUT_US);
> +		if (ret)
> +			dev_warn(mtu->dev, "%s TX FIFO did not drain\n",
> +				 mep->name);
Shouldn't there be some interface reset on failure ?

Shouldn't the failure be propagated ?
