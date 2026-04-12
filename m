Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A48E937E1
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 12:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC8B83BC4;
	Sun, 12 Apr 2026 14:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iu+/VYj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A9B83DC9; Sun, 12 Apr 2026 14:11:39 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D73783B99
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 14:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbd2a0211bso2667911a34.0
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 05:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775995896; cv=none;
 d=google.com; s=arc-20240605;
 b=MFwiWlV5oaGxNnznXqFWQRYDSReoNU9ZFtOPWlTRh0BR6hJe5scSbmJWtHPC7DYKlm
 DJGHzHCRfuPexbxazTrWmvunvpJuYCmRH49jdV4MbG5gMiVnRJki6wXDRec3lKcdwwgD
 QZA5Sklkr1ldDxVJ2vW0jXp5Q3xzeprPqs9KRR93RqjqNhugQJtoTYg4Bn6i6TX6icXP
 v3pHwcrTng7CBgeY2arXFADMNusL8Usp738FU9iJvNitrqxJUY3AMWazdosYBpVtJbaj
 nytHfRfCMcfI2lpnz0MHGXiQTfT8+mu/p6SWcwVcCqmtrscykSHK+LTNut4+9xbZg/ln
 vyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qgmNa6I9ojzvxrNKcpWTYBtWnL9GNwzuUajoAQhiv8o=;
 fh=5mDSfDdjbtpO+s7Gf85WJVKs9bU4+9Dk/kaTaCTQzuk=;
 b=SHCDKRyUsyPk3zYsU++V/zRoJ4a771oCV4aIieFuNAMjnFLdZf7n2C37Qge+PXf330
 Nr+3f/D9ixVrrEa44Q9aTMxRmuTc/Q4fw06082Hcub6T0/Xm5ns9WBeAuT3EbGuW4JQg
 Hy/CaHGeOE5tNTTj2e2xuDuUYchv+KRDmcnUdwAQ5k7L4dow7adlJvnp1ThJ3bLX2De9
 9qV0SM7tDvLKNbbE2+tOV0Cxav3TWjrcQZfNtlpsn8UO8zVFO6pp4voURxtH72HbMGin
 2b6hea6fQfSafTrbz3c+o9tm/ohD0zpr+4gcTS9YvYVQ25ih9YNozuNoJBPeqwPx8TZJ
 Pxhg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775995896; x=1776600696; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgmNa6I9ojzvxrNKcpWTYBtWnL9GNwzuUajoAQhiv8o=;
 b=Iu+/VYj3EB074siSI54ibIA7Coll5w/xmyyhet2EMF/D+jD69da/VGePlYFXnUDQMn
 mwtcOkGpZ98crJ99mKqqCMWfI3uTPWQFnZwHhNlk5H0+VrkoDwyZvVFkHuzkaJtVyidd
 lV1HeL/QvKV3y+RZzkpJAo5rhe9kis/bbMjoOkNDlfM16r5lM59UlNieLrXfuow7q/Sz
 z+uxlC29EnVA99njyk3kycBQtZEcGHFTe+1T5Dlfd4ZvSnFo7Jor/wO3qJewPH2sr5WW
 by+1nWDSSmey8vcENqNZ+pjudGr3vb1ltmRIxlHBtjtDjs4/TxP8gCaHc/Go8sgS5vxN
 Tz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775995896; x=1776600696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qgmNa6I9ojzvxrNKcpWTYBtWnL9GNwzuUajoAQhiv8o=;
 b=rfu9hskFHKrVyzvdOlsdt+d4u6iXpOWHNBRcNq47TWiMStspj31fWBZCJj+1rpAOCK
 b8JLFi/4W0oF+SODPq18rGFy7T5kyU9Xq2QcChXXoKLbpnkEa9HLC8Zuwr9e0mM6mmb/
 dzrgm2NEo7tjWZUWby2BPIWRlKA7uZn8a6eLN2UMQEFadQgQs3cqtVB4aLf/BNwNawkn
 eMAHFTV3ePgq7WTuamv5LJPSWS7oBLtGMDNPGWPdc0CgySVq9dE5iVqoe+iJnZQh8aeE
 S/BnU5SnG07ZFAy9ivqg6AWfnw2n2tBIpyjTF6ibLkyMZhqDCoGaWaDrwKAjnyB7etIC
 vKkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjv56o5R5ZlNGGoxLPXG+DoxJcG0gVUlNcQZ0w7bke+CKMCjKVqjoZ7JmWWFEL3WF8IXVhXB0=@lists.denx.de
X-Gm-Message-State: AOJu0YziNMPq9J+Voiop8+rj4AF60rRJF8Iewo3xAx/xfL35oimQRGP0
 I/1rb7ayQjP/RHApnlstVKcWO0xfbb5Eo5+eJ56tjM8MRTUKiQc9XCnIzKLpUm3E5xdmy+PKUor
 j069i0PSMkSH+EOR+/AMg72x19KhUgQNEsg==
