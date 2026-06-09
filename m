Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1FDCD8CB9
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 16:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C0384704;
	Tue,  9 Jun 2026 18:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QE4JiHqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF8D384894; Tue,  9 Jun 2026 18:06:15 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43CA28466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 18:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5aa68cf9123so6051940e87.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 09:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781021172; cv=none;
 d=google.com; s=arc-20240605;
 b=FSCSAhGKGpx0yvBjgsQnjKj6iTkA1d0hazXgKYw1B/H4DBSrr3oztitSeGEqYbwV0w
 zVUrovMPUmW2jbyy6S2yaPwfhYMTA9SkzsnNs1ZecN/ZErVFJcLcf8aOTWvN//kVKmi1
 lfBHRK+eYUhbrFZ+IqH1ycYBiEht1pvDDvodg1s+SjcKotlyfqtT/LM3rSfcX0lnt/HI
 pH1HvISvCF2ZQPTlrlI7NIZPLa0+Lm/gwS5HB4ZoA4gGX24K6hJLION7K5hLsyLPInoW
 /XGEQuZXmdLVDrNtwhhY6AfXXQVWTCyaq/JgC61AkfTvMayAFxeN8Iopjp9V576DyrZY
 exQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5V50AFleF/B/mvJ2CdIAK24UILPhhMSjo8pRppEyu6Y=;
 fh=y7xQc8X+qFVojYD6YjtqM1gdFPcxLCL8om/s8n2Gl5I=;
 b=FqR+Eq5akoSngloFWda8/cDhTE5JfdukRm+WmBfOn9JwNZe0k6wWsoCUe45bBTG4XB
 4u+Xa/pId1uDWlIMInYlzW7GEuhzCY2XfETbFLh1XtTquV3VyxpsoUEYG125T+tJEMc+
 mrD/0SgJ86xegovGcOtUFtw4ycuC72LFy5DdcxxtaGtVu9CTRlnw1Rvh3A0+uNpXZuor
 bQhUSe2bPzzBcbe8oeJb/8Mg2Rx5kvSLY27mcbAUGXSgo4VZfKfUheqkhdriTCG5dLio
 aOw5Ej0MgOR1afyP+wxIdfJ7TGJqVBPICwhKrcjJb+SdZJ7Z5rUVH+CEA8JmxUKIs6J6
 eNYQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781021172; x=1781625972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5V50AFleF/B/mvJ2CdIAK24UILPhhMSjo8pRppEyu6Y=;
 b=QE4JiHqC42ogob6iQ2QM8FuX3CYUuNNtHt2nJuV6/ULioBYZpjlYQXhjhWY90TlrB5
 vmBBD7qU3jJUSvN7ehAqgfGEwk8H3hU+3TCFW3qUwG//GgMwIfLfgrRdpgscPy1eju+f
 XBT8nkeBMFVtUPMrU4XXlcH/88aV6w9VFRlxqmYPr9+AYKgxmDTNYQ1RskwjDYi3M6TU
 birEEW+di++4eUXCek6VUllE+D6tLFk10sw5KHUgnDZIYNwHk6uJ4mx4ySOnBSXclGoN
 ssiZ1pLr6VUBa7/RegawsG33L5m6G7NvLS67FQEWJ8eIP7XTe9E2ZT3vs0nobBigFYIe
 FeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021172; x=1781625972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5V50AFleF/B/mvJ2CdIAK24UILPhhMSjo8pRppEyu6Y=;
 b=fehxsBipW7pQRtEq6FTZ75Mmm6Z+qoyxszNVARvs76ClIWddvAzWtfZ227GpiOSWFZ
 2S81u059KAP5ojEOofZKNF+/1xRY+bnrD+QhPkKNFyYhUgRlEtC0BuVUf5pAtMpdkdZV
 1sgP1WGe638pHlNA2XD3a+dySHSHPgtf9DfV9SKtqLfypor5N1NcjtK9BhHnkAtaFQH6
 3jv4UqvPqni33uR9C0ar7rFV/N7OA8FlAMWvosERGApCb4Ey72ZCF3oQLnvDdisWKkVd
 26tRBUkgr/pItjfctEna66GvW9YJ7kdY4vB22dVPYNYpuLNf47HftRPialU9WYw9CeSx
 TFPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ml7SzNZVdA4nrNIf0fZXLqA9fbjt+sBoUlXAyikrz3F/7Lr1oqAiecjem/F4qy6TrTGYy2vs=@lists.denx.de
X-Gm-Message-State: AOJu0YxVAbUJu8/YijGrfhqGjGA4f1rzG0ddNYEq6Z+ctpewsYo1paC9
 CLey/pRup8fH+RqPNCyOiRLiHGQFqItKB2NDOhoxQKaYZ7PNXgiLF5tFuMU3/3AF6AXlbloVBcP
 mEKblbbS/iE+MsQf1Kq1AMdkx3mPgr+crtZyQLisDfw==
