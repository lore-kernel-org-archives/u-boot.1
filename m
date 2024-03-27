Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CC6C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 10:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDB7D87FDA;
	Wed, 27 Mar 2024 11:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="A+LqPyWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4795F8800C; Wed, 27 Mar 2024 11:00:32 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E1A887F4F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 11:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1711533627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kmy5ciKHV+LeDb+sjuIxwYADMg4SAFU/x2plZbaOOes=;
 b=A+LqPyWsX9FhqLw3KD2ZgPBNfMj3DrvfjH8CyXsR4aZd7WgSs+Kv/6e2V8EVCQ3WJ4Y2hC
 VzHDm5Dtvoo5O+4La6Iod2ittBegMsJpW+9uEziG23Nh/n8nOcxO2MD2it+X4R3i0AN95J
 wO7KZ/sueh7NG1fxiTpRePB4ADcrqxhVoynfGl87Jc0vwnW4g0s+T2FYrquEjcVXWeNXyj
 7uadCUUVUpqUpSlJdzQvIdQZgsgYEx8Ma0LyfZOaEa8QnBl3DCvuPjvaDs9nudDj4m7WN/
 83lKlMYDFoxHwAwlN8xyCXKe4Nhrgoh8omT2hV5HoWOyMbCeNtYur2cfeMULiQ==
Date: Wed, 27 Mar 2024 11:00:26 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: rockchip_sdhci: Revert 4 blocks PIO mode read limit
 for RK35xx
In-Reply-To: <a162464f-8cf6-4229-9062-f1369769af20@theobroma-systems.com>
References: <20240326233502.2625015-1-jonas@kwiboo.se>
 <a162464f-8cf6-4229-9062-f1369769af20@theobroma-systems.com>
Message-ID: <5ae859e94602e2a1b72ee069cb80697d@manjaro.org>
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

On 2024-03-27 09:56, Quentin Schulz wrote:
> On 3/27/24 00:35, Jonas Karlman wrote:
>> The commit 2cc6cde647e2 ("mmc: rockchip_sdhci: Limit number of blocks
>> read in a single command") introduced a limit of number of blocks to
>> read to fix a Data End Bit Error on RK3568 and RK3588. This had a side
>> affect of significant slowing down reading FIT from eMMC.
>> 
>> After the commit 6de9d7b2f13c ("rockchip: rk35xx: Enable eMMC HS200 
>> mode
>> by default") the limit of number of blocks to read workaround is no
>> longer necessary and a Data End Bit Error is no longer happening using
>> PIO mode.
>> 
>> Revert this limitation to allow reading more than 4 blocks with a 
>> single
>> CMD18 command in PIO mode and speed up reading FIT from eMMC.
> 
> Should we instead keep this code but surround it with
> #if !IS_ENABLED(MMC_HS200_SUPPORT)
> ?
> 
> After all, HS200 is only implied for RK35xx boards, so one could 
> disable it.
> 
> Also wondering whether we should do this dynamically based on the MMC
> mode that could be negotiated with the chip? E.g. I think it's not
> guaranteed that with hs200 support built and enabled in DT that it'll
> be negotiated as HS200?

Totally agreed with Quentin's remarks.
