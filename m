Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D588E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202CF8749F;
	Mon,  2 Oct 2023 03:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PyTAmW+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B54A87487; Mon,  2 Oct 2023 03:22:36 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB938721E
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5347e657a11so10634103a12.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209745; x=1696814545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h4N0sRbwwkOESWKICfVolxR31XPLQApy28G6F8qr6z8=;
 b=PyTAmW+q7mFiGjquxCo2E//TBStHvcK2IcYFvhMLBSIGn/Mw+5IDrsSzIVm/+Vudes
 /WCNlqU0CGp31f7R+Q9avgye2qPjdMSZf/Ssa2t906zjRnOoEOJHVpzTpBC0dzMkClYS
 vxXYYxQTk0WPoKHW9hHnGI8Dy+drlfyAuPIEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209745; x=1696814545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h4N0sRbwwkOESWKICfVolxR31XPLQApy28G6F8qr6z8=;
 b=Ix/vcPfsiMZPOjHck5nule/OIZlDArWG4HWD2oelaLcvZizInmN+apUMbkWR6DrxsW
 q27dul6YIfBCw+mxVtuFrDMvXzqucIQGMFZI+zIH6akjwC+7+VJakBv4pyhneGcUpXbB
 HDdpjcWKF6d2h8cFYNx8jDOdoEeMD7K8gKAPyPc5haaUn13vp+ouPY2MIA5W/pesFjOW
 HHZcjmQP0KZtEaYuB459CwuCN6eFaVWTEUoxEo/ZeL4p/hlZVoDn9ULLlv4RlJRhSiYV
 bZQS8nvx5HFTlF4Xvtg342DLCI2V+cvkl396mnI0i/URj2bIbe65nuH6Q4ttkliF22MR
 m9sw==
X-Gm-Message-State: AOJu0Yy2C5Xtu1rXLEnuJDjsNsezmyAeRpnDJNFN3sHdr9Fy7wHhgUen
 UHkTBO5WNXHfNh33zju2mlWuFEjCClxF651YehYpTg==
X-Google-Smtp-Source: AGHT+IHJFbch9xaX51e5UQ+yaX4WDJmTsN2tIpcWNZBMFJEVJE9l9CvJKuPO2uhyn2aKZdLtIik/2Ijd0I9SS3842Oo=
X-Received: by 2002:aa7:c1d1:0:b0:530:9fbc:8df5 with SMTP id
 d17-20020aa7c1d1000000b005309fbc8df5mr7801370edp.9.1696209745351; Sun, 01 Oct
 2023 18:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230929004717.37413-1-heinrich.schuchardt@canonical.com>
 <20230929004717.37413-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230929004717.37413-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:45 -0600
Message-ID: <CAPnjgZ0iQxp14c+MT__3jUJ7BT=zWSvpK44iYug8FfcsTwYqcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: serial: fix serial_post_probe()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Michal Suchanek <msuchanek@suse.de>, 
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, u-boot@lists.denx.de
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

On Thu, 28 Sept 2023 at 18:47, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The size of the name of a udevice is not limited.
>
> When setting the fixed sized name field of a stdio device we must ensure
> that the target string is NUL terminated to avoid buffer overflows.
>
> Fixes: 57d92753d4ca ("dm: Add a uclass for serial devices")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/serial/serial-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
