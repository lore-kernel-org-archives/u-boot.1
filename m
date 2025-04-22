Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22299C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B26E781273;
	Tue, 22 Apr 2025 17:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745335195;
	bh=JuQv9pVbHK5mRAU2XASI/u6SXFhn0kQVn+h3dz9xlUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=KfwRUrjFsfV3FnboIiF+iEsZnc82qHj1YvRK5O1Y+Z0mzjtLM2jcGkilXumxZwRgL
	 hHdW7VSnJ3gJaglU3e3t0v29B8FRd3t1Y8HQ6v+tjzEimaehxbUoYix86Xg4whfqhs
	 8FqJiZSqe2tG6cVQITQVqx3NVywaR2hQ7o6gCRTYcG1Wu6nPb2mBJJDSGdBAIz0Ezp
	 tqzww86Ua7i3amNfCoFD6jwuRL+FkcuRuXJbyDdFgDDfMcPVe51TtZ8+r8HiI9nffC
	 eWmlWNpkk5Yx5W5HvdGOSFaNg74WWlB6pRKcVHC66/Kcs+9lF9Lcb/zv4tMgB5W3Pf
	 HHB4UBIpqZjkA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6CA981E72; Tue, 22 Apr 2025 17:19:54 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE0D80F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="fJkvTqNU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ECFF71039EF31; 
 Tue, 22 Apr 2025 17:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745335191;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=JuQv9pVbHK5mRAU2XASI/u6SXFhn0kQVn+h3dz9xlUU=;
 b=fJkvTqNUNFCe9iJUNhTpicpfkKXJ/vseDwGgOTdtV4V915wUrJnd/zAhK/Sqa9zFPmExr7
 7FJq+7HziRWor5s9M7BUtCuv0+MLYyaSfkv9xsUf4nwS5Eo46UEqP+exklk6U8gcBJGvqQ
 /s2SIZwPq6aPBA9UnXRzkjFtpBylJORlwVk4BPAt32zYrAmJgNCzvHqCoRXE1RdePinybT
 0yc2aX0RekG9SR/TyGRnx0gTrWqLqwdF2LPR8NcUaXR7VjUvYp1j/uF4sMbVecHujvSGxu
 vyC2yGSJVa7ipFpX6j4YtwFOd9KgPNLQuwycZoVlugpq6R1OCQQsNracvdecyw==
Message-ID: <7668c2d7-2542-2797-ab82-fad2b89ac546@denx.de>
Date: Tue, 22 Apr 2025 17:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 4/4] drivers: i2c: Kconfig: Add
 CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, w.egorov@phytec.de, j-keerthy@ti.com,
 u-kumar1@ti.com
References: <20250422101957.1949448-1-a-limaye@ti.com>
 <20250422101957.1949448-5-a-limaye@ti.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250422101957.1949448-5-a-limaye@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Aniket,

On 22.04.25 12:19, Aniket Limaye wrote:
> Add a Kconfig option to disable sending Stop conditions between multiple
> i2c_msgs within a single xfer. Enable this config by default for ARCH_K3
> platforms.
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
> 
> v2:
> - CONFIG_I2C_REPEATED_START -> CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
> - Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-4-a-limaye@ti.com/
> 
> ---
>   drivers/i2c/Kconfig | 9 +++++++++
>   1 file changed, 9 insertions(+)

Applied to u-boot-i2c master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
