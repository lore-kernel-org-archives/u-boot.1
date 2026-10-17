Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764C0CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 20:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E551240907;
	Sat, 17 Oct 2026 20:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ndq8-BychL-k; Sat, 17 Oct 2026 20:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F0014408E4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792267533;
	b=hatqe1nX2YJshyHzdnzoGTVB/4WNJmMFdb1HN2R5z3oEAPLUw59TUyW2ySwMialKp8S1
	 +q+Hf4BQ0Tu01uhLQu1zqTb4NAJ2Lo7Y2CD7bK/qKKaPdMxUyDCcwa/qf31On1lqOrcRc
	 HWRESTaBF7NKTCC2T7KqoNtoYeMYGRPE5QHjyYatIuQLXUAHsbKyAQFG4T4uVLhLIGkZb
	 YkW8K7pL7oMF0sCszUiUS9QPOmkb2bwdXC/mzracJEjGOo+PGzK7BKw6HSeY3WoQoFkkv
	 VDKVZzAn+ZJ9Bj6ofes3P2PHfo8wHhbtwjoHGdMCtKnogU25r+wb6AM470/IpZs9UYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792267533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w9WxgW9+9WPSei/7f1f1bhy7v8fr7f/Y6v/NBF4uOvk=;
	b=bE4zfbVnwjzkJAQ5j7zf0cNIa86OB5yyPWeRMKH1foDLto0Zcfnp3fxrmsHIY4+p9v1P
	 jM6FAdG8QPSVCPNi4lrzY0D+ssAnboE6+fNmYB7oXZP5228PjAwGErhw3qAWw1AKVu5l+
	 dykCRwn98QSBrrC9ZVH/xja48D0wSRIRwUaKmzSeBCxl+SL3k/krCTFPVsxN48+6Ds/mY
	 E1IXkwSV1WB/ja6XaLT4s82TXZ8cTZd6gnXLhgNjAKsNomt5+cKPLoqNH7Vk/PFxcWJ6Y
	 zb6785dajqYIkb4S3lFG8w2sc3KipIyKQfKVIb/gXcHTag4KCwjdr8k1pejxUGf3RJg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792267533;
	bh=w9WxgW9+9WPSei/7f1f1bhy7v8fr7f/Y6v/NBF4uOvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bDyPcRduc7u31CWG6RflZQA+vjITVT6/7HvP+tAkOn/toMlpe9nvztmCqCMK4jVrM
	 no/zh5IX7yQnFrkw86zKba1eal8xPDFKufbltMUyMqlo4roQxIyA0hecfBgOkSvdzj
	 id6ELQifpyPhwk3zu2BSeerCPBcI1xEhEPm30cZLcPtONcQL6Lm4Je/qxpUeOTT8Hw
	 7P5PcqjpsruSM0qkzCwV3RfuZnWZ4F8aUQW3eOUsbKiPH/vHvti3JXbAxfGT6Guhxk
	 8AJHk3MdkS9NYaw2hQWM4O6QVtoA4ofKoyEqbw68s2L2IdVXrPNgE5yx4MY8g0gr40
	 PGp2OMJr4iTAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0014408E4;
	Sat, 17 Oct 2026 20:05:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 49FBA61
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 20:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C4CA8122C
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 20:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hXdN6rK9nWqJ for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 20:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3FFF881220
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::936"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792267530;
 b=IBElCna6O4FxNbc1542Yb0Fs/X5qNMRCJibnsXbZjTC5b2ptgvzub/2vJJ1vZWHrROBd
 CCl19QTbctX5hF1+l5lZXRcKXGRXQtw0AE+GO5YHO9D0XT2nB3oMjOUh9sM6Jt0FyxUtm
 P2r6I75UTIsN37yZ9/6FvT0D/NwZwDe/oaztb9nwvOoIkfVFHtl4GLfCp8q2tJfrpPBi6
 1+Pyk6Em3eBLImh9Kqm694eMtj5D139oJAmuvI9km8T3MWH+TlBNxa9fTzzsr1k9766KY
 7/iawiB37inhBGkoB1kDVAvZ73J245Mazwm5neUz1Zw9sBeyEvYo5fZaVYozKRpyMKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792267530;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:Content-Transfer-Encoding:
 In-Reply-To;
 bh=w9WxgW9+9WPSei/7f1f1bhy7v8fr7f/Y6v/NBF4uOvk=;
 b=Yz05kplXYxJlxnWd3CF600XhEtsrlyPza5+fx/xBi8l82fJwGvD+2U+mj+gaoWqlbQhW
 Uvgvkn9i9WzGYN81/JZeHp1wYHXatV1X3wCFv0JmfYCizOr0rEHeXEPsy6Nm37wTHDqb7
 7M1LZo78JhcYxhcXgbRNMbvEaU8cF4vwE7YIy0aae0UC9h8wcwHvQR8R4B0MW0tL5Vur9
 NVUrSFRBz3r8q7HIewrPiifRU7emij2d8/UImRI+U3qtV/pH5nU5bOm0PXPXN9OTMgbP1
 YlnrXPjJ1uPYF7/Z+qkCzLhp9cJ8TuThyHFLwu8As+uov6iwxOZDRva3bl1H8f17ZKg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XJsbb+8+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::936"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::936; helo=mail-ua1-x936.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XJsbb+8+
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FFF881220
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 20:05:27 +0000 (UTC)
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-99075306daaso562279241.3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792267526; x=1792872326;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w9WxgW9+9WPSei/7f1f1bhy7v8fr7f/Y6v/NBF4uOvk=;
 b=XJsbb+8+0l4VCzUudDblTvhvg+aQ/Dwne4vOYPakREZ6D23RpIx8KCkmBChm+Cb9cf
 Fl65x3dSS1RFFgqyxNlLBjHnR+GaGJLVb8zTU+PewsChaJWh2lBQaLnQ32kofPGxaTbr
 oUgSNhZQeObhKvrLjDLe8xRz0TFihJm41Ge7DV2A3if5bMb2BIOsvBjWf8wsco+YSVIv
 koWYIUi2Jl8/aJOXSFPSSkSgL5poBF6N/N8zL4dKPFHAQISfjn7TUnoiO5yt1Vl/2eGF
 O7qYDcNoD/nkX9eDiwQ6rGYccgge+6EjJf62sEwPbMaIii9RpCzjTftTDaWRCqcGOglq
 LB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792267526; x=1792872326;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w9WxgW9+9WPSei/7f1f1bhy7v8fr7f/Y6v/NBF4uOvk=;
 b=myQPn7agHuKmTpZjR5IHYqsAHe7tr/WoFgwkyEc3Jx3Cxv2gr+4fdgDlajJosM5lgb
 NiorsDFPoqmEXrsBY2+MH8xNU2ffKqQbRsyfWkldQLuGlhp7pXbgdwk73IVKYUw/p7vO
 q7CiX2O9bkizgkcRF1NbXeuNbwV+WSs54wBVlUJqr5XCFyWUxl+JlMi4LFCfc3Gy8p8Q
 vjP0drGGkMLtUohQd5CcMx0Ipwacr06TDyGcAU7A59ZfaSJfEPUHzmVOrDVUTKr99pML
 8+IJ9bRXWszwyKqvHzZrfyP7OM2fKTFAdvXhVnPP7220ZqKAeBLmkMnuwMEFfjdVjVNd
 ca9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDidI5/BUrLBl/zFoyAyJ41nx+2jhXDgzZzcDhjWFMR9mA6jXJbiYJZNNkyppcMR3tsGAv4YU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKps0Vcoodap8xtCIOtiL7V/DPBi6BAV3Shnddvk2La/rO7sDGR
 RmSlEXm53dhYTlptKtDJ3oZNMyj8o92ZnyF9iS10pyux8Qd4Ei1FcNZ9MvArh4cs9qA=
