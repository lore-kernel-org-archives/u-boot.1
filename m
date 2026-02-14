Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48F2EF584C
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 22:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E390183AA9;
	Sat, 14 Feb 2026 23:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B1dQyv4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A846D83AA7; Sat, 14 Feb 2026 23:19:40 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E522083BE1
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 23:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso1314269a34.0
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 14:19:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771107575; cv=none;
 d=google.com; s=arc-20240605;
 b=RofLgZdN5lvmWpbxlgu0G5JIiBedZwJX9VsUPohFm+dOyxWJ7mt4Jx0VmVV5T9s/rZ
 o7w3niiMPhvI2Qxb7Om8veOiXqqw2GqspzLwTf5b8jhOxVGoxtYAYt1NP++H9Uv+ZuLS
 y57AFNhMR8CvgJJAtZi1hlNKQ9YsZteTuqo8vALk+uymfaFVc+PV8nIVDKBmRpb533cx
 yPdYnKaeKFt6W310iLbQd/PVtOijYEk3e1ym2wBNH+N7KHsloyt+twNPcwqOXPjx9MNF
 tMO/9Sy+VqvgYZ08fDBrkhE5SstHVcnc8dOIeXOyr+0+aPrPNvvYB767LbufWt/CQaoR
 jISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=59PQ2HPDSWCz0+1a5YMKjmncAA2xkg2F8C2X8ZbLm0Q=;
 fh=Hm3AHlJnoij9um3g2wcoIMzbf0/chxEtXLDJaMWHQpg=;
 b=JBy+WS36uLmNRkYPByrbPr8c53oTGF/DrLhDpj60ElB6Ilm1N+ABoiXjPDcsduoeu3
 Jf11mSZEckkh1D3PDu4yemYO+cWgs7zMJk4zYAMVREztOh5U4U4IWHO2bR+9OW72e9GO
 Ut0NvK4SfDAqWTARzOhnHYIq6oCHfzvORNHIOEK4ynKzz8PnX3RWu1c1/Ed9nFNbHr/3
 GP/vMKqh24ASDqhQ8JAREq39mtVtCnJNrrLOw7sK3CLn+cbmsPRk4NmUrEti9qbKX7ee
 j8yW4e7H6XGA2xksHf9OGLpoSkGd5uYjJAJG40esP+8lt8jgdtvsTwTexFMxVHL/yWyl
 CoOw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771107575; x=1771712375; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59PQ2HPDSWCz0+1a5YMKjmncAA2xkg2F8C2X8ZbLm0Q=;
 b=B1dQyv4vmN0yMwPFI8d8r0K9Q/v5rd7KIqwlGdcHFzRhEPeo65zrJEj/aYDrK0c/Ay
 yiNbW6t28ZGMFtN1P7QbXrCD718AL3RSzuz8vcrJeqWsRG2ManW4Cko4pO9RCSCk2WtI
 BJZR4Kj99rciehAmY2PHzk2Rf82zGYfC64+71MAjPV4tuZ3xDzvTeYlsTyE2SfEpsHIj
 c1IlebGItnA9AKurN+3zwAbKtL9J2ThBumL4gwqhPcCZKd+0XStHV+s4l5jJCNdLGhkY
 3TSXbT7uFitFgISRCOfsHdtubRmbpVIC/tzX/lXBuPe97fgMs2k9dgqk1lSmnQlDux1p
 TZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771107575; x=1771712375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=59PQ2HPDSWCz0+1a5YMKjmncAA2xkg2F8C2X8ZbLm0Q=;
 b=LnxOQ34CjTsXuWNcdvYsVZEK3H+PNeIJArHXQNdQ1Z2U16ozJCfAm37jMafdMeZjj8
 nCdj2aHoge7qy2Iywmd6CMZ2JOFoJjjnm8fzoNwMEUaSd4d2g3r1fk0qFnQcE6/9Pqpb
 DzLVtEnAqtdTlNOQ4q8NqF7sfgSVvQZIRfOCCRsHc6P0D1DQE0jhzBl0QBzUXpR3cLj7
 8CDIOY+vNXZA4J/9faxgm/mFAtGDRva9rjC7zKM/fRM4MG8hXJeLPWeNxlPdI/hmQyvI
 ycBJg0gg+S2b/GobKz7LjqNMJbcXL28Oyb/LrugLD30N79t1hlt+pLRwBA11KokhxQQ+
 wQ0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu+a9pAknbFyZHPhERf4QHerO94QKIQ/xxjdPzqG5cZYlYWIqdnJYuAq89Rs3eqAoUcZ/qMxk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5+yEAQkOR38Gy+lGQ0JNg0wGG/LOZmNq0xTWp085mlYNVKYdN
 mOL+MkZKAmOVxSsJf3jsDI1/RRBsLuHMwh/Dzr5uZug7SGILMeZVARO0nIUvcB6/UvmAgl4ybky
 e0tBaXk2HuJFGZt9pSo8RAtzq2eHGIx4=
