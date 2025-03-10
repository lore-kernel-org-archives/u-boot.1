Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BD4C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F0588144F;
	Mon, 10 Mar 2025 14:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l5980ta8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE62814A4; Mon, 10 Mar 2025 14:55:33 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0F48141D
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30bf7d0c15eso33655901fa.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741614930; x=1742219730; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/alKQcFH+O9DIzKUARCxyxnvxW6vRJjsn0wR1NvsWcg=;
 b=l5980ta8P7qKAnpKg0mk2saRcXB5mHPiJPSER4OwXx8ktVyPuY7/WTlDYhzK7v0V5M
 xBPi45uuQUX+6E3T2k8OkKvB28lco+HHiief33l+dcOkY4UDCX60JgkQz4bHUbEjHDY7
 hwvqz7U35iWiC3qYG6OxwlEnEI5Va3QQxkxqzUYz7NgBtxg13KNYvOVhk6tvQ7mtqmIw
 BKKxh7+Ckr4lRA35f4Da/GvW501IDdnt4tdqZCUVrEhqctoWsUH0ucWEUUaA1FrZNo8O
 0ENpJziM+PFnarx3gy7sS7xsKtq+3efDNHP9erXx3dxUm2ngIdpCbp2YnPQAZ738TaKO
 g2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741614930; x=1742219730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/alKQcFH+O9DIzKUARCxyxnvxW6vRJjsn0wR1NvsWcg=;
 b=D//YhxWGnpesHWjVKFMnfJd/BhUXwNhwvDXEZZF3JE9sVUEz0Gi1uJ0Ro+vGIbjdOT
 +0PMf8VBSvMn6JJz+1LK/gq/4f0o7gCOQO7iUxaz8aUPKiiLQE1mEtzn0ocYxIa0z/WW
 eNJnXuRZ5SiTnZS15jbWJcB4/gZOiXQkn/m61z8iumdLwips2wAm+ng5QdDWYErw/Pt6
 PYc6foPkFq33euqVKokd80tORmN2kappvPmkWgLTnlDUL3ZNLqZLJ9Za61yeBCkd3AN/
 Cx+8vSuW7w2uJP7hwDdn/1xRRhYenmME0sfJv5PeBzLDsnnAnCNFd1Kdh8vOq7L4Wcs1
 8gHA==
X-Gm-Message-State: AOJu0Ywz+os2uI5j97AhsqzX/o0P7OZk5v+4NX6Q/iKab8bBb1P6Q7lk
 TrYfDanJCx+9two9u8iYlXH3d7SjsyLjakqmUZpHH8BzqKyGT2TzPWHlVHVUVvF4dweFRFC+QrN
 VAIp/aAXosuI7qanIqt3NXjWtLOK2Lg==
X-Gm-Gg: ASbGncvmAv02crazM1YlHEhVuC6ud50GOPVY7NimhnmO7ijqSdfZioFeHD8Z0Y3F+eL
 3uuDDFCYptYay5p7Xpjcx61DVHUO79o4QzrOSWzd8qU3en/P3zJCUe/Id1DJgJGwoplE/Z+wKvn
 r7MzsLsYFmvxE89K8US+5lxIQCcjlWgdXh6sJlTJaT2u2xh9Ce4PCzRKmJpQ==
X-Google-Smtp-Source: AGHT+IGzyvPcMDlcks6bqOj57jv/pqyeCD7yYJ1qR3jyqNrMYgMgd0XL7wsKgadBvooD5crhRwnPmekjMooYEfQKJfY=
X-Received: by 2002:ac2:4c46:0:b0:543:baa3:87ab with SMTP id
 2adb3069b0e04-549910b7f23mr4098523e87.47.1741614929890; Mon, 10 Mar 2025
 06:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250310133647.2712374-1-anshuld@ti.com>
In-Reply-To: <20250310133647.2712374-1-anshuld@ti.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 10 Mar 2025 10:55:17 -0300
X-Gm-Features: AQ5f1JrZltrVpUC0H2UiyG6-WyMRJwyCfMZ-3vkSkKMjvGGQJISLDg9BSFgV_zg
Message-ID: <CAOMZO5AmQ8TViLkx2cQe-FyrCCnOn9B=Cupgt-rj_5EvJyMsgA@mail.gmail.com>
Subject: Re: [PATCH v1] config: falcon: move CFG_SYS_SPI_* to Kconfig
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, trini@konsulko.com
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

On Mon, Mar 10, 2025 at 10:37=E2=80=AFAM Anshul Dalal <anshuld@ti.com> wrot=
e:

> diff --git a/include/configs/xea.h b/include/configs/xea.h
> index 00d62748733..2b358a41e2b 100644
> --- a/include/configs/xea.h
> +++ b/include/configs/xea.h
> @@ -14,12 +14,6 @@
>
>  #include <linux/sizes.h>

This header file can also be removed.

> -/* SPL */
> -
> -#define CFG_SYS_SPI_KERNEL_OFFS        SZ_1M
> -#define CFG_SYS_SPI_ARGS_OFFS  SZ_512K
> -#define CFG_SYS_SPI_ARGS_SIZE  SZ_32K
