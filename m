Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D279CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E5DE84987;
	Thu, 25 Jun 2026 14:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GMY9kpE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84579848F0; Thu, 25 Jun 2026 10:36:59 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 499EB8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjm2473@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-9225cc6fbb8so167684185a.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782376615; cv=none;
 d=google.com; s=arc-20260327;
 b=Xiyosu/rZmCuikK3vOtwF6lfhleoNbUUTegYbDuhyHrke7tvC+i4GjjRJsaluJaq9J
 kEKqCnAgfDRurH7j+CuAt/FebFF2rrHmO5hYu4mnBx4ykG+FrbDdc/xb42QYoHu1+aiJ
 Eyi7VFzekX+j71cjmvslM8FEvkw2l85nFXC51wRbQUDLUMPsf68E9ouLqMsg0pX6GNU6
 4NJUO53u8UlSL1/DKetUY6HvYl92T4/g36VdLZJOwlM9YM8niMuV96RgfQWXfMs11U0K
 WK6zM0188Q3SnstwMXpKF0yI1lu6jF2QDtxeRT5k95w+3FxCFs/lJzMaj5k3tzqBD3Lo
 2Kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TO0c4LLNDXJWMczCcngkTO41yJThlxlEaaJC97DL2lk=;
 fh=x73HISMD02Ddlm4UL9P4qFt+bKnpXc6gYNbl/Hv7Q+Q=;
 b=Gj/LA2nVqbOlzwNXJXDnMtFE7ebZhfvkp/QVgQKHjHZL8SieHe98DRiNO0DfKkFLhk
 pEvoi9ytSnC4ofg+2X8dAyCWO2bgJ8ws526b63FMV+f5y6tS1x7J1gZZDclaZCpHY6Ns
 1pUeL1CbM7en5rHEEtOgH9kkt6Vk69AzC3wxT/tOJy0KxDOBOLUj0G90LsK7dsMUDcCn
 TPZ8b+jpYpxCJqFOG38kcHIDgFJtwXsGKVGIacEepqSlV2J/Z9h7Z7aLIHixCWotWvp9
 NAO2QByNUeSmkbCAVnGbIKwfAFHqnqFoYso4KmZvAuG68AzcvT86Otd9YNXCA46gNp3i
 IFYw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782376615; x=1782981415; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TO0c4LLNDXJWMczCcngkTO41yJThlxlEaaJC97DL2lk=;
 b=GMY9kpE+qVIivzCklZ7ESGT94sDcFFzjhnJpAcM0IkJVTavuY+pPCVfh1/fBDH2Ewd
 Xt1O6f1ssPqXcM02N/Xw6KrlB43OPcArJs1bvQhl5tNnF8IpM1Ggsn5gVuHzlu4hJuCg
 gfEctNUJD3F7x0Vj8RPDsPGyUNxwrUmODs9M1FsMRxs4II0WDMduyYqmoLlDkjCg6CxN
 Frvw6YMtgIiF92zFgiYBTIGP/JVeapWJ4pW3Xc2ibWtzEVSNaZnYF8v40MpNHOmHj1D4
 cJxPX/0G8qi8yLtVlsyIO4okgnluCD+CZUFtFLGy7unIzVCcUhPExEosyM02bebrytUf
 G/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782376615; x=1782981415;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TO0c4LLNDXJWMczCcngkTO41yJThlxlEaaJC97DL2lk=;
 b=Qpkb0l9v07CMNvR5bh2iyvxbdLt9qhsMQY3iCtDlyznHcpWjXXtop0Whs+GjlGMTmR
 y60LR7AN+/uUak3bXZcriZHd8IrM1a6lzlSppzuhZoHXxSNB5q4UrVX6swEBcRkkBQmN
 BoUksZ4Zcruwtfz3j89sWfIOCHhkt4SoKi2ULIint6sTbRTfmLvMsatcHpDOGRBqqfhY
 pJFHR1raCHJo7aTFRLy2/K/ECyTgioivHZjxo+GmGldk4laXi0ODzU1gh9VuGeg5xO4Z
 9EH3npE+LIqcObMAFO+qtrAloqUHAWtWVJ6oC+e6fr+mayUPs6upvWI2U4DWp5WAASLS
 d6rg==
X-Gm-Message-State: AOJu0Yw1N86z7NUKWC8sJr4cKmCSU/4rYhj235cI5lgtqjePjzQAjcnF
 c2l1PIu9WUvmh8utJOjZRtabPJM4gPKjAN82wCgZ5xfPVib/8wV+6hXpLe6L2kDdo9hEeKit/4r
 7gbtA6ueycgT7TijjhBNI1AKlg0BY1yX1fFF6BY6gNg==
X-Gm-Gg: AfdE7cnLi8JC59ydO6K0cwOksYnkPN9Y9sd5WKHWdJQyQZAvcl2DcYxKgf1MlP5YJNS
 vNttJMMaqrPRJsnOExI/C1r93MJgDSfcUsE55fXhZ3UC5/wjzPihiHF+emAc0IEbo3Pl3St9w9a
 DEyyteb7GyqVBSDAp0Jjt7/Yig6YeDckQh3BcmldocMcQKysPaRhcoryDD0hrj53k0OznnTjVq9
 +kF3dHbF9UNmG+b1OZt5s6YVKqgyav52BP3S1/NTUWVQ2jhAWTQ4S5OFViGQW/eJBoTT/M=
X-Received: by 2002:a05:620a:2907:b0:915:e7bf:e6ff with SMTP id
 af79cd13be357-9293b474ff7mr177361785a.11.1782376615089; Thu, 25 Jun 2026
 01:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260512091532.97256-1-jjm2473@gmail.com>
 <20260512091532.97256-2-jjm2473@gmail.com>
 <b2b25f9e-336e-419f-b2a0-e5942df246af@cherry.de>
In-Reply-To: <b2b25f9e-336e-419f-b2a0-e5942df246af@cherry.de>
From: Liangbin Lian <jjm2473@gmail.com>
Date: Thu, 25 Jun 2026 16:36:43 +0800
X-Gm-Features: AVVi8CdHL4kCQtpA57CwJpWQGTwd1fG3zWvQoWyV53XvEmz6y8P46uLwdIGelGQ
Message-ID: <CAP_9mL409bOVu1kg-y07ZxNpfdb--g8A1T2hUbRUetXfeMF81w@mail.gmail.com>
Subject: Re: [PATCH 1/1] rockchip: rk3568: Add support for LinkEase EasePi R1
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

Hi Quentin,

> > +CONFIG_LEGACY_IMAGE_FORMAT=y
>
> Do you really need this?

I found `mkimage -A $INITRD_ARCH -O linux -T ramdisk -C gzip -n
uInitrd -d $2 $tempname` in the Armbian code [1], so
`CONFIG_LEGACY_IMAGE_FORMAT=y` should still be needed, right?

[1] https://github.com/armbian/build/blob/main/packages/bsp/common/etc/initramfs/post-update.d/99-uboot

Cheers,
Liangbin
