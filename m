Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A39C48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 17:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A2187F7E;
	Mon, 19 Feb 2024 18:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tovebpdi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F0F87F74; Mon, 19 Feb 2024 18:27:54 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FAE387F65
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 18:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-29593a27fcaso1309347a91.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 09:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708363626; x=1708968426; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAxmpF1S7LxpuiBk3M9A7IENHBURx/RlBvzIE2k5rdA=;
 b=TovebpdiXJyqTuIklJq0+jMuml6DH8XhuZ099y0qpNHc4Dlt2OQz3eUzkZaVD8asYE
 WfggdUvTbPP1xS1kxI8M+JIceV8yDumHp6cN85fj7YMJLD67wmzb68MwbbD6OpzB3VKi
 z9TRojVG9kDAstUe19iVffLbKzD6CcVrxBOGxmdxB06HrpRt+kz/nRe+301ERM2MfTIb
 RC7VNJyJA1cdlP5NmwguXDpQFoP8tk3sTU8w+lbTzslCtbYkX6VuKQ6WB+wvbp4tLZuH
 SfSEJliZgI4Jmj3KApVXKFFtixK+jNeGJi1HYXNsxDHa84RwoCijfdl60l3FyQui46VB
 dpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708363626; x=1708968426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAxmpF1S7LxpuiBk3M9A7IENHBURx/RlBvzIE2k5rdA=;
 b=Lt9F8QxViGTVM12AB96don4FP5UJ+BORcZ7XogCigIXJ6LiBepFsln8nDO5gAwDPiW
 ySKjVaBagxXYLzJUwG8RXTAvmr90x9Tsdphkx3VPbiVq236zwHVMeF4gMAzMfueywm6e
 tP/HJLNny92EOZ62X0mEHBzbW5y9G0BC8bMdS3GNjeaAyAsjw5FMqQlruFf0t0B4Ho/o
 CPJS5B1zg86tucxxOg7lEh3xOYO364V8zQNBZkl0+qLw8q8us51SWrQ9ez/+ckvxW/5g
 KN2/Qf7x50xixogzT2yCJ5yfMHpTVOJc0muX23Nd4oxi3PwQ8OYAsFMzA1+EKRPMSgPF
 cKFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVWY1McTWFjA+dF4FRuPPl2+oUohGFFgoNYoDtxXqDhl2Rr70RYBAiZZmyhR+2M8jGCwrMJgGzI37XcG0OP1uwuav0AA==
X-Gm-Message-State: AOJu0YwabpSiDEEI5om0oI+XShIsIVFiHuzZzgQa5JDQIpjPpekhxiau
 wFjYSFVyITYZOpXBuyH6BovOs/k0wbf5CDlsaZivXUxQRyAVpWqU4vpY97YSUSxPX7xy8F1XWeV
 b4gt602WWxQzScFbOz98CVXYiEn4=
X-Google-Smtp-Source: AGHT+IFLk+p0VR5v/2twf1gnNdDEF5k73FJp6obbNJ8XyF4CHMsq0w5ht/6+f162aVBqGgztbapA7P3kB+gxOvV5WHk=
X-Received: by 2002:a17:90b:116:b0:299:4a1:ca9a with SMTP id
 p22-20020a17090b011600b0029904a1ca9amr10444690pjz.0.1708363625825; Mon, 19
 Feb 2024 09:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20240219170531.14959-1-othacehe@gnu.org>
In-Reply-To: <20240219170531.14959-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Feb 2024 14:26:55 -0300
Message-ID: <CAOMZO5COoMMY6gVc1Bpw2iGLeFtmrhE_G=rTzD7Zsj5i6PBipw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: ehci-mx6: Add i.MX93 support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>,
 u-boot@lists.denx.de
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

On Mon, Feb 19, 2024 at 2:05=E2=80=AFPM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> i.MX93 uses the same USB IP as i.MX8MM. It can then reuse the ehci-mx6
> driver.
>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

I assume you will add USB support to some i.MX93 boards later.
