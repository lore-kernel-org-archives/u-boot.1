Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2471FD0D146
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 23:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8521983A2D;
	Thu,  8 Jan 2026 00:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AJkZ7mR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A8983A91; Thu,  8 Jan 2026 00:52:53 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A0E83A2D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 00:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-59b6c905a46so1507320e87.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 15:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767829971; x=1768434771; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mt9oosdy3BaPnia7DFqvfxI2Bb0vy6lp0mQhI+q2jRI=;
 b=AJkZ7mR/JnvSTEI7KwGrXleICmk815nMMs1Hc7c9UUBrE2xWiO72MWj1+oNCTqscez
 7mXgcFk4ugRlbc64LdMD+sZJWYRvQxUUEzC+yP3zsHinM0P/AS73aoAPB4sNZd9zTRJE
 jFTOuUn7zBtRq4Od7xFm9i1+/45Rq2mWO/ieroy/05MUTefYqnc244MFeM4EsynoBRw3
 dTt5akxdI6RWL++HL1gH1BJvK5hfzihEPArlPtnt4bW3tXh88yareDPDDRrmx/sczeqQ
 lsTLVXBRO/0X4U4Dw4suwIRlH6FbIjE6jcGO826wtwBzlmlgC9d2IcWR/oQb851AXs8T
 KWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767829971; x=1768434771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mt9oosdy3BaPnia7DFqvfxI2Bb0vy6lp0mQhI+q2jRI=;
 b=E1difmC1+PyLqzBCOsthGtUeYsNi88Nx0l3hFsaFXgRIq7l18tJpzzuuwqLd+Esdv7
 Y96IadNpNmHNllpSRRfFJq+8qSuFpITejf8nzHNPUDMo6t77zON7vxFFFqxQYF3acsQp
 IU195P7gd49rUYd3G/RMNKv2IZ3yf/MGaHE4WSTslYsgqjDDJ5g68lsybOSYCA/pi4+D
 p47zbmvmD4Pm5fqj9KTxHmtytKn8beP/umDJu7my2TL/8BYm/MDWP5MWl9wyTEGiMRsW
 ml8iRtdKu5mA33u7AOQERjm074T+3Jj9dbNlgxspmnb7HGVCf01GDCPCyquwcBgQTAxa
 VZUA==
X-Gm-Message-State: AOJu0Ywg3mpYUyaYOZNNcLg6WQ+oUlDdAzbOKs10ec3prM+P0qQ3cW/e
 GK22pL00MeIcF5Bx6Qrjk8EXQh8Gy8icWqQIPLsXd3shK7CJ50Tesh/A2rxvGoQI+XkUSvK/BGU
 BuQSTI/AY2x0BtnvwK4VEz7H/W/gOPII=
X-Gm-Gg: AY/fxX5sY02V3WXYmMn6Jzypgrlx+jxbS9faF8c1WBGFJE2USO+6WwRzMMnBJ+yeVnz
 wc6+cwKNNveAW37kZkFtCx2MA2TD7un7EBBzDifJjMSZUYtaq0FOjogSOVsVwQzo4KE2b7wyXmg
 RflyNEicWMiWlqmPaDh/6+uBWzesMiF4ynAFZiZpi4JywN39R6+9yGuVDFmKLi54dGxmkPLOxap
 8G9TANrgiUSKg+1cLGYmVlllLOZQipz5nIVAEocFUdT+pxZpWm/+Cz6T5mmagnmlROcQVvdOphk
 9JWaqLBS/+dhv6jgxB4tUSwQgoakV5c9cR09zA==
X-Google-Smtp-Source: AGHT+IFprGj5HrJAkyELiYhn82zmIic4/UTBAAoQ6+RqDR72uab5+fWe+K3JK0AI2oVzn9hr/kJ85qesPK7s5IReGAQ=
X-Received: by 2002:a05:6512:b95:b0:594:5545:b743 with SMTP id
 2adb3069b0e04-59b6f036b60mr1558578e87.27.1767829970351; Wed, 07 Jan 2026
 15:52:50 -0800 (PST)
MIME-Version: 1.0
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
In-Reply-To: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Jan 2026 20:52:39 -0300
X-Gm-Features: AQt7F2pvHL7Svcgd5gs6aWMJzdtH1BNTn7FTHbaYcfv7rKi95vDNoxmKn-dCGA0
Message-ID: <CAOMZO5CCRpeE4y2uc+13wKnnQ3BZjEzreNtzs8kQyRcKrvyNEw@mail.gmail.com>
Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
To: Vitor Soares <ivitro@gmail.com>
Cc: u-boot@lists.denx.de, vitor.soares@toradex.com, peng.fan@nxp.com, 
 jh80.chung@samsung.com, trini@konsulko.com, tanmay.kathpalia@altera.com, 
 marex@denx.de, tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
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

On Wed, Jan 7, 2026 at 8:45=E2=80=AFPM Vitor Soares <ivitro@gmail.com> wrot=
e:

> Verdin iMX8M Mini (SPL failure):
>
> U-Boot SPL 2026.01-0.0.0-devel+git.53c0d5b38795 (Jan 06 2026 - 20:44:27 +=
0000)
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout=
)
> SEC0:  RNG instantiated
> Trying to boot from MMC1
> unable to select a mode: -5
> spl: mmc init failed with error: -524
> Error: -524
> SPL: Unsupported Boot Device!
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###

Please run 'git bisect' to identify the guilty commit.
