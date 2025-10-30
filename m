Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F7ECCF9EB
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 03:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB96836D3;
	Thu, 30 Oct 2025 04:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UTE56VJI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iTa39g0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE89836D3; Thu, 30 Oct 2025 04:08:05 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FF15835FE
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 04:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cxpvl0ztXz9sp2;
 Thu, 30 Oct 2025 04:08:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761793683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tv6H6TVjYl4qMT7EUZkeCm8DKQwErMQmoFNmQ39b78=;
 b=UTE56VJIyTX0JpAdhQsYO6I90XpGEeej1n8yUqcfbjNf684NDN14GqQ19dtwJjlJnhvI+5
 i0w9zqR1Dng8IP87TalXYSfRKPs6Lu4oQMBMtgqurAqjY9dtNL7O2W9ETRqZ+J9Vw4n9qB
 rvfERgtoJGC/p029szWHa73cmEGFdyxY6//X+NiNvmGii4WXuX2tbHs4J7Ey6K6syZI7wq
 S5FZsUWuHzJGN9RnTnxGnQlcne/fVklT49eA0zfVC9q38nesqjRie7HfeiGtsDZWLyTpC9
 eW9haSslwGrWaNaoWtoWAsih9Aia1abAGq0cmh3vJgLTWmv85ZgXfnCQQQwP3A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=iTa39g0H;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <ba112e5f-ce74-4fd8-8087-b142ca6d823d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761793681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tv6H6TVjYl4qMT7EUZkeCm8DKQwErMQmoFNmQ39b78=;
 b=iTa39g0HAY5ZVjN2vWIIDece6xgcSNnR0N68Ie/3aoHPYvV38ZaEnYH9KmJIry8J9Db5wu
 TzfbLhDbt97/CCI1EhuyQ6iYApTAKfdrQMuirQ9irxuTPecFz56E1ogft4KD918jB5GEab
 MR83/AiJw5tA1i3ejREJV58sZX/FVV+zekQUUlGGjDbPEH67WADs2J/O2/FGfMDf7aeOEq
 5L7J35RQbmTSHiFnYuPd91E6Sw+ZYgutClawhRX+YUKjz9R6nBEuR0SdwJfZJgKj10UTQ+
 I3/9ue62YU5PVASKCsmD8JH00yzCDMcrUmpgQ5w4+Hzr59nwo/sY3QABTCpWPg==
Date: Thu, 30 Oct 2025 03:24:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/4] net: phy: aquantia: use generic firmware loader
To: Beiyan Yun <root@infi.wang>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
References: <20251014121318.453701-1-root@infi.wang>
 <20251014121318.453701-5-root@infi.wang>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251014121318.453701-5-root@infi.wang>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3a5be4e547202d3f6f4
X-MBO-RS-META: pt89b65ha5girguyijaxdupn3a7y4ri4
X-Rspamd-Queue-Id: 4cxpvl0ztXz9sp2
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

On 10/14/25 2:12 PM, Beiyan Yun wrote:
> Aquantia PHYs are being used w/o SPI flash in some routers recently.
> Current firmware loader only attempts to load from FS on top of MMC,
> limiting the use on many devices.
> 
> Removed the old firmware loader, migrate to generic firmware loader to
> allow a wider range and runtime override of firmware source. (e.g., USB).
> 
> Tested on Buffalo WXR18000BE10P with UBIFS.
> 
> Tested-by: Beiyan Yun <root@infi.wang>

Please don't add own Tested-by tags.

> Signed-off-by: Beiyan Yun <root@infi.wang>
> 
> 

Newlines not needed before ---

> ---
> 
> Changes in v3:
> - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
> 
> Changes in v2:
> - Add support for script based loader
> 
>   drivers/net/phy/Kconfig    |  24 ++++---
>   drivers/net/phy/aquantia.c | 133 ++++++++++++++++++++-----------------
>   2 files changed, 88 insertions(+), 69 deletions(-)

Would it be possible to split this patch up a bit, so it is easier to 
review ? Clean ups and code moves first, functional changes second ?

Thank you
