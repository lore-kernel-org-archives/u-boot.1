Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2000BF8A146
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAEC78407E;
	Thu, 16 Apr 2026 11:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="oZSym3rd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0513B84105; Thu, 16 Apr 2026 11:14:36 +0200 (CEST)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7582E83FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1279eced0b9so11286052c88.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776330871; cv=none;
 d=google.com; s=arc-20240605;
 b=j8jIGMnkFEjHzvB+XOtPEYMQuXZ+2zyU7xKGfvQyZnY+x2DA6Fe0pNSBHVqOl/xWS7
 oywlryjDSdXxWX/5lLVnNmrcacw4rMy1sY0/KCbqzB/ChrGTW/t8wExcIjyQCwxviIvP
 Ittu5iTHjOszVcaJCF8tfCbMw9Lv6SBl+KZHDMIg7cGBpCIdltXAfjBbQDHg2Iu53nHJ
 OmKZH4FtyEwRx/mz1wra6dFSPn+2Ayt0awDa32SdJaam7OjnajH+YcUCEmQplwcEPQIz
 lZwzDJAlvEePw20XUiGShsmi4S7L0ahzfh7VYItQAKeac1c3oegao96TcwUj4qGI21yu
 of0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GgdMK6jRW9uHesHpYxhFQYZ6L/g2qMNmJl/uCB9aPdc=;
 fh=uR6Xv81TiE6im77EvvdP+H3OfCw2R1K5JYTXz3LgkcE=;
 b=ktQTbtPlxIO43axRdBlqPtqQZzQvcEOsT7S4ABKv4A8AgK14PNaAa/96QJ3Xk3KdwY
 F9JiN4sQEUwvzUaBHgQ3wmm8advvGIfMB3lYgZ2PZLEOfJizhSPqkpzQUKUvp6K5Xo+X
 /WLkjWm9OFGqvtZDvAJKOTsFyvS/Oo3id8mPJZIfD2aHfb39lwSC+/p0qKk4zYO/bc/q
 3nt7HH5F0fqT6iEld7fqKJpMb4YoBJYUSZlDGqRDu4M5HoZBARRuNeO3m28n1G0ESTbI
 k4AjWYazMbuOZ61j7x6wglZu/AV0jLYx+wyleM3Z6Jk7EMbgvHM7uP1SsV3j0cCisJ/S
 9z9w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776330871; x=1776935671; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GgdMK6jRW9uHesHpYxhFQYZ6L/g2qMNmJl/uCB9aPdc=;
 b=oZSym3rdtIGNcXgmbaGjcX/XG05JXvND+rAorfQh0o5D3eTrXZc1znsos8COXw/gow
 jlWuX8jaWt0+uz1KZ+OrTuJSjGkzzRwPrUWDcTWOeYlVwl9+0fP8tuokkMxrmO0Xyawb
 rHpSKuOX6bCUgvXk35yDZg0YWthJg9QBK35Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776330871; x=1776935671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GgdMK6jRW9uHesHpYxhFQYZ6L/g2qMNmJl/uCB9aPdc=;
 b=GhP7ZnRDEOc97aTG4AprBOmshmA/O0RpnkmeJgMqgP5G29qTw4elKj/RabWCwge50k
 4Y4K/LBkXrSZZ9c4riwTyZxyOAR1hKpMtY/08TwJzxNcR1UCqDlKkg09W9ClgSFeduNK
 s746RISWSHpX99cMrLWq7SKs4r3TRepp90IGswbOpvW9XjV8D4wkZR3lyCLmdRSkD6FU
 MUQyuAAdraGkatnGdynrW8siD7iKKMT+4IfJotwOsFpartJrXCWg2gXikCzwlEIcYLBG
 64uOmtHHlpBxBfkWZ37CME/+qOdBzUTyjd9Rx+7ykwhUZZTaYFfy1JeeTdqv7dDy+sqc
 L5Kg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NVC209l0fB8FlBxhGP3dCFxH1SHn3UVIkxbvcwwWsUKojm0/pM26xIG15zytK8qB+S2Y7NTA=@lists.denx.de
X-Gm-Message-State: AOJu0YxjmSEcobTswC2tGAUSI9EX29bO5eqUkQgLR3mFL7b7DP+E1Fd+
 oIP8SEj/Py9V4wOWV1XduOyQF2Zyr2meRCx7Di+z02g5tjodvGNmH/814raMCZVA6xOPwreSMhb
 MjDLdU2i5K3bEdzBfMMlDhmPxIgNUmF9HY1i4rBaPUUliYyuY/XeyY4g=
X-Gm-Gg: AeBDievjeWhv+5i2Yndxpw9X5oOkgsWE9uZeHbjJ/7AQb/g734+hvvwEOQuR1xaX0a3
 NYmwNt+mNKxrXpDb6saYWg6jzCjkCzm74A+ylvD9PAfr+7wDdOIWWi0vV8mjFfMd+PxK+ZxU9Y4
 DbwHyGnCbzMB7k1Vrgfg04OMMDquWJR6E6bFD61JWuXXiU+CK3+duIElS7bY1rM05OWlrTex+Ou
 isg9H3v17N57Zj1TSK/8Wvruiva3NRSjvMc0ybARz7VX+sV7P2i/0x66u4KUVxv/H7WW947EYXN
 638SeEk=
X-Received: by 2002:a05:7022:e0d:b0:128:cf5c:535a with SMTP id
 a92af1059eb24-12c34e8f94emr13473687c88.11.1776330870730; Thu, 16 Apr 2026
 02:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-3-daniel@thingy.jp>
 <9953a109-6ff5-43f1-ac5d-245c906280b5@kernel-space.org>
In-Reply-To: <9953a109-6ff5-43f1-ac5d-245c906280b5@kernel-space.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Thu, 16 Apr 2026 18:14:18 +0900
X-Gm-Features: AQROBzA7Abhwg4mpOSClXPlc5KDef2RDVXxcL56ZDotNsnBz5jE3VbE3RMr4l7M
Message-ID: <CAFr9PXk+1THbL3Pe9gGfXtYWr0Tt0Aci559UGzc0kDsnD63dQg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] m68k: Fix writew(), writel(), readw(), readl()
 endianness for classic m68k
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: visitorckw@gmail.com, bmeng.cn@gmail.com, sjg@chromium.org, 
 u-boot@lists.denx.de
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

Hi Angelo,

On Thu, 16 Apr 2026 at 18:06, Angelo Dureghello <angelo@kernel-space.org> wrote:
>
> Hi Daniel,
>
> actually, i can build all m68k boards without errors,
> and have stmark2 up and running without any issue.
>
> I will try to fix better this endian thing asap, thanks for the comment.

A heads up: The linux versions of these might change for CF ->
https://lore.kernel.org/linux-m68k/4ec2b9f3-8420-4f77-9373-7ae4df83404d@app.fastmail.com/T/#mdb1f285ce91df7e94f1c2a1fb3b137f3f8e21a79

Cheers,

Daniel
