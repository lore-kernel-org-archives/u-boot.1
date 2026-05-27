Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C8BCD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 03:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1339F846BD;
	Wed, 27 May 2026 05:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="jJNWHUzT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7344784886; Wed, 27 May 2026 05:17:11 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85ED48469D
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 05:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 16B5B102BF2; Wed, 27 May 2026 05:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1779851828;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=RWZFOEHUj+FqyeMr6ZXGRUg6A6qWTbtW2mLQZ8/9q1Q=;
 b=jJNWHUzT1JIx7Fg+e4Mv3T6irselelAgU7JT3ke6sW4oubBgUYU7SJOMOTFODzwq/fhPtf
 RAGvU6qoPOMYs0lGPdHJZ0TpoJWgaqPGJbV8X+15suaVpnGEjAKohDX6zn1KvvVmdMuWnZ
 6ah7LUEsdGO9BOk9WtnMSJ/kmyhkUQhYR9BkJfeqL55SJ54/WuKWOXs+eHOv3ENsFbC+58
 kho+XQu1FVgXSUgRqscme5XnugFV/RQPRcEClgb45z9p3MfUYga0zR0Y0V8ewrC3qAi/HZ
 T8ySrcHnfJZo1L1zg7RqaqfkwZSXsTFmUy9ok9uuhLf+mHecH8ivRJdO4E0uBA==
Message-ID: <35aeead7-d969-152e-72b3-49c9720108d6@nabladev.com>
Date: Wed, 27 May 2026 05:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] i2c: nx: Use dev_read_addr_ptr()
Content-Language: en-US
To: peng.fan@nxp.com, stefan_b@posteo.net, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260525040303.2367825-1-peng.fan@nxp.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260525040303.2367825-1-peng.fan@nxp.com>
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

Hello Peng,

On 25.05.26 06:03, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use dev_read_addr_ptr() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/i2c/nx_i2c.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
