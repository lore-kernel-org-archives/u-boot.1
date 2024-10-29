Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06DBD2AB3B
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 13:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2625F8912B;
	Tue, 29 Oct 2024 14:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="3PNF2pcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD2E8912C; Tue, 29 Oct 2024 14:01:59 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 670B288ECD
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 14:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6e33c65d104so47908787b3.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1730206915; x=1730811715;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ny0xZjbhea8Itm3ay30d2wewHL3nYIRR15uSzSN9mnI=;
 b=3PNF2pcRXz/Ij4n7QunEr54oUrxtS6wgP39u/r8AxvUk1OwxLM53G3W1JV+9tf0D/q
 1UNWl3sZziAI5WcDzrqBgcGNQVQxz8KDsMQuZbODVCeohvtITagqR5H/vWkxpdxjwqlr
 fF7CGdIg0UP8sVWJ2mkFWkVQMorXgzgs0GL/tYrhBneWf1csjFRW4ZsLLKTCzaI4xcHH
 lzZ3z3TzFhTNF1R+PRe+aswa4EgKyCVA03USlhkVTyb1mMhN2rBfDITP/dEywYGwnrmV
 MDcoqCUXAqtD2rf4NYyfapu+vXSNxHD580MLs0+LxsZ109eXTpGZ0elQwjPu1/4LhrlW
 u4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730206915; x=1730811715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ny0xZjbhea8Itm3ay30d2wewHL3nYIRR15uSzSN9mnI=;
 b=jPA1NeECdPm2ORL6024YniONSdvms/vNI4SQR/Hg/0kLktxT+aRuP9PjOyJiX/r/L2
 PU2SgbYq8xeMQAank1sZzuPsHJQxsOKiuaMpNssMlRc3Ypcyzl/4mFV7YN2B+WcyEi+2
 VqVB1N5wW9nWjYLiW+X8kH4JkrstT90NXWtYLtkWNumeqok7/1EqjVBcbtgM/WQYPtyI
 0+z5HKe6S+JE0ig+4qEQDQteFXlGyzhcru1rGxhm4BDxmrdF3D9FfUlCujAs0rCDbBPM
 ZPQELxbyKo8R5I9s82CFdCon33mTwjTvhR6qCirRt+zfvDPcphptEf2FgbXRJJ9C9Wv/
 jGyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYFHLNkISOHDEtfiVxmAWBDNQDRE8XJFd58MSCBIGBnN+zEnSSSz4IaDxEBUTdUC965DXUY7Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyrbQte5SS8ylr7V49+ZKiCW0rpEcS85EoCksZ/p5ciLnQyR3ty
 6QfP7/Ren8qt2cFhshlGbjRmgAOJl+k8Ih48Hdfvy8g8FKespYII6PwcuJ//YWmVSjJeu9BQ9Ur
 a/Hj20Dlq36Tr+431LcbetMlDVrNuLmqwwsbxw0SDbOtVSrTofQ==
X-Google-Smtp-Source: AGHT+IFiOyoIY1SDFpXSd+2q+IZb3y+qQqC6z7uiEnavEFvhJmys586FdxJXT40EDxU2cbupg1ksxslpssavpymcYvs=
X-Received: by 2002:a05:690c:3389:b0:6dd:bace:572 with SMTP id
 00721157ae682-6e9d899517amr128551427b3.19.1730206914555; Tue, 29 Oct 2024
 06:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <Zx-C0_rHzfNmG-yt@swlinux02> <20241028152010.GP4959@bill-the-cat>
 <ZyCr3a8I52q1gkfZ@swlinux02>
In-Reply-To: <ZyCr3a8I52q1gkfZ@swlinux02>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 29 Oct 2024 14:01:43 +0100
Message-ID: <CAHTX3dKcotZQOJNNEHXx5rMUQyvXqTw0tUMsc5UT4qPrPvM0Zw@mail.gmail.com>
Subject: Re: [GIT PULL] u-boot-riscv/next
To: Leo Liang <ycliang@andestech.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, rick@andestech.com
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

=C3=BAt 29. 10. 2024 v 10:35 odes=C3=ADlatel Leo Liang <ycliang@andestech.c=
om> napsal:
>
> Hi Tom,
>
> On Mon, Oct 28, 2024 at 09:20:10AM -0600, Tom Rini wrote:
> > [EXTERNAL MAIL]
> > Date: Mon, 28 Oct 2024 09:20:10 -0600
> > From: Tom Rini <trini@konsulko.com>
> > To: Leo Liang <ycliang@andestech.com>
> > Cc: u-boot@lists.denx.de, rick@andestech.com
> > Subject: Re: [GIT PULL] u-boot-riscv/next
> >
> > On Mon, Oct 28, 2024 at 08:25:55PM +0800, Leo Liang wrote:
> > > Hi Tom,
> > >
> > > The following changes since commit 28dc47038edc4e93f32d75a357131bcf01=
a18d85:
> > >
> > >   Merge branch 'u-boot-nand-20241005' of https://gitlab.denx.de/u-boo=
t/custodians/u-boot-nand-flash into next (2024-10-05 11:19:24 -0600)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> > >
> > > for you to fetch changes up to f07daa5967f65771f90221ee9bfad9814e5496=
47:
> > >
> > >   riscv: mbv: Align DT with QEMU (2024-10-28 17:49:25 +0800)
> > >
> > > CI result shows no issue: https://source.denx.de/u-boot/custodians/u-=
boot-riscv/-/pipelines/23049
> > >
> > > ----------------------------------------------------------------
> > > Michal Simek (1):
> > >       riscv: mbv: Align DT with QEMU
> > >
> > >  arch/riscv/dts/xilinx-mbv32.dts | 30 ++++++++++--------------------
> > >  board/xilinx/mbv/Kconfig        |  6 +++---
> > >  configs/xilinx_mbv32_defconfig  | 12 ++++++------
> > >  3 files changed, 19 insertions(+), 29 deletions(-)
> >
> > Why is this for -next and not master? We're not so far in to the cycle
> > that next is open, and this seems clear enough to pull in today. Thanks=
.
> >
> > --
> > Tom
>
>
> Michal said that this patch might have to wait for its counterpart in QEM=
U be merged.
> (https://lore.kernel.org/all/20241017072507.4033413-1-sai.pavan.boddu@amd=
.com/)
> But like you said, this seems clear enough for master. I will create anot=
her PR for this patch.

Likely the address map won't change.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
