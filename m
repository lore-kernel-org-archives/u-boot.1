Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEC8F357DA
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 07:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC5683E13;
	Wed, 25 Feb 2026 08:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LX2iOROz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A9B583E61; Wed, 25 Feb 2026 08:24:28 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9658D82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fLR144WFbz9tf7;
 Wed, 25 Feb 2026 08:24:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772004264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+vrH1Kc+T7EDNYes5tunI84dtce3gG+bBkUm/bU4pE=;
 b=LX2iOROzgY24shbnh+p7GCIjt2qTYxM5NHuJipo/zG8UfCgndDbBSZNUOHla97rNA+8e6I
 Xfcf/p/Ec1Qw/2I1KSdoht9idGGXnVk8/YYYUifSrv3BhXyLpwxKh3r6fuw7zU4Xi7k+qW
 JQFkvKcqVcaSBsMod/uAg2MRmbxSDnnv9wxL2eHFqOu25VRIv1KfElDchjWnVGAGz7vnQW
 NcwAho6h3QqtvdIWkHT+2j1GdtqQAJCh8aRf3Tkio83rAegzPVhnvd5sBqBwdya3eGngxc
 LEoRBye+KvZI0Dp3PXvhlm1xgoxfDUqieW4PWlj9ECQMzI4oKRqhTH8+csFoQw==
Message-ID: <5a1d198b-a988-4493-acbe-b4dea2794102@mailbox.org>
Date: Wed, 25 Feb 2026 08:24:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] serial: serial_octeon_bootcmd.c: use correct Kconfig
 symbol
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>, Michal Simek
 <michal.simek@amd.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Luca Weiss <luca.weiss@fairphone.com>, u-boot@lists.denx.de
References: <20260225071008.49435-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260225071008.49435-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c5928c7d5b139295f71
X-MBO-RS-META: 8xwbm693ao11gsafqj33r6r9zx4byirw
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

On 2/25/26 08:10, Heinrich Schuchardt wrote:
> CONFIG_SYS_IS_IN_ENV does not exist.
> CONFIG_SYS_CONSOLE_IS_IN_ENV seems to be needed here.
> 
> Fixes: f1054661e50f ("serial: serial_octeon_bootcmd.c: Add PCI remote console support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/serial/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index b84cb9ec781..3fb3492dcd0 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1022,7 +1022,7 @@ config OCTEON_SERIAL_BOOTCMD
>   	bool "MIPS Octeon PCI remote bootcmd input"
>   	depends on ARCH_OCTEON
>   	depends on DM_SERIAL
> -	select SYS_IS_IN_ENV
> +	select SYS_CONSOLE_IS_IN_ENV
>   	select CONSOLE_MUX
>   	help
>   	 This driver supports remote input over the PCIe bus from a host

