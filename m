Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C29C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73EA28760D;
	Thu,  1 Feb 2024 04:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="sSvpPPDX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="d2Hojf1d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 199CF87C32; Thu,  1 Feb 2024 04:00:32 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1493C8760D
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id BA1173200B05;
 Wed, 31 Jan 2024 22:00:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Wed, 31 Jan 2024 22:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1706756422; x=1706842822; bh=4/7N/L+GG4JTQvHrC9SVzOcTRbc1Bud4
 5Xa3X7Ol/Wk=; b=sSvpPPDXUtlQY3guhwyf7Qt4qhVw5WFcpahkTdkzUPQ5ewh0
 qvUCwNlbZ0RPk5wh7dystQdKOpcfyGEBHDbHUFpAlHu3N9w5s40EszalDbXTAewL
 RYqibxXSM7cmZQxgNs1eB6LYNHGQCsGtBpKZesP0TjWWbKMdQcVwkOJtMsumwLFS
 dJM2TB3DZ/WzWK9vcZ9HKFzbZV+KSduxKkLT5J6QQX4XlJg71EUNhL28Mux3nfco
 fwOvlBA++BIFWhGbcIi2NRyDStPivVVys0xphN6mpUgSCBII9kMmsFzeV6D4n7DN
 dz1F02PhdNGsVM0FDNApIUjqxAWiHOX7hfT59A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706756422; x=
 1706842822; bh=4/7N/L+GG4JTQvHrC9SVzOcTRbc1Bud45Xa3X7Ol/Wk=; b=d
 2Hojf1d7cicbsJIBHP156QwcRc5kU8BYjXRdRW/p+RI9rxXPsXKFpHnV3lZqyrS+
 TG3zAKJr6BuQEssrrR89qUEiA6aa8CHXWaBtXkIyNu2FLtoh/xAQObzpJFo8yJOx
 9gjwe1jZxRgCOENKFPS6KWESpQ1dBSFwkl3vuO1Cq60bGsaB139Eji3a5hPZVp5V
 kfNbMdtcvHzR3f8Sxrkgg53bsdDg0OEID8kV0VUzuU6QEfrBe3jnCk96uMTe0GRX
 kGFRfpC0IkTueKaxB0dWtd5W+Rv0dd93ggNO3mqjOAaQX3I2l+vdUk2b6d+L9fA5
 Pq3Q/LTeJhtvz6pTb/4Cg==
X-ME-Sender: <xms:RQm7ZT1LZRO11NWQmsM1_9bQeEm-9jyl2pVl7lMPl7tiV53CjY1Qbw>
 <xme:RQm7ZSHz682-FvS4L3cDujtY-Mp2jNVkyraKQKZm1VUDXpQpoLkBVD28Ob7wWh1Xw
 DmifMoOmQ>
X-ME-Received: <xmr:RQm7ZT6DsmG57OgxH_SPQaQ83SU-34u6uvrq28ha_xtESIue6E8TBxh5Nse5_uzovYGWDlg2w8lvWw6vBSYSJT3DUVfU3e35y5gqpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgheefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
 ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
 hrnhepueegfefgveeuiedtheffgfefveejkeetiefhhfdvjeevlefhueekudeuleeghfek
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
 esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:RQm7ZY0B9wBMdzThfFaVIzNeA-Fy0Lp0Y-4nDgZm79EJgxwdvRVTNw>
 <xmx:RQm7ZWEb0ET9gJ4ZziIyxq__Qkf_3BBEw1xUX6Cg10RkIwsu4YIo6g>
 <xmx:RQm7ZZ9qhyHzUv30PFOOlBBEN4JiCYEfKv3fOywwX4DC43NOKOz9gw>
 <xmx:Rgm7ZTNN-QiNC535FwZTbaRw9RI5Ky2jnjmRSM8NCA4nMkdjfSPY1g>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 22:00:19 -0500 (EST)
Message-ID: <15e12fe6-338c-4cc5-9219-876a219c550d@feathertop.org>
Date: Thu, 1 Feb 2024 14:00:16 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add Hardkernel ODROID-M1S
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Dongjin Kim <tobetter@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20240125070252.2057679-1-tobetter@gmail.com>
 <254dcaee-6aca-48da-a09c-35b8f41f0480@kwiboo.se>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <254dcaee-6aca-48da-a09c-35b8f41f0480@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

On 1/25/24 22:50, Jonas Karlman wrote:
>> +	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
>> +};
> Because this device tree is not yet in linux, hopefully correct props
> can be applied to device tree and u-boot do not need any overrides.
>
I suppose this pinctrl override was copied from Odroid-M1 where the 
emmc_rst pin is shared with SPI flash. That is not the case on 
Odroid-M1S which doesnt have SPI flash. So should be ok to drop this 
override.

Regards
    Tim
