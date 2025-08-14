Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1567ECA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 13:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2A458394A;
	Thu, 14 Aug 2025 15:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vAnMuSpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D926183952; Thu, 14 Aug 2025 15:37:12 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D1068393F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 15:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c2mW73ppwz9tFm;
 Thu, 14 Aug 2025 15:37:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755178627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMDewS9h4e99F7/5HiBas2VBHtSLFsVMS1CmtdwaT78=;
 b=vAnMuSpynDp/0AFopp/8BM5ZRokrYlF/4uCH/dWSd+VIbm3txZoKQ9RtryKHGdnQaWN/eo
 kax0Sn6uY++M+zfTVe6mamFJ50zl8NvHXiHg/hryqh2a5b+mk4rkQcwATboeoYJ3hyCVBD
 RhRQBzV80+M+52Ydnk7D4RNYxMob+M0G6f+YxVnSGBHlymkWwtPXg8lDgqOqz+yC8EhU0B
 bbnZYj4B7evVkMF+aKPCPKi9o96dZZZsu0KNw3Yc9yK0XExu8Wr72QUn/v9tRj8KPyL+P+
 I8bDf2FmE/5Lvi7wTIMCokB99J2pJmNFDRhrVm8W9LatQ5tHqhqGfDmC2fyIaQ==
Message-ID: <a10f97cf-72d8-4f82-870f-cb845e5cb72e@mailbox.org>
Date: Thu, 14 Aug 2025 15:37:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] configs: stm32mp25: Enable OF_UPSTREAM_BUILD_VENDOR
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250814120938.1358059-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250814120938.1358059-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b61c2fbb653f223224a
X-MBO-RS-META: j18yg7w5aj6s5dcs43ec7nj3dek7thqg
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

On 8/14/25 2:09 PM, Patrice Chotard wrote:
> Initially, only one STM32MP25 based board was available, the
> stm32mp257f-ev1 board which was set by default in stm32mp25_defconfig.
> 
> Since commit 79f3e77133bd ("Subtree merge tag 'v6.16-dts' of dts repo [1] into dts/upstream")
> we inherited of a second MP25 based board which is the stm32mp257f-dk board.
> 
> Enable OF_UPSTREAM_BUILD_VENDOR and set OF_UPSTREAM_VENDOR to allow all
> STMicroelectronics DT compilation.
If I build stm32mp25_defconfig , I can run the result on both EV1 and DK 
now ?

It seems only the EV1 DT is built into the binary, so why compile all DTs ?

$ grep TREE configs/stm32mp25_defconfig
CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp257f-ev1"

