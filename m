Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAC8C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516E088B57;
	Thu,  1 Aug 2024 16:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vgm489Lx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A42A588B57; Thu,  1 Aug 2024 16:42:40 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90025889FC
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b78c980981so37341496d6.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722523357; x=1723128157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MAv1w6Vhw0c1XuNv05WVnMcdCWYc56xSwLfxMDzHhVU=;
 b=Vgm489Lxm8jxIdx6NTNQYiqa1vL15MiQCHwg09dMuIaniCvIzoXDXGvtcljPL7SlkG
 q7bh9xBkeiJW+yrYwuVOypqlpdmxjfohzVRp+vDButlRhcIV0o9gexc0w+1rrd5xPyPE
 WCwfwhogxQ/Zx3U7Q+iw+2AcsJcEct/TqxAYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523357; x=1723128157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MAv1w6Vhw0c1XuNv05WVnMcdCWYc56xSwLfxMDzHhVU=;
 b=C3pfkeRuWAWszzJv0pVg8gG0B2h3CD+e6M9aaJYZGbxyFQ/8a8SkA8if0FjT6SgQRC
 t0YZsAiQUN9mu/Cu2L0Xim+4GNiLgE6Puxyx13Y7jgDoNraUvNgWzOnTBiuWXd+LOvYS
 Op1yEvi9tedR3YwCRlorUvR/RcOGI7pVkdOkcMyzyg7aPacPzC8AIEirxvVWj7b9NL2C
 epsheUng16nL7yqQEsUg2d+2TOVHtzthPNSGN/1voXZBd1iICvBST5A/+BnRc6yB6Aop
 8yJ7VDcSI3BnudhWaUR5K7Phtaj/2kVO+ggyH+vssHtjnlX3GoKf/BZm17JcaKIuUjlg
 tSsQ==
X-Gm-Message-State: AOJu0YwIl45o/2Oj9zv1POxuPX17mV/kr9hSh8sqvdBMdMw3f0aq/EH9
 q9BvJnNAsehgH1VF9WGCkt4vOrLCUtUokDERXXf6MyuqO+u9S+0Qm++TRhBljH/J9pOW+zEcCGk
 DimR2DBrzpoQX3+eOajlHEzznQMVi9DJimW9+
X-Google-Smtp-Source: AGHT+IH2JpQH3HiFl0xB3B2Iy2UkzaGNP4QaI0GknVYJcuVJgQ6xtqM+J2yEXGjlnwpoImzjTRR3EMbEAhLeoC3WMC8=
X-Received: by 2002:a05:6214:5713:b0:6b5:ef1:72b with SMTP id
 6a1803df08f44-6bb9848f4f6mr2825196d6.50.1722523357549; Thu, 01 Aug 2024
 07:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240731145521.19527-1-sughosh.ganu@linaro.org>
In-Reply-To: <20240731145521.19527-1-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 08:42:27 -0600
Message-ID: <CAFLszTjwL7qZzTmSrJpyPsqhBuM-rRRaiki2DVrfzJ8UypnkQw@mail.gmail.com>
Subject: Re: [PATCH] list: use list_count_nodes() to count list entries
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 31 Jul 2024 at 08:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Use the API function list_count_nodes() to count the number of list
> entries.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>
> Note: To be applied on top of efi-2024-10-rc2
>
>  boot/scene.c                  | 8 +-------
>  drivers/mtd/ubi/fastmap.c     | 8 +++-----
>  fs/yaffs2/yaffs_guts.c        | 5 ++---
>  lib/efi_loader/efi_boottime.c | 4 +---
>  lib/fwu_updates/fwu_mtd.c     | 5 +----
>  test/boot/expo.c              | 4 +---
>  6 files changed, 9 insertions(+), 25 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
