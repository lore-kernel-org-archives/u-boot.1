Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398D8CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 08:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A6283192;
	Mon, 29 Sep 2025 10:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CNuhUTsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CED8319C; Mon, 29 Sep 2025 10:51:29 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D23E808AF
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 10:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4924E6234A;
 Mon, 29 Sep 2025 08:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4073C4CEF4;
 Mon, 29 Sep 2025 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759135886;
 bh=8vjoNsrJCciYVYm8QPH2q63EekSIHwQR1ebQjxMh05Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=CNuhUTsxfn6xUOGIav61X/4YyG1+OtkupxZic0lkqP++usQzUj4v5HWaYvuQmUiJ5
 HzyFtNiMwAaVZ0rmwQr5UuEJfiAoSUxeAd1D8IPlgeHooUvGHmAvMQ2XTPGsm5M/vG
 zqezXQKXx7ZyfEnP9meJv6UOG1oQhDBPjRzTDeAri8+puk8Wr7/kd8Ky9+ToehVfN8
 sY7a+6ROYLXJOQNOu2Hh5fBj5i+zoFEVtYZ1sSLHq4YUuSlJSCpZJ1kaxc12J0mK6p
 3PAzfh/3liXOv4RZoTetf2lPgfJ2qJg/ng0Rx+QW8Gs8zrrTMfEqUTlWmLX7C+B0yw
 syiyB1W+CE6Tg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan
 <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 05/10] usb: f_sdp: Update SDP driver to support PQC
 container
In-Reply-To: <20250923-usbnetc-v1-5-507cddbe7214@oss.nxp.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
 <20250923-usbnetc-v1-5-507cddbe7214@oss.nxp.com>
Date: Mon, 29 Sep 2025 10:51:23 +0200
Message-ID: <877bxhk5f8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Alice,

Thank you for the patch.

On Tue, Sep 23, 2025 at 19:11, "Alice Guo (OSS)" <alice.guo@oss.nxp.com> wrote:

> From: Ye Li <ye.li@nxp.com>
>
> Since PQC container has changed version to 0x2 in container header,
> update the header's check.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/gadget/f_sdp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
> index 647001d8dd0..f72e27028b7 100644
> --- a/drivers/usb/gadget/f_sdp.c
> +++ b/drivers/usb/gadget/f_sdp.c
> @@ -765,7 +765,7 @@ static ulong search_container_header(ulong p, int size)
>  
>  	for (i = 0; i < size; i += 4) {
>  		hdr = (u8 *)(p + i);
> -		if (*(hdr + 3) == 0x87 && *hdr == 0)
> +		if (*(hdr + 3) == 0x87 && (*hdr == 0 || *hdr == 2))
>  			if (*(hdr + 1) != 0 || *(hdr + 2) != 0)
>  				return p + i;
>  	}
>
> -- 
> 2.43.0
