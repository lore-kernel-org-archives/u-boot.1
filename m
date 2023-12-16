Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CE1C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B1E8775F;
	Sat, 16 Dec 2023 19:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JhCnVT8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00CA28780A; Sat, 16 Dec 2023 19:46:59 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEDEF87729
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dbd01358170so1092992276.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752415; x=1703357215; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8e+ClWU+qooDImHsk5xQ8Isj59Vg0SOQwo7n7ef0jbc=;
 b=JhCnVT8+lRyBKQPo9Y3egPKNiw5il9Epk49O0+wvzbgHgFnpKz1Jf63Z8c6p3+7ipc
 3x67sYtdvRXncxyYkEjVlfd8YiIlgswBlgzSTBxzHeiX2e7oA5+I/ozaTDqgPfYSwuOo
 gxjzqX+DnzGmh6drkJSTqjY3wgB/EwVVhxnik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752415; x=1703357215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8e+ClWU+qooDImHsk5xQ8Isj59Vg0SOQwo7n7ef0jbc=;
 b=rZSQBvm0QahfZHSq5wjIVtY+RwRhBYMz7w7n+rnAXGuUsMYL6CdVCxphk9GCJcqW9A
 k+Qm+fMzWLI65JhQjrL8c0Mb1RyraPZwr7daabD/Oh+Z6MNXBU49+vIshUr/31bSrrGX
 uTWb4XQ4sj4pe+xP3iGdebA8clidOy968DMHgrRvUQP9DtITMCtvadw5EyuxMTenSeqB
 paHUvYJ8tS9SbSAkpiKzFvdmUW8kU3cLOnijEfHfHsVWsAqToqHxlQQOPrngBELLFGf+
 lgKONJw1J9cl3EEWEcqVbZAGwo8YEJ4VQrufksKLedVKy3Xh+c6Wm7ugTBIt8OLmbsje
 pyVA==
X-Gm-Message-State: AOJu0YzVbfTNL50fS7xEBiogrfWzMR+rI3BVH468AcPIzMr/tqKQxPHj
 Ux2qOblhCKZaFVelw4pZHTF3aFs/SM+ZEursTdBAVg==
X-Google-Smtp-Source: AGHT+IF7/p6+y8mAi+oWhZkWQEV7DgY+eLwlZcvwrNJAa6ebPwc85BKykb1/rNdl0uyGECYJn2wxpaChiGjtBbGWhlo=
X-Received: by 2002:a25:d6cb:0:b0:dbc:e819:fff3 with SMTP id
 n194-20020a25d6cb000000b00dbce819fff3mr3389109ybg.54.1702752415470; Sat, 16
 Dec 2023 10:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
 <20231216081200.7677-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231216081200.7677-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:33 -0700
Message-ID: <CAPnjgZ2=Qd=u7z90nYXRXNUBK6Sdu4iDiBmT00OJMi0FU1_nbA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] acpi: support 64bit in acpi_find_table for DSDT
 and FACS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Sat, 16 Dec 2023 at 01:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use X_DSDT and X_FIRMWARE_CTRL if available.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/acpi/acpi.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

This could really use a test
