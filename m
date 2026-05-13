Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C2BCD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F596836AC;
	Wed, 13 May 2026 13:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hERBTR+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7586683FB0; Wed, 13 May 2026 13:45:54 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B8C580F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 92DB643450;
 Wed, 13 May 2026 11:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB1AC2BCB7;
 Wed, 13 May 2026 11:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778672748;
 bh=r9zutWIJwrf4DyEq5+MvjdT4IinnpysG1WTf9lpEeyY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hERBTR+YsAq9fWz69w10KAtC4M8M6HEK2f24EJpZlSHxksvYg4rIZEkTOhlf9NTAl
 f9L+651odxnPwLGhs21ha4ZDScfEpGjQmsyL7zahW93++CYrxeWP9kGCiCtSRxl6CI
 dVMFuF9a8YyZrsXM4qRCo0HFvYIJ4CD0nB3MhNlvTRg9tUSxNvVWkOK56wVSvNuAdK
 Q0mZvJODT2BNUCW8tow/TU96ueZGXur3xnQzVLA/cQDNqCb1skRF1FqM89BPnuH/JN
 HvRaLRFxue10654iOUOjno741Jqi8EvUCOtV67s67AvIZ53le8CSMeaW87oPDHTFPT
 o9qY0UAw2bHOA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
 u-boot@lists.denx.de
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, =?utf-8?Q?=C5=81ukasz?=
 Stelmach <l.stelmach@samsung.com>
Subject: Re: [PATCH] fastboot: read fastboot buffer address from
 fastboot_addr_r
In-Reply-To: <20260430201503.320359-1-l.stelmach@samsung.com>
References: <CGME20260430201556eucas1p21ad12913ce5c83e8bf5cef3c4f50d81b@eucas1p2.samsung.com>
 <20260430201503.320359-1-l.stelmach@samsung.com>
Date: Wed, 13 May 2026 13:45:45 +0200
Message-ID: <87bjejv8gm.fsf@kernel.org>
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

Somehow, I was not in copy of this email so I could have missed it.
Please make sure to run get_maintainer.pl next time you submit something.

$ ./scripts/get_maintainer.pl -f drivers/fastboot/

See:
https://docs.u-boot.org/en/latest/CONTRIBUTE.html#contributions

On Thu, Apr 30, 2026 at 22:14, =C5=81ukasz Stelmach <l.stelmach@samsung.com=
> wrote:

> Following the previous advice (link below) check fastbooot_addr_r

fastbooot -> fastboot

> environment variable for fastboot buffer address.
>
> Link: https://lore.kernel.org/u-boot/aWiWFrdwvy7-IK63@sumit-xelite/
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/fastboot/fb_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 68f92c4b887..4579f30b52e 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -226,7 +226,9 @@ void fastboot_set_progress_callback(void (*progress)(=
const char *msg))
>   */
>  void fastboot_init(void *buf_addr, u32 buf_size)
>  {
> -	fastboot_buf_addr =3D buf_addr ? buf_addr :
> +	void *_buf_addr =3D (void *)env_get_hex("fastboot_addr_r", 0);
> +
> +	fastboot_buf_addr =3D buf_addr ? buf_addr : _buf_addr ? _buf_addr :
>  				       (void *)CONFIG_FASTBOOT_BUF_ADDR;

Please also have a look at Quentin's suggestion:
https://lore.kernel.org/all/453e3e7f-e975-42a6-9f44-5aaa9a5fd03f@cherry.de/

>  	fastboot_buf_size =3D buf_size ? buf_size : CONFIG_FASTBOOT_BUF_SIZE;
>  	fastboot_set_progress_callback(NULL);
> --=20
> 2.47.3
