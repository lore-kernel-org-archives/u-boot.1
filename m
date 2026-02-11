Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD4DEB595E
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 04:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EF6383A5A;
	Wed, 11 Feb 2026 05:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LZXPg6ZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2D483B72; Wed, 11 Feb 2026 05:58:22 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD70E83A47
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 05:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7C7601104F4; Wed, 11 Feb 2026 05:58:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1770785898;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Rx+S985SP7QTIbib+7ZBGL4zYJTeadBx012B/GWZslY=;
 b=LZXPg6ZBfELSTJKcL/lH0qAtxZJ1PONPQg8uWQZx+o3aP7dnt0cPSEsfNYzv5jDqaRZ/cU
 gXHNejkbaXuwC+cBeK5b15VtI9dtFe0XTo0FzSqZkuqbxbJKCk++X2Cvxlqpwh1+XTs7pQ
 4E6EauwtArgAo2q0PaXC+EzhRl9X6QRaxNEEbrHSLWMCoPC0ux7aPqSJNb6M8jJgDhXleF
 MtHxj3bvuDTeVU+POdGnpRlzkBBL+vNkJXAnxNdb4BZf7P7Vb2Mgw0grbWyIl7Z9yISi4T
 8wSQJfKOCmAS+iVr1BdXCQh97uFp4ZmL18q1Cqc5IMWJrMmcmllShmVKBpmVFg==
Message-ID: <cd1a492b-51a8-26ca-d7df-4c4f22706f17@nabladev.com>
Date: Wed, 11 Feb 2026 05:57:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 11/16] i2c: k1: add I2C driver support
Content-Language: en-US
To: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de,
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, samuel@sholland.org,
 Guodong Xu <guodong.xu@riscstar.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
 <20260210151459.2348758-12-raymondmaoca@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260210151459.2348758-12-raymondmaoca@gmail.com>
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

Hello Raymond,

On 10.02.26 16:14, Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
> 
> Add I2C driver support on Spacemit K1 SoC using driver model.
> 
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> Signed-off-by: Guodong Xu <guodong.xu@riscstar.com>
> ---
>   drivers/i2c/Kconfig  |   7 +
>   drivers/i2c/Makefile |   1 +
>   drivers/i2c/k1_i2c.c | 516 +++++++++++++++++++++++++++++++++++++++++++
>   drivers/i2c/k1_i2c.h |  69 ++++++
>   4 files changed, 593 insertions(+)
>   create mode 100644 drivers/i2c/k1_i2c.c
>   create mode 100644 drivers/i2c/k1_i2c.h

No changelog? (You may take a look at patman tool in
tools/patman)

But it seems, you have addressed my comments to v1, so

Reviewed-by: Heiko Schocher <hs@nabladev.com>

Thanks!

bye,
Heiko

[...]
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
