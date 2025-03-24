Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F322FC36005
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 11:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF93881F71;
	Mon, 24 Mar 2025 12:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7FD81FBC; Mon, 24 Mar 2025 12:02:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9B0A381F6B
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 12:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21F4C1A2D;
 Mon, 24 Mar 2025 04:02:51 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 132083F58B;
 Mon, 24 Mar 2025 04:02:43 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:02:34 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Vincent =?UTF-8?B?U3RlaGzDqQ==?= <vincent.stehle@arm.com>
Cc: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Jason Jin
 <jason.jin@freescale.com>
Subject: Re: [PATCH] ata: ahci: remove bad free
Message-ID: <20250324110234.24a2443b@donnerap.manchester.arm.com>
In-Reply-To: <20250324083406.1536773-1-vincent.stehle@arm.com>
References: <20250324083406.1536773-1-vincent.stehle@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 24 Mar 2025 09:34:06 +0100
Vincent Stehl=C3=A9 <vincent.stehle@arm.com> wrote:

> In the case of a memory allocation error, the ahci_port_start() function
> tries to free the `pp' pointer.
> This pointer was not dynamically allocated but does in fact point to an
> element of the port[] array member of the struct ahci_uc_priv.
> Remove the erroneous call to free() to fix this.

I think free() doesn't do much (harm) in U-Boot, but it's definitely not
right here. I see one malloc() in this driver (for ataid[port]), for which
I cannot find the corresponding free(), but this is a separate issue, and
this patch here is fine.

> Fixes: 4782ac80b02f ("Add AHCI support to u-boot")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> Cc: Tom Rini <trini@konsulko.com>
> Cc: Jason Jin <jason.jin@freescale.com>
> ---
>  drivers/ata/ahci.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 8058d5ff1c3..e593e228685 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -463,7 +463,6 @@ static int ahci_port_start(struct ahci_uc_priv *uc_pr=
iv, u8 port)
> =20
>  	mem =3D memalign(2048, AHCI_PORT_PRIV_DMA_SZ);
>  	if (!mem) {
> -		free(pp);
>  		printf("%s: No mem for table!\n", __func__);
>  		return -ENOMEM;
>  	}

