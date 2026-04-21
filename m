Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC454F5A8CE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A6F8422D;
	Tue, 21 Apr 2026 02:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UlJGvmZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D88728426E; Tue, 21 Apr 2026 02:44:44 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8FCD84198
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g03XS7175z9vLQ;
 Tue, 21 Apr 2026 02:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776732281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Loqc4jPFv1rmnuRXKv0FDQRs/31nDEfch0OgGjSmTF8=;
 b=UlJGvmZajZ9GDFssCt8HiGuHV/FTEXafhwLhQ1vH8P/OEbiVioZa/Tp80BHigqVNT1YZAj
 VYivJ5vQ5mUWu638dimp9/lByBWoN4jtQR53Xhp86rG8KgX7dU+66nsIeZN/38dgtDFtdN
 tbaOffovMdSna/Qy+7Kdrusc91LOYZx+h+6saTag89oublH6NfyXQF8qwGOba6UsmvHBvi
 vBQ1PuaQk4lEGY8yTfgGWMCcMiYV2SxKVXpM97QxqF0MpmX9B2fcQi1unW7I8OxBkmB+Os
 AaMPjWPsfDrHl3p0b47QMlMbrafVYAru0ydGrAjGWv5CoZjRWs8km6yig7NxeQ==
Message-ID: <81f45736-4304-4d3d-b073-a34646d13407@mailbox.org>
Date: Tue, 21 Apr 2026 02:44:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 8/8] board: ten64: start USB stack in late init
To: Mathew McBride <matt@traverse.com.au>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-8-eaa81288e393@traverse.com.au>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260421-ten64-add-usb5744-v2-8-eaa81288e393@traverse.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 71ij5j6u1ya8fi87tdwoy38za37tkckc
X-MBO-RS-ID: 4e462647c980391d1e6
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

On 4/21/26 2:04 AM, Mathew McBride wrote:
> There are two reasons we need to start the USB stack late
> in the init sequence (before handing control to the user /
> boot sequence):
> 
> 1. When a USB hub is present on the board, we need to
> do the required sequences to make it usable
> 
> 2. To make USB storage devices 'visible' to bootflow
> without further intervention
> 
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
> ---
>   board/traverse/ten64/ten64.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
> index ee2a4005739..29faea3dadb 100644
> --- a/board/traverse/ten64/ten64.c
> +++ b/board/traverse/ten64/ten64.c
> @@ -31,7 +31,7 @@
>   #include <asm/arch/soc.h>
>   #include <asm/arch-fsl-layerscape/fsl_icid.h>
>   #include <nvme.h>
> -
> +#include <usb.h>
>   #include <fsl_immap.h>
>   
>   #include "../common/ten64-controller.h"
> @@ -239,6 +239,13 @@ int fsl_board_late_init(void)
>   	if (IS_ENABLED(CONFIG_NVME))
>   		nvme_scan_namespace();
>   
> +	/* Ensure usb storage devices are available to bootflow.
> +	 * Additionally, if there is a USB hub on the board,
> +	 * it needs to be started to become usable both in U-Boot
> +	 * and in any booted OS.
> +	 */
> +	if (IS_ENABLED(CONFIG_USB_STORAGE) || IS_ENABLED(CONFIG_USB_ONBOARD_HUB))
> +		usb_init();
Why not place 'usb start' into 'preboot' script instead ?
