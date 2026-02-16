Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DABE63F3F
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 08:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE90683C6C;
	Mon, 16 Feb 2026 09:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="e8mG7zQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A9F83D5D; Mon, 16 Feb 2026 09:49:10 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF0338063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 09:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D23FA10F1BF; Mon, 16 Feb 2026 09:49:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771231747;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=zLxOPKuBs6T8WblAbtc5WFnDdeHxODAJpIinFWGSKjo=;
 b=e8mG7zQnul4/VTayXvSxY8XQhHp3f7PkKM7fRxEjhtnI85edTEuAdAn7ImWLAw9fMIIxfL
 VDD7ac2Ush5GSh0zdpvXR8OWU6TV/m+bVaj7TdtqWL9f9jPtpp9Dk0V1A6XJls0pFu3+KJ
 gtOEIHMbR5v71SO3Kotxp4Uwnn7pS5UUmBIRytbWm9wJZB+JHPZUKQT96oo0W0mg9IGj8H
 GQUPzhvGeXL5LsSjy1gEGE7x903vqlQ2DSw+B18GtjUghPrzbZqDy1vn//vaeC32CczLCR
 cWb6E+h38dWn7x2eZcWqs/1sxJDGi9XoK43A+dUifE4yn2hEiuF/2/HHRyX+ug==
Message-ID: <856380cf-09eb-d722-0f48-3c9705b78626@nabladev.com>
Date: Mon, 16 Feb 2026 09:49:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: muxes: pca954x: Add support for pca9848
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Frank Wunderlich <frank-w@public-files.de>, Tom Rini <trini@konsulko.com>
References: <72cadba2a21e9d5723d54994b898d8a6880042e0.1771229639.git.michal.simek@amd.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <72cadba2a21e9d5723d54994b898d8a6880042e0.1771229639.git.michal.simek@amd.com>
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

Hello Micahl,

On 16.02.26 09:14, Michal Simek wrote:
> Add support for PCA9848 chip.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/i2c/muxes/pca954x.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
