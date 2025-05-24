Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF22C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871E583483;
	Sat, 24 May 2025 06:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cNFHbzXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B992A83483; Sat, 24 May 2025 06:25:22 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1922383439
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad5566ac13cso60469566b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060717; x=1748665517; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VM5ep0hXW3odYqgv7jAPgv++JrDqneWe6iNhFQ1OuIU=;
 b=cNFHbzXknGyktZPbEXVMxFdLvFvgkvK/mWWdcIek/AsmR8eqpmWEPb3/w7VJ5qRxy5
 NfBmWcRpGZMBUDJiR/4FxQOkRhJooYY0K0MW7HwnbsYoM3COzapv1zdTwgPJmZaT+Six
 QBSspoaSqbrGAWRUpEnO/N4xsHQ8f31aRi51U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060717; x=1748665517;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VM5ep0hXW3odYqgv7jAPgv++JrDqneWe6iNhFQ1OuIU=;
 b=kC5SauZA1XHGsR05rgwWeLHvUALdeSQBoqdd+eVYPrZ6qc1Wegzji6o6LXLsLZS6/c
 K4V/DV1doxMecZeiJ4P5iiMRO8ntaQJ5NdHXJNfmEqDb/Zp2wMz8d9tAkaFJkPOKXHzS
 3wj1V2vB6IbdkcAVGQUuSWQ1D76hnba8JxjQmRWboNClYQgHDazKU8yxo9uAq1O0QGtI
 sawZBVsg/6eGGG5FQx/dbSAqeBG4aD7Hd6DSMSeBD83KdZ3a5jE2FnELbeWP0we9kZgd
 8MBFoKmEpvT3flCMv0OM5/i+yZ/ciXROg8FXcJFNICTn3svJMxPTUyY/4B8uVDFyL8/e
 Bwmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDAwrMbkYplaNrTct12G7AWogV5WgeFinQtcwvrTPsKlr/3fIaqbJCIP5GeNa49NTLsMlhtIs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz09+iLjWSy/rRiq8T1WcwcLpOHT+QlSHlT+vhPA/IFnI3ippON
 u7SKbqOgsjdcuqdZlexPYudi7eYx1oKH7lRT9krAAzZVJOtzuTQrRGsorYFHWNCduVqxozmEVFN
 dREfA1cOZVBPPyqXIUf8g3weL4BiBx5IJNros/hSaesgcjg9yVSEc4Tfq
X-Gm-Gg: ASbGncvdg71rIMuILEDFWKFj7yjX9hOruHT+dvRRNoR3c/qZ5imrLnYVIMz9xaIID56
 1R3hElCpnBiLBLRXW8pV8y+LTVqQ4ieoGLazy3E/YhA/kM75dJdhfYqLpCd3yO7KrDhKY3hS5z8
 6K+IrW67D4Z9GQ/IfIlY3T/JxfOiEP0GU=
X-Google-Smtp-Source: AGHT+IHhJtmNambDlNn5QUCB+hnbzqQtV5ek6InBnv85mO9IV6MMq5TKk9qs2x7AHM4uE33QuKlK0fgxKV0A4Skm0TU=
X-Received: by 2002:a17:907:3e06:b0:ad5:27f5:7174 with SMTP id
 a640c23a62f3a-ad85adbbbf7mr139834666b.0.1748060717582; Fri, 23 May 2025
 21:25:17 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:15 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:15 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-16-sjg@chromium.org>
References: <20250508072907.207175-16-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 21:25:15 -0700
X-Google-Sender-Auth: GyV0D9Hu1-aqm1fvQ9i5lN32XAU
X-Gm-Features: AX0GCFvqefi8weB4qv8Z-2Q6xctM6886oPpZ1vXsd_VWymaITdyZ0nCHrh1TNbM
Message-ID: <CAFLszTj1LTpuL3aDzOjN8mCLpePLwGq7Q1U2bgRDVUCNvyjPdw@mail.gmail.com>
Subject: Re: [PATCH 15/20] patman: Add tests for help
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

Add a few tests to make sure that help is provided when requested.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Applied to sjg/master, thanks!
