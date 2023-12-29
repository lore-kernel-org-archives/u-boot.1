Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E850C47072
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 03:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3CC4879F6;
	Fri, 29 Dec 2023 04:43:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FPCFGwPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D57A87976; Fri, 29 Dec 2023 02:56:12 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A0C87919
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 02:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BT1u2aL075310;
 Thu, 28 Dec 2023 19:56:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703814962;
 bh=i336Uu/zEgtH4DxsnMFRsEiCIVVKqYlUJNeCNllTPOI=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=FPCFGwPtFjVoAfoaLqK2kqxRNlPjq5rVPLIfQusBUdWjCp2xQG2FUcvsGz9hWLqmy
 jlssFnEtG0nN16C6KZzCrtTQDMt5/diR6H5sROk6zqooB6Id507OxBBJlL5F+Vkz4K
 denspGbCc5RvxunB9KkF+4xS5AnzBkbT1BgJENes=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BT1u2Zw115788
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Dec 2023 19:56:02 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Dec 2023 19:56:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Dec 2023 19:56:02 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BT1u27e115086;
 Thu, 28 Dec 2023 19:56:02 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>,
 <n-francis@ti.com>
CC: <sjg@chromium.org>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] include: env: ti: default_findfdt: Follow the
 bootstd/distro conventions
In-Reply-To: <20231227130837.2624211-1-nm@ti.com>
References: <20231227130837.2624211-1-nm@ti.com>
Date: Thu, 28 Dec 2023 19:56:02 -0600
Message-ID: <86le9dwz4d.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 29 Dec 2023 04:43:12 +0100
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

Nishanth Menon <nm@ti.com> writes:

> Distroboot and bootstd both mandate a findfdt variable pointing to the
> correct device tree blob. Current mechanism calls a find_fdt function
> to set this variable. We do not need a find_fdt command to set the
> environment variable to a single dtb. Simplify the default_findfdt to
> remove variable expansion while at it.
>
> For legacy scripts depending on a TI convention of name_fdt, provide a
> find_fdt wrapper that behaves like before.
>
> NOTE: As part of this change, we also drop the cooked up
> default_device_tree_arch default_device_tree_subarch variables.
>
> Reported-by: Jonathan Humphreys <j-humphreys@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  include/env/ti/default_findfdt.env | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/include/env/ti/default_findfdt.env b/include/env/ti/default_findfdt.env
> index a2b51dd923bb..1a1ab8406c9e 100644
> --- a/include/env/ti/default_findfdt.env
> +++ b/include/env/ti/default_findfdt.env
> @@ -1,12 +1,7 @@
> -default_device_tree=CONFIG_DEFAULT_DEVICE_TREE
> -default_device_tree_arch=ti
>  #ifdef CONFIG_ARM64
> -findfdt=
> -	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
> -	setenv fdtfile ${name_fdt}
> +fdtfile=ti/CONFIG_DEFAULT_DEVICE_TREE.dtb;
>  #else
> -default_device_tree_subarch=omap
> -findfdt=
> -	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subarch}/${default_device_tree}.dtb;
> -	setenv fdtfile ${name_fdt}
> +fdtfile=ti/omap/CONFIG_DEFAULT_DEVICE_TREE.dtb;
>  #endif
> +
> +findfdt=setenv name_fdt ${fdt_file}
> -- 
> 2.43.0

Nishanth, only am62/beagleplay uses the default_findfdt.env definitions.  Others
(eg, j721e) define their own and have a run-time component to them.

Jon
