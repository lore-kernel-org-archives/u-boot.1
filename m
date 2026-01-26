Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37118D1951A
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 22:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB37A83BFE;
	Mon, 26 Jan 2026 23:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="VJSoIn4w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1ACA83EC8; Mon, 26 Jan 2026 23:09:25 +0100 (CET)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D3183B27
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 23:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1769465358; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j9d+5eDDipTTwqcsgp0Y7xsfvZ4LEME5sP+FdSgnjXxvnFln04oXsCTloOjXR7AJzkz1S1k31CmnEvUTJ2THnlRykCBC0YonQz6H4Hli45onkKI5hsJmdZahXMUbYCUQLyrKz7vK+vTwAi2BD119J+csHmhuxH7DTMWim9ixJ3U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769465358;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=34EG9uRSG0iytRQzUA9VWKmq/B8ZtSUjTQcQGm58oAQ=; 
 b=HfsB50s8wspQYj7PkCxzGMyNw2ekstgCGXAAt4p2CnMt2Q7j6BDwuzNnH+O3bYPxbAkb8C9FOg3+WdRiyvXkZfinvhoL+mep6+xx5YRdjL2PZ0o+rly7VuNRq/TW09b+7Omk4B8qqaivRSRKUGw208OEhukRybSgPkwhNHL6ByU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769465358; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=34EG9uRSG0iytRQzUA9VWKmq/B8ZtSUjTQcQGm58oAQ=;
 b=VJSoIn4wFr0X+Aktb+Dd8YxsOoL8Hc1z4+K8EzVAjT/hJzHbqnOiCTvrTBmFwNMd
 M7Y1NfrSkRrERg7xYS4tvTEVH8a33pUm+jLSQtG0jxkLCQa4/4lwQo1WBuS8OiVVurd
 3gtiAmV5ZWsIP3LhFObeY5yNZTgJXduaARMgAojY=
Received: by mx.zohomail.com with SMTPS id 1769465356188507.9300255083805;
 Mon, 26 Jan 2026 14:09:16 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
 id 336E2180B13; Mon, 26 Jan 2026 23:09:13 +0100 (CET)
Date: Mon, 26 Jan 2026 23:09:13 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Remove USB-C controller from
 u-boot.dtsi
Message-ID: <aXfl19X8PMzlEARg@venus>
References: <20260126215601.837587-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jlwwszfca75jhz57"
Content-Disposition: inline
In-Reply-To: <20260126215601.837587-1-jonas@kwiboo.se>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.5.1/269.427.30
X-ZohoMailClient: External
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


--jlwwszfca75jhz57
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Remove USB-C controller from
 u-boot.dtsi
MIME-Version: 1.0

Hi,

On Mon, Jan 26, 2026 at 09:55:59PM +0000, Jonas Karlman wrote:
> The commit 12049db76437 ("rockchip: rk3588-rock-5b: Add USB-C controller
> to u-boot.dtsi") added the USB-C controller node to the ROCK 5B board
> u-boot.dtsi, this and related usb nodes are now part of upstream DT.
>=20
> Remove the upstream USB-C controller related DT nodes from u-boot.dtsi,
> keep usbc0 status =3D "okay" to keep USB-C power delivery working.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 43 +------------------------
>  1 file changed, 1 insertion(+), 42 deletions(-)
>=20
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk358=
8-rock-5b-u-boot.dtsi
> index e07b549c767f..ddc177344ebd 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -19,33 +19,6 @@
>  	bootph-some-ram;
>  };
> =20
> -&i2c4 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&i2c4m1_xfer>;
> -	status =3D "okay";
> -
> -	usbc0: usb-typec@22 {
> -		compatible =3D "fcs,fusb302";
> -		reg =3D <0x22>;
> -		interrupt-parent =3D <&gpio3>;
> -		interrupts =3D <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
> -		pinctrl-names =3D "default";
> -		status =3D "okay";
> -
> -		usb_con: connector {
> -			compatible =3D "usb-c-connector";
> -			label =3D "USB-C";
> -			data-role =3D "dual";
> -			power-role =3D "sink";
> -			try-power-role =3D "sink";
> -			op-sink-microwatt =3D <1000000>;
> -			sink-pdos =3D
> -				<PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>,
> -				<PDO_VAR(5000, 20000, 5000)>;
> -		};
> -	};
> -};
> -
>  &saradc {
>  	bootph-pre-ram;
>  	vdd-microvolts =3D <1800000>;
> @@ -63,20 +36,6 @@
>  	};
>  };
> =20
> -&u2phy0 {
> -	status =3D "okay";
> -};
> -
> -&u2phy0_otg {
> -	status =3D "okay";
> -};
> -
> -&usbdp_phy0 {
> -	status =3D "okay";
> -};
> -
> -&usb_host0_xhci {
> -	dr_mode =3D "peripheral";
> -	maximum-speed =3D "high-speed";
> +&usbc0 {
>  	status =3D "okay";
>  };
> --=20
> 2.52.0
>=20

--jlwwszfca75jhz57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAml35gUACgkQ2O7X88g7
+pqTGhAAgMMvpI2pA2Xwliz/8UR93eDMTwdDqHSi5mf3PqGrsu3skYR14DauD4IP
E7I0H4Ls3tAArTimDQFmMZjAUyTz3jZbqwcX9WVR/41IPxAlfpDfXDIq+BH30Ngp
QR8gkMLWjKFVltym4vylhJCsVfdWrXTAI9cH/T36kZ3tkA0QWjK5esnj8sYszj9i
8DrWjtaoJpwO3RLUO/rCuSxi33k823j1jw6mKqCg50goPreJKt/JSaHYzVu3Y+Hw
t8/5N+5bdg/JG+C8ege+bTstPcY9bzSSdpo4BK2uJxQ2ok6DEt2Crp1z/6HCfM3F
SQqV/vnwOem5MLhQPFQ2A/jEEKaPO4y5Fa1QnTvgrf8FGguPffPBPFem2VDNK0lB
C2T3uHCqseJkRf/3wxzMJn+hsoY8Z0nBkboBwi4r01QJxFzwMKtRTJ0t9QVYSK0/
MIHv7LACKoAok49hyMMiH8ZbqO5+ZK/vGAfrp9ZSYn1ESTlTamMqhZNOpDPfSLpw
i8EtxK1LNgo/EzFSwLG/V3JzBmO/lb9siSYwD08vgfr2hSzyS3D86dSwCliCKqn7
Gw/U/FSu+mB6dfm6UUZWesq01ddhv/L8RHRLSLR75rCDPnxoYJFp4kCfLoTO5zSN
81QOohmD/VNyWDHNWE6eY+ifjrgsKwWdaW0+tiJSjCOkVMF888Q=
=hIMt
-----END PGP SIGNATURE-----

--jlwwszfca75jhz57--
