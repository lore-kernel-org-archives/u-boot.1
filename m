Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FDFCD8C90
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 03:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDCE83EEF;
	Mon,  8 Jun 2026 05:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="kQVP+sed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 782F383FEC; Mon,  8 Jun 2026 05:07:49 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFD9807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 05:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bec49f7e35eso493660466b.2
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 20:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780888067; cv=none;
 d=google.com; s=arc-20240605;
 b=CQ/Xabz6TN9rUJNPPgkesNGjRcYRYI4IV1YkgAO3VHHXZ7NHRUcIFQC85EdQl44/sZ
 KuElIKcu+ASfE0dKLCD8Cp7+rYGIIZtdB8sk9gRHSmFVa3nGQtCr0EnMc04HGQkjW+SL
 02dd01GOPi+kbqjtnSlJWeAtfMybZteOaDWmUMqXjszV0lmHYOP1I4lxvqfdCNf3NZCO
 QCuoSHJDKXCMOTCQUX+VMcSxdHn+gtXOm5TqTLZRisaq/2d9m4ISeDqpmo/3sKLkrua4
 qwUMdWIhr27s8qmQeOZn0/WqNz9mRQK45T1lq/mm6frqqKtiflStLI7tJDmkAg/nH/T4
 vWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xWOzjGLrvCrPSz2mQnuh2MHQ1/zGhEKtPkgykB9GhQU=;
 fh=lWMgiRKu66il2kf42614CqMAYctVqLpJS/lbPDMcud0=;
 b=ZhGLBboJQrzRTdMygLAt2TjT3U3z70oELA+3dulNMS1YmCqfgdED97Tkl2eJRYuFH8
 8kOJ1kdGMWUkKaV21aoXaaaOrrWV4/ONI0cjcSi8k7KoQzfoCSUXJYYdipjH+MM4kDB3
 JI7MCYh8RFh9cOLhWKhEY+Q7RWLMHaBeIWa3Fh2apouMiG2SnUXuaV2WppwvxlRnup8a
 0FgqeGiTGwKj39L3oKpVjjtwBfMEzAlanc0IBOeKgLiGzc0EQJ1sG+ZwYbc0yox76err
 qWYHjKrhVErfMS1ZWRUls5a2fitr378Or+4WQ3e6twBT/t5qWUmzbpBFXlWd+5iehr/G
 sbaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1780888067; x=1781492867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xWOzjGLrvCrPSz2mQnuh2MHQ1/zGhEKtPkgykB9GhQU=;
 b=kQVP+sedXyQ9Wve1M6U8e+SbIA7kYu9TSmlpoJELF8E0SpD25C9Tj4R8yc5AqhURBu
 7IEos3d8f7AyDf4DdSEWhE0oEdA8sLhvP18VdOW3cNt/IG8eV71bITpYX9MZFGlPKa3R
 pOdB3uRQ/aYUDX3HorX/i4LR0f0gpZ2eB/ObQEKZ0BJqdgKqwiERAowzShaNhUKStvas
 KIiNduS7Kuz29kvQHoiqpPDkDNH12S6GfSol3WyD58X+NhQbHGKGM5YQdfOYDK3oDzxL
 NPZqOajRzaBvAGWf4+E6qHLjM8bfUBzV1t+CpwyN4sJvFapXPTpSW1pIppAK7vViVg65
 4woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780888067; x=1781492867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWOzjGLrvCrPSz2mQnuh2MHQ1/zGhEKtPkgykB9GhQU=;
 b=eg46+of1I7RmZt0AvnAhLGp2PCo2RGztQIC2RMbKY+ugEaYfo7m7+1+IjCTTPmhn3d
 BJsgqdl9xhWybGPl49zJo5w/tuofOzVCzs9i3fdiaGLyA1MANCQqZTnbyEuoFNOwSswl
 i9zkUXV/QP4SpHF/nIbkYF03UyDbAIR6iM74KXAe2d9/ANKSkfRTlEEx6+gLEmRcEzyN
 RZk0ggCJ0fe3ixcj8WSIzKpmnr+bK3nQTcIFDz2EC4VPi9xSPAz8y/IJUDpljQTQ6IaF
 S7WUkbI3rFd2K33ZhqG1zXQQl2jagWX5N+CxDNg6E/5fx0BBERuCBXN7v1lpDHNmYNbo
 3XAQ==
