Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF418C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 14:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1331E86B81;
	Sun,  5 Nov 2023 15:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X7HvYYC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2A08642D; Sun,  5 Nov 2023 15:05:59 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 294A586BF7
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 15:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so5912950a12.3
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699193148; x=1699797948; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwk/knGI1FsEWpJOXjbqEUQAKtn9SypFtVVqp8rrBh0=;
 b=X7HvYYC0v8w6eMXIHTsctoOsaMpEVWv/Bmh7kOaNmB248scHmZizYvY2Gyyq8F6gqF
 9GHfUMa5ngHJ7wIA2tUoopP8EII2F9eNrsE70FkFPD4/It2Svfk/+tqo2G9/sxcF2+CL
 Ty+1IjXZesrOzmnkpmhbSSin2Ipc4zagAUMa/hTN2RxbW3VeChUWrbMsBJQHtrSwd3lV
 owCD8kNAaylFlIB9WnFTXA3NCu2QljBDDe6BDptvSNIiQdIQUgxfB3VuvXtnA4jOQY9u
 U2Uck6gC/xWXuz8f7Y/yZ4JMsQmjcVXM2Hu7Urqty7FE7SiFF4HCNWlrA30afDvizGnQ
 pcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699193148; x=1699797948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwk/knGI1FsEWpJOXjbqEUQAKtn9SypFtVVqp8rrBh0=;
 b=EoyYn8Krqit8+stdGThwuedykmK56VRsGAFl/r42j2KbEenW5N/9Ac9NyV9iMsqeXL
 egc4BeI2Y/calFpJB5gWef8Lp1FwasMhMK6mrRjOFagQQv5if/ufVJe0QG2RzMl4II8N
 JNSX3Uctj33vYfffyu5ybMX2m5DVHKncM+kFAgJ2SdPE9HZTBDiwnH67d/lnnv+8XnHW
 9ZO3bA2JdfFQiapxmz3biauIFItcUSXUlxCFYZC39QKKPM5n4o9/nkF2Ig7Eq833DKCb
 xj6DCRt1oFjyaZ2xq6yK/5GVHTU9+PEUfzA1EOjhsLjzGX0u4mxlyi6kgErm04Izz+Zb
 PiHw==
X-Gm-Message-State: AOJu0YyBFkA8xfZ4hH9bD4XSrjCfsj/5i0Fx9FQXrD6r72LyaZIHXehu
 dKG+jAk2xf7lP8iu38fG3QEGr07Tg4LHqHDOEzE=
X-Google-Smtp-Source: AGHT+IEVUYIqMoBWYnY1X+1nNMixaDl+3B4Mlil96FrotsSCXLLTmfDSwhmw5pRwLiGj3OHogXe83ke2/RA2U+rw9o0=
X-Received: by 2002:a05:6402:124e:b0:53e:1375:33ce with SMTP id
 l14-20020a056402124e00b0053e137533cemr22107817edw.30.1699193148425; Sun, 05
 Nov 2023 06:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-5-sjg@chromium.org>
In-Reply-To: <20231002011450.462468-5-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 5 Nov 2023 22:05:37 +0800
Message-ID: <CAEUhbmWi9phnvS1U=z1O+8t7kK5mV=JLw8=YJ4A_u3tcrPSXGw@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] x86: Enable SSE in 64-bit mode
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

On Mon, Oct 2, 2023 at 9:15=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> This is needed to support Truetype fonts. In any case, the compiler
> expects SSE to be available in 64-bit mode. Enable it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
> (no changes since v1)
>
>  arch/x86/config.mk        |  1 -
>  arch/x86/cpu/x86_64/cpu.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>

I didn't suggest we enable SSE for x86. This is the wrong approach.

We should rewrite the Truetype support codes to avoid using float/double ty=
pes.

This way the Truetype codes can be used on any other architectures
without the need for the compiler to emit explicit floating
instructions.

Regards,
Bin
