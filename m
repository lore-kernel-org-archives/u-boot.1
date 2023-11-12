Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CF8C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 04:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0DD986C89;
	Sun, 12 Nov 2023 05:02:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kUKJ08ke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 143CA86F88; Sun, 12 Nov 2023 04:40:08 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE2986F1A
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul@gmail.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-da0359751dbso2743486276.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699760404; x=1700365204; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VC0PBNq9PihDxsNcegP2V44g9YKqjLa9VXxaCvVAuDE=;
 b=kUKJ08kedJ6AYfBqkWpvn7GkscCYmYKEL87z/e84QxvhDDLOwIWXBQs5ppu3njVedv
 kfau2mcvHaJ5Bna20Ujf/6cOaqUnPrgFFEDtPll9ajMxrc6C4i/ofIJs2zsTe/NQ5lxx
 JzwRBZxFUVvrkQGKtegK/HPFasdeSl1TVLzwda6QYt07T0itmJBenbf0oeScJLtxKCNA
 SOq/MAdXhGYE/n2qD6YeN12/d7Tzn8F4Hk8uNWfrt0l8fBAwo7L1pAyVSR7q21iqBPtx
 KzSIbc1K2aCerP+qT5VxIPnHxk3acMGloErH2RJjBUE/gAfzUtFud32mBwA0DW6PCGoU
 licA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699760404; x=1700365204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VC0PBNq9PihDxsNcegP2V44g9YKqjLa9VXxaCvVAuDE=;
 b=K2AhmhWiQbPAU2WEERmE1XOZ0eSVBsQiEYerjTGysQWD5wsfkKGiAczzI9x5agCadR
 07bVaUUjirSv80gCdZt3Nhu00X0+ag/+vzn3itPwakm+VYhp8qcchuP7Y3g1hDrKWRj1
 1nQ3/e4CltftD2y+rCS4kacz+orBhH+1qBmThUtBFG6GSzDIhF2SWJNts2vn4QBazD9w
 fWKNXR/aV9uKDp6G4QXv4lDHmFUF8Q+Vmu/Pidk1ELhQToHuJ453OFcLLcGhFXWDERWi
 7D8IDuL9ZBq/rm+Ftjf3/ZM+svnjSuXO6xHNI59m3JX3HOE5/gwh/WcOitYogJ5oZBdC
 t0GQ==
X-Gm-Message-State: AOJu0Yy/4DqW7PzQMJiM7390G0PujB250A6SXuT3yT/ok7iSkuWDhf9X
 jj0t0T7l/iZN6WPzypESf2WhU+Us5qU0gQ8t0Vs=
X-Google-Smtp-Source: AGHT+IFuHnHoZFVmd1tKZ7RYZMU4IKSzed5Lqhd5GExRbb+yMPslmg6jQYVmfoP3VqdhRZNe8l6js1PzklHqC5tzoLA=
X-Received: by 2002:a25:248a:0:b0:d9d:1048:b90 with SMTP id
 k132-20020a25248a000000b00d9d10480b90mr4133424ybk.30.1699760404170; Sat, 11
 Nov 2023 19:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20230804110448.24589-1-macpaul.lin@mediatek.com>
 <78245d2791000a64ca123db0ca4c063f2e1928d7.camel@toradex.com>
In-Reply-To: <78245d2791000a64ca123db0ca4c063f2e1928d7.camel@toradex.com>
From: Macpaul Lin <macpaul@gmail.com>
Date: Sun, 12 Nov 2023 11:39:56 +0800
Message-ID: <CACCg+XOX9fNb4wbtsFMOH12Lu7COqoY56mSqVx7k_dPohBPUJA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm: mediatek: add mt8195 SOC support
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "macpaul.lin@mediatek.com" <macpaul.lin@mediatek.com>,
 "marex@denx.de" <marex@denx.de>, 
 "fparent@baylibre.com" <fparent@baylibre.com>, 
 "aouledameur@baylibre.com" <aouledameur@baylibre.com>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "bear.wang@mediatek.com" <bear.wang@mediatek.com>,
 "sam.shih@mediatek.com" <sam.shih@mediatek.com>, 
 "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>, 
 "Ryder.Lee@mediatek.com" <Ryder.Lee@mediatek.com>, 
 "weijie.gao@mediatek.com" <weijie.gao@mediatek.com>,
 "pablo.sun@mediatek.com" <pablo.sun@mediatek.com>, 
 "GSS_MTK_Uboot_upstream@mediatek.com" <GSS_MTK_Uboot_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 12 Nov 2023 05:02:50 +0100
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

Marcel Ziswiler <marcel.ziswiler@toradex.com> =E6=96=BC 2023=E5=B9=B411=E6=
=9C=8811=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=884:24=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
[snip]
> > Changes for v5:
> >  - Fix Copyright year to 2023.
> >  - Fix memory map in dram_init() to support 8GB onboard memory.
> >  - Add '#if !IS_ENABLED(CONFIG_SYSRESET)' with reset_cpu().
> >  - Correct reset_cpu() function prototype.
> >  - rebase patchset to v2023-10.rc1
> >  - Add missing arch/arm/mach-mediatek/mt8195/Kconfig.
>
> [snip]
>
> I finally got my hands on an EVK and gave this a try. However, I did not =
get that far. This is with latest
> downstream TF-A as I still struggle with upstream there as well. Any idea=
s?
>
> U-Boot 2024.01-rc1-00056-g5237f2b48bb (Nov 10 2023 - 15:33:34 +0100)
>
> CPU:   MediaTek MT8195
> DRAM:  8 GiB
> mtu3 usb@11200000: clks of sts1 are not stable!
> mtu3-peripheral ssusb@11200000: device enable failed -110
> mtu3-peripheral ssusb@11200000: mtu3 hw init failed:-110
> board_init: Cannot find USB device
> initcall failed at call 00000000ffe46a50 (err=3D-110)
> ### ERROR ### Please RESET the board ###
>
> Cheers
>
> Marcel

I'm glad you've get a board and tested our patches.
Currently we're busy on other tasks so the improvement to the patch v5
has been postponed. :~(

These error is because the power supplement settings are in the later patch=
es.
Hence the clock might not stable for the cold boot up.
You can just press the key on the board and warm reset it, the clock
issue should be disappear.

> mtu3-peripheral ssusb@11200000: device enable failed -110
> mtu3-peripheral ssusb@11200000: mtu3 hw init failed:-110

You can refer to the user guide and public domain code.
https://mediatek.gitlab.io/aiot/doc/aiot-dev-guide/master/sw/yocto/get-star=
ted.html
https://mediatek.gitlab.io/aiot/doc/aiot-dev-guide/master/sw/yocto/get-star=
ted/build-code/build-steps.html

The latest u-boot code is here.
https://gitlab.com/mediatek/aiot/bsp/u-boot/-/tree/mtk-v2022.10?ref_type=3D=
heads
--=20
Best regards,
Macpaul Lin
