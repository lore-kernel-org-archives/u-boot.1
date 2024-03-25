Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596A2C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 17:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAD187C69;
	Mon, 25 Mar 2024 18:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VvtBDxBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86E583346; Mon, 25 Mar 2024 18:37:43 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B27487C69
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 18:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 904AD6112A;
 Mon, 25 Mar 2024 17:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860EBC43390;
 Mon, 25 Mar 2024 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711388260;
 bh=B2Z0l0I/Xpaksylqevo5yj46pKpLrrcTwRqKDApcf5I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VvtBDxBj9bIIGgQUnSmI7y77bm7fstyPRdQShUo6ztGjFXyohyaxdYO/DKp4LL55h
 Y638R6XMpARawE8lBWIZzzSuiHHSM+nsd6i5VIsu7rZH4s2C1I/G28BAQoFXxLPlWU
 JsZLKHLFNaEEblVtxhGopvh9gb3wuDSQk2StXFlGin00SONZAuc3XrBW140ahg+aLN
 YydYRMDNQ2xkPiqO5U+2lZHCRM3SftZkwbO2b6jTqli7iBW9xib2ZJbgROaFbzExxs
 zH286BxRrqBABOSjJPsp4939tgDoQTq3bPTxOY8A10iy3dVpsRK9aDAsjMbKELQwYX
 UOXsnikk38t3g==
Date: Mon, 25 Mar 2024 18:37:35 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH u-boot-mvebu v2 06/18] arm: mvebu: turris_omnia: Print
 board ECDSA public key if available
Message-ID: <20240325183735.6cfa2244@dellmb>
In-Reply-To: <20240323180711.5498-7-kabel@kernel.org>
References: <20240323180711.5498-1-kabel@kernel.org>
 <20240323180711.5498-7-kabel@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
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

On Sat, 23 Mar 2024 19:06:59 +0100
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> If MCU supports the FEAT_CRYPTO feature, read board ECDSA public key
> from MCU and print it.
>=20
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> ---
>  board/CZ.NIC/turris_omnia/turris_omnia.c | 25 +++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turr=
is_omnia/turris_omnia.c
> index f63640ad64..896c14bb99 100644
> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> @@ -253,6 +253,24 @@ static int omnia_mcu_board_info(char *serial, u8 *ma=
c, char *version)
>  	return 0;
>  }
> =20
> +static int omnia_mcu_get_board_public_key(char pub_key[static 67])
> +{
> +	u8 reply[34];
> +	int ret;
> +
> +	ret =3D omnia_mcu_read(CMD_CRYPTO_GET_PUBLIC_KEY, reply, sizeof(reply));
> +	if (ret)
> +		return ret;
> +
> +	if (reply[0] !=3D 33)
> +		return -EBADMSG;
> +
> +	bin2hex(pub_key, &reply[1], 33);
> +	reply[66] =3D '\0';

Aargh, this should be pub_key[66] =3D '\0'.

And I noticed once more thing, so I will sent another version.
