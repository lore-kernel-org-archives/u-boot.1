Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06C9C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 15:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C8F88842;
	Wed,  3 Jul 2024 17:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BcVpcdEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735E488842; Wed,  3 Jul 2024 17:25:10 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC6D887E7
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 17:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-36743a79dceso534450f8f.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720020307; x=1720625107; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cK24eXpgiyVvGrESExTQ0T3xmt82AuTEKCKmAfbBZD0=;
 b=BcVpcdEWw6C730dGmuR8J7Jafgk+AiiJrOCbMOl9o6bAAU4oz1uGZMfuv7ag/TCJ/3
 bvSBfq5jzoLt+wy6HtENY1v/0YpsZVbRMGMr0dhHck4ku+JExRm3JzcsZwwndFCz8x+o
 bJ6fCM9dVlTijZcmPM/psb8EAJOcBHwrsJKC1zgtrUYgKgjpWqaaA/4owzjbb2VSOXyO
 lPLCROjYJO//DM5erfzymTJ2Ekht/ANkITClkAXYn3WmRl0f8dX8O3BwRlJD6VIIJrP0
 4uLV2vNPVmYWABfqlNFCPE2D+a/DNJrIFMfP4KymX4c09P3efJ9zMNobisGSYZo4QUwW
 HtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720020307; x=1720625107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cK24eXpgiyVvGrESExTQ0T3xmt82AuTEKCKmAfbBZD0=;
 b=lt3FI/HtSZ5V5vypSxcc6qmBBHzPJxGbBu9BTmxgpj146fkdYL36n3WqNHXKItJwHJ
 gU8PoDw95kmE1r5TwJvWw4bTpYvYEKR6PT4R2BC3PA1JZ4DOLITgwwRICbyWvABzbRvv
 2/UuhrShDZXQ+yzrHtIcIHr6Bh9cH5z1RhmLOVyFP3gxwzPHyEStcSPWT1OH03KKCOes
 +uud79qE4rDalxJtg9AMhGc0Tjchzqx3xyMcE/1SCBzKNIr9zcfail0XZT3tfPYxPoEL
 Bw+Qn1UNrvksNSqIxQhw2JZrBSdpcQMbO3xjQV/ujCcHCqeiV6LaRFbvasFtt3MxSWaA
 pM8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+7KRa7CRjH39QwPjPyx8NMXUwlOFoNfikPznGDG0W8kOCk0nC1qD2KyB9zxLfONqaGZG6/lQ4UlxOB92g7FR3T1al8w==
X-Gm-Message-State: AOJu0Yzi+t2rrxPGApUB/9nqpPUfvJkzBv7YWypOlLSceiLW+FkELRid
 94vdsgz2yJlzpv24lZ7QcP7VomS4N4U/5DuQOtfa2k1PE41HXvy15WXR5Z+ELY4=
X-Google-Smtp-Source: AGHT+IHAyAzLHdH8CT0T2QfqU6TG/Mf/24Dk5Wk+4Z0O07qEEfDUiZlByIykA9/jG5v/OYRc+69pNw==
X-Received: by 2002:a5d:42c8:0:b0:361:e909:60c3 with SMTP id
 ffacd0b85a97d-36794797f57mr1963608f8f.9.1720020307171; 
 Wed, 03 Jul 2024 08:25:07 -0700 (PDT)
Received: from hades (ppp046103011142.access.hol.gr. [46.103.11.142])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd784sm16235668f8f.7.2024.07.03.08.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 08:25:06 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:25:03 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Jon Humphreys <j-humphreys@ti.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Joshua Watt <jpewhacker@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/2] scripts/Makefile.lib: EFI: Use capsule CRT
 instead of ESL
Message-ID: <ZoVtTxDSU5qYLrYW@hades>
References: <20240613202753.2528889-1-j-humphreys@ti.com>
 <CAC_iWjLE05LthXeAL4o92oywjtkCmPa+T6K8DRBvV=DFqZVybA@mail.gmail.com>
 <86le37ihwu.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86le37ihwu.fsf@udb0321960.dhcp.ti.com>
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

On Fri, Jun 14, 2024 at 11:54:41AM -0500, Jon Humphreys wrote:
> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
> 
> > Hi Jonathan
> >
> > On Thu, 13 Jun 2024 at 23:28, Jonathan Humphreys <j-humphreys@ti.com> wrote:
> >>
> >> Use the capsule's public key certificate rather than a prebuilt ESL
> >> generated from the certificate. The ESL is now generated as part of the
> >> build.
> >
> > Is there a reason to do this? I understand that the .crt extension
> > might be well known while the .esl is not, but OTOH the system you
> > build on after this change *needs* to have cert-to-efi-sig-list
> > installed
> >
> Hi Ilias,
> 
> In general, I am following the principle that it is better to not include
> in your source repo derived binaries that can be built at buildtime.
> 
> As far as the need to have cert-to-efi-sig-list, it is part of efitools and
> that is already documented as a requirement for the build host ([0] and
> [1]), and our baseline Docker file also includes it.

Ok we already have the tool on the CI

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> 
> [0] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-capsule-authentication
> [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#configuring-uefi-secure-boot
> 
> Jon
> 
> > Thanks
> > /Ilias
> >>
> >> Changes from v1:
> >> - Converted the single patch to a series to include a bug fix found during
> >>   development.
> >> - Created an explicit rule for creating the ESL file for proper makefile
> >>   dependency tracking.  v1 had combined creating the ESL file and
> >>   generating the .dtsi include in a single command.
> >>
> >> Jonathan Humphreys (2):
> >>   scripts/Makefile.lib: fixes: Embed capsule public key in platform's
> >>     dtb
> >>   scripts/Makefile.lib: EFI: Use capsule CRT instead of ESL file
> >>
> >>  board/sandbox/capsule_pub_esl_good.esl | Bin 831 -> 0 bytes
> >>  configs/sandbox_defconfig              |   2 +-
> >>  configs/sandbox_flattree_defconfig     |   2 +-
> >>  doc/develop/uefi/uefi.rst              |   8 ++++----
> >>  lib/efi_loader/Kconfig                 |  12 +++++++-----
> >>  scripts/Makefile.lib                   |  24 +++++++++++++++---------
> >>  6 files changed, 28 insertions(+), 20 deletions(-)
> >>  delete mode 100644 board/sandbox/capsule_pub_esl_good.esl
> >>
> >> --
> >> 2.34.1
> >>
