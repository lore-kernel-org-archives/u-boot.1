Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA51CC46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B76887CAB;
	Sat, 16 Dec 2023 19:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K/A/fFJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B2187C18; Sat, 16 Dec 2023 19:48:42 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB54187C78
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7b71b10391aso91216039f.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QiwDHwmOL0hZFZcyXavudqS0vIjKojY51tsKBuYa5cs=;
 b=K/A/fFJtTJiqyTgnO9qwLRkVNGoRrKej44stcw0d0sA02h7gmk0CChUa88k5wr7jpz
 uSdxhIQVOfvczsDXhurw8L+KszvcE/JUeJsuDiEem8lC+MM9kM2WklPZsahu+kGqWkPA
 B52V+hG/4SU5sl+vNWStWc3iNXqbQFXAM3BIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QiwDHwmOL0hZFZcyXavudqS0vIjKojY51tsKBuYa5cs=;
 b=eTdZqJiWf7TTCY+q8Yq4Ft6+rX14VBLK/Ld92w+pXeeCzZ8AXAa8qTab1nxLA4Fx46
 b+BSLmIiS8rKWiyjv1MBKjTJ/V9B16pop1dW2YuIJUcsSW/DZdXKKuAHRmcZ1//i2WOh
 19MKg7+0v2m1hlQK76scYskeaqun1pt3xcBN35WkQVlWQKa1Hp3dJzUlEuN9AHeFSzkX
 5+3TTXO5xAodEOZS/pwjgQazsQu9TcXPD3cvTN1j/BJCB7zfLyfI2h+enLJoP8yf6p9D
 aIv+7XU9txJrUwHDIErnALtUucDErlAUPCd0Pdx95Eagl8KPghb6GMJsPD8Z53Z+F3ry
 aSUg==
X-Gm-Message-State: AOJu0YwS6ln2cplP9bycem2GwXZgeFL7u7gCEyn+3hfVaQUP/gGsa5DZ
 om2XD7M+GariA1xJfyuX2YTLOHmMRSvGqcXf8iWWQA==
X-Google-Smtp-Source: AGHT+IEMtvrDl8nzWSQd1aA10zsuGRo+pR/MaxhT6jGFtP3uDLfeJTFjxx+IUrQ7EQP8B2LktmgyuoR/6y+TqTdNNGQ=
X-Received: by 2002:a05:6e02:3889:b0:35f:7df4:cee2 with SMTP id
 cn9-20020a056e02388900b0035f7df4cee2mr4679235ilb.17.1702752514176; Sat, 16
 Dec 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
 <20231215133245.7923-10-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231215133245.7923-10-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:13 -0700
Message-ID: <CAPnjgZ1MprDHu5Ae5NzUbYLABA2tLSq3Aj_MsnTSqx2e8aa9dg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] arm: enable support for QEMU firmware tables
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
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

On Fri, 15 Dec 2023 at 06:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Enable the QEMU firmware interface if ACPI tables are to be supported on
> the QEMU platform.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  board/emulation/qemu-arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
