Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E8EC28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 05:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F8E3806D8;
	Tue, 11 Mar 2025 06:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741670290;
	bh=5csZkDuhUf6omgUyVCF1rU4n2ZhPig3eBif0vf/9XBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=nxtbpXhOjsLSiOUTsMkvkNgIG6wE0UbW484adGfcjjT/KzeCvrTRMPPGjoNYphCsd
	 q3pHan2Ey7bs4Br4XzR7N5Ybep6Ajrwh8ghe2JtsOJEYd0F5uSjZM1uCuUXXLDKKDH
	 9qQd+DgiF9fNm0nwWmObZfKQCWHQnOsnlMvtGPhZcY6Mj3HRvObFb1L6Fe5I4DUcfA
	 UbaKTLsJD3ZVrmhJ07+GcannaB0t/DU+OBX8yCDLy7ZIY/1AfqkDu8QvgBHspp25xJ
	 cn/kAA8DN6wD7Ioy9EaIKtsHnuAGst/+KC0DuIgkgndhtzUa5wX0VWcV3wx3H12VHM
	 hiszmZFNxELzg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C475807D7; Tue, 11 Mar 2025 06:18:10 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A20E8006D
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JN8D3nC/"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9698210210BC0; Tue, 11 Mar 2025 06:18:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741670286;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=5csZkDuhUf6omgUyVCF1rU4n2ZhPig3eBif0vf/9XBw=;
 b=JN8D3nC/J3hIVamqVY3DVxn+VAa7wZcoyUaxWenIx3Bh8+ZNLkUFfxNRe30BauHQCoAsDn
 9b0f2SLPTNB6JYctvRydktWpnyZ1+91VOFHwYonfEP8M+Qc4/jy6M2y7JHRoEEgb3YlIA0
 16r1UOFuubVZc0z2B4F2NIR9LqM8qQAf25d31SDhwZ3lGu+2ukWdkZUmkPLfMf2aipfbR6
 KfhShkWooYHfcisA8lVmjgnsL6B5wH3hPIoSwwFcm1eYi2Oq3bmS2nauHXCyjht9VrOTVP
 /GQO9h5OkbTyf8f47cTLlWBnpUD6rAZjPOxHDBejN7wmRNxEudwArzJf5C+faQ==
Message-ID: <6d8b084c-1a66-82dc-4142-76dd63ad606c@denx.de>
Date: Tue, 11 Mar 2025 06:18:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/4] i2c: omap24xx_i2c: Remove unused
 CONFIG_I2C_REPEATED_START
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, stefan.agner@toradex.com, w.egorov@phytec.de,
 j-keerthy@ti.com, u-kumar1@ti.com
References: <20250310103702.1464782-1-a-limaye@ti.com>
 <20250310103702.1464782-2-a-limaye@ti.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250310103702.1464782-2-a-limaye@ti.com>
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

On 10.03.25 11:36, Aniket Limaye wrote:
> Remove unused piece of code under CONFIG_I2C_REPEATED_START which does
> not have any Kconfig entry at all.
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>   drivers/i2c/omap24xx_i2c.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