X-Gm-Gg: AYBFou1aCogsi34wCVqtRZCm+38Z6Lg9rXe241pOpq2uA8UEZIUEU3t/q+DpSGeNlP/
 NN6WeT8GJ0Z7juzhBS1W0EBa+n0OOTikufVnJlnYoiBayMmdUAxokKFmlWhnlb8E1v20mcRUE7r
 N70v4I/TIFPwrYV3HGK/p36/n5Wd5K+2VjIeDn4Q+wrGVhtbghyn8QgJxsY7kUej5o26fv7q0Vu
 g2f+fyM09BeMm65nuRvWMUyWqAZEGAsdQCnJMUayFgtobD/2ovoXzqCrs7YHHCSHqSj7mBYo4kM
 H5j/fQy2TlMb0SxUJ3dP50CDI1qODj8SxEVW/M/a7DEwMrar1bfm4MtqZItXc2xOoQN19JfNlNy
 BgsV7LzJOSlVCZJttOKqWxZroTDhCsliE9MziCGbhJ8s7nZVPosjXQgV8Y68/O0vF6OWryRqECb
 wUsz9GMUXOr97hqSDB7CHtmIF809f0wFkcZogQ32R8jR52NF41NVPayba5dMO/ARGVfQpXXSPlZ
 A+Mt6eIT7iu78sZIqw/8oKqlEtFYvL2R3oVWj1YNd8d5qubfek=
