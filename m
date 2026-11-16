Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365D606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dixgYDoD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hQgZhUZf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04AF2607EB;
	Mon, 16 Nov 2026 23:45:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cl_ALMs2kAPq; Mon, 16 Nov 2026 23:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 363E36069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794872752;
	b=qWxQkae9ztSpYTDym4nTwF8t4YVrrC5pEbqxd7wmgXQQcVIsBTm8QFqe2Ty6ZjM2A2sX
	 8KEWEjJVMDdFwUBFPYjfftzwv0ZPw80i+i7ClTUsXF6xPyPiSXzrLJXT7nMr7QITLopFA
	 M72WO9z5Vd8Os1LjRu2S0Bqw0NncK2O5Lu/hvdzAn72nkrn7afYa/5YBdgRqfkfKOQMhv
	 FUl+JdyYzoaWQABjz7RLlfYaljGoyOT1471rl3Uuhi5yX73Jt3qK5nhRvCj3wJCjbR1O4
	 G+ol/P3t1oxTAuxQVwy7LQVgCpa3j7txiH7i0wQti+hcE8hRTBU8xKy1BlFX/tRsPJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794872752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5nfXqcRbwV+GcFRMYbyM2EyaF2O9RqbgdRpFWAZCy9s=;
	b=CQzP0ldSujKejWGko+N8yRemG/rtx/PrdG+FsFJ8LmrAsaUF7mckEhWJS5bEhoj8oiHe
	 wd6wQyhyZNPnFxA7ck8w47HfpgAXOoFnC36/lg3vPvhLp1fydwDDhnSTuw6WZIT9pnDLL
	 VDw+P7QQdwA03QO5uZibE//O0DaLHC6C5Xt0jjyITJfTraccKGuSXTMNLxLaJhqmiYC6j
	 BgI5cNhkp3VikPNwM0VqPKtciukiuSz2/my7CFu5lm/Ta2Dl4c5ZX1QdH4JmEDp5eC58J
	 C1XMbOLcT24H0viVupAWs0+eK+9D4BOfgtxvezEabgPwuvdLNpM4rj8qD6D0O9CIVNA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hQgZhUZf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794872752;
	bh=5nfXqcRbwV+GcFRMYbyM2EyaF2O9RqbgdRpFWAZCy9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dixgYDoDNw90V9+iCLUfsKfKZR+18d6f8dTM84KyKQb/4ZwQLIBvQ44+0clbbxVyQ
	 lsIK3v2qfK3I4AXiTustkvwbGNfIsYJAnDuilPZWKA5Gmsvnm+baxsuL92nI7wJgN1
	 34afNvoq7rsaCI0IskxO6x2wcTzn8i9i32Wl/iCqN6YuuxLtuzGygNffAZFzIAyc5o
	 +CO2WnKnkO2NhjBo/gPQPWGYxwU5TiL3i/IVgP1eAZ7stVs04bZ8A+ydyf+zertZLv
	 hv/eoKDVmLwaoXgu60OpL1WXByh5VRhHJ8Lsbg4LlmDlc2JmF3bYGmloCeNWIkHdLZ
	 K8gkB1/p02EOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 363E36069A;
	Mon, 16 Nov 2026 23:45:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F09D70B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DFF326069A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:45:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJ0pY3pVc4oc for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 23:45:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4D9E6067D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.11
X-Greylist: delayed 903 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 16 Nov 2026 23:45:48 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=zohomail header.b=hQgZhUZf
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.11;
 helo=sender6-op-o11.zoho.com; envelope-from=sebastian.reichel@collabora.com;
 receiver=<UNKNOWN> 
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4D9E6067D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:45:48 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=hQgZhUZflaV82y3H7yjILsRSffwZvNrwq+fU/nrumk15q98qBlCV3F7xD5ukqrYYELMY67js1phIpsPRVEB43udhS4qa15hfgczF2Bc4uzGjSDiYVaOZQbGWvE0rZUi9AFgidE4Ms6AhX/pQs+dwUwlcDuyoG+ux4sSHwAOjawg=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=5nfXqcRbwV+GcFRMYbyM2EyaF2O9RqbgdRpFWAZCy9s=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179487181550510.799819216247784; 
 Mon, 16 Nov 2026 15:30:15 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
 id D977D1805C7; Tue, 17 Nov 2026 00:30:11 +0100 (CET)
Date: Tue, 17 Nov 2026 00:30:11 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: Constify driver ops
Message-ID: <avuR5ZsHaidTXR2T@venus>
References: <20261116174446.3488393-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4vtcc4helz5zfqpy"
Content-Disposition: inline
In-Reply-To: <20261116174446.3488393-1-marek.vasut+renesas@mailbox.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.853.92
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--4vtcc4helz5zfqpy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] usb: Constify driver ops
MIME-Version: 1.0

Hi,

