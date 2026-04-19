Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2706DF99C8D
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 01:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55F1883B99;
	Sun, 19 Apr 2026 03:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="k3vylid6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0182183BC8; Sun, 19 Apr 2026 03:33:27 +0200 (CEST)
Received: from mail-dl1-x1231.google.com (mail-dl1-x1231.google.com
 [IPv6:2607:f8b0:4864:20::1231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83668839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 03:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-12c080efc1eso1873276c88.0
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 18:33:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776562401; cv=none;
 d=google.com; s=arc-20240605;
 b=RBH9jwAGNSdLLM+/AH9nDy1cA1oRkn8gHzd+UIXAme2Den/2OhBTnB3xGsNHX9JQcK
 1ZODIxega3tkzPGZWHJh7wV+Pd5PW6RflDmZPYs0SUOox+4cJ5qp0JS9PliHIOo04RkC
 Ee687CxL5vHMsanGageYxPNvbWV9V9q4gbFYP8/cxSMdR9xWS/LRs7qgECwQFEIK8ZPF
 2gbc1XydjQM4d65+F2+iHkfpA5xT2xkYK3zw0FA66SMebwAI4cjSZ/uQtLqx4mzYu/mF
 x+UNrQ1jPBfzksU9xrXMLHnZcijMzBA7pEskUtrDxAy2M3axpPnOotYekkfEdr8eF+A5
 dB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z/+ToO8X1EzuYfqRm38wTbv3ooyEwgtrTFJ/tr07xZ8=;
 fh=OB9/KaF0dMU4M1JLn2IhaPQpRnSyTn0z2VO9+B98haw=;
 b=g7rkaZPtsKNLhqT+h+xJLtdMtIV/FFtAGmLZ0iwoxQDuBQow0oknnFs2PqDXEvbNzs
 EWfrhpHNYT4yMxaoO1p9J94OtcSql5/pJDRZAa62DCwyucaf2d7KNJT9LmCVdz//hnZs
 1sP79fKQl/a3vrOrNm8ss+N9XPZn+VrNdcC9za3ibYfqDWwwGioQqTIZK+izSJwPiKY+
 KlKMr+PN0zQALX75vHrZYa5iGORVGiwak04fNOJY3X7KXicqAo0u0yVDURVJtSJgM2FH
 aSTE/mVnsQsnLB7RYv7nM/w2cfUBvNtxJE9g1vCKGZYZv5LWmp4IgZWayBLdXIQd6Ibr
 mg1A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776562401; x=1777167201; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/+ToO8X1EzuYfqRm38wTbv3ooyEwgtrTFJ/tr07xZ8=;
 b=k3vylid6Se/dQNLk0P7u7QANVcmxIKWYnLnv3RB0a3CdC3+MKns5G9MMCaCbKR+0Cp
 hzJQmpVs8GhMCLXjjwJmTZcJalgzqNFV7t7otKl8SdqyLe1v9PS+ZWHdrp2gJxkMqMt/
 74LgolPj5K49PNxdSJqr/8/WzfoRSWTP/AR3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776562401; x=1777167201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/+ToO8X1EzuYfqRm38wTbv3ooyEwgtrTFJ/tr07xZ8=;
 b=BByvlPf28Sot7aqFtD+vczDNuvkBY3je9bIWIou2sB8H/3h/wLQQfNhFssJOSw3yfk
 DXShYDwVIkRwv5EXa8WqQE4M1ix5AeAVhEF+zF75GpXElpm4KFhjLW0EKWX00vqk+hao
 faB3Nv0AW4TII22qXv4H6P0OXD/lOp+sOFVn1MgSy3JSA/OgIBkpaZ7ivzYFTV5rI33g
 dVu60emNxfiTt2vT9RKcvTzH+kOlXlmPtdcNkSM7Q4v+TUt6/ZI4tspWcwYUSlHVgve1
 PqVxPqiPJ++tqZZX2N5/neS3tLKI5PdY1qPtladqY7cOHkEfJpfLkNKrLGPfVxkEpFmF
 m3tQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cA4oMvZoeWpeWN2S+Ewt4l9PNil2pho27DstQG+8pSRL0+9k35D+dSX0Gh7WHd8K6GH7Uqe0=@lists.denx.de
X-Gm-Message-State: AOJu0YzX1uWlesNtMB+tiECEf/CrBrDunpxn/qp2jd3qNXiZA3IckBJn
 qKzUavEeX6/xQwuxJTWl8RwJSZgGoa4JQRVOejUCh7ftaCmLG34A98Icp3Svy/gVbTrRDk2ONHG
 mvTfKm1XQXc0J3XP6XqmGakZWDrpR7cBw+IKUIQTSag==
X-Gm-Gg: AeBDieuSudQ5tXnRbnVSsyOJ4Odh0wMH0IOs0uEnLp1NgcTz7O1EetZooMIVX+3MhEU
 ShkXBrR5gzQymkBbsG92/U2jzzLS0+/fZshxJTBZTivTBANwunSFruJjdDoRY00to5bxWzLNV0D
 ywAHvbYhX/nuTeUMkjHrKlzthZHX5bU+1bQtbO/7w4yBHatWYlG774RMczCXe+H+8MGe4yFyHSS
 iAZt+imy+Uvy37NHA+rbKZHv1zdpO2PrnDJ2ThDwWl3lwgfvXyo/jdCvtqyqgDusuXW8EqXnme1
 YMi9AQOV/enNzUa+iQ==
X-Received: by 2002:a05:7022:4581:b0:12b:ebf6:a3bc with SMTP id
 a92af1059eb24-12c73ae55b1mr3328905c88.3.1776562401465; Sat, 18 Apr 2026
 18:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260416093927.602613-1-daniel@thingy.jp>
In-Reply-To: <20260416093927.602613-1-daniel@thingy.jp>
From: Daniel Palmer <daniel@thingy.jp>
Date: Sun, 19 Apr 2026 10:33:09 +0900
X-Gm-Features: AQROBzBnePmmBixUKUbKUhq3lSxEO-CT8gkqKmJQLmY9ZGMKAmUQZHkJswcUL-k
Message-ID: <CAFr9PXnPnQhdn7-PwHM2E6pT3o4uuCXJqb8AkZ1mHQ_Ovgneqw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add virtio-mmio support to m68k virt machine
To: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de
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

Hi all, but I think mainly Kuan-Wei

On Thu, 16 Apr 2026 at 18:39, Daniel Palmer <daniel@thingy.jp> wrote:
>
> Lets start making the m68k virt machine support useful.
>

I now also have everything else needed to get linux to boot
(relocation support for u-boot, passing the bootinfo onto linux and so
on).
I'll send a series after this gets merged. Heads up to avoid duplicate work. :)

Cheers,

Daniel
