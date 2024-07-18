Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E406EC3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5FF88AD2;
	Thu, 18 Jul 2024 19:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jONUm0K3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53DF688ABE; Thu, 18 Jul 2024 19:02:19 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79E6B88ABA
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ee9174c5c0so1675561fa.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721322136; x=1721926936; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEO4CG87gcKiYqDLq3gSu70pMhMTu0BWMWCN5alJUW8=;
 b=jONUm0K3hlDzbEFflfkeD4A1/PZD4DPk+HwDh0tlmQnO4x5XIdiasHOqYH/thqMD80
 RZLIEUi2H+Z5nUx9KHclsuc7Hh5koUPe+9wma7dvaKT+Qbx9cA+hoJiJQk1rj7v2MQe9
 8LQZCkgT8/3zqsgifCf60RrFQk8+xzrAHM6HyQdi5mKdwa6KHGUJM7rDQG0L+aJBIYR/
 rDXwRHEpQBXXvwkgA9JE7BS1iz5V0LzFdBfPnZnmSqg8vz8ILTcgJPyjolZ5oLKGWFMv
 f2Ojmiv+KclKmRrEnOo6+T2XFcRK1cgXyrwymb4UiS0KZ/Xy6Qr7fXd0vZG0EHvANutw
 IWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721322136; x=1721926936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEO4CG87gcKiYqDLq3gSu70pMhMTu0BWMWCN5alJUW8=;
 b=oF9uaPiXp95FiRKO9tT61OaO1ETTcSwWxUpUlYMY6BKJbBJ9ybnVy3vpOz8XawlYOf
 KekQJ1L3BHysinjpU1VQ6CeRCm4H11Y6X+e0W+Tm2qSc6tSKPO8DDn8+KHp26yzcSn2B
 cAEKvpreEW/YJgiFLJjMgeEQK65zeN7Y3b9ujXdT4+xwWfjC1gXyIh9b4Ib4e98W3pTF
 GAKK7TcWWIjgT4kA3PXmDU/jVgntkMFN1VT4ZdbMegql3Qlnx/nRpelTTqcWUgBJ8HQC
 sBHdGuR/efmu1BRrCZyUD1eTLA1NTX07V4qu7jiLIqjWafK9dmRgSsHTxYqKqykkqXS9
 xjRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhy4vJgvq2rCKsv3DoQGo03fu5fUy7M/IaoFjY/zJkWqsddZcqbepSffyTrgzvaNiVEmNlhWqmVMDwdGjeEe/aLYyZvQ==
X-Gm-Message-State: AOJu0YxRt6sQ4jd2PV5JMNft/ejTuJSPwbdmwf+YqP/lf+c+2KZro8yE
 le9b3LkQwO8ehQs8XgR0TotB8CkyogSzHv8VnzJZeiBSH5Fe5A3SzfFyB9nE7UlKjtNqiR+Ao+c
 IQK3unWCq+LCUsjjuwL7C4EWrZVA=
X-Google-Smtp-Source: AGHT+IHgOY9LRwZiixABpTUPD0kxbMgpycCSRgba6sDf76gJCSImkbjG1WaXMjO2h6TlhgOYSaME9LS/yGnLpx4eaRE=
X-Received: by 2002:a2e:9995:0:b0:2ee:d55c:5c3 with SMTP id
 38308e7fff4ca-2ef05d5de10mr10316471fa.7.1721322135388; Thu, 18 Jul 2024
 10:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <038dad39-e99a-4464-be5e-57a3a73ca8af@oss.nxp.com>
 <20240702090928.1663707-1-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20240702090928.1663707-1-paul.geurts@prodrive-technologies.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 18 Jul 2024 14:02:03 -0300
Message-ID: <CAOMZO5BGYvWhb9gBspMb4mbx_OFmJ+0TiKyP9inZ+i8ieToCWA@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: ye.li@oss.nxp.com, sbabic@denx.de, uboot-imx@nxp.com, trini@konsulko.com, 
 peng.fan@nxp.com, eduard@lionizers.com, marex@denx.de, fedor.ross@ifm.com, 
 rasmus.villemoes@prevas.dk, xypron.glpk@gmx.de, elena.popa@nxp.com, 
 tharvey@gateworks.com, sjg@chromium.org, vitor.soares@toradex.com, 
 u-boot@lists.denx.de, martijn.de.gouw@prodrive-technologies.com
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

Hi Ye Li,

On Tue, Jul 2, 2024 at 6:09=E2=80=AFAM Paul Geurts
<paul.geurts@prodrive-technologies.com> wrote:

> > Thanks for confirm. I also cross checked with teams. 8MP must burn a
> > pattern. Otherwise HAB won't covert to field return.
>
> Okay, thanks for checking, I will wait for the details and make the neces=
sary adjustments

Please let us know if you have more information on this so we can
proceed with this patch.

Thanks
