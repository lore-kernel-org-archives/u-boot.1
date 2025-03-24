Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295E3C3600C
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 11:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F1E781FE6;
	Mon, 24 Mar 2025 12:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E1682033; Mon, 24 Mar 2025 12:14:45 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7426B81F6B
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 12:14:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED64D1C14;
 Mon, 24 Mar 2025 04:14:48 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 766503F58B;
 Mon, 24 Mar 2025 04:14:41 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:14:38 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Vincent =?UTF-8?B?U3RlaGzDqQ==?= <vincent.stehle@arm.com>
Cc: <u-boot@lists.denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Adriano Cordova
 <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] efi_loader: fix ipv4 device path node conversion
Message-ID: <20250324111438.247fcba5@donnerap.manchester.arm.com>
In-Reply-To: <20250324083443.1537006-1-vincent.stehle@arm.com>
References: <20250324083443.1537006-1-vincent.stehle@arm.com>
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

On Mon, 24 Mar 2025 09:34:43 +0100
Vincent Stehl=C3=A9 <vincent.stehle@arm.com> wrote:

Hi,

Tom: I think this is v2025.04 material, as this code was introduced in
this cycle.

> When converting an IPv4 device path node to text, the
> EFI_DEVICE_PATH_TO_TEXT_PROTOCOL will produce the following string:
>=20
>   IPv4(5.6.7.8,TCP,UDP,0x6,DHCP,1.2.3.4,9.10.11.12,255.255.255.0)
>=20
> This string erroneously contains multiple protocols: TCP, UDP and 0x6.
>=20
> Add the missing `break' statements in the dp_msging() function to fix this
> and obtain the following expected string instead:
>=20
>   IPv4(5.6.7.8,TCP,DHCP,1.2.3.4,9.10.11.12,255.255.255.0)

Nice catch! Being spoiled by the picky kernel, I wondered how this could
slip through, only to realise that we don't use -Wimplicit-fallthrough.

So I enabled that, and somewhat expectedly found some issues, and fixed
them for the one build that I tried for now. Will send a series later.

> Fixes: aaf63429a112 ("efi_loader: add IPv4() to device path to text proto=
col")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  lib/efi_loader/efi_device_path_to_text.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/ef=
i_device_path_to_text.c
> index f6889cb7399..452ec1b2e8b 100644
> --- a/lib/efi_loader/efi_device_path_to_text.c
> +++ b/lib/efi_loader/efi_device_path_to_text.c
> @@ -181,10 +181,13 @@ static char *dp_msging(char *s, struct efi_device_p=
ath *dp)
>  		switch (idp->protocol) {
>  		case IPPROTO_TCP:
>  			s +=3D sprintf(s, "TCP,");
> +			break;
>  		case IPPROTO_UDP:
>  			s +=3D sprintf(s, "UDP,");
> +			break;
>  		default:
>  			s +=3D sprintf(s, "0x%x,", idp->protocol);
> +			break;
>  		}
>  		s +=3D sprintf(s, idp->static_ip_address ? "Static" : "DHCP");
>  		s +=3D sprintf(s, ",%pI4", &idp->local_ip_address);

