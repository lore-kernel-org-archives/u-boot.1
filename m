Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B35C531FA
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 10:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 094C4607A3;
	Fri, 24 Jul 2026 10:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ReJI97lVvXGG; Fri, 24 Jul 2026 10:26:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E53BB60B17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784888773;
	bh=RL/2n9haNUwcg5S6LbaB1rsfmfZiupXIXjkBgVDAc4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cWs5hDeCu2uNeT/ICdO1/s3oWQQZIlJR8Qco0qzo8+UZXkSnWuVwgDgiayL6DbCLZ
	 gmmlBwh1w0ztlBtlxAAa9gt9YaWK1yirdS0nH94T7Vf7G/m1Upj+WLAg6czkaVMu+u
	 1Q4Hvh5Ls5Xxpn02vPW71sZOoXKYQ7fqdG6FcFpLlVD2m6KPOu8DaEU9XAkKiuVF9q
	 U3uGnEH6LuR9mal2zmYLYb2KWQu0PJXe48bSF2KFJDrunYPxKECuSisO5K6Sd4iN7v
	 LkPtCbGAY6gusrqdlOgyNBJsMjxPJ95EnmMSAnosWCrZoifLE1+eF7UqnoW581xI0v
	 qmL8k/q9iPb3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E53BB60B17;
	Fri, 24 Jul 2026 10:26:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D5EB3B1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62E9C81105
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JdppEP1fFibw for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 10:26:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=briansune@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 157BC81114
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 157BC81114
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 157BC81114
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:26:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C83783E76; Fri, 24 Jul 2026 12:26:09 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A4C800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 12:26:06 +0200 (CEST)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e9d7464b71so79387a34.0
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 03:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784888764; cv=none;
 d=google.com; s=arc-20260327;
 b=ryhbyMldmFf1FOKZaTC8G7/E+ucwY8kgkN8gFmijSz2qWShb9wcjWvDVI7Hhkte18j
 qP6ele7lEbsPTwOtH8LZL8YFsc7ub6P7qOtkOj5VSeVi0tD7PcKEi2wJHw/GdSEQMB+d
 9QJk9riAIrsxoyytcO08oIl9O4AV1s8Bjgb2bM3pWto1cC4oKlqhqbcM0YtaLjWSLqsZ
 +FbkNWbY3bFkQ7x/UZDynvXheXGy2vRPH2F6nUPGD6vTBdwNb72gXndDto6le65hVy51
 E5aXO/H2kPos2k1vSSmC6AfK+sYHB5s0q+cflIF9FIx/4vIJRlodp7esxaluwY+TpSxj
 oD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RL/2n9haNUwcg5S6LbaB1rsfmfZiupXIXjkBgVDAc4I=;
 fh=UklOzYJJCxjFwm0+NorQsq/NTPP3gbaSoC1VPS/YTLc=;
 b=KcmXLXQDDVNqrs/YoE/Hr4x+inrVi9Y36SjFhteMR0AB9RE65+Kbfji7tPvYs5uJc7
 bpmCzV8ZESceNbKle61kb+sDYf8dT/nYPvWqOYfDY/NIeydFMLnai4IYc6i0MpYQXSrR
 N+tBOk5lZxE1jCH9ldYvUJ+ou+AtbptUS1/1lbMhEv3JTa6u5JqDIRFX28X0ZcEqNU7b
 dsTPqhPzaLUZ5tpjJF7efeuELWxHlh8OyWR85nOQ2Hh80BLtsjT27CXcRXFZ0JPjBVpz
 TCgu1Tozw0NaqDXAzzY6+WNbmXwUBc772vMkwNEqMS4YLeSeieeclWfM77gD/U4SVotJ
 CjWw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784888764; x=1785493564;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RL/2n9haNUwcg5S6LbaB1rsfmfZiupXIXjkBgVDAc4I=;
 b=Zkov4MEgrc7tFUuCy/X//YTOgMq+Y5D8EMGUurubZWeGSgvmEBM51oY3nmlRP3Ta+L
 cFhBy6EDS/E58NOzDafpWtCXhVzAtnaDGBzdnJCfNjvC5chBJEL61NNljbiH7+WZ7IM6
 Q7Q+A9W5YirxyF4VgzJ0mOezQgTkRFX1NdwWkTgKyTi/re3QVmwVEFi0hQmYhemtD+vP
 fpR8/KFgNgbl3boNSujtlzWHvzWiiWuaKA32YF3PgElY7Qb88qlcr65GNJoXz9j5xiGr
 uzdWa6fu1iXyu6Mtvce+sBu7zi+fSAY5i5OKkmtKtaR0BatjnAnpMnMaWqw4Kdv3XwXG
 sPnw==
X-Gm-Message-State: AOJu0Ywv9MTmyLaFag/2P6exn1+UtrUayrlu0obhTlHo9YyJRqGD27u4
 hLL4IbXX0FktqucLKoAm7N7QMK2nmtbvTzXqpZrS2kJFwOOCdBE87p2CK2hNH8MaFcH3w18neWu
 zyMpEAubNZCwKR/swgxvmKCUppwxLF4o=
X-Gm-Gg: AR+sD11BZZjy8WP3redsa5XLUew8LOjSGrTSXnagsR3pFHPVq0blNt0MdXMX6rPUrap
 iM3IJmyI16lOupwyDMRPxWZ9sKT0/tLh2LWoIuyLjv9Ijyirch78dIAzexc8BGPA/oWvk516FkA
 k77pCOOf1Nog28zSW79T1xwKo2sx/HpKS3djMLYMJjAn5rk6z8KYHW0MHvrE7dyOeDGY6UbWWON
 yMlGYTVl0zN0C9z7UnmXdOTzqFJtJor5eLBWX2Q+VpisHQ/StYybTDi9n+5/Dz7GWkhKS6gaw==
