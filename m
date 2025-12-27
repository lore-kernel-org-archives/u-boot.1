Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6397FE8FDCC
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FFD883C08;
	Sat, 27 Dec 2025 15:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IdC0EFHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5BF683B82; Sat, 27 Dec 2025 15:52:56 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA9183C0C
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b73161849e1so1537159166b.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766847174; x=1767451974; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ze4qhsbtKGDrJacUSoOe2beM2bKhXT35GxZKJHyJgnU=;
 b=IdC0EFHhwrsAskytmcULtWcH++kMbwbeRhmFQiygYbMic9tQpBz36wA4e5lmA4K3eo
 IDN9sS0uEA9BhiEmk22VqN5aHBBLn4Vygw3jF47xExV0YWVt+2Y7SiYqq8ASNTPXJwuA
 iEfnCvBxL/O0DIKl+PJQG5jJtfNl1ELw7pFr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766847174; x=1767451974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ze4qhsbtKGDrJacUSoOe2beM2bKhXT35GxZKJHyJgnU=;
 b=rHrQzMPI/b05Be0K4pxQdtw/EOzbi/yim+Yod0IgPRClNN8CPeA9uO/RE+3YXvBe3c
 h0bC30daSRPOwGRMo9YvYwhOlYV0U06ST8mKcg1KWnQ3GtQX5VX/76gGJkyJgyrt0UX0
 dfYAS4uqJGYM4PuzUMlRh/5rV4Vyt98m6cvM8/ID/tnhjac5qARyWhPWw0cLjPSJ5/Im
 4NP7+CfjakAFcmh4hF5QzCAwnUkGYrywI1mBWvwz55oLNDFtHQ1JM/6swO0a8/fU0B1G
 /nMYxAjQ3EVbADCEh4LlfYaZaT0/3KflK1K7/g2yGNggHFyF+UaAO/OQEYYsKz5iuh+m
 zl+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVUJ8V9xZjfwzByFgHvUfgQR/fg6fxzRgQHwMhcecuhQRBxnRW8LrE7FXERM3l+MTXgit80VI=@lists.denx.de
X-Gm-Message-State: AOJu0YyWMMGCEzShtaptO0+mCAlhUktgp+AmHLDO2ae43swwfMT7rTdm
 6vHQhBrKjDR0RSIHQnoyPDLjvrHFLMLVqAF1uHO8Lrcn1dOKb8jF0k2D/m4kOUHu/j/QsXQjIld
 Ktw3tn293nykD0L1jHK0sUYlZKVMV0Tf8QWO28xt+
X-Gm-Gg: AY/fxX6bRn0hVJRkSHhULwKA9GtML798yExT0MgNk619/wj5SXQJqg3FdrVL/ZOYm9q
 ca9iiridbxfNhXO2+97JPmVOexeWNOQFyWAFZ4ydb5O9lUTS7CAekprs6UpjTjzMFdZYamS8PF7
 oyTjeEfL4bIc9uq6nA0yvjnBim/No3X7GSy3U5Z4LaD5h3x765OLR9Xi8U6V4LIK18cUKWz+Xpp
 dlMZT5AuWOyvFoSIYUUWWTeuFGz2JyRKMss+yYvL7omSxrzKAG/NciBKLk2jR15otgN2w==
X-Google-Smtp-Source: AGHT+IEFQ8eatp5u3hZd17+a247T7okvDabM4LNJMWnz4OlCMgojOX5NT8Vsg0Im1jjV7dbmOBwbTghVGsqcQOO54nY=
X-Received: by 2002:a17:906:fe41:b0:b73:5a2f:2f0e with SMTP id
 a640c23a62f3a-b8036ebf4ebmr2593211266b.3.1766847174221; Sat, 27 Dec 2025
 06:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
 <20251217-a-few-test-py-improvements-v2-3-e1f91e3bf551@baylibre.com>
In-Reply-To: <20251217-a-few-test-py-improvements-v2-3-e1f91e3bf551@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 07:52:34 -0700
X-Gm-Features: AQt7F2rC6tCUA1k4iazCNCgjGCCJzv_yFm_YzG7PD4tNjC-myiov5cBMYP2rPlQ
Message-ID: <CAFLszTgzSGhaFOh7NevH8X3A3858pSi=3KGFBDnYiTU3+zyqfQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pylibfdt: add requirements.txt for setuptools
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
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

On Wed, 17 Dec 2025 at 11:43, David Lechner <dlechner@baylibre.com> wrote:
>
> Add a requirements.txt file to the pylibfdt script directory to specify
> setuptools as a dependency. This follows the pattern of each tool in
> U-Boot having its own requirements.txt file. The version is set to
> 78.1.1 to avoid conflict with the same in tools/patman/requirements.txt.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v2 changes:
> - new patch
> ---
>  scripts/dtc/pylibfdt/requirements.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>



>
> diff --git a/scripts/dtc/pylibfdt/requirements.txt b/scripts/dtc/pylibfdt/requirements.txt
> new file mode 100644
> index 00000000000..b7dbecdd587
> --- /dev/null
> +++ b/scripts/dtc/pylibfdt/requirements.txt
> @@ -0,0 +1 @@
> +setuptools==78.1.1
>
> --
> 2.43.0
>
