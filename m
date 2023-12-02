Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365F4C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 093D88779A;
	Sat,  2 Dec 2023 19:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gf2ZBjYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9602687754; Sat,  2 Dec 2023 19:31:55 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3056987778
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a18ebac19efso522288166b.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541908; x=1702146708; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mPMJovhBwM6BwIkaMlre7FfU6+jgj15Xaxm4/sUDnQk=;
 b=Gf2ZBjYhyMc86/DvCqdUYSm0uw+A1YnXNvTq3h8PtJ6Dnp1cTiCOlJXdXR5goxPxYx
 8Nn58B41SbSGw9JAnoulUJCcZVM57lFGHcmGg18J68a+LHVATwSjPF//GcZXgHfp1R3r
 hYcL1OAgjk6lf9V9plVL74ci5OpgM6Rd/izGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541908; x=1702146708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mPMJovhBwM6BwIkaMlre7FfU6+jgj15Xaxm4/sUDnQk=;
 b=kDACOGiwmasdyEF5p1WBvmQQS5Oe01q1Lb9JSj58VbPmeP0BYg+FQpJEgcz+Q4KEK5
 hmsK3zuAcLwg2Hs2fDtWPW2INJJ1inGNKl30ypnhHr5gAzd+Ak3YxUxCT7up61CN5ehB
 4E6K55yxmUN3wfUbzgq0XYTXR+GHU+qV6F9zYyV7wbnQ7hlAYdCFTucGv6oTwJMmA9UI
 3EUAFB08smS26qtZC83NDVEKv3x4dVbxP9r5xKjasqESj7Pxj+DaPG4lkZFCE1hgjp0b
 AfEH/cKVC/GNvKw8MLHyvSZUXQCeZhzq5LplX3k55cIM83SEDiWKCWB83pAngeN6FBKV
 ViCg==
X-Gm-Message-State: AOJu0YwTcRZKWJREYEBYcVo6KhrNU4Ok1umQPHLNK0tRv+aUXY9G6jwW
 OJpwjX3a/ewQNyaQD9AdspJ3X7xwEzYWH0zVWXtfcBe/kX4+aa/iN5h7fg==
X-Google-Smtp-Source: AGHT+IGor8MbLHeerRQRIBOcCYSSLh/KGf065DlhHuoKLXWKnUw+54vxpwTtUOOW1C4wJU4Gro768BcQ0Rjl2OrH9NI=
X-Received: by 2002:a17:907:3a82:b0:a19:a409:37ec with SMTP id
 fh2-20020a1709073a8200b00a19a40937ecmr2849588ejc.69.1701541908420; Sat, 02
 Dec 2023 10:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-8-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-8-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:30 -0700
Message-ID: <CAPnjgZ2F39nypMjJm-obtODBqN6u2F=0qTvGJrcCbxqsBzijpw@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] bloblist: Drop the spare values
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <seanga2@gmail.com>
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

On Mon, 27 Nov 2023 at 12:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> There are no spare values in spec v0.9 so drop them.
>
> For now they are still present in the headers, with an underscore, so that
> tests continue to pass.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c  | 1 -
>  include/bloblist.h | 6 ++----
>  test/bloblist.c    | 4 ----
>  3 files changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
