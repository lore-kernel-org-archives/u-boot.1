Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FD7EE57CD
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 22:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A08C86AD8;
	Sun, 10 Sep 2023 00:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lFwv1/Q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE25F86ADC; Sun, 10 Sep 2023 00:40:39 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44CA786ADA
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 00:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso2929469f8f.0
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694299235; x=1694904035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QTEzYfHEmHkyW8q/UO26TfQaJ15fYvmkwKuMm3Scf8Q=;
 b=lFwv1/Q6EefMwyMsrXrvyubgCiwDuj+ea8ZHRkCb3Ttzgp3tCNnxvLkQvJ1iKSxzvV
 fr8fcO9rv9Uqy8OiOBjm+LjSsNEG/ad1eCuYaB4BYp818b55Wltzw+A1OA5gIeEM9aK9
 6npvlA5vTdOaK5gAJwLU1GBwEdRNl7sWibIIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694299235; x=1694904035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QTEzYfHEmHkyW8q/UO26TfQaJ15fYvmkwKuMm3Scf8Q=;
 b=pkyWCjjQ9MF5WUyUZUPqq1FzGr4X36FCPbxEo8GRutr/R8crrXd91f79d4w8ze/apk
 v3F/XBgsYOGE/1iXG3QeArTZIjV1iWe50vzxttj8IhKEbm0CZv3pqOfPHlvkwuoiViGg
 j5RrAcsx2ju1njq+FMyhxIiuQDzaksCQRR1rORQM5imBLy/g/iLTgpZ1Z6y7fWGoyEHT
 B9K2euNcnXSO6Tyk5OG4qapceI9r7JaTotLgCa+hGshD8MUffDvCN9ZvONJK23evkQVC
 ANR5z9nlzt1csFh+0/jVM2yXzPj+vjgUd4H5zf0874lbvYWcIxzPuS7uWxUKQxNWiqCA
 mLUw==
X-Gm-Message-State: AOJu0YyDfrquqv0QMWl9pMUSRW9AwyMzsJVStIagZRje7xWxH5ZPj4gn
 zMdJi/NXebs10Cc5j9OS39gZckppyuel5+2WK/LFLA==
X-Google-Smtp-Source: AGHT+IGSXppw+an8pr3syrUPuWPQZrIjWopiRpZPpRrPenmHmOygI+MrP38nZ9H+XSlOTNcrOTXVzvP1rcJpCltpuZQ=
X-Received: by 2002:a05:6000:18b:b0:313:e456:e64a with SMTP id
 p11-20020a056000018b00b00313e456e64amr4413667wrx.21.1694299235612; Sat, 09
 Sep 2023 15:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230909103228.17366-1-massimo.pegorer+oss@gmail.com>
In-Reply-To: <20230909103228.17366-1-massimo.pegorer+oss@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 9 Sep 2023 16:40:23 -0600
Message-ID: <CAPnjgZ2zTJzAJM=y3mtLqN0DLZyowUpKkWEDAxc-sxFftEqc1A@mail.gmail.com>
Subject: Re: [PATCH] expo: Fix documentation reference
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.denx.de
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

On Sat, 9 Sept 2023 at 04:32, Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> Fix typo: doc/develop/expo.rst instead of doc/developer/expo.rst
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>  boot/expo_build.c | 6 +++---
>  include/expo.h    | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
