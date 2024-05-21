Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60457C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 19:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23FD8839D;
	Tue, 21 May 2024 21:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r2bMIG7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F97883AF; Tue, 21 May 2024 21:05:36 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA998826E
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 21:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e34e85ebf4so49500081fa.2
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716318334; x=1716923134; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNk/ofo2iqGZJLLtbnuUKcCBws1oKpoWfIcp0YgwXkI=;
 b=r2bMIG7AnH76DPyPyD32qPA/t8HikaHVCwbysEPs8IkyjMY+BZLe1hrGwp3RxgJoO0
 H+adI5fWuor9wmis7q9uNGAyQclLB4T4Wceezl7uDlMR4tiA1TLdmOiNrWUkfghitAZO
 gdshnZcreJDnuUcpYUKW08fscPMi9JlMUVdmo3aDkstUYC0kOs/deL9+ywhuSbiU9OsW
 aHJYalcnSLdhgJ20GvTjFB4PyIkZ/iZtjErgfdUFwalzjHu2Y1m8YjptGOiH7u3CAwmv
 LMyGGYNggL3gX28IletAM26HwYz88MdOuS/rhZXZQ4PW58nQkcpbSdxYjOgV731/Pcok
 vGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716318334; x=1716923134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XNk/ofo2iqGZJLLtbnuUKcCBws1oKpoWfIcp0YgwXkI=;
 b=ochNZGgn5zQlWM7i6GP+pTyp7T2ewMYPOwQhvplnjUciKjaXqqa3mmZXAudRwiUr2n
 cxFm+aLNsGwTZpR3xYHJ4qhsBMXOpDjLvqACXxz8e60Itp/YEcl9l8EENlcP/4RELp5s
 n4cHqXuWNylAWD0/d84KGNcsDDZ2/MYLfK1HCzFBh7aLSIPdx1uPF9sqa6unspUhohnI
 6K1MpOPEi9QX93vALU//EG344+B5ijsnOMEib2Sy+UPzo5Kognt6/MFCqYc8IcBqnczF
 0opXe2kXJ1nPh3C7aE91JuHaGe1CPym/FfdmCUID/tb7mAf6zgRjmmUf3sBXgUtGVppV
 tttA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh0PeaVCZHKK8LZfuLTf1p4gBF/IoyWq9mSEtJq9Z9JNoq1FCIsrpEow+KKsFb3pWTspT/mWyOPDukpczqVdCc51eXQg==
X-Gm-Message-State: AOJu0YzYKPmDYIxrPOhSGgqhaLTmmKFrR9c/yaohhAcuDxUctixiBqfA
 v6J2Xc/V2jM0QZ3rKpvP8McpFiBuYtiB4BnlcCfDxUZJRFD2bEJRDn3iz8hNRqVeLYXoLCmaSJ2
 0Us8kSkuVAXA8bmAXURfTKtMFD7jwrTgpNaefPhUv15FzrAAKn14=
X-Google-Smtp-Source: AGHT+IGXiQ1rzC8t2SgwEmuPUgJaQm9IXOF4iWrACLqBmpx5petTG/MuthB62F7Ffoj+yvnlqLMJkvQzq8mMfBECr9E=
X-Received: by 2002:a2e:9c8e:0:b0:2df:8bef:d900 with SMTP id
 38308e7fff4ca-2e51fd47d7cmr187722601fa.16.1716318333899; Tue, 21 May 2024
 12:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240515232138.3065987-1-tharvey@gateworks.com>
 <20240516090950.373d304c@xps-13> <ZkXNN4I/gFgjD3oP@trex>
 <20240516113414.49fe3b9f@xps-13>
 <ZkXV6wBiN/oRfUH+@trex> <20240516124047.0fe6a6e9@xps-13>
In-Reply-To: <20240516124047.0fe6a6e9@xps-13>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 May 2024 22:04:58 +0300
Message-ID: <CAC_iWj+a4Y-CFXok_tfdaYPM5rB_mUkbtFggTrd_4mZGjv2jpg@mail.gmail.com>
Subject: Re: [PATCH v3] tpm: display warning if using gpio reset with TPM
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, 
 Adam Ford <aford173@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

On Thu, 16 May 2024 at 13:40, Miquel Raynal <miquel.raynal@bootlin.com> wro=
te:
>
>
> > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > >
> > > You cannot send your SoB like this. SoB means you are carrying some
> > > code which complies with the license, etc.
> > >
> > > Either you were part of the original writing and want to be credited
> > > for that (you can be the author and first SoB, or suggest Tim to use
> > > Co-developed-by). Or you reviewed the change (Reviewed-by), you teste=
d
> > > the change (Tested-by), or you are maintainer/responsible for some pa=
rt
> > > that is touched and you agree with the change (Acked-by).
> >
> > right, however there is some lenience in the process: some projects acc=
ept
> > the signed off, some others add the acked or reviewed and so on...
> >
> > but I agree with you and I certainly do not need/want/expect to be
> > credited for this work. it is all good on my end :)
> >
> > >
> > > Thanks,
> > > Miqu=C3=A8l
> >
> > btw you could have simply ignored my note btw : notice the "if needed"
> > part in my response. for reference, I noticed my name in CC, checked th=
e
> > change, thought it was a good idea and tried to move it a long - just
> > chose the wrong tag for sure...
>
> And this is likely a good habit :) But now you need to send your
> Reviewed-by because these tags are usually collected by the tools. If
> you don't write it properly, there are very little chances it will
> ever be picked-up.

I'll pick it up manually. Jorge is it a r-b?


Thanks
/Ilias
>
> Thanks,
> Miqu=C3=A8l
