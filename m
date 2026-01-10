Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3723FD277C9
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 02:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89848843E6;
	Sat, 10 Jan 2026 03:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hlk3xCcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC46784405; Sat, 10 Jan 2026 03:17:26 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCC9784390
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 03:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79045634f45so54845627b3.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 18:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768011443; x=1768616243; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlCIqBET37854OcL3TKd5Yg1NcEKNEUVKrRjmg2XHSQ=;
 b=Hlk3xCcUIrr/SLY5pZjnBLnYuIqtTUtbg2y1g19gxTxn61kx6P0Pqch+d4jtawfx8p
 dAN+jlqp2FrVBN+Rt+IZfz1eSREtAiaZTKLG7++GPDA+hXJYfVAQ1Iix/5HHlcjccBlT
 TR7sgNn2P1LHgWV0P+cDIzJEVsRMaFU8e4spG62kh3hWGCfBJ1KsROU4ngB/hJDRgZPe
 UPQIseTBPAq8L1ZD2KIB/GebtOAz1EDGJFwnxw6UE+GbTX7sGxMuSsrG2Uggrp0w8Cbd
 ZRxGa7EUvDtsO9SGJFPodv9HQ62ZXCqzFsTbzq8c3mxkAiIAP7QoegI3hRV8OLIYt/a9
 2Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768011443; x=1768616243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xlCIqBET37854OcL3TKd5Yg1NcEKNEUVKrRjmg2XHSQ=;
 b=YqXTGVk9lcsX0f/PdujDkuEBNQWQ0fSksA0Z4DpojofBUXGydQOkoeQuR2laqzIANE
 Lscx/ApTfAkQ1rS2+sRwhQM6s1InhQptBLwhnE+9TotZF7aSb8gSGG26KiaJfKRksrYA
 nkWyl3+JY6qf/6zroph34u+x74oGNWpU0khefgFrE6UhG/0VkRHrCdrNs2lXCpLbW0oD
 AOlAQKo2fdr+prdpnOfWVeA1tL1JvQp6XTzy84RtoRp7sSgoo23Vslgv8Xnp6yBxtLwz
 EC/rBRdwe2e8bocjErHutbxnaFdK9TUx37kHGu2NYf/1gGA6dWxIv+zrcpLcALHI1kFZ
 6Iog==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7ZaqarO2bE4Yvfcr/NTPoj56ak46LQoKpsyEO78fXZPQM2WKV7MFGVLGzAGDcDWsPxBEGg6w=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2k3OnB+LhOpVKJC7nNn90YNP2j0Bp8jjbuFpxhfLnGPF7TzE0
 y+Nw7cAnyGtHvvB5+wszzxm9ueB0tCKXefyUqnCPdI2fzmyE7QwOVhCzTQpoJm0bp4yB5i1FOAl
 wtOO9qxi8uN0JpDx2SWJadhQGKK3qVmMMWA==
X-Gm-Gg: AY/fxX5kDTJKAJNZZ7ew2wwtWUZwMO3sSVG3jSf65rTgNFuOEB2jA3iJxi6kZMBFzjI
 HZjcRZYpxyRpNCZMghyy3Arc3Fq8R1kQ2YWW5otrsc2Gs4FNCzRebn7hTtLqkbD31oFZIesqpeN
 NPHnYUuHZfXPfnmX35WTrYpdYmCbW050SYs0ruh1BKJqlMUzUv2Hgd2Qj52Iv3tqsRVmm4cyjiS
 5BAuXVbiwqDgZu5G6bsDx96MrDiUJH/FwfilL4LhAABIjzjsvtHp+n+6xrtiObo0tyCCmkr8oZl
 SzzNMJmgJPU2/YHnH+Rve/oZEg==
X-Google-Smtp-Source: AGHT+IH76OAuMlXCxRL5GB0BzXgVzNYJaNYlsA+poxWPNoPh6q8W1qiMgQaioWIG85vRZVE5LKt89EwxrFlRwyzot9U=
X-Received: by 2002:a05:690e:1404:b0:644:fc4b:6fad with SMTP id
 956f58d0204a3-64716c1979fmr10594677d50.58.1768011443253; Fri, 09 Jan 2026
 18:17:23 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5B0HmoyCtHHuOFjTq8n1HRoHxZ0-c-mJ_2e6JoT2heSBA@mail.gmail.com>
 <bf3a7773-8b66-478d-b45b-f032cf93347e@cherry.de>
In-Reply-To: <bf3a7773-8b66-478d-b45b-f032cf93347e@cherry.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 9 Jan 2026 23:17:10 -0300
X-Gm-Features: AQt7F2rl80yQMH1BaFNLd06alaJGixcs2anpvaj2E2y0o0ztpkYm7uVqSGJWJMY
Message-ID: <CAOMZO5D8hbaUqVMJ2hCgSsCDDUhn9-ACux7Da=bKzELehApf1w@mail.gmail.com>
Subject: Re: RV1103B: Attempt to upstream
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 U-Boot-Denx <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 xuhui.lin@rock-chips.com
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

Hi Quentin,

On Thu, Jan 8, 2026 at 1:33=E2=80=AFPM Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:

> Do you actually use the same SPL blob as in the v2017.09 image? Do you
> see something on UART on that image?

Thanks for your reply.

The board boots with mainline U-Boot now.

I will submit the patches to the list soon.

Thanks
