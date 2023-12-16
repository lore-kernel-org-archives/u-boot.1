Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC128C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4FA87C75;
	Sat, 16 Dec 2023 19:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gZ48NwKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C6A87C97; Sat, 16 Dec 2023 19:48:40 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A1687C6A
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6da45aa5549so1391724a34.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qVkteyzRBFuDFYJgtBPvJnAfS3iqgT+Rf2zbQtb7qgw=;
 b=gZ48NwKZDgn7HWza6vq/zfm+LDZiYVtkGiZmzUZF71axC5row7n8wueCtyX9OFHuq9
 qVAWWmyZTWGP/tm1KSnGfVT9yKMu0FDQ+Jjil+Pi4CMS93bh8JfW8x23cDv7oJC7jIOl
 WEcIG56F6tQ7JNjcWc2W0oGjewyOv12EFfkIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVkteyzRBFuDFYJgtBPvJnAfS3iqgT+Rf2zbQtb7qgw=;
 b=H/mr18qq+xMzJIhFw9rszVahgm1CB9SjYr5fGWIMzSeV6IpMCrtEQ9tP2OilCuw9EF
 yHWgxNOPVjB4L1P0QAg7GNDJm+C6xpsiotOSR2b4IG51qZU/5PL7tdMfGGYrChfGiaZ7
 mq5UZn37Hy3GCQAPtQ0YCVMIlr/UoawsjEMv7Bv2XO8J41cyYx8a4/yl56oa7xjqQKZj
 pmRtzTugnpAS9Kglw9NG/leR0aN3YaRGtuG/51ROvr0Q2GBL5myAFa/+dc2BcTYZ9CiZ
 YxaHjOawhJ1h15LXlTryBC7s/yHP6hZgq2+8FYmCzy3Ye3JFkCvnqLlnpGvvtWwWg5WV
 SsEA==
X-Gm-Message-State: AOJu0YxN1PPfBM4D2zsIoyw4XBEVE4Y7Msw27HNy36Vwj1n82kIAC3Rq
 9qLT7jFLGEk+jEZ01C4SrcDXT3mkVf92eyMN6fyquIKxKSgBrd+Ha64=
X-Google-Smtp-Source: AGHT+IGtygmag0qt7iPoDYxAbfmpK7F0j+OodcnRSSokjxMmANvqnZDyYBZ5m5IPh4gE7JunchNAEhY8FzZkhXHBL5M=
X-Received: by 2002:a05:6830:1185:b0:6da:5218:46e8 with SMTP id
 u5-20020a056830118500b006da521846e8mr3221317otq.58.1702752514154; Sat, 16 Dec
 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231216180804.173374-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231216180804.173374-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:00 -0700
Message-ID: <CAPnjgZ0=wMzY8oaVUGzszGZahvdJH1Z1XnX2JOtjVfyPFKWvZg@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer.pl: Add --git to look up CCed in git
 history
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Sat, 16 Dec 2023 at 11:08, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Add the --git parameter, else recent contributors are left out of the CC list.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  .get_maintainer.conf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Simon Glass <sjg@chromium.org>
