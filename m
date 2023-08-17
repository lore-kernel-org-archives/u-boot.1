Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB6CC27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 07:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC5186A4B;
	Thu, 17 Aug 2023 09:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MSoACHSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0833286A4F; Thu, 17 Aug 2023 09:55:38 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 769F786A44
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 09:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C37A660722B;
 Thu, 17 Aug 2023 08:55:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1692258935;
 bh=7l/QBcv0gmR9zYBlux27+LT0SQBLceMjFPuZQJpgypE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MSoACHSJ/CjaiHrwr91LvL489kzOrLP2gHcrELJ58Y49IcdvTIFAnd2N2HOEwxKOy
 sTJdFKZSIeT4Ht9gRFSwov+pCmIHmf2updjXWlHIWMO1X2e7Q787h2Ag8uxMeN1mT7
 ayoYw2dvHJPRKjFGug55fjTmTcx+vMITGT3FVcGxfBe97BhvmxLdL5334Q8poyRe7O
 a4Hnkf5C/1+fujLXoIz0LeOQZSqj7M8fxZwnu7HN324bCQ8VmxEEAkk5gW+sJnH/Dr
 48q+eC8o39APljPT8NYBaWQ+rG4Pys8h+8fJmQgMdEE/OO/7N/eaZWhtqs1yCCMaEN
 jMfT9mqOdNRyw==
Message-ID: <ce2473fd-dc7c-3c24-e83b-b2243de58bf1@collabora.com>
Date: Thu, 17 Aug 2023 10:55:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] board: rockchip: rk35xx: Add myself as reviewer to
 MAINTAINERS
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tianling Shen <cnsztl@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>, Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20230817060422.477759-1-jonas@kwiboo.se>
 <20230817060422.477759-4-jonas@kwiboo.se>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230817060422.477759-4-jonas@kwiboo.se>
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

On 8/17/23 09:04, Jonas Karlman wrote:
> Add myself as a reviewer for RK3566/RK3568/RK3588 boards that I have and
> can help with review and testing of defconfig and device tree changes.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   board/radxa/rock5a-rk3588s/MAINTAINERS | 1 +
>   board/radxa/rock5b-rk3588/MAINTAINERS  | 1 +
>   board/rockchip/evb_rk3568/MAINTAINERS  | 4 ++++
>   3 files changed, 6 insertions(+)
> 

For rock5,
Acked-by: Eugen Hristev <eugen.hristev@collabora.com>

