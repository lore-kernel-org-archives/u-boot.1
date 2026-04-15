Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CD2FA0C37
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 07:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D303183D8A;
	Wed, 15 Apr 2026 09:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5705783E36; Wed, 15 Apr 2026 09:04:38 +0200 (CEST)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7722483B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=legoll@online.fr
Received: from [10.0.0.2] (unknown [82.65.243.93])
 (Authenticated sender: legoll@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id B453160143;
 Wed, 15 Apr 2026 09:04:12 +0200 (CEST)
Message-ID: <fb7a128a-1408-4595-a09d-2f2fecb311b4@online.fr>
Date: Wed, 15 Apr 2026 09:04:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] Add board support for Spacemit K1 SoC in SPL
From: Vincent Legoll <legoll@online.fr>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
References: <87d4cc89-e60a-4365-b6c0-efe5b20d0c7f@online.fr>
 <286a02e2-d026-48bd-977a-d8df3c9d98c5@online.fr>
Content-Language: en-US
In-Reply-To: <286a02e2-d026-48bd-977a-d8df3c9d98c5@online.fr>
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

Hello,


Is there something we can do to help this series move forward ?


What are the next steps ?

How can we get a fully booting board after this is enabled ?


Thanks for all the work !


Best regards

