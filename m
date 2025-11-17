Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C52CEBF61
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 11:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED1083A8F;
	Mon, 17 Nov 2025 12:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AslGbXU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B70283B81; Mon, 17 Nov 2025 12:42:20 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 418F583A79
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 12:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59445ee9738so3185088e87.3
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 03:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763379737; x=1763984537; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=68WDlUPBJKMXN4tN8EC1CIzUiZoXBSNsREwngY2GYps=;
 b=AslGbXU+G9KWgGOL7FhmlftenBpCCidVh5SoIfKDPzHtx/IwtOWPJwxaZnf4QvGj6e
 H8UZtn38djknuPfsHZaKT64hnlKALEQjkCabXPGB+dL4wEi+3LYIGPCNaNIwk49GAxG0
 XkiaU3xc+WXj9zgVJms/45yx9u9alDwE5GGzd9eiUW7PrQwMOX5tlc4ZEOqlIYHPqO5v
 HBCGkDcJA+UoHYSjFdmf8x/2Q2+1LgbobPTNepzBIcAJbRncsYHd97uD4/MpXNHrE/fG
 iwIJWGpn0SuXJ8yAHM47CwensXO2RWXa/2jpjp5LcfDtX2Ztqelm6QCTCzZytld4eBAs
 xlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763379737; x=1763984537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=68WDlUPBJKMXN4tN8EC1CIzUiZoXBSNsREwngY2GYps=;
 b=QhMyWbWrq6cN9+QDtZdINCfTijlekjC8BxMfEkMBdV8FlDWYW64VD1NOCdt8z5Vt8H
 h90237KGhlY1egPrHfMn8EC9qnsRbFoHO7hP0kKK4dHMQXOi1TOqdhR2RFtHZSaUIAUS
 zweA4F61SlrOBRUxRMviRnJy0ow3tOqr3W8zecabn42pnEWwPCYl5l3ASSmkpNcFPlM7
 9nVuSlffwM6oLJaM5wZ6LC3jgo1EmKUrpRCQJU7UDx3LZYyFH12Bk8TndjHHt+d3iuh8
 dng4cmYDm0tMhAfuv7bRWnbvf68dyvpNiFU0MFHUQrEnoGP8/rnthOo2wkDyIxp7E1rh
 pD0g==
X-Gm-Message-State: AOJu0YzCfFvb3cFTOFu9V0eiiiUvnWpvGr06qOPWT+SZ5Pkshf+qwNOC
 AXDOZGqvceKwKCPdwfT11hYEfI8bk4gOQblB4n1JgQRkj0Eo4eVInTgw2Mt9FzEgEdxajLWlzK2
 wLFspHCqEeFBcs0tbwtC7GGVPDdjbfu4=
X-Gm-Gg: ASbGnctvtjNXT2ZGMP7Sy5WQJCn2LAngfKDv5RVC5e6rNKbe7KGspgzM8NWFMTZC7XQ
 kUPGLS7TDRwPjO7NjBdAi8XbQdXL3B1aMw1AdJje2qABYCj4dT5PLA3dN+4XXFQFhzgcph1bPGC
 3UdP724m7Vd7XCWNwGRghhx9GF3yAI9P05s1RLZzIAh5EIUNdXrN28Bc5+heoWHFwjS+klmzQ6k
 f9QnNA0A52QRBQAqABSltH8oaytyLHypm8Xqy+BhJQNd5G3hlislb+KwCEKU77GxH64Ug7VoVQo
 /70t3gdSvwnlLdcql0kpmRJij48=
X-Google-Smtp-Source: AGHT+IG5jPGYs2F1NBSyg1G1xkPbKsONIvRR6EMmfKlfInakkcCjhJpiPThNWNG76KUV9v3tDNdB+du9rjREIgL7K2Q=
X-Received: by 2002:a05:6512:2314:b0:595:81c2:9920 with SMTP id
 2adb3069b0e04-59584205c8emr3868435e87.27.1763379737237; Mon, 17 Nov 2025
 03:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20251117094449.1109636-1-alice.guo@oss.nxp.com>
In-Reply-To: <20251117094449.1109636-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 17 Nov 2025 08:42:05 -0300
X-Gm-Features: AWmQ_bnHqp8O-InkO925215XbF9d2J4Fe7tCVrnpmQuV2J65qoVfzwcDqGtHn3g
Message-ID: <CAOMZO5DB-KdmthcY1S4sm-JXwSwxPtx5Fo+Z3F600HE7wOnsRA@mail.gmail.com>
Subject: Re: [PATCH v1] arm: dts: imx8ulp: Update device tree to fix boot
 issue on i.MX8ULP EVK
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com, 
 trini@konsulko.com, alice.guo@nxp.com, peng.fan@nxp.com, lukma@denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Alice,

On Mon, Nov 17, 2025 at 6:45=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> Update imx8ulp-evk-u-boot.dtsi and imx8ulp-evk.dts to resolve boot
> issues observed on i.MX8ULP EVK board.

The changes look good, but the commit log should be improved.

Please explain why the changes solve the problem.

> -               bootph-pre-ram;
> +               bootph-all;

It is OK to patch imx8ulp-evk-u-boot.dtsi for now, but in the long
term, please consider adding bootph-all to the upstream Linux dts.

> +
> +&wdog3 {
> +       status =3D "disabled";

This change also deserves an explanation.
