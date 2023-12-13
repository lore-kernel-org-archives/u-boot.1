Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0ECC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4005887908;
	Wed, 13 Dec 2023 21:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X/0APFBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66DC7878ED; Wed, 13 Dec 2023 21:39:37 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B83878CA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cb21afa6c1so89502951fa.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499974; x=1703104774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zOO8RVe7DYKHbIG+P4vJOd+bNs82gPFR/GpcKSD6aDE=;
 b=X/0APFBveo8ZAMt1Ph84NApby3DvgLS1u/b/MiFzk2cNtEIO1ZkC4RbOl1kbxRz/74
 GLhCayEacl//ja1o/yvITEb4Mv4CAhywtxNFYrwCLi757Gk+2ZApXu2lIgXjNRJHQTst
 nRdT18jY9/lcg3LVRn0FO0sCHDd0doED+vMUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499974; x=1703104774;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zOO8RVe7DYKHbIG+P4vJOd+bNs82gPFR/GpcKSD6aDE=;
 b=UlypzZ1EP4z5zXxiLQVQCf4x5n4rkrgjDEYOtB4y4WKo9p6BtO6dOrsqb/8WubMhqj
 c8qHrxgSlaxS3MO65irWiNKt6957qc/uRD+lSGOJvaIstXWLmmrOh8++MMkURW8ljzo2
 4Ya5uM1Ms4gT+Plh2yAaYjFMVf+kJR5+WdcgR974lIKC1mWU+kg/176W22zcpIKDhHdS
 3DcOU/NRJfVQ7sovZ5Tw/fm+3VIbZdQi80UNIaSPVJvu7Svhi2s2MhJ7bM+wdOYo0Ya4
 s6I2l8COpiKEUaAHkg1SLQ7vRXHxEdV3VOT8pPKVMizbI/fI1ezHwFTxMcH1zUS1S1Vu
 O4Og==
X-Gm-Message-State: AOJu0YzH7qD7UI5BMdzNumtp7IlmJVU6i8r5hakQ/tgEu+mvHI9IYzUS
 Gs+TIU+qYVhwe318pXLK5yyAZhdOxiEj1n+B8EybPQ==
X-Google-Smtp-Source: AGHT+IEf7m6GNzObvNS788GUQi/+YGemzrL35SduoNDH6YKoIBRQq/eAOwoj+cla4iEZkKlKpmt37PxKqwfPIMGc2yE=
X-Received: by 2002:a05:6512:b9f:b0:50c:19:5909 with SMTP id
 b31-20020a0565120b9f00b0050c00195909mr5682274lfv.18.1702499974250; Wed, 13
 Dec 2023 12:39:34 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:32 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-13-sjg@chromium.org>
References: <20231002011553.463514-13-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:32 -0800
X-Google-Sender-Auth: BXGGQ6zarCeslXiyIrUMb6XcZUo
Message-ID: <CAPnjgZ1Gc31wjepP2dUCh_uASgHE4x6xhbyxWP+8tHzGfWf8WQ@mail.gmail.com>
Subject: Re: [PATCH 12/34] test: print: Skip test on x86
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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

These tests cannot work on x86 machines as memory at address zero is
not writable. Add a condition to skip these.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/print_ut.c | 8 ++++++++
 1 file changed, 8 insertions(+)

Applied to u-boot-dm/next, thanks!
