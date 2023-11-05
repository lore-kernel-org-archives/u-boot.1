Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496A8C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 14:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF4386F91;
	Sun,  5 Nov 2023 15:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jy7TLaM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C98486CB1; Sun,  5 Nov 2023 15:06:57 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54FC186EEE
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 15:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so5982192a12.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 06:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699193203; x=1699798003; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A79gK6CsOsSi4DOdE+LiS+XaD2Ok3vHgW5vJCe938W4=;
 b=Jy7TLaM+ffMCCVu2+UombOS4VLwMN0z4dTlIcQm8HIrTl70iopSwChSgKI9RZ7g35R
 oyskIoOsdHXRJmXsPMEcHKgaKrBJmhY2WWCTWPzKwUxHVOtBBJNqfG6C9UHNIlJQuynb
 VCGx8bVKKK3som1ClLgVCu1eoOxS0CEgIYz3n7WdX10g/hYaKy8RDRWUqqPQ4K9gXs6u
 nxeRLpEkB0aRTDK4RoEqn45df8vLO6s9bOjD85qKCX1+nVP002lg4rlJhGNSuTO3IfyJ
 6Hod8liqzinzmvyTCQgKLIo21OuGN2+vzy0bNTBU18oFW8vF9cI8aQICLq+iAR6bHGWI
 RZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699193203; x=1699798003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A79gK6CsOsSi4DOdE+LiS+XaD2Ok3vHgW5vJCe938W4=;
 b=oAvCtWHsYMFnlHrfAXkGq+zeyTUoSg249hW6qbxdSNK0xqk5LA948qstNyuCHZ8/wU
 60x9jOfAqg1XipcXuhJg9v0DXPsIkPqcMsoNFJnbLgpBEyYeU8LYEWKl9dQi4El2fGrI
 oZPAAHyKmsabIa7OnLxHzs2sE3NcyOOvyn6IHIc4QONc6Do5U0xdmcMvogkoWCEtUel5
 zKG2HyErBzU+33p8jIjRGvwLEK+QlD30FPWdlQGuf5kYzspJYWOGQp6wBnILvEa8nozJ
 9W7En7sEgOTUyOhMyMaJXpPIm/EjjmYBMNHlGYiz/xdumI4XvchiRzo3YSeMq4bDlqgq
 kpfA==
X-Gm-Message-State: AOJu0Yye6pO70xtZ+2yraJNAUwFwjrsvEN2MLKBvONr46vqDHa8rSp4v
 0QKuw5NyEEWPBfClFSYUYBXDusY+f6emJo0CejU=
X-Google-Smtp-Source: AGHT+IGLp1MlCnkuZqQAsheiytK+8+PJBw7QEipK8PLcn7OO8hDROI+vpvbIhCVUM1R96cNHpcUoeS5UWH5u3cTpGy8=
X-Received: by 2002:a05:6402:292f:b0:53d:a4a3:e5cc with SMTP id
 ee47-20020a056402292f00b0053da4a3e5ccmr16166606edb.42.1699193203607; Sun, 05
 Nov 2023 06:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231001191444.v3.1.I9f7f373d00947c704aeae0088dfedd8df07fab60@changeid>
In-Reply-To: <20231001191444.v3.1.I9f7f373d00947c704aeae0088dfedd8df07fab60@changeid>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 5 Nov 2023 22:06:32 +0800
Message-ID: <CAEUhbmXs+r6Rngsv91ku4FWpq59w8Wq=PjX_sGdHjkaY4md8wA@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] efi: Correct handling of frame buffer
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, 
 Anatolij Gustschin <agust@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 2, 2023 at 10:23=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> The efi_gop driver uses private fields from the video uclass to obtain a
> pointer to the frame buffer. Use the platform data instead.
>
> Check the VIDEO_COPY setting to determine which frame buffer to use. Once
> the next stage is running (and making use of U-Boot's EFI boot services)
> U-Boot does not handle copying from priv->fb to the hardware framebuffer,
> so we must allow EFI to write directly to the hardware framebuffer.
>
> We could provide a function to read this, but it seems better to just
> document how it works. The original change ignored an explicit comment
> in the video.h file ("Things that are private to the uclass: don't use
> these in the driver") which is why this was missed when the VIDEO_COPY
> feature was added.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 8f661a5b662 ("efi_loader: gop: Expose fb when 32bpp")
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Rebase to -next
> - Add some more comments to the header file
> - Add fixes tag
>
>  include/video.h          |  9 ++++++---
>  lib/efi_loader/efi_gop.c | 12 +++++++-----
>  2 files changed, 13 insertions(+), 8 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
