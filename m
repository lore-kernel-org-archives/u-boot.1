Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966E1E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61D48043F;
	Fri, 20 Dec 2024 05:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XLVRe8vn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 681F380508; Fri, 20 Dec 2024 05:05:49 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F627804CC
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa6aad76beeso222426266b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667545; x=1735272345; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fKqj5XxMM6ETsljYw6BhOK1wDATCggEN2ywC7hzCDyw=;
 b=XLVRe8vnuDg2b+0Tf3NAlaLFsODMO+qI3Rf1E399hPl+zUedy5nOpoHS/lq1qqJeOu
 La/Dr4Or/MrWb5h62q5m0uo1JPC1Oxroxgl7zFpG7VQAP5Mxa3nz9kBUQ6WqELxXCeDQ
 59S706/iYVRxhiLxlJ3LYepk37Xi7cuEx8hZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667545; x=1735272345;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fKqj5XxMM6ETsljYw6BhOK1wDATCggEN2ywC7hzCDyw=;
 b=PUnYvwvSjj3Fs6Fp4BdMRGDT7Knx9k+pcaDVi8gXmbqry9gC4fGc923PI7E47vGMew
 RMJ4GeZL/vQ5Syk8xnlGQUNHsJxazvC0a6C//S/Epcd/0BY/+C5qIhsePfXIWITPzJbh
 /uRuDLnwnf3aXM4wchxBEc5XKcJc0xTY7GTyVx/kQ8BNynJqspYd4PQhwH4/EZyihPOF
 LhSGcS0i8+hsr1FuH2luBC61ILAC4nsDqYrLzRVRmAYb8mxuKqDEN6cOSRRLYWXkct5A
 Xi6k1KD009e97A4Z7aKl2eTJI1cbOyQsLPZvbCNZo7xVBawqNOqibvxHhEUY/OuV8KLv
 7mrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyxdgAsHm6P8/U2XYJtlBHtVWOmHGxhCwNrzkDxLRuP/BX3+vbhiLPxt4P2kxZizqrpKGxWSA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3z4KD/Of0j0yBWdWCF6bHiqK8GcgeICxo0Egs9Yz4q1giIV0u
 pOsmixTmi9G5hS91J3Pm9IJAQNdgWB1Qhu8F5o2G4pRQAA0qROd3+/7floemKUNrEFtferDi7da
 AsdowxrQnx1T0gbyEi74+0cEl+e6AQp5TI9TQskE9xQzC5RQ=
X-Gm-Gg: ASbGncuaL9mNxi+0WMPh1FtMQNgEvbG9QpYMlWQp5EhA2UhmZiPVLes/xjubxpxzQjh
 Pnn8IPwibvLfD3dkBJjIKyeYFIUnPunGNtDx0Qno=
X-Google-Smtp-Source: AGHT+IFDNUNJF+LhyWi9tS+q726nAjg3BEwItGbVtXlqmpL9S0jBu8Rzlo17mdKC3zQmbuGif9EFWAaY2scsej6ejS8=
X-Received: by 2002:a17:907:9715:b0:aac:619:e914 with SMTP id
 a640c23a62f3a-aac2ad88fcfmr108580466b.16.1734667545639; Thu, 19 Dec 2024
 20:05:45 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:05:44 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-29-sjg@chromium.org>
References: <20241206023626.2456858-29-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:05:44 -0800
X-Google-Sender-Auth: UvTeQuJin_E4CvOIEGTnBaYuexY
Message-ID: <CAFLszTik_QTVopPWjZqGXOtT-eubPwRDFNwM0e_gkh03hZBMPg@mail.gmail.com>
Subject: Re: [PATCH v3 28/46] net: Drop #ifdef in parse_args()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>,
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

Use IS_ENABLED() to avoid an extra build path.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 cmd/net.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Applied to sjg/master, thanks!
