Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34484CFD315
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 07:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9C983F6A;
	Tue, 25 Nov 2025 08:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d+tmWAHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1326383F6C; Tue, 25 Nov 2025 08:23:56 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F26F83E8E
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 08:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c701097a75so2308007a34.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 23:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764055432; x=1764660232; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dBqWXXPXbxlQccrXRfh3A/enfpRSZoSegDUirp8916k=;
 b=d+tmWAHdV6vlS4Ib+8wbNuGV4SBo8C8pAckkAx+qOMwDUyG6/uhPfsXB3CtGYUWCAH
 hyQy/9qBO6htIyIQR+aYp8FiOyBGQ5FVuloxvrESI7kP6/6A3g7azi670MpQ1F3g9bqK
 +7BwfY6Fb5O4NS7q2vDT8v9X+9iPKxsNZNNXNdeTcm2h8oZkIAE7IdEPS4pFEWgEtCw0
 TYe79Fydl230/EZ60lupBbp5DiENszn6ANqlFdizAcrmd31UAXfRo4dFJpf4DxTB4SMJ
 jAocTuOisYAA76uGxrmKgCvPK+vonzWSJ2O8QxVfqJJ9Tn1JYqhJqbkxFnvfSdLrxpKf
 88qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764055432; x=1764660232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBqWXXPXbxlQccrXRfh3A/enfpRSZoSegDUirp8916k=;
 b=swHG8mdbuyvEkEPi866rjsslBsHO+D7BFIDKAKORJj5+uo2+dE1TCiCjSg1E+FEIi2
 HGMRIopgkNfWM0yZbEhQw3EcE9ymVnfgTuwfWnJEqGdlLxOCaq1Njx6b1enHLeiTotdd
 qhvxPkjdufRg2WrZI6fFmZww/FbIgYiK3t/OWXtCTg2cQHVCIZfb8Ya2gfjyHWV2TTWg
 nN1R21n6iL1FRoIo2AYF3hKHsKmclY3CSu6fIh3I/uqdepEIyAxFLqIPdqlc9XT89Zgn
 iz+nM/WtCtZnVUb+GLWsGFL7SSjsgRfwYZ5mzooKyCEFJ0tpvFJ3GCRUhWd+JiOpl6yM
 SL1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdePFw0EYpaxuriRylXKh669hozKf0lPHpNz3eyKCf818Zs0TUKECezQLAbaxUfMQucieuX1Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwSWudGcLCYpHtIGgZB4zJErpJoIpqD2t6iir3mjuli0hrklJXt
 PTQH+19V3YFwckd3YrnMPjxtD+X8JDfpZMp/KYTLFZrOTh0aB/mNB6bSoyeh/fMMHYrKsN6lPPX
 2lFTkKTcxaVh66vSQ0uCvR/xu6AkiV00=
X-Gm-Gg: ASbGnctRcZ1LSnmbpODTZGAJmrlxFp8t+w7BwciqmoObtUWfpP2ffADZPv3smjMZX5c
 VvcyZYcT6sdmteV/1SeYnwNTdCqIH47EHf7vRqND9OCO8KgNo7i+7lL5G2bPEQY87UyyaMgdSgE
 /y7uk5dHiG7wZR9KJSrszxxTIWOqBcPGRs5xEHPI+4tWjbgPKyC5AEGpZ9l1pkBiAp5DP4YbGkU
 zO4qtwukJt8dH/CBF0yM6lVGRJ9NxdVDpri7Sy0OLku1Y67ej4gXZpCm6Pp68gvKtcCbJ41
X-Google-Smtp-Source: AGHT+IHzwZ4XffwvCvtmAkpau3DvhCuiVaCNKGCU9wqkF6eN8ifgG4UO6EWU5opIcTqi9LL4I3lj9I5HQq6AzoVvcqQ=
X-Received: by 2002:a05:6830:2647:b0:7c7:4f2:e15d with SMTP id
 46e09a7af769-7c798c0800emr8050425a34.16.1764055431956; Mon, 24 Nov 2025
 23:23:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
 <CAN7C2SCEnkiLtRyiRx9ykLWOWJFNkUOh-UNZ+Qaq=bD5wk_a=g@mail.gmail.com>
 <c813c1a0-d224-4e82-8494-1a7d2676b29e@siemens.com>
In-Reply-To: <c813c1a0-d224-4e82-8494-1a7d2676b29e@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 15:23:40 +0800
X-Gm-Features: AWmQ_blI-7JmZtCTkPEys6wINQZNLDFOVGV_xwrxOCoZS86rb7SK7hT_20y9kHM
Message-ID: <CAN7C2SBtyc_i3inaCMBCUr_x40_d1LqEARtb2iJms=rHt2TtsA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
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

> But that boot approach fell apart after the refactorings of raw mode mmc
> loading and now starts to work again with my patches. Not saying they
> are perfect, but at least the board defconfig gives something that runs.

Hi Jan,

No it did not.

My latest since 2025.07 built on Uboot not even used what the hard code setups.

grep -r "SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR" .config
# CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set

I simply used the A2 partition settings on SPL and it booted properly w/o issue.
All you need is to split the u-boot.img to fat partition.
I build this and boot almost w/o any major issue since the changes from
mixed setup to 3 individual setups boot by "offset", "#", and "Type".
Still not sure what you have trouble with in the first place?
So I really dont understand what this is trying to fix.

Maybe T.F. can have more better comment but u-boot after
2025.07 no issue on boot by type=A2. I did not try boot by#,
b.c. raw type must be sought from first.

Brian
