Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FDDC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 05:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7BB8832FE;
	Thu, 17 Jul 2025 07:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752731983;
	bh=O4+99LHRCxPzSxei3Rt3MHp5n79w9vZka7XXLAQIa0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mBzkCVoF3huHvHSU6vy4Sf/4f7lYm9FLmsNfrAY60P+aHDgEufz8PfSQrvnKraq53
	 Z0zGwWfAJE7BH5GVOwy0iCGNa5ZUGITbqI2Ikao3NhYYyRJ6lTWC615SPqvfRC2icl
	 1t17R8GBi+BDdP+QJ8/ZQwj5/JFEds62JAIi7kk9OPWsFqK9vbgPKnE47ESd1idiqf
	 AzD2f6nyD6Rvgk2Kuve2HRqcv6UEQeVUqymy6aIGqjh6XoM+4GBSLwK4StgLCGKIrW
	 OScH4tWrVlXwjmBPaQvdJlyLKq3LdAiZ7SEl0clm+rnMAQWFPy8YtWeclS03nAOOLO
	 VuvxK+WDV0Nhg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 434B083314; Thu, 17 Jul 2025 07:59:43 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A66682B0F
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 07:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QH2v8Y0z"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5409610397286; 
 Thu, 17 Jul 2025 07:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752731980;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=O4+99LHRCxPzSxei3Rt3MHp5n79w9vZka7XXLAQIa0o=;
 b=QH2v8Y0zwPYxb+Xr+fJe++EZVZsi+Beu+RjETGsIelKcWwZHSPn5GfG+Cl0ItgeVB+Q329
 J/V/3DZbF/RdATwU1wiOi+Ddff3jdpgvgLZNjk0JVEB4HxYl23NAcerVbmGEOYQPCTaLnt
 e6Cj8Ng8qIhvYs1ml5N/4DzqR7YMdW7c8ywZAs9iFGhe01bWWmx3BtmEfSM6b598AzzvsL
 gmwDMdJggfKHAtFhdrCthtUKTyP16udRQTUfWT7hbB/uAOX4YWf7kfK/WN6JwkQUcqFp3h
 eMQ8Sl6ZldLGy3NYE0HMch+5X5alOM154b5tEuwbukorlZli7qRKVdPYNs8KzQ==
Message-ID: <ff39e1e9-5cf6-b935-4d5e-21e25515785c@denx.de>
Date: Thu, 17 Jul 2025 08:00:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: muxes: Add PCA9541 i2c arbitrator driver
Content-Language: en-US
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, michal.simek@amd.com, jonathan.stroud@amd.com,
 bigunclemax@gmail.com
References: <20250623082439.949845-1-padmarao.begari@amd.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250623082439.949845-1-padmarao.begari@amd.com>
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

Hello Padmarao Begari

On 23.06.25 10:24, Padmarao Begari wrote:
> Add a driver for the PCA9541 i2c bus arbitrator based
> on the Linux driver for the same device.
> 
> Co-developed-by: Jonathan Stroud <jonathan.stroud@amd.com>
> Signed-off-by: Jonathan Stroud <jonathan.stroud@amd.com>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   drivers/i2c/muxes/Kconfig   |   7 +
>   drivers/i2c/muxes/Makefile  |   1 +
>   drivers/i2c/muxes/pca9541.c | 297 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 305 insertions(+)
>   create mode 100644 drivers/i2c/muxes/pca9541.c

applied to u-boot-i2c master, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
