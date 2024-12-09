Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9109FE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C2089772;
	Mon,  9 Dec 2024 16:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kwWI+VKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D27F8977B; Mon,  9 Dec 2024 16:07:23 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A46089384
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434f74e59c7so12843835e9.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733756841; x=1734361641; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zxy/2Cvp+a27itXrH9lZYCzNB7NksP9WbjXRjWDNtEY=;
 b=kwWI+VKvRWLvbgJhIuHE5XIKZyN6oTJLMVdRd4Vo0wkocDPq4KHRjST3cDEyYjjQLa
 avS0GxBVaFcdwea7OWcCaALVEgXCXbsh8VfhKe3v0k7fn/QF9+KfyM4ipdLR6wSgWGfM
 J+jaUqQY5FLQEQXyP3aL6fDDhdv3zGSyfjwF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733756841; x=1734361641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zxy/2Cvp+a27itXrH9lZYCzNB7NksP9WbjXRjWDNtEY=;
 b=Y1hck0xL7PXeWsFoThX/El3qYmmWA7neMi5cith0Uzr+XFQyBXAv8CV83sqtUOT7o9
 hWpmJzco2jyh1ATgf56bWJMsNsvLtnID8z+N8+SAhVzxEujq7/7861IWg2fbPuzAZbBi
 VN7KBvvQAuvfjJ3aeomDCy2hO7ahuOxFtTmugbCsQjZe4C3mRIgNmW9R96VaYvTN0l3g
 /NfYOIzmcbTVmHTs6vcd9niiM2mIiq1fVI4YkER/tpvAsV0SqT6yRJxzwcy5S7d5bLyW
 qOYSKIiiivI3tgGOJr56Ul4HMKuV4XlOJq1cnGKwCUXPKWk667EM/zuactYnLGnO8ViP
 BUVg==
X-Gm-Message-State: AOJu0Yz6G/qUgkaN41r8vNdFET4D4umsdLBmKYG8j/HwL/cuZXzYBJss
 4tIlYsA2gLTUBt8gzWF9+3OjH7+JrakFo8mFthBxnNjh+NjwomqGNqlHcNq69raYKh6c1xQEo10
 3goMCim/wnyaPC8cwD85hvg0PgPR7+7qXnGgci1hJIqA0u/8=
X-Gm-Gg: ASbGncu05XmcgJ3/xmHgW9OsKqOKMrkDVAqNIePFjDq8Gtn6dPdosdgAssBQg9TnYOi
 J3g4nFLYDso2+v4HUBubMBGVbZ9rI2muQ
X-Google-Smtp-Source: AGHT+IFYNNaqVtM0YQEAZJoDgyUFXklTuZifVJDBkRhPOwDQr2eBVFfqOHW3Vsh+Pf0w2DUHZy06WWRT/8nMODzo+iU=
X-Received: by 2002:a05:6000:2ad:b0:386:256c:8e59 with SMTP id
 ffacd0b85a97d-386453cf83bmr827413f8f.3.1733756458453; Mon, 09 Dec 2024
 07:00:58 -0800 (PST)
MIME-Version: 1.0
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-10-trini@konsulko.com>
In-Reply-To: <20241208190741.4192601-10-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 08:00:41 -0700
Message-ID: <CAFLszThrSZbS_FqJ39CrBrtG1repE0bD-MnGOPhh31JPEfEuVw@mail.gmail.com>
Subject: Re: [PATCH 9/9] docker: Update to latest "Jammy" tag
To: Tom Rini <trini@konsulko.com>
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

On Sun, 8 Dec 2024 at 12:09, Tom Rini <trini@konsulko.com> wrote:
>
> Bring us up to the current Ubuntu "Jammy" tag.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml    | 2 +-
>  .gitlab-ci.yml          | 2 +-
>  tools/docker/Dockerfile | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