X-Received: by 2002:a05:6830:3741:b0:7e6:c9eb:535a with SMTP id
 46e09a7af769-7ee43a5164fmr3964138a34.6.1784888764515; Fri, 24 Jul 2026
 03:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260723024306.9888-1-alif.zakuan.yuslaimi@altera.com>
 <CAN7C2SDhSzVabXx+EswLksHbQSEyK4GxgkgUVG7Z3Kx7RdS6JA@mail.gmail.com>
 <a4a2481c-fa1f-411c-ac21-380b3a35a4c2@altera.com>
In-Reply-To: <a4a2481c-fa1f-411c-ac21-380b3a35a4c2@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 24 Jul 2026 18:25:52 +0800
X-Gm-Features: AUfX_mw606qmhUcH1LKITHuwtUXcDwC0Ti5HCZOdvSHMtSbq6rZ_obp3dIbS96w
Message-ID: <CAN7C2SCatXrdU-ObZWW=-sRAO2oa4chFu7pRsTVjcAaqs=w8VQ@mail.gmail.com>
Subject: Re: [PATCH] arm: socfpga: Rename TARGET to ARCH for SoCFPGA
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784888764; x=1785493564; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RL/2n9haNUwcg5S6LbaB1rsfmfZiupXIXjkBgVDAc4I=;
 b=Dag/DfeZnlH3XvowHnSAN25fwdWmBi6RrTeK0xdcZZnOPLN9vZJzMuef9bBURd+yRj
 osU5UpdFmHWEmjlgnueTejxD2QfgXHTgpjQ5Z1UmJeU4LHtEn13dD9BNncH2H/J+6gut
 cpvBoCg8ISP3mAnXP4i84ZvhqaecWZ6XMAjtGBW1EjgOwiQOdO4E3Lu4y8h28yAyT7nR
 n8jQRLfhmjZXIz5GvRpekfaymBqMhGFPjd7lfWASsMNBAKYSy0C5bKL/nCettt/KSnmA
 ehXA8JhumCH0be2oELPWT3UE9zrPLjDVinVwHQL8tbMXZk3Y6UeiYRMp7KAbbrIeZVuu
 SUPw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Dag/DfeZ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=briansune@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dag/DfeZ"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, Jul 24, 2026 at 12:09=E2=80=AFPM Yuslaimi, Alif Zakuan
<alif.zakuan.yuslaimi@altera.com> wrote:
>
> Hello Brian,
>
> On 23/7/2026 4:59 pm, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > HI Alif,
> >
> > Just reminding, duplicated patch:
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20260407153650.26404-1=
-briansune@gmail.com/.
> >
> > Which is under reviewed.
> >
> > Thanks,
> > Brian
> >

Hi Alif,

My original patch does grep the entire u-boot repository and update it.
However how T.F. redo that patch or any missing I did not double check
again.
Tom also noticed the new board's naming update is missing and updated
the naming as well.
After the patch applied, the board.c did not notice the missing renaming
but only the PL330.

I am okay with the old patch removal due to the title not properly formed.
I also suggest doing a full grep again to verify any missing.

Thanks,
Brian

> Thanks for the heads up. How about the fix for
> arch/arm/mach-socfpga/board.c?
>
> Best regards,
> Alif
>
> > On Thu, Jul 23, 2026 at 10:43=E2=80=AFAM <alif.zakuan.yuslaimi@altera.c=
om> wrote:
> >>
> >> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >>
> >> Commit 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
> >> replaces the TARGET namespace to ARCH for all SoCFPGA devices.
> >>
> >> Some of the TARGET namespaces are still left out, update leftover TARG=
ET
> >> to ARCH following current SoCFPGA naming.
> >>
> >> Fixes: 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
> >>
> >> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >> ---
> >>   arch/arm/mach-socfpga/board.c | 4 ++--
> >>   cmd/Kconfig                   | 2 +-
> >>   2 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/boa=
rd.c
> >> index b202ca258bc..b662afc1ad7 100644
> >> --- a/arch/arm/mach-socfpga/board.c
> >> +++ b/arch/arm/mach-socfpga/board.c
> >> @@ -210,8 +210,8 @@ void lmb_arch_add_memory(void)
> >>   }
> >>   #endif
> >>
> >> -#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
> >> -     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD=
)
> >> +#if (defined(CONFIG_ARCH_SOCFPGA_ARRIA10) || \
> >> +     defined(CONFIG_ARCH_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
> >>   unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
> >>                                                   unsigned long raw_se=
ct)
> >>   {
> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> index 35ce42f8397..b724f4f8d49 100644
> >> --- a/cmd/Kconfig
> >> +++ b/cmd/Kconfig
> >> @@ -1911,7 +1911,7 @@ menu "Shell scripting commands"
> >>
> >>   config CMD_C5_PL330_DMA
> >>          bool "Release Reset DMA Channels for PL330 Handshake"
> >> -       depends on TARGET_SOCFPGA_CYCLONE5
> >> +       depends on ARCH_SOCFPGA_CYCLONE5
> >>          help
> >>            Provides access to Reset Manager Per2ModRst. Enables DMA
> >>            channels for ARM PrimeCell PL330 via reset release.
> >> --
> >> 2.43.7
> >>
>
