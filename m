Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DCBCDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2C984894;
	Thu, 25 Jun 2026 17:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="icfIe7FB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C0B8495B; Thu, 25 Jun 2026 17:24:32 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F448460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c0c15bd6b8fso342841466b.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401070; cv=none;
 d=google.com; s=arc-20260327;
 b=BNtZTJTIRZmBVsHrTJiT5iuZMDDb7zZhXYjizBW055ghVNbnzLypwhIu2w0e5iQJiY
 3nVxbQ6taQ+bWUzsLbAPHY9RaJdBdTiuu7KWOzq91Pko8owSTQiHSRtO34p8tEkBhuRw
 tDeEPecUQWhwWYAKwGlX0A1KqJWr54rlvFou5gm0tgCK1zjnzCFMtyKzPgzzUcgPeMJy
 WRzkwpqqdzYYFId9eN7djOhPuoo2VJBaKCOoBHAJXd5YxO19fuDPKfKwzKVuDuPkQzuh
 p/YM3VnsusJrAuZ4FAgbTUWan8kjVQE6lcL+DqOG4nn83JVXo9moIIqYyqhUhwzqA3ks
 SkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1HMD5Ts5bNbOvwi+cNPJwYDXSm58h5P6NffGkI1XTBk=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=fhAWjt6t9OmwH79NUDTOx9QYX909Itj9dEVMFfUj8Vi5ggenBTNYwfY3qm6JoaSZAg
 +NJX1JostGGbHGekgWFANQjfoIm6ALR9ix7wGE+sKyPB52O48pOPzbi+iQcyWpL3M+5F
 jM9F0yfsZ98gMc55eK0KkgXag4AU3gL/tFIH+qaGzzM+zwGLYZ++jbyUfx739e+jLNbX
 OQkjck2290y9xeVj7/a9eSCOsnIeuFbNPAHXK0RA3pFKCZdWqWUKv+BMvuiUKe5ipU1H
 Bu6xGZQJTpW5xJKQxfOCPC7moCfRmLSxpDkiL405LBafdN0FldRrawp+ms/Y6XzVs8JZ
 DLWQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782401070; x=1783005870; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1HMD5Ts5bNbOvwi+cNPJwYDXSm58h5P6NffGkI1XTBk=;
 b=icfIe7FBMdqajPrSSClEyWVVvHzIkLSQO/vs0/eNomAyUM+ogpnphkjqrg/EgBM+UB
 btBE+t49uEk43g4rbFkEe78AL9lZ3cS8WOjsNzytSQIxQUwLeeFfa2eGuFWUAdneViTx
 6lwJcJJ5DkcvslkDGIYqyZFUidAPXwJ3wLgsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401070; x=1783005870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HMD5Ts5bNbOvwi+cNPJwYDXSm58h5P6NffGkI1XTBk=;
 b=o78FGIGVKt9JDcN3SBT4NUpuOmHcNIV2WEuH4zI+G/G538deoMXzMhx2KWssod2SAr
 LDlE+kscFRl8ChKDmhsBE2onrfjPcEr61yw/vcIwdIgwZxvLPMA+uyMOMIJFIWWNu1qZ
 +hfP3gxr3MBGour+ryYhdjiwcH0+TcSct0cICKjsc8OFyZQzx8AyDd70lVr9fOBwWdD9
 KRI5vHsegm5hU89jyfYk9RprvMpzEIIb+luS6BI1T4sVStteWXya8aAc2whrndOGdmVS
 ykMEPbMfSnsaoTPd8I7aEgtzIQxGJQw4GXDzrmtRRCx/lCxlRs4Kqv/uXtKLtNx7cjuq
 3O0A==
X-Gm-Message-State: AOJu0YyIXxymIk2mGTZZjdcc58SenbnISp53e0cNOIW1oxnllaMkh96Z
 RvsVwTIkf8dexuKFVoAbDoQmFqGvsj+HolLEwHa3V4VcgYsAh4HvYD5MLSPiDkNBluFR0RAesue
 D5KDkR00ImzwkPQhPlnb3Bh+EKWw3ZV5C2t8zPyPCqKphps8Mj5H4cWlA
X-Gm-Gg: AfdE7cmOtbW9zSN0WKeklv4BNrTUY8XJRNPgdCtX/sIGOLJiqwb4sK2n890rtGlrwGt
 FNhoB1KBE+Sena9w5feJF7yZb5kQ6/ATltb/GsE/wvz4na4pkF+oIq3Ykr+oHWfdtrW3MZBLc1X
 2abGnFEWBsCGwAIDtmTpis7wh3DG9DKVGRT0lrQ9/JVT7cv70Ci3mdNQQQHCZHLrAHJp82niy/M
 NTLM3efYWPXned9sdpXymiGxlM8HZy4r1/PC7BVkjiC6Dt/L54AfG1GQi4lomsUvceZ+2EMZA==
X-Received: by 2002:a17:906:c14a:b0:bed:17a8:4ca8 with SMTP id
 a640c23a62f3a-c1205eb8577mr229653766b.32.1782401070268; Thu, 25 Jun 2026
 08:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260623220630.2828767-1-dmukhin@ford.com>
 <20260623220630.2828767-3-dmukhin@ford.com>
In-Reply-To: <20260623220630.2828767-3-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 16:24:17 +0100
X-Gm-Features: AVVi8Cc09hXAlMv90uxi-VBpdu4apk6_f6huZS4TCjh2mL8asUZUjgLwaJE1c2c
Message-ID: <CAFLszTg2iCKN1GTBj4NpDon4U+2g3x-0hOz=oAmy56fms_Btuw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] test: bootdev: scan with a broken high-priority
 device
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-06-23T22:06:29, None <dmukhin@ford.com> wrote:
> test: bootdev: scan with a broken high-priority device
>
> Add bootdev_hunt_fallthrough() test to verify that 'bootflow scan -l'
> falls back to a lower-priority bootdev when a higher-priority hunter
> fails.
>
> Introduce a simple 'sandbox-bootdev' device for the test. The new
> bootdev can be configured to produce an error at the hunting stage.
>
> Introduce new host_set_flags_by_label() API and a flags field to
> 'host_sb_plat' to simulate a bootdev hunter failure for the test.
>
> Adjust boot{dev,flow} tests which depend on bootdev hunters.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/block/Makefile          |  2 +-
>  drivers/block/host-uclass.c     | 15 +++++++++
>  drivers/block/sandbox-bootdev.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  include/sandbox_host.h          | 18 ++++++++++
>  test/boot/bootdev.c             | 23 ++++++-------
>  test/boot/bootflow.c            | 47 ++++++++++++++++++++++++++
>  test/boot/bootstd_common.h      |  5 ++-
>  7 files changed, 170 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
