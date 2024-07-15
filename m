Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08146C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F8AC88890;
	Mon, 15 Jul 2024 15:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oPweDp8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE2F8888D2; Mon, 15 Jul 2024 15:31:34 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BAD88886
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b6176e59e7so26898536d6.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050291; x=1721655091; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OanzBtP2sVEqZuMOCVkQQZ+pTvPo3PscJR6NADXaYQ8=;
 b=oPweDp8RZt7pAP13hRbWyAGWv+y2v20bSwbe/dAsQSMd51rOhiJyAs5dwGEIDUMQbX
 1dxtMyJzUJKvgR8PwxVkIHdqLDaqZB3q33yQpNv5dHp6tKiZtVKhjW1E+Qg9dX9Asg9e
 Vy1x4LYZebVcZBfsC/VxV9xr2ryIp00N74Nh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050291; x=1721655091;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OanzBtP2sVEqZuMOCVkQQZ+pTvPo3PscJR6NADXaYQ8=;
 b=nRd7aw6r2R3jYJ14qTAln+mEA7TRivC19pN74DXUvp/IjOj7nRaXCIpcLUFKL3eZXd
 qtJl/XfAGIotU0k+h0yPCKhQG9ZCw5BK0WiirqczBz4zqphJE+QiNbSVavsH5pE2aSbu
 3cHOYvu1t4xH+rB+1xZ+07Z4gUDbCZlCJrrHOTPLGuwvsqmFIA3wDlGMkUtUKFL7pGEC
 v7CCXsvkziYJJqQQgocdjLE4v1nAZTm/0S3PUD78w6Hd8UUo6mMEHuVD+3y4yj7hKE6/
 Ibmq0oYBAY9ooZSOt+nkLHZWqyGg9jHnxrlK3JTrhpz5hbVfndDcf6byi1PYwE5GrZ49
 cV6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx57leYRUvsNJlvkqocTnZgqj8s14G5I2Np55KXWTYu1BUIXKuwMxw0mdh1e33fQCBN/aA2ynHxK3ha1Kp/cdXoa0QMQ==
X-Gm-Message-State: AOJu0YzEO04gqteeCf3IGEOvUfn9jxMyxtx+j30jQnJIKFkGil5E86OA
 ciH+Jv3elwKwqudaUKdIFxSyW4Gqv2feeGhf4QVZV+aSGOVnY/TK3H1Ts9GfMZJCcYc3eZA6VMg
 bgfY+7bEq6bpFJRlDFAR4z+2efl9nFU1xAyGB
X-Google-Smtp-Source: AGHT+IEjOrpHKM/wD4rCs8XBBz2pvaWRpB8snsPG5HyCR39A4xu8/JCajmf8lt/xSKh+aC/YkIPG5Nv2B87j3DrUD/E=
X-Received: by 2002:a05:6214:1254:b0:6b0:729c:5efc with SMTP id
 6a1803df08f44-6b61c1e5bf7mr240339756d6.56.1721050291617; Mon, 15 Jul 2024
 06:31:31 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:30 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-11-sjg@chromium.org>
References: <20240623175515.1466908-11-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:30 -0700
X-Google-Sender-Auth: QhVofTg3dzJGYDBGh63FKKO_o4s
Message-ID: <CAFLszTjvGzTkiomuLzASX+EvPMiicdjYse_yAw=Hn8NJtz2whQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] buildman: Make mrproper an argument to
 run_commit()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Pass this in so the caller can change it independently of the member
variable.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/buildman/builderthread.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Applied to u-boot-dm, thanks!