X-Gm-Gg: AZuq6aLH0Ag5lsrJz5aggY0BhqUbqUuduB116Xxjioa3Ch+cXW8bxGvyhp63FAQUizj
 sFhnsgjYSBA18Ttw3Smfir/SrkC7bWGFX19G68SQUBPOQDEjcJ9aeSgFWEHFTRSd2PT2v23rWNE
 BVsY+jrCxzgHkrZaImDTlkYwrwh8XMVHmr49ENkaKwbY67g0OnYvpS49745BtCQsXhQ0uD1N3WY
 FYMjqfnCR8d8s7WsrZ6GH7HZm3/9EKy65ozMKYrOknPq10CA6+QY8KJT0Sj1gN5/4CxK9DNJawS
 DbJq6pC7
X-Received: by 2002:a05:6830:6188:b0:7d4:bbc3:4efe with SMTP id
 46e09a7af769-7d4c4aee4f0mr3798263a34.27.1771107575535; Sat, 14 Feb 2026
 14:19:35 -0800 (PST)
MIME-Version: 1.0
References: <LV8PR03MB81379CE3BDF36A06DC1D517BA761A@LV8PR03MB8137.namprd03.prod.outlook.com>
 <20260214185409.GS2747538@bill-the-cat>
 <CAN7C2SAbayHsJWyKQE=trBhV-qFTdVTdV-pFCM-ji4tRzZoUTg@mail.gmail.com>
 <20260214204943.GT2747538@bill-the-cat>
In-Reply-To: <20260214204943.GT2747538@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sun, 15 Feb 2026 06:19:25 +0800
X-Gm-Features: AZwV_QjWJ3Zkwz1OMoZmG4e1xscfiCmFMDZTkSRWvfcBTiTXN_Q6ldTW8fL1q5s
Message-ID: <CAN7C2SB1icR_=6Ork3HCqxTGGFRwtZW25mmnpuPPALGb=9gvfQ@mail.gmail.com>
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20260213
To: Tom Rini <trini@konsulko.com>
Cc: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, 
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, "Maniyam,
 Dinesh" <dinesh.maniyam@altera.com>, 
 "Lok, Chen Huei" <chen.huei.lok@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
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

On Sun, Feb 15, 2026 at 4:49=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Feb 15, 2026 at 03:58:35AM +0800, Sune Brian wrote:
> > On Sun, Feb 15, 2026 at 2:54=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Sat, Feb 14, 2026 at 04:45:41AM +0000, Chee, Tien Fong wrote:
> > >
> > > > Dear Tom,
> > > >
> > > > This pull request updates SoCFPGA platforms with DDR improvements, =
new board support, Agilex5 enhancements and general cleanup across the code=
base.
> > > > DDR and memory handling
> > > >
> > > >   *
> > > > Add DRAM size checking support for Arria10.
> > > >   *
> > > > Widen MEM_TOTAL_CAPACITY mask handling in IOSSM mailbox driver.
> > > >   *
> > > > Assign unit address to memory node for improved memory representati=
on and consistency.
> > > >
> > > > Agilex / Agilex5 updates
> > > >
> > > >   *
> > > > Restore multi-DTB support for NAND boot and fix NAND clock handling=
.
> > > >   *
> > > > Enable SD card UHS mode and eMMC HS200/HS400 mode support on Agilex=
5.
> > > >   *
> > > > Fix DT property naming conventions for Agilex5.
> > > >   *
> > > > Exclude AGILEX_L4_SYS_FREE_CLK from clock enable/disable operations=
 to avoid unintended clock control.
