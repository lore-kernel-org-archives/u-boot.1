Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C89DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 16:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B217187215;
	Sat,  9 Dec 2023 17:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCZOc0Rr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD38874B7; Sat,  9 Dec 2023 17:41:22 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C838717E
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 17:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-286f3e0d010so858016a91.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 08:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702140078; x=1702744878; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yG3wQIY4y6qxy75oRGRMY6wG/xZOO2YvhCVZ1xYG4EA=;
 b=gCZOc0Rroz+5v8weyab4CTffJRJhJTD/5r1PTUbY5KE+3TpnoHoxYlBikYTI32pBSc
 vj1dqeEFsPBhWTSy7gL9tW2CkPQFJ8wdkouRJnxlZ3dg2kx6HpDRMr5iJqhu3l63h91q
 zs6blW2+h6pLjJ9ytKXb2rMekqQiifJVE3dG9fqGiiuEtkH1RiMh1LtE24c28bb3VRV/
 onlnuUbbLKPxrj39TzInVDqZ4bCumXcvbU7KWaLuMaznZpV4vjzbDn18Ireeh1hgxtiI
 RQKSJfBIU8nWWYPAk3s2bxi8l7tuUKJWpQSiXZKMvySlkUn2SxUVn6pLVgBQltyWSJPW
 DMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702140078; x=1702744878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yG3wQIY4y6qxy75oRGRMY6wG/xZOO2YvhCVZ1xYG4EA=;
 b=tAQ61xnx5VlyTHg+UwOtJR+uhYlLh0xCGdmXGoE8mQdG9uxDlaFCIJxaz93XuEpJxQ
 fMqseNpG8/s6QtKV7JMLs208sJ15GpnzkV9rb+KfJiSDHAR+xbTcpirDo/3Nx6NKHKxo
 7J6YvtFRgGO989t+56x3cJge5ahMtgNSg8NxI6s3HN3qvXAaABMwH0VW0UiZcNcNJRR4
 hoLBP5xSh5Gm7WElmBszegaiGK1CA/iiajz+pYM/Z0StzWYc1lLjUOx1GTndMBvpNbc1
 dicwDQvteEIFtEwzH50bT9n9fHULriXXXBb4Qb0rSX3/6CGjF/9jMHzh0mXDBvMqOpFn
 DPRA==
X-Gm-Message-State: AOJu0YxJUo7cPq8EzJc88ulMK1HBSdhc6f0/lHgavCLvysUNS5KHe9tH
 bAqRuJLrfS8WG6BZcyIA4WC8kYGjC1QC89lzUos/FP5Q1oY=
X-Google-Smtp-Source: AGHT+IGm+nfcoiJ9Fc90CoXT5xg3DtCNj3GYGG/0X9U4KKo1lKO+wtTa6l5/irHw4KOkQVddzHtOizDZRDOcd+uDewc=
X-Received: by 2002:a17:90b:4f41:b0:286:515e:b8e6 with SMTP id
 pj1-20020a17090b4f4100b00286515eb8e6mr3344899pjb.1.1702140078360; Sat, 09 Dec
 2023 08:41:18 -0800 (PST)
MIME-Version: 1.0
References: <CABqjNW-wv1g-3W139TyTX_sSP5h3KLFzX_Sqzvx+atV=ZJrOYw@mail.gmail.com>
 <CAOMZO5BzCRhNnseNq5RMP94GLt=1H9s742ywtm_LWOqTxaJcrg@mail.gmail.com>
 <CABqjNW-w3BRg0rqDXXYRMKY6-Ws3HsuxdUbx_pKAQ2hiuUrOaA@mail.gmail.com>
 <CAOMZO5DZ9WzWqeHQ_ApgCMW_jTxiGCPeB4s=Q921jTdkbZZytA@mail.gmail.com>
 <CABqjNW9GBhd7ojKuRum=ZV-W8gAQ1Cv8wdm6M8=iED+Zt2b7rg@mail.gmail.com>
In-Reply-To: <CABqjNW9GBhd7ojKuRum=ZV-W8gAQ1Cv8wdm6M8=iED+Zt2b7rg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Dec 2023 13:41:06 -0300
Message-ID: <CAOMZO5DG-Yp+ZeDstUp99rWHFSDJ0zjvq4qYOLxz-OKnA=ftgA@mail.gmail.com>
Subject: Re: iMX6, CONFIG_IMX_HAB and fuse_read()
To: =?UTF-8?Q?Lisandro_P=C3=A9rez_Meyer?= <lpmeyer@ics.com>
Cc: u-boot@lists.denx.de
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

On Sat, Dec 9, 2023 at 11:12=E2=80=AFAM Lisandro P=C3=A9rez Meyer <lpmeyer@=
ics.com> wrote:

> That made it! So the question is: is CONFIG_SPL_DRIVERS_MISC something
> that should be pulled in automatically by CONFIG_IMX_HAB or by
> something else?

Yes, I think we need something like that:

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index abd48d42583a..c34bc25c0bfb 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -54,6 +54,7 @@ config IMX_HAB
        bool "Support i.MX HAB features"
        depends on ARCH_MX7 || ARCH_MX6 || ARCH_MX5 || ARCH_IMX8M || ARCH_M=
X7ULP
        select FSL_CAAM if HAS_CAAM
+       select SPL_DRIVERS_MISC if SPL
        imply CMD_DEKBLOB if HAS_CAAM
        help
          This option enables the support for secure boot (HAB).

I will run some tests and submit it soon,
