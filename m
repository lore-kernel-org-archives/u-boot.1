Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24489C36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 10:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D7158059D;
	Sat, 29 Mar 2025 11:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j2dVARzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E995E805C8; Sat, 29 Mar 2025 11:04:45 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B7E800C1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 11:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso30472985e9.0
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743242683; x=1743847483;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=570WfIrvyUKK2usJwocQhJlrbZS25/e8Iro4e8NBuIs=;
 b=j2dVARzBHIAbSXQUL7gVoPmxWCNpI2GBfcGlv+LFovk1y2dmRn+t4v+xpCT0GQsXqj
 YyI78SG0tIazefmBOn2S9KUf3M0J15UuyIfEVtKf+F0eKJXUGq/ISQtjxiXKjRC+Z8FR
 hjkg1d8KAa2bpAEUZw9CaVYlwrebdfAgO4hxHe14BGEc27724sq1r+GAGMD8zK+XlQ3M
 rLJYIpvAcKfOAj6IqCZUWxdU2BpvoFLWuRQaUnYsQ6AMLleqNKlp9J+MIPm8eKU+MRYw
 f7UQ4VVPaP0HduPFHU0sdjW3PzSVRYLoFcS/KJmeZ2mBsGrh+X1gIF7BjiOqe428Um9P
 B/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743242683; x=1743847483;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=570WfIrvyUKK2usJwocQhJlrbZS25/e8Iro4e8NBuIs=;
 b=EFwj+p2d5DzwrfFlPhTblSTDPffz+EmdJSILH/h/epMcGLdvBQ1mRTklb34h3cWJfN
 B2sCcs9SYEnIVyg6r2tVMBssFewZSpJYLqFFq9UEgTXLuOuGkcyzvKnVnlj7dlbRIm7w
 IKyyC+QvoZLD0xMFFnCTziFNj6BsR6bQF6MpFgowX+aIQmVLPl3HEaoL8v7kHFxJq3aU
 Ds2CgxuPdALEKQXy2czCgE5aFg+QUtVY0ZmdZ92mJuWyezXF3l5RtuPA8G4KDGECedxM
 V0iZC0wCq4bhPLIgMLVPxIiKvIERMoix2+zsmQUfj81idpLIBLWbfFPgqXDQYwWSzhOc
 LfYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLhg+RIcb6XUyu9N8YsgH7//ksbyQZc9M8ZoBlQxTgovmUvdZrnL4/DGUjfEXdnlLTdfT+rWM=@lists.denx.de
X-Gm-Message-State: AOJu0YzSDERKLAMSAFwBxGMz2nGMPXWwCcQ0sItHzCmUi1mev5wfe4aW
 8Y4SKLyHsnx2GGWf89Clrvcpp2pAa0kJwzcW86+Ams7RCSfvhq3Prg8wpkvmoQfyOcePiQUPc5E
 E
X-Gm-Gg: ASbGncsBF17vSUKxf81YKCN3XnCj0NgsPQUm722QOkKmNajIajn5GIBVpx7xdM2AAu3
 Qgn+YLzrvqhFtTBIhQVD9iQ++HjMWUF9GgcNzODC7+wfog3OI/tdL/D/wxU0SQfji2aoSaglr4r
 7M+uwUL+yAt33Vua4vzomSvoqYVv2jSRpcozdqU8LZQfCQ3qNaa0vCvOmdEvswFCOO9ZL0i+Uxe
 8ZbzIMYjSKYtsQzg7fSaeCQfv6PXfGIYF+4ptA7S0dAICZ04pRbdky1XQRDion9LoXwPdVU1gZf
 DfnU6DOIebqAY45gLG/TY1AgiCMjFDXBpR/W0X4EfoHaR3wVTRPMJmk=
X-Google-Smtp-Source: AGHT+IGFutMe8yomQdk3Z5itJwgIXTEMPTlUd13JX/Rgk/uQU9/n/zdTaHw4y6V5msqJy4uds9tDrA==
X-Received: by 2002:a05:600c:3ca6:b0:43d:98e7:38dc with SMTP id
 5b1f17b1804b1-43db61d823emr26495515e9.5.1743242682787; 
 Sat, 29 Mar 2025 03:04:42 -0700 (PDT)
Received: from localhost ([2a01:cb1a:4029:8df0:34ec:162c:f374:eb39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d9142a5f0sm41706595e9.0.2025.03.29.03.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Mar 2025 03:04:41 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/4] usb: gadget: f_mass_storage: Fix crashes on low
 memory devices
In-Reply-To: <CA+GyqeZwrAaQ_7DcvY6VgnVo0WTsMBiZsKZBmWVzQu2CAL6_xQ@mail.gmail.com>
References: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
 <CA+GyqeZwrAaQ_7DcvY6VgnVo0WTsMBiZsKZBmWVzQu2CAL6_xQ@mail.gmail.com>
Date: Sat, 29 Mar 2025 11:04:39 +0100
Message-ID: <87tt7c885k.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Zixun,

On ven., mars 28, 2025 at 18:38, Zixun LI <admin@hifiphile.com> wrote:

> On Fri, Mar 28, 2025 at 9:15=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>> This series fixes the above mentioned crash by introducing proper error
>> handling and freeing the buffers in the unbind callback.
>
> Hi Mattijs,
>
> Thank you for the quick fix, I've tested on SAM9X60 with multiple ums
> commands and it works.

Thank you for testing. Testing on hardware is very valuable to the
U-Boot community.
It is so valuable that we give credit in the commit history for testing.

In order to give you proper credit for testing, a special email line is
expected to be found:

"""
Tested-by: Zixun LI <admin@hifiphile.com>
"""

You can also specify on which board you've tested:
"""
Tested-by: Zixun LI <admin@hifiphile.com> # on SAM9X60
"""

This allows tools to automatically pick up your testing efforts and put
them in the commit log.

See: https://docs.u-boot.org/en/latest/develop/process.html#review-process-=
git-tags

If you are OK with being mentioned in the commit log, could you please
answer this email thread with the special "Tested-by:" line.

Also, do not hesitate to use that in the future.

Thanks again for contributing to U-Boot!
Mattijs

>
> Zixun
