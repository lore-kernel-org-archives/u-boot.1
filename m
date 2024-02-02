Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BAAC4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 20:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB9E87E38;
	Fri,  2 Feb 2024 21:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UWNkpnvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B528587E32; Fri,  2 Feb 2024 21:45:47 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73EE587E3A
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 21:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6dddf4fc85dso2010598b3a.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 12:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706906744; x=1707511544; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OaEOEzaRSBs7xN2ARowr7ZlOyR5goZcbyOI8HKtddkM=;
 b=UWNkpnvcxmw/H8pFAis3xmNOa6+njUL4d3zrCEbN71kiyeeU/pbee2zUkTMVTo72bp
 243y8Arhb3s06aV9j3+1h/3mnlDihoS3b7AI5f340wmcfu41d3g0h2ZyfUpoeCtuy/Fe
 skpOwd5fw9YURXoF4IvtU1jsJhUtnL9ZhAcb+TfNA6NR9zYmCnedVM8LXgKLvdcq8/qw
 SYcNE3n2Ia1ZAJXDR199RyjI/UJCbjefg5VCT6AxuBfQj7PQ8TEpKgP/pbhKez9icBiX
 pM/Bpm6iqGHc//lpXtjIsqI7trn1Qzt7n2CiYzsBs1qIq5oxx/dUgIAk3je8QExH4N+v
 DPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706906744; x=1707511544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OaEOEzaRSBs7xN2ARowr7ZlOyR5goZcbyOI8HKtddkM=;
 b=wGCQWfKtjjOWxXhL5GWKeKXI0LV09IuHYa4FkukaaW7qFlcpdfDfMEqgEiC1s4/teN
 MKhMgmceNxa4FWKvfCo34R1z6RJAijSLol1kShaYZGTJ7ewUppRMUC8NyWwnuE609KZg
 s898V5TmPRKMpZFv6kCEicwqfZ2x4L4yzkwv9pwpgTXWQQwQVXKgSuJXLw8KXUDEfk9D
 zd3VuKmylKNbR4SGt9I5UGBFPQFBc6dx8DsHXCzWyLOZAs7OeFGw7UjVoovHiuzas7/6
 60x+MvvW4gKtgAtJorcdXKOPaKlqje1J+c0B9Ocuz9wyGVo8QO5HZFdz4OFd/u+Kdp8X
 PQEg==
X-Gm-Message-State: AOJu0YxBH7CDWqgxgFhT6REvbrAoRx+OSlEvFQLCox6wZqSn5ccf/kuw
 /SGotNFlSXVHuzeT6rNNw+sxXiG1ccyvx/UB8XIHonmt4Vj2NIPeW4G9YaxZKXGGLcs9KWigfov
 MWAjK9ZcqCYlIunbayXVanyxx/4Al4k3EqI8=
X-Google-Smtp-Source: AGHT+IFHqILmPwug86wWXKWWq5H3SQXePErF1q/Hmbb9U4c/qPbi93NoO2ImCKuhMPYaqLo53DGYrMTcACRGzRrqUAg=
X-Received: by 2002:a05:6a21:8cc1:b0:199:49cc:87e2 with SMTP id
 ta1-20020a056a218cc100b0019949cc87e2mr3405233pzb.56.1706906743644; Fri, 02
 Feb 2024 12:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20240201150004.1343366-1-Mr.Bossman075@gmail.com>
 <76dff51f-c9d5-477e-8ab2-0832073d2f33@gmx.de>
In-Reply-To: <76dff51f-c9d5-477e-8ab2-0832073d2f33@gmx.de>
From: Jesse T <mr.bossman075@gmail.com>
Date: Fri, 2 Feb 2024 15:45:07 -0500
Message-ID: <CAJFTR8Rs4nvUQRKjX3=iXxq-wkUc97BC++o=ew+4BH1A9U-duw@mail.gmail.com>
Subject: Re: [PATCH v1] doc: imx: imxrt1170: Document imxrt1170-evk board
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Alon Bar-Lev <alon.barlev@gmail.com>, u-boot@lists.denx.de
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

On Fri, Feb 2, 2024 at 3:40=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gmx=
.de> wrote:
>
> On 2/1/24 16:00, Jesse Taube wrote:
> > Add documentation for imxrt1170-evk.
> >
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > ---
> >   doc/board/nxp/imxrt1170-evk.rst | 42 ++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 42 insertions(+)
> >   create mode 100644 doc/board/nxp/imxrt1170-evk.rst
> >
> > diff --git a/doc/board/nxp/imxrt1170-evk.rst b/doc/board/nxp/imxrt1170-=
evk.rst
> > new file mode 100644
> > index 0000000000..4acccdcc93
> > --- /dev/null
> > +++ b/doc/board/nxp/imxrt1170-evk.rst
> > @@ -0,0 +1,42 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +imxrt1170-evk
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +How to use U-Boot on NXP i.MXRT1170 EVK
> > +---------------------------------------
> > +
> > +- Build U-Boot for i.MXRT1170 EVK:
> > +
> > +.. code-block:: bash
> > +
> > +   $ make mrproper
> > +   $ make imxrt1170-evk_defconfig
> > +   $ make
> > +
> > +This will generate the SPL image called SPL and the u-boot.img.
> > +
> > +- Flash the SPL image into the micro SD card:
> > +
> > +.. code-block:: bash
> > +
> > +   $sudo dd if=3DSPL of=3D/dev/sdX bs=3D1k seek=3D1 conv=3Dnotrunc; sy=
nc
>
> This location conflicts with GPT partitioning. Does the SoC support an
> alternative location for the SPL?

Unfortunately, it doesn't seem to, but it will still work as the
secondary table entry is intact.
As this is abuse of the GUID Partition Table it's probably best to just use=
 MBR

Thanks,
Jesse Taube
>
> Best regards
>
> Heinrich
>
> > +
> > +- Flash the u-boot.img image into the micro SD card:
> > +
> > +.. code-block:: bash
> > +
> > +   $sudo dd if=3Du-boot.img of=3D/dev/sdX bs=3D1k seek=3D128 conv=3Dno=
trunc; sync
> > +
> > +- Jumper settings::
> > +
> > +   SW1: 1 0 1 0
> > +   SW2: 0 0 0 0  0 0 0 0  1 0 0 0
> > +
> > +where 0 means bottom position and 1 means top position (from the
> > +switch label numbers reference).
> > +
> > +- Connect the USB cable between the EVK and the PC for the console.
> > +  The USB console connector is the one close the ethernet connector
> > +
> > +- Insert the micro SD card in the board, power it up and U-Boot messag=
es should come up.
>
