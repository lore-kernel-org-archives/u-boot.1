Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEBCC54FAA
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 13:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB09288875;
	Wed, 28 Aug 2024 15:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724851467;
	bh=aXqIzRdScHD5VGeaOtwEzve8mYlHWYxNfUPwnXCj6/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zViP03RJppJBcSxu6sWWQqm//aDzywwstKLYwc9+3MS1DS2IylJmneROSqYqYDv2k
	 jg1bSf3X5lGfT+9Kl5laTql+ob7rQHuR8f3x6KSA/7GwgDATr1vpgsMGBFtefAMfPC
	 xS7db1E+gGZf50L1WJr+qOgsx/uk3ZQgVcPzUfr82R6Ez8UxuE9DJP2efocX3+G/g7
	 UjKklj85QrRzpplg+KfDpN3mbIUGRsft9SG+98fVu7WQC7BzDQBbuFMr+YSABUiMdR
	 HdVbmD51CalJ8AxckdRdKYbq3e7hgQyNYg7ygQyMkHiY/ZGpi1nJvxHR0eZ2e/yIgR
	 5nbwecyHsPDXg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E61B4887B4;
 Wed, 28 Aug 2024 15:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724851466;
 bh=aXqIzRdScHD5VGeaOtwEzve8mYlHWYxNfUPwnXCj6/U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uRGkLMHOL7uTAAzpMy1DWkbLIA8tLdpRS6CoU09FzASwTt8F+XOW38zoSqlFz/w2j
 lPfO3m3jbUcKVARsOHOQpg9jIN9wzz/KgDkSH6NsFy3hldTh1kG6YeM5IESF7xusqD
 c4zkBFiJ1AEQQ6gRzh0BumMAusGe8QqBS7L/RuicQwLIQrOLbWlkhBPXiN+1Rfxn5K
 Hn1rCZ2+NCHa2+uWEEcZ8x2BzRS+W5lV8s0j/K/ewWFlh6IaXxjslNaxh+HxIs34q2
 Z03+QcQajHaLpmKE7houQv/lMoQjXyXLdJ/QQPcXnWHy0C1Lw2asgagKJAteZXqh+R
 qgy+0zJjmY+/g==
Message-ID: <6076e0bc-a7b3-4d48-b180-32443fb966e0@denx.de>
Date: Wed, 28 Aug 2024 15:24:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] gpio: mxc_gpio: fix reading state of GPIO pins in
 output mode
To: Tomas Paukrt <tomaspaukrt@email.cz>, u-boot@lists.denx.de
Cc: festevam@gmail.com, trini@konsulko.com, francesco.dolcini@toradex.com,
 tharvey@gateworks.com, aford173@gmail.com, peng.fan@nxp.com, ye.li@nxp.com,
 michael@amarulasolutions.com
References: <py.Zbyp.4iSBCzZ4lgW.1cpo6S@seznam.cz>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <py.Zbyp.4iSBCzZ4lgW.1cpo6S@seznam.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/28/24 3:09 PM, Tomas Paukrt wrote:
> The PSR register works correctly for GPIO pins in input mode,
> but always returns 0 for GPIO pins in output mode unless the SION
> bit is set.
> 
> The DR register should be used for GPIO pins in output mode
> to allow correct getting of previously set output value.
> 
> Please note that the Linux gpio-mxc driver and the NXP U-Boot mxc_gpio
> driver already use the DR register for all GPIO pins in output mode:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=442b2494b17d1a4f0a14721580271eb23ebffd42
> https://github.com/nxp-imx/uboot-imx/commit/4afc3f90943c6b117f79b66d2cd04e64f437b0c2
> 
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>

Changelog is missing, what changed since V3 of this patch ?
