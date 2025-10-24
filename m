Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79332CCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 05:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4689F82E34;
	Fri, 24 Oct 2025 07:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="PvD9aSzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 603D5832BC; Fri, 24 Oct 2025 07:48:05 +0200 (CEST)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12ACB81E13
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 07:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=grimler.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=henrik@grimler.se
Date: Fri, 24 Oct 2025 07:47:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1761284882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eNo46JW4+6+iizCmkqGphnJ0c8bC2/VE0S8EVhJEF/g=;
 b=PvD9aSzp6iLoeb8uKvS3N8rilJK14n2VPBKN6/qkMfKHKI7gOfUaEjDJiINcZnrbsuETWm
 qqsBbM+f+s9NqjJJMXcxemm9+UT9cDQrnXiqF25A7YRev3ftqjH0hcY1DQkAsiJw9P+CVK
 LhJgYF9vEPV8OP0HGSfubABWA+xw/NA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] serial: s5p: add compatible for exynos8895
Message-ID: <20251024054758.GA10245@localhost>
References: <20251017-serial-s5p-exynos8895-v1-1-b412dd112cfd@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-serial-s5p-exynos8895-v1-1-b412dd112cfd@disroot.org>
X-Migadu-Flow: FLOW_OUT
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

Hi Kaustabh,

On Fri, Oct 17, 2025 at 08:59:22PM +0530, Kaustabh Chakraborty wrote:
> Add the compatible for Exynos8895 UART as described in upstream
> devicetree bindings. This enables support for Exynos8895 and other
> similar UART devices, such as Exynos7870. Other than that, the driver
> works as-is.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Henrik Grimler <henrik@grimler.se>

Thanks!

> ---
>  drivers/serial/serial_s5p.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
> index 734780a124ad47ed97811784edfdb45a75d37bf7..d46a88610ab88a227aa07b10c62576a13168bfbc 100644
> --- a/drivers/serial/serial_s5p.c
> +++ b/drivers/serial/serial_s5p.c
> @@ -258,6 +258,7 @@ static const struct dm_serial_ops s5p_serial_ops = {
>  static const struct udevice_id s5p_serial_ids[] = {
>  	{ .compatible = "samsung,exynos4210-uart",	.data = PORT_S5P },
>  	{ .compatible = "samsung,exynos850-uart",	.data = PORT_S5P },
> +	{ .compatible = "samsung,exynos8895-uart",	.data = PORT_S5P },
>  	{ .compatible = "apple,s5l-uart",		.data = PORT_S5L },
>  	{ }
>  };
> 
> ---
> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
> change-id: 20251014-serial-s5p-exynos8895-3303dfe3a99b
> 
> Best regards,
> -- 
> Kaustabh Chakraborty <kauschluss@disroot.org>
> 
