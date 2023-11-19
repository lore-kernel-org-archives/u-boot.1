Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AD8C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 21:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2C7871C0;
	Sun, 19 Nov 2023 22:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VAEQGh75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B22DB870E7; Sun, 19 Nov 2023 22:28:33 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33FC5871C0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 22:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-280cd4e6f47so817127a91.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 13:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700429309; x=1701034109; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRTSrhEJOBSSBsAy7XHjIavuiwVONHficOgyEc3wHcM=;
 b=VAEQGh75lIemLKirGfRpCLPPUjErFJrPmeX3lzLsoOy+eRRe8ChwpRIQNpZOx+vRqj
 8vaNwKEcRUPN/I9cmH2lM+z6LUcygQ9PPcdvu3EANra+lwkNGiRymFDIB6kGIczd/blP
 /5IByA471nMXr1bDzfTAmZ9bsNOx5V/kwoi8P6yW9gC1HPmuzIPn6sAeMT6+f1SXPdgW
 IPQrlk0Kxk181SCfeMOdB+v4IXo6nq9xFMArx0Bv82bOhFCf0n7NMcB4UFxfGACKUO1T
 uLuDECfF0LgHDyY8lqXB6AajwJL0P0NDWkhiOno73juwIrPLcls8NIsa0hPuyYyw+p3H
 kzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700429309; x=1701034109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HRTSrhEJOBSSBsAy7XHjIavuiwVONHficOgyEc3wHcM=;
 b=utCAdjNEhRJDtWKnQ4yk93XBydSSLU0zNHKYUVJZj3wuFkQQp8ZG3wAYiLBQ0p2SLy
 Rfto0KDVE54DKMhfaSgJHM8jG7wyNovrxnQQJ1GN0cXHHKHY4dcLNFzWxzpTU2qoH97/
 gwvIgDALFEkmrl22N1yxyIa6c5Jfn+kTG4PUsfgAins3SgFvmdLNIDdvMnmaW4QzR+va
 1AgVky7A8Syxq/dsWhzhrAyVMbW4L/OgcKE/2J5RK25o1fjirb5fADBlFutyZ/oNbLeE
 VAODmK2g9AD8Li+V/7bAtwPEM/BTBbWhxdf23a/R+eCSxcFjY/PFykRemmZdGZNZzh8f
 99kw==
X-Gm-Message-State: AOJu0YxOJnFaDE17Tx+zua/LhR80wd9tUUxc7JvEhhiZdsCT35fHa5wo
 k1YEUbL0Ex4zqthrtBxrvWlMNh9BhVlRpgSSpAA=
X-Google-Smtp-Source: AGHT+IGfwXw4UUYs6sq3sAlS+spWI60A73uc3KMT+2VeFdGZK05cpuF9l/78YEJgA/466uO75P7LbJ6lH2ZUvvBMI7Y=
X-Received: by 2002:a17:90b:198f:b0:283:2fc3:b8ad with SMTP id
 mv15-20020a17090b198f00b002832fc3b8admr5732209pjb.2.1700429309074; Sun, 19
 Nov 2023 13:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20231107221617.470-1-egyszeregy@freemail.hu>
 <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
 <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
In-Reply-To: <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 19 Nov 2023 18:28:16 -0300
Message-ID: <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
To: =?UTF-8?B?U3rFkWtlIEvDoWxtw6FuIEJlbmphbWlu?= <egyszeregy@freemail.hu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
 "sbabic@denx.de" <sbabic@denx.de>
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

Hi Benjamin,

[Please do not top-post]

On Sun, Nov 19, 2023 at 6:08=E2=80=AFPM Sz=C5=91ke K=C3=A1lm=C3=A1n Benjami=
n
<egyszeregy@freemail.hu> wrote:

> (void)(devno); is need because devno arguments is an unused variable, nee=
d to use this solution to suppress any potential warnings.

No, devno is a function parameter. There is no warning if
'(void)(devno)' is removed.
