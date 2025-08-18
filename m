Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DBDCA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 03:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AB96833D1;
	Mon, 18 Aug 2025 05:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MreaCzGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D6B83403; Mon, 18 Aug 2025 05:27:33 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4B90833C6
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 05:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-55ce52b01caso4247672e87.3
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 20:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755487651; x=1756092451; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bT6igruAyOzIL5jLwMfD3B/+DTCuuhultBAnQ14Fq6E=;
 b=MreaCzGDa4Esx7Vp6n8TLXz/Gnvi4f1KB7EldCh0iiC3/MOyvt78C/CrB3+6PqTFJB
 5LzJBV5BDW7tMv971TYXkNQXrUoYpcpIme08AeKCOdUJttN0m9MOmVxC2jJe15ySIo1/
 +z+ZNzXPTUiZkHuqhgs3z4Ri1IGsHMpjELUC/eS52h7c2NHIDJ5UQQ25GKgoq0vZ3w3O
 mbjz9AxDXE5P+H85C49jt7nteI5eCcmc30CotY15nbEiOuehpXnUnDTbmOxoccN8EO2X
 UzJUck1aSPn7PNn4BEUkA0Gw9Jd8fVNghjU5G0fjr8aP5dY1/Pij941lgRif8LCA+woJ
 20OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755487651; x=1756092451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bT6igruAyOzIL5jLwMfD3B/+DTCuuhultBAnQ14Fq6E=;
 b=TVFQiX67tacQXrrFUgE1pkgied/+HzHIcHgpIzGcJmlBHcP3Ak2xFCwgRfSoMRf9rw
 g8EnaL3edMoWeDRHBSxlZh1PRcELsmcyFYgMjNSC8/fRfDbBQ3MDdHrTjDLMY0tfRoCl
 ud1KpNAUivhWjH6Fw68cVQPlQ5FkK8ypIpAPkkmgsCGT8z12jYtag+pQ0OS8btSu5u15
 AbR9oG2wHwyiNGoh5/SfMrp9ebviBSHGhWAQRQFXur2aSJ454KRCstCGsXIDgeFXwrN6
 gYDn1YpG0M54ptftQhwG6Q2HBmSUHEHHywvUT6M/AlrAsQe2ZoinO+TuAPzUmdj5mHcC
 9clg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdgo4RE8OaJ09RxhkTJr4FrJpmEOgg3WrRjDL6JLeApGAazDV3QnnIJ+fZyq9kzr13pvqn73k=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5yVZY5NViR/SPxglRcSnxEKflMeP+yj6PQWxlTY5U+Rf/1nKJ
 56iyHtlvqhaIT4OTESR2gks+I/y4ghl/zIcg31+hXc7xVYYbstEnz4vEQyi69IqpfJTV7BqB3UM
 2HI2Qt/Zkpjzckbv/Ipw8OZ0M8yvcpNA=
X-Gm-Gg: ASbGncvhl6H+k5md0kzF89GvcLlzzbdOMrObjQfQb8ugMUX1WptUJBLxo1/nTVPLZEB
 NipimE2LaiPn+RntM+RQMUG3JFkkUa0l2WID+60MTr3n9JJbk3R0OTGRKGJ+dPe7rJrsjeo2F4l
 WiMX9xpUR76hMmx4UxQjlR96lpcl5Mv82ACzBXebVwrMrKAIgH5lNwG92uNvJnKyyIDn72Uh1lo
 +3qU0fcR6WQmja52A/l
X-Google-Smtp-Source: AGHT+IEd2eGsMMyCEHt8U5afm1055AiopUBaQmDGmU05He3j9KIV8xJ2KlRAMGl6BFiNu82u6EhQlxmhN7iDDRSaxHo=
X-Received: by 2002:ac2:4f04:0:b0:55b:5c62:c7d2 with SMTP id
 2adb3069b0e04-55ceeb6b891mr3150154e87.39.1755487650666; Sun, 17 Aug 2025
 20:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250814163926.1205901-1-jeremie.dautheribes@bootlin.com>
 <CAOMZO5Ank65-NpF+b4icn8BxCAR11VEUPt-v4VAMrQeu0Xr1NQ@mail.gmail.com>
 <cced47b7-ec79-43cf-af08-653987d62fc1@bootlin.com>
In-Reply-To: <cced47b7-ec79-43cf-af08-653987d62fc1@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 18 Aug 2025 00:27:19 -0300
X-Gm-Features: Ac12FXxKkbYwsthU4kRjy4MXhUodZ7nfW-YYUp-KikhDNefvg_8qs1MWqoUN0K0
Message-ID: <CAOMZO5B6eLhbqrobxYuaTz5G=KCNw6F2kwNAWgxBM-RcUVRVvQ@mail.gmail.com>
Subject: Re: [PATCH] imx: imx93_evk: Fix conflict SPL early malloc address
To: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?= <jeremie.dautheribes@bootlin.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
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

Hi J=C3=A9r=C3=A9mie,

On Sun, Aug 17, 2025 at 1:39=E2=80=AFPM J=C3=A9r=C3=A9mie Dautheribes
<jeremie.dautheribes@bootlin.com> wrote:

> Yes I guess they can face the same issue. I have access to a frdm board
> if you want me to test it.

Good, please send a v2 that changes the three imx93-based boards.

Thanks
