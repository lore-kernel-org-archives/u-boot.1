Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019BED5E38A
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 01:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2500E89327;
	Sun, 10 Nov 2024 02:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731202471;
	bh=+E7X0Aq4km1MqCnhyStV6AHo4NZ9ZYAea459CMmFY/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZecEA0p9ePmTVWKtbadNrcYULQgMZnhDAlYqUL8OTWRtJhbHMOjbzAM2ELAaeV4MY
	 YrO/XyaWMsNI0ARphTRqfeROdXuR0ICQRmWBIqY18mNJU68+9KooADLDA0pUTuR/8E
	 t74qiCkiJH8xX6NEdsmu/fgNthTkjLcqzll4q2UMlY9MOI/EMUgjJl1GsHaLH2/Hbm
	 fJUYJ00wvniET9MW2Fy0P2yGx90hht3BXmoiLC6kvraJcugZpU9WfOs4sZo7vn+0rQ
	 Seu9CpQd5P9qBjU6y+BQWiCn4QxMGsWP7uwwi/B+8B1II6r9N8CVuM1+C+zas3hGY0
	 Gt7AM2pbk2N0Q==
Received: from [127.0.0.1] (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 306DF88DE6;
 Sun, 10 Nov 2024 02:34:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731202469;
 bh=+E7X0Aq4km1MqCnhyStV6AHo4NZ9ZYAea459CMmFY/o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uMhyk69jmBDjYjTG8CDNkkW65kl3/tPpDar8tN8ufWepDcnZ9lQKubABb6yhQXXrP
 SXF8ksoDqxn4Khezu1QAK2WtBrts/EPMX6WaE6JKSY2yRXFOdpnPvDjJ+oCUmLsAiK
 VIj7DWOOM2VKJG9Ubmy/Ryo8BVqZAgfgj0KnLObiHM7zE8T9wJEiVXXfuCOP91ZIv0
 zxKFBaPDFm25Wc5cYKsi5FAA5lvTFc8p1w+wge7VcraE+tqlT/XwYp6DcDvALHWlXg
 prd76wfs9FZIRaq6Nx5QKBOZ3/p0sd483bXWdfzPrUN+YFq0nfOoVsxpp4y9I7kSox
 wmHgJdGH0zKdQ==
Message-ID: <690f6e55-ac68-4ef6-aeda-1f36a36e9a32@denx.de>
Date: Sun, 10 Nov 2024 02:29:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: imx8mn: Fix FSPI booting
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com, lukma@denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20241109200610.1615430-1-aford173@gmail.com>
 <20241109200610.1615430-2-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241109200610.1615430-2-aford173@gmail.com>
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

On 11/9/24 9:06 PM, Adam Ford wrote:
> When FSPI_CONF_HEADER is set, the binary needs to be built such
> that there is a configuration file located at 0x400 and the start
> of the file that would normally be flash.bin starts at 0x1000.
> This used to be done properly until the device tree was converted to
> nxp_imx8mimage.
> 
> Building these with the offsets built into the binman device tree
> changes impacts how the actual image is built and the locations
> of the various blobs aren't fetched properly and booting fails.
> 
> Fix this by building a standard image as if it were to boot from
> eMMC or SD, then use that image as the input for a second image

This seems like a workaround for some broken offset calculation in binman ?
