Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668C6F3ED4A
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 00:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB7F83B99;
	Sun, 12 Apr 2026 02:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="fjrIjp9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A4E83B99; Sun, 12 Apr 2026 02:59:31 +0200 (CEST)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com
 [IPv6:2607:f8b0:4864:20::1236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C10839D9
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 02:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-12c45281a06so561836c88.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 17:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775955566; cv=none;
 d=google.com; s=arc-20240605;
 b=FAjSNjetB0lpafKhNEuxZPompZB7vLwp7hpFG9Z9CNC9VgdKCGme8Edgi2vDf7qRKK
 8dpI2y91eWGQn+FQFesA2cnl60Zsni91ajG9kTKEl5mZ76OCD4CGmnN03Xi3j99Dzsb7
 fHK2kbrMxY/+ErY34iykUJiyRnXjByny0bTzlMZh+ZTb2oG3x8E+zqYo5jLqIEKU2a4J
 70FP58HFK0zrbO4hkNgI7jtA3LdZrTl9BQUEo0zWz9CvlqN1XjAo81zIHoYS7ME3LGas
 i/njdoCCk13maLvGjpBZQKhkkol4Fxq/xXOI1isQf9D2G2PsOUABOLL59lLaZRq8VnOY
 69Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9B/awkBf76NYQ3wZfgenyzP5dYSGtgNbKORGBL7qQDY=;
 fh=ZUGUgN1x0n8D4+gg/oXM2I8GAYqDnensOouY5qV2UWA=;
 b=VPGS2eBHxDVq9U3DrSqqOjVGPdOq5hLh8Op7DHQdUbq5GMzP1eB930Ga30BOmvNspE
 YAe8ZNHg7+WcmMOC1c+YrgxDsFO1tVMUAgr7S7oHQaCJy4RbvMg9Cp1XPto+DZpmZmgN
 F9r5h2OJNqV3b3Jd4PMsN89coofJA6X39mWo7Wo57ZIcKTHByN0QozxVY7Yf/4/XaQJE
 qemViE+ihIkLcfKrJZWzhWc2SftiNRftdtySosR7Iayb6sJk+gmKxDr08z0UxyT5n6fM
 dwpLMUM/J/oEgvjNvbksodN7qhiPdqURVXdFTNghsfeG5alTDjVb3KdG8nOmgixJ2von
 AN7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775955566; x=1776560366; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9B/awkBf76NYQ3wZfgenyzP5dYSGtgNbKORGBL7qQDY=;
 b=fjrIjp9KH/wuhu32UhNBZsx3Vdu0a5GpUOmLyNFsdUapH0sjciX2lACm9VnZ4FXU7B
 y3juk+LybWeu3oQ8Px9qM9JWPQb2jrOfXrxhwjF1C3yYAuglN6zit/qxgoepP05/Xu66
 4eBjsqtpVcS1iedgWmsphVOgOG6o64H9f5UJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775955566; x=1776560366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9B/awkBf76NYQ3wZfgenyzP5dYSGtgNbKORGBL7qQDY=;
 b=OsXFT7wMaEn9ti96AWq2qq3A2cl9rDE0lRtXg8iFXjpvGRjHbm0PPKT+0zx3FmMfRs
 Fv5CzB4K5uQkduca6UeLNCfA+KO8rSnAgZNNMe55q2mJAZsI7f0ChThGmkBs6GhThuSH
 04zyBbsiaZJBrMGPGG59C/UbEGRRu5b6fUIi3Mm7vFrdl8PotlvA3LwUPERzVQgd6wvK
 N/lsgyX5bhLIu1OmM1BbH41hHMK3yuy720hh4xvWxrUMLpyGAToRYqWihqUKe0sbHEd0
 uSO2P035z4F1NMtu6JDlfNi1ESAZrzd3AuCxS1kKU7STz3gHCNc75MYZ05f4MwRUebFC
 C79g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlh7h3ldGe2inPOU4+JIccjHdhU1TeeTkeQ9GFMwbj3Lr0lVVKuighhdABAgx3iduKwaLw1/A=@lists.denx.de
X-Gm-Message-State: AOJu0YwLUwDeMT8hXatdt2XO+00hHY/I/xESEnPbRH/kMo/HhbeXcxF9
 AKJj8oQDj9LOWCZMtIOa07Q4wpjc9Ms7j6hlDtMCWxasEHKraHeb8tM8TsUHn/i1MAil15USGJZ
 gQwOnhbZgpoqGv8ixv5tLrNt2Zgo60Nk1uCsibynVbg==
X-Gm-Gg: AeBDievb+iN6dYljnvutl7Wa98NLkgB46MsBfyQw7h6WzrK53rz9LUStGxMtbOeA4fO
 aR9bjHN0nPDxoi9b2EoUu6STNIwRpql8XHFee/nGpBoovGY9LUIqTnZJdvrXSCFOVSCQaoY0qdD
 IaGbdVy2gy2L6D7y3xk/R71fuJqwxbuu19xIbSPaFFBJQaFIac70ebgl8ZaQ/1MEIsiZlsVS+d3
 TF9Ck8PtzURPzpNhdhcB+daUmD4FneDE+VlaYZruME1guWiz+qe/tp9giC+FgjOjl8UtxS4HcS4
 vtRrQo+fvu1z/cU=
X-Received: by 2002:a05:7022:48e:b0:128:df3d:cd97 with SMTP id
 a92af1059eb24-12c34f07477mr4736775c88.35.1775955565679; Sat, 11 Apr 2026
 17:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-3-daniel@thingy.jp>
 <f9270d65-c5cd-442c-82aa-b6e6ce96fd9f@kernel-space.org>
In-Reply-To: <f9270d65-c5cd-442c-82aa-b6e6ce96fd9f@kernel-space.org>
From: Daniel Palmer <daniel@thingy.jp>
Date: Sun, 12 Apr 2026 09:59:13 +0900
X-Gm-Features: AQROBzCT7MsLN13zN-xnXDk7dZNzn7QVWJMsxvJ6Ym73UVn6ijG1P5-Bebe19d8
Message-ID: <CAFr9PXmywknpi_ULyYAxcy3yn3kh6wfizejQMtAwgwxe1=hzXQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] m68k: Fix writew(), writel(), readw(), readl()
 endianness for classic m68k
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

Hi Angelo,

On Sun, 12 Apr 2026 at 06:07, Angelo Dureghello <angelo@kernel-space.org> wrote:

> Would M680x0 non-qemu work still with this change ?
> Maybe an #if defined (CONFIG_VIRTIO) && defined(CONFIG_M680x0)
> would be better ?

I think we need this change even for non-virtio. The bug just showed
up because of virtio.
I think this would have shown up if/when PCI support is added. I have
PCI on my Amiga working in Linux so that's not totally impossible. :)

Cheers,

Daniel
