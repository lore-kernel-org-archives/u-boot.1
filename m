Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10C9CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 09:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E0CA83A5A;
	Wed,  5 Nov 2025 10:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="byu3nps8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3395B83A5A; Wed,  5 Nov 2025 10:56:26 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 226A983A5A
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 10:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7866aca9e25so33592827b3.3
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 01:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762336583; x=1762941383; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=guf9mrPoki+Me2v3MxtYTDjKFiH9Xsm7aE4viEITFTU=;
 b=byu3nps8Fx/BGia/mG7IQVMaiEzoYvxB+bVCrV5nqf2Rau7C6S+s6ywle45m7Dx1TT
 kEf7MbfMquDwwytgjidtrd5VQ9ucpC5XabkTSG16ir6W4AI2AH/LklI7JvNar620cYTy
 1Mgy8fdw2rgN0kc0jXHdw9pp00/KyTtIyHvTiItWNmYp7LE4OaBHSoseoXFU0F3PXyrd
 +lVafIlcQu6/07ixUl7eRzvo6UpSQNCMiAva/6cLGwvR02z8M1z6cmj1xV+e5DrH8HyJ
 i2C2nnV7xiXbAFApSWC3X4NJL0KJDeRgDgU05zh7PDodkGsbkkun31eXkIEw2qRorJI/
 1hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762336583; x=1762941383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=guf9mrPoki+Me2v3MxtYTDjKFiH9Xsm7aE4viEITFTU=;
 b=NJ4lrFbsOvFE5vVbREf7WAAd+LWOp69VsUD2ZVPgW7G1VoXk/fOcNR34oB7ILZJ7sp
 S1OMlD0p5BUmFI99xdD5Ms8b5MVS5xFkN8MYXNpvW1EHM/aXOsVa5tzKMucBC2xXTUS/
 VKuAciA97KlhQ5xfdLXhGIcscYlTMc307Aez+yhfoP9nllf9rjLDBqzXmQw8t7FibZi/
 aLjtBJphNlBfi0qCwdqSAT9u9tjHN87zS0oQJEyTnHiFA4JHKbtPNMyNMR7q/SSsbNXC
 wTYSzqbLSYnzf6sstNvqAUsuzSruY1sL1PS4eXM8CeFQhqRC9yT8OHTGil8UJrv1DlVw
 62tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW42iuAMtV6WsSlq1kgKJugY3pxACjYSlYe3lPNx+CskiRYiV/P8OVCOMnfGmhXFM4/kUUM1eY=@lists.denx.de
X-Gm-Message-State: AOJu0YxGR4yMHQYbaxB/vlBf8T+KYO9+9d3SAZc78lkMsx+/QH9nUaUB
 iYInNmhA9D6gsR8nfOhQDGUx55kNSp7VpBql92L+FtipIVLRIWs10lvlxjJX8FX0G34gbu32szn
 Gvv3PCtIr1bMV7UK8a6nAJev3ZN/m1YVhOA==
X-Gm-Gg: ASbGnctCDZezGT1yLT8RfCcOhcyZDf+MEC3GMx86/MiY37lSSszEGoVHCz0hVjMwmZp
 njqdD3tcMbrjw5awz3zsnpB5bgDTa3Ea5sfaBtV1RvSHaVooQPk1HmDhFZd3eRBPeFjbJlGRvPR
 UKW9JE2BDMdB7TVTz+mBOzB0OPsfP6fzXUCD3dNllMOEZ8XmfCu9svEf6G7wy6VbSQlD7L8p6nM
 7HlmRz4fGCu5djlPd0grCpS3zBDDJKlK9zhaB/D8DeGxI/P+QHP60tzjRqCKMw=
X-Google-Smtp-Source: AGHT+IHTsl9nKpwOlPEW6fyho7kwjm4sFArWY9z5PS+WI7Rx+kHyg8bYVTeMDWjcad42B/6Xyt2VrpEeGpLZYLUMD00=
X-Received: by 2002:a05:690e:2582:b0:63f:b6a4:bd24 with SMTP id
 956f58d0204a3-63fd3576031mr1578520d50.48.1762336582905; Wed, 05 Nov 2025
 01:56:22 -0800 (PST)
MIME-Version: 1.0
References: <20251105013045.11283-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251105013045.11283-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 17:56:10 +0800
X-Gm-Features: AWmQ_blGwqSZF2Em5VH6W7ZpfIUSm_RSFCkQkuxINCzViPyvKBDf5tXrUpxAUZI
Message-ID: <CAEUhbmU+dLnMBy6XCf+0w-yNxTDTfyvMoy-U+ksGuSEQMLH7MA@mail.gmail.com>
Subject: Re: [PATCH v2] efi_driver: typo 'to be write'
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, Nov 5, 2025 at 9:30=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/to be write/to write/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         use 'to write' to match blkcnt description
> ---
>  lib/efi_driver/efi_block_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
