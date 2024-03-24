Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722B8C6FD1F
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 18:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3246879E0;
	Sun, 24 Mar 2024 19:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKbPaLzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB78F87D57; Sun, 24 Mar 2024 19:00:36 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82784875FA
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 19:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29df844539bso752915a91.1
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711303233; x=1711908033; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USRf4E/8TsrLZy3GC2knDSF2jMcK/GwDWiOImZoAEx0=;
 b=XKbPaLzIut0hCiXh3PBmI76qkhqLgK6ujD6VZLgdQUyNRe2K3NmVfytuDXde2gqfEm
 LOAmxZlBGh5faeS/MLgxTnbsYD5bJh+v0jJw2qehlnFjYWgfgIoBCVL5wVxuYYe+gyvd
 v8vBrRmt8H90u76duoHUAatMAidZJwHbqTQhsDWzGb0XiKF+wWJj1f4tweiDL4vHA2MT
 TXtysxoxn8FaoEXFZOrNWkSTromRHNjx6zKnEFhcbS81BYkkEEt5bk53FSssLPeVNOZf
 2YXhKekfckpSTG267HUR61OaK4l8eihtqgieJBpP8H2H+rgVctK3JZI2TIH/Vnb67hwn
 t9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711303233; x=1711908033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USRf4E/8TsrLZy3GC2knDSF2jMcK/GwDWiOImZoAEx0=;
 b=iAd8WJ0LNa7dU2J6g7OqsSuC4dq40yq6hevZ9FK6hz69zjpZXlGV6MwuMsHULEtjSI
 oZUqRU18B6OL9617/chJTr317Dn7slXTBHl4kl+rGNHwzrc8wLVHKXEsHqoxdx2TfKe2
 NRcEAvMtE/oEHRjujzhNQyrdkzsMvVgyIkeDNubjASnckt+L2G9v3+pS3j1wSzNORiYq
 jTDJUCaH61a5ZtDDsV8VUs4VCXYvb89W8QPmY7qMD9rEQxJHT8lAe5DILN1NsU/gIKRA
 u6p+6l6FDpWlUsqO00FZ6epY00Sv8II9WcPFcfZt6QQEvziYQswW6e23dk15n6NcT1hd
 KPxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Ysj6wPaU/usMNrXdm5isjJb85OlWx+vl7u9ufU5n0CmKwvsIXeJSHqlwfg/drcqT5PGPKhG2btW/9oHJ9f1LIyqy8w==
X-Gm-Message-State: AOJu0YwN1OUuYEqvt00aqJvTNKeuIfD4OfhZXCYFUye+ev7meEB8Xkmi
 egmvcVonapaVxq64y4oqegKiyYm4wUthii+Otx7Dv9UgBcoadbqnDy1BimulymaqcC5+gZhmtVA
 Nb4B5PyUBk/dUg4ZXQtebmb+BpCY=
X-Google-Smtp-Source: AGHT+IExY0iue9jS5Iq1FS9i6bYBiSo5AHsrro1oKmLalvjRqEdoZdpPtdBXFNzsjQ5epzoxEXuX6uhbxfCIhEO4hDw=
X-Received: by 2002:a17:90a:b395:b0:2a0:350a:a7a8 with SMTP id
 e21-20020a17090ab39500b002a0350aa7a8mr4160943pjr.2.1711303233020; Sun, 24 Mar
 2024 11:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240321144541.15314-1-othacehe@gnu.org>
 <20240321144541.15314-3-othacehe@gnu.org>
 <dec314ce-d83a-4549-a2d6-f5604107bca5@denx.de>
In-Reply-To: <dec314ce-d83a-4549-a2d6-f5604107bca5@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 24 Mar 2024 15:00:21 -0300
Message-ID: <CAOMZO5AOv9Cmdpmji-y+YO9GvkMTHmh2d+RxmVksMLgj-23rqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] configs: imx93-phyboard-segin: Add USB support
To: Marek Vasut <marex@denx.de>
Cc: Mathieu Othacehe <othacehe@gnu.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@denx.de>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
 Yannic Moog <y.moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, u-boot@lists.denx.de
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

On Thu, Mar 21, 2024 at 4:17=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> $ git grep -i usb.*phytec configs
> configs/phycore_pcl063_defconfig:CONFIG_USB_GADGET_MANUFACTURER=3D"Phytec=
"
> configs/phycore_pcl063_ull_defconfig:CONFIG_USB_GADGET_MANUFACTURER=3D"Ph=
ytec"
>
> It would be good to be consistent.
>
> Also, what is the vendor/product number those two boards use ?

They both use:

CONFIG_USB_GADGET_VENDOR_NUM=3D0x01b67
CONFIG_USB_GADGET_PRODUCT_NUM=3D0x4fff

configs/phycore-imx8mp_defconfig has:

CONFIG_USB_GADGET_MANUFACTURER=3D"FSL"
CONFIG_USB_GADGET_VENDOR_NUM=3D0x0525
CONFIG_USB_GADGET_PRODUCT_NUM=3D0xa4a5

I agree we should make this consistent.

To not block this series, I applied it, but it would be great if
Phytec could submit
a separate series making it consistent across their boards.

Thanks
