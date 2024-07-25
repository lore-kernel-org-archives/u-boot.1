Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14B1C3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FB78862E;
	Fri, 26 Jul 2024 01:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HgvMb88/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF011884AC; Fri, 26 Jul 2024 01:32:41 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD118842C
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5d5aeaa9751so280204eaf.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950358; x=1722555158; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gjmNa/I/KK0DpGyGSJ2xzxN7PeQSr/ziBpkxzZIWJYA=;
 b=HgvMb88/aMAIX7CS4i8bPxFmPyrWAqUhNrUfGNsglyhRXSjGTmZzz+tDI150jodIPU
 r2bbgTTdrDmeP/jbJgdp0mlzkRAU8+KDXxauhnyB7LwhY+vbQWbnpv/ZszeHlDzWxjK9
 bDTsqj5QfxDRyxp3PzjYQBtRFs8+C0sCQtasw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950358; x=1722555158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gjmNa/I/KK0DpGyGSJ2xzxN7PeQSr/ziBpkxzZIWJYA=;
 b=eiLQoBiDQWL8LJ2whGitoe6K8qaazprHIM4xM51YGLRSAGqeuZE/uRRriUoq2ET0OZ
 H/eFLs7NuJlaj+JmUSaSAjXcSSpXyhoISESomA70i3twygmqyFmwHjHUt0KQc4tbhJut
 20oQaMD7QaG7j/zEwyy+sd1/YSG1qJmMfH+bBK45jr+qgg4RH6nueR1WMJX/UJykhYt+
 riKzSDR+ttRB+lJauNNC9kxNxXJZXmsjsmyoMs2+LZBC6HjQ0vnQtOt9Eef9BPQgWKi7
 E3tp9lbQB5D1sbsSvTMd1TxjlPwmOf9UikUkUBE/hbtOqzCpSTD/pIm5pUWs+MeHmFcH
 5vng==
X-Gm-Message-State: AOJu0YwcK75jniK1tXkoOPXPzwfLqwY0nU2to0xLKnTHQ78POYM7TJoQ
 JiLKquTv8imS+izPH3pFcdRwCXOMGqj/0s+YglO/hUiZ2s9unz+JhSdTydjdmatbkRRHbdsOXCU
 ShJdBsy5rsK7YYBv3JPG9jto8bL3VmiYctSfP
X-Google-Smtp-Source: AGHT+IERxnJrq7QBdavY2oLtA+36q887o9U2BFR1ND6Tz35xvmOF4bXdHkX2OWxQwVlkOspfH0qJzGTy0lux6E7LzCQ=
X-Received: by 2002:a05:6218:260a:b0:1ac:f722:4d2 with SMTP id
 e5c5f4694b2df-1acf887dd11mr581365855d.18.1721950357814; Thu, 25 Jul 2024
 16:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-17-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-17-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:27 -0600
Message-ID: <CAFLszThWjpz47RRhAbrYqu47NnYs3ZtXWe-hE5ABw9dokyQ46g@mail.gmail.com>
Subject: Re: [PATCH 16/40] lmb: allow lmb module to be used in SPL
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> With the introduction of separate config symbols for the SPL phase of
> U-Boot, the condition checks need to be tweaked so that platforms that
> enable the LMB module in SPL are also able to call the LMB API's. Use
> the appropriate condition checks to achieve this.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc:
> * Replace conditional compilation of lmb code to an if
>   (CONFIG_IS_ENABLED()) in store_block() and tftp_init_load_addr().
>
>  board/xilinx/common/board.c |  2 +-
>  boot/bootm.c                |  4 ++--
>  boot/image-board.c          |  2 +-
>  fs/fs.c                     |  4 ++--
>  lib/Makefile                |  2 +-
>  net/tftp.c                  | 40 ++++++++++++++++++-------------------
>  net/wget.c                  |  4 ++--
>  7 files changed, 29 insertions(+), 29 deletions(-)

Same question as previous patch...do any platforms need lmb in SPL?

The cover letter says "The LMB module is enabled by default for the
main U-Boot image, while it needs to be enabled for SPL." but I don't
really understand that.

Regards,
Simon
