Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B225CEE645A
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 19:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D294A84189;
	Wed, 31 Dec 2025 20:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RjgFalJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BAE88418A; Wed, 31 Dec 2025 20:30:44 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E1C84183
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 20:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b7633027cb2so2000588766b.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 11:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767209441; x=1767814241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZFgW1xmFe/BskMoQS5rTg34tLLUCJPoHILxuNUpoP9s=;
 b=RjgFalJcY8RvvS4vrJpGFGgDygoVJKBBzOfDviZnxwnm6NwMcm0ZN0C+0N9XuoCJ4l
 Lg5dAVq1/7YR7z/Lo3CQxxpfCGRLMycu8HOAB4zTfcQnQzZfMWA5droYj988NsmGmDPQ
 keGZLaTb9seg5JU0tfTVbqQLSG+2w5MRdpMvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767209441; x=1767814241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFgW1xmFe/BskMoQS5rTg34tLLUCJPoHILxuNUpoP9s=;
 b=hCb0KESiD+5nZ1cgpApA33S8TMDg9ZfIjX2qvZbGit4BjLCayHAZCNHobHGSz/TMVe
 S9NKxvnJBeqnd1FSGd52pUOlYJr2Aa/A9L6nvR006/JZQmBoFnd+YI4XLfLHn17P2+Cu
 UtsIfGa+ZCYajpIzR49TO4LfIF10j/wk7boh3y1pyYyZOE4sRW6TCnYkmqyd+nUY5dqV
 rP/nvDnS4ANwWK9OiXPysvfJD9Hht76iLchCXOVUEKkoBa6WEj3MoL7+cDlG2VYGCOc4
 Wh44Un+TXrNcuyPWSnLYip/btnkMyxun6NWki9oAOn9Quq8Cy5bXZVFWURVT5KzGIjob
 l/6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgW5i0By1V1efzn+uT83h4/RFV7Y1J2EG2mNkUnkBq3cjl2R3FIKlMVq7TGbqFLOjs00ls6Q4=@lists.denx.de
X-Gm-Message-State: AOJu0YzfuGRicpnbO3kK48f7k3zAQJNheE4L/IEZrN5NXOkj7HAjql/O
 HMjTI9OoXhkITMfmGcHsIYZrzAjdNAbPdJNrDMiOoOVxKDzGU7jZQB8DUTqzqUomV/+YdEV5Gkz
 oNMYc/4I0mHMs3yw7eJ6bADg78Ggod21jTu2fK0Tg
X-Gm-Gg: AY/fxX5XqR5fG/e4BGuhni3Dci0P1EE+s5JLiIvGAIqDpEYbD6j5udz6BwHKdjbsU3t
 Q9dP4HJliD1WbQk/OuwVJw4DfiZHSSB+b185By7uhcNBE2x/yo79yzT49/2xOEQfW5I6GXqnnyN
 T78m5o647Ej8ohYUB/T6L58i85ZZx3G0/9vVPDJsEPRPKoNWAmyLh0vAoKVk2KYjoFCgQCyW5Xm
 2Klq65VTCZEI4Ps3JGDOgRlPRv6/y6oMOr0vAfnXZdYCMowhmCeEux8pE4v/GlVHhdGFF910/2Y
 wiAN
X-Google-Smtp-Source: AGHT+IE67+BRUXsAPUtIQ1pUqdJVEqKXUbs0D2PCss5oZMXqu8fT/mjXlH2Ladr8T9Wiw4cgdJmhvcN1VochGBhHMUg=
X-Received: by 2002:a17:907:d87:b0:b73:5d8c:dd0d with SMTP id
 a640c23a62f3a-b80371d69e5mr4073403066b.52.1767209441560; Wed, 31 Dec 2025
 11:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20251231153719.84716-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251231153719.84716-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Dec 2025 12:30:30 -0700
X-Gm-Features: AQt7F2qeY1aJwi3Pf5v16uKBtjhhKYczL3_AxublryG_y9lADlZrvP5s3vPbuoI
Message-ID: <CAFLszTi1tQnK6dGAPyDizZT6mvD0orMCWmssDUVwNV2oMh-9Ew@mail.gmail.com>
Subject: Re: [PATCH 1/1] video: correct label for cyclic video_idle
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
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

On Wed, 31 Dec 2025 at 08:37, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When the cyclic function video_idle() takes too long a message like the
> following is displaced:
>
>    cyclic function video_init took too long: 87707us vs 5000us max
>
> The text "video_init" is misleading. Replace it by "video_idle".
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/video/video-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
