Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8219C54E60
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 02:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9B487F75;
	Fri, 15 Mar 2024 03:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DDt7lRui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D88787F69; Fri, 15 Mar 2024 03:18:20 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1635687DAB
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 03:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33e70d71756so1627340f8f.1
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 19:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710469097; x=1711073897; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mNC/nnItUvp7xWYQjVjkfgzjJ9spjUrsfWIq0EMs+k=;
 b=DDt7lRuiDEDww3uUeWca7ao5ZJafNJMEsrEmMCTd68V+hmKMSAZXGGuVVslbgZjwED
 DEsc1R43ClSrfWDMGRFqHx+sTk8LsrfomEOngl3Gr28icqM5MBGUvtFyxXRckggLVnvO
 m/1O93mbNX1e2uqBgcCgXzy76bfalC75oyrW+mWvdwzU7UnjVrG1hPNhbw66B0b1OhZp
 0Rjl2ZloQ5pgama+DNm3Il6XUMO6qybQBfYk+6QsDhDtYie2k+owIsY+GG6dm5/xyKcU
 T4kRnGSz4BwSastpmfRq+MKOyISCVqDsTb3/muI4Id12s+3D8t4sveHUPYa5rHR4fyBs
 IyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710469097; x=1711073897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mNC/nnItUvp7xWYQjVjkfgzjJ9spjUrsfWIq0EMs+k=;
 b=t8nZCR01ke3PJ0Ui7nV5X6JVr1p3SdJoKgnAVKbAx50kfhcYd5uavTRHvFsZH/nvP3
 t1hTrTPCuP9sEA269FSz2ZPdmedTmnfswctwenUjyJCYUsB60WE8qbtPzZLklokYqhZn
 DSCVrdgsPWDrE45+98LZ4+vcvOQxNin/5lM4Rjw17IP1emSuw1vn0ZDvO+T48odKTnyo
 7NcN8A6N521WZPPaTbFUQhYZViFLWo5uvRdGC8m/h5uGnapaG4TCNJ1p2dWrAsXGTNeE
 b1ZTKunoOjkvjrZyIXAZyYKYjhhppUgDPmpuoM8UoDiHkmL5scZWSXNXtA1DIxK2ayNL
 NWxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSKHLJTeLcPskfavFbpHaSSLCu+4CVDpZJbvl0lFZIlp+bHk93PEnBaJucOhzMHgb1eCPIdI3Frke9yfl0ApTC6RKw+w==
X-Gm-Message-State: AOJu0YxmGCjEP2EuxqFcCAsj8PQrtdq0mM6BDGhfrWHDTaLs8/XPlF0K
 3h4q7sbEmCKl+ofL3DTOYueQE8q4kugUgyidgXD+GbGv9MRgdaHuKxW4SOsBrsUHaB6cRCB0B+m
 Gl8x36i+amYfjNbe7dNx1YIsk3rEfbuKWTMP5lEvQOsA=
X-Google-Smtp-Source: AGHT+IHjNNF2RXCqN16/2Eori5E3EF5VFwvZLskMxP8yT0dGqS9NkNGifwWNFMhImMRzhWRF1/iENuQyr3pc3yFN16E=
X-Received: by 2002:adf:dd87:0:b0:33e:710a:b699 with SMTP id
 x7-20020adfdd87000000b0033e710ab699mr3198575wrl.9.1710469097320; Thu, 14 Mar
 2024 19:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240310055816.11575-1-seashell11234455@gmail.com>
 <20240310055816.11575-3-seashell11234455@gmail.com>
 <ZfAnkOLt4mdCZLOP@swlinux02>
 <20240312-unnatural-deviant-24bab57103ba@spud>
In-Reply-To: <20240312-unnatural-deviant-24bab57103ba@spud>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Fri, 15 Mar 2024 10:18:07 +0800
Message-ID: <CAOKwTdpqjq5W-emd4APL8Z-LYAERR=62Rbu_YmyCeSkyDska5w@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: dts: sophgo: Add ethernet node
To: Conor Dooley <conor@kernel.org>
Cc: Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de, 
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 15 Mar 2024 03:30:04 +0100
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

Conor Dooley <conor@kernel.org> =E4=BA=8E2024=E5=B9=B43=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=8C 21:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 12, 2024 at 05:59:44PM +0800, Leo Liang wrote:
> > On Sun, Mar 10, 2024 at 01:56:45PM +0800, Kongyang Liu wrote:
> > > Add ethernet node for cv1800b SoC
> > >
> > > Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> > > ---
> > >
> > >  arch/riscv/dts/cv18xx.dtsi | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> >
> > Hi KongYang,
> >
> > Will there be a patch adding this ethernet node for kernel as well ?
>
> It's highly like that the compatible of "cv1800b-ethernet" will be
> requested to be changed to "cv1800b-dwmac" to match the designware IP
> used in other SoCs.
>

I will change it in next version

> The added node also looks suspiciously missing any clocks or interrupts.

If we only consider u-boot, since u-boot does not utilize interrupts and
clocks, this code can function properly. However, if compatibility with
the kernel is a concern, I will discuss this issue with who is working on
Milk-V Duo Ethernet support for the kernel.

Best regards
Kongyang Liu
