Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19229C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CF8877C2;
	Sat,  2 Dec 2023 19:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EhoBWRZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D83F877B5; Sat,  2 Dec 2023 19:32:18 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39FD7877B9
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c9f8faf57bso2249141fa.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541934; x=1702146734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FTkai7hx9Oj7uzjfmeU7QJjYWM2yEvlkC4rLdGK5/IU=;
 b=EhoBWRZ6ZAQ+zWb64RyQHyu/BwOgAb9NQbHLvuUyDKPV4BJsQ1GvePbEHkUecNtxWv
 FKb71i1IDn+LG5OvK7NiXryWc68sZ0OnAvlj6ec7HUkK6zXxafGfqO4hcjTwrN+g6W9F
 HwIC65pCVCZ5DuqhXLTuPeAM6tP8iH72EaaP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541934; x=1702146734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FTkai7hx9Oj7uzjfmeU7QJjYWM2yEvlkC4rLdGK5/IU=;
 b=M2NmOINx1tBKLP6YEqW8rpMhnVmHaBr5kJlAS8PaSRkCWNCm0VwpJf0vPlFCHd16al
 Ww0HYukWoH+ZfYKngw024d0bdcKgRqMFR2KuFzyfMiGSGHJNFlkTfH7kQfrSQ+UZz1nn
 hAozxjkftMx6Misjgtv1Nq7MoOJT6EYt5eKmck3gJBAKeLYLAFGRfobgGDGxSIEwPOql
 My0qiQkFsq3hgdq/QkNdX/yJWtKF0tca9AESNJpcgEGfEOniEfFYtqcS7gESX3PtJ1Vs
 XMsHNnwgaE9/qphiPVBQMDuzKS1bPmonB4Ujtp8V+sPPwXHa9w5V7r2ndvGWr/Wz/cuC
 QAxw==
X-Gm-Message-State: AOJu0YzpHcLLqmklM4VKeHY9fQmD6vYrQMAuKNsu9RQI1iH19ybIBXab
 wWiVa+qxruqUw2xrnkSdspzkfD4Jn6Na0t4n75ua4A==
X-Google-Smtp-Source: AGHT+IEY9WSBKX9Lbd80D0R/6b2SkGeId1RJFluP9/NzqtM9cUm3FoiEohjTuz1fMHb6ExUw+rsg581BAuaInNMZrFA=
X-Received: by 2002:a2e:9248:0:b0:2c9:ba12:63e with SMTP id
 v8-20020a2e9248000000b002c9ba12063emr1574558ljg.21.1701541934203; Sat, 02 Dec
 2023 10:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-12-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-12-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:36 -0700
Message-ID: <CAPnjgZ2pXLJrXEQ0-RmXR4XP4FQOZAt7qdsE+JpPMJKtVdJmKg@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] bloblist: Reduce blob-header size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
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

On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> The v0.9 spec provides for an 8-byte header for each blob, with fewer
> fields.
> The blob start address should be aligned to the alignment specified
> by the bloblist header.
> Update the implementation to match this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Update the blob start address to align to the alignment required by
>   the bloblist header.
> - Define the macros of bloblist header size and bloblist record header
>   size as the size of their structures.
>
>  common/bloblist.c  | 17 +++++++++--------
>  include/bloblist.h | 33 ++++++++++++++++++++++-----------
>  test/bloblist.c    | 16 ++++++++--------
>  3 files changed, 39 insertions(+), 27 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