> > > >
> > > > New board support
> > > >
> > > >   *
> > > > Add support for CoreCourse Cyclone V boards:
> > > >      *
> > > > AC501
> > > >      *
> > > > AC550
> > > > Including device trees, QTS configuration, defconfigs and maintaine=
rs entries.
> > > >
> > > > Fixes and cleanup
> > > >
> > > >   *
> > > > Fix GEN5 handoff script path.
> > > >   *
> > > > Remove incorrect CONFIG_SPL_LDSCRIPT settings.
> > > >   *
> > > > Replace legacy TARGET namespace and perform related cleanup across =
SoCFPGA code.
> > > >   *
> > > > General Kconfig, build and SoCFPGA maintenance updates.
> > > >
> > > > Overall this pull request improves platform robustness, adds new bo=
ard coverage and cleans up legacy configuration usage across the SoCFPGA U-=
Boot codebase.
> > > > Thanks.
> > > >
> > > > Best regards,
> > > > Tien Fong
> > > >
> > > > The following changes since commit f9ffeec4bdcf1da655a0ffea482062ad=
de78fee8:
> > > >
> > > >   board: toradex: Make A53 get RAM size from DT in K3 boards (2026-=
02-12 08:12:09 -0600)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/=
u-boot-socfpga-next-20260213
> > > >
> > > > for you to fetch changes up to 4b567f8e252e27f6dafdfe22de1bad147595=
e33b:
> > > >
> > > >   Replace TARGET namespace and cleanup properly (2026-02-13 20:35:0=
9 +0800)
> > > >
> > >
> >
> > Hi Tom,
> >
> > Actually I am also troubled by this manners:
> >
> > If there are patches that are not committed yet while new patches do
> > rely on the other holding patches.
> >
> > Under that background should the new patch that relies on another
> > follow the new one or ignore the dependent patch.
> > Keep using the master to develop.
>
> I'm not sure I follow you, sorry. It's hard to get gitlab to show the
> merge commit diff itself, but:
> $ git show 136faf7b0cc9
> commit 136faf7b0cc92af1d38b0db1bfaa5405e884ee2d
> Merge: 6caff66ce469 62f7a9460209
> Author: Tom Rini <trini@konsulko.com>
> Date:   Sat Feb 14 08:58:38 2026 -0600
>
>     Merge tag 'u-boot-socfpga-next-20260213' of https://source.denx.de/u-=
boot/custodians/u-boot-socfpga into next
>
>     This pull request updates SoCFPGA platforms with DDR improvements, ne=
w
>     board support, Agilex5 enhancements and general cleanup across the
>     codebase.
>
>     DDR and memory handling
>
>       * Add DRAM size checking support for Arria10.
>       * Widen MEM_TOTAL_CAPACITY mask handling in IOSSM mailbox driver.
>       * Assign unit address to memory node for improved memory
>         representation and consistency.
>
>     Agilex / Agilex5 updates
>
>       * Restore multi-DTB support for NAND boot and fix NAND clock handli=
ng.
>       * Enable SD card UHS mode and eMMC HS200/HS400 mode support on Agil=
ex5.
>       * Fix DT property naming conventions for Agilex5.
>       * Exclude AGILEX_L4_SYS_FREE_CLK from clock enable/disable operatio=
ns
>         to avoid unintended clock control.
>
>     New board support
>
>       * Add support for CoreCourse Cyclone V boards:
>          * AC501
>          * AC550
>     Including device trees, QTS configuration, defconfigs and maintainers
>     entries.
>
>     Fixes and cleanup
>
>       * Fix GEN5 handoff script path.
>       * Remove incorrect CONFIG_SPL_LDSCRIPT settings.
>       * Replace legacy TARGET namespace and perform related cleanup acros=
s
>         SoCFPGA code.
>       * General Kconfig, build and SoCFPGA maintenance updates.
>
>     Overall this pull request improves platform robustness, adds new boar=
d
>     coverage and cleans up legacy configuration usage across the SoCFPGA
>     U-Boot codebase.
>
>     [trini: Change TARGET_SOCFPGA_CYCLONE5 to ARCH_SOCFPGA_CYCLONE5 in th=
e
>     new platforms this added]
>     Signed-off-by: Tom Rini <trini@konsulko.com>
>
> diff --cc arch/arm/mach-socfpga/Kconfig
> index f2e959b56624,3a9e018ce234..aec0fb7b1c8e
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@@ -237,7 -237,15 +237,15 @@@ config TARGET_SOCFPGA_TERASIC_DE1_SO
>
>   config TARGET_SOCFPGA_TERASIC_SOCKIT
>         bool "Terasic SoCkit (Cyclone V)"
> -       select TARGET_SOCFPGA_CYCLONE5
> +       select ARCH_SOCFPGA_CYCLONE5
> +
> + config TARGET_SOCFPGA_CORECOURSE_AC501SOC
> +       bool "CoreCourse AC501SoC (Cyclone V)"
>  -      select TARGET_SOCFPGA_CYCLONE5
> ++      select ARCH_SOCFPGA_CYCLONE5
> +
> + config TARGET_SOCFPGA_CORECOURSE_AC550SOC
> +       bool "CoreCourse AC550SoC (Cyclone V)"
>  -      select TARGET_SOCFPGA_CYCLONE5
> ++      select ARCH_SOCFPGA_CYCLONE5
>
>   endchoice
>
> And this is the simple and obviously correct type of change custodians
> are allowed to make, if they don't want to push changes out to being
> merged even later. The symbol TARGET_SOCFPGA_CYCLONE5 was globally
> renamed to ARCH_SOCFPGA_CYCLONE5, and so could have been corrected (And
> SoB'd) by Tien Fong. But since this didn't go through CI, it wasn't
> caught, so I fixed it up, rather than push everything back again.
>
> In some cases, people will develop their series and say it depends on
> another going in first, for example:
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D489945

Hi Tom,

From your example applied back to the current patch.
In this case the new boards are using old naming due to the naming fix not
being pushed and committed yet.

So in this case either it is using the old symbol and mentioned in the mess=
age
during commit. And as your example "a" suggested.

OR

New symbol (yet exist) and also mentioned in the message.
By "functionally blocked by" ....

Thanks,
Brian

> is functionally blocked by:
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D491484
> and the cover letter notes this.
>
> --
> Tom
