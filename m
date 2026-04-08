Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520481073CA6
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38CEB8404A;
	Wed,  8 Apr 2026 14:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="opgIG8dE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80CFE8405F; Wed,  8 Apr 2026 14:49:31 +0200 (CEST)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42AF483D8A
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 14:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-1271257ae53so6767605c88.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 05:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775652566; cv=none;
 d=google.com; s=arc-20240605;
 b=ksH0go5YHlz0Hu5pY3ITv2WaorxTcNCMKyM9se2FF75r0adhVHAeETJZz7ksGMXQwR
 v8+cxNicKCWT4b3qUzxNMceoQqncaEn8OULTBZsSb5OAZtEm69GiI5RzXq7fh4b8ol2s
 FVCkpcWdErwVVooMjZAdzPkUjUjmkLX64ux0QYqOggu6FRK3i223NgWyWdDfLhiwZQbR
 qLNdpfuDWYUfEi/8+wK6fJc9NoVqoWQ83OSpX/9sOqulU0OKCASLOkzoSKUUJhQNhWxl
 TYV7KyeUvUf0sGbUEe9Fd76otI0ufEpk2LKmGOmAcqZpDLFLmOeVawr1z7XGq9/5i0NG
 B0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SCoGw0DDXydlU7v3nkENRbcafWs3N2ntoEHnai/FUGs=;
 fh=jbRFM7KP5D5iElM46gV8oSZh+zTFFNlTSTHiAqaXMnQ=;
 b=NfIVnKrhSvlSxp2h7zeKGozICFwQoU4KNOxfpIQQxG2beA0Y6UjtNWnitFg4r+ZyDR
 1dTqTOyRPmZcalarKfR+0RCiM3ATAAXXnMWdZb8phx7XV6E8wN/f3Z2pd3c0ZMtSf6oX
 H2P2ozJxe62i4UICEZPAaVWj5YbvNViANkIUgARlOvwNbwdYwCPD3GT1waRRqGoQwLNk
 o2QGWTqux2w5sjPsYDnnyjpcnutKw0qNRyeaXjm/3JY6YoCvwcGk3fLK9SdZ6/2u6P5K
 d/kO65aaSsQ7Rq0vmEkBaOLYtoy55+v8Req+8sDnYPoiBtR6VqNUpA4KA0fsYs/oys47
 xQBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775652566; x=1776257366; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SCoGw0DDXydlU7v3nkENRbcafWs3N2ntoEHnai/FUGs=;
 b=opgIG8dEKtzT0OcbzHcaryVtLLiR41MsD2wJT2cFzQ+wgY5PDr70ysRsAI+5anFbPQ
 45pqueu18u6BhxyRAK40rgy+bQRB9NM4txsolEQbmW3TSmB5AGqvNk/WPq/iu9ObeJwl
 j3GB5GRXIpzVGfsXmZ+MyEU9VF4R3WrLQXYRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775652566; x=1776257366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCoGw0DDXydlU7v3nkENRbcafWs3N2ntoEHnai/FUGs=;
 b=L4Akiig0jXQn5TMuVAU0eLiVP02EfYDyCidWAGGb1QPCkZfaBcXkaoGMv+AOXWIFqp
 JPcgP6t4NUtLng3xWlb2nyniz3rqObX9oCt5CoH4VlxofWyTo3chUnulx0AF+z9og3ef
 45zzMOGwpIjQ444pSA94kXGq/cSGecFls993DArDeeNmaQ+RPu6H6CPXgUtI9yGoJiV8
 43AeWQ+zzRZOPh5z1gHJ7LFdCTjH/6r3wXMfEJui+343hEFXNwJnpyYlxad/C6sKKE14
 4fQlmoDYD2yzVZq+Xfx8DdgnEUHk6vm3Isw5PI2NSoIwIX2piHpYTGmEIecWvvkmWBHI
 rZUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUwyFSEtIYR2zFg2PJkycQG6OHExHG7/ZQbVi3e+oq+eR6B41RQ4GBrQAMSngWCEYyxPytQA0=@lists.denx.de
X-Gm-Message-State: AOJu0YzV4axhRc6g6uuHu2MxbkO68qwRwCIiDYZPaJ9qLjBMQsCERWZB
 IUCr28c2u4gof8gmRHBFamLhQwbG+dp3A3M/b6ZUdFsDalgg2Wh9KAT21LWufe7EoPXwOuUIewP
 x9r2f7EdS4+WRRpxPY1lxZoTcSsGsFNUyNTSmSw3DWPf0UjEjwFhG
X-Gm-Gg: AeBDietYgn7INzww1OqVsvkS2gbiShUxYuJnapzyJ72bVB/DYWOB6EsrPupJADGVuth
 rCG7kol+gB2FKC2y7FaYRXsXTU7EGllMMcucKZTJtZLEAkJnguAbpVk58+VloX68uJUk1snUOk+
 eWCuf2raMjHL7q01fevDv0aGVqhDy/LdoTKT0eNjSh+alJFhWEnFCBMXJ/iqXyzH1p7vOtDhis1
 EUmih65f9/Vo0sOnuXBd3rfwhZX7qFCjDJEXXfpH4vmfBinjkXJVJGApcoQMgDTe2RA6Llxa5lF
 rldf
X-Received: by 2002:a05:7022:b81:b0:119:e55a:9c03 with SMTP id
 a92af1059eb24-12bfb765d17mr9265257c88.31.1775652566320; Wed, 08 Apr 2026
 05:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-3-daniel@thingy.jp>
 <c300ac4f-f38a-4a0d-bed9-65588b3308d8@kernel-space.org>
In-Reply-To: <c300ac4f-f38a-4a0d-bed9-65588b3308d8@kernel-space.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Wed, 8 Apr 2026 21:49:14 +0900
X-Gm-Features: AQROBzCzfRBpGRFGg4APZCRiYAfo1VMK34upR4HtmeaCpsvq7uq_znTLohg7ZL8
Message-ID: <CAFr9PXk-fJ_kbqd08LHtCdNfid=MVAr8yEj25o_yJghh7qRB=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] m68k: Fix writew(), writel(), readw(),
 readl() endianness
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: visitorckw@gmail.com, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

Hi Angelo.

On Wed, 8 Apr 2026 at 21:12, Angelo Dureghello <angelo@kernel-space.org> wrote:
> mmm, "currently broken" ?
> If you remove bigendian read/write the driver framework will fail
> to work with coldfire/m68k stuff.

I'm not sure who/what decided this but in Linux at least these are
meant to be read little endian and convert to cpu endian.
Classic m68k in linux works like that. Coldfire in Linux is currently
the same as u-boot on internal registers and but everything else has
the "correct" behaviour. I think that is so PCI can work.

> I tested the patchset over master in stmark2 board, seems this patch is
> breaking dspi cs init:

Thank you for checking and sorry for the breakage.

> Please find a different solution, that may be using "xxx_le" stuff directly
> from your code.

mmm so I did try that for nommu classic m68k in Linux because it's
also "broken" there and got told to fix readl() etc.

Would putting this in some #ifdefs so coldfire keeps the current
behaviour and classic m68k matches Linux be acceptable?

Thanks,

Daniel
