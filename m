Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80773E6F086
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 20:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C0088DC8;
	Fri,  1 Nov 2024 21:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="CCoM6ybS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7758188E14; Fri,  1 Nov 2024 21:29:56 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9080C88D9A
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 21:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 0c20ee7f-9890-11ef-9dde-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 0c20ee7f-9890-11ef-9dde-00505699b430;
 Fri, 01 Nov 2024 21:29:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=PF2zdgTJoDT5Ta2l6glFi4aOAEue7QhN2xxHGUEgsVE=;
 b=CCoM6ybS4wgKUaw5XlUQsPwcGX6QfhlP77aAnqoPSyb9agDQq9Snl60esiu/G0zmM3Cdrn4ycgvXk
 VVYtu+WR+IhlKdSe2COlwDYiVx3w8DLERj59YDnUmk7LN9mr32fGTsaA8TdR74F/YiEhqisq2SWmEB
 wH487dSs7/yyZfhSj4XGB6dBbm8tQFsj3plYpG+EnMewvAJ7bEnq+lNv17oVsPNujrpoH5y+0IRCAf
 nehUIKQOQf5uaVbVNhJMznSC/+Wcw7ngYB+tU71ratdEVyAuRB80H2g1nleTDM1HA25DC3nb60G4V2
 krECd+Qs0L9arh/2IOtsVNK4RNPtMcA==
X-KPN-MID: 33|4RQ3nM3D+LPTPhlzwKznWYGYiU9bTLELn3o5KEoAAybh+JwWFV3oSPe8seZLNnp
 +aYyjcekUp8TeOBm45kTfy+6aWFMJ1oOvW+wTspfH+4I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|8WwY0EMuFRdnSEzYEg35KQASHfP+7vYIdJ9pu9cyPU3Tjnb6MC7OYXoUtwm/PSE
 /utks4f3DkurFLo0y303BNg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 0d35a79e-9890-11ef-9749-005056998788;
 Fri, 01 Nov 2024 21:29:54 +0100 (CET)
Date: Fri, 01 Nov 2024 21:29:53 +0100
Message-Id: <87zfmi4rzy.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: kettenis@openbsd.org, trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de, j@jannau.net
In-Reply-To: <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
 (message from Janne Grunau on Thu, 31 Oct 2024 23:48:02 +0100)
Subject: Re: [PATCH 2/2] efi_loader: remove non vital devices first
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Thu, 31 Oct 2024 23:48:02 +0100
> 
> DM_FLAG_VITAL marks devices which are essential for the operation of
> other devices. Removing these devices before their users can result in
> hangs or crashes.
> This potentially fixes EFI boot of Renesas rcar3 devices. Their clock
> devices (and with this series the dart iommu) are the only devices
> markes as vital.
> The arm boot code already handles devioce removal in this way.

There is a typo in that last sentence of the commit message (devioce).
Otherwise:

> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  lib/efi_loader/efi_boottime.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 4f52284b4c653c252b0ed6c0c87da8901448d4b4..7db3c95782970f8c06a970a8ee86b1804cd848b6 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2234,6 +2234,7 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
>  		if (IS_ENABLED(CONFIG_USB_DEVICE))
>  			udc_disconnect();
>  		board_quiesce_devices();
> +		dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_VITAL);
>  		dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
>  	}
>  
> 
> -- 
> 2.47.0
> 
> 
