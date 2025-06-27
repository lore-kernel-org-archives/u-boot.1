Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7DAC7EE30
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 01:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6BEF82B34;
	Fri, 27 Jun 2025 03:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="e/jpiV7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7833D82C65; Fri, 27 Jun 2025 03:33:25 +0200 (CEST)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D08D280C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 03:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750987995; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iZj/B5wUHo7WLAjPgtZwu15duSFU0TYfJhzIZeI9Fz1uXOZSIPrIwhKBEpbIxd92jwE7RUxtsDAgXghrIw4U79FTgh1LoOG9rSfhlvQWGtXL0ply9xdYGleM32/7eBi/eqSyU5o6uxZa0o8sr3yT8ikfKGLplXt4nNl05DWs7b8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1750987995;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=TPqmloFqBKZdtn5hTnWzgtRaPv2zPNWzDwhfbnheybw=; 
 b=nIku3thmn4TySdUhsE4i9Gqp+begB+krKMuFqqVmATeW3lzEiY73vAb6pzwdpSLtap6GxQOBH77O3H6+6UzNhG2f0mNpMhAQfDnF5XihAUcauou8OBOMDHTpDxo0tvr2p4MKzW5K+RMj7/loOmH5tq2fK12sub8EnIZD1a4veM0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750987995; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=TPqmloFqBKZdtn5hTnWzgtRaPv2zPNWzDwhfbnheybw=;
 b=e/jpiV7n1hUKMLwQdNfrTR2xHuHKC5XJoLFx5lyWIyik50x7zcbV2ojMWuL6iYRS
 Y7Ou8Pfh7cra8EHwiCF9J6zEV9lAAppWrWpQQNPthndZX8zrHqxswDzEd4TmLNrFZUw
 AXnEjjizC7Pw1wEqU1EP0T/AHdfHf8aodiBfq4BM=
Received: by mx.zohomail.com with SMTPS id 1750987992270146.4674960293919;
 Thu, 26 Jun 2025 18:33:12 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id B74871809B7; Fri, 27 Jun 2025 03:33:08 +0200 (CEST)
Date: Fri, 27 Jun 2025 03:33:08 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Wang Jie <dave.wang@rock-chips.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] tcpm: fix pd_transmit poll condition
Message-ID: <n4seevp44ipfmhnzbrsbxa7qumbut6r3qghz7phvbxslb4lg5v@55lr2ywdw377>
References: <20250526-topic-tcpm-tx-poll-cond-v1-1-38a81560ffff@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vflalam6op2bvrkz"
Content-Disposition: inline
In-Reply-To: <20250526-topic-tcpm-tx-poll-cond-v1-1-38a81560ffff@linaro.org>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.963.58
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


--vflalam6op2bvrkz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tcpm: fix pd_transmit poll condition
MIME-Version: 1.0

Hi,

On Mon, May 26, 2025 at 09:42:53AM +0200, Neil Armstrong wrote:
> The read_poll_timeout() exit "cond" parameter wait for a complete
> transmit state.
>=20
> The "!tx_complete" cond means that on the first tcpm_transmit_helper()
> call, if the tx_complete returns to false, the poll loop would exit.
> But since at probe the tx_status is left at 0, the tx is considered
> as successful. And then later the proper status is returned and
> ignored.
>=20
> But if on the first tcpm_transmit_helper() call the TX status is
> returned the read_poll_timeout() would return in timeout and the
> negociation would fail.
>=20
> Fixes: 1db4c0ac77e ("usb: tcpm: add core framework")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Good catch!

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/usb/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
> index 0aee57cb2f4a44af7b483e0e609e39ba584a06c0..c8679615cd7701982b64b1905=
c5822ac98ed6f79 100644
> --- a/drivers/usb/tcpm/tcpm.c
> +++ b/drivers/usb/tcpm/tcpm.c
> @@ -209,7 +209,7 @@ static int tcpm_pd_transmit(struct udevice *dev,
>  	 */
>  	timeout_us *=3D 5;
>  	ret =3D read_poll_timeout(tcpm_transmit_helper, tx_complete,
> -				!tx_complete, false, timeout_us, dev);
> +				tx_complete, false, timeout_us, dev);
>  	if (ret < 0) {
>  		dev_err(dev, "TCPM: PD transmit data failed: %d\n", ret);
>  		return ret;
>=20
> ---
> base-commit: bab54f5942c428be698216224fd10b91d974d4da
> change-id: 20250526-topic-tcpm-tx-poll-cond-8dd3ebbbeddc
>=20
> Best regards,
> --=20
> Neil Armstrong <neil.armstrong@linaro.org>
>=20

--vflalam6op2bvrkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhd9M8ACgkQ2O7X88g7
+pqN/A/8CvZ6zQXZd0Qof6DYupDkCPRezNqXrklIzDRJOJbz0kWE9KjNYsh+kGow
JcHRrSdj+LHpX7A0kpODQTEhqavHKrPlW9peN3kQ/Dc7Scp8j/IuOWiQmGQJS+nl
a4Lz/+DmLp0P0o+pNKN35xhhtlR8nSol6BqaYFKlFcEnCUtRhLZ3fSjy0iyns8F0
RAcHq4kDS6jt2v3p1SoPB6pPk7+AUZSrPpOGyUYB5nSpeh9j4n6s68v9ocyf6b7p
Hl0uNzLfOmz56R/pXrzIOmcocvMl6vNb9pL/HXha4vGMp0nYWBfJqGjmIFkf/WLJ
PvPQ2QvSe+O1lWordSlSTqdrXYkR6Bo7xcA4x6MOqwekKLv9YV5PWXZC6amJ9Pmn
qgVsC8f8n7rrCALFfxKgbrQYTlJqGlgVb1zRlitEcpp21CUGCxNrYSYjcMvB4mGs
cq/h92k/UxH8I6NT1fKVzR4ExGhJjjPUfQv1KqUjtLoATKXDp95LuuFhsf+b974z
QVbEd80X8echQa6fBs2KuLXr/H0O/41FVCD9lvJ4YpcPfaCIiuNYON0lFcry7C3c
uZ+JwOwVToJKwApZAj73IU6b/kLXVIKw1cNTu86xJ+gzzcnS0OgXKby2dHOm1zq8
mPJiaBkNefcOMEFfjx7u3jIfvIiHm6eWVLY0RkbUgLRAK6anfUs=
=WA3W
-----END PGP SIGNATURE-----

--vflalam6op2bvrkz--
