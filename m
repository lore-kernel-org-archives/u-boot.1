Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C886D1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C120891C6;
	Mon, 14 Oct 2024 17:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FrPo7vDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 300E1891C1; Mon, 14 Oct 2024 17:51:11 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 248F7891AD
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cb97afcec9so39271676d6.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921067; x=1729525867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eZej2HKzS1ROUG2RMMd3Y5t+vvuFpjYb8KY9D7ujQOw=;
 b=FrPo7vDMTegR0FR2QmBcUMVykaOdMYmnv9ezFh8FvnWnkJ32CZ67i9XqZBfIP4J7U2
 0mmAH8B+Ul1hh9yTnuTIsau33j5QRHj2FMim3mU0VfgAmJvtIeS9ybyyFqq+7gQUNkKj
 kHceJ9LnjDv0fT1T1ZXE8+o4yQu0NCwJ6wNHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921067; x=1729525867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eZej2HKzS1ROUG2RMMd3Y5t+vvuFpjYb8KY9D7ujQOw=;
 b=p4XL/3p/AEuBdvh2Bd9uFKDYYF+pPmjsvKmg4kh6HFLyfOS3iST20PkKQHZOQfgFj3
 LH8AF4QLLqVD2BgepnbzKPdLfAOVcssX+MXAlY1lhAiU21cOj2LBj6Eo77pUrlsJ5tEf
 /D+sWJy9F6bJcZb98p6ghh6IcodeB5D50plyGH6BQ2Mhs05++kNdBJmM/eFOLx+qsIPv
 hcigC2rJON6YUXii4i7UlbibRfdug80hRnIqcEV9ooMLGNmPRoqTh22D0sA+pQiYy52F
 6a9tBE2F7t/9pWQ7d0lQepmSXY24xRuMcm+ww5SkjozPZnn/IPyxlOYCAX9xSibHo4Hn
 cAhA==
X-Gm-Message-State: AOJu0YzGPkRKhukNTJtCyvOI2Y+945JjaubdaL5qUsxx5i837X/FaOk0
 YGHPGNdkWzekqtoQn3AZlxBJeBsqgzywKRrAtD3+VIGA3JQe9s90rXuhl0jCauVTeAJNWo+RZbH
 93F1wgwOlJN5O8wocwxGESma5qR9kfG0O/3jA
X-Google-Smtp-Source: AGHT+IEVdtkbcgEXR9pFFdlbZctcUG2AkUW+QPcmb7fNXYJkhQBQFdCxb102j2ly3RLxZiVfL9UzezEXnfk94O6nz/M=
X-Received: by 2002:a05:6214:5b87:b0:6cb:d302:f0cf with SMTP id
 6a1803df08f44-6cbeff63b0fmr208281536d6.28.1728921067417; Mon, 14 Oct 2024
 08:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-15-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-15-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:56 -0600
Message-ID: <CAFLszTizzDx88Rs1rRXXgcFDf8z3Qe1U+BfOW4GM7owuRw2=MQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] lmb: remove call to efi_lmb_reserve()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The EFI memory allocations are now being done through the LMB
> module. With this change, there is no need to get the EFI memory map
> and set aside EFI allocated memory.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since V2: None
>
>  lib/lmb.c | 35 -----------------------------------
>  1 file changed, 35 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
