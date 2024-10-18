Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12150D2FFFD
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6609D89093;
	Fri, 18 Oct 2024 14:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jnPcrZ6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D34F8890E9; Fri, 18 Oct 2024 14:31:20 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC3DE89096
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539e8586b53so2625523e87.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729254678; x=1729859478; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfubtJ2JKyQRudJFZhfGhAARSidpTx0OyAKSjC20lnM=;
 b=jnPcrZ6LYwM1lku5mYO6irxJqIAma8LKdpdSEkGiyJR35PoK51/QbjrsLGy47CRrFT
 txVatYhKX01zCF+IBc1YinXDKU2bt6FRmY2fKIIb4cDcRGWmtkyK1u+hlWtCXX2rMRwr
 bmoRGiAl6Z6XvQOv40SfmjbMn2n5W6Rl3vKJg6rzRolClsSfT0qRUtxC54QMXwv7Z0ld
 8MDNm0LOAbBXlw13EHCcxNnMd3vQ3WF7woA4wXOEIYeRF1JLt8X5UpgD8UoSFwZTbdPw
 W20jm4CB4ZfoNt6yAXjo0zFzCVZS3oEHtkylvAC4XzjREWwzGWywHVnio5lpOHUmx+Fb
 Parw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729254678; x=1729859478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfubtJ2JKyQRudJFZhfGhAARSidpTx0OyAKSjC20lnM=;
 b=Q2j1ZB24vr0zBSCQkOZKb9t5Oyw65FPsHGNbjDNycMKu5aCM8HW+2QNpObZm/gWAnD
 Kidx+MYXxKdK2ts6I/yd7OORq0TGKL2WUC9ZaXmRpyJAy/LgjEBAmt/9/iFJA9SOsHcu
 /4W4A7qhrmLiMu5ZsyBi1L9pNIG3nA50fYy0p0/zt5gKEMsrP9gN7jnygHf+qD21NW2E
 jkEsyEI66tcuBr/RcGb7RarZiMNEToE5iBxM9PQsgX3MYhL+2ekfl9LeaGc7Pey0eQdI
 XLm5NWv+5HyDQ7iY9+vMPX9lKeQMdmkQ2xO1xtObxpFbjfKZcXeZQOr5A52OTj7ez7xc
 bfQA==
X-Gm-Message-State: AOJu0Yye8QK6n9xIhikRFwPKOnyl21g0UwfkwrMnVj23/lrQIMNS5HX7
 wODytpRX5u+PN0uC4A4cRAZWott5bXMmfZb7UKGP8DdsWP4U53V9VA95ki6d67cHh8aK/+zXAoK
 0W8Sf8eQiTUbbxhIcdlhsFqPkRZ8=
X-Google-Smtp-Source: AGHT+IGIpfwVfkorPIqJqRioUD9yb3udGgamZ7XenXR6wI48yk0HC9g0xRFvzlJMO3chPb5XztYceDoSEyxIpsTIcDk=
X-Received: by 2002:a05:6512:3b2b:b0:53a:1b6:4624 with SMTP id
 2adb3069b0e04-53a0c6a5c2cmr2181703e87.5.1729254677790; Fri, 18 Oct 2024
 05:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241017010856.152764-1-marex@denx.de>
In-Reply-To: <20241017010856.152764-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 18 Oct 2024 09:31:05 -0300
Message-ID: <CAOMZO5CFVmtoMXTFf3w4EoT6h0UxH_j19tc6arN=YzLamiBscg@mail.gmail.com>
Subject: Re: [PATCH v4] dts: Add ability to build fallback DTBOs from
 arch/$(ARCH)/dts
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Lothar Rubusch <l.rubusch@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
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

On Wed, Oct 16, 2024 at 10:09=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Currently the enablement of OF_UPSTREAM results on the build system
> searching for DTs only in dts/upstream/ . There are platforms which
> use U-Boot specific DTBOs applied on top of U-Boot control DT during
> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
>
> Add dedicated 'dtbos' target which builds only .dtbos and not .dtbs and
> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled, build
> this target for arch/$(ARCH)/dtb to generate local U-Boot specific DTBOs.
>
> Adjust top level Makefile so binman would search for .dtb and .dtbo in
> both OF_UPSTREAM specific paths and arch/$(ARCH)/dtb for the .dtbo case
> in case CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS is enabled.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied this one and 2/2 from v3, thanks.
