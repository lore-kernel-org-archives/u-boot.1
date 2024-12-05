Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C09EE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E8D894CE;
	Thu,  5 Dec 2024 20:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WnJd9r5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14D358919B; Thu,  5 Dec 2024 20:55:58 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C008952C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso160479866b.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428555; x=1734033355; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9u79q3ArfX7d7koivYM1KMfxY0+TjifdtekIZ92dxOw=;
 b=WnJd9r5/CHGRjReNHQC3upio7AKfRfnh8RHxJTOiXZ6nL0edhEw8E+MFChlt8NoB5s
 UCiydGRy3ZiDtMicfPUCPwR57Fy3SIsOn2d6So4HvDDBqVky/I9+K9Et3GuQHnf9wrsW
 IS+8KBJSr4642bp4ZEj22ftoQ08rl8hCC4oro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428555; x=1734033355;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9u79q3ArfX7d7koivYM1KMfxY0+TjifdtekIZ92dxOw=;
 b=CDMOJb05pGZxkIyXcNy68Qp6V3Ecj+IkrYMoYYkSkF61EMj/lmh+eAooLXf7TxDio0
 MxBlSXkxAVNPI0RCVSTKceoIfyFwZv9NhTU3z/Kn/V9CrShwWER84mOK+AqP33dieKxd
 OSdTURjqihcngj4MoHEbfDM9ulG/CnL395MosvG0ip7iRHeVb04hR08BzmMOyauiXJNs
 MbUaxByvPAjCdhQNoGzEcg+U00ZexD3E5F4VUFLUpCCcTsh86oNdvEHLblLjCd5Ltvuf
 a1/O0qdYr2YSi3amEjR2Rrs/LHHtH8A84JTP4UImU1v2HBb7tSy7uAL72aD+xu0H/DND
 SkJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7nrkkkdaCu6mM7XSuIjE3oEZ9LhbdfbV9acds3LUWTfn4x48/ZUOPECTl6ttplAs5Kh+z9qw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywt/rDW+ZzLBDMXH+nUyRZNKGnM5G8iZ1E9+frpEzjvRzbu25A5
 iSAmBtrD4NV5X7CvSUAngZMOMzSxK4LYSo8oyOpUa2WYZ7n9/FHJ267CCCefhRDx1w71zOnBUc1
 NoUfvtUFpxIt5oAKvmKhuLsLmvQ6hmghpTlGt
X-Gm-Gg: ASbGnctf0nzvszgaIaMYRHgEHUwcNRGU11OkvN250HprA+5YA7lnz9jIlb2qfvJnMf9
 vpfUK9d/6fddWXW648/ZERHFBY2TEFzfq
X-Google-Smtp-Source: AGHT+IGZJ00m9BR7PVNEPNzFm7G8irIFhhaJfMlxhVkzl+/efJabp+pmHnRgnC3qBYbkfwSXaj0++nkEdf0G6SEXkU8=
X-Received: by 2002:a17:906:30cc:b0:aa5:1d08:dad7 with SMTP id
 a640c23a62f3a-aa639fb0e5bmr9092366b.9.1733428555649; Thu, 05 Dec 2024
 11:55:55 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:53 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-10-sjg@chromium.org>
References: <20241115231926.211999-10-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:53 -0600
X-Google-Sender-Auth: lSl8JVC_XFn_4yljPhDSaZfUGJM
Message-ID: <CAFLszTids2cUW7sbm-4aUqBF21FbN9CWP_DzThxJ-Q_xXH9WHA@mail.gmail.com>
Subject: Re: [PATCH v4 09/19] bootmeth_efi: Simplify reading files by using
 the common function
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Shantur Rathore <i@shantur.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The efiload_read_file() does similar things to a common function, so
update it to use that instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v4:
- Make sure that bflow->buf is set correctly

Changes in v2:
- Change the tag to bootmeth_efi

 boot/bootmeth_efi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Applied to ci/master, thanks!
