Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD53C369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 12:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761CA8209C;
	Mon, 14 Apr 2025 14:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bamGRwjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED8CD82075; Mon, 14 Apr 2025 14:22:33 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFAE8209C
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 14:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 30EB0A49DBC;
 Mon, 14 Apr 2025 12:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE498C4CEE2;
 Mon, 14 Apr 2025 12:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744633350;
 bh=UBk584GPyErYtVr5Vs6fQhzhDS/mUSo9HwAOpZvUkZY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=bamGRwjnJ8qkM5hQdHPHRK/GRr869NK8tJU4vMmegFMpCEshpyoPOyT6HmWPZYokd
 P1+U1VRrNhXD//QRcnXSA98CeN7p9vusg5LGMtpCd8TQmzT169pMrp/9nS9BpXhZPi
 Ukv0EU86IWQ5fcE2D9/x4AkEdRx7qlYHSRsQnHjJ7bbrXgbaVXkk0xL3NRbPYdpzVY
 YY/Yr5oFStAVmvzLZoUP8B+xzO5Yn5vvN932jpUN/LNIiS6d4hQCw1FZouOM9b9lit
 nqOVIqehkaFVTZpzuOfwqMB6RGFYz+RxlylqMtjQCWk5QdYFFu7a+1aRXgYmyHyOT+
 3dif6xVo218VQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>, Jassi Brar
 <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/5] fwu: developerbox: fix dfu alt buffer clearing
In-Reply-To: <20250407170529.893307-2-vincent.stehle@arm.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
 <20250407170529.893307-2-vincent.stehle@arm.com>
Date: Mon, 14 Apr 2025 14:22:28 +0200
Message-ID: <87sembc4qj.fsf@kernel.org>
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

Hi Vincent,

Thank you for the patch.

On lun., avril 07, 2025 at 19:05, Vincent Stehl=C3=A9 <vincent.stehle@arm.c=
om> wrote:

> The set_dfu_alt_info() function calls the ALLOC_CACHE_ALIGN_BUFFER()
> macro to declare a `buf' variable pointer into an array allocated on the
> stack. It then calls the memset() function to clear the useable portion
> of the array using the idiomatic expression `sizeof(buf)'.
>
> While this would indeed work fine for an array, in the present case we
> end up clearing only the size of a pointer.
> Fix this by specifying the explicit size `DFU_ALT_BUF_LEN' instead.
>
> Fixes: 6b403ca4dcf4 ("fwu: DeveloperBox: add support for FWU")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  board/socionext/developerbox/fwu_plat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/socionext/developerbox/fwu_plat.c b/board/socionext/de=
veloperbox/fwu_plat.c
> index 26031795b09..a8b111477ef 100644
> --- a/board/socionext/developerbox/fwu_plat.c
> +++ b/board/socionext/developerbox/fwu_plat.c
> @@ -18,7 +18,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>  	struct mtd_info *mtd;
>  	int ret;
>=20=20
> -	memset(buf, 0, sizeof(buf));
> +	memset(buf, 0, DFU_ALT_BUF_LEN);
>=20=20
>  	mtd_probe_devices();
>=20=20
> --=20
> 2.47.2
