Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C83EC47258
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 02:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1080487956;
	Mon, 29 Jan 2024 03:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gzo9rcF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C4B8792D; Mon, 29 Jan 2024 03:55:39 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2C2879D7
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 03:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-295521db99cso166446a91.1
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 18:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706496936; x=1707101736; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5lnU/Mpo8oyFticgoZz3X2jLQpvJHk/+Qrn5QjQwYw=;
 b=Gzo9rcF041+rpjCKbuGR2UgYTe/hC90kBTa08WciyYYnUXz5pvwnrpkBsnWJV8Tgrn
 CZv974Y0z5l+MMzxC8W02XfxShTZNQN35dp2CnXmYoK98h6fidcsdPzZ7hnM0f7+ieFZ
 4769Cjwi8bAYvcu1qWuycH6Gw90QMPMWKt+YhbQltK6fbh629CfyXFPAQnmJx0BxQRpS
 CkdnL3WVrMCW+m6kEi4n42kpANds06f9EcMCKBvQA2S8Ne0L5rVidUnwX4al65bajNNH
 7rmnfogSkHVA86yjUgaxJ54Ng+T1aLn7Zpm7ciqoNQt96l2oWPacW9FzJxmEy5X6PbyY
 lNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706496936; x=1707101736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q5lnU/Mpo8oyFticgoZz3X2jLQpvJHk/+Qrn5QjQwYw=;
 b=HJ/y4Pq69mwBYHp9zpSSe6VabCgMSD+UXV0YZmYI3s1WCbQPJakJSaDH2zJYjcTp8B
 IJNXX5Ya8SOuTVMwYghDcXpjfHrFuZ+CLMMziMui6YNb6PvOqeKQBsPgl8XVfiyOxiRf
 UD4g+uYgvTHw/NDiGXERkW770g8T2VBIlD7WuxjF0p9LSrqTeK2ms+OiPttYZCQvJmbi
 7ba2/w/gFVK1s9vRkym5XJTxn7No9LBielK81y2sLbFrQUPci2Acvq++PHQ4hBs05q5g
 5FzO63sUg3Y4Ld3MN+9+mBcRqjnEIGN4hn0BBvi3dFlq6EVzweUex/p3bXGV4gV0kNgt
 +bYg==
X-Gm-Message-State: AOJu0YwHZHTjDU0hVxjU+JkKftBcZm5t9RQ9vf1QT1xAJIAzA3o4KrOU
 /3gLWs+Ri4kzPeyreiMwSKDeh/NbN0thtGoImJGfd1n4CJwLEHa7w66E0sc1Sj4yXycxoGISEBJ
 3zIfHcjAyjldT2PVWGROeIEjknV8=
X-Google-Smtp-Source: AGHT+IFyf/UhRTDfxCrPYkOpQ+T3OVljG38Ff1vCfxAmHS9U9bVRstSPOxRzsrnK/bVxHjWH++EaPiwLh58VglKc8G0=
X-Received: by 2002:a17:90a:e989:b0:290:f5f7:caff with SMTP id
 v9-20020a17090ae98900b00290f5f7caffmr5488669pjy.3.1706496935942; Sun, 28 Jan
 2024 18:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
 <20240128214335.120280-2-Mr.Bossman075@gmail.com>
In-Reply-To: <20240128214335.120280-2-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 28 Jan 2024 23:55:25 -0300
Message-ID: <CAOMZO5B5An2rPycw1rmLcbgdLJv1Ct+xVh7q5bhQ0zg-mAb5Vg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] imx: imxrt1050-evk: Add documentation for SPI boot
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

On Sun, Jan 28, 2024 at 6:43=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.co=
m> wrote:
>
> Adds documentation for SPI boot.

s/Adds/Add

> +How to use U-Boot with SPI flash on NXP i.MXRT1050 EVK
> +------------------------------------------------------
> +
> +- Build U-Boot for i.MXRT1050 EVK:
> +
> +.. code-block:: bash
> +
> +   $ make mrproper
> +   $ make imxrt1050-evk_spi_defconfig

In the previous patch, the new defconfig is called imxrt1050-evk_fspi_defco=
nfig.

> +   $ make
> +
> +This will generate SPL, uboot.img, fspi_header.bin, and the final image =
(flash.bin).
> +
> +To boot from SPI flash on other boards you may need to change the flash =
header config,
> +that is specific to your flash chip, in Kconfig.
> +The flash config is 4K in size and is documented on page 217 of the imxr=
t1050RM.

It would be helpful to mention the SPI NOR flash part number that is
used on the i.MXRT1050 EVK.
