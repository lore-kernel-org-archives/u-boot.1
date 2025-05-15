Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4356DC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 19:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8E0082BDA;
	Thu, 15 May 2025 21:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="loXekYjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFEEF82AB2; Thu, 15 May 2025 21:27:16 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D22458129F
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 21:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5fbcd9088a7so1382043a12.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747337234; x=1747942034; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BhKSLyqH/pF/ENmB4T58qJ1XiP5qePmgI0h+8kvy/pw=;
 b=loXekYjYQfyJD5KxRQvexCp5nso25R1zE2z15R3J6z5cvqUhVNnokq7mhS7Mu/iFpZ
 8Tn7W7EQaBNV57+RdLTWj9v757//Q3n8Axy9nqCVDj3wq0GNNQ37PvTYCk5V4goCfI9z
 zVYkL8EzW1A7QWFvWPhsUehDBmTGn2UyJ0PY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747337234; x=1747942034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BhKSLyqH/pF/ENmB4T58qJ1XiP5qePmgI0h+8kvy/pw=;
 b=HcwJv481b7wM40/w+eKcuDqhuYbPjgziCq/iezQyv5AM/pe59K39zMrumUekGjGodY
 lUGZiMgaCGh0elpsdDIsoLJCLJiaS5T+aCk9OfrYnk529TTHDtqmMVcUJaEV5GfozsYd
 q87h1T0fMX6nOXfywmm+Je7nP5nqUFnc9GvCSuktly8/Z0+ZAPRSPd8hLC8f6tWFwifq
 ZvMXqHF/Su+geR8ne2KvBmn/BrIwms47u9+UeSkls/HyCUTwuEfaTOFYgzcEaiPtHO/n
 t6iN7K5+Rm8/BWwDcNAp+814krUUTjfpJvkiU6VYVWsQdcwhDzqnIOeabXUPsTv1kt4X
 o1Kg==
X-Gm-Message-State: AOJu0YwSYUKSPVwUpGov1owht6wRMMUjDmUATwSk8mRPedhHCDZVANQF
 OJEUlY2KGrAzrbtnPTi/rfQZJqKErf94GgDsbzcF63XLMRVQmJz7PwmbCe1Mi8uTg45N89t+Gwg
 mcxnq7wpRkmL8ExxK/4YGpx0XJdfCFZKy5WsuBwE4
X-Gm-Gg: ASbGncubF7KH86gbwea3JxkNFw9WZaoGvU5Mw2QaahL9dXKlbrFXgO529apwPcDPPXu
 XFFFYilaiPso1F6V1ldAX6ZgQ4C4GauDCBq63QgRE6/L0/RDVoxNi/SeomWQIwrhvn1ja3i0PBw
 oGw4ht5kTNXuEdJfOLsXxO6cpf4tGbjr9nKg==
X-Google-Smtp-Source: AGHT+IG7frNXXI+vjNRpZP+oVDYS9Bvs7+TX4YfpqmIZPaKFYVacsJWy/8rTaRnuFD1oqqvpGm38HYzuvsgg3AOtO9w=
X-Received: by 2002:a05:6402:84a:b0:5fc:8d75:4a25 with SMTP id
 4fb4d7f45d1cf-5ffc745c28bmr4459802a12.7.1747337234284; Thu, 15 May 2025
 12:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250510130642.1575114-1-sjg@chromium.org>
 <20250514215004.GC603748@bill-the-cat>
In-Reply-To: <20250514215004.GC603748@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 May 2025 21:26:59 +0200
X-Gm-Features: AX0GCFu6jN393IbqhCHh8cmFkDMXjYCcIb4Kxg2p7c5LK3zFxBTejdlb09LUjz4
Message-ID: <CAFLszTi+EZQENhvzVfJfwp1E6g3i5_HzdcFOTaTvhnneMONjBQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] ext4: Overflow fixes
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Uma Shankar <uma.shankar@samsung.com>, 
 =?UTF-8?Q?=C5=81ukasz_Majewski?= <l.majewski@samsung.com>
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

Hi Tom,

On Wed, 14 May 2025 at 23:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 10, 2025 at 03:06:06PM +0200, Simon Glass wrote:
>
> > This series fixes some potential overflows in the ext4 code with invalid
> > or malicious filesystems.
> >
> > To assist with this and future work, it brings in overflow.h and part of
> > limits.h from Linux.
> >
> > Changes in v3:
> > - Split out into separate patches for easier review
> >
> > Changes in v2:
> > - Add new patch to bring in linux/limits.h
> > - Add new patch to bring in linux/overflow.h
> > - Use Linux macros instead of gcc built-ins
> >
> > Simon Glass (10):
> >   Bring in linux/limits.h
> >   Bring in linux/overflow.h
> >   ext4: Avoid expr in declaration in ext4fs_get_bgdtable()
> >   ext4: Create a var for the number of blocks to allocate
> >   ext4: Check for overflow of block count
> >   ext4: Bail out of no_blk_pergdt() if there are no blocks
> >   ext4: Replace multiplication with an existing variable
> >   ext4: Set a max limit on block-size in ext4fs_init()
> >   ext4: Make sure there is at least one sector per block
> >   ext4: Check for overflow when allocating tables
> >
> >  fs/ext4/ext4_write.c     |  25 ++-
> >  include/limits.h         |   2 +
> >  include/linux/kernel.h   |  12 --
> >  include/linux/limits.h   |  21 ++
> >  include/linux/overflow.h | 443 +++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 487 insertions(+), 16 deletions(-)
> >  create mode 100644 include/linux/limits.h
> >  create mode 100644 include/linux/overflow.h
> >
> > --
> > 2.43.0
> >
> > base-commit: c5a631df96de7421d10ee03dceed1b79db213026
> > branch: sec3
>
> Since this commit isn't mainline, there's nothing further to do with it.

If you'd like to review the series, please do. I just checked again
and it applies fine to your tree.

Regards,
Simon
