Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818AEC636F0
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 19:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9937C88901;
	Wed, 28 Aug 2024 21:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724872529;
	bh=adF3D3Ttvacq5dVXn4ylzTqPcRPZjoaxkO7UMYSbS7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kajxXjUeDFMOVTODKImeieSKh+/Aaq2RiN81UChgleowy2IWhJbX2uwbVUqrZF5+S
	 rGx1dtjN8eVIZ40tSj9Zt0y54hoLzD0C5Ll75Wrpjf6Mjn+2CO8kAZxVddnyDXhTzA
	 2Ix4OlFH6TVVtHDdIt+n+d/fvYG7B9ZL4B3Ts5KwPaeLKbmUF8wlSVZ1+yr9710XpJ
	 3pqZOlNDnsxyKQm8TUKtz5BU45eIQOaUJVhVExi5UTb1CPHBX4vtvGM4gMegXz54+H
	 CRZz3q2k2vOgTelbCKem67tXa2xkc1Da6R9A969UxZri3t7J8r2ntuEow3JiciKOE6
	 cL8s2z5P/Bm5A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D4C6688440;
 Wed, 28 Aug 2024 21:15:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724872528;
 bh=adF3D3Ttvacq5dVXn4ylzTqPcRPZjoaxkO7UMYSbS7c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rzzblDMPMccAkq0luhJMaBr2igTJvSEM6QVKDwRqs9WFmaXYfoFIWEtNljq1C9sPi
 c7jrlUDSCKaXTelFnIA6XilI4XVW0IE6pcqNnOFiidp0pIEeUMfyYW0KHayFVOOtUi
 Y7QJUAFZL/1oTH/VF84R9Fjl8nMi7BjRqehmgB/vUKWgEoQ8rRVWyfYaQ4BPQQhRWY
 VoR1qxI0egaQvpKgEUTXEW63eE9uxCqL6VXdifxTOAqmh6H8RPrO8n0i/lluDqvmrl
 c6BRZZAiUPxowOZo+SQqr7P8vWJG2n+ZJ3JQO5+Uh/lZi0oz0FuysvHD2BRP6T23vL
 xK4KuqqHZdr+Q==
Message-ID: <0aabfe0b-d991-4ec0-b297-e051e7a1b181@denx.de>
Date: Wed, 28 Aug 2024 21:14:31 +0200
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

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks
