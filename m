Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABBDC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D8D787916;
	Wed, 13 Dec 2023 21:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eS+DFSVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47EBB878DB; Wed, 13 Dec 2023 21:39:40 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490C4878EA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1ceae92ab6so983991366b.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499977; x=1703104777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2KTLgNA14/5Ps0w2YaOh5xDgmex/o/kwDmV8k3GsCfg=;
 b=eS+DFSVfWbhYG1vUOjLtMqmLyOsxnLNG1ocjzUKnwdEX0mHirz2cFQHq0KKd5NVHpG
 jZ1UCy/IgqQvFNutUMR1qFk8lplpmPYXcJarRAqJBkC2DuXSesGpoGw31rPjD/VpCITF
 v/BScoWbnRUFsoWUHI9Hll8E45oQ3ymkIwvHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499977; x=1703104777;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2KTLgNA14/5Ps0w2YaOh5xDgmex/o/kwDmV8k3GsCfg=;
 b=T4ljq0Ai/0x8VN0HvbHmS3SZAr1y8+2nOAAoXSfJQ/7b0P51x+6XCZKQwdJplo3a9R
 WF1n39yvG8cUgDTYJFo8Ldpnb6H2WaCn7thHxQFNwKtWX8B9kkdZBzCdVDU1+jxqU4lj
 h6s70fBeeOv8ab+Qtds8R/O0eG0C26Iwz62JhXy39SEWeJwzlbJP6auBFJQHl/bMlC8p
 Lo2e5kJeCSn5Bckf7KDAcrDfbkEmPWtHgcts3Bhmm4yoHGT82x/Z/Yjly3B7bdDVRNGG
 +s0RBmEVu4o0Rr0MJsC5FMrNaOXRFgPVLFWIlTInp7AlazVpVJqBye8ty2CA37dP2fId
 PIgQ==
X-Gm-Message-State: AOJu0YyrPwY3KvX4gQ2SHfcJSUZQGNUayO5E5KfHDRr47zkYXyo3k/Cf
 gHBATRVetmBX0FSxXpzEfy1B571ePgCB4q+UTqSIkQ==
X-Google-Smtp-Source: AGHT+IE1CENT2n9d9G7DGZSxW9vBSrFhwMaSoUJZbHNp3utwLGQbjy0Wtd7YTr2sgV6r9DrskH3dreLO3mo4c0oGX2c=
X-Received: by 2002:a17:907:6d0c:b0:9fc:93e1:c6bc with SMTP id
 sa12-20020a1709076d0c00b009fc93e1c6bcmr5984909ejc.33.1702499976552; Wed, 13
 Dec 2023 12:39:36 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:35 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-10-sjg@chromium.org>
References: <20231002011553.463514-10-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:35 -0800
X-Google-Sender-Auth: Ps6fO7EwV9zK5QnSZPIOS3bX_eI
Message-ID: <CAPnjgZ110thwNtmgBiYnsh4CaiDfCBdr7teXQ78mhmDgggPc7A@mail.gmail.com>
Subject: Re: [PATCH 09/34] test: font: Add dependencies on fonts
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

The font test needs two fonts. If one is not available, skip out early,
to avoid an error.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/font.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
