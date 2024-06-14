Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8089BC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 06:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C668E8897A;
	Fri, 14 Jun 2024 08:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uFyOY2lF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D7C58897B; Fri, 14 Jun 2024 08:12:50 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E896B88315
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 08:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f700e4cb92so16419495ad.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 23:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718345565; x=1718950365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ako4YZ9l/7j0W0fC5qO4KU++9BbsAhYOrEzYGMuDRRE=;
 b=uFyOY2lFuhW/4Zj53HFrCtpvxs08yRdCBUcb6nbcOSkGMHZIrHuaYnFkFlHFXPsFv3
 dWKmHiJtfVcTnmZb7N1E2Yk/X+SHNssmETDE2aBDQgvssPVDcR64R3xzZvERgz/9clEX
 MoylLGLCXQwRafP/CGs2jwWsA2oxyDrGasu7AauW1W+OT43IHY+ARvO5p/Rm7iXUcyeq
 MWA29obOl2o9hJwxFhp4vi208xkLup2gY9ZT0jJKS3PBDfO2ALQlzwQpdURpeTGY8i6u
 kklEox/tPulLCvTtZa6RmeNMc7jhSYK21UXWOWt9YVjPPsDIOXlBy2KidOTfpcGuuV36
 pDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718345565; x=1718950365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ako4YZ9l/7j0W0fC5qO4KU++9BbsAhYOrEzYGMuDRRE=;
 b=CVd3wmiKEOcwImezECm7p4HKwJrvb9YauP3BTDT/oOe3ghGVdscH/8EkW2xpJZDInB
 ipEl+uSoH8JzQPPyk6g+7mY8FtcIJDDPbx7D6LExhtTnkOht+Swe0DGYlC+NKWP/1T51
 rf/Gzlbt5JlTFKdwwRhOea/qpUE2ObRTzSLT0TwrgSNNMUSwq3nY8l+rrkuR1jH7yO65
 wfc/Fu/BsBoICGnRM5ojpq4mFTp/t1iso8XTUcW/pf0G7m4m2Zh3LGeRePYX+/wed39A
 QPGFjTVSvQlZBjsOeJFqDh/yGMxr+GhRakBHBu93b4jx2D1XdpPI7+ijKYsb6xho+wzx
 U11g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpSxDgBFaZLvuJ3D2Tu15ROVLwSV53tgksEpyb4gmlF7iqQY/QsIY//8osUXUdI7ISntZPpNvV8bTHPLiRXInX49GQZA==
X-Gm-Message-State: AOJu0YwUIo0KS9NocQnkufXZAyrtGqkPbuPkZEZws3F9ZcpDZmcaab6y
 ycK5vCGKnHqG3gjgL2Pi0MbcWKQx+E9bBAp/ojKASsBVhNknm2lCZYg+lLKENdoqtv1OKC+9Ysu
 u/2L3HxC1dl/39O+vAi+QQ+a3M73TBlKdYTPY0g==
X-Google-Smtp-Source: AGHT+IGdDUYNFYyfVsgWRFYQjrB3RWSSy3nycfH5MYWdey0RUaC7kLV+rfchJ/bPa9Rbt9fuVQ94MCJ9MQ9hXxPi638=
X-Received: by 2002:a17:902:ced0:b0:1f4:b9d3:adce with SMTP id
 d9443c01a7336-1f8625d39abmr23109445ad.27.1718345565420; Thu, 13 Jun 2024
 23:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240613202753.2528889-1-j-humphreys@ti.com>
In-Reply-To: <20240613202753.2528889-1-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Jun 2024 09:12:09 +0300
Message-ID: <CAC_iWjLE05LthXeAL4o92oywjtkCmPa+T6K8DRBvV=DFqZVybA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] scripts/Makefile.lib: EFI: Use capsule CRT instead
 of ESL
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Joshua Watt <jpewhacker@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, 
 Sean Anderson <seanga2@gmail.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Jonathan

On Thu, 13 Jun 2024 at 23:28, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>
> Use the capsule's public key certificate rather than a prebuilt ESL
> generated from the certificate. The ESL is now generated as part of the
> build.

Is there a reason to do this? I understand that the .crt extension
might be well known while the .esl is not, but OTOH the system you
build on after this change *needs* to have cert-to-efi-sig-list
installed

Thanks
/Ilias
>
> Changes from v1:
> - Converted the single patch to a series to include a bug fix found during
>   development.
> - Created an explicit rule for creating the ESL file for proper makefile
>   dependency tracking.  v1 had combined creating the ESL file and
>   generating the .dtsi include in a single command.
>
> Jonathan Humphreys (2):
>   scripts/Makefile.lib: fixes: Embed capsule public key in platform's
>     dtb
>   scripts/Makefile.lib: EFI: Use capsule CRT instead of ESL file
>
>  board/sandbox/capsule_pub_esl_good.esl | Bin 831 -> 0 bytes
>  configs/sandbox_defconfig              |   2 +-
>  configs/sandbox_flattree_defconfig     |   2 +-
>  doc/develop/uefi/uefi.rst              |   8 ++++----
>  lib/efi_loader/Kconfig                 |  12 +++++++-----
>  scripts/Makefile.lib                   |  24 +++++++++++++++---------
>  6 files changed, 28 insertions(+), 20 deletions(-)
>  delete mode 100644 board/sandbox/capsule_pub_esl_good.esl
>
> --
> 2.34.1
>