On Mon, Nov 16, 2026 at 06:44:42PM +0100, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Lukasz Majewski <lukma@nabladev.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/usb/gadget/dwc2_udc_otg.c | 2 +-
>  drivers/usb/musb-new/am35x.c      | 2 +-
>  drivers/usb/musb-new/musb_core.c  | 2 +-
>  drivers/usb/musb-new/musb_dsps.c  | 2 +-
>  drivers/usb/tcpm/fusb302.c        | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_=
udc_otg.c
> index 4dc049d64b1..e680cf6c64b 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -136,7 +136,7 @@ void *get_udc_gadget_private_data(struct usb_gadget *=
gadget)
>  	return gadget->dev.device_data;
>  }
> =20
> -static struct usb_ep_ops dwc2_ep_ops =3D {
> +static const struct usb_ep_ops dwc2_ep_ops =3D {
>  	.enable =3D dwc2_ep_enable,
>  	.disable =3D dwc2_ep_disable,
> =20
> diff --git a/drivers/usb/musb-new/am35x.c b/drivers/usb/musb-new/am35x.c
> index ca4d798642e..572abd2b50d 100644
> --- a/drivers/usb/musb-new/am35x.c
> +++ b/drivers/usb/musb-new/am35x.c
> @@ -666,7 +666,7 @@ static int am35x_resume(struct device *dev)
>  	return 0;
>  }
> =20
> -static struct dev_pm_ops am35x_pm_ops =3D {
> +static const struct dev_pm_ops am35x_pm_ops =3D {
>  	.suspend	=3D am35x_suspend,
>  	.resume		=3D am35x_resume,
>  };
> diff --git a/drivers/usb/musb-new/musb_core.c b/drivers/usb/musb-new/musb=
_core.c
> index 17ec0d3acbd..7856af42ba9 100644
> --- a/drivers/usb/musb-new/musb_core.c
> +++ b/drivers/usb/musb-new/musb_core.c
> @@ -205,7 +205,7 @@ out:
>  	return ret;
>  }
> =20
> -static struct usb_phy_io_ops musb_ulpi_access =3D {
> +static const struct usb_phy_io_ops musb_ulpi_access =3D {
>  	.read =3D musb_ulpi_read,
>  	.write =3D musb_ulpi_write,
>  };
> diff --git a/drivers/usb/musb-new/musb_dsps.c b/drivers/usb/musb-new/musb=
_dsps.c
> index b73f3531ce2..41d1d3db586 100644
> --- a/drivers/usb/musb-new/musb_dsps.c
> +++ b/drivers/usb/musb-new/musb_dsps.c
> @@ -508,7 +508,7 @@ static int dsps_musb_exit(struct musb *musb)
>  }
> =20
>  #ifndef __UBOOT__
> -static struct musb_platform_ops dsps_ops =3D {
> +static const struct musb_platform_ops dsps_ops =3D {
>  #else
>  struct musb_platform_ops musb_dsps_ops =3D {
>  #endif
> diff --git a/drivers/usb/tcpm/fusb302.c b/drivers/usb/tcpm/fusb302.c
> index fe93ff3d339..b77fe0fa204 100644
> --- a/drivers/usb/tcpm/fusb302.c
> +++ b/drivers/usb/tcpm/fusb302.c
> @@ -1293,7 +1293,7 @@ static int fusb302_get_connector_node(struct udevic=
e *dev, ofnode *connector_nod
>  	return 0;
>  }
> =20
> -static struct dm_tcpm_ops fusb302_ops =3D {
> +static const struct dm_tcpm_ops fusb302_ops =3D {
>  	.get_connector_node =3D fusb302_get_connector_node,
>  	.init =3D fusb302_init,
>  	.get_vbus =3D fusb302_get_vbus,
> --=20
> 2.53.0
>=20

--4vtcc4helz5zfqpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr7kgAACgkQ2O7X88g7
+prqCA//QU1XfSXeItornflnyMJndsMSUU1swL7CywZUn6ZZAJScL0MZg5HbtaKd
cV+W0cq8zqtijFu443dWyoVEzD+8oJhULarfebMpI9NPUJCGEBb4EXBoaW5vqkGG
8xy0PMmi7K+4Y52PGWWcr6wp+k3hpSXxLSMMCIIUKnlo+S66OpHcW2bYtFqC70dm
JTJuPalJ4YMreo5pRL5F1hUHDe4TF8yQ6TGRCZAsnq8g6oRD9wMG8rybV9XxKHk6
6AP074ncQRbPeMSJG8M1c8l5n4oCDSEn6oPOt4zVWuj/yrXwGVhpKUr8i4lWr/Cq
UUwtTpCTZNWzIjLY/sen5zMwDonIUjbPbkklIn5BHuZtb96VdgxvxIU5YZ7NHeNa
4c5+RotBlcbC+lohCxqXbvKCvl3RBWidEb3oGhr2wKs4G/SLfbopdEAyJcF6vzSW
YK4p3KvHteBZrcsxxZqPTvo6DXCiSFAUwGi/W63Rg4lzU7BRZSeO3F6C/LEeeszv
ubJawaeCA47Y8ipzqLdZr13o1LQlOFrvoH0bicO4UMnRef/JSGUb/zH0vxhVZChp
0GxlpZn7QYIAYyUSkxLzxuz1HyXnTfUD86I87kTMs1czssHdveiS2mQsoDhv5W36
J3e8/JwHIiVN3lLc3vlq7MGKNf6Qv5OHnKo14f9DcKiM8v41p38=
=ppsk
-----END PGP SIGNATURE-----

--4vtcc4helz5zfqpy--
