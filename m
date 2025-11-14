Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76C9CE7B01
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60926840ED;
	Fri, 14 Nov 2025 13:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GVa+yoD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8D2E840F1; Fri, 14 Nov 2025 13:46:00 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8603B840E0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2957850c63bso20139915ad.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 04:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763124357; x=1763729157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7/cgqc7aIn8CWpzRF693pUqnXd4MuUbDb3RZmSR7fXQ=;
 b=GVa+yoD0tUi96FMsnV5os3VN6dX+evZo9XvWn+brtnmch2++7QyEd6GcypM1WuKVv2
 FMQrTzDHKuy+4lwXgOVC3YqM+UZW22en48UXCzB+X1gvpJ2u91B5NXEGm8sZ7LBGDH4t
 TAcseX5s+BZnzZttCNtWT1a8dbizUz6LISvJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763124357; x=1763729157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/cgqc7aIn8CWpzRF693pUqnXd4MuUbDb3RZmSR7fXQ=;
 b=TKX8GLgpw4UNQpOWj3PWxabujYcsXcu91+JcvndPIPmftjflnxwZ5TzWuUG6uw2aGh
 pWos8SowClE7J7E1/pwIYbfr4f0aTmHkV54ubXuKSkNW3mg2ALfYtqHdDgyqY8g+G8dy
 3879yrz7yElMpW9hz/jCj/rmi/BXbCSFSo9YWGK33kkjIfJtFavGzffdXiVkExz1GVTn
 VLh7s93mJwZ5bIzhpLZdO1+569ZLDQ+fI+YLFIf/O+uHpTqFjJWVyqS6Yg8WLt+01WcJ
 PRU6lErRMUnhFSUazTwd/ooNxYr3WwSt6tf+0asTeUKdl0ZlwhcqhCyIUGVdGP+w/3I3
 okxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL+3yFnLDVyCRdlZz592jOR345sdWr4pFAmrSUJMim4ZcG+4RkhkUHZC3PkyPKj6YlIEuNjbU=@lists.denx.de
X-Gm-Message-State: AOJu0YwoGdOmgrjiky9NHb4Is9wEvL7tWFf8rbWHxDka/ZyojE7WaDCL
 dahnauWXIdkSWtngJXGPfWgk/8kiiUbIL2upTN8oh+HodpxhnRRpbkRjP43x6OTH+2spFHBFYv6
 nUxh5Br4dFR+vxO9Sbtmzlzq49kt7eR29n+tyd8bo
X-Gm-Gg: ASbGncuJLKnx7SVFtJb+vgqlpbMsSQnRvlhR2fWcb93Xn1JY0GgjUnOEHkFxDzX9fg8
 0x6MYdMmpcH1HWPvd5EaFrbhTfgv5A2i/608t0pKnSrvZyauWunVDN8TFuFMwzQsmMxvr8lz4Wh
 E1fFTfonEHCWurTSAVU2CwLeaB59BOGdHhlWd1GhXW394vQlCTqi2ESexJ599QAipa0DSQh8COm
 Hs65hMsGOOSYb4niFa6nbua+bvIO94bzFWjX8j4l5Z3ej0fELsHZ+i6R2J7mNprhieUizOtL/s1
 3jll
X-Google-Smtp-Source: AGHT+IEmztzGGddEFXGCnq6kO4JIXWt8dBv2Da+Bfvj0xwhj73rdo3TxTc4QrdmEa/xGMmeyX9aSSFNc74r3fnOXs1U=
X-Received: by 2002:a17:903:1112:b0:295:7423:530a with SMTP id
 d9443c01a7336-2986801b5a3mr37206505ad.29.1763124356908; Fri, 14 Nov 2025
 04:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-6-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 05:44:59 -0700
X-Gm-Features: AWmQ_bmWOZxD81YU-A_1luBipK6wIkmZcIAWLzYYNUDSmRShNhsqZa4K0ZbLS_k
Message-ID: <CAFLszTi-Mv7LBvbT9K-QLRykNdgQD=iO4VvMVxrrd4xRmV=L7A@mail.gmail.com>
Subject: Re: [PATCH 5/9] test: common/print: do not use fixed buffer addresses
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The location of memory depends on the board. Do not assume memory at fixed
> memory locations. Use calloc() instead to allocate buffers.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/common/print.c | 76 ++++++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 36 deletions(-)
>

I have the same question, as to the value of this test when it is
already covered by sandbox.

Regards,
Simon
