Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FFB109B467
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 13:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B31D84073;
	Tue, 31 Mar 2026 15:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="B7VdfhhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF3B84011; Tue, 31 Mar 2026 15:01:19 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 585E983A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 15:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jimmy.ho@sifive.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46708149af2so3231847b6e.0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 06:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774962076; cv=none;
 d=google.com; s=arc-20240605;
 b=ba5Q7GkPhywGXzr/4cWDzjKY5xs/vMQmPHwOJ/IBjMG0//WDVWSdVuXo2BcudfkBRP
 uvM2w2l18YLLzpX8hT0e5xJYGu0YXy0G7LzUCZgBLV9ut3QeeggeVmZVvfIQkJ4D6nXE
 u+ySTi6+eo3uNTd0HOjeWRztoVvHyQ8Kc8BvYkKs+HQXeZEakC7Y/DorSoyh1lgBjpIO
 eE/ZsmrKdPHZoPAzPQaCbC9unGCeG49AwguvXzJ0z9nE7peKveyxWbHqeMngNYmY6mPX
 tOFF7a0iRdGcqJBAasZb6BkPJBL07Rn8FQDnHXhV4yBgTp6Qav0CF62d1Vkykh1dUYRR
 pqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dVST5uMheWxMw8Coninb63X5eh+KXVwP+rKC9ThKQjc=;
 fh=U2Z2AAf+0KFq4rU93U2jM/ZGAPn6fMbRi+4UqR11gtw=;
 b=jOsQuaLq10ZtYdgwHZCOY+ohNUUadX865hGu03jEbtmZlD+gQFUYUiSZ/xwPDst63S
 K7JfoNqPgZLEILtt4OpU36g2FBKypUMAqb4Xvhm9UonoOWbwvYO+x0v4V6wwEjsgwlhA
 WuR0oO6n8c44oa9jTGIm/6g3sGx5sSWWmQGrTMvkd/Crbi1bn+2BXSCBy+QlbAmiV3/P
 hCwyko0xP/kJiNPOK6tBLFsbXc+59h2FrUPLFQvAgUvIXzcAxyJlOKzLfhovW69Scqt8
 K14/zkJYuI/5+OVQ7yTYJN0wtDEPT345iqzdA1SJbzn+uJuBnhuO+cKoNXeSIzL7J3Gr
 H8VA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1774962076; x=1775566876; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVST5uMheWxMw8Coninb63X5eh+KXVwP+rKC9ThKQjc=;
 b=B7VdfhhVT+lFnweuji/OUlO2hQnPJU7ofUKrVXML7YoM4X2O22wkGSazWq7MAMVQB3
 mighchKH+jMcZRQKeITjN2W5mH6/yxn/p9e2qSxmhecC1uVo+oi/LBZ6doLvdIqS4y9z
 bKbdgEwYU7hwtSHQh3cBnAefJKgDcKTEsgtc4nqg2IiyvYjuMCYkxEcUOcutJdEHhCUD
 LvzXiO9S5/TGLxeA3INCN+RNJFrxXOBt5mOpOlosZOJCNXtj0+v8QE09gVBIvHOr8+jb
 kJfY5wY9q42eileEqxqUKm21X6UWxusyXZZglcUG4uNLg/hTHema7R2HsTeeL3S0z0yo
 9lIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962076; x=1775566876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dVST5uMheWxMw8Coninb63X5eh+KXVwP+rKC9ThKQjc=;
 b=Tnaqala0qFIWjlJVTm3z0JOOD8b8g5mZjWNwMCIJpIhqfsZkmOvSGHgM99EXzc9KVh
 3C1HKqBjiuCBPCkax54Vpa5AI/Ay99AMI132nZJKErqN0CWWYq79DTE4970reKy8VLUT
 c9anInDcDW2AeRXzGlHQebRYyYZv+c5Xpk6rcwEM8J2z2Ai8O4hzPM+XC6A67VDxgyyP
 vxs7lmH9NQ/5wWGcNmHWaLe/g/K32KqzFE4VfGwI+CZwD++b9/2L81lvN5+X3rzbNaEW
 /syS47LvAdQV03wiMrL2saXFGa9tZqlCzwvojngBxAdMsaqPcDEsf7YjkVwzfqIluD3Z
 Aoyw==
X-Gm-Message-State: AOJu0YyzBQN13LuDSjo3cQQrkTeyKQcl5Ozx3ku9D6xfGxDPK2Y5oEH9
 xKsr7YA011f/KV+ethF85r9bPD5e2CyyivhjxFnmgL2PoVokFWESiUhKU+nYAclkj8LMwLeT7nD
 UBc7Vva2YBUPNeWjMjMP+L7Lx26Ntre9QxScC3R48dw==
X-Gm-Gg: ATEYQzy+wi9XkZoPiBt3SaydZEQyjqcZhIa/FvnjsSVd2YAIOrm3lMP/Kb5uluwGLj1
 nKLUWj/xZMBvx5sS0A3POmAoryRi0oMyizI4qH4mCGtsd0KMAJLCT9rf/7LrlbHTKr5PJnkOov4
 rUgnelaO1G4ADVDtmt5Y4hspQjZS2Mrjeh2Lu+yDL/fdmtFZdfLwUYbG9EKRh+YRbWF+DTTfgGr
 +JThv7zFHHtSjIBMuUKqnDWfyqeU9C75VYatOU4xT09uhp2v/2wtR5YgvcDOwZXCICTuu4Gk7nP
 pEc7GwqkLg==
X-Received: by 2002:a05:6808:c2d1:b0:44d:9dc2:2be5 with SMTP id
 5614622812f47-46a8a437609mr7402303b6e.21.1774962074431; Tue, 31 Mar 2026
 06:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260119055523.13460-1-jimmy.ho@sifive.com>
 <aYnCoctRzE-DZyuT@swlinux02>
In-Reply-To: <aYnCoctRzE-DZyuT@swlinux02>
From: Jimmy Ho <jimmy.ho@sifive.com>
Date: Tue, 31 Mar 2026 21:01:02 +0800
X-Gm-Features: AQROBzDHw4yBmhQ1z3iZB4oiFqk-xbLV3rvuZRf10_AhVvpG1hRZvGWN0SEPqP0
Message-ID: <CAJh9TSJpyDKezRZ0wEkjb-GEPkiAS1zOGfqm0mY2dzdhXZDf+A@mail.gmail.com>
Subject: Re: [PATCH] driver: cache: Remove SiFive PL2 driver
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, greentime.hu@sifive.com, nick.hu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 31 Mar 2026 15:08:26 +0200
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

just a friendly ping to see if this can be merged

Best regards, jimmy ho

On Mon, Feb 9, 2026 at 7:19=E2=80=AFPM Leo Liang <ycliang@andestech.com> wr=
ote:
>
> On Mon, Jan 19, 2026 at 01:55:23PM +0800, Jimmy Ho wrote:
> > From: Nick Hu <nick.hu@sifive.com>
> >
> > Under single core boot platform, the secondary cores won't enter the
> > u-boot spl. Therefore we move the pl2 driver from u-boot to the Opensbi=
.
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
> > ---
> >  arch/riscv/lib/sifive_cache.c | 3 ---
> >  drivers/cache/Kconfig         | 6 ------
> >  drivers/cache/Makefile        | 1 -
> >  3 files changed, 10 deletions(-)
>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
