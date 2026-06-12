Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6797CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1317784717;
	Fri, 12 Jun 2026 22:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MEA0qQDc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KTxxcYI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 311408484F; Fri, 12 Jun 2026 22:01:22 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2338E8063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gcVl35KSDz9v72;
 Fri, 12 Jun 2026 22:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781294479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQ7Ymrcp+JDWBt4JirXiTcBd+jhTWuamJuCzeHOXdM4=;
 b=MEA0qQDcVVHHDSw1qBrUb3jKn9lK7pnnBlZO21XEd1qVN4w1rkiYGSdra+3qvUNPWWM/ww
 gVUR7RHuM6tRUD39wVbiwvUNdA+zsx89JNZJHSo59Na77zgjaoS1rdOLHZPCUGj5F+B/+5
 Boch4sbVr9TbmnGUOMToLBYRBo0XVRj8J44rh+Ay45s3IbwEoWuPqKXrBhhGR886U7SeyQ
 V5mlPTUllDRfe+3M97EfW2vUj0rnkts+1oHKRtGtXKmFWyZNW4BQhAgnoA03asod6+GpHr
 WwPqqqmuDHrauWh+Ovzj5StKyEdT1QtqyLQ2MivOMOqTZeCyLMCL1KR1QWJXMA==
Message-ID: <4ed22a3e-93b5-4dc2-820b-dba6f5ab6050@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781294478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQ7Ymrcp+JDWBt4JirXiTcBd+jhTWuamJuCzeHOXdM4=;
 b=KTxxcYI6ZfDORd4mcUcPJ20UGZQ7gcjQSwa8GghgG+UODMPQYqka0FwL2tTyAwzwn9Lhoj
 FkyRLotcJrhxUPv/3d4c3nTjMBXEpYBFgkVK3YOrqRcpOvZp7q3K+uKFzK/t1W/H1UkU9P
 YKvc9CPrKBeavG/DP23OrgYDBwTMpza5rE020qVJ9CLXvW9hdHPUtRtCLg0C6dDKUXZn8w
 dseMK1hvh8AxTQU0DieGt02y8kQU5EuKdlLZCr/5koxnKG28xW72B6O0+ym/s0E7gENZBk
 1AH7kBpMheS0K+zyAJCY5jhQzSUbQnk+zWUDiWWOWHz5RZZCnonwA/aEPwar3g==
Date: Fri, 12 Jun 2026 22:01:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] lmb: default LMB_LIMIT_DMA_BELOW_RAM_TOP for 64-bit
 Mediatek SoCs
To: Sam Edwards <cfsworks@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, Rudy Andram
 <rmandrad@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.denx.de
References: <20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com>
 <20260611-mtk-fix-ram-size-v1-1-42ed330660ca@baylibre.com>
 <CAH5Ym4i=fkGC_WvECVqzK=K-GL_fV8hyBH3qd30f02n9gnfq5A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAH5Ym4i=fkGC_WvECVqzK=K-GL_fV8hyBH3qd30f02n9gnfq5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kbjxkqnoqo37inp876gueoo8gwzw9jqn
X-MBO-RS-ID: a6cc834291c309d5c85
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

On 6/12/26 7:52 PM, Sam Edwards wrote:
> On Fri, Jun 12, 2026 at 10:32 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Add 64-bit Mediatek ARM SoCs to the default y setting of
>> LMB_LIMIT_DMA_BELOW_RAM_TOP. These platforms have a 4GiB DMA limit, e.g.
>> for the SD/MMC controller.
> 
> Hi David,
> 
> Is the 4GiB DMA limit due to the interconnect itself or are there
> merely a few blocks that can't speak 64-bit?

It is a mix of both, depending on the SoC. Old 32bit IPs are reused in 
64bit SoCs, sometimes old 32bit interconnect is reused in 64bit SoCs.

> If the latter, I think
> it'd be clearer to associate the setting with the culprit driver(s)
> rather than the whole platform, so that it can be removed if/when
> those drivers begin to use bounce buffers.
> 
> Marek: I fear that a lot of things are going to depend on this config
> option being 'true' in the very near future, and with a lot of
> still-unidentified drivers with bugs unveiled by this LMB change (e.g.
> I spent much of last weekend chasing down a failure on RK3588 because
> U-Boot's SDHCI-SDMA impl. assumes 32-bit addresses) would it be better
> to make this setting default true for 2026.07 to buy us more time to
> find those cases?

We could do either that, or add more SoCs to this list.

What do others think ?

> I'm not very familiar with the rationale behind the
> original change ("lmb: Reinstate access to memory above ram_top") but
> it sounds like only some users need that access currently?

With LMB_LIMIT_DMA_BELOW_RAM_TOP disabled, TFTP above 4 GiB is not 
allowed, LMB will block that. If you have a lot of DRAM above 4 GiB and 
you want to TFTP large payloads there, it won't work, which is 
unfortunate (perfectly valid DRAM is wasted).

-- 
Best regards,
Marek Vasut
