Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831A0C369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D08B382F87;
	Thu, 17 Apr 2025 15:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jnga+sVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58D582D32; Thu, 17 Apr 2025 15:54:27 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDDD82D18
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-30f30200b51so8781181fa.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744898065; x=1745502865; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5Be8ZG/XfXv7B2xXM8yWX5mnifHNnRiUIAR7wc8Us0=;
 b=Jnga+sVG0GZwfsGE7vMcxDpwIF6YTf9UG+Xip6/4vNwin0ahIWxapmRGv8AKVzF5jl
 yrrnYcxIEOr+dDqUufw8jQ7Hjt5RO5qvs5e0MyD0D0Qlbv0KwGuc7YCB6A8Q1dSai+JY
 D90+cX8PXCguQt6eebfuY8yDfrgb6nQKMe5+YOfINfePT6tZ78x5+Yg0eSSB6YuiIRLo
 NLNMxi/G7cpTrKLfWqeP0NzbAuqgFRFNeAYVQu4Tx1N+xj5chEVU2N9jEqKhaa/3XD2K
 AnpFck7KOaExPun+ilI7IoUdF5DttANtv9xC/uhzMo0f63dwWIyuVjYhr9nk65XMOQ6H
 bm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744898065; x=1745502865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5Be8ZG/XfXv7B2xXM8yWX5mnifHNnRiUIAR7wc8Us0=;
 b=mhWZoaugWg0PHf7djdYfmLTYwcyvonC/lHaGIO8DGL/770AjnJPFIs6z4Vrnyg8IMX
 6eiu0MgWeuMWyX5pjihiowm9RJuTSv4On8rlDW8T+HaeLHDaaoD1NkNB4vIM+dZbhei/
 IF7Ji6FBAoz7glJwwPBfDhB70GgDC+6O0PtReaPNLMS/6dcxIUkb40X3ompJgU72RS/H
 1g+UGdMCL8dqtfb+AbmOVYz3x7B/mAnT8GSTFu05On4txZOLUWYFdNBSY2vvlWG3AE3n
 R2pNCXhQCm6gtmHuvJH77IxnFTHw3Sa8/Yxr1MgWg8CUfsv1nix8ELy0ChA0hrxKIr+s
 iMFw==
X-Gm-Message-State: AOJu0YyuyAmHLKAzwwB4rcIMj/E3cjk/QOD13tl/BTWL0zLGrAqrk0Dp
 w7UDyK2uHEBt6sGDmn0kqnl4N4uVfnDiZmeP91fl8iC9rUn/OfMicxosuVMnXXPAOWEuj5zAqOn
 xoXyEnMaP0rrHHlrOykt52VUWTxI=
X-Gm-Gg: ASbGncvFgJwaA3P19SH6HHslKsZ04EgRzL8I8S2iLN5QXT/pO2ffBrX859dYmkzs2ON
 1NKzm+LNu8ascxpy1CtgTPSxP2P7UkHRMMq+2ROZh1Xczr727CAc3vwUn8mLUTHBkirumAgxnMq
 TcbvpIXQXQqChPLdjr0eYKDzKYI2+V3A6tGr9wiANzhs/Gt8pUJ1krMg==
X-Google-Smtp-Source: AGHT+IH70VGAnB6OLpJUXF7dXxsXr4YG6C4Zg7DOgQTEN0slPjHBO3mdeNzDY7wFUNAv+YLSXZ58mzEY/ZjPW1EV+Os=
X-Received: by 2002:a05:651c:30cb:b0:30b:d17b:26aa with SMTP id
 38308e7fff4ca-3107f68abc4mr37766181fa.2.1744898064878; Thu, 17 Apr 2025
 06:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250403151050.3649150-1-festevam@gmail.com>
In-Reply-To: <20250403151050.3649150-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Apr 2025 10:54:13 -0300
X-Gm-Features: ATxdqUFD0gCAG6t0QvbLRxvjvMf58MS80ql-SVkUyYQsdLjo0KMC3p0jYkGOKIs
Message-ID: <CAOMZO5BT+yfWYab=Ltj5iJWWSGyAj_TVAuHd99RQP10rzauE4g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2: Pass bootph-all to the PIT timer
To: eugen.hristev@linaro.org
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
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

Hi Eugen,

On Thu, Apr 3, 2025 at 12:10=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> The PIT timer needs to be available early in the SPL phase,
> otherwise SPL fails to boot and only prints:
>
> Could not initialize timer (err -96)
>
> Fix this problem by passing 'bootph-all' to the sama5d2 PIT node.

Do you have any comments, please?

This allows SPL to work on sama5d27.

Thanks
