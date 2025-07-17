Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBCAC83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 06:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C214E83314;
	Thu, 17 Jul 2025 08:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752732416;
	bh=BmfLnY1WhFUq9NDsfB09tcFLg8vFH0wNYc6WzJiyOXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=kHGvHcvL3uPGQoPHVsW2dkWvLPRV7Yhjmb5aKSyo7HUUjROgAdkhMrDb7o2GaNybo
	 qOLnlfBvx1pZyjAHjcd0Q9rBptUoeJjk+Q5wyJ0ucsys3muPK25OlnH0bg1+iSlgfW
	 kGPybugln4XESoUygH81MfbugMgtnvTMoRosL/La9X/adDwRRMZvLQU2H9sX1+nSzA
	 HdG7sGX7MgTguBZvjFlgzgg9Tv2ESgyg25DfLrrsixI3VT4eXxZV6rfj/etO1nP6da
	 klNquzwEdabZ6+c2dSChf2DaL1IznUA0bYljR2RRgfPr09lMpwAG4f7/G3TB2mjkw6
	 iqt0v/78JFEJA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0314E83327; Thu, 17 Jul 2025 08:06:55 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19EBC832EA
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="expmAdp3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7349410397286; 
 Thu, 17 Jul 2025 08:06:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752732412;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=BmfLnY1WhFUq9NDsfB09tcFLg8vFH0wNYc6WzJiyOXE=;
 b=expmAdp33iwJM+yDWS0Uj7FBTPQH/v1OZfkPF2rjlmIk1DbnDjww/gUuQXnvBJmNKWj4NW
 V7aATRbu3ZSYK2B94hz0ijydkBiA96ahXdA1Hl3FAzeUCpALkgN0OF4dWlSAoyH0yI9bTE
 pa6qmo5CVSkUv8HdqJFsjsIoNrAKvhADWx47PyGDL3kVH2NaqATO/5SYY5R4A/27K4NX+T
 Jb7Qt1KC5jUMrm2EZv5GKSfp07DqrrQbBCfeMy84TMpHfSRKThCEHpPQgaFc54eJ0nJCvA
 OoKIkSBry0hgCengdwSk5hbgLXv+1rfQhhBU0a8Uytyq2ADr6YDfd5xIvbGWGQ==
Message-ID: <8edc3ef3-993e-6737-f5bd-7633b9bb98a6@denx.de>
Date: Thu, 17 Jul 2025 08:07:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] cmd: i2c: fix build when CFG_SYS_I2C_NOPROBES defined
 with DM_I2C
Content-Language: en-US
To: Holger Brunck <holger.brunck@hitachienergy.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com
References: <20250714115608.2457884-1-holger.brunck@hitachienergy.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250714115608.2457884-1-holger.brunck@hitachienergy.com>
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

Hello Holger,

On 14.07.25 13:56, Holger Brunck wrote:
> When DM_I2C is enabled and CFG_SYS_I2C_NOPROBES is defined, the
> building is broken due to already existing 'bus' local variable.
> Rename udevice 'bus' to 'cur_bus' to fix this.
> 
> Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
> ---
>   cmd/i2c.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

applied to u-boot-i2c.git master, thanks!

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
