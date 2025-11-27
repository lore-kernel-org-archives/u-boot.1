Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C42D10375
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 05:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E63842DF;
	Thu, 27 Nov 2025 06:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PLvY3/9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C29842E0; Thu, 27 Nov 2025 06:20:59 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6A6842CD
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 06:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-657244ed2c2so92009eaf.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 21:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764220856; x=1764825656; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DGvEzCNJvN5taWw7A1p2d/oe2FbbFAYVl3+1/J8L0tU=;
 b=PLvY3/9YuWdiY+Rcdj2JMH6Yj+dBoYB0vkd1uMHtSsLLwIfu/d/9QoXWq0AclNPRuB
 FoA/iiy6zxYZaNA2p4vSeFjJ1bNTkTJX4RrGgqvzpWkyO+Woz+awtfnRr4J9oTIf0Kot
 dTlZ4IOHCsGfxu7ey1pYYuGiRj8krC6u4P3qg+uwIP0E6ClppiUSPbCGb/ZdKtlA/whv
 ApDr4lhpuw43i8EKmQM5gSBwp9DRIY98KpvRG5ufT35ywe3pAYdsBihAsYKe8F8cs6Bw
 /d6ni2+RJCYLXzbMWipkznBcUGIZiSFSaofgptFspZgi03sA5eSOaNgS0zIWQvjUP3IF
 CuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764220856; x=1764825656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGvEzCNJvN5taWw7A1p2d/oe2FbbFAYVl3+1/J8L0tU=;
 b=MZMDVGy3AKI5DQjpl9p7q03bhrqKDsC3ofRU5RJe9M/z98FuRjn5FZDVYDa+RyL22Z
 OgJpycrJb24aBbuTYs90GBFeBm4KkuIWolhne0FPsEUF6abrPAcrToAaSYsdDVmGlsDf
 DQPFDOOB6Ab+LRHZV0xh79vPUxjurNidSc+QC3evJyBMGhJOnWvB8Yhr2KrVxc/M9C+O
 Db9gxeti7YGBlawki4E1loRtSSShuUcfBPNwaEef9NZNJFxJgbe494TOjQQolJmD3B8W
 6RFBZPckmrPWv6AfDGZo67NXODpPCvWzimVUnHGrW/ioOmeqML4KiT6XiIupMjzWBNKJ
 CAPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpsTMLD2fqT5M9Yx9pd8Fg5lzwU6FnsAXifSgIPuLoKk1e10yLo4G/schnA6+O4Dm1KB+9d1E=@lists.denx.de
X-Gm-Message-State: AOJu0YxhWv+3Hwuk9kbXbCKJVfNrHARZlcbMR0rNk/0KEVZC7lBmprKI
 qECvV/e13CZDaVGh9JgXnlXMX+ZQxOv4OWEs1MY/l/M7HVnDsmsq5WVdDShH5anKmMd1zR9kP19
 d1YKop9NYDaogVrdr5oylqvbLw12rcjg=
X-Gm-Gg: ASbGnctfcytzzoQll4fkREcmFwfRTDBPAfldgPd6iIBTuXOwPHUj2zPxdi0uQJtB/Xf
 EHCEO5jF+Z+lo8KJDhlsmxVTaBhAdnqGoh6hzd04cSudWe52H0nmqYvh70RrPtHbSRfpiz+ZPOy
 pGp4z48f+6dj2LRJxXdlrVyBvOvCOut/BoeG7awZGFAWReNWME81ulOKooNqC6v1QlUbxnhlcuS
 YQjUj+fT9K7vcjvkfv6UusBuXrZcFNq91DLxLk9VSr48PU8/TSonKMD/rju9pSV4Iq6hs8=
X-Google-Smtp-Source: AGHT+IEe8u0gl5i4oERTmHMO0uA93e9AQ+P12c4DceASAft+EaYbon86YfKLj7rF2iaGBA+ARAxxeumJBYLaM/4ZS6Q=
X-Received: by 2002:a05:6830:4126:b0:7c6:cb39:adf7 with SMTP id
 46e09a7af769-7c798f6199bmr10963340a34.6.1764220855972; Wed, 26 Nov 2025
 21:20:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
 <0720e9a5-536a-490f-bb28-87efe50289a4@altera.com>
In-Reply-To: <0720e9a5-536a-490f-bb28-87efe50289a4@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 27 Nov 2025 13:20:44 +0800
X-Gm-Features: AWmQ_bkDvVLkeYCHvfokwbRtqq8D8uirmRAoblRsRplJWvGYXbQ3oBBXM0YVwBc
Message-ID: <CAN7C2SDhuPmFV7JjqGwvAOi6s68AbdihmcJ5dapm18=ON0i5jw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
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

> Our POC confirms that this restriction applies to SPL only. Once SPL is
> running from OCRAM, it can load U-Boot proper from FAT32 without issue.
> This reduces OCRAM usage, simplifies the MMC layout, and preserves FAT32
> benefits.

Hi T.F.

Can you confirm or recap a bit.

First I had no issue since the new update from mixed seek
to three individual seek methods, TYPE, PAR#, OFFSET.

But what my best guest Jan is trying to fix does not exist
from the beginning. There are no need to follow old days
combined splx4+uboot to A2 but simply spl on A2 and
uboot in FAT.

To confirm --->
For u-boot-with-spl.sfp simply dd using old method aka
early like 2025.05 or before will not require the uboot to exist
in FAT32 and simply all combined and flashed to A2. But
using such will only stop at SPL and the U BOOT phase never
completes.
<---

Simply follow old boot or flash flow and blindly run
make board_defconfig and no sync or update results in fails.

So what my comment is just a very bad naming on
latest u-boot generated file "u-boot-with-spl.sfp" ?

Thanks,
Brian
