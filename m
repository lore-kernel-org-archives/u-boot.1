Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27942C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E6984A4D;
	Fri,  3 Jul 2026 14:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nn0TGfkF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96357846A4; Fri,  3 Jul 2026 10:06:46 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3244F841F2
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 10:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.bezairie@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-8f032b47e3cso1407506d6.0
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 01:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783066003; cv=none;
 d=google.com; s=arc-20260327;
 b=It5hANDT9lFv2aBKLftte8GqublXn4FcS5gAeTP/tGGGqgd5Im2VkUV4OHBDIA3/rx
 AK6UwXtowCVojLCVpH3r14FdfXMNNKKEiBk0rkTXibRSB8+rdRBtssFq0urgu9ihl46h
 LoINXsrfEUkWCh8U+OhDgiS3XjQXs/F7G9E+HUs8yQwOoGXtHwMHUptnZU6+3H85MeVV
 8TZrW5QksFj/KzHuAKDD7KZ8JakJ/lLFWevsj/9oMlXxzKHG3QjT6G8SNbqJWDsFPfc4
 HgnEkQRTAOGo9xHzmT9LOZb9TQADF3N2MxACPTS10aU6BcC0o0ITVz1CLCijsseSrlgn
 OJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=RhOhWNWtyvKfHPwhDodIu5qi0R6T426wFIxZcj4+HR0=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=RKrVEDY6gaoKY5csRZIDR0G+UziLj2qgR4WsUO/oCYgO6Zd9jAh6n7VsLyKYK7c/nI
 9p8TTlqeRaMOZFAuF0bPDBsjdyEK11Um0z4EI4TCuF41Z9wwghKm5iHhvM4q4ttOcrZE
 cgMIPXmvqxpfQx2MNv08qTedsDFul8hOqjKURH7m6l4d7/a01JcZ4mC/t5xFatUmdBIL
 uHB1RrzsZ0R5E821fbZEuGCwfsxSTUEnc4MhhQW9GhMZIc6C1arzafEYw8/F8c+cYh7G
 C1lQPjzOi5Mmtk00L6vsdA/359v5difwHH5Oxz6kTKqRjMRkbgRJNX62Nau0yZwxh6Do
 YJOw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783066003; x=1783670803; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RhOhWNWtyvKfHPwhDodIu5qi0R6T426wFIxZcj4+HR0=;
 b=nn0TGfkFp+z5jqERo+e8bxny+7ve246+2Dk2fsNsIKH4OfyRknQJc8Gy4Rwhnap37i
 PHHfzTidNhmu7NB/WrUOYUJkPU2hUyHrQeAec9Ed5DcL/6Eu+bc61WjNYm7MWzCvBwSK
 9GLneO7/r5YoVhJEThRVjoC80gdvWb9cSmy5V55gLbwmrRrOuQhitGeReqSG9aTYIC4Q
 S1pmQi7eJk/tcivXxcMEERFIc9dFFA++mZCb0qh+BnUp848k2ppxhtAM9wDCxp97/bH5
 4TSnKf6Ispxdw1axhW7IHXL5fXRua1OGul9T9gjfGUd2YsGa6iQUnHzgxsCD+XVwxaaQ
 FdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783066003; x=1783670803;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RhOhWNWtyvKfHPwhDodIu5qi0R6T426wFIxZcj4+HR0=;
 b=bToa4jhCKmRf74B/t5rmKPczu4Kbj7hYw3mQJzNoD2qCybnShUDRkAmMRQTKqO94wJ
 wHUkmBaTYIizTcjACCPzVzzi/GJPtz2LCz9yKx9R+2myHTXT1WHA2ukZmrxFbpTD2mbf
 gHqxze8L1+VLG/sSDYWvAqWBFuuQ/5Drgxj+rGSblM83IX7/UgOA8xKqtN/+3GHrGoLi
 ZSIKX1Ip1wszwYlWOrbAhNLgVeBIW/PkJ+vCzm0oJHLJjVDTyBhUI3wWsSjh8vFD2Har
 XHOSJg71+F4U1mJEkmzrbnZlh2Hahydz7hpoCNG+HNW+DBTI/m5n90QfRe7E8cyEHx/2
 IOlA==
X-Gm-Message-State: AOJu0YzfgZrcmIalN534IfkZW+7xA857DjKVoSeRT0UrFSFX1OpCRfj9
 fll/9piE29EXa2sTq4adeXIaTQP6b2CxWhgQwW0KRl0zpBR8Y32yzG/3qYkhWdrVFHtnranr8k5
 d7evYLcmUoLuUX9L0vR8nENKeTkhFjjvtgP/gSAY=
X-Gm-Gg: AfdE7cln/xYDCY7wGdmERHkmDv2eDFcrelT4BsKU7E+q2GD2ets3sHYqoqSI85X4qQH
 5Wt4CtFnMaBVWgssbsG5FeAj461NYNgvq7rTwdwj7ICMVvJWiSupx13+YlaTds5EYZ2m2qx/KZ/
 7HI85Z5K9VVR64s/bXOl/hWU3gYKZKyVBrMjmyyjg1aJ9kAjMy7Jy4mk+SY1u4loycxSZmXWiIJ
 bIdwJXF1pcosvB8N6dQyCLgXT8uMQ/1N5U+jrvd29vFUOZvJXf6tedNguAfVwI4E+iXMyJ2KRHm
 CdVwbx98yqcUcSgjVm6nmFJBqHdli8eHyAE0KqWOfqqw/EwCdlRJVEZJKe9YSxeuRgnQF04Qwk0
 =
X-Received: by 2002:a05:622a:4892:b0:50f:ba62:c328 with SMTP id
 d75a77b69052e-51c26a62d43mr126599121cf.22.1783066002850; Fri, 03 Jul 2026
 01:06:42 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?SsOpcsOpbXkgQsOpemFpcmll?= <jeremy.bezairie@gmail.com>
Date: Fri, 3 Jul 2026 08:06:32 +0000
X-Gm-Features: AVVi8CfGOVMCYI7hDJgbDp2UYLQxAcedGVXoW1ld92COZrDqmzl-v0NEf7W0BUo
Message-ID: <CAMdxF8BDNszU-UY9V+_dQq68pZSFu3Z+vUsgkWe8G4rDZMGoZQ@mail.gmail.com>
Subject: Fairphone 5, microSD card support?
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 03 Jul 2026 14:59:42 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

https://catacombing.org/builder , selecting Fairphone 5 then Build Image
brings to
https://gitlab.postmarketos.org/tauchgang/u-boot/-/jobs/1548118/artifacts/raw/binaries/u-boot-fairphone-fp5.img
(it's
not the latest...).

The latest
https://gitlab.postmarketos.org/tauchgang/u-boot/-/jobs/1607429/artifacts/raw/binaries/u-boot-fairphone-fp5.img
,
according to what is displayed on my Fairphone 5, seems not to support the
microSD card, no USB mass storage it, no boot it.

So is it possible to add microSD card support for the Fairphone 5, &/or USB
drive?

I already sent an email at aelin@postmarketos.org (the creator of the link
above, see
https://gitlab.postmarketos.org/tauchgang/u-boot/-/jobs?kind=BUILD ) at
26/6/2026, still no reply...

Also see https://lemmy.world/post/48540597 , since still no reply I tried
also
https://app.element.io/#/room/#main:postmarketos.org/$OicLO7RRqJmGbkqTUUmACaFrH-f8RWHCb47UpEpvsXA
without
success...
