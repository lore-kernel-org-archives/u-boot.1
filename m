Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D3C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE3288BFE;
	Fri, 19 Jul 2024 12:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZYYop1sI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EAF88B93; Fri, 19 Jul 2024 12:52:40 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7DE88B8B
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52e991fb456so1077611e87.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721386357; x=1721991157; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58/jv5tptFNOiwfxFhbasDAzVtRJkaZAGxlA4W5Tws8=;
 b=ZYYop1sIjcCh1ey0z66dBUjrEz+P2ldc4k0b1wC64rd5XuvPAjB5AMIhJDwNU9Gmeu
 BsGVxAYbwQL0EojdamrtQW5r0bhpim7A6BYl/Wy+HSjmmVhONNqs1RR+SedbW2BqInHx
 zsmTdNQv3ZEISC0n63KxWyRs/j9Lg3Xa96bEztJQngwVWjWycW6PbanRuCVfGgXUr57K
 SXLX+UOp6Hbo5nqOGV6/HnW8zUAKtJsk9K2vKaKnSsyt9esDnRqtHFRRCcGah7ra69Pb
 ek880GCQfp3RGgY/1GG6C2sequ2XfiFh7Vmir1ghdJK6h1TRK9+ET7baYFH1jZxomzh+
 99pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721386357; x=1721991157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58/jv5tptFNOiwfxFhbasDAzVtRJkaZAGxlA4W5Tws8=;
 b=Ud+cce/xwLNX9cvdzFs5KacyzQv2J1DTooIS8mMU5aHitFbN5kdf2kUxrOm9YNLHxt
 mV+soXemPd+fCJ+AG6XiQ+9fv1v2l3VM7eiZRl4Qiqj4wOcgOFrqe6TZipf78eWTNxFF
 KKtDLfroEG6hBaq8NePDm2R7Uav8evntmWrUmTrWAcXLWP1UdYEcFdXkU3QR18zoHmqu
 4mYtdwUsNZoDGym9yJDQNItvSCd+QM6S9Tnm1vR9KfbER2qPuHZcKo8I1SW5YIFzkKyq
 cpD/r1QnimWoSvwD5oZ0ur8X2sBifaJPRp4084aZY+WdybFSu5KBMYrefKMshm3BvPFZ
 R8xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjJoH1QvVbV4iFogQa44rNmjC0g5mg8rh/pvWV4X3jbRlfhkJ+HaRunpLE9QzaRdSA5n0qrkLf1himPeOBpddMHWRbUg==
X-Gm-Message-State: AOJu0YwFFRZ+t+31eqfwwf4sagbTzDDUV7ZR7FkqyRUb22dy3qeKjh0F
 HPBz16onuZ7eDaXEOWWflFhVFTDVnPNdijKyEptLRpDLDV19TYKmROYlU0kgM8xizjxHAsoxZHZ
 lUSv8MtbGBcByJ5IQkBPEqMN50l8=
X-Google-Smtp-Source: AGHT+IG8oZQ0npnXQUEY7YaoZDRcydfhBZ8hZanYKC3e90aGGaAfHYcMhkwRaqotdi8FLwfH5xNIzOUcyOCblDAqLIc=
X-Received: by 2002:a05:6512:6cd:b0:52c:ca8d:d1c with SMTP id
 2adb3069b0e04-52ef09e237dmr1272031e87.2.1721386357175; Fri, 19 Jul 2024
 03:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <1709694011-683-1-git-send-email-ganboing@gmail.com>
 <ZQ2PR01MB13079F11D2A7B2A20968F4FDE62BA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTMPrQVZhWvNFxi8-RA0ZC4UAF1sHBbHiipUc01aWx6oqg@mail.gmail.com>
 <0eda64cb-4ca8-f8bc-7515-6d2a2d3d4638@gmail.com>
 <CANV2PTP3o1Q2JPCZO8Ewfye+oz9f3TVNTYhYZ3EAKtdYAhvkHg@mail.gmail.com>
 <f355e582-cb52-e4c5-538b-26bcf69f0a2c@gmail.com>
 <CANV2PTOzgyzYSbNRJXuvLnMDAT-mDL8o1tU7d72qTKQDMdt_Uw@mail.gmail.com>
 <CANV2PTP2hpd5m17+_T7zp2V6w03d=0rgAuwukyC0LHVYxLtRuw@mail.gmail.com>
 <ZpZSmdrst4z_Q4JQ@swlinux02>
In-Reply-To: <ZpZSmdrst4z_Q4JQ@swlinux02>
From: E Shattow <lucent@gmail.com>
Date: Fri, 19 Jul 2024 03:52:25 -0700
Message-ID: <CANV2PTOgP0Nc=9gM9gA=hL6b3qkDDsmdP99D2bOF0U+7x4RKjw@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
To: Leo Liang <ycliang@andestech.com>
Cc: Bo Gan <ganboing@gmail.com>, Hal Feng <hal.feng@starfivetech.com>, 
 "rick@andestech.com" <rick@andestech.com>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 "duwe@suse.de" <duwe@suse.de>, "namcao@linutronix.de" <namcao@linutronix.de>, 
 Xingyu Wu <xingyu.wu@starfivetech.com>, Mason Huo <mason.huo@starfivetech.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Tue, Jul 16, 2024 at 3:59=E2=80=AFAM Leo Liang <ycliang@andestech.com> w=
rote:
>
> On Thu, Jul 11, 2024 at 12:55:05PM -0700, E Shattow wrote:
> > [EXTERNAL MAIL]
> >
> > Ping. This regression still exists and is now in stable release.
> > Should we revert this change or how must it be fixed?
> >
> > -E
> >
>

> Hi all,
>
> I think I could revert this commit for now
> if we cannot find the root cause and solution right away.
>
> Best regards,
> Leo
>

Yes I agree this needs to be reverted. There are more than just
failures of older SD card profiles within U-Boot, there is also the
failure of newer SD card profile device access from Linux Kernel when
U-Boot internal fdt is passed on to Grub2 and then Linux Kernel (6.10
upstream). We should test for these problems before bringing this
change back.

-E