X-Gm-Gg: AeBDietI8ruEeTFOGEgLqu6btpPfweqedIhC1cRZd3lLapLQ4JT4nM/D1xtkBHCnsBq
 rCbtVse6XpTMjvS0vGhewH9VOXjhLQOIDU0cvVn8OtZ2oos6zyct7cbRrAdMmayavX7hPrHAJIZ
 yy7fN4tRSA0Uvpeggrx/OcMBuLXLQyyV/NKCFmz0QRGVmioiPGk7yDfyHJ7FClK617CDXctXASK
 Mg0D+1s+nfQ921XQDEvpX83U7Zw7HIlP1kNzkUYrArgSpPj2UU68kloiGikqomVLsUFT/DqBmlD
 ilBpDtRj
X-Received: by 2002:a05:6830:6a95:b0:7d7:cc76:ff56 with SMTP id
 46e09a7af769-7dc27d93535mr6242894a34.5.1775995895705; Sun, 12 Apr 2026
 05:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <c5129f8f-5970-44eb-8bda-a6577bde41bd@altera.com>
In-Reply-To: <c5129f8f-5970-44eb-8bda-a6577bde41bd@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Sun, 12 Apr 2026 20:11:24 +0800
X-Gm-Features: AQROBzD3Nvpl_H4K-pr_prDQOQPGYiklMIN0g9LkTwotBRXLrUs5Vq_-CFFlpQ4
Message-ID: <CAN7C2SAP8b38_2=6oanx7s8zYPpudUBFF+J1te6bPqALcbRPVQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] SoCFPGA: Update DDR Support for Gen5/Arria10 in
 U-Boot
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de, 
 Tien Fong Chee <tien.fong.chee@altera.com>
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

Hi T.F. and Alif,

What are the issues here? Try to help push ECC back to main
stream u-boot.

Latest U-Boot revision even removed cache codes.

So what are the solutions here?

Thanks,
Brian

On Sat, Feb 14, 2026 at 12:52=E2=80=AFPM Chee, Tien Fong
<tienfong.chee@altera.com> wrote:
>
> Hi Alif,
>
> On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
>
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> This patch set updates the boot support for the Altera SoCFPGA Gen5/Arria=
10 platform in U-Boot. The changes include:
> 1. Update MMU/dcache setup across Gen5/Arria10 using common driver
> 2. Add ECC scrubbing support for Gen5/Arria10
> 3. Add DRAM size checking for Gen5/Arria10
> 4. Assign unit address to memory node in common SoCFPGA device tree file
>
> This patch set has been tested on CycloneV devkit with SDMMC boot and RAM=
 boot (TFTP & ARM DS debugger).
> Tested on Arria10 devkit with RAM boot as well
>
> Alif Zakuan Yuslaimi (5):
>   arm: socfpga: Consolidate dram_bank_mmu_setup()
>   ddr: socfpga: Add ECC DRAM scrubbing support for Gen5/Arria10
>   ddr: altera: gen5: Add DRAM size checking
>   ddr: altera: arria10: Add DRAM size checking
>   arch: arm: socfpga: Assign unit address to memory node
>
>  arch/arm/dts/socfpga-common-u-boot.dtsi       |  2 +-
>  arch/arm/dts/socfpga_arria5_secu1.dts         |  2 +-
>  arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts    |  2 +-
>  arch/arm/dts/socfpga_cyclone5_de10_nano.dts   |  2 +-
>  .../dts/socfpga_cyclone5_de10_standard.dts    |  2 +-
>  arch/arm/dts/socfpga_cyclone5_de1_soc.dts     |  2 +-
>  arch/arm/dts/socfpga_cyclone5_is1.dts         |  2 +-
>  arch/arm/mach-socfpga/Kconfig                 |  1 +
>  arch/arm/mach-socfpga/misc.c                  | 31 ++++++++
>  arch/arm/mach-socfpga/misc_arria10.c          | 26 -------
>  arch/arm/mach-socfpga/spl_gen5.c              |  4 +
>  drivers/ddr/altera/Makefile                   |  4 +-
>  drivers/ddr/altera/sdram_arria10.c            | 57 +++++++++-----
>  drivers/ddr/altera/sdram_gen5.c               | 38 +++++++++-
>  drivers/ddr/altera/sdram_soc32.c              | 74 +++++++++++++++++++
>  drivers/ddr/altera/sdram_soc32.h              | 11 +++
>  16 files changed, 205 insertions(+), 55 deletions(-)
>  create mode 100644 drivers/ddr/altera/sdram_soc32.c
>  create mode 100644 drivers/ddr/altera/sdram_soc32.h
>
> I will need to drop these patches (1/5, 2/5, 3/5) for now as it causes th=
e U-Boot SPL file size to exceed the limit on several Cyclone V variant def=
configs (see CI failure: https://source.denx.de/u-boot/custodians/u-boot-so=
cfpga/-/jobs/1379031).
>
> Please consider restructuring the changes so that Arria 10 and Cyclone V =
are handled separately. Arria 10 has a larger OCRAM footprint, while Cyclon=
e V is much more constrained.
>
> The SPL size overflow on certain Cyclone V boards must be properly resolv=
ed before we can take this upstream.
>
> Also, please make sure to run the pipeline tests and confirm they pass be=
fore resubmitting the patches upstream.
>
> Thanks for your understanding, and please resend once the Cyclone V size =
issue has been properly addressed and the pipeline is clean.
>
> Best regards,
>
> Tien Fong