X-Gm-Gg: Acq92OGIsQ12By0lUIakrsyTFNidIdJgF79ETL8UQMclFgW6qZSAggOGsb1cFR01QhW
 i1sbFUsaOUhbLLUYEfCV0Kmv+F5+ZuMcerd5pyKyWIcFaB2KUVnDg0vhufKvR3W+lvH2v9INAMX
 l1tRQY5fqcd0+b6YFWU4szVyP0jZ21IcQf/qUE8/5ot/Tgej+461ltQwvcidJgnL1whWxOQdI5w
 +pWE23x65R72rgsOS+tyl3LTyyu1wS+fzOQlyH2wqPXqG8m5qtGmwlzlrx74tyOBQdSsoQvGprO
 bCqYJXJ5RNr6mDkPl6riJBJ5/VT813cevmoanUKJpZ3B4VYdKpMMKF9KxFawksgMoQs9U2DK3b+
 zZ7Cz1fDTroi26p3XQZbz1hbfK7XTzLXf7gen9ILYlOIcc9wLoO271d5QhD8CoS6bso/obpzLZ2
 3/ZYniNhzvuOAwChLxUkjJ/J/pEwikq7j3Gl4+Ms+raknwYO2Vllol0nIdTZWybSwRmO5PjYdYa
 aYvFqul1XI6aZPB4wgohxix6O9t3Hlqqi761j9JRaEK2awejEbE2nIdyEcZuB3H9Zq7BG3NVlrF
 Zd7fbT1xWE2j3eGaJtAAV2mXJl5uRzXs0rf7MTJPioIX0GIVOs6IHYjxBEzFpsnHBa687q+3yEx
 rzPYhB0Wamkm51rg=
X-Received: by 2002:a05:6512:2310:b0:5aa:7525:e770 with SMTP id
 2adb3069b0e04-5aaa81c3ed8mr3352175e87.40.1781021172134; Tue, 09 Jun 2026
 09:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-2-ilias.apalodimas@linaro.org>
 <89b2f624-796b-48b9-92b9-4739cc64a497@mailbox.org>
 <20260604230951.GX627328@bill-the-cat>
 <465fc13b-28a8-4ac5-90c1-e10c0a342a7d@kernel.org>
In-Reply-To: <465fc13b-28a8-4ac5-90c1-e10c0a342a7d@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 9 Jun 2026 19:05:57 +0300
X-Gm-Features: AVVi8CcyJlTb7Nf7Y5M3koNGyIeR6drTULYL82CEYjF6f5kuuL05_XIjprDVMCA
Message-ID: <CAC_iWjKvDqPhiAnNignBRAY4fs1axTvA84-8KcnxLhs+a1rHfw@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] treewide: move bi_dram[] from bd to gd
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Thanks Christophe

I've sent a v6 in the meanwhile, but this part remains unchanged

Thanks
Ilias

On Tue, Jun 9, 2026, 17:23 Christophe Leroy (CS GROUP) <chleroy@kernel.org>
wrote:

>
>
> Le 05/06/2026 =C3=A0 01:09, Tom Rini a =C3=A9crit :
> > On Fri, Jun 05, 2026 at 12:31:10AM +0200, Marek Vasut wrote:
> >> On 6/4/26 9:37 AM, Ilias Apalodimas wrote:
> >>> Currently, the bi_dram[] information is stored in the board info
> >>> structure (bd). Because bd is only valid after reserve_board(),
> >>> dram_init_banksize() must be called late in the initialization proces=
s.
> >>> This limitation is problematic, as it forces us to rely on a variety =
of
> >>> bespoke functions to determine board RAM, bank memory sizes, and othe=
r
> >>> early setup requirements.
> >>>
> >>> By moving bi_dram[] into the global data (gd), we can run it earlier.
> >>> This is particularly convenient since boards define their own
> >>> dram_init_banksize() routines, which do not always rely on parsing
> >>> Device Tree (DT) memory nodes.
> >>>
> >>> Additionally, U-Boot defaults to relocating to the top of the first
> memory
> >>> bank. While boards currently use custom functions to override this
> >>> behavior, having the DRAM bank information available earlier in gd
> makes
> >>> relocating to a different bank trivial and standardizes the process.
> >> Regarding the BD, this is likely really old, but it seems BD might be
> passed
> >> from U-Boot to Linux somehow ? See [1] and U-Boot
> >> include/asm-generic/u-boot.h :
> >>
> >>   8  * NOTE: This header file defines an interface to U-Boot. Includin=
g
> >>   9  * this (unmodified) header file in another file is considered
> normal
> >> 10  * use of U-Boot, and does *not* fall under the heading of "derived
> >> 11  * work".
> >>
> >> Are we certain we are not breaking ABI here ?
> >>
> >> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/powerpc/boot/ppcboot.h
> >
> > I've added in Christophe as the maintainer of one of the active and in
> > some ways oldest (since MPC8xx is very old) PowerPC platforms we still
> > actively support. A tested-by on this series that also includes
> > verifying Linux still comes up would be much appreciated.
>
> Traveling at the moment. I will try to give it a go in a couple weeks.
>
> >
> > My suspicion is that anything DT-based shouldn't change here, and in
> > turn if you're doing modern U-Boot you're probably doing
> > not-extremely-ancient kernel and so DT based booting.
> >
>
> Linux receives a pointer to the device tree from U-boot, nothing else as
> far as I know.
>
> Christophe
>