X-Received: by 2002:a05:6102:4415:b0:7ba:9a61:23eb with SMTP id
 ada2fe7eead31-7cc36acefcdmr1078061137.37.1792267525967; 
 Sat, 17 Oct 2026 13:05:25 -0700 (PDT)
Received: from hiagonb ([2804:7f0:9541:c052:e6d1:375d:d62b:8560])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990835f05c7sm4793152241.6.2026.10.17.13.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 13:05:25 -0700 (PDT)
Date: Sat, 17 Oct 2026 17:05:16 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: E Shattow <e@freeshell.de>
Cc: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, 
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Gui-Dong Han <hanguidong02@gmail.com>, 
 Joshua Milas <josh.milas@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Michal Simek <michal.simek@amd.com>, Yixun Lan <dlan@kernel.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
Subject: Re: [PATCH 4/4] board: sophgo: Add support for Milk-V Duo S
Message-ID: <atPUQnyjFHvwkXIK@hiagonb>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
 <20261016-upstream-v1-milk-duo-s-v1-4-e4bf386eea2d@gmail.com>
 <d61a5f4a-f7eb-496f-86b9-70aedcfe2e66@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d61a5f4a-f7eb-496f-86b9-70aedcfe2e66@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, Oct 16, 2026 at 04:51:34PM -0700, E Shattow wrote:
> Hi João Paulo,
> 
> On 10/16/26 12:52, João Paulo Gonçalves wrote:
> > Add support for the Milk-V Duo S, a development board based on the
> > Sophgo SG2000 SoC with 512 MiB of RAM.
> > 
> > The SG2000 differs from the CV1800B used on the Milk-V Duo 64M and the
> > SG2002 used on the Milk-V Duo 256M, but these SoCs share most of their
> > IP blocks, including the CPU core, so the existing CV1800B support can
> > be reused.
> > 
> > Add a separate board directory, target and defconfig for the Duo S,
> > based on the Milk-V Duo 256M ones. Like the Duo 256M, it reuses the
> > common Milk-V Duo board code. The defconfig uses the upstream devicetree
> > via OF_UPSTREAM.
> > 
> > Link: https://milkv.io/docs/duo/getting-started/duos
> > Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> > Acked-by: Andrei Lalaev <andrey.lalaev@gmail.com>
> > Acked-by: Hiago De Franco <hfranco@baylibre.com>
> > ---
> >  arch/riscv/Kconfig                       |  4 ++
> >  board/sophgo/milkv_duo_s/Kconfig         | 30 +++++++++++
> >  board/sophgo/milkv_duo_s/MAINTAINERS     |  8 +++
> >  board/sophgo/milkv_duo_s/Makefile        |  6 +++
> >  board/sophgo/milkv_duo_s/milkv_duo_s.env |  8 +++
> >  configs/milkv_duo_s_defconfig            | 43 ++++++++++++++++
> >  doc/board/sophgo/index.rst               |  1 +
> >  doc/board/sophgo/milkv_duo_s.rst         | 86 ++++++++++++++++++++++++++++++++
> >  include/configs/milkv_duo_s.h            | 12 +++++
> >  9 files changed, 198 insertions(+)
> > 

