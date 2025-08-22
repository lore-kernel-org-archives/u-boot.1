Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2417CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 11:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0701E80422;
	Fri, 22 Aug 2025 13:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MEB96vE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0825880548; Fri, 22 Aug 2025 13:59:11 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85358006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 13:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-afcb61f6044so356593366b.0
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755863948; x=1756468748; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KpEP5DuV4WO/uQlXchaLktbkGUe9h5EkPENDL3Mo/wg=;
 b=MEB96vE2cZjZgcBawcx5XK5i9CpTIVexSgGhe42Ska1t9vsg2WDPvM9rEEDc/lRWE5
 fSnuAe6L0yxeMaVaCs7WWqZVry4V7mtgbrq4i7FgUpDgCF8KIHQQQlnI7xALIx0Ipx3/
 kyIQ2SlnV0nluEBNUPa/pAmU1kWg+dWD3gkTktffQBpv2PAPoLKMeEhh0zH+zQDeoitu
 oH3oIE970jeMuib2ys6EmglpVV+pO6do214K/K8hpe748UavXXIGpTJR6IKFHFFVX+Or
 wBwwxtdVDdlbFTCl/bBer0OcaGWmbPOS090uiHluolLHtvyIkP991Am+Ss+gelOLYc/q
 uamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755863948; x=1756468748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KpEP5DuV4WO/uQlXchaLktbkGUe9h5EkPENDL3Mo/wg=;
 b=is7v56vw1hbi2Ql7oaszBngr2bW47aSwLCzLbsdcU8fE6bLTYhlcn6V3yRUfZaon48
 zj50f4VwCU51YInWlAnBw2GNnZC18+9LyFpxGBNZIAZW2WpBdJ63TiDcdNhwVPsyqlkT
 jO37C59iMbSJLy4ZL4oqvZuibG08YPuH1onQ6TlcClJhB84XDvgSFI8FPf8dIs641vXa
 8/G/yG8cZ1Cl7wNaA1qM5RiJ/fovVrAW52eT9otHpjtLiXqP6ZQ/gZNkSKbszVqli6SJ
 B//0xBCORHi99brdK3g6PTrqlTQhxuC4mrE6Jx0ShPLlkucP3lieWn2P+f4F7Vc//ex6
 48rA==
X-Gm-Message-State: AOJu0Yypc5s6gO1/Ga2LImfKLeJ+DNBQNSk46XNdcsh5IJpPAtvhwLnd
 wulasrQL/G3HhR+3JzirKWBJL6N7Mqfy4xR2wxMmW22OFrA4LlM3IY5+9LycajM4Tjm7Uehth7Y
 1WISSG3hGSh8w/WovENi+D3FKJdLUApNmMziIzNk=
X-Gm-Gg: ASbGncs7cGryXeHN4MjRm7IavBav8cVgYVbT6P4lgPWFjwjYiPbAMtD6NG3cxbbNziz
 vheScboKICAk/TjblJMMtiyCBR5CXH13NaZVUnzTe+5VwxMwOSl+fz0wJQcsH8tWTT/Ky1M7Tn8
 KPBoWMrcfwh73sMeakj0pvSYOXFcO8W6qy4lTlY65ik4n89LFa2PK4my3Uvy0CXujuyXUjoUoek
 Li6H0xV3u5+HcuiYVwvTxCHX2T2sbo4y+jOc8I=
X-Google-Smtp-Source: AGHT+IFFA29TRwPVZF9QsJ2oRS1AlBFI03VPrI6QUAFYQa68/YXZumw9f5v6z8YR3VLJqxYzrcwZ65FVSjSoATIAyTM=
X-Received: by 2002:a17:907:3cc4:b0:afc:b3c2:82eb with SMTP id
 a640c23a62f3a-afe0b0d9668mr561442466b.13.1755863948136; Fri, 22 Aug 2025
 04:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-8-adrianocarvalho.pt@gmail.com>
 <cd2e240b-0108-41b5-b2b9-74514c93c01e@gmx.de>
In-Reply-To: <cd2e240b-0108-41b5-b2b9-74514c93c01e@gmx.de>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Fri, 22 Aug 2025 12:58:56 +0100
X-Gm-Features: Ac12FXxioxvMk-qsu4pIrqyRwMubcmoGyLKWWadPwdaSpu4JeptL1Gesggz1D2E
Message-ID: <CACAHuLCi-eptudENfAeYdXEG+wPYgBAO63eyaM_iq++0+za25w@mail.gmail.com>
Subject: Re: [PATCH 07/10] doc: Fix typo in doc/build/documentation.rst
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
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

On Wed, 20 Aug 2025 at 21:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> [...]
> >   The *pdfdocs* target is meant to be used to build PDF documenation.
>
> Please, also fix the "documenation" typo.
>
> > -As v2023.01 it fails with 'LaTeX Error: Too deeply nested'.
> > +As of v2023.01 it fails with 'LaTeX Error: Too deeply nested'.
>
> Building target pdfdocs for origin/master on Ubuntu 25.10 fails with a
> different error:
>
> Cannot determine size of graphic in boot_diagram_am62.svg
>
> Please, improve the description: How about
>
>      "Multiple failures have been reported for this build target."
>
> Maybe we should simply drop the build target.
> [...]

I'll see what I can do to fix these failures. Unless you tell me it's
not worth it.

When I say this what comes to my mind is: What distributions
must/should be supported? If I provide a fix for Ubuntu, that doesn't
mean it'll work in other distributions.

ATM, and for this patch series, it seems the best is:

-The *pdfdocs* target is meant to be used to build PDF documenation.
-As of v2023.01 it fails with 'LaTeX Error: Too deeply nested'.
+The *pdfdocs* target is meant to be used to build PDF documentation.
+However, multiple failures have been reported for this build target.

(In the first sentence: documenation -> documentation.)

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
