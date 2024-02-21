Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B18C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 06:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC65087FD8;
	Wed, 21 Feb 2024 07:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NRUpKEg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234EC87E19; Wed, 21 Feb 2024 07:17:40 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E99887D29
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 07:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4704750edd7so564024137.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 22:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708496253; x=1709101053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=si8DQrB82eZNQaqYNDLpqo4IXeX0ZktgbGHkiSFkowk=;
 b=NRUpKEg3TbUElnJciMKbMTBCAGGhIH1lsfHVLFkdOzvl5J2rq6gNe1lxc7Eq/ysNuI
 tBQzXNyAo2e1BAMms/NduPP10KryqKmocEsroZWOZkFUuod27KlglGMZ320ffZSCvggL
 EWLH3MKIIZ/JPq+KNnY33sQSod4nCfZ8sPq730FZaYctD+9F84okDieVMoODvn9rPoia
 UmETornoUpI+nUBC1dbyfTTuiU03rx3QL35xoLOuHa51/nHfa6S1WaI/d0HFj2tIfU3L
 E2GoDPfAf9e0ijahkWS2IMUvGVrVdoZZZaY41wfjc/ncgCiVltOKo8KjR0hRDCyQgq2h
 sDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708496253; x=1709101053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=si8DQrB82eZNQaqYNDLpqo4IXeX0ZktgbGHkiSFkowk=;
 b=Usg+zePfd4P5R0E+hdMu/u1fOrzvJhqt+27hhoKCGH8RTRlyZM0JXtXHspw0pUyaxb
 4+jQ6SVtxjergJVK6nlOOtNMSg4LsQQ1sVd90mBXe9PQnK9kEXg2tPa61TMt3jlfcIAG
 iAVeRVsubV53b7O1xxHzPYuqeQ7zm9mj1uR6JdjWnEfgNncmV7Qaj4gEU4Uh1HA9XLe2
 skSwvVh8RdrJqBwWvvN6I4CH8KQppAWBK4Ei53PowASzwc1XWCCWEe82jF2ZEDjyMdfo
 9Iw73hmS3RoT/PFA6ZgiYFyS+F9wZfCOO+TVIWHjpwYDLJtiUzKNlbZ7sJ2MN3AmUjLc
 nKlw==
X-Gm-Message-State: AOJu0YwlEIbS3yyMziX/y+G4Bx8/9ppDQDtWrP0DJofSdriQ9EoRnTbu
 Ny0B4hTH53w8+wBDyJnAetmqloB0F6TpteI+79mdoit7C6fGuG18L9VhUutPpNqVx9lnG9oCrQ+
 D1RcSFFKXuh6kSAVehLfYC2wgdVIgE+igD3AXvjpBlK3EvcOZ+98=
X-Google-Smtp-Source: AGHT+IGsuQqdz5Cw+VqiDkZ8FHoLkBPXWhb/ByPI2K+E68PxHGN6GwekVH1l208Cnm7VzdmPh/VeOOOL121eQJm5zZI=
X-Received: by 2002:a67:f98f:0:b0:470:4ba4:ebb9 with SMTP id
 b15-20020a67f98f000000b004704ba4ebb9mr8498515vsq.29.1708496253149; Tue, 20
 Feb 2024 22:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-6-sumit.garg@linaro.org>
 <55e11f56-0080-41a7-b4b9-43c3abe61264@denx.de>
In-Reply-To: <55e11f56-0080-41a7-b4b9-43c3abe61264@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 11:47:22 +0530
Message-ID: <CAFA6WYMQtHysuS1nor_kZnq4xy3tk7Q=RezWdCfOVdBq0ee-iQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe
 PHY
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com, 
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com, 
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
>
> On 2/20/24 14:10, Sumit Garg wrote:
> > Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
> > PHY initialization moved to this standalone PHY driver.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Is this based on Linux ? If so, include Linux commit ID from which the
> code was imported.

Yeah it is derived from the corresponding Linux driver (see header for
phy-imx8m-pcie.c file). I can add the corresponding Linux version
(v6.8-rc3) in the commit message.

-Sumit