...

> > diff --git a/configs/milkv_duo_s_defconfig b/configs/milkv_duo_s_defconfig
> > new file mode 100644
> > index 000000000000..41a31c4ad46c
> > --- /dev/null
> > +++ b/configs/milkv_duo_s_defconfig
> > @@ -0,0 +1,43 @@
> > +CONFIG_RISCV=y
> > +CONFIG_SYS_MALLOC_LEN=0x820000
> > +CONFIG_SYS_MALLOC_F_LEN=0x8000
> > +CONFIG_NR_DRAM_BANKS=1
> > +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> > +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
> > +CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2000-milkv-duo-s"
> > +CONFIG_SYS_LOAD_ADDR=0x80080000
> > +CONFIG_IDENT_STRING=" milkv_duo_s"
> > +CONFIG_TARGET_MILKV_DUO_S=y
> > +CONFIG_ARCH_RV64I=y
> > +CONFIG_RISCV_SMODE=y
> > +CONFIG_FIT=y
> > +CONFIG_BOOTSTD_FULL=y
> > +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> > +CONFIG_SD_BOOT=y
> > +CONFIG_SYS_CBSIZE=512
> > +CONFIG_SYS_PBSIZE=544
> > +CONFIG_SYS_PROMPT="milkv_duo_s# "
> 
> Delete CONFIG_SYS_PROMPT there is no purpose for non-default here

This is the same for the other Milk-V Duo boards (CV1800B and SG2002). I
like the idea to have this with the board name and I do not see this as
a blocker for the series. If this needs to be removed, I would remove
the other boards as well, which I prefer not to do.

> 
> > +# CONFIG_CMD_BOOTDEV is not set
> > +CONFIG_CMD_MBR=y
> > +CONFIG_CMD_MMC=y
> > +CONFIG_CMD_POWEROFF=y
> > +# CONFIG_CMD_MII is not set
> > +CONFIG_CMD_EXT4_WRITE=y
> > +# CONFIG_ISO_PARTITION is not set
> > +# CONFIG_EFI_PARTITION is not set
> > +CONFIG_OF_UPSTREAM=y
> > +CONFIG_ENV_OVERWRITE=y
> > +CONFIG_NET_RANDOM_ETHADDR=y
> > +CONFIG_CLK_SOPHGO_CV1800B=y
> > +CONFIG_MMC=y
> > +CONFIG_MMC_IO_VOLTAGE=y
> > +CONFIG_MMC_UHS_SUPPORT=y
> > +CONFIG_MMC_SDHCI=y
> > +CONFIG_MMC_SDHCI_ADMA=y
> > +CONFIG_MMC_SDHCI_CV1800B=y
> > +CONFIG_ETH_DESIGNWARE=y
> > +CONFIG_SYS_NS16550=y
> > +CONFIG_SYS_NS16550_MEM32=y
> > +CONFIG_SPI=y
> > +CONFIG_SYSRESET=y
> > +CONFIG_SYSRESET_CV1800B=y

...

Best regards,
-- 
Hiago
