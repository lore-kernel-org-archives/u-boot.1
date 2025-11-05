Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C61CCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CC8839D6;
	Wed,  5 Nov 2025 01:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSJlTJP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3E96839DD; Wed,  5 Nov 2025 01:45:16 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA55983981
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7864cef1976so6643777b3.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 16:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762303513; x=1762908313; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8+FwRTWr/Rc1uw5ljfjw9+wCp6iufXOgmBG0z7X+dk=;
 b=cSJlTJP/b64GapU1/2GyBiSiBkXRxFXrUVP3IPjBHsrSX9nWTqMaOnkRPvzkW358lB
 oQo5yJgr8Gzcaz6GF22NXJwC2kT54WHLydZcj29oQ70SgS6s1gf2N58qVeeqwlWJp+tp
 tOhqzMZO41egGS79q2ZZkfjg3t/r0NPTFYuNiMTEL5OymhMUmzxB+O4gwHE0fQWrOVGx
 8s09ng14XCB43xFWgt3bMGPzrKw46nc3LTk9oq9DyTnoQigQdzL2OWBzWuXqhpsAg7mJ
 iwJgEPmDmRo0zkOOxqTnWRIx83j3nYF6vykQpsNgJA6nTu3Ut2b/XXTMLRzP7EbP+rxD
 qWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762303513; x=1762908313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8+FwRTWr/Rc1uw5ljfjw9+wCp6iufXOgmBG0z7X+dk=;
 b=f+mOMBeCgyhdB72ETSH05XzeaQG7+Mhl+08twGA6XKTS67nZ0vluYAzX5z3eSvpTAe
 RF+GSzXBJXKPH0ksQecHdLIJtGQfuAK8unWQn1bncIZve5HsGJCSaMgFf4fn3ZhkKXB1
 S01jXvuZslD2jXk9U5QhYuOPpChmCMG2uNK1qmz6VROK6ry+RXm+ytzVU5nEEG4QUSSJ
 bcANNn04c/dQiksVoaUGDx9dS5C8o5RAud7SOv7VHk2S2qfHN2GWLhDtdG0x+HX7RilK
 UdSCkFURVYFQlLkMwNL7jxKV7zEuqNy4dT7HcAoKbY4MS4UidXMIdMyXqCmvk8IoEEg8
 Tu4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHP0J+CK/3mzydoTQVL2/ajFVR2+4YEEh97LiEl4ZH9IL+wcwImzV+nxQSwQBr5xAsQ0skMxY=@lists.denx.de
X-Gm-Message-State: AOJu0YyzzbwRUHMyPpG7fBGaTbIuWmLgfWC7m8SxoaZOvMSsJizC5bz6
 a1W5rxg68FX5BUG3gpI9Y8KF70AKKzysiM+IvJP7K5qgpn0QSTSSuRZpiSCO2gg/woLur1JLmYr
 Z00O7u1if8IVHzpgm2cO3LBJFkX/70tk=
X-Gm-Gg: ASbGnctsSzibTeR61W2fUiqlPmK6rbERpay0nlu6KSUhC4/P3nFE5AJWddtTlPMlu8I
 poNuNYA0OuYH0q6pJDykIgeJV7NvzZidjps9IqTHQR39o4gWzBFHYYQka4Pr6Dw4cB5FIpot+cR
 d/dxWUq7ZXRV/vqaCiT5GSXSHbq6wjiWW6rk7OpJI+uYsPJvXW9eBoK/K5GbzpKtsB4qUBjtfNy
 XXz4r2qAoBUsahRHDuY+VT0zr4d0nOdpmsnhRlb9tJejZGZ5aClPvDsTd4A
X-Google-Smtp-Source: AGHT+IGgTtBtsUb/JwLTjkE9uMW8Ji9my6AC24HxaRlHQBTI3pqjNkxOE7KVanz/Kfv6i5I1IRJOf3RsauesiY1VKlc=
X-Received: by 2002:a05:690e:4005:b0:63e:3546:6fc5 with SMTP id
 956f58d0204a3-63fc76ab56amr5076893d50.32.1762303513511; Tue, 04 Nov 2025
 16:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20251105001351.92457-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251105001351.92457-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 08:45:02 +0800
X-Gm-Features: AWmQ_bmEA5htxPzbqdQgpsSv7F6etaXh8vBu66B2X-MOJyWs0vODU5-itAtwPbU
Message-ID: <CAEUhbmXSt+CTcKK0E_Fxgoh9PF6Lns3nxV2W_5b1MTpn=BCjTQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] spl: mmc: avoid including errno.h twice
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>, 
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Nov 5, 2025 at 8:14=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Each include should only be included once.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/spl/spl_mmc.c | 1 -
>  1 file changed, 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
