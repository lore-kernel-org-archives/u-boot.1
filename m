Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C46C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 18:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CFA8879C;
	Sat, 20 Apr 2024 20:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iDrelgMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD2A887BD; Sat, 20 Apr 2024 20:35:42 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2506588785
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 20:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ab48c1c007so765374a91.2
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713638138; x=1714242938; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcdOCt1JR0sX16nFHCOaenkQd3jZWopg0njmZkkCVa0=;
 b=iDrelgMY6Iep4mI7MTTeuoiH5Ep1LvEjWMuz7orfpZX3iITMahhrOsYYY/ynh4F7ia
 R/Z68hcbvWAs+kYPBAk1mDpOCRaww5RWXnNp+kedar08W9avWuorbeEkrHlG2X8xolOx
 GiHTKyySct0R7OlCH7TnJM4r3JIEWwpBSVfKlxUM9m0g8nkZiEt4Umuv+RBoAqW9d7GR
 9PEb9CML5XVBCLYakYfA0+CTA8uNZCPTcvM4NyfV12AasghpC6bqdhqW26BnFb/h82t5
 2RysX7ee2sxyJ5rkEHcaI0t0xG0UaHOZGirGt2TigmCUofziCFMXGk/edKwQbhS4rJov
 yBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713638138; x=1714242938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcdOCt1JR0sX16nFHCOaenkQd3jZWopg0njmZkkCVa0=;
 b=gSUWRM41wVhW49OfcMgIxo9cTEI0p4XZh3VJwge/2aAw3Dwl4Mawetiqe5rMSau36O
 9SB6b/DH59hGDkKxhPleQuwwTFdlQ/Di+c+R7WUKgGH1uNqznqHEqhj/Pvwey8aBsyA/
 eg/VjUOdW/rJvYfduie50/ifVLyMF4iTJcK00RzeydhkSxHmPpESejmJ/ywN0E2I46VJ
 5Rf8nUueca3Dkg7skImV7AYNdk06eaHNKxGocBTjAbLNbz9ibxjINGo1kY46fTrSB4su
 rPQT9/CyUdqZ0TTUdOWRDgapXoMCQGswmj2HaUB5itP/oMvWiftBqvn0IVGBTcvwUXB0
 omsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd714Q3X15mVnfDiJV7tgxMFj2JL26DDxeB1iDOKAB2o20JNKJ+HLG+l8NYdU0JvrrcB6dqs2JUZQkJ6JEpmKPPiXc9A==
X-Gm-Message-State: AOJu0YzkL8aydFIa8TE79+6M/oJxGBODtyVkBm5tM6q2lxyQwCAn7kBO
 bRdrOavKVSmI4getAd6j+vEXHc/zBFFj+qPfGU+UqREM+kP3gnDFPF2wNeIINaH1TtO96jkyBGI
 Ql6sFCB9FcZCRw1OZwtJ5lifDEkM=
X-Google-Smtp-Source: AGHT+IHZZfaC2WwteibkIKXmlQSHhGsX/IjZkMO4jIshlCV63UM4kCurxddY3BnhUc42uU2W4Xoa9RG2mX9GE9/uIvI=
X-Received: by 2002:a17:90a:b292:b0:29c:7487:43b8 with SMTP id
 c18-20020a17090ab29200b0029c748743b8mr5649540pjr.1.1713638138618; Sat, 20 Apr
 2024 11:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240417084902.13904-1-eichest@gmail.com>
In-Reply-To: <20240417084902.13904-1-eichest@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 20 Apr 2024 15:35:28 -0300
Message-ID: <CAOMZO5DJ-xOBA9z-AFpvKP6eEonMrwruKQb394ixmbT3Nmvy=g@mail.gmail.com>
Subject: Re: [PATCH v1] arm: dts: verdin-imx8mm/imx8mp: use gpio-hog for sleep
 moci
To: Stefan Eichenberger <eichest@gmail.com>
Cc: marcel.ziswiler@toradex.com, sbabic@denx.de, uboot-imx@nxp.com, 
 trini@konsulko.com, francesco.dolcini@toradex.com, 
 emanuele.ghidoli@toradex.com, tharvey@gateworks.com, 
 andrejs.cainikovs@toradex.com, stefan.eichenberger@toradex.com, 
 u-boot@lists.denx.de
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

On Wed, Apr 17, 2024 at 5:49=E2=80=AFAM Stefan Eichenberger <eichest@gmail.=
com> wrote:
>
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> In Linux, we allow sleep moci to be turned off when the carrier board
> supports it and the system is in suspend. In U-Boot, however, we want
> the sleep moci to be always on. So we use a gpio hog and disable the
> regulator. This change is necessary because we switched to upstream
> device tree files with commit 23fe2def1edf
> ("verdin-imx8mm/verdin-imx8mp: move imx verdins to OF_UPSTREAM"). A
> recent upstream patch removes the gpio hog from the Linux device tree,
> so we need to add it to the u-boot dtsi. The following patch will remove
> the gpio hog from the Linux device tree:
> https://lore.kernel.org/linux-devicetree/20240405160720.5977-1-eichest@gm=
ail.com/
> The U-Boot patch can be applied without it and will not break the build.
>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Applied, thanks.
