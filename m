Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B26CD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6787083EEF;
	Mon,  8 Jun 2026 11:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="llOhsdVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB928405A; Mon,  8 Jun 2026 11:14:58 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD1E807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C809E6001D;
 Mon,  8 Jun 2026 09:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7211F00893;
 Mon,  8 Jun 2026 09:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780910094;
 bh=TZnhKJ+T3Yj8TwDTvNPg6KPIe83XZCX4Etn0dWyfiP8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=llOhsdVkW04l8xEqjDJQJf1briFddZK1Wf/z6EZ/LJCgIGQO0Q9bMj6jg1FpcacMV
 rb2mc7K0vVq88Y4F6gLsI8zOxyMgzBtQCI92cMjfIjeIe/OlgY7zKY8woxZ1LmdQkF
 dBwatkg+mesfzzXzVObuAy79vbuo5KZWVYMqhf38ZcEiXHalP+Eb8UUqmIPpPNlgwu
 TM06fclDqXQepI6oPNih3/q0wPjbR1z+y8q46ti0fNOFgxZ2JWGn5ZQj8PItBpzQKS
 2hGSC6i3MQbBSxIe6hJ37Ry3wbCTGbDRLXtwEzywKRVzjluEGtKIkXd2uzICiInTR0
 Ull99+p9l4L9w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>, Mattijs
 Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, Quentin Schulz
 <quentin.schulz@cherry.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, =?utf-8?Q?=C5=81ukasz?=
 Stelmach <l.stelmach@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] fastboot: read fastboot buffer address from
 fastboot_addr_r
In-Reply-To: <20260521105728.605496-1-l.stelmach@samsung.com>
References: <CGME20260521105819eucas1p18eab88ecd16fe3563eb8717324e77dba@eucas1p1.samsung.com>
 <20260521105728.605496-1-l.stelmach@samsung.com>
Date: Mon, 08 Jun 2026 11:14:51 +0200
Message-ID: <87fr2xxuk4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi =C5=81ukasz,

Thank you for the patch.

On Thu, May 21, 2026 at 12:57, =C5=81ukasz Stelmach <l.stelmach@samsung.com=
> wrote:

> Following the previous advice (link below) check fastboot_addr_r
> environment variable for fastboot buffer address.
>
> Link: https://lore.kernel.org/u-boot/aWiWFrdwvy7-IK63@sumit-xelite/
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>

Sorry for the late review.

The change looks fine, but this new environment variable should be added
to the docs as well:
https://docs.u-boot.org/en/latest/android/fastboot.html

Please add a small sub-section in doc/android/fastboot.rst
under "Fastboot environment variables".


> ---
>  drivers/fastboot/fb_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Changes in v2:
>
> * replaced the nested ternary operator with the parameterised call to
>   env_get_hex()
>
> * fixed a typo in the commit message
>
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 9c52e004588..f2f063ebfbb 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -240,7 +240,7 @@ void fastboot_init(void *buf_addr, u32 buf_size)
>  #endif
>=20=20
>  	fastboot_buf_addr =3D buf_addr ? buf_addr :
> -				       (void *)CONFIG_FASTBOOT_BUF_ADDR;
> +		(void *)env_get_hex("fastboot_addr_r", CONFIG_FASTBOOT_BUF_ADDR);
>  	fastboot_buf_size =3D buf_size ? buf_size : CONFIG_FASTBOOT_BUF_SIZE;
>  	fastboot_set_progress_callback(NULL);
>=20=20
> --=20
> 2.47.3
