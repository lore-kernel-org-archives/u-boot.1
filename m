Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0F8E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D82803CC;
	Fri, 20 Dec 2024 05:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kIEQAR78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAA4F80087; Fri, 20 Dec 2024 05:05:17 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDAAA80362
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so266357466b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667515; x=1735272315; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CQF1nJDwzdxPlv0o1zbHOU8A3QHWvxJAwqQR2yT4Gd4=;
 b=kIEQAR78udHLiJtuIamVrmqGCYwAclXYxhKZOlUZ8IFMep/pYJmZdsrZnKP2L0ED/x
 E9AA6u1NXyDT9dVpuzq2VoftI63lgPXF51mJAkzi2EUweBcMdofrzuXWHtZjc2VxFMIM
 rR1gSOBbUx4NTc1pPJoV3K/k5is1xaONyinR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667515; x=1735272315;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CQF1nJDwzdxPlv0o1zbHOU8A3QHWvxJAwqQR2yT4Gd4=;
 b=eth8gKrX8A3LGAjDKEYhZGTP8rTeT9fN0Y/tDLklkdWbVMpt/zTjJGbgN+wRCGCs9j
 Acp48AEorJml5/xIo89i/gU76Z92uLfh6SWn4CBaWMrvdV/DfSO25iNTA+k+xsJR9xsc
 nDDm8XFwO6nzrh9MsCvdZ0ZVr/nEmX44Aw3+qfHJ3pdoMjSZGoizfUvVId/N2ID7eBvU
 tGVgXQbNtP48LtdxCJh4ggK9bPPyhs+lXBs4U7q7lOn+HUWD+Eu7sNtzK1egD4i6w5tm
 4lY2d1Du1t+n3+KgP58ReQ5ee5o3bfFTgkJF2bFXH9VJQ1v+hayB3YDIHm6MxI+LePnd
 6CJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQhHyEZUoLwqnrDtmVmcXQTEvzY11ncuqRgq2H0cKpmOoFt13i5k6oYV2Bgl1gX/PnEPeEzTg=@lists.denx.de
X-Gm-Message-State: AOJu0YxF4Hglxn3PFryV/6kDqSVGpWb2ftBtEYhYTWs3oHAKrPRJdpR9
 W4f2QJWcZ5CfeQaE8fGERC10auc2zoTFXA5FrC9lnOXYcirOj+crogAKSRGMaS42JRWfxJHaadU
 Tk969BYm9hsp7/xmP4BakDxUzp8b0PZ9d70cf
X-Gm-Gg: ASbGnctRcMBXbruxkK68axPv62sHjwZ7v1LTbc5/xW9Ca+YJLO1DmTGbrwEosDD5X7L
 wMesWBk3n9Q/bRpbmfXDYZ6fYt20RawiWD3IEBGQ=
X-Google-Smtp-Source: AGHT+IEyqoVvPw5UJOqHNzr4MNF4ZeJh5Lk0Y4BPy6uPeW/hPRMreA5Q5BcD5Cu8uoJMV4bB503cnKAU01UR7lcmQBw=
X-Received: by 2002:a17:907:9722:b0:aa6:730c:acd with SMTP id
 a640c23a62f3a-aac2ad9e692mr108679966b.16.1734667515408; Thu, 19 Dec 2024
 20:05:15 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:05:14 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-39-sjg@chromium.org>
References: <20241206023626.2456858-39-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:05:14 -0600
X-Google-Sender-Auth: k8RNPSH0K4ayRHEusfcMj1CnPjg
Message-ID: <CAFLszTgnPz4tTyquovW3u+XgU0=gstVg43ApuWVA1yLgc38d7g@mail.gmail.com>
Subject: Re: [PATCH v3 38/46] bootmeth_pxe: Implement the fallback option
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
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

Provide this feature in PXE, so that it matches extlinux. Use plat data
for this, just like extlinux.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_pxe.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Applied to sjg/master, thanks!
