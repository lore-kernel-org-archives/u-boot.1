Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB5DC35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0887C88DD4;
	Tue, 17 Sep 2024 14:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BuU6r6v2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B24BC88D7E; Tue, 17 Sep 2024 14:20:44 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC95A88DD4
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f029e9c9cfso45817371fa.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726575642; x=1727180442; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EpgPZ8uno7MqtCOsB6l+YfxnGvKlLVyX2MjnvQT9Os=;
 b=BuU6r6v2DmlDFnQKiMcwUxYTcje0I25yg203naBlEKKf+xZ0FtUYCl/SYcsZqa8OYx
 edPSYmmDRlMtsUz382lQwSU9qJgmJVlzOvVWCBZc1eFZhvXc3YwQpaaLdun4nCOpiuQG
 EUbIz15QrYiZoRFKYAGBlYVn3Edw7rfokjQBR2ZKNJ4chiG6+4NUvgCdQfmlvH9aHLMT
 +B9k15fUZ9vkT7tn/TajG8UalCH8kwe0adjuf2J5vkpovHX7gupqygHkQJT3ADfTjtaZ
 Jm0fxmjECiEIEKQr9UM4Fb1rmy7aQAJQsTfBGHcjQ8Ymxd+2tB1Rr76ycqCqncz03EbU
 UPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575642; x=1727180442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7EpgPZ8uno7MqtCOsB6l+YfxnGvKlLVyX2MjnvQT9Os=;
 b=WoBrTgiI79FBo9rx9nJPHZXFy8RuntK01tcIKbFsvl7B9CU0IadXdlTy5Nr0RF/kPs
 R5drrQG+REAXwaXkklQ2aHXHFDAIwAU8RGDz1ipM17zjPd4vm8iOeu2i9Y6FHJAdXcmV
 x7pRXBqmj5fHV0ivCGX98OKP3zrW89jKYH2FVC33EecO5uBdhebKXMWaGgqSRSMAqsHs
 rIR5Yf5MJlHu+traCNhT8uX5jb1dgMf7PE52I3NYlpVDw10V9Zorttk0QyfYGjmXNj3t
 9sXh2l3mgZcMkyRfyvv2nx1PcSq5BjskJbwtSSHlFycZr7fABfl/OMT751iQBEj8FYPO
 17BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV17JkFW7CnRWbqv2McxX9Go86MuNAzI7KirG4ql8NocL/j+3bnOslTE7giEjFGtK5ISgmt9kU=@lists.denx.de
X-Gm-Message-State: AOJu0YzAiLV6YzJsQqCttuUp0nVgrb7izlCKNNm99PcKGQp1RLnHGE3P
 SksRyyF+WY4v+ei2LG2qscw3RaNfDCSGwONnewh3VIO5daRIlGIK92cLgaF8oIu7RtlDQXsHiLp
 HcD2Wx0M7qyRgqP0vOL3oOiWxMX4=
X-Google-Smtp-Source: AGHT+IFQ2hJ0HmFIuWwAIr32BfowpWls+mYoy4D257xOunESMKt3yOfh7KID5IwssGkZ2jdWXpA51tV76ySxMDaVLHg=
X-Received: by 2002:a2e:a584:0:b0:2f6:6d6d:63c4 with SMTP id
 38308e7fff4ca-2f791b66b36mr96629131fa.42.1726575641961; Tue, 17 Sep 2024
 05:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-5-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-5-4fe8effc937e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Sep 2024 09:20:30 -0300
Message-ID: <CAOMZO5CAFL-r95i0cBFq14aO=H7n+dKeo+HmSeDysZUxaOgukg@mail.gmail.com>
Subject: Re: [PATCH 05/21] imx9: soc: Change FSB directly access to fuse API
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
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

On Mon, Sep 16, 2024 at 11:30=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

> -       fuse_read(2, 3, &val);
> +       ret =3D fuse_read(2, 3, &val);

Please use proper definitions for the 2 and 3 here.

> +
> +       ret =3D fuse_read(2, 3, &val);

Same here.

> +       if (ret)
> +               val =3D 0; /* If read fuse failed, return as blank fuse *=
/
> +
> +       ret =3D fuse_read(2, 4, &val2);

Same here.
