Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F78C369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6A3830B4;
	Thu, 17 Apr 2025 23:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JZotzBex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A988319C; Thu, 17 Apr 2025 23:37:54 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A73982CF1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso4395667a12.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744925872; x=1745530672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eIfL8nAt6lX/7AFOAJn0NkPitzo5ny5G2/iKgrvV4Bg=;
 b=JZotzBexzJZ0ZBzUuRXbvkMvhBmit/HqDt3NwahtZHrfQxsW0ovikTNqC0l4NhQBhU
 cL9KN3tvOWruiCBMm++P4u7f1vnxR6zh8mMnuIHBC9DceQsIBcOodjrfJI2vJKB8KH0T
 vzt8DxLqe8TEt4Wu5Qgu8paPm479EyzEhtKmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744925872; x=1745530672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eIfL8nAt6lX/7AFOAJn0NkPitzo5ny5G2/iKgrvV4Bg=;
 b=cKhe1L7PpIC2I+96BVo3eCsqF2vc6evx+tCMwY1J4I4CfjmcpXDGmWfjIBvCiQJ3G0
 xA8sLz9OjC17i7ooyNrRdxLhODvT8dVKHnmy41Qoro3Z1E345ZCHUXSJWCuF5iobvB33
 AvWnIVHelE2z0zycZa8iEb+viHTmv7z8w1iGaOrDVYdrAiSWJjIlSPcq2xjcDYjCS0oz
 YwryYANffN4mVUGlk1jJj49JFupkN5oZ/pSRlycPlyu5ixY40vdIlq4SlNVIYC0NxA8R
 ZXFwvMrSGInZkXOMfwbfP3svlCO6Poh+5hO2ywFzIYzCePMWEV19yFYwOEa3nztkGptQ
 HYzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvkfQOpADE3/mFgwbLuCkF1TPok66XLkd/k7L91byZsFchZY9BT87Dfc5rBIZWdmBxzdNUr7E=@lists.denx.de
X-Gm-Message-State: AOJu0Yxai5nhVsCKYmDZUMVv/uWc9NswnY5fK1QTxIbgQDvUxBSHefnR
 MdpEBFvVKgtaUs2vbzrmt7aC66FULIEtUwBoSX963OnhPF+F4jdCgqsjSH0S14xzzTWyS4Zmy5H
 V/r1KI7z2Sb58TxbXmNXq2T3w2IK/UMgWkh60
X-Gm-Gg: ASbGncs4Nm5ZCwFcqmk33JFU5l/C663X91bDbVfJTy9FsSWwNTwr5rWjDNLlAFingZv
 uNA6jSdvk0avqogsCvCbdjeldJxwNEfYfIHmAednZ7y2kdf3R9AjNYgqqb4LUKPlmjbK/htu7kl
 95qGbY1qYTtW9+MGFU+E48LRw=
X-Google-Smtp-Source: AGHT+IE95/Eg1o/vuotcYvso5RTYMpp1Tj87uAGXn2sLR90hqBmm/BRv5iNDsWL1JuB2AI4Eln3ZPg68zPh1sMOFo/Q=
X-Received: by 2002:a17:907:980a:b0:acb:3719:3011 with SMTP id
 a640c23a62f3a-acb75121618mr20571466b.9.1744925871960; Thu, 17 Apr 2025
 14:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250414-binman-pubkey-dir-v1-0-0784d54ac621@cherry.de>
 <20250414-binman-pubkey-dir-v1-1-0784d54ac621@cherry.de>
In-Reply-To: <20250414-binman-pubkey-dir-v1-1-0784d54ac621@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:37:36 -0600
X-Gm-Features: ATxdqUG_nOOikXWRksOU1swTz_Qqu4nX8y2uAKdx_Nq5uMfmyBxU6xoTdfz3Nvo
Message-ID: <CAFLszTg7AL=Y33xuYpdofkFhbWq4asD5ScMYNp-pJNU70BXarA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: binman: etype: fit: raise ValueError if
 key-name-hint is a path
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 14 Apr 2025 at 04:51, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> mkimage doesn't fail if it cannot find the public key but it prints to
> stderr. Considering that btool.run() discards stderr, it means binman
> happily returns an unsigned FIT and doesn't tell you something went
> wrong.
>
> Binman will actually find the file if there's a path in the
> key-name-hint property but the current logic expects key-name-hint to be
> a filename and thus returns the dirname of the found path for the key,
> but with the original key-name-hint appended. This means we can have the
> following:
>
> - key-name-hint = "keys/dev"
> - name = "/home/qschulz/work/upstream/u-boot/keys/"
>
> so we pass /home/qschulz/work/upstream/u-boot/keys/ to the -k option of
> mkimage but the FIT still contains "keys/dev" in key-name-hint which
> means mkimage will try to find the key at
> /home/qschulz/work/upstream/u-boot/keys/keys/, which doesn't exist.
>
> Let's assume paths are simply not supported (it is named key-name-hint
> and not key-path-hint after all) and raise an error if the property
> contains a path so that the build fails and not quietly.
>
> Fixes: 133c000ca334 ("binman: implement signing FIT images during image build")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/binman/etype/fit.py | 3 +++
>  1 file changed, 3 insertions(+)

I might be missing it, but this needs a test or you will break code coverage.

Regards,
Simon
