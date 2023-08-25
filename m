Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCBAC6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3DB86B53;
	Fri, 25 Aug 2023 20:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rJLEgbTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 577CA86B32; Fri, 25 Aug 2023 20:06:21 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C81EF86B33
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so1695336a12.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692986778; x=1693591578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QQdhzq7ULnsXsxzWVGPTlOKy+QtI40YBOQEDyru8gWE=;
 b=rJLEgbTVvz0F5zngpcolpK8Zb/aRYu2fwRtsXpaCJ+5SmOSyG0gNkrMxZ3yRfO7Zr5
 HmNVPaHg3ohdbuQxP0hpnmtrAfxIE75LSm+WvuFnIggUZRU9+92Xodqe7ei23eJ+YxIj
 hhg97dgktXWx/z3LPJR+05sqPFW5lSRFnu392a1udOb0g4DG9GGEiNA9aYXXvHj4AaDs
 d8xpUWC8mRrMWU+Cel4i+pj88BXjdRcntuubTZCh3oAEJ5a0dAE6imPbdriDPWWx1e/I
 iT7MXGzVuRRpBNKJu+4VhXzSpiG0NBiKOnCzxpKL4JYuYyFoCic8Tty0ySy6qTpbFMIK
 IIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692986778; x=1693591578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QQdhzq7ULnsXsxzWVGPTlOKy+QtI40YBOQEDyru8gWE=;
 b=ABjBeSoXq8WfoJjnXpBbMLYnmZWJhRruQBsqNUsD3OaPoOeRjZr97H7TP8WMhbTjhw
 t5pPNUx2v0s3zhZh7MobuYk8EMog/9ZbOAo3bPPfBkgDInjNBpGCKTn6T4BX+mOIoU7f
 D/ZK32uiO2cysjNMapKnSCrczR60j97C2VjPzCWDCz2Otn4LWm5KsjK/Z7IwO6r1Swxs
 +9tedUHRhEb93cjoYorw9xhZQn32pmmBP7jTxk8mIV/dsjAEQ+tx6+jFR7xgGC8T/Lix
 zCtj7K3DNhgtYzkQd8OTy7vAtyrNiYQWnkk/ZtyoC4RM0yqGqUxqfBusPLhHCjZh1MGa
 XL6g==
X-Gm-Message-State: AOJu0YziM/4St8sB9voaNeHVA3coy0eNY3OXnNdpWlroYFlJ00VVSxKT
 LUmbPhHGnO8OBrVItaFOM2l3nN9XTx68uzb9vCJ70w==
X-Google-Smtp-Source: AGHT+IGViMkUqklcKerA2P9YiCAysgLgVxjG2Kx27J/m1C9hIEkf8/HPnTLZ58m0vm1nly5NviFAGeO2gT+PuMwqSSE=
X-Received: by 2002:aa7:d058:0:b0:523:d1ab:b2ed with SMTP id
 n24-20020aa7d058000000b00523d1abb2edmr15520380edo.29.1692986778056; Fri, 25
 Aug 2023 11:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230825172127.3406461-1-trini@konsulko.com>
In-Reply-To: <20230825172127.3406461-1-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Fri, 25 Aug 2023 12:06:06 -0600
Message-ID: <CAPnjgZ3XvRXx9+vgR81JNse0A4pZ8KmcnU7piuPU7e5QHoyftQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] CI: Update to gcc-13.2.0
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

On Fri, 25 Aug 2023 at 11:21, Tom Rini <trini@konsulko.com> wrote:
>
> The latest kernel.org toolchains for gcc are now 13.2.0, so upgrade to
> that.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml        |  2 +-
>  .gitlab-ci.yml              |  2 +-
>  tools/buildman/toolchain.py |  2 +-
>  tools/docker/Dockerfile     | 58 ++++++++++++++++++-------------------
>  4 files changed, 32 insertions(+), 32 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
