Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B81CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 13:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF2080F0E;
	Thu, 14 May 2026 15:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="iFVmlEKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 697FC8467A; Thu, 14 May 2026 15:35:01 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92EFA8039B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 15:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 969AB10D133; Thu, 14 May 2026 15:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1778765699;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=FspRLANaEWDJkbDAYMMaIKEjAOM2kJ7sFyOVB8ulBUU=;
 b=iFVmlEKpyhseysvXSvquNjBKUWjPESmaPtjosnW58L0oSNfe8NfYdnULOzC+49L3/7xqJH
 ukcVEIEPcmfHHq2+PJmIyAS1B3BEk/DeiFKGGIiU+w5JKnP/t9jZpVsbdZb72GguAHDalE
 CP1swdZdnJik5p19Qigt5wnmohTxP6dyAjXjc/FYB3rQr7Qk176KSQBxodQvJJvx/2R6IA
 PvpthI2l41bDduoAkKiToh6cpIVx4YCNvDzfH+IGk/78tD0c4Mj3lf+5kGMrdWMDNQkMBy
 HjSPZxW4jYlkfpNTpy9iyIavLZXtXUvpZXx+vCYZ6BOmRx1EKNB10MjVGhul5g==
Message-ID: <528a2a47-a117-e57c-24cd-2a314c0dab51@nabladev.com>
Date: Thu, 14 May 2026 15:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: Remove legacy CONFIG_SYS_I2C_SOFT
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260320205321.3788559-1-trini@konsulko.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260320205321.3788559-1-trini@konsulko.com>
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

On 20.03.26 21:53, Tom Rini wrote:
> The last users of this legacy i2c stack have been removed or converted
> to a modern part of the stack instead. Remove this code and references
> to it.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   README                     |  92 --------
>   board/nxp/m53017evb/README |   4 -
>   board/nxp/m5373evb/README  |   4 -
>   drivers/i2c/Kconfig        |  20 --
>   drivers/i2c/Makefile       |   1 -
>   drivers/i2c/soft_i2c.c     | 418 -------------------------------------
>   6 files changed, 539 deletions(-)


Applied to u-boot-i2c

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
