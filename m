Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE30DC4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 02:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A15D8791C;
	Thu, 14 Dec 2023 03:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fDY8CAnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F178B87995; Thu, 14 Dec 2023 03:01:29 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1AA587905
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 03:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5ca5b616de0so128256a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 18:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702519286; x=1703124086; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEDA0kkoptt8L5Fpjn3QuUF7OOSs1JxONd7SNJHpoK8=;
 b=fDY8CAnD12af4rbgaAxM3I/zD/LO872kCTCpTb6wi6tjq1qEU1zA0rvyNtSTgGGQiv
 TyM0HH5Jgbi5ZrQ08VaiVxHTRyOZy5R4WUuOFe/A+fxMBcVgU7heSuAI7UmZ8A7fDDU2
 tRLQ2r1sus+qDmFLi1HKuJV7qE4MgAjOnubPxqX+QLqHMGHmR4EAkGsDBDksyKfrxIeM
 Ttf9SxSD16hE0mnAsAdNo5OODw1y6y83NaVVVU6xRKYcQ87b41rPuvHRUKO21bONRMQw
 Jwc3tBQeUVBAvKhaCALVvKvVwa+LXMsb90vKXOqEQ95G5DLSW4dPXUCF1s4esD+KmHkC
 xOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702519286; x=1703124086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEDA0kkoptt8L5Fpjn3QuUF7OOSs1JxONd7SNJHpoK8=;
 b=if4RrunJQGmduxhze8qCqiXV0MpQ1IFiyiTvAgSfgRXwosH5grGSX7CToKsdKBAt60
 GUw5xcWGP+TieXtCvbyA0YX7e1kqn9/vovH5yyFAYQ+0tnBeHuLQCEneZZLB90t+z0qz
 zE724r+WY+ueyFBgetH5gMf7ExVi0+Fgd05SNl7QjXIqI7WA+E+Fk+0kHYCWg22ySkF7
 sewpLecCcl5BrzEeidjvwXkYOEEuo3foi/PW7ZQnKGhNlEeOQK3WEx7mWjqXZkDyvrXp
 6Eq+S9YWL2hEPZ3lCf3BCs4s0AUGSS+NRPmuZgI7TIB//Fac+bzV0TJl48+y1bgMJNbI
 /P/A==
X-Gm-Message-State: AOJu0YyBoAw0UEaALJyNolPjimaD59StYjqzMJRIVK597uSzWiA7UpsG
 vELWy9HU4XDiw8VNCBmiFI63YEoxbn+C72AG8k23Pj7TdQI=
X-Google-Smtp-Source: AGHT+IHYXvWynxnn4YEjWG50ee4G1Kyp+lzyS1o+wx+ZtgtHEIESndxrnsGwyF3G5sw9mr514xZIMpDTbKqx4mSSw+0=
X-Received: by 2002:a17:90b:188f:b0:28a:f2bf:207e with SMTP id
 mn15-20020a17090b188f00b0028af2bf207emr2330247pjb.1.1702519286106; Wed, 13
 Dec 2023 18:01:26 -0800 (PST)
MIME-Version: 1.0
References: <ZWy2Chxgz9mRxGQN@arcana.i.gnudd.com>
In-Reply-To: <ZWy2Chxgz9mRxGQN@arcana.i.gnudd.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 23:01:14 -0300
Message-ID: <CAOMZO5AOPeAXLOLASErVCszdGHHBF+aCPgKPs7AniwjsQQP26A@mail.gmail.com>
Subject: Re: [PATCH] tools: mxsboot: pre-fill buffer with 0xff, not 0
To: Alessandro Rubini <rubini@gnudd.com>
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

On Sun, Dec 3, 2023 at 9:24=E2=80=AFPM Alessandro Rubini <rubini@gnudd.com>=
 wrote:
>
> The tool works for me, with imx28 and NAND memory, but the resulting
> blocks are reported as bad, both by u-boot and the kernel.
>
> This makes it impossible to erase from Linux (for an upgrade without
> console access, for example -- u-boot can "nand scrub" but linux can't).
>
> pre-filling with 0xff creates a proper boot loader image, but no
> bad-block marker is there when written to flash.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>

Applied to u-boot-imx next, thanks
