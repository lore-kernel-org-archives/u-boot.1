Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FAAF8E497
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6B1B84297;
	Fri, 17 Apr 2026 04:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Im7pMSEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F57842B7; Fri, 17 Apr 2026 04:57:51 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C62868428C
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fxfgw0kbcz9tYR;
 Fri, 17 Apr 2026 04:57:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776394668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ekJR8XsqzIREXfNM0NLEF8nioi1uBOufZHleQmjr0c=;
 b=Im7pMSEqF1cRgmkMieoGrBgDaVgRoc3gdguwAMYQgMEaSDoQLc8K2hPhvrgRDO2l16lOYt
 XA7Taumfi08JAdFCrcrB/8aqvuimqXubJfYcUdZJFJDf3nBxoLwaENlqqswnKVw0hfLqSX
 dPU2Sx/EgWsEUh9lAtQm76V8DJYIqWqmXr+pKeFuB5T2UR8Es25iluyIKCeBOTmLdUh1LJ
 NQ9QHRH7AKM5xcwDw5Ud7wwV5842LQnyRvviUdtC8CMoHbpkPk+onMwdRH3memYEWAvdig
 NxQVJvC6zW+6WbbI2yU4UTyODLpsdFPSKqaYhYe5bIYkeoGsxB6pei4YIGCDVA==
Message-ID: <b5e71edf-70fb-439a-b5f0-228cd169d1c7@mailbox.org>
Date: Thu, 16 Apr 2026 20:13:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/2] Changes since v2: Added missing Signed-off-by tags.
To: Michele Bisogno <micbis.openwrt@gmail.com>, u-boot@lists.denx.de,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: paul@pbarker.dev, jh80.chung@samsung.com, peng.fan@nxp.com,
 lukma@denx.de, mkorpershoek@kernel.org, trini@konsulko.com
References: <20260416153827.14256-1-micbis.openwrt@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260416153827.14256-1-micbis.openwrt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 797c234946b96d51bcc
X-MBO-RS-META: uuhmsu8qk7hb8xmw6kpbqkgcrbkmb5wz
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

On 4/16/26 5:38 PM, Michele Bisogno wrote:
> Changes since v2: Added missing Signed-off-by tags.

The subject should describe what this series does, it shouldn't be a 
changelog.

> Technical Justification:
> While the Linux driver for RZ/G2L relies on DMA, this U-Boot implementation
> focuses on the PIO path. The refactoring in fifo.c to use byte-level access
> (ioread8/iowrite8) is necessary to handle trailing bytes and alignment
> requirements specific to the RZ/G2L bus.

Can you please clarify exactly what kind of problem are you hitting with 
the current code and how is it triggered ? Details please.

> Additionally, explicit reset deassertion is added to the probe sequence,
> and a re-entrancy fix (usb_del_gadget_udc) is included to prevent crashes
> during repeated executions of gadget commands like 'ums'.
> 
> Michele Bisogno (2):
>    regulator: rzg2l: implement connectivity notification
>    usb: gadget: renesas: add support for RZ/G2L SoC
> 
>   .../power/regulator/rzg2l-usbphy-regulator.c  | 10 ++++++--
>   drivers/usb/gadget/rcar/common.c              | 15 ++++++++++++
>   drivers/usb/gadget/rcar/fifo.c                | 23 +++++++++++--------
>   3 files changed, 36 insertions(+), 12 deletions(-)
[...]
