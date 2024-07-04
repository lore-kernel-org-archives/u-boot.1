Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D14FC31D97
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 10:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73996884A7;
	Thu,  4 Jul 2024 12:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=bade.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=bade.nz header.i=@bade.nz header.b="UvJiHujK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C1D387FC8; Thu,  4 Jul 2024 12:47:25 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E836884A7
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 12:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=bade.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leith@leithalweapon.geek.nz
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5c479e5f6faso252728eaf.3
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bade.nz; s=google; t=1720090039; x=1720694839; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1UpDtKkEAKs7pPx3mM0bJR/0Gij0lT+SrysUbNP0h0=;
 b=UvJiHujKxJyJhsuxQiwTL41bgLQzvn7fSHhDQCHgjrxhqr00pckEm0VaD7KO64WOmd
 vUml30tQHS10A54scx2u3tY9TmgbRpsGOn7+xhLKBz7jEn9JlbnEdlRqNukO0l+m2/ys
 SzxxdaB0GqsWJSMTu81yqbwP6VXwFO31W/JyputH07KTy/qo5fjQC8GRZEhDudWPi0mg
 qg0Sc9mPshcEYvNxXrJW7HJ5nkUTGhf6ds0QasLGY3BSRn4iwE+mm2o6yEEpQFE/8lg6
 OYBx4FFdkNIM1fP/J2+2DJvzxhFClIM/cm21PzGEDywipPdlF2l9sN/xWBVCIHz31SjH
 4WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720090039; x=1720694839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y1UpDtKkEAKs7pPx3mM0bJR/0Gij0lT+SrysUbNP0h0=;
 b=YcIgxbIb3weu1iIfTJbBXp8YBZWcj/k4uB1mZKgcUT+/VAJm6QmrvjzbdGE9vBqPK4
 ltgmVRn5f7X0L4+8V9dmKECJ/RCNcS+SWSbPnDB3eI1KS2Np1dbWIu9bx94GgHxyST6S
 QJWrOb/gSniVtubvw1zxuO3NQBL3rwqjopI2xyURlq5ghNycTHvYuNn9ctGKcGirXxTj
 +M9ix7Pt12sWLz5V9SiJT7E1noe4SHN4f13SBufMBe9as9qehsrMRKKb5WRJhlsnoG/C
 Hh9pSP5JLptDLCQMOLCOSdD55VKxrgKtCiQf6awUAnZkUZw/KA05UJd0MstAmg29ld0I
 WOUg==
X-Gm-Message-State: AOJu0Yxa/Dw0Nym8wce/U+K3xKTBcXOWoaQVCQeUBSRuWr8j3VmRsU2B
 ZxRJYtoZwC9G0jR/tJHM+2jrapxTMhPVjCgcALZaLB8oAcULlWDsfbosHT5F8FDW6YauacyvzTZ
 DshSkHoLrTjInL1+OFESNviKNKpU8YR8SMtyn
X-Google-Smtp-Source: AGHT+IGw3E6iu+n/nPmM0vam+LR8HMBR0TYgzl3SWZIzs8deeDApbntIy+Y3S8qJde0kEZuTc9vDPGpqSufqJ3K8Flk=
X-Received: by 2002:a4a:55c9:0:b0:5c2:222f:7e33 with SMTP id
 006d021491bc7-5c646e1a0c2mr1895140eaf.3.1720090039543; Thu, 04 Jul 2024
 03:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240703084035.2891892-1-leith@bade.nz>
 <d33065b98c1e610f766dc6c322c2760d5d4810f5.camel@mediatek.com>
In-Reply-To: <d33065b98c1e610f766dc6c322c2760d5d4810f5.camel@mediatek.com>
From: Leith Bade <leith@bade.nz>
Date: Thu, 4 Jul 2024 20:47:08 +1000
Message-ID: <CAPDEroUmBW3YVSxNg713rz01TRzeJ6C00+46SGxfgwKHPwsWBg@mail.gmail.com>
Subject: Re: [PATCH] arm: mediatek: split config into separate options for the
 board and SoC
To: =?UTF-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, 
 "lukma@denx.de" <lukma@denx.de>,
 =?UTF-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?= <Sam.Shih@mediatek.com>, 
 =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>, 
 "trini@konsulko.com" <trini@konsulko.com>, 
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "jmasson@baylibre.com" <jmasson@baylibre.com>, 
 "seanga2@gmail.com" <seanga2@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <Ryder.Lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Weijie,

> I have a better example for reference:
> arch/mips/mach-mtmips
>
> ARCH_MTMIPS is defined for the entire MediaTek MIPS platform, same as
> ARCH_MEDIATEK.
>
> The mtmips then defined its SoC families:
> SOC_MT7620, SOC_MT7621 and SOC_MT7628
>
> Each SoC has its own folder and Kconfig, e.g.:
> arch/mips/mach-mtmips/mt7620/Kconfig
>
> Every SoC then defined its own boards, e.g.:
> BOARD_MT7620_RFB and BOARD_MT7620_MT7530_RFB
>
> So you can define configs like SOC_MT7622 (not just MT7622), and treat
> TARGET_MT7622 as a board, selecting SOC_MT7622. This will make sure
> all mediatek chips have unified SOC_MTxxxx
>
> Other device driver can then be changed to depend on SOC_MTxxxx

Thank you for the quick response!

I will go study that folder and update my patch to be similar so there
is consistency with the other MediaTek SoCs.

Thanks,
Leith
