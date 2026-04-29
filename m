Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57FFFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 06:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C10846EA;
	Wed, 29 Apr 2026 08:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="PTX9FeHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97997846DE; Wed, 29 Apr 2026 08:11:27 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B91B1846EA
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DA6B3114EA4; Wed, 29 Apr 2026 08:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777443081;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sZgLE3vZvpEbkKjWybiP+tOYCde8PzC8VG6/OCWAKuI=;
 b=PTX9FeHXlQT3J9Mwgv/O2PfkWDS9cqjUmVxg50xLhoqNi4EIP4sL7ZgK4OOmc+kKXdZ1h5
 qEVb6gJOD7N/UP9Jr38jz9qkCc1v/ULO/cNe8MW54CitxW15FO2vrqwIZstco/55BifRkp
 KpaPY3l/PscGt+QLQy2A/2TK/Wlu1aBhK4onCY2HSlQNJF1Q50L9Oooq5w/XZV27MbAe4j
 hKBOgQaNMjbFe31iYppNBD8X9krsnn/0/8q4c8bYJKc0gxMZX96NqV4GeC+ljPmlo4IW4X
 cBvY9bbO/dkVvDHFhthG5m0p8zlIsbEUlxZ/bHVLbJCfPUChLxgcrqlY9ay/gw==
Message-ID: <7a057ec1-7e7f-7023-8693-c1f321608edf@nabladev.com>
Date: Wed, 29 Apr 2026 08:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/3] configs: socfpga_arria10_defconfig: Enable I2C as
 default
Content-Language: en-US
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Wojciech Szamocki
 <wojciech.szamocki@nokia.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>
References: <cover.1777439293.git.dinesh.maniyam@altera.com>
 <69a41eff6ce34bda3b39a6b8340968a1174f7a93.1777439293.git.dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <69a41eff6ce34bda3b39a6b8340968a1174f7a93.1777439293.git.dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Dinesh,

On 29.04.26 07:11, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> Enable I2C as default for Arria 10 defconfig so that this driver
> can be covered by U-Boot's regtest.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   configs/socfpga_arria10_defconfig | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

Thanks!

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
