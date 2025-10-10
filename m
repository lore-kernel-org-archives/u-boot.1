Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF97ECCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 17:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0840483FB0;
	Fri, 10 Oct 2025 19:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="c0QEBe/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FC883FCB; Fri, 10 Oct 2025 19:28:50 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AB683FAA
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 19:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760117327; x=1760722127; i=xypron.glpk@gmx.de;
 bh=a4XaWnI4uoHvcLJnwPLv0+nwNLX0MpPvJcxQButMZZE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=c0QEBe/O55Jj03fiL0ngZdKa+lWfDpYD92Jq0Atsazf4UF9UqXRBL3vKreEcKKyZ
 t9n663LsxbP5WMf5FJ25ioo8rOAghlM5aqrnaeXVHgdtog71LqBx1fEYwoYwiAH28
 aF3iKrRXany2iNJbDWyzdQGBc3ploo0D8DncY4eR/drhZsMksL9LLabCB+jShGgHq
 ruDjXf/rWQxO2eNj0c3LeNqNJtKonTI+GACZSCtEj8Ca7nzC/josJ8uff7ZeH85zd
 ZsFNnO30HNl+/ai1kamNxHwpy/8tW1vX/UlOggE1b82vk4zmWkN1qFdIuvyIPlfw5
 L7vbyE6l0NTCf5jSjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1uHNHu1Elp-00qxCi; Fri, 10
 Oct 2025 19:28:47 +0200
Message-ID: <d5cc0678-5d8a-4ff4-973d-6b5a41f2fa4e@gmx.de>
Date: Fri, 10 Oct 2025 19:28:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mtd: benchmark: use lldiv() instead of 64-bit
 division
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>, Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20251010165103.1572444-1-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251010165103.1572444-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A8KlVVh0TkjMw3UhsVkp7Pa+i37TyslBSDRJEO/7MDhad44E5ct
 qPBs4Jk7HsKeavqK/nuwZFOwCXOmuIhhfOIPkymWszzkn5hQg7rlo3XHpunj9zUB/9XnM/1
 48TwC5C2bb9MC3a86IuRQkpUrjBz0eFKFqVG1u0hLgWsf3KGV89xHeGTyyZYCjyt5B5qFSS
 ZsCzo14BWqgd1X9uZXR9w==
UI-OutboundReport: notjunk:1;M01:P0:8vn762cuTiU=;alcV7xMa0TLkAcfy1JLb9yuk6Dk
 +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
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

On 10/10/25 18:51, Mikhail Kshevetskiy wrote:
> As was noted by Heinrich Schuchardt, some SoCs may not support 64-bit
> divisions. Fix an issue by using lldiv() instead.

Thank you for the patch.

It is on top of
cmd: mtd: fix speed measurement in the speed benchmark
https://patchwork.ozlabs.org/project/uboot/patch/20251010124115.1545865-5-=
mikhail.kshevetskiy@iopsys.eu/

Adding it to the series might make Tom's life easier.

>=20
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   cmd/mtd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index acd886da6da..2bc9fea697c 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -10,6 +10,7 @@
>  =20
>   #include <command.h>
>   #include <console.h>
> +#include <div64.h>
>   #include <led.h>
>   #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
>   #include <hexdump.h>
> @@ -595,7 +596,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>  =20
>   	if (benchmark && bench_start) {
>   		bench_end =3D timer_get_us();
> -		speed =3D (len * 1000000) / (bench_end - bench_start);
> +		speed =3D lldiv(len * 1000000, bench_end - bench_start);

Here you assume that the benchmark never takes more than 4294 seconds=20
and thus the difference will be less than U32_MAX. This looks reasonable=
=20
to me.

>   		printf("%s speed: %lukiB/s\n",
>   		       read ? "Read" : "Write",
>   		       (unsigned long)(speed / 1024));

You further assume that the compiler implements this u64 division
as >> 10. You could be explicit about this.

Best regards

Heinrich
