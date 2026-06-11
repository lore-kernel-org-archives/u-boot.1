Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C620CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 505718407D;
	Thu, 11 Jun 2026 16:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B+cgr0se";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE25B841C2; Thu, 11 Jun 2026 16:53:46 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1DEA83FF5
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-396753f343aso80572221fa.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781189624; cv=none;
 d=google.com; s=arc-20240605;
 b=Tl19CoN0eTfFcTWYlq7wn3GIdhnN0VPynqwMZy4QGkOzRroA7HqyrSxj4EFXqkIRWn
 fy9lTa70S28b246AiNgWQ+YQgO7R9UfmE7ClJMg5WqQdnXmHNAgIeFGuClLkFfJd6KbN
 Cy8QElXp2LH+dJcvsdtQ5fMGrjOnxr7wht45O+PmPNlJ5ERFkGX5S9m69mOoOLOBIPB0
 F9i6Gg72mJ3BgOspe3+n9pKnrgIoPg50tRuNGOmEAwRfLYJ/U7juN6441BaN3cbyP4XH
 7d0abm/qxcyPJwvBeOS8zcOJ4+EmprqIWW8wUgTZIRNMfkfEFCYc+Kd5EtLi23SAzqs9
 f8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VojQjuhBNmjKszSqXfkKYBVqioSNN/IerMu1vDYbw+s=;
 fh=3KNw0hr4Jv66fITXUDFwFtvdEzmrZAVlm8m4QbIfaI0=;
 b=H+W3pz6Z7YpIIBcJxk22L9MRMoHkU8kCKOcZ68ay6z/7zvckREDFNYVyJPxzmIaTaK
 p8qLT7xUeTNSUISqcGtYDppvAkSNrcIkruY3e4WKn1i/1Cleg/fFgdDxZjPg54CSEuJ9
 IxgtnoKpJzoxQ/zWys1PLC5IxSm4fjMTjFIoQ5sDsyVlJEEmSElX39jcmNa6Ed9bh9wz
 wDLuUV/4vgxlVVtMsiMshGKhVmTj8et5F/yicjOYlnX4/kyySPdc1Dl3ypvNuLza9nZt
 IFMaNSSoQ+d6dfYw/KSk/Ekp6kAVcnrVOOU22YdngA+GrUz+spCBK330oYZZaJ3PtQyo
 clkw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781189624; x=1781794424; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VojQjuhBNmjKszSqXfkKYBVqioSNN/IerMu1vDYbw+s=;
 b=B+cgr0seW4EYwOVZlcVT/XdEAE/3DbnnkDKEa7lbgmDpXdHDtxzJ0qhmZj3fU5iV36
 GqIJ4UExJhmI7MDmxnOuK5EVTKy2iDwRdS78WQHP2HcTDoaOVHJSY+TI1mh26hLZ4wg2
 aK6irh699FIi/iqqXMRSQLiz6EX0ESUyr1xJHkA36nwumCP7pxftKbh6NJterqUHYBuL
 ojFGrSGM1FGhW+eb8obLaV1ASE4jFw7TlyFe1KOwGj32EZ25srZYh2EnoRx+2xBj4aBl
 Osv1X5JJI5IpYLvUKuNuZn04ohGiWn/iVQ0bnoocs1sxYKZbWbNWUeqqjJ0LGllbvSHm
 3qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781189624; x=1781794424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VojQjuhBNmjKszSqXfkKYBVqioSNN/IerMu1vDYbw+s=;
 b=rM1uHG7O8tAPc2kqk44FnupLOCiz//4yBiHKoM4JYPViHI2whJQQ5HmSU+b0cL2l1t
 VUR1GeRnMwhBin5fzVHElWw7dCTVxw5Nywf8pjzmu8LdY8ALL4QxDVKCkO4Q1lB/YfgP
 1IX18q3cW6mtR+v1n/bFFcVuZMynCLWxNP43usSnnJzET8EwpVQ96nUJHjA6nbfva8Vc
 itMcV5hXUdRN5Omivq1thxE+O1gOX/rzXotrky+/vqBltXy5f7slXh8zdNfic43bjOSt
 yiAu1QSPIBmqRm8Rct9JpoWF8Egsszw0yAyxe88cmHc9dDa60Koof2wYqLwB5VxAxq0M
 6e4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1959EZMlyR/roT6jmenEinXevwss+GJv0O3hjPl7uIz9244Q0gdneP0pTHCG30i+uuDmG1kY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzmi9TC4mQ25mfDg4SF/QdqywCQoE6MW3mvjedTTuHZkNap6ULX
 KGnkFxBWZy9PRrw3KJ01VxZCdET+wJW3FsLF6iE/7ulBnpZ8WAc2PuO5Jvdr+Ahylhj4HUCfvdz
 X3Wifnk9gOTIpFpW/RQ29GCxQSlyglpU=
X-Gm-Gg: Acq92OFW2xzOpHd/uzFxga/hzf1Cj8CmID2v7z3GcHEsQR9fKYiGiq2/O7lQ4zSn833
 FDO1js2O50aceEVeb0FhPAgACiiPxEor6zOeLOBV9vp1YPDOZhO5P6NOnJylnJj0pbFNOibzpuW
 MSwEniSEz2aEzOv8u62n5f4UYD1NSQWCCGxA6SQbVlKggfwVuCNaZoRmmb/DaVbM8X0gEAonX1B
 27WY7Gmdo0cRMAIW9SLiBeHB+Rc6dAz2lvh9tPvL3SimXLrzNHV3AqBmE7ZgE99XDHpKndfKULl
 tT7aZxtGoNlrJm8mEa11yujfiD/QPEbb+Y51TkW5wZVJCo1J49IW9coTJ0zUQ5iA7bzSGM7OsdH
 pulfRCRg=
X-Received: by 2002:a2e:9fc6:0:b0:396:ae32:860 with SMTP id
 38308e7fff4ca-3991a0e14b7mr9581391fa.16.1781189623626; Thu, 11 Jun 2026
 07:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <3208216.Ym5mLc6kNg@nailgun> <5857153.7ts2hSHzFV@nailgun>
 <a22e9862-8718-48eb-9eb2-ecb51209f672@oss.nxp.com>
In-Reply-To: <a22e9862-8718-48eb-9eb2-ecb51209f672@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 11 Jun 2026 11:53:31 -0300
X-Gm-Features: AVVi8CcPAaEXhDoPZXNKsUSgFrq0mKu15457Mp_nftmIdSoGD-jLtShdI3A1YEM
Message-ID: <CAOMZO5AOMGgf-iHL-504ZTLjG4-_LhrPAMQbG48tuqfrEVamwQ@mail.gmail.com>
Subject: Re: TZASC misconfiguration on i.mx8m
To: Ye Li <ye.li@oss.nxp.com>
Cc: Richard Weinberger <richard@sigma-star.at>, u-boot@lists.denx.de,
 alice.guo@nxp.com, 
 peng.fan@nxp.com, upstream+uboot@sigma-star.at, ye.li@nxp.com
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

Hi Ye Li,

On Sun, Jun 7, 2026 at 10:53=E2=80=AFPM Ye Li <ye.li@oss.nxp.com> wrote:

> We have discussed this with iMX optee owner. The fix should be done in
> OPTEE not u-boot.
> 1. OPTEE uses secure memory, so it needs to re-confiure trustzone to
> meet secure requirement not depending on SPL setting.
> 2. SPL also supports Non-optee case.

Does NXP plan to fix this?

Thanks
