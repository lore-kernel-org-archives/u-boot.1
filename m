Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4696C67861
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 01:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77CD48809E;
	Wed, 10 Apr 2024 03:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NAebWbP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC372880F8; Wed, 10 Apr 2024 03:56:08 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A0D387DCA
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 03:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7e7af556183so5518241.2
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 18:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712714161; x=1713318961; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kuDairqxyZ+jhmiMT5/gimp7lzdnFFFikKSz84/3Fc=;
 b=NAebWbP6Lc8ecYI1qBQbr/v0J/tPRBYaP7tg5oy18GrFuIQBJm0SPaoVA9UeZk/rWH
 Noq3lqEKWs44unLW4FDAFSxl7ATf9W+L2An3Ngv/TtP+KAnPigKIbYm+p25wIdOxQSIB
 yxR3wMsPgoriex5oMG08X7onVwMsu6/dKvuAtzR1BAx+1OZM1ExdM6Nwd8oxxo/LubK7
 sV2DPYmgtbbneVZHsumnKEPTu5DIG1y1WWd/LcFkJe6Yv1ME82thBc+daeLEHkWj8uN+
 y4vnNHV7/sYAwSnK7sO3MLFeA8hMxvTHMqPWTU1HpvIeiYrjMUYsQtAmiZQpMIrnZy4p
 CxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712714161; x=1713318961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kuDairqxyZ+jhmiMT5/gimp7lzdnFFFikKSz84/3Fc=;
 b=UhtsvXnSB3r0yPmGAL6Ub2isBFc2FZKHlajs7QFRGlqSQbKJI5DWslqs50faLVLID4
 Gmro/yzobHzwLkwlwkpBpU3yR2RhIJUgO8XSBEqyIxh0EzVNbJkevTlYNf0l2rhHqMxv
 ftLQoimUfNTGHX1aXKthBQPhvnIznJepIdwc2MX7dI9tq7w29ZvdI5YezrdaFzR2jwLr
 ioo/soSkXCenpdZjsaIea/s+uvldfVa8vyHNRaZwchhlaSk/cAf64vGAj6YkIaiLCAmN
 mW2Tv/i3PvK3B2xbv9H1SBkotpXhC6zPI7KScAEuAvO6PdZWkITzYWyRB60vhMTLqCQ/
 BTRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRha6QqOmKOLitVtk3HJUFlIxwGbZPSdL+0RF43QiGBVT0A/ysjqwmx/Jki4TjJrB2etGpcpKm8Oc6TKVJKlCsEjiADQ==
X-Gm-Message-State: AOJu0Yy3YgFDOTz+Hob4ix1apEmcJMLDl/f5M0VcZ2X0ma83qc/feeYc
 GoIe5JkasGwrK8fgMGPItQGGU7U7hmIH0NJ/+4eZooZJZLV0DWxsS/v92PlKd1mqyap7WjKucvL
 dCCmIrVXU2+LHjTUQmXsDPphiHs0=
X-Google-Smtp-Source: AGHT+IHdFRq2w69yBBEuhwEHXkEMWh+j20N+/n9HteZdRacqyb+o6sOO3AxBjz/xtjra8zzZx6fwGtqTiAOqgjwM4p0=
X-Received: by 2002:a67:ef45:0:b0:47a:217c:f1f with SMTP id
 k5-20020a67ef45000000b0047a217c0f1fmr1012945vsr.19.1712714161125; Tue, 09 Apr
 2024 18:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <1709694011-683-1-git-send-email-ganboing@gmail.com>
 <ZQ2PR01MB13079F11D2A7B2A20968F4FDE62BA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
In-Reply-To: <ZQ2PR01MB13079F11D2A7B2A20968F4FDE62BA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
From: E Shattow <lucent@gmail.com>
Date: Tue, 9 Apr 2024 18:55:49 -0700
Message-ID: <CANV2PTMPrQVZhWvNFxi8-RA0ZC4UAF1sHBbHiipUc01aWx6oqg@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Bo Gan <ganboing@gmail.com>, "rick@andestech.com" <rick@andestech.com>, 
 "ycliang@andestech.com" <ycliang@andestech.com>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "yanhong.wang@starfivetech.com" <yanhong.wang@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 "duwe@suse.de" <duwe@suse.de>, "namcao@linutronix.de" <namcao@linutronix.de>, 
 Xingyu Wu <xingyu.wu@starfivetech.com>, Mason Huo <mason.huo@starfivetech.com>,
 "chanho61.park@samsung.com" <chanho61.park@samsung.com>,
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

Original speed class SD cards fail with this change "unable to change mode"=
.

On Tue, Mar 12, 2024 at 4:12=E2=80=AFAM Hal Feng <hal.feng@starfivetech.com=
> wrote:
>
> > On 06.03.24 11:00, Bo Gan wrote:
> >
> > Previously PLL node was missing from SPL dts. This caused BUS_ROOT to s=
tay on
> > OSC clock (24Mhz). As a result, all peripherals have to run at a much l=
ower
> > frequency, and loading from sdcard/emmc is slow.
> > Thus, enabling PLL node in dts to fix this.
> >
> > Signed-off-by: Bo Gan <ganboing@gmail.com>
>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>
