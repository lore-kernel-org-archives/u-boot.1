Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE58E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA93D802C2;
	Tue, 17 Dec 2024 20:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GljyX1sR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3680E801CE; Tue, 17 Dec 2024 20:47:10 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407CB80107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so880285166b.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464828; x=1735069628; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=goRi/cWtBWlBFENHz55TKjYgH/NOoCpaO6Je8LK7JuQ=;
 b=GljyX1sRoPVSEaDyo3SAdwuucsjrB7ezTSY4B5mMdJwTj1/2dfXqx2AL50qneFDUc+
 S4n6LE8Rv8sWtUodq6uLjroMIp64rCbbFGZs1KaF9BSsKK2dt1CB13aMyRX78mKnVR3a
 U1+LHQRsdlNvYN5sQIrxhjTGi//cnk/HiIR3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464828; x=1735069628;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=goRi/cWtBWlBFENHz55TKjYgH/NOoCpaO6Je8LK7JuQ=;
 b=qXxS01u/vH8uRnAMBGXkIvliqu4pQGQtXSnhzOWNAqiY6dWez+0+YjkXZNH0dFkL43
 tjLPLFb68wfs9lWSHplBzNoEMzSR+euK3AeF3mK9tBduzOVIlLYz/TEO3zG08eHmSM9S
 XiRGOm2GhnTaXvNG8y1XLFAHfCFFl5NyMMQgOEkKMl0+2B34NXykG3WhBwNnop5fwnvr
 V1IBD2fvW6B5c9OZkxYRot4tBZRUKXJsSWXUIc0AuYc76fXWlRrUfI7JYgUNKGLRWwib
 PhdCRAEeNhSkCvPjIqfW3aDw48VKoiU1oF7lIDRtGq2BV4MsVlO9E/C40KKKdCIA8NcR
 y2vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqpuGdp2Psd6csoi3wuGNuOIHOVidMZgtAF9R1DzZC0WbZGGSkuo2FifVA26Qc+8qgW6Qb32k=@lists.denx.de
X-Gm-Message-State: AOJu0Yysk1H3loKDOfRXW1T60X6ANWZI7z3Nd48brO8mIHh8aLD3L+s1
 7eiwc4SkeriipcZypO5dVAApaF9vRlzq/64uKo9VLPbEtMarEvyD9wqzNvNOcLZYzQ5jP55m+Pm
 qzuhELbo2yAmDkrJPI0cFodkxMygXa+OI9PmP
X-Gm-Gg: ASbGnctwdN1mAtNNRaEnRPChWtkTOcdbHbCwVD/O8uYfs2SNLoIXb048iPqi6Grlz0+
 F7uyztTP2mVexjB9FuICMdoJlV/0v2Dw9mEPQQXI=
X-Google-Smtp-Source: AGHT+IGVOSci1iK4Jlqt30nP9EiGAS7rNMdsokXKmbkwFXQb6jOfhZ1RprqoEZbvY2/YvuM3dhmP8SB+byNk0HFn4qM=
X-Received: by 2002:a17:907:7811:b0:aa6:8b4a:46a4 with SMTP id
 a640c23a62f3a-aabf1c85370mr50094466b.44.1734464827720; Tue, 17 Dec 2024
 11:47:07 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 13:47:06 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211135418.563803-23-sjg@chromium.org>
References: <20241211135418.563803-23-sjg@chromium.org>
 <20241211135418.563803-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 13:47:06 -0600
X-Google-Sender-Auth: 7KdD1A0whd8XpeGq6LacLvAmGNc
Message-ID: <CAFLszTg-OjHy8uSdq9HLC72pvOD6rA1RYReioj=sMi3Sg47dzQ@mail.gmail.com>
Subject: Re: [PATCH v5 22/23] efi_bootmgr: Avoid casts in
 try_load_from_uri_path()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Update this function to use map_sysmem() so that it can work correctly
on sandbox

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_bootmgr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Applied to sjg/master, thanks!
