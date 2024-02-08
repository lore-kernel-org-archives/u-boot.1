Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EA2C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 21:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F57A87D5D;
	Thu,  8 Feb 2024 22:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QtdFZrRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA91187E3D; Thu,  8 Feb 2024 22:31:08 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D23787CCF
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 22:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-295f9e5f8a4so78165a91.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 13:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707427865; x=1708032665; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZvsFrExuchIqE1z+K5jCUZlplaQLWPOkUPrZfi9g90=;
 b=QtdFZrRkeNhk6LDGWaZyS+PTnryFHK+vlDGz4zt0nNsNeshaTicuo/QysJfqV6ph+r
 yd4xaE9oA7NN7Wo/zQ6aVMXPQ5Ck3VultU0hEl+hrD+auI+zUYPZccvHpF+ojDAUEM+v
 hbweEO8Ub+V5eUBOIcYzewc1oHMux/vQzXuNwkgWBTYw78Cp0W6LoECtya3I7PPb0DEs
 7cv+6t6J31cQ2vfGfMtSsHyEgVlqyf0GyNm2dc/ZKvwqThxAzL1pCOvjF8HVUeeMsANI
 TI1DxUqNIILVI+IUirPen0qjfVwcQNcIhRpyPMLtEfwe/L7d6i/zVpgNQ++eU19LuNjb
 HXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707427865; x=1708032665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KZvsFrExuchIqE1z+K5jCUZlplaQLWPOkUPrZfi9g90=;
 b=NZe4YC+xJzckFsmVfej8WkID437TyqlZ19p9xjzjuO5Hrq7DMcHj+Kr+HVcAd9PoQG
 ocI+dQ6mjDhC2dvtNBwMVjdfVMZJca0TCk6S5VfgTR8FutJB2BEo5t8wAsox3x92fM2N
 /SPxDgajMJysN/DOm9vMgGNUqkSVqrUvzB7fDzB3uRkt7LEVx24fH3UnmCe5fQ1nH4oa
 oPH3TaSu19Ykn3LG8U8MQaOv0+WpG3NYK6MFkejIYy4ESf/hmEpCi5KLetQFa87G8jQT
 oGoxNHMZ5ZONF5P/58wqvykrTF1XnzxcvV9669QXw25Ot4xRUh0eQyqJWNfpMRnNx7BT
 YyBQ==
X-Gm-Message-State: AOJu0YxHTTwkzp67bq2w/VMxfksmx+vdR0ddNmVi/cfNrvVt17KO00hz
 uk6TpH0ze8Kjbx1nGwsCyRRnGu4kdXatSiRkWpJZRs3Kz07yJ03FNnhFw8WT9g/bpAX0NOw3IHu
 1JfVefhKBGDG3+nMUkUUfHU33V3A=
X-Google-Smtp-Source: AGHT+IFB49KXc2CKmQtBD/ukMnwmwuJBJQtC0Mmr08xofIJQ9kcHdWzQEYQkgCiMOBzryaVuFUcUVVdiFFlcWe0pWRQ=
X-Received: by 2002:a17:90a:3ec3:b0:290:f5f7:caff with SMTP id
 k61-20020a17090a3ec300b00290f5f7caffmr491966pjc.3.1707427864815; Thu, 08 Feb
 2024 13:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20240208173415.397633-1-marex@denx.de>
In-Reply-To: <20240208173415.397633-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 18:30:53 -0300
Message-ID: <CAOMZO5Dy+pvZtz1CYnVU00jTHyLqxyLzysqyD1FRWienY_zNUw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Let SPL configure ECSPI1 clock on Data Modul
 i.MX8M Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Stefano Babic <sbabic@denx.de>
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

Hi Marek,

On Thu, Feb 8, 2024 at 2:34=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The SPL clock code does configure the ECSPI clock frequency, which has
> to match the mxc-spi driver configuration for successful SPI NOR boot.
> Drop the assigned-clock from DT ecspi1 node on this board to let the
> SPL clock code do the configuration and keep it aligned with the driver
> expectation.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
