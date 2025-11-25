Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A0ECFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 07:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEAC83EAE;
	Tue, 25 Nov 2025 08:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ePSljyzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC8BA83F63; Tue, 25 Nov 2025 08:08:39 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7632883E62
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 08:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3d56d0cb3dbso3071349fac.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 23:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764054516; x=1764659316; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QPKNjz41jyEkaAkAoDooszWCD8qhxyR25i6dkoy8NgQ=;
 b=ePSljyzX9IHjMYeksC2fDNNMCDMCLAO0D1q+WMhuJgROdkXlZYGWcMuByVAf8mnT6f
 H8QFviwjGvGtOlCooRuewD6ZfNtSu4TLPupW2ZO1qnP1JLNS5xRpgITUrdxmUGC9mFqq
 mdf2WQoLrc8TrSPcQv3aoTMjd25QZLrGVyT7Xfz/FLyTQKEAYoVQYHdauFqufibuszKw
 8gCiLuxrnvzmXE9aSOIKo+cuF8FDiCGoggfimOLZryrmIURg3iVQ/O+OCkmEoF/F3Wvz
 eWDVd2WdK5wyxYnWJDosQYVpDKEANVHhVyEmmTBhhhYFEhEEYb0pxHIWMXV3PO7j41wp
 UDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764054516; x=1764659316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPKNjz41jyEkaAkAoDooszWCD8qhxyR25i6dkoy8NgQ=;
 b=jH9SF3+5MNzqpVgDFhyx5PGwD3rtTwlx6nupkbQme/gEy8MpDe9Q5ybcd5vkhqjXgm
 gDA0bhtjiaVkdYwe8SUkpxjTowz6qductnmLxPpJjfHmPWK4ZdEsA775THZ05/LqOxEF
 2ieAZnrRGO6Y0oG6sKtnEkTIRHxD/dLJ7WJX0NASYTHfcIK7TbQkEb39+LQ2QZ2aT9Wt
 mNIiyViuWSOt8wTssfxpsy7tDUPtViJKPJjPplGn4bttJd0fXQTS0phoEGWEnV+H6uYe
 YJZdqk0rtLjeD8t7GWwXG4bgsy1bUkfgzmhH9uqlrlackZ8Ua01XFFAC40xGtkrYtEuK
 FOGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW60JhgmQtNllK9tC0xtRzJcl4emmTsqFfyJc1RW8pWmcjLUYtF2XVdL4P1X/yE6fzwnWupjE=@lists.denx.de
X-Gm-Message-State: AOJu0YwLJsrbpvq2viIDWWOZfiavVvO2EdHzX6JOGk74q1CzGnKs4m3T
 AK641OFbfgz/cVAohEv3wc82AER3lWxotefvzc51+BtPXiJWrmrW7nBGA9hURwdTvDG0FpMS62I
 ypa9Hn+QM2CYeA+iFOvbswkSotcm/fB8=
X-Gm-Gg: ASbGnctRsQYu5r9OVXIMOWCYhcihipFnn4OZPJh8NR99Yvrm4U/MQlKU6PRM9KqTTmL
 4Df6rTGrPyULv6AJOd1nwtvmU4TbrK0tfpzNzdBWh6PyO2p/2+lwq9FspIBjQclNp7bX7Tb2WaA
 8Hr7ChpzCl3i7c1wXSLWk8VWPiNZhtP8cdbbBajAnycsVIyHGOkAYywChRNdycKqpEIQkRW0DSi
 VhdWV7EM+CeBbGEnGzO/cSnG3o7H5PjRWp00dCzh/qgA9r1rTmgjLjATFIsfYOrXQhhMix2
X-Google-Smtp-Source: AGHT+IEqTe/upLiLDpK47e/Vco8TwHvMtB3fSRBk5CG6CgCMW99NcOrLhLWFRkJkaMJyI4gT4ezSP+lMx9Vog9voHZ8=
X-Received: by 2002:a05:6830:6a98:b0:7c7:5050:ec29 with SMTP id
 46e09a7af769-7c798d1938fmr8298703a34.32.1764054516156; Mon, 24 Nov 2025
 23:08:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
In-Reply-To: <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 15:08:25 +0800
X-Gm-Features: AWmQ_bknTpdbui4S2xzt9HbvYkSh6S4WZ_7AFV4TrN0wuN4Q45WFVR4IFusonWU
Message-ID: <CAN7C2SCEnkiLtRyiRx9ykLWOWJFNkUOh-UNZ+Qaq=bD5wk_a=g@mail.gmail.com>
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

> >> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
> >> +                                                unsigned long raw_sect)
> >> +{
> >> +       return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
> >> +}
> >> +#endif

Hi Jan

I am not sure what this is trying to fix btw.
But A2 partition might not be located at 0x200 it can place to the end
of the MMC.
It is very personal and really nothing to do with board but only some socfpga.

But what this actually trying to fix or improve from first place?
Maybe Jan you can explain a bit?

Do the RAW referring to A2 partition if so really not always.
Correct me if not, and current three settings on
1) partition #
2) offset
3) partition type
aren't enough to make things work?
Not sure getting this right.

Brian
