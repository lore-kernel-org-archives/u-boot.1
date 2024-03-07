Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36945C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 21:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A6A87C83;
	Thu,  7 Mar 2024 22:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F7y3hazG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E25D687B77; Thu,  7 Mar 2024 22:19:30 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA9487D99
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 22:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5a0dc313058so270029a12.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709846365; x=1710451165; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fard8IB/A9jM914wz6yPmDbtuAwKIjfeb6K7RnDIGe4=;
 b=F7y3hazGfgLvy4bfmagNu14+ex3pAWLAzISCc74DnTd9r9jS+Eqgq6RAQa/Gia2+a0
 vHRWhubfyFd7BxTBr2U0Cj3a0qHIXcbJvkcrNszFBCB9uWOPBpotMHHzHhqMan4rOlB/
 +g+1LaoCfuUCg4OPOoDm8q4GfyuhdU1KH3ebCQjYZsYN7MUHbOVWAyPfZ8DcMn8YhPIq
 GLdxPEma4XBO5DAkZWTLzCvWv15zE+yLhgj5rOo5HDqbZvSXvGcQhdgTlkNMztMqHgRi
 SlbWj/uhAAxEzgiq0RYyi5oeauiYKkQlngAnmSWVIjm2IIJKj5fKIv7a7XsyZAuNNx2O
 mr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709846365; x=1710451165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fard8IB/A9jM914wz6yPmDbtuAwKIjfeb6K7RnDIGe4=;
 b=gdtIPD6G6gVPMsZt++HkUyP0M93p0iV0PpqW6YI5BGBO309zAuJhJnT1h3QVMzZuex
 5sYbk9Ty8cH4DI7NgqssZpo1Q+MWQRS2LJx2n/YaF2H6s6nCki61Jxsd5IRbMGQxZfz/
 H1NLD/aV57dnxVaGTuulttAIjZqD6clw5wd1GSf56owDtWlnDTh9jjAO55Z1W3er3nm+
 C/8/ab5xxKSmdcvqQZ0qUAZGu895t8He/mL6/YU8TD5jH32oKSCD4LbRImxzWJMtYnD6
 dJSE0FFm04rrUj3TMHINzQSidZjEnj2ihUsEB8sk+Mk+ctnzaKGuxwAbjD5A9U4N4InY
 TRkA==
X-Gm-Message-State: AOJu0YyoQWbPbmDnVUCNRvoDQtJ7dh0l65cOjKWy/GOBcgy0cz7gZlO7
 Lb8Ft1+vRvxNQ3EdWYHbsRb/FspIt1cMspBd6DRoSGFsN2SGvPfFC6aGEsG4cdQRzF9Zq713l1Z
 +u4l4/Ex9T7/otCXG6GIg0SscIPOa1eOw
X-Google-Smtp-Source: AGHT+IFkFhKPSBYf2Qa1EMZNQVKven4O2x/AYcbyrgbWRnJ2aEd0l8RLhxxrdTnuEGVjNskwcoS6jn6K+aDOV4CQt5g=
X-Received: by 2002:a05:6a20:b22a:b0:1a1:8008:8cc with SMTP id
 eh42-20020a056a20b22a00b001a1800808ccmr136799pzb.3.1709846364855; Thu, 07 Mar
 2024 13:19:24 -0800 (PST)
MIME-Version: 1.0
References: <BEZP281MB29655E047444C987850ED632AB202@BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM>
 <CAOMZO5BhEmnVsmYdJgabZC1L6GrNc4WvMhRZNrFhemTvD3rpzQ@mail.gmail.com>
 <FRYP281MB2969D2ABC5FF3EB2421E95E8AB202@FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FRYP281MB2969D2ABC5FF3EB2421E95E8AB202@FRYP281MB2969.DEUP281.PROD.OUTLOOK.COM>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 Mar 2024 18:19:12 -0300
Message-ID: <CAOMZO5BZETj3yTE1mOVXCmUH+JeyYPs2bSWZ9DGp1qtNqD=JHQ@mail.gmail.com>
Subject: Re: U-boot fails for khadas-edge -v
To: Vivek Jaiswal <vjaiswal@cinemo.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Thu, Mar 7, 2024 at 2:43=E2=80=AFPM Vivek Jaiswal <vjaiswal@cinemo.com> =
wrote:

> are you saying to use this one?
> https://github.com/u-boot/u-boot/blob/master/configs/khadas-edge-v-rk3399=
_defconfig

Yes, this one.
