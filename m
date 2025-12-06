Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AF5D3B7DB
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 20:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC9A683984;
	Sat,  6 Dec 2025 21:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bbU1A9jn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C25839F1; Sat,  6 Dec 2025 21:03:30 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9BF683957
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 21:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5957e017378so4203752e87.3
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 12:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765051408; x=1765656208; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fB5BL+wMcqZgXPIpcqyS2Pte2agWpRE8Sd9SKwUce+c=;
 b=bbU1A9jnUA8eiEvC89ZBZ1+vTh2nYuAix3GWky842x88jkvacvrxopeJRtRhtBo9ke
 G7b9rrPr8Qz4fAkiSftqJoB42GoVJc9tK3L+aOR1MYdsXwWgNx7DaItBWyQsLrZ2vLr4
 Bd2Kwa8YPD/v293pehHzfUcaLpz5dENt3bO/hk4DrKQTalcBQQCliYXu5qy89vmEDovE
 T31imhw8WLPYJzZ7XvH5voYVqsyo06ShnrUQfWI3xOj6rbrqHaRw5cf4t26aoHyQHGFn
 PuGRUeSsZAJxmsfSONgmLdNDTcaMQI+EiRUhLxQ1ia2F7A+ALqwB3CJbki4I9TxLWimP
 ngGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765051408; x=1765656208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fB5BL+wMcqZgXPIpcqyS2Pte2agWpRE8Sd9SKwUce+c=;
 b=X07ve9pQnwRgjygaEeKNwTn0v1aoW2JJt6uJaYZ3JzZ90/G8b5nW5wIT6NteRaMRCa
 cgHv9JrvMFzoLteEMR6gZmNsbPadzcEXfU9TxmaJAavrfBMXWkIOgr0a15ZAuQkv0ml0
 cVqXYhkHuL/Z/42TWm+ruTHYKU1DZQvAyCkbsvOEthquw0FmRsgO7k1LQAypjqiE+Mtf
 23T9ym6hZq+ER/poYF+iq1ANsU8/LqrmyVjONHtuO2EL1xBTdSOekZ3vmUh1NTg+vBD+
 MMdbL0/qGft+/4taA+N7zBHnpkV1H36R1Qbfp+ImkT7nTw+8S1ahSecsDyELMq9w1d36
 5pYQ==
X-Gm-Message-State: AOJu0Yxz9ps8ii5Cr8oRkt5YPRxrBkLhiKFeFw/255p63Exy39TEzM/f
 W/Xu7G3Hpl3hZBp+KjuAB30Xpshi4wCAmtY/UsRE+IL9JEJQDotS3qucLnu0VNXWn8ekfCuu4tG
 6/BGsN9SokAcSQLgreQIRYih0WwF+atsxs2uc
X-Gm-Gg: ASbGncv0ESLwjAvnQYCEVmB39kWW7MOPLHkh+zej0sqltsNi2++eGKzaXWh0ItsjmNM
 utx+N0acBy4Yv3YZlZ+mCqxY86ozsWTl4IT2TqRxPUxyGCnsn+j0hMF3VdyWhEJAhun1u+GWgsT
 Jv5+7XMEIUqAPKccfs915+ScLSc8w3zLa5N8lCaiDyjaUuEli+4LFNRARDqQoBaUMCWyki7gRTn
 u0fiLi6v0CWtLYe6+cVhNfGbFsH/vSr3qOeGgCaiS1JxW2eJD1R+6jAHlE0P8VjJMGB+xadryeM
 LHOvNGU2D9tMwckXJ94W39ZFvK1KRSIEVIsVgw==
X-Google-Smtp-Source: AGHT+IFw4Z8+r85eLYWHPLo9LXNnD9dA31v6erWm+xSu/tadxYQrsLf8fmAjCmuoOXQ1tZST4lS+cRVfZ95ukKN9oyE=
X-Received: by 2002:ac2:4f03:0:b0:595:83f5:c33e with SMTP id
 2adb3069b0e04-598754a59c3mr759971e87.11.1765051407899; Sat, 06 Dec 2025
 12:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20251127172920.39740-1-jeremie.dautheribes@bootlin.com>
In-Reply-To: <20251127172920.39740-1-jeremie.dautheribes@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Dec 2025 17:03:15 -0300
X-Gm-Features: AQt7F2oHDKD-OkoBa399AILsOCYfIpp1P4aRnPFZaUm3coyaR1J0ii-ObE1FbD4
Message-ID: <CAOMZO5BEBLz9KEWOQ5M6YodJUeGYY9stMfrHaa+66p27C7Cdgg@mail.gmail.com>
Subject: Re: [PATCH 0/2] nxp-imx93image etype for the imx93
To: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?= <jeremie.dautheribes@bootlin.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 uboot-imx@nxp.com, 
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>, Wahid Essid <wahid.essid@se.com>
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

On Thu, Nov 27, 2025 at 2:29=E2=80=AFPM J=C3=A9r=C3=A9mie Dautheribes
<jeremie.dautheribes@bootlin.com> wrote:
>
> From: "J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric)" <jeremie.dauth=
eribes@bootlin.com>
>
> Hi all,
>
> This patch prepares for integrating the automatic secure boot signing
> procedure into the i.MX93 platform, similar to what was done for the i.MX=
8MP.

Applied to u-boot-imx/next, thanks.