X-Gm-Message-State: AOJu0YyJ/TbSFW8+oSBbOQONCTRULjMVj+5UreXQO0iqdlK55ysEzZ+3
 KuM1j+5VcJZ11kK0lCbbfjo5CJzcNHhDeocn3HZvT61uc46Yex+7sZ+DBu3x0RmlhtPZPaFfwE6
 GHzgiS8smFj7XSrNIL3r+3Qz2BH9Mfa1BEgIEvGln0Q==
X-Gm-Gg: Acq92OGvRaHczoXynxKFMdf+WHFrNSW1tWbazhGct+UGYCGmOS8Rcgm53t9EH/0az4T
 guGxIa/bAwYYh1EVC5xHwKKiuNvUMb54ezFA2sbt6jrJjSvgcvYozfMEcOGkhmxEy4fS8SvcFiq
 aP6xT7AdLaGfCcejFhxzVaz+E16dTQzbS58wgOv5prtILcDXg5ZMGpq27+v7t11K4AxEFldH6y0
 gMFhGBcVpH9a4A4GeM8lTt95Q6pXt82P8eI4enD/3S58r0jg90Xw5mqjbNz14Kd+AjmWoLlR+gY
 IFJmiF2uzEpo8nYRVw==
X-Received: by 2002:a17:907:986:b0:bed:5774:7c17 with SMTP id
 a640c23a62f3a-bf3701806abmr627934766b.5.1780888066548; Sun, 07 Jun 2026
 20:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <3208216.Ym5mLc6kNg@nailgun> <5857153.7ts2hSHzFV@nailgun>
 <a22e9862-8718-48eb-9eb2-ecb51209f672@oss.nxp.com>
In-Reply-To: <a22e9862-8718-48eb-9eb2-ecb51209f672@oss.nxp.com>
From: Richard Weinberger <richard@sigma-star.at>
Date: Mon, 8 Jun 2026 05:07:36 +0200
X-Gm-Features: AVVi8Cf2n-hsPIzXmQaxCVQxheopG8hyDkytFlxwA3QYp626_46UaRn-s5gdh3k
Message-ID: <CAKxiovgS_1x4rVYN+bdXGGSBLQ87Q-ho88wSLn=eVEMQO9BG6Q@mail.gmail.com>
Subject: Re: TZASC misconfiguration on i.mx8m
To: Ye Li <ye.li@oss.nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, alice.guo@nxp.com,
 peng.fan@nxp.com, upstream+uboot@sigma-star.at, ye.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Ye Li <ye.li@oss.nxp.com> schrieb am Mo., 8. Juni 2026, 03:43:

> Hi Richard,
>
> On 6/5/2026 10:52 PM, Richard Weinberger wrote:
> > CC'ing Ye Li.
> >
> > On Donnerstag, 4. Juni 2026 19:24 Richard Weinberger wrote:
> >> Hello!
> >>
> >> FYI, in arch/arm/mach-imx/imx8m/soc.c enable_tzc380() U-Boot configures
> >> region0 to allow secure and non-secure world access.
> >> This is known to be problematic and allows circumventing the TrustZone
> due to
> >> memory aliasing[0][1].
> >>
> >> It causes also recent OP-TEE to panic at startup:
> >> E/TC:0 0 Panic 'region0 is not secure configured, non-secure memory
> alias access possible!' at core/arch/arm/plat-imx/tzc380.c:217
> <imx_configure_tzasc>
> >>
> >> This is not a theoretical issue.
> >> On my i.mx8mm evk Board I was able to exploit this and dump all OP-TEE
> memory from Linux.
> >
> > I suggest reverting commit b3cf0a8f03d162e030cde1131751d060853e16fc
> > Author: Ye Li <ye.li@nxp.com>
> > Date:   Tue Aug 27 06:25:34 2019 +0000
> >
> >      imx8m: Configure trustzone region 0 for non-secure access
> >
> >      Set trustzone region 0 to allow both non-secure and secure access
> >      when trust zone is enabled. We found USB controller fails to access
> >      DDR if the default region 0 is secure access only.
> >
> >      Signed-off-by: Ye Li <ye.li@nxp.com>
> >      Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >
> > Thanks,
> > //richard
> We have discussed this with iMX optee owner. The fix should be done in
> OPTEE not u-boot.
> 1. OPTEE uses secure memory, so it needs to re-confiure trustzone to
> meet secure requirement not depending on SPL setting.
> 2. SPL also supports Non-optee case.
>
> Best regards,
> Ye Li
>

Can you please point to this discussion?

Thanks,
//richard

>
