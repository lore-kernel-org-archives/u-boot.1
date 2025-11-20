Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034F4CF8564
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD4F840AA;
	Thu, 20 Nov 2025 10:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="VBRKewIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40B3840AB; Thu, 20 Nov 2025 10:18:41 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C838083DBF
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8CDE610B397; Thu, 20 Nov 2025 10:18:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763630318;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=pWiGSFR9K0VgT6m7Jw47srEjHlqFiQh3jpmuy5cZsZ4=;
 b=VBRKewIc/NH+xDPoY5oaksc7MkTEkVvC2yLfciXw0LDVxkeX8M8iDLgACB84yeUR/FDejO
 A8Z6HKGi8A4GmVT8gimBXw1IYBs9si5Q4ySHzLz/cr3W/fwMn0irlj4GANxUxnpNRR49ll
 gatSPwYxMDuXzJws8yUgSrarx8jpy9zbHDEzzl4tC32c6c/MIGljJkJ5+wkkkSpWUXpnQz
 F+yRvMqImxg69GGkGBAPAZcC2FA51/DJgST08+X/8z0E+zOx/CE29f2sYQIdFzB3SwTPpP
 kL6GQeDguIu2J0b1uWQvhjFqPynEzaAYEAV1T64DE6S3NZ1tet5bEbjGdeDV0w==
Message-ID: <46f2e9b0-286b-ecbf-78ad-6b3f0f1a545e@nabladev.com>
Date: Thu, 20 Nov 2025 10:18:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/4] corvus: remove green led support
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Freihofer, Adrian" <adrian.freihofer@siemens.com>
References: <20251119-corvus-led-red-green-v1-0-ce86b8d59dfc@cherry.de>
 <20251119-corvus-led-red-green-v1-1-ce86b8d59dfc@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251119-corvus-led-red-green-v1-1-ce86b8d59dfc@cherry.de>
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

Hello Quentin,

I added Adrian to cc, as I do not have access to a hardware...

On 19.11.25 18:01, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> green_led_on and green_led_off are only called by the legacy LED command
> (CONFIG_LED_STATUS_CMD) when CONFIG_LED_STATUS_GREEN is enabled, both of
> which aren't enabled for corvus, so let's simply remove it as it's dead
> code.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   board/siemens/corvus/board.c | 11 -----------
>   1 file changed, 11 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
