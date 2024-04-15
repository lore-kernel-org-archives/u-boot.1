Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B88C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 09:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9358823D;
	Mon, 15 Apr 2024 11:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="HT2axpxO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF7B8823E; Mon, 15 Apr 2024 11:04:31 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0489E874B1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713171866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJ6B2fjSW7T/TvSN8Kd+xdJMUqovXYYWSQBi4wb6kyM=;
 b=HT2axpxOhWpYQv+2QLQ/crZVFTQyDUJu+PzsOtog1x4jgVQ05xvDgBguvp1neCB/yWDIdZ
 +Ubfgv771QSOUnOIZGNo4bffxPVku+/N/cV5tJdQpBtatyu3Pn718hPYI2KUC9NcPwpihR
 gDthXsztkGn/2RreHSa6or5j1rCGiSVZCR27TaIhF5cT5jf6Kt/TFPH7Gt8AxrmZCJyvjH
 Ag6LG1hbep7Um0SmE3n0zHsYnLzttz7Zy6gbdvIRCHoNHxY7OxQwFKGVV5M8oNw9vyITeR
 jCNFHM2xEsv6X+LP/1h7RP0VQ8V3JVPl1AtEBydH3WiqqrbILMCZ1FbPqpKBTQ==
Date: Mon, 15 Apr 2024 11:04:26 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Elon Zhang
 <zhangzj@rock-chips.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 15/23] rockchip: rk3588-toybrick: Add missing Kconfig
 options
In-Reply-To: <ab33123f-05a5-4edd-b720-a5b8792d5443@theobroma-systems.com>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-16-jonas@kwiboo.se>
 <ab33123f-05a5-4edd-b720-a5b8792d5443@theobroma-systems.com>
Message-ID: <6a057b12fe264f752f641f3eccd7ff23@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-04-15 10:58, Quentin Schulz wrote:
> On 4/13/24 20:13, Jonas Karlman wrote:
>> Add .dtb-file entry to Makefile and enable Kconfig options required to
>> configure pinctrl in SPL. Also add missing 
>> PHY_ROCKCHIP_NANENG_COMBOPHY.
> 
> Separate commits please.

Perhaps the Makefile changes from a couple of different patches
could be put together into another, separate patch.  Those are all
related changes, and it would result in one less patch in the v3
of this series.

> Sum of changes is fine though (but a bit more verbose commit log would
> be welcome, why SPL_DM_SEQ_ALIAS for example).
