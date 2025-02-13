Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6239C021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 17:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3615E80F42;
	Thu, 13 Feb 2025 18:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FbXJYOUt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB9B80F5C; Thu, 13 Feb 2025 18:41:13 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B487B80EBD
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 18:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-307d1ab59c6so12140791fa.1
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 09:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739468471; x=1740073271; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2WoJLWMVpIKK/U20+VyhG6V07DCPfjQQMrjzlPtr84=;
 b=FbXJYOUto2X94+pGGAWafPOlAvjWAa7gLr7Hb+le162yPxV+AYxo+rJ5lW2q5S66pt
 6inItWXyWYpaX3Zj/gfkdW1GbQDRQbtBh187qVQGJD+usD9Dpbzsdq2cJlwmZyPjn/2w
 Uv1f9w6QH1eh7eGMgMgLBzTr9D9mv083DocYXerq1ns4cyoA8AskR1SkQ1M4TMYKxmQM
 qx+QmhyoJoHmH2XZbeojPu2+Ws6KFF4A2KZiIl7FBQX41A6cvRxqduY6ST5xKmYZc2Ft
 KTm1EEuOMuMTFSpx1Ihtx8Przbt3r+U4y63tMQCnCFNVkcwfcDBHvvZNGBe84SUQ/QSr
 WNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739468471; x=1740073271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K2WoJLWMVpIKK/U20+VyhG6V07DCPfjQQMrjzlPtr84=;
 b=CaYN+CURnumOKKx4zkVdaOBldJMssoYfZJ5BHZGPvQd9BVkBd+99ii5D0YgdjG/zy1
 l4YY15EFA8nCgByTUAql4JqyrDqG8VbqRnrVjUxaeoCv9NIQlGm2cFugFmX+AA1W8D13
 /LKuubGpQOqjsDov54C0cd3dS3hBVpjPtxEgDFdtoKmOdhavP2K/GcLyhuIAC3hOvGzq
 BGAWtazq2xo+NmWVKqqCqbLi+6z3sfIu1zDa3FiDJPw294qHjtAsUfTxoQdUwB6jAA9M
 vTvWYhLOE0Fw0OqslGOrilV5iXPlW6uThukf0Upo/dKzVx3uwnVNrD5IcBDvaxSnDePa
 uOSg==
X-Gm-Message-State: AOJu0YwmlfhSWiIiz1WOrFGmUGzFoeWQq8r7EOrMHBttgoK0kmNkoP7X
 BSO09EG2jlUdwqQI4+RMPCPVmD3imwaKdCM05Hf2KfnJq4VzXDjgs9qXQfdEJBKn8OU8aXCuWHl
 l+rbeyUZDktzGqYw6Y8R+XxRsAc0=
X-Gm-Gg: ASbGncsyO6VcEv9jAQjG3yvW7I3l+jtsELqyBPqAPrAHk2rUWIlg7UJFbvAT8TbmalB
 djtAUuO9VWku40F7gtkoRFH3rPrcnENVbbBKu4mTkUgnA/ONPEPV8RINP7/tcfOBKifdYjifBhE
 jz92u9Jw7GtoY4Dy7Pfb8PaeiblXyp
X-Google-Smtp-Source: AGHT+IHpWz+g66ByeKFHIrDQWjXgkN/BeAP1dEU7mLoH8pfKuLnzwgnCOynkmLH41INZZvLSTjgK+MPxwsT3MdMLxS0=
X-Received: by 2002:a2e:be91:0:b0:308:e9ae:b5b3 with SMTP id
 38308e7fff4ca-3090362f816mr28222721fa.1.1739468470607; Thu, 13 Feb 2025
 09:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20250213162123.69159-1-ludwig.nussel@siemens.com>
In-Reply-To: <20250213162123.69159-1-ludwig.nussel@siemens.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Feb 2025 14:40:55 -0300
X-Gm-Features: AWEUYZknLyXAH0IX4jGD6Z4YBl9HdqxXk8oIjuwX6SwkrNI7vRZegygjfzjGF5w
Message-ID: <CAOMZO5DF6HVfpdRq3X6jT_x9jv-C5jmfsJpT0mmLARAV2xqUDA@mail.gmail.com>
Subject: Re: [PATCH] imx: fix imx8mm_evk config
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

Hi Ludwig,

Thanks for the patch.

Adding Peng on Cc.

On Thu, Feb 13, 2025 at 2:34=E2=80=AFPM Ludwig Nussel <ludwig.nussel@siemen=
s.com> wrote:
>
> Commit 364ba68ed1a adjusted Kconfig for imx8mn_evk instead of
> imx8mm_evk for bootstd. Therefore mm is actually left building
> without bootstd by default.
>
> Also the name of the dtb referenced mp instead of mm. IIUC
> CONFIG_DEFAULT_FDT_FILE is meant to point to the path of the dtb
> within the kernel install directory. Therefore adding freescale/ as
> subdir too.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
