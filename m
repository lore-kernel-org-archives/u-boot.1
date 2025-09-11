Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B74FCAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 14:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B45833AD;
	Thu, 11 Sep 2025 16:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="F9NNwUtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E015833C6; Thu, 11 Sep 2025 16:24:10 +0200 (CEST)
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C088334F
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 16:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=alexeymin@minlexx.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6KZWtnxJUUq938q5fc5FywTIwyIjpOWi3Izf+5FdNd8=; b=F9NNwUtAaz86GOFVG7hHG1qFi7
 AAkpIxX7ZLsDHJoFySvgwxh20EcGJW4yqeDo+TY594wk1dVutICAzsoDAPHkmhD0mROOAlNXWbQrU
 gBY9aaQO/lM/Fc4OQWGR6zFZB/jTwlcXntWWjwqXpm1damwbnPuvELUSdrDk9HCePhZU=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
 (envelope-from <alexeymin@minlexx.ru>) id 1uwiDV-000000000r7-47ao;
 Thu, 11 Sep 2025 17:24:05 +0300
Message-ID: <04a4b029-c661-4921-9981-96ce82fb2498@minlexx.ru>
Date: Thu, 11 Sep 2025 17:24:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Fix UART autoboot issues on DragonBoard 410c
To: u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Sam Day <me@samcday.com>, u-boot@lists.denx.de
References: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
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

On 08.09.2025 14:31, Stephan Gerhold via groups.io wrote:
> There have been issues with autoboot on DB410c for years, where autoboot
> gets interrupted by spurious input on the UART console. I've tried fixing
> this back in 2021, but it turned out this fix was not enough. Looking into
> it further, there are two separate issues to fix:
> 
>   - Spurious input with UART disconnected: The RX pin is floating in this
>     case, resulting in garbage or a UART break event (0x00 byte). This is
>     interpreted as input in the autoboot prompt. Fix this by adding
>     bias-pull-up for the RX pin. I've made this change upstream in Linux
>     6.16 for all MSM8916/MSM8939 devices and it has already landed in U-Boot
>     through the recent subtree update of dts/upstream.
> 
>   - Spurious input when querying console size with UART connected: It's
>     unclear why this happens, but it seems to be some issue in the overly
>     complex implementation of 4-character packing mode in the serial_msm
>     driver. Fix this by switching the driver to use the more simple
>     single-character mode, which doesn't have this issue.
> 
> With these patches, autoboot is finally working reliably on DragonBoard
> 410c (and hopefully will remain so for the future :-)).
> 
FWIW I've tested this series using serial UART DM interface on SDM660 
device. It does not fix *all* the issues needed for it to function 
there, but I can confirm it does not break anything and makes things 
much better than before, now with proper resetting and single-character 
mode it's possible to not rely on configuration from previous boot 
loader, for example.

Tested-by: Alexey Minnekhanov <alexeymin@minlexx.ru>

--
Regards,
Alexey Minnekhanov
