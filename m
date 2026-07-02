Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF0DC43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1592D84931;
	Thu,  2 Jul 2026 11:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B0DBJjRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2F38496E; Thu,  2 Jul 2026 11:44:29 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16E34848BF
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 11:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so1001485a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 02:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782985466; cv=none;
 d=google.com; s=arc-20260327;
 b=H5jHIoDq1i9QieFmYLVuoH6UCLrxgvaGsPbYHURfM2rLfAHnRmFPvJPKwc6vvmetxI
 scjfj+6DZzN6RfsImYpk7XT8ZYQecM2kqgp0UkyTPlljMZ9Nk7yid7ZXInyisZnyfV5G
 mxMovHiizzNQs5zQd0LhgDnNlUgzeXyiLCAVaG/BldNaAv4tQhmgYocO0AA7kNi9UVtZ
 nTzQ5Qncsh7DleY/GhcOLKwWzQw4EBFUaA1F0Gp9rJ6ATv9tIto6FNxFiv2Mq8dYLlhD
 LzWDyquUvraceLm2mZ0ZOOTLmeVMidpu+6v74OtFmPQLwWg8i/PvS+cKEjrHnkFJUIX8
 NoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zr9zl/oo9BgpZ8pGkZfo3dIkwmrThuNawP9fqOWB6mg=;
 fh=7xLaw+TyjDBB/PI/pFqi0cWKvk/LlWfgDxhuYlGjr3s=;
 b=fN+6RuTd+PMKNantSzQhE/oTq7EjPizDccKzdZZb/8mpsDRLx2d+3xnINO7xh7Lrb/
 l2XYngYS+GMAvbzCBoL+cYlylkL0KSzsnEYCpIaPkG0O8YYvVxlIFm/X6TB2p0Xq3IMV
 LotSNqGUqBSBflV/F474fGuo4HqZoZtKilN6VVCTNyj803g81YlM1F/SZaRmYh9NT6qy
 xpp9FiM3DqV10Pgf2dxOeXY31UbXXwdSNQcm0/Dfl08sf0ozDgZwaDKghpz0cdFo92cV
 6PnAJGZ+f50i7KYjryP30Lw/TTlOPnvBMCgJhqrDQC1LTgH7HQ4TvfFl2Q/VUZc7LtNE
 BDiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782985466; x=1783590266; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zr9zl/oo9BgpZ8pGkZfo3dIkwmrThuNawP9fqOWB6mg=;
 b=B0DBJjRtqs8QpE0pLgu5eji2FIxgEc4EIQZbnVMlVPn9c9iC2P6irUmJvF7zlmZBMN
 l9JfqeK/7EojgQ/6vAcdg8K0HgPsCET6RkSYAZtnXCs1tsvtDtI33MuThWLDXDWgDR9G
 fCkCJ/cYGN7PVpN6x1DKStKGa3BJYzDLMG5mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985466; x=1783590266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zr9zl/oo9BgpZ8pGkZfo3dIkwmrThuNawP9fqOWB6mg=;
 b=ookWzuWblp+keuBoRaW1POuIaF3QNgIAu/jtPh3NgPXqevm/+i9AGTocChDYdiuD6/
 TCQeFdPHDo9rlf+a14K9DMD0QVtRI0cJc7nrh+YUskG/Y7kXQg09fsAifYgOTAJfhImb
 lKxOIJOhbqQbS33bvFSt2eXSMg6yBm6P/B+3KIUHzM7vqXQdNJRNuJWinQelSWdpHvW7
 PHC+XDsa4uJ50YAd14+77uPxdTKNRy6kQmVfHRsEs+PU1c4T9JxFrvZo1VhKe+778M6+
 dDM8l08n+FgcphCk1GYj6sAtm3lv/iMwDFj8BN3nC9pxuw8lcax4pZFcPVtXgsTXfuTt
 Bmow==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/oAjmtQ0ZL7FsfI9NfhIRWwkX8jYDwd5eTFCiAJv7qzFkeR0FbdYg9WsATnvX46uSNauzjDQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyE1jiEMAUe5D4SMp5N74yLlmJPitytZojVghwyI44wdXht7ByU
 oRt4zem/Urn7dxTpGflwBZ+uO4BcOWhlvODk0Kp1Q6mX5MqN4Wa3U+ayiB5ZqS2aEJMLEDHrVMi
 hStA5df2kua2Bkv2FjhqU8bwAaTK09Q/hrc5Dn6Zk
X-Gm-Gg: AfdE7ck53GxavEOdAgwktQ/N/h/o+DPbHYwXS269Gbh4FnUN6iBLozejmTW1vXEd4cQ
 EDIdG7sQUYGrGynjHEmnn3Z9i57FfTW8wZ4dDU+cI9BOoDenpDF7cQx2cy+Xx0v14tBGSQwAlzA
 vAaf3NB/8cyOaZFElg9y1K9pykyD5JK7WQc2hReWcc07KOJfHZPsiPnQHOzuiosFRkAviKLygsG
 tctsWhfJMz857gjwOsABp9QZP9BHvG65Er3SWwIYHE5zyP9kYjdnZnwKVo0Ybo+Bo1ssitQxw==
X-Received: by 2002:a05:6402:434b:b0:698:3b7c:be63 with SMTP id
 4fb4d7f45d1cf-6989f38d21emr2605663a12.31.1782985466553; Thu, 02 Jul 2026
 02:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-6-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-6-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 10:44:14 +0100
X-Gm-Features: AVVi8CfEPLVEC4mm37mGvjxBxq3SVVbI1AX-43nNZN3elYhHXl5D_9mVOhqkF7M
Message-ID: <CAFLszThVbkK6AXYD1CknRfGcZBWZW72B0nErmDCE3rfzLSO-XQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] image: Define IH_ARCH_LOONGARCH
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> image: Define IH_ARCH_LOONGARCH
>
> Allocate the next value to IH_ARCH_LOONGARCH.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> boot/image.c    | 1 +
>  include/image.h | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
