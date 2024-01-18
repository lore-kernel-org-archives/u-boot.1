Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27843C4725D
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 01:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB81287A77;
	Thu, 18 Jan 2024 02:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BMlGTyPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 580E587A77; Thu, 18 Jan 2024 02:33:06 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E12EE878FF
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 02:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2866b15b013so2558318a91.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 17:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705541580; x=1706146380; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ah8M2rX13w/hbe5ACB8jcmojrm3IdHCPxg56YaoUhgQ=;
 b=BMlGTyPWB1K0Yr44k+VqzIT7HD1UEr8gnpeHLxWLvYaaZAvN1fTO2IaVby0q+6NiuQ
 4bvQq8aau2fj0opAzspwXnGiOrbGPK3FkBAjtOyuzP7BWbOBeDKso03EnMUhPLDtbqpc
 YkQXTx9zF6245uOccyZBhVgGOxQq9J4gfd2B5I46i3olwi45ock42yLFnDFvGJHuwEz/
 KtkVRr/HzN1YWfaXVHfGowfoT+z99O1Rkso5aHBkam2FK2+++idA5h5W+d5B9QMhezqX
 DbXwG1wBLACxESkWS3b0+hGuAEFB7zcmZNESi2noBZz93sBvxAyn5UNKmvsf5WGmBeNK
 0Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705541580; x=1706146380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ah8M2rX13w/hbe5ACB8jcmojrm3IdHCPxg56YaoUhgQ=;
 b=X6+3Iwe/GFQRMrN3HaUsnm/boosjXzeWZDvMHsO3CQjQR/cGFV3k2cRlAzSCDdHgT0
 x4KLw4pd7FwrZTUhp0FRuhB24t05HzaLRNzVXICRYOJuG3+tzLlxE1f9I/AlC/BCwAfK
 2xG4dxkUzsuYCqKUxAYJk6gfKtdgPs/aDX3Opdn6SFhy15FgKLFKxVuFWUkUaG21+sxZ
 OlzBMr066vko+8K5Cm7lJ9cjooWgDu/LI/e9hGBLPyVniPmFXm8Z8jsNHu1lbPpxBwk8
 4Zb+nfHhzNM6/uXw2tUwa4jzrnbBYJp+Y2YVUyxrZIRqzjcbj20M/3n9PQek400oWLOH
 Zsqw==
X-Gm-Message-State: AOJu0Yy0QCUYfUBp9U9x7a06dI0ZRRbe//n+ChQGJRpRdBwQ6GWBU3Bc
 YvK9Wzofj2ACe6ParoLNl8bVEEusCFsB6AUhuwCu6iZOI+In4RjS/kGLhFuwR3iWZv9+vXpywxL
 J3MtaI5XOxgPOCi/ny6iILwg1ccI=
X-Google-Smtp-Source: AGHT+IF4N8TtbCOmD1KPJJI7oYOMtzv3KPdQj3hAMzUIJ43RG6nMUWLiPy6J1vsQb1U/01iBMf1O2MLYrU63Y7Z9DQ0=
X-Received: by 2002:a17:90b:4c4b:b0:28c:fe8c:aa93 with SMTP id
 np11-20020a17090b4c4b00b0028cfe8caa93mr300599pjb.1.1705541580238; Wed, 17 Jan
 2024 17:33:00 -0800 (PST)
MIME-Version: 1.0
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
 <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
 <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>
 <CAOMZO5Cy8as7b_cup6J+PYbN-stkj4Vz2wsLB_1=NN3vx5SVWQ@mail.gmail.com>
 <728CCDD9-CEA4-4ED1-9143-189C3F257097@supermicro.com>
 <9c2e7790f0c94b0ebf0e840100eae2c0@supermicro.com>
 <be10a49d2381407fb955958fbc87ecd4@supermicro.com>
In-Reply-To: <be10a49d2381407fb955958fbc87ecd4@supermicro.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 17 Jan 2024 22:32:48 -0300
Message-ID: <CAOMZO5D5g6izBC=aCumX_H1tbo5uXTfuhQekSuH_XDqUAN91Kg@mail.gmail.com>
Subject: Re: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
To: Liu Wang <liuw@supermicro.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Wed, Jan 17, 2024 at 10:26=E2=80=AFPM Liu Wang <liuw@supermicro.com> wro=
te:
>
> Hi Fabio,
>
> Thank you for your help.
>
> Switching to "arm-gnu-toolchain-13.2.Rel1-x86-64-arm-none-eabi" seems a f=
ix for :
> ...gnueabihf-gcc: cannot execute binary file: Exec format error...

I would suggest installing the default arm toolchain from Ubuntu.

As for the build error, you would need to ask to whoever provided you
with the code.

Since this is not a mainline U-Boot, we cannot help.
