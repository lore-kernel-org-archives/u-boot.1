Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E73C53209
	for <u-boot@archiver.kernel.org>; Sun, 26 Jul 2026 22:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50A6280C55;
	Sun, 26 Jul 2026 22:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rh1JR8-GZj6D; Sun, 26 Jul 2026 22:45:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2270280C84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785105904;
	bh=V2VbZsmQGgXZaesJ7OXo9dYePUe5GiksOujcHNvTD74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FTUlrcO0UHlZ5a6RLXdoE6eEXMRj2EysBLH8AIEBbW9Ck4MwdgV4pfgGLj90pPSxO
	 Djvtq6n/h9td5oRztKVvz8QRifAX/vxEBe4PJGQ7zOjQwJc0zNiQ4g6wCxP7US8UkN
	 /SjQnqkm5T0f0Mwzsr/muQ8U8Ju/jTPAojN/DozB60vOBLnk2vyBjqIhMyz6VJafoj
	 Kv+AuwUrRv+yLccz/vCdpG4QfkoPxP0qbXOZiH6x8JaqPhQRN58LfMAw8HBwAbkGhk
	 U7wP4PGSdpg5eUqkWbcT9+DRItBAdH9pWnBWakyW86OmA7L8bwDESlvADoGJTpxU/c
	 t/47dhtqWt1yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2270280C84;
	Sun, 26 Jul 2026 22:45:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6749C357
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 22:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 441C840623
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 22:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k5gIJqvA-6m9 for <u-boot@lists.u-boot-project.org>;
 Sun, 26 Jul 2026 22:45:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CB5664061D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB5664061D
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB5664061D
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 22:45:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 398F4143D;
 Sun, 26 Jul 2026 15:44:55 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBE593F66F;
 Sun, 26 Jul 2026 15:44:57 -0700 (PDT)
Date: Mon, 27 Jul 2026 00:41:06 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: "=?UTF-8?B?U8O2cmVu?= Hantel" <fugininsane@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?B?U8O2cmVu?= Hantel <fugininsane@googlemail.com>, Omar Ivan
 Fardjoume <ivan.fardjoume@gmail.com>
Subject: Re: [PATCH] mmc: sunxi: Fix mod clock register offset for the A80
Message-ID: <20260727004106.47219647@ryzen.lan>
In-Reply-To: <20260722162126.2790195-1-fugininsane@googlemail.com>
References: <20260722162126.2790195-1-fugininsane@googlemail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785105899; bh=F0NaGWKmB7puUH7VFDHHfBaCzP75nrfr6No77ph4Gxo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LsQ97gSFrmevis4TUHC+29mvETZHBt0SJDT0+kz2H9apaiLS16hNb5++mvF4eeX3m
 waPPOW2Wbct2mx8kLwROOUvMSPUja07oXZ/uHQjJqNfwjKfKlV30Dzjb3wsDhFOHvS
 Ov+TpX+YdIRKRiUqcfTuHJudfTxj3rKUNjj9SlMY=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=LsQ97gSF
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 22 Jul 2026 18:21:26 +0200
"S=C3=B6ren Hantel" <fugininsane@gmail.com> wrote:

Hi S=C3=B6ren,

I just realised why this problem was so familiar: Omar had sent
basically the same patch in April[1], and I queued it for the next merge
window (which is now).
[1]
https://lore.kernel.org/u-boot/CAM+fx6Ny0ncWr=3D6nxTWpy_VpaRj-R4pkU_fNcVEdK=
-B35O4GSg@mail.gmail.com/T/#u

So apologies, but this means that Omar's patch wins.
Many thanks for caring and sending the patch upstream. It looks
like the A80 still lacks some functionality, so there should be more
opportunities to contribute.

Cheers,
Andre

> get_mclk_offset() checks CONFIG_MACH_SUN9I_A80, but no such Kconfig
> symbol exists - the A80 is covered by CONFIG_MACH_SUN9I. The check
> therefore always fails and the function falls through to the default
> offset 0x88, which lies in a reserved region of the A80 CCU. All mod
> clock writes from U-Boot proper end up there and are silently lost,
> so the SD/MMC controllers keep running at whatever clock the
> SPL/BROM left behind.
>=20
> For the eMMC on SDC2 that means card identification runs at the
> ~48 MHz the SPL used for loading U-Boot instead of 400 kHz: short
> responses still limp along, but long (R2) responses are received as
> all-ones, CMD2/ALL_SEND_CID fails and mmc_init() returns -110. This
> went unnoticed for years because the SPL uses the legacy code path
> with a hardcoded mclk address, so booting *from* eMMC still worked -
> only U-Boot proper could never access the eMMC on sun9i.
>=20
> Use the correct Kconfig symbol so the mod clock writes reach the SDC
> clock registers at CCU offset 0x410.
>=20
> Tested on a Cubietech Cubieboard4: eMMC identification now succeeds
> and distro boot from the eMMC works.
>=20
> Fixes: 0237b3047e25 ("mmc: sunxi: Refactor mod clock register offset")
> Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
> Signed-off-by: S=C3=B6ren Hantel <fugininsane@googlemail.com>
> ---
>  drivers/mmc/sunxi_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
> index e28c81af..623393fc 100644
> --- a/drivers/mmc/sunxi_mmc.c
> +++ b/drivers/mmc/sunxi_mmc.c
> @@ -663,7 +663,7 @@ static const struct dm_mmc_ops sunxi_mmc_ops =3D {
> =20
>  static unsigned get_mclk_offset(void)
>  {
> -	if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
> +	if (IS_ENABLED(CONFIG_MACH_SUN9I))
>  		return 0x410;
> =20
>  	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCA=
T2))

