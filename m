Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B410C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DEAA87A71;
	Mon,  8 Jan 2024 01:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A6PdRBf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D0687A42; Mon,  8 Jan 2024 01:16:17 +0100 (CET)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFC0E87A35
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-67f85fe5632so18610206d6.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672972; x=1705277772; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22458RKHJZnMCEn4MIJoGHgaQqGcxGa1iipkzwTVP3A=;
 b=A6PdRBf+BsRFQSaIpYSYiCmrm9u3oXqzC30aMbZsVyYfgT5TiYfajG+luuZRXYXCBc
 +KK8O99YYpxeQmmWutG2R0SMwQ9e/tzhBr5E2SUHmpQKxoEoJwlBo+q7B7lgvtSj7eWf
 pJuYLRU4FRE0bcVYLYxh5bpfb3HJ4BGQ1UfdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672972; x=1705277772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22458RKHJZnMCEn4MIJoGHgaQqGcxGa1iipkzwTVP3A=;
 b=jn926c/+6i/ZDnGnYWeuMQhYL/P8x3pja7W5nAstYRhBhvyjbkp6Qkvezoj+mB5Q5r
 3a/PgJMomtCIBA9d34rUUSObu12BLiL6KyKquoUntOKrrRmaolM6uc12yQhuqHnYgkxJ
 KGwevrWqlfxwKyEclAUcmHH49PmNPQCd+W05uQQQl9iO4Um0Sd5TkR0ZAp322UF8YOfw
 ZZLAH5sUZvPukYapdkPi7GSHn2CkZ/6r66KvHENm3p3bQF6mUDS04TMw5MBwfalo/jt6
 /AWjvpX84+qQiHXZ+0zgac5hs43IOsTwehAock6Ly8+Mdn50ojnsE+lwZazD13f/I16C
 rMGg==
X-Gm-Message-State: AOJu0Yx115VKLk4WnKbdPYM8DUSh9SrJyPEV+KHEAN4CnAnPf7Kkiv0g
 zk2AlqQBItzKGTcpKmvACj1LnoLy62Ur8bJK3ySJXjqrKp7v
X-Google-Smtp-Source: AGHT+IHyVhN8ZvnzPE2VbvZUA+vnKwacGkJk3Z1hVUONl//00Fc0XRXcGR7y8Ne7cGE7O/ZSMth83E4og6tSM5nAomI=
X-Received: by 2002:ad4:4eaf:0:b0:681:35b:ff6f with SMTP id
 ed15-20020ad44eaf000000b00681035bff6fmr1882507qvb.29.1704672972615; Sun, 07
 Jan 2024 16:16:12 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:12 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CALeDE9NxUh1rK9TFQEXLd41hdEs0p3e-kpJdY4ZFyJb_asKHzA@mail.gmail.com>
References: <CALeDE9NxUh1rK9TFQEXLd41hdEs0p3e-kpJdY4ZFyJb_asKHzA@mail.gmail.com>
 <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-9-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:12 -0600
X-Google-Sender-Auth: ydUZ56mXHpyVFiKXSjd6P0v556U
Message-ID: <CAFLszTiuWZX+d98e_KCHsbkkx-k5jHs1a7GxnxN4Le-HJ384GQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] smbios: Drop support for SMBIOS2 tables
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
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

On Sun, Dec 31, 2023 at 3:26=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> These tables are a pain since there is no way to handle memory above
> 4GB. Use SMBIOS3 always.
>
> This should hopefully not create problems on x86 devices, since SMBIOS3
> was released seven years ago (2015).
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

It's also worth noting here the aarch64 Server Base Boot Requirements
(SBBR) has required SMBIOS v3 since version 1.0 of the spec [1].

[1] https://documentation-service.arm.com/static/5fb7e5adca04df4095c1d64d

> ---
>
> Changes in v5:
> - Add new patch to drop support for SMBIOS2 tables
>
>  lib/smbios.c | 76 ++++++++++++----------------------------------------
>  1 file changed, 17 insertions(+), 59 deletions(-)
>
Applied to u-boot-dm/next, thanks!
