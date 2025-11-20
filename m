Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC3ACF884F
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 12:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E938410D;
	Thu, 20 Nov 2025 13:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="R9k244Hg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D20B840F8; Thu, 20 Nov 2025 13:25:15 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34AEE84118
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7400E1072E6; Thu, 20 Nov 2025 13:25:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763641512;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=LzIUu11Z3bI2E/330tAcbHb71DtD7k4XG1Lr53KCFDg=;
 b=R9k244Hg90ltMBU4QTO5p1ZO278+cyvhA4MGjkogpEz9tep9P8iqMmxN3bvPZhy3jwn5qh
 P4Hs4n44B7JebCn9HsFyIsUUIh+Ze8nFmj8xRsNRe+9fU3jbRiFGIabImm9tzT/BItev+/
 F6bCCVXeXVqi0YzwCfCUAMeYg1jGOUkYAOxD5DDJUWfYv3xkjAtCnh/8I9o9SLAk5IHDkP
 QQIJwH6UgU21EPvlJyGcqYWd0dTfJaeD4A4p2Ko8QC9rOTt0MyVG1jiEXRaKpVP6iiO0Fu
 E+938BMn3Ko1IggH7lx1tHBSprVCM4s+tJ7zcbyBJfiiLsFK4PJt4Y8ossmhlQ==
Message-ID: <2e2f3add-dda8-fcc9-0cc7-9cfbdaf11619@nabladev.com>
Date: Thu, 20 Nov 2025 13:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] capricorn: Stop disabling device tree relocation
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
References: <20251119145025.842054-1-trini@konsulko.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251119145025.842054-1-trini@konsulko.com>
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

Hello Tom,

On 19.11.25 15:50, Tom Rini wrote:
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If there is some window of memory that must be used for where the device
> tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
> or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.
> 
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Walter Schweizer <walter.schweizer@siemens.com>
> ---
>   board/siemens/capricorn/capricorn_default.env | 1 -
>   1 file changed, 1 deletion(-)

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
