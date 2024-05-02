Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31630C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 08:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD8888CA4;
	Thu,  2 May 2024 10:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fvH0FDIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54FAC88CF6; Thu,  2 May 2024 10:23:52 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4103C88C67
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 10:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714638229;
 bh=LZXmRonkuqbBnCgQSlu5tSe/2a0K41oQtiwCY0qr1dI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=fvH0FDIrStHDg0T3F4bDXRPEyiBvqY93B5KlXtfASwTHyA7PkLQNlOp7nBT/RFNn0
 DSHZK4qR+J4ffVwhy6UqianIqnSwK2DxFR0XPzBV/4z8r7B5TxbZkD7/c7pLibZCyb
 yfc2ddxe31DEZHLfZDxJ1wKXF5G+NPuZwEEFbpj9nVpo6Wlhfay1UYeNaPr40VZFkJ
 r56sR1nQ3WBHN6lqTcmqUdoDN8tywLAMGN/SS/T3SsEAPJqDCxk31wPAlx48I+xKFQ
 oz0U88dvudwVn9Iig3ZNJH94Iauu7oq4YfblSifjwaAOPIrXz2ckJkZaieqGy0zdyA
 05ETW/FjBUVAA==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E71D3781013;
 Thu,  2 May 2024 08:23:49 +0000 (UTC)
Message-ID: <2605366dadf08aac1b4fc1701b807b44aaebb0d1.camel@collabora.com>
Subject: Re: [PATCH v2 22/22] rockchip: rk3399: Drop ethernet0 alias from
 SoC u-boot.dtsi
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, Peter Robinson <pbrobinson@gmail.com>, 
 u-boot@lists.denx.de
Date: Thu, 02 May 2024 09:23:47 +0100
In-Reply-To: <20240501162308.875193-23-jonas@kwiboo.se>
References: <20240501162308.875193-1-jonas@kwiboo.se>
 <20240501162308.875193-23-jonas@kwiboo.se>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1+b3 
MIME-Version: 1.0
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

Hi Jonas,

On Wed, 2024-05-01 at 16:22 +0000, Jonas Karlman wrote:
> Remove the obsolete ethernet0 alias now that all board device tree files
> have been fully synced with Linux kernel v6.8.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Looks good to me.

Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>

> ---
> v2: New patch
> ---
> =C2=A0arch/arm/dts/rk3399-u-boot.dtsi | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-
> boot.dtsi
> index 6af9621ac3d0..b6b43271172e 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -6,7 +6,6 @@
> =C2=A0
> =C2=A0/ {
> =C2=A0	aliases {
> -		ethernet0 =3D &gmac;
> =C2=A0		mmc0 =3D &sdhci;
> =C2=A0		mmc1 =3D &sdmmc;
> =C2=A0		pci0 =3D &pcie0;

