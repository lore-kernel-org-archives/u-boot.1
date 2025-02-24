Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67DFC021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 06:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3807080C77;
	Mon, 24 Feb 2025 07:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N5hdKjPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF7C80F3F; Mon, 24 Feb 2025 07:22:32 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 772BC805C3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 07:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7be49f6b331so402670185a.1
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 22:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740378149; x=1740982949; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ne17KJUAPskbECqMbJLUs66BDTBKQVTvbN5qGPrxAo=;
 b=N5hdKjPgiNdBiYCdwKddaJsaa/kgvDAuO8yVurBIuitcSf1xBd2wKG1jXc0bLyl9me
 YiFWugUqNDSBHd1kr3XdQpKgvr0MW1h95K8HxMh5z/zGbLZqaWLDql1kd/zU3Qn/o66U
 BbNbz1nNx/VHStbuK7TJkZpbxIh5AYxpTa1D9pZ/rTK3pmFV0zumvK0XfZ46Ukc12JUm
 WsTRu23BmUbUmzIMzP5h4vNHZ8sYeg11CWqnetgw6Dd2qMGPoGU/RqYTh910f6oaY47Q
 gSueVHoebXd0tpWgA48d3KmzO5UdF614c34o02OOTSXXbDpRc+PIS7cV8aZeBru1Gkvj
 bDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740378149; x=1740982949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ne17KJUAPskbECqMbJLUs66BDTBKQVTvbN5qGPrxAo=;
 b=d2810o7OLvZFy0hprIdUC3VbFP11YcV9VB0Hu8eMGiewEC4LLxNsS0dGCaV19Pi3yh
 UbJ4G6lCoZ9DCem+CgXDNMevM8sUJW8d5xavgTMYXwFW7ly+49Bt0T7EOO3U+82r6WiP
 1tRJ5l0IOWnbX8YkaZmlZsWM2e3o0NfEM/xGqZBngWnp+MbA+zKddz6keSzj5/+B7dcC
 VqVjoWFnagfpZ1myiGZEL0nC4ZjkMn06+3TcWpobYJgz6dtpSrxFptxyCOzJ040eqq6x
 tpg93fFmZkTS0CrCMFNEZorpwCQmh0gHWeR8DOSQfsPVBIE7ffAWm9KeVOa4JESsoKS4
 DkwQ==
X-Gm-Message-State: AOJu0YwfxA/jb2jSnb1+NbYg0/z6awN4Dla6hsCu04OJtX/3DcNttEqO
 fRvue5cRtcZGdA7fRQqNm4D8Zi8zUAofLD57a93SKLa/zBl7l8vvU3HdWtT/m5ELxlwBeokLAeE
 fdnik59zyr8ESltsPR57fZASNYuuwWUuzQLfyRQ==
X-Gm-Gg: ASbGncueqC09J5QEA/z3nwqjIhsBrv+QFX/caf/oETmIvAyuJn4N0uRWyOoPYRoy3FN
 uGEuGfyW6VI1SHhmEDlZbLu8A0QpxhiHD6+8CILHDbz9drFceFcae7y+U1+5a6fhefE7JND2ych
 vditLRZqQABLXttkT9raFAGYDj+GKeoJFniOfu2ysRcA==
X-Google-Smtp-Source: AGHT+IGqdewZd/MLJu3bmd/1ivyk6bdZkVEASSQuwgSymEW/OTS76ZCpzZ3t8L7k1NsC+kf7SHaRlx7Ffe3lLjeAj9I=
X-Received: by 2002:a05:620a:450c:b0:7c0:abe0:ce64 with SMTP id
 af79cd13be357-7c0cf8aec7emr1643760385a.9.1740378149356; Sun, 23 Feb 2025
 22:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20250221125855.300717-1-mchitale@ventanamicro.com>
 <20250221125855.300717-4-mchitale@ventanamicro.com>
 <CEED6988-8760-4F8B-BDEF-3F3A442CA107@gmx.de>
In-Reply-To: <CEED6988-8760-4F8B-BDEF-3F3A442CA107@gmx.de>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Mon, 24 Feb 2025 11:51:53 +0530
X-Gm-Features: AWEUYZlc_ZR3gqSSqKEq3qIE4Y7qNkSYTEDjgsrPXFM7hJe9tKLza20TFcGPMPA
Message-ID: <CAN37VV6eKSCAQfESanfPcCPvvLfsqF5OT9Y=Q_MboqYQCoUp_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] riscv: booti/bootm: Verify image arch type
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

Hi Heinrich,

On Sat, Feb 22, 2025 at 10:55=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> Am 21. Februar 2025 13:58:53 MEZ schrieb Mayuresh Chitale <mchitale@venta=
namicro.com>:
> >For bootm, disallow booting an image that was built for an arch type
> >other than the current arch. For booti, set the arch type same as the
> >current arch.
>
> Hello Mayuresh,
>
> The code change looks fine, but the commit message could be a bit more ex=
haustive:
>
> A commit message should provide the reason why you are making a change. E=
.g. you could state that booting a RISC-V FIT image of different bitness is=
 not supported by the current code and that you want to catch that problem =
early.
>
> The current commit message sounds like you are forbidding booting amd64 f=
rom i386, too. Please, mention that this is a RISC-V only change in the com=
mit message.

Sure. Will do that.
>
> Best regards
>
> Heinrich
>
> >
> >Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> >---
> > arch/riscv/lib/bootm.c | 4 ++++
> > cmd/booti.c            | 5 ++++-
> > 2 files changed, 8 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> >index 76c610bcee0..90f71bee6a5 100644
> >--- a/arch/riscv/lib/bootm.c
> >+++ b/arch/riscv/lib/bootm.c
> >@@ -94,6 +94,10 @@ static void boot_jump_linux(struct bootm_headers *ima=
ges, int flag)
> >       announce_and_cleanup(fake);
> >
> >       if (!fake) {
> >+              if (images->os.arch !=3D IH_ARCH_DEFAULT) {
> >+                      printf("Image arch not compatible with host arch.=
\n");
> >+                      hang();
> >+              }
> >               if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
> > #ifdef CONFIG_SMP
> >                       ret =3D smp_call_function(images->ep,
> >diff --git a/cmd/booti.c b/cmd/booti.c
> >index 1a57fe91397..00921ec4a9d 100644
> >--- a/cmd/booti.c
> >+++ b/cmd/booti.c
> >@@ -131,7 +131,10 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int a=
rgc, char *const argv[])
> >
> >       images.os.os =3D IH_OS_LINUX;
> >       if (IS_ENABLED(CONFIG_RISCV_SMODE))
> >-              images.os.arch =3D IH_ARCH_RISCV;
> >+              if (IS_ENABLED(CONFIG_64BIT))
> >+                      images.os.arch =3D IH_ARCH_RISCV64;
> >+              else
> >+                      images.os.arch =3D IH_ARCH_RISCV;
> >       else if (IS_ENABLED(CONFIG_ARM64))
> >               images.os.arch =3D IH_ARCH_ARM64;
> >
>
