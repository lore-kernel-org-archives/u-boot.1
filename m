Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CC1C2FC0E
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 07:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040A986A68;
	Thu, 17 Aug 2023 09:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="en6hgIJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC59F86A66; Thu, 17 Aug 2023 09:55:52 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7207B86A6E
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 09:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.125] (unknown [82.76.24.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 6CCF3660722B;
 Thu, 17 Aug 2023 08:55:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1692258950;
 bh=CdgDL8/9h4R8c1Nz593NHJCDmZLlsvSypP5NFvLJidg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=en6hgIJs12SDY26MWwRXUnNVU8zQ60bgrq/DR2exq7qaCJyTin00SpZlX/inda8Yo
 ZHdCwSpbsNSeXtLAsO0IVtazpS5eH1W3mLWYa3XYuLuvnO5Dn9nvPRpxGID+UMHYT6
 jiQiBH7g7gn+vSzV86gPnP7VVEWB7BCvxO0xwyL4gQvKH7IlVSqOML4+Uk2lVCAV3Z
 7fR09IyfwzvmNLepDvwR5z2MIrMiIEhd5sinWUqQsUBEdmgmzFvPNIcE0k9JQqF6+m
 Zy8zM0H9f+S6bELSTCKrfBvcxfcEUZoV0JrGne3VmamRnFGaR26YhJ/Sh5+ue6LTMs
 clW3D3KbZ/5MQ==
Message-ID: <2f63abf2-a22a-b27b-a5ca-6b7e86cf5917@collabora.com>
Date: Thu, 17 Aug 2023 10:55:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] board: rockchip: rk35xx: Add device tree files to
 MAINTAINERS
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andy Yan <andyshrk@163.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Chris Morgan <macromorgan@hotmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20230817060422.477759-1-jonas@kwiboo.se>
 <20230817060422.477759-3-jonas@kwiboo.se>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230817060422.477759-3-jonas@kwiboo.se>
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
> Update MAINTAINERS files for RK3566/RK3568/RK3588 boards to include
> related device tree files. Also replace space with tabs.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   board/anbernic/rgxx3_rk3566/MAINTAINERS       |  3 ++
>   .../neural-compute-module-6/MAINTAINERS       |  6 +++
>   board/radxa/rock5a-rk3588s/MAINTAINERS        |  2 +
>   board/radxa/rock5b-rk3588/MAINTAINERS         |  4 +-
>   board/rockchip/evb_rk3568/MAINTAINERS         | 51 ++++++++++---------
>   board/rockchip/evb_rk3588/MAINTAINERS         |  3 +-
>   6 files changed, 43 insertions(+), 26 deletions(-)
> 

For rock5,
Acked-by: Eugen Hristev <eugen.hristev@collabora.com>

