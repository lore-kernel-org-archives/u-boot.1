Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A02C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 16:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C274386E02;
	Fri, 17 Nov 2023 17:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bu4JiLrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E5B186F84; Fri, 17 Nov 2023 17:13:23 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119D886E02
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 17:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ce6059c2bbso1104015ad.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 08:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700237599; x=1700842399; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxQBimEjuUzemFQi0bWMZqxLzpO4vGkY+bBM0UyNc6I=;
 b=Bu4JiLrRUjBQkqxbZFxo6idffPliRxUiXEJ4Nhdt+odlaB6e21aUHJ9wPSpQerT5RG
 W/KHLSUkR3RABEorkHy8VlqauCrzXRf44weNe4quJ3fMND6YuJBIkE2e8IG3ewfLlfIT
 MPFUKFAbzi1bAim1ftbhdjsgoFJGnk+jZy55L8vcFXeS7V3eV/PreVn08ULqAw1st+h2
 K8aAnjrJ6d59WKBAYNqbHlyg9E4TAHn9bAOapFBp/YT1RKvZHtno0IJr9NLHI5FGLxNC
 xcvyM81t65SKtD/9fGrMGgDVWvthxdYeWf6+/ekPnLkP8vllvvjrF1e7YvKXAbPA1GLg
 QT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700237599; x=1700842399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxQBimEjuUzemFQi0bWMZqxLzpO4vGkY+bBM0UyNc6I=;
 b=NNsv8g3e///S+jRj6P9AsspJTp8pzoCv9jP4nRq6ssZy7x7Cuio7/7Pb2yjgwbJjwH
 1U/G6VBm5jt9cHRKv3ZLSGXSyk85nO6gh7AVaa//8TZuEhBnyv/iF27eNlF/V+/b2xvg
 xeBGYEPx3bQlQWq+aCHgBcamA6fiL6nzVIYafBo0b9X6/HdIPC7AbqyMOI6dx65haTRn
 J9BS3FLSHXH7nnEnOGK7C1TdvVRpPXXoXPUl2Af51kJQArlAzWjNkbxJsNqHwOleha8m
 XGD4zZALaAQEVsYRE98DWbcN9Q2ilzgbkM+x6etQodf7dPkBLOMt+EaNA7K6i9vhf7YU
 847w==
X-Gm-Message-State: AOJu0YwNRPN940eTCBJm9cTQ4G0XmgYsbqOG0/k95Ffso/RAVA2km/6S
 AjWWJTSCjWFbonQNKjq1kyiztytT63v0wsc60ag=
X-Google-Smtp-Source: AGHT+IFoBhVB4JsO1SOsF+waijSTdYqW5j7hU0qB/znywWQhKgi0DK+2veOQxmsnM0Sf5w422SIJPmA9GUWVz2RJ15Y=
X-Received: by 2002:a17:90b:1288:b0:283:987b:9104 with SMTP id
 fw8-20020a17090b128800b00283987b9104mr2420167pjb.4.1700237599355; Fri, 17 Nov
 2023 08:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
 <f9ce2b20-1fa1-408c-9ae6-4dd382c9c999@prevas.dk>
 <6ab14ae1-7044-4663-98e4-919b9d1757b9@denx.de>
 <899b50aa96b802275035f9ee40f46b461f8bfb46.camel@toradex.com>
 <86ddb623945da5a507fb4632375f7cb70361ac58.camel@toradex.com>
 <20231116184226.GF170968@bill-the-cat>
 <91c3d742-a87a-458a-ab6f-6a56706bb78c@denx.de>
 <20231117142540.GE170968@bill-the-cat>
In-Reply-To: <20231117142540.GE170968@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 17 Nov 2023 13:13:07 -0300
Message-ID: <CAOMZO5Dtc1wdmEpsqZ2Zo=YHQwyYb+oRdYZmhz1r3YQyXRx4sA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
To: Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 "peng.fan@nxp.com" <peng.fan@nxp.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>
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

Hi Tom,

On Fri, Nov 17, 2023 at 11:25=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:

> OK. Fabio, please send me your patchwork username off-list and I'll get
> you added and you can start managing patches there. I've started using
> some of the b4 + patchwork integration just recently and it's very nice.

In the meantime, could you pleas directly apply this series from Marcel?

Thanks
