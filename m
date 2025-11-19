Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB10CF3185
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF3E83DE9;
	Wed, 19 Nov 2025 10:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="aLeBpmG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F03800B6; Wed, 19 Nov 2025 10:41:47 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D045183DEB
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 10:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1600010848B; Wed, 19 Nov 2025 10:41:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763545305;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=zw9kltHdXoRf7pvns9Ram2KaaTsLt0c/AFrQYQu/DEg=;
 b=aLeBpmG1/CGMkk+U/WntG6VZP1Aupg7JESHaoxmT4VQGi15z0+ZCAGDx3rBY4mU982w5qY
 +COOoZzBn8hNKm0stM+E7dnf/bnRrobW4RVejJBX3OvqI85B66qFYcN53vo1v5iCXLq+BR
 wGiwLw9MxgfYlUcJJzwsGQLMRy2reuZIA2n+lLzANdyGaKZFa3yshnUIVn6lvvB1cWZmGW
 1cL2MII5uj0t9NSjoQH1wK6aLvMdZ442Xhp7qDA4oy7w2vPGg0Ftku9IBTTzNO8zZPqmng
 Pu65nFXSr5rntgZucbV3VZkqxQdSd8wqOJPbS/9T6EPctWE360bG+pDrtjF8JA==
Date: Wed, 19 Nov 2025 10:41:42 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] kp_imx6q_tpc: Stop disabling device tree relocation
Message-ID: <20251119104142.5b9acb33@wsk>
In-Reply-To: <20251118180402.591115-1-trini@konsulko.com>
References: <20251118180402.591115-1-trini@konsulko.com>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 18 Nov 2025 12:04:02 -0600
Tom Rini <trini@konsulko.com> wrote:

> Remove setting of fdt_high to ~0, which disables device tree
> relocation, from the default environment. Doing so prevents U-Boot
> from correcting problems such as having an unaligned device tree and
> leads to various failure modes in the OS.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If there is some window of memory that must be used for where the
> device tree is relocated to, bootm_low + bootm_size (or often just
> bootm_size) or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.
>=20
> Cc: Lukasz Majewski <lukma@nabladev.com>
> ---
>  include/configs/kp_imx6q_tpc.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/configs/kp_imx6q_tpc.h
> b/include/configs/kp_imx6q_tpc.h index c0cb3db23e7a..e89e9601ae82
> 100644 --- a/include/configs/kp_imx6q_tpc.h
> +++ b/include/configs/kp_imx6q_tpc.h
> @@ -19,7 +19,6 @@
>  #define CFG_EXTRA_ENV_SETTINGS	\
>  	"console=3Dttymxc0,115200\0"	\
>  	"fdt_addr=3D0x18000000\0"		\
> -	"fdt_high=3D0xffffffff\0"		\
>  	"initrd_high=3D0xffffffff\0"	\
>  	"kernel_addr_r=3D0x10008000\0"	\
>  	"fdt_addr_r=3D0x13000000\0"	\

Reviewed-by: =C5=81ukasz Majewski <lukma@nabladev.com>

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Managing Director : Stefano Babic
