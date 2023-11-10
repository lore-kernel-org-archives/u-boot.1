Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE2FC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 11:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2286187743;
	Fri, 10 Nov 2023 12:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pa9oyB7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6956187585; Fri, 10 Nov 2023 12:50:49 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B0287785
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 12:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5446c9f3a77so3351223a12.0
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 03:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699617047; x=1700221847; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kJBsVqWalDGiOGBhd3fdkJrBEx/30rh7mVlmqH9WDUU=;
 b=Pa9oyB7c+yDiQjKS3Vab6e/qIS0Y74WYI99mLp4pFWlUbSuuv1v2W8pB7Le2RoEM5A
 v73BOlZDA9rvlqkh7y+kA1ukz2bnHD5x8ds+O0UkfC2UosWLSvNI28OVHWFIlWH2F2ot
 5izrvvi4MSgROpElb+9rB7e4f/WnT1KpxdukU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699617047; x=1700221847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kJBsVqWalDGiOGBhd3fdkJrBEx/30rh7mVlmqH9WDUU=;
 b=NCsYtwmzqDvnFixzaZyAqPIozDm1pue3K//T2l+Iwrrr930tbX4DFi0gpczyhQspQ/
 UcWOTKty9pakNC+oWijTPJH5g9RCasxmiaSmn64W4ije0rffjyhGor3KFjwyUVAooSj5
 sRu9K99wllCBRKzv0OBKB6NW4CSj2pdEXlOSfzSFG8bTSIW6kSHxS+p6DuUTV45tUi8b
 NFkyh+xNEIZDiyAKOdPU2EfFjbpz9ZqlWBjz0l6OawBAG120JjUaSqgb2sQc2NsvTJ01
 t+XHSEjmvQNi8Pj7jaIlhWld2KF/NKYAvop8M81erOhdIzZBaQ3r69qGCVtAETkP6Ogk
 dKlA==
X-Gm-Message-State: AOJu0YzauyJhidgMpHfc/4vHq9dnz9ERRMQOP+hQMUzPyTS3smXX7mjc
 vxnZSxRLl/il8KqykMwwSDYEcr4W4Q6NOeyxF66QiG+iMxnFi5ebC4c=
X-Google-Smtp-Source: AGHT+IEeSqSvGonx8hW9nbt24VW6uTE0zuQrSb4d0j/86Io3XkVRUty/8Of7zuWfwjaNsL+q0xRjhbdAOLb8cFkVR/4=
X-Received: by 2002:a17:907:318e:b0:9e3:675f:e36b with SMTP id
 xe14-20020a170907318e00b009e3675fe36bmr5391305ejb.59.1699617046975; Fri, 10
 Nov 2023 03:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20231109163507.24096-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231109163507.24096-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Nov 2023 04:50:35 -0700
Message-ID: <CAPnjgZ1+M0_B_rGie-CxFWoHiayZOr-EusfHAYm=e1VgNcEg5A@mail.gmail.com>
Subject: Re: [PATCH] doc: typo 'form' in qfw.rst
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

On Thu, 9 Nov 2023 at 09:35, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/form/from/
>
> Fixes: d46bee8c2d24 ("doc: qfw man-page")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/usage/cmd/qfw.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
