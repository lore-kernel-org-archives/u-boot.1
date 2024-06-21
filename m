Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA76C2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F09884C6;
	Fri, 21 Jun 2024 16:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LcWH3ID6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDF48845A; Fri, 21 Jun 2024 16:24:49 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76A36884C6
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7062bf84f99so50219b3a.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718979885; x=1719584685; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKbTl213yhH+ARzwG3bNiaYISqR1lsFTzBl6T4fHjn8=;
 b=LcWH3ID6ey/5qALh+H3KU78bstkTNRGlE6u5R2yuwSLw04SHMBfrMBhiWEQvB9pTRs
 ijfZgp5/4CrL0KcGeQX+ssqSqx0U1sy6sxfBIvDrCYDly27xXoRr6KwjjZxYah93hOAh
 ns94uohE0sqDJOjSz1NByLS2b9ZQ1vKC/beHRCC+xypypC/gI5bT3BberixHzv1raNzx
 zs484kq8K0RYFAZ3+l7y/2BnP2/vE8VToIdxbtGRnsmUoH58atePx0y9/lg13EodGJI3
 C9a4Ti+aynC857iFgM84906j+ffQv9+RCensK7r9+rY2ypt5BKq0fvIGSHmQxShPn8QF
 rHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718979885; x=1719584685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YKbTl213yhH+ARzwG3bNiaYISqR1lsFTzBl6T4fHjn8=;
 b=cjF6RmoIFqoXtm97bY7WBlr52f/UPKY1mTFvP43XuHng5cltHJK3czorfmVahvQP2i
 rriPMMHy1HjYX6Y4vg2obcnOfqRg09aykmCQCkUQEiFFsNMhQuHRbFLBqx8Xw8tkSaEu
 FzD0+xKM17ekBImO2w4vHnpUjpErHhvfAyfbD0FLhHdMG4ps5aa5CazG+RrPYEgEH1Wl
 nwGpCDzSgjd4Bi6oET4Bo2jcMW79AVw6Vs2WHZenNzApMDtzctQqXm0GDTTi/emzbf9h
 BMvgqAFlHBn7s7tHvKdupPqgnV/uOmX9V+6XL6D4w4irBqARQ78lmLVi80rzEP0xjIle
 +oRQ==
X-Gm-Message-State: AOJu0Yzv/QshDDFIuHv9k6aKW1kYEBWHJOJIsrl511QqBWFvsVObFAA/
 a+0R67VqXwk1Ow5sWgU4w9zXYXAuux7lymMxXOuFtMoPN4XbYKcqj1qVMJglB+MYqzfeKQthNUw
 F/B4I6F0dJbA5cQ3SR8jeZhRhJz5/KQ==
X-Google-Smtp-Source: AGHT+IHHznoYlbUFI4c9qZ23z91nuPCx8N7ZwgDqznZ3dYFHhUFhEJ+ak7z/Bd2QXEqOkHWE/4faoa1bnpN88w5CuIQ=
X-Received: by 2002:a05:6a20:12cf:b0:1b0:1be7:3708 with SMTP id
 adf61e73a8af0-1bcbb39b78bmr8575555637.1.1718979884728; Fri, 21 Jun 2024
 07:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240620013018.2283965-1-tharvey@gateworks.com>
In-Reply-To: <20240620013018.2283965-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 21 Jun 2024 11:24:33 -0300
Message-ID: <CAOMZO5DESaposvEEH8suJm6cGA-qqUQ=_5bvZY=L03bT09zk+A@mail.gmail.com>
Subject: Re: [PATCH] imx8mp-venice-gw702x: Drop EQos clock workaround
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
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

Hi Tim,

On Wed, Jun 19, 2024 at 10:30=E2=80=AFPM Tim Harvey <tharvey@gateworks.com>=
 wrote:
>
> The assigned-clock no longer have to be dropped, the clock are now
> defined in clk-imx8mp.c and used by DWMAC driver to configure the
> DWMAC clock. Drop the workarounds from U-Boot specific DT extras.
>
> Having the clocks dropped causes the EQoS to be non-functional.
>
> See commit c7ea9612df0f ("arm64: dts: imx8mp: Drop EQoS clock
> workaround").
>
> Fixes: 48c6f9777cee ("board: gateworks: venice: add imx8mp-gw7905-2x supp=
ort")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Is this targetted for master or next?
