Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB10FC47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 13:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3AE879CB;
	Mon, 22 Jan 2024 14:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aooj90I7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64ED687BB3; Mon, 22 Jan 2024 14:01:11 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A9388796E
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29054ccb9e7so337924a91.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 05:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705928467; x=1706533267; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZL41R9u9FmzHC38eptWUpZRCE1ZIHW16yKu2qzW3xe0=;
 b=Aooj90I7hCDkfGJgITE+3GYN2S6V1IXNDtdtmV60/inxiZjDKFtx2tLJxIpRNeQLRg
 KCM94YZQH/QzFnwJKeZm2oy6mJOtVAiOSddsEd93UrXKCnHiwNYLoUa/HpwfEAXjcoAG
 Ek8rR4kG/jv4ogwAa9Tppp0gocoPiA7BXDSZ4JgXvlpcL08nRv8xzY4icJ0+yJQWjzXh
 6aBKs7dGcgdw2jQOGZ9ymhC9HNtQnsgdwDaBpPy0riAZgEguYByXL7hpXeQmBHhFB5fP
 pw2FJwPQ5lSvrvbyEHcltBhKZJ6JwUa7a/YNq9viOusA6SMVbHqxZ4KII1bYSmcgiKY4
 x14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928467; x=1706533267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZL41R9u9FmzHC38eptWUpZRCE1ZIHW16yKu2qzW3xe0=;
 b=mKgvRyp9Z/paaHspDM1bjXwQIoVxDBsjaQxIsBy/oA1umlemeoCoBDtvTgU1ZgkEpF
 u3v19+BYx4Pwf642NyLcCnemdzSrxMYfyyM8rCJD3jyVDfUA2bzTXt8XUxL9C6vlxCNN
 2DF41T+wErp9abJvTARfjgKsnA6xzV11w71L0JAhV0uIPT6M+A87v8YQ5nDptE642BNw
 zsfFdd/C4bWnOgM1uUkKAQmch55SEAhVC1ZeViuXFl+bynjNK6m4JjSWbg+ACqqzSWmC
 +iClyMMv80faL65fZJW+H172dmRVhy8sMtDN6nuj+83pE5SPgu08CucqsCvXvKH0tYiQ
 XqWQ==
X-Gm-Message-State: AOJu0YznJbuFQ/mJpO1QHzhLcT8YMzFT/eTeyjeCuGR1vZcWC2jvx/Lt
 +LdCsC9Mg6b9dZG5eUjlFxDOYPIwuOMMN6oGv147vgjXsAy9b7/EOOZJfnom746b4Wbnnd4VWdS
 crr/4Dyc8+JRnAw7IKRMg9jV3Kjc=
X-Google-Smtp-Source: AGHT+IFDy/CJiikG51K9cn/Suipakm4wWesoKK1pYoGD2Q86kBcwq/CgeqrsOjPNGLuwBgKfK47J8XPEvkHRuA69txo=
X-Received: by 2002:a17:90a:e513:b0:290:172f:3b1a with SMTP id
 t19-20020a17090ae51300b00290172f3b1amr5216341pjy.3.1705928467290; Mon, 22 Jan
 2024 05:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20240119172533.653865-1-festevam@gmail.com>
In-Reply-To: <20240119172533.653865-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jan 2024 10:00:55 -0300
Message-ID: <CAOMZO5D3A7yFy-xMK2ZbSrdP185zfEO-FRZQP691WmVNqTtFiw@mail.gmail.com>
Subject: Re: [PATCH] wandboard: Convert to watchdog driver model
To: sbabic@denx.de
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

On Fri, Jan 19, 2024 at 2:25=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
