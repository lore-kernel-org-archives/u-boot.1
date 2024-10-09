Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE52CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B28BF8902E;
	Wed,  9 Oct 2024 03:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GlR/DcCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E995489050; Wed,  9 Oct 2024 03:51:30 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D4E89030
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7c3e1081804so3118742a12.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438685; x=1729043485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3/ArSs3bCFRkTtIEBNxCvhP1X1bz07Jqe1q2SzEl/eo=;
 b=GlR/DcCMo6b6Gzd4eORml1IQlhoGsqE9GhefyZVwezHu2ayFvCr5sjVZ0qhbNLlsuh
 xIkYI174yoNV9AAWSjknSQUO4qR4DKB8qAkJ0C7okFPmfdsJXakJ1AY2FpjyLiijBvnK
 aXahYgMlDbwhQWgqfV8NuS42ym0XERz/AfVRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438685; x=1729043485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3/ArSs3bCFRkTtIEBNxCvhP1X1bz07Jqe1q2SzEl/eo=;
 b=LXsvD2ZT4crHtQaAA6rFxTBCUhWk1gnpaKkAx+loVMLjn0wOft22bNbMm2C6irXMU7
 fpWA2I3VvKbEhusuZCAl21kPFxtC6BvF9xY5gFRcQy6jUaj/NMaen/9DPhhgRAVZZifl
 tNGhzLQBjaMDbSMs2UpesMwDBgKIkJ2m6mmQCDvte7yzKL0lvnvC0eJu8nvnfYl8cWaZ
 FhnVgUXTjT+XkMuRc1avG4rXR7ovIqQtz3xytTQ5qzf8M/Qf5+lKOv467TX7+VfoJtjA
 218GReevSEBD5Ior72SRIN9MIcNTAv5QRrZQolEAmXz2iRy/vU4QEpDvFzTAAIXBLPQi
 JWFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwLKWQThmGp5XJJ+LF6XuzBIyFE3AHb85N7Z0fnpzh2AIIg/2oMoRbAht/7MlwWQ2J/WgPSE8=@lists.denx.de
X-Gm-Message-State: AOJu0YzNhLBcEstu2CLdLk/yO9ebHe0+sHkL9vpTZw/UGbSNEtyXFrpQ
 0f/O4H+h8960WtWcADflwiPdCsI++37pyDQ8OvLwLMdU9qqSg46tSaTnF3g1vPC865bdH/XYfR3
 jSlGr4nB1tKuCfbTB7vFl2/rgdfhNQ2eu4DJr
X-Google-Smtp-Source: AGHT+IFNg2Wvg83yJiEgJVUenVf/0ZYeAfSeJY7WpBHMpz1WWu0InZ/7/2Tk+Qc5zXFGnJusEHXri58SbrgJOq/F0A0=
X-Received: by 2002:a05:6a21:2d89:b0:1d6:d330:2417 with SMTP id
 adf61e73a8af0-1d8a3c48d2bmr1542523637.40.1728438685428; Tue, 08 Oct 2024
 18:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241002132633.246942-1-martyn.welch@collabora.com>
 <20241002132633.246942-4-martyn.welch@collabora.com>
In-Reply-To: <20241002132633.246942-4-martyn.welch@collabora.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:00 -0600
Message-ID: <CAFLszTjOfohC+yJDwM43N-K5J3LYFKZC8Omw-n8=ZOisHyF7tw@mail.gmail.com>
Subject: Re: [PATCH 4/4] test: Add tests for the bootmeth set command
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 2 Oct 2024 at 07:26, Martyn Welch <martyn.welch@collabora.com> wrote:
>
> We have added a "set" sub command to bootmeth, add some tests to check
> it's operation.
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
>  test/boot/bootmeth.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
