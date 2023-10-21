Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5B3C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 08:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F6F875CA;
	Sat, 21 Oct 2023 10:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="bLgbj/qy";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q4rXoeYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D9F875D4; Sat, 21 Oct 2023 10:21:32 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6876E875A5
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 10:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 849615C017D;
 Sat, 21 Oct 2023 04:21:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Sat, 21 Oct 2023 04:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697876484; x=1697962884; bh=u+Ee/AZZ6GcPfobBRSVpZsVMoL9a05lj2Dw
 Kdqw6ma8=; b=bLgbj/qyg4WyyTqQ2y+u56dZibUjkeeETyGEtWl/6zayUmCi5hG
 aJC+dtw4208u0oPd4vLtEj0oWHoZtD7e/5/YOq/nhvIOHQPHgWoQOflxDnLnXdWu
 QM3iXh3FqhbMO9X7puJxfklYSlWMv5kfpoPf9l54OBlIw++5C0140nltNx4gOqXq
 1G+BdN6KWODoW9jJquQoXTbei2kXsRWx1fGKHEVnegEm1+YmUilptLeopKhpLAPg
 1rz6jC/Rk+0zHh1AVSyodGqvQ8kpKnAAw9GCljsddDmewfweFOpsRqHp3OsrFCC+
 TyMI7M4Qm8i03MKJknjZSagN4M6oWn0EtxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697876484; x=1697962884; bh=u+Ee/AZZ6GcPfobBRSVpZsVMoL9a05lj2Dw
 Kdqw6ma8=; b=Q4rXoeYqB+DMuS7CApw/rJmX6yX79wxZQ/GAqICsCnIckov6Kg+
 BpZlEhMdue4Rc40QhVxXJ54cWrVkZry85voGyHLXly6zKaRoCpXui83O7SkuQFIj
 LD4FJLXVVNRbyYEz1dk+MNNed5ee/4NdyLciwImXMRotD/ui9tk2Senrr2aWIxPc
 WRja8XrBY71pu7E7syj4EYOQfWUWs0Tw7xmN3iAoQFpLl8BrGKWCyXRX0WknTMQb
 hE4CBqcSFi3Vl7J1tqlLJysudh/dUuQP3kE6BHA5V0zS/Xb6f5jviEf9kGeQHi8H
 e8L4IayI+o/JyiagmTQ8N269JiB5nRsAiGQ==
X-ME-Sender: <xms:A4ozZd8yqXAZGH5F0Vuoax4ROfCXD6ihguM2AiUG25RTQqHAf8NA7Q>
 <xme:A4ozZRsfSYuyUl5im38bsYJ1NLybgXaISHQ_NTbg6gBB6Xokw4JE1RrhBiI1FEMny
 BpLtXwLbvpcrocbIQ>
X-ME-Received: <xmr:A4ozZbDYWA6gTv39AKr-8OGeHLTXTgo5RLPK7KxscLpvlbKcj17-Jr59Mv0dRBSimsTsgUX9FPmQr5xC9diQfIgYPV1uUJvoRyW_o-iSNSsQgkgAcmDEDP8neA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtucetufdoteggodetrfdotffvucfrrh
 hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgvlhcu
 jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
 htthgvrhhnpeekjeelleefiedthfdtgfekgeehudefudeugeffvdfhudekleelfedtteej
 hedutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:A4ozZRfPpZUaN0SwVa4zrNDYHQUTUrSXYvzmfoKFrNGgkA36NFWwag>
 <xmx:A4ozZSObH8eUbHpkYtww7W7mtRORxsxV5YJdxYPP6lByjR8bTd2mDA>
 <xmx:A4ozZTkcAQ1z4VhzL1K6kUsABwCUbd7x0y-Nf6y5rGTxnrKe_ds4dA>
 <xmx:BIozZThNr73fQl_BIS3jlSudVTiQvWTWspAir5jIMQaS_xHzFMak0Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 04:21:22 -0400 (EDT)
Message-ID: <1f56f58c-33d7-644f-ee21-2d49e01b99d7@sholland.org>
Date: Sat, 21 Oct 2023 03:21:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 04/22] pinctrl: sunxi: move pinctrl code
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-5-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230928215455.28094-5-andre.przywara@arm.com>
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

Hi Andre,

On 9/28/23 16:54, Andre Przywara wrote:
> Move the existing sunxi-specific low level pinctrl routines from
> arch/arm/mach-sunxi into the existing GPIO code under drivers/gpio, so
> that the common code can be shared outside of arch/arm.
> 
> This also takes the opportunity to move some definitions from our
> header file into the driver C file, as they are private to the driver
> and are not needed elsewhere.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/include/asm/arch-sunxi/gpio.h |  20 +----
>  arch/arm/mach-sunxi/Makefile           |   1 -
>  arch/arm/mach-sunxi/pinmux.c           |  78 -------------------
>  drivers/gpio/sunxi_gpio.c              | 102 ++++++++++++++++++++++++-
>  4 files changed, 105 insertions(+), 96 deletions(-)
>  delete mode 100644 arch/arm/mach-sunxi/pinmux.c

Many thanks! This works perfectly for D1.

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>

