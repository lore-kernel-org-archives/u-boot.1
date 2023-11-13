Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE52C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D40870E3;
	Mon, 13 Nov 2023 15:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kdcoeDbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06EC86A4B; Mon, 13 Nov 2023 15:00:56 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43E988707C
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9df8d0c2505so906733766b.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 06:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699884053; x=1700488853; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TgQjEF6ql5oPGAWfuUsfS2hZj6syPYRZPTWyzN514LI=;
 b=kdcoeDbSk38qAcPzRgIlHrY9yFo4Trmdnmy1BNs1alNMzXdnvc0vxckQUPX2N85aPq
 rBsmI9G3Fvo4+ZCTdp51IDueWuZWfFvN+YygSj6Fi6RVGprilZkZk8ujJuw+zf8FDU5n
 5JJueJuqvcY8ARRFj4TU1/SrSbJXdD5ZuQKO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699884053; x=1700488853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TgQjEF6ql5oPGAWfuUsfS2hZj6syPYRZPTWyzN514LI=;
 b=o89nOWpx7qJpVrLIWz+zl1W7xSeoWqQUG2JCgxSRwyeIqnRKrtXiM4/d/sWCGrE/rZ
 2363tO9xr8S9qwAB1AMTtrLTYiMovv0kGmrusvrrDftiYtE67dbZ+l/pciUjO5yQuiC2
 FBveJIH/wHwVMlR+NETiWtlXC/p9JEUvvw1wglS4TwLDtsxjHDtMXncuvMEvWFrXRhC0
 /UkerYhUq1mJBe7TmJZZgD+Fz8Doyh9wpEdJZ4qROt4kt15MLg4zMPzRz8yaxkRRKY3G
 LxoeVwwlPpuY3yUPB+w7S66lSKXB+5J9ex0sexXtI6jQBAvHeLPYNT8IcduuHspKtbCM
 ihjA==
X-Gm-Message-State: AOJu0YyKbj2w7xTu1whOA7bNQuK9Ag0cqcOF/qjU9rbTrYuNAwDDTsOg
 aUQilN1zAnL5ON4Wx56Z7J+HDZvIuqAQk/FttcGsbg==
X-Google-Smtp-Source: AGHT+IHECrNgLmtZX6geaPNDoxsm4zBKWhd0jT0R51CWWHUFO/1A20tWmQ6cWVrChkpfnV9Css1LQxPGYD4+jpTBva4=
X-Received: by 2002:a17:906:2882:b0:9c7:59ff:b7fd with SMTP id
 o2-20020a170906288200b009c759ffb7fdmr8516583ejd.28.1699884052470; Mon, 13 Nov
 2023 06:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20231112235356.12260-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231112235356.12260-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Nov 2023 07:00:39 -0700
Message-ID: <CAPnjgZ0SDY7UKeUyt+spaou3wJ=Wr3+B8BXSM+0QX05UjURZ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] acpi: cannot have RSDT above 4 GiB
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Sun, 12 Nov 2023 at 16:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The field RsdtAddress has only 32 bit. The RSDT table cannot be located
> beyond 4 GiB.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Avoid superfluous 0 assignment. RSDP is already zeroed out.
>         Use constants form linux/sizes.h
> ---
>  lib/acpi/base.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
