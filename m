Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9146DCE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 09:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16EA983B0B;
	Mon, 17 Nov 2025 10:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0smQahsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 349F983B4A; Mon, 17 Nov 2025 10:00:08 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A77983B0A
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A82C6C12647;
 Mon, 17 Nov 2025 08:59:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B8516606B9;
 Mon, 17 Nov 2025 09:00:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B78E10371CF7; Mon, 17 Nov 2025 10:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1763370004; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=VRYurppXQttNoSBB5dego4F9jJhxfZDeCp2eeHHHCc0=;
 b=0smQahsYxEXatyo1imGOAVIUJmNJEb2++nlW3sG/ReKc1pwotlvjjaUGgrBt5LQ1B6Yp8S
 9mmBzhBVNyWu///tXcTiB1prrhA7KkwByHRQeg7PP2TCgOdVg+SER4hxmquVMXIsnydIpR
 OHVu92zdmzJSmW5Lj+fr5aFg/c+3jJmJ+/bPM/Zhaq/v8vCIoU2Yrx3RdQ0GP2CVxDWlk/
 LKyCL+zVfLZP8o9eaymipNq7VU+yBBxk/V0A7S9lbsF/Mz1oi4VK4u++FSofuWJuQSIBbd
 +3MbdnCgox5jnqt6g6DAhxqfCwQthMo2Q0yWnC8tUEHSxKZHOIPhAftlJngm2Q==
Date: Mon, 17 Nov 2025 10:00:01 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd/extension: avoid NULL pointer dereference
Message-ID: <20251117100001.4a55ff5e@kmaincent-XPS-13-7390>
In-Reply-To: <20251116114153.118217-1-heinrich.schuchardt@canonical.com>
References: <20251116114153.118217-1-heinrich.schuchardt@canonical.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Sun, 16 Nov 2025 12:41:53 +0100
Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> extension_get_list() will return NULL if there is no extension device.
> Check for this situation.
>=20
> Addresses-Coverity-ID: 638557 - Null pointer dereferences (NULL_RETURNS)
> Fixes: 2d12958ee71b ("boot: Remove legacy extension board support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Hello Heinrich, I have already sent a fix for this. Sorry I forgot to add y=
ou
in Cc.
https://patchwork.ozlabs.org/project/uboot/patch/20251112130742.97473-1-kor=
y.maincent@bootlin.com/

Your patch is better as it adds a custom log in case of no extension_list.

> ---
>  cmd/extension_board.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/cmd/extension_board.c b/cmd/extension_board.c
> index 86e4795ba8a..75358abf666 100644
> --- a/cmd/extension_board.c
> +++ b/cmd/extension_board.c
> @@ -99,6 +99,10 @@ static int do_extension_list(struct cmd_tbl *cmdtp, int
> flag, int i =3D 0;
> =20
>  	extension_list =3D extension_get_list();
> +	if (!extension_list) {
> +		printf("No extension device\n");
> +		return CMD_RET_FAILURE;
> +	}
>  	if (!alist_get_ptr(extension_list, 0)) {
>  		printf("No extension registered - Please run \"extension
> scan\"\n"); return CMD_RET_SUCCESS;



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
