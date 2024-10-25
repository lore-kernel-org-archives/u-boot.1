Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDFCD0C61F
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 15:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A6B88BEF;
	Fri, 25 Oct 2024 17:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K7llwdcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5404688BEF; Fri, 25 Oct 2024 17:06:19 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5589288B9E
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb50e84ec7so18507181fa.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729868774; x=1730473574; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJ+YdEfDIk5TwLVvwwgOnzHuOD4QsH8Ur40XSzPgZX0=;
 b=K7llwdcQ6EOnwrHsFxDc6KHjkC43k696ZKZP5iI4Sv1ircf3acfDJOCNjqt6ko7rSg
 soLQejR+j+eE8rUxd+fkzoPFMlV6nogPvxiyJ395qR6wmZ39bAq7T42C3opYSuzpuyqd
 Om6x8M5h31Q2EZS6lAoAkW8qD7FPVBzSn74b6keLAhm/I5dMmq++SPbsFJCTv76qb4ns
 QHgG8LvVzexXqQIBRQh7/maZlikAqD+d7yv0cvGsbL34V2KbzIpmjzF0r4TpJeSS7qh3
 cZyCHeWXAVXphdqEll1ADe8vTvfQBhkw44fE59AQzKTkJGbCtgPAxrWIZlibfixG45Sb
 MZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729868774; x=1730473574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJ+YdEfDIk5TwLVvwwgOnzHuOD4QsH8Ur40XSzPgZX0=;
 b=bFH8xNR4ENVonwvEycM4yYMw5Qc/GfKQG/X1sksIIdw4J47dEsSrRywx4jjVFw4ylT
 5sYp2MODwX6al9zMhHzf+NSw5STSWGovdFWng1q7IHElCZD8oBRkInuplSNSMi75zWnD
 eP3jh7X/ni9bNPKdhM7SFXTHgAFs2JNh8ditdzGDXuy2tUa7jXtAibakoxXyABG8qo9i
 35zVt+SpvZN9xgSlBnoPV3FRq4Gv4yvRND3zbXnD1kvlWAf3nqGAG4eMRPG8Afh9AzyQ
 9KXgzXTKPhKxqctXvQ3fv1m0SAlHa/YEcUxFZjmWjjjFV88TeZ00qEUL8F95+Dk2ikh8
 cT1w==
X-Gm-Message-State: AOJu0Yw10fcjBHEB32brfOwYQSoQkbdHBGebv2y3FgD65Qo0xYzgqhXc
 ipuH8fVZvhYKBD1YMAUjUB1uJnErM9ECcVxjt7fYDEYYa6tVkDmu8wapwXRzBy+wEiqNAhNNQSx
 pxM8OiMHDjQOLweW0Tk8dxib5MVHAVg==
X-Google-Smtp-Source: AGHT+IGwcsghM2tEOv8GAZfy9A3iYzGOAmZbCqotgoq7ItTERa8j3+fYiVNpZQfxOKgzGzcYLdKAjlCvNn37YkLs9RY=
X-Received: by 2002:a05:651c:2227:b0:2fa:ddb5:77f4 with SMTP id
 38308e7fff4ca-2fca8265c88mr36799001fa.38.1729868773371; Fri, 25 Oct 2024
 08:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241025144645.1969367-1-festevam@gmail.com>
In-Reply-To: <20241025144645.1969367-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 12:06:02 -0300
Message-ID: <CAOMZO5B2yOMX7H3YEnzTUamHV53221MJRiSY11AoopLe0AeJPw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20241025
To: trini@konsulko.com
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

Hi Tom,

On Fri, Oct 25, 2024 at 11:46=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:

> Rasmus Villemoes (2):
>       imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS
>       imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb

It seems this one needs more work/discusssion, so please disconsider this P=
R.

I will send another one without it.
