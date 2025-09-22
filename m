Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656B1CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5749834D4;
	Mon, 22 Sep 2025 16:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XN2whPD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF544834E1; Mon, 22 Sep 2025 16:24:22 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B7683443
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-57dfd0b6cd7so1451328e87.0
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758551060; x=1759155860; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wyBITM7UIQpFksBii69ut4MPwZWiH987aGV9fr+615w=;
 b=XN2whPD70iDX6nmZswi/AGdn7QkfpdxQj0pHKXEUs863v5kq7F++Qz1hOqmsN+T7oQ
 1Ln1K8fKx7pmmafIJVnYs2ptamHIfVEBxyp2nbhdHn1rCh1O0+a4dn9eaMSJw19wDqkR
 3/KKhDibo034pILSu/ZUgIKNwXElW7IsbMpb0dYOjvkFNIah7UXTNEQl0P15AxKas8qd
 WJj8jfssmOqCCKzpIsq/bxIC6+UO1YlV9ZJTvUfaziDcPzdmz7xPl6KDjCZnOj9UDZ2C
 j+Dl7Hc8vQvRn8j+4zZ7CYcnu/yGNk5xX4f5OtbID6QBmzHKQql6P4GSJ+QXrS3NiiMs
 8uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758551060; x=1759155860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wyBITM7UIQpFksBii69ut4MPwZWiH987aGV9fr+615w=;
 b=jvjbwvtyE8SUNOGQ1/8CZZRgYXdzzOhjqi5rnpYuiJKdVMSJ/1RqROVzj0/TIeiQGt
 i41HgA8NNcmbhtQjoxWkK+/0xl33tNN18r3mbyOwYD0triGImi4tIQFGpOSG/cUdcdLE
 GBeb/EHTsnM+gDO/Qk9k+kFtu2PK+41wJKpj19ZT23w6H4cDGT/Gc+s7AC1COlH4zXKS
 WkLIljKPcsgfdyqW1s1UM7lfzKk8V8jRAAmsUmLKOETxgSCLilLfR0MwkZwXdoNk9bJF
 Y2mBcxvQsqUvDehqyITzml4XVUdNSoGujf54v2D8OXfVzUyRhZv5E0lgoNs7tocwzd5n
 XL1Q==
X-Gm-Message-State: AOJu0YxQviGH/qOULeP3aKjV+zvI89PT20hBClP42pogn9ZH5BjWSJea
 K7Zrp0kbQCPZx/IErpfcEjluEEMqLtUb11wLXyvSvBTkrA8rEHpJgF+5oESZjgiQivuqt49gsvX
 x5QXj2tVdqYLmBzN1Nu0ieDBBFJ3bdvE=
X-Gm-Gg: ASbGncspWmAf8bcQjgvl3ZtpcpNUi64pj2ykT8XpBhcDKunR37XIZBxpjfQmD6HST2k
 MjFSe1vtabs2p99WjIkVOsRisNxPk86sOBHfAhksAylLPTfk/ifqABA4xEtgVqHzGQ5xtOcn/Zs
 fgztmvNxcfbfwIeKkvDinfvp24OCsMLPkCvt+xC2aNXgfymisKKpecMsKlBf6j+A5Kw2wJ+FUgY
 S6GHw5o9XZOvkGLnuZmk4l76EygtaYDWRYcLrw=
X-Google-Smtp-Source: AGHT+IFg7GSVgZcacu8hEER4zqKDi17wXDSlXkYkZ0X7mOxIXr+aKCsbGARdGaDtWwY+tpAW2ZETalZgRLYDIXYdFJI=
X-Received: by 2002:a05:6512:3e2a:b0:568:c51:e7cb with SMTP id
 2adb3069b0e04-579e2db7fdbmr4731765e87.52.1758551060053; Mon, 22 Sep 2025
 07:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250919065834.1497068-1-ye.li@nxp.com>
In-Reply-To: <20250919065834.1497068-1-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 11:24:06 -0300
X-Gm-Features: AS18NWBepkowo8M5EfhPINcVVcYutjzU9HiSyPsRQP-5943Z36R44NsuSBzZ2HE
Message-ID: <CAOMZO5BwY497Y6q32gtET_=pEUZV83f9awzka0VU5ZBeveUf-g@mail.gmail.com>
Subject: Re: [PATCH] imx: imx8ulp: Call DM post init function for init_r phase
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 alice.guo@nxp.com, ye.li@oss.nxp.com
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

On Fri, Sep 19, 2025 at 3:59=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> The ELE MU driver needs to be probed at init_r phase as well because
> some ELE APIs will be called.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Applied to -master, thanks.
