Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE6DECD6C1
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 16:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3777C8388D;
	Wed, 11 Feb 2026 17:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lBdiRZ7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C535683CB5; Wed, 11 Feb 2026 17:19:36 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651038367F
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 17:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d15b8feca3so2096067a34.3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 08:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770826773; x=1771431573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wrwd0OFJUnuvB++PlPuHmnzDgJxKS1awgj6OUZgkcY=;
 b=lBdiRZ7xaphZXZcMalJ3DGaXUrg8gjWbNR/mQCv6xO1RHJwCjqWkbZAc21MXLZ+jpn
 zpTli0yr3s4hCw6MPA+Htz7R/ASM8BiUkN5jpkU/qkpX9WrUmLKIkaGLlH5mnclk9TTc
 BGCXELq+mx7m3J85rCQVK0a5Y8BfJC4cbZ19Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770826773; x=1771431573;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5wrwd0OFJUnuvB++PlPuHmnzDgJxKS1awgj6OUZgkcY=;
 b=TTA2oRSidlzdsWou3gOaTlxv1UrNTy71ZFOj6GfkPM4HF5p/AMvVPQXts5IslMHReh
 TDuzTVkAaqDZe2MjSyg/Zb+jVGfgMdwFTzcDkJKN3STGAvbQF6CksO9L0TGBHrbRypF3
 BDP5zrubg4GOg95V4QI+m480MAsSKWoUtruxIpynYZpzVhLfhL8YeJ+OBy0kx7aeQz8F
 YaIUUtEOuS+GmhIx5qkzdIrS91QPyRdFa31oxHUOt53gW7HCLou+0P0QEudPUKPWbnsW
 2XMWun98ARQdj0ndG9D3kVYvJHHeEj5Fl5AUchKOKJHxPGnsH5AFvmk0dapp/E8cpAu7
 3isg==
X-Gm-Message-State: AOJu0YzPMdtKdDrdXB/JiNGbtx/KKZjfcxEqdYgBLuBqWPLOqWJIygf8
 3xA3eVpRi7UA4LAaOY4SCilWjwrXez1dWrH72dn/PuOWOWdEZI6Vp/tT8L+5UpQDuPJwqpVQOwG
 mZS+jtBc=
X-Gm-Gg: AZuq6aIc0nYY+aAvXrtRXrPcsR4pq3ne+WFu2nsjoA1JUulj8CKMtziJ+qNJ2YqWlyt
 2F3vl6AhPmztst8mBQrwcAfW6elPHz04CFaCFU0Hr8W1djYXHsuk1TV/qfZbvGH90OaQbYTKCNZ
 V4gT5gfbHjRe8vkcji4k6PJCv4zUdDyIamfqBfH0j8Ngkcy41XC3a/nd1fMP//C66TfbxZtoLRO
 LfuuIVzzLpjnyRKdGmBgPyWtM9j3AgiliOg61fKtn1CgxMdnhx8tLBkJluoOwaDuPbbvIP77OrR
 gFsiCPg6YiRyTtH4/oFCZ8vVDhryA/oNbdUMy2S6Ru77d5l7lcuxO6FnIc6HyJPqbHSUjiYPSDr
 YPQXLP8jlKpclKGYnNRl85XtZSE+N2MccfW0K9sVW8sJcbckr0/YXcWGA4YD91wTwkZuRIWKGhU
 pTx14abKhmGJMgHT4Wj1hNCxIHwWObCDg4uqH7TmcEGD5SghBpWGCt1NrXR9wLqf7lQLkqSvIZs
 gcY92J7dcXa5zpsuNcYCptRS2/4jbWJ99YMfNL/pcDkbgSsKQ==
X-Received: by 2002:a05:6830:4990:b0:7cf:d642:d36c with SMTP id
 46e09a7af769-7d4643d732dmr10328472a34.2.1770826773156; 
 Wed, 11 Feb 2026 08:19:33 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a754b4bbsm1514279a34.11.2026.02.11.08.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 08:19:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: hs@nabladev.com
In-Reply-To: <20260211100516.63099-1-ilias.apalodimas@linaro.org>
References: <20260211100516.63099-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for tpm-master-11022026
Message-Id: <177082677252.1650830.11715634688592874677.b4-ty@konsulko.com>
Date: Wed, 11 Feb 2026 10:19:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 11 Feb 2026 12:05:16 +0200, Ilias Apalodimas wrote:

> A small update from Heiko on SM3 support. We want this in -master
> 
> The following changes since commit 712765339a5c6576fdd5683748f97a1215868d5d:
> 
>   Merge patch series "Update DDR Configurations" (2026-02-10 12:57:02 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


