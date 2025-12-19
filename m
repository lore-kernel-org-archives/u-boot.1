Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C43D78770
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 17:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA1D803F5;
	Fri, 19 Dec 2025 18:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CXKy8xqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56024808AF; Fri, 19 Dec 2025 18:47:46 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F3EC80050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 18:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-37b9728a353so25706691fa.0
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 09:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766166464; x=1766771264; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2euWaQf2AaQwNShCxOZ3QoduJLr8RUlhzUrShtfs4ls=;
 b=CXKy8xqfOq7ArVHYe0nFdhGvoEiFVbD4VtMbpsUiHmftFjt06fHsC4iqHLRIWswPJw
 6tUoWdmwdK2xfINZAPoLBYvU3mBGphjpL3nX7Z7P26hr8pUOqAum89r8O/EU07DDA81S
 d2QOhkLkYukcIfFD+r5s2T9a8cPNCERg78eRZnABl6db9MHART41Spu9EkCThLn+vnn7
 vpiGuGwSq8RXrRQ3VwjCnNadd60oWW/SpTIoDAUz6ZKbc3QJ/OcUXJbQ9sxEzvJdvxaF
 E2OD2dsgtBWLMwteTpfYdTdyhNaCfTZVefwre5WPLZXyJtIPAxwQBTWtJafvw57vyT+h
 E7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766166464; x=1766771264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2euWaQf2AaQwNShCxOZ3QoduJLr8RUlhzUrShtfs4ls=;
 b=m0kJxWTQ44d0l1FglnaHAKagP90H/V7oSb/GzOi4D0r6WJEXLUsuHjKSDvZDpl0EmV
 zBH3/5n/1UMcDJOmVFzqTsD1h+kFnAG3S9FNxqCQthx998aSvswhwz4lwaWKzFe+4Vx8
 I9ksaL/aNCZ/pVqYo+Ui/CNCHvlMy+F6lUPQREJq+IvGqy+lt0qzf7MTH4cnbUndaezP
 +M+CzeN1tyVDyksGqvfforyn1ExLYYcy7vi+SQAtGEFZXkQId+vYywvHFG9yFYQimi7j
 o1B4XQpViz8mf/Xh0SCyjxLYT10XsV8zF+fobIrX0jQZyHvaezYaS08blVkoxxB1eGNM
 Z8Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG65rOKvB1OJvYGV5gdyoEYtLtfJc664wj9ZRecMVgIAEwaebQiGjmu2kk0ZZnqunhnwfT/ss=@lists.denx.de
X-Gm-Message-State: AOJu0YzmD2izlbebQoA4Mv1vQFrRguT0keqZEQQ85xLHnvyENSIcgrVX
 22T4S1Nw1OGeBVLsPJiW1BOlAX17zbxTSZs4CP3D1tLSd2GAuKKrKbr6v/VR1y34itQShm+5XzH
 WX1MWlWLqDILWrCnF8J2VFKecAX/UWVo=
X-Gm-Gg: AY/fxX7TbmsAM2TiY6bGzJS0upC1/0toYMHpLGIRvCDiW5wIVySO894GjxC2sPSxrAc
 QsxT3tLAD5dw3yj6Jz0trNpbSAXQaQc1G6VPl/dAC1CMtZAx/3riQmnrYGGXLQ6Rr3F2wtPJjUG
 +AStuIcAbUHVI5sY3l6jfxAXI/J3QTsy/iarI1atOL9NWr5xR4vZcyqPS+nYqwOOec7pYnqjtZW
 1PC5xnkuS9FBe1/cCc67snDNHM9H8hvIejyqwacKvbuQ30AssFwuqpHzaQq0FQ1Ejh7PoHmvAUI
 O4OzS+kn4YdNES8bk00J+jgKYcAl7JAn/gC/cw==
X-Google-Smtp-Source: AGHT+IHHu5AbYHBx8lPOgCh0kMoxpFOgR7ldcPLDyx5YEKaao/7JhwafXyAb6NjjvuO4eDqmBt6rqBg6GLWrpgl0gsE=
X-Received: by 2002:a05:651c:b23:b0:37f:c5ca:b70a with SMTP id
 38308e7fff4ca-381215671e0mr13064111fa.7.1766166463336; Fri, 19 Dec 2025
 09:47:43 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
 <aUTFFpDswwsVYdI0@pie>
In-Reply-To: <aUTFFpDswwsVYdI0@pie>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 19 Dec 2025 14:47:31 -0300
X-Gm-Features: AQt7F2ocJ4kBTte3B4HDMzx8dGTJ90qRGUNDet-weG_QZMGHOUW9FZd17BMqHME
Message-ID: <CAOMZO5B5fp7SMjJw0HLxGPxdVMh+BGbEN_=xsE=VpukLKUMbMg@mail.gmail.com>
Subject: Re: RV1103B: Attempt to upstream
To: Yao Zi <me@ziyao.cc>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, U-Boot-Denx <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, xuhui.lin@rock-chips.com
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

Hi Yao,

On Fri, Dec 19, 2025 at 12:23=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:

> I think the upstreaming process should start from the kernel side,
> then we will have stable devicetree ABI reference to work with, instead
> of creating everything from scratch in U-Boot.
>
> This will also makes it easier to enable OF_UPSTREAM.

I can help upstream the RV1103 device trees in Linux.

However, at this point, I would like some guidance on the RV1103's
boot process with mainline U-Boot.
