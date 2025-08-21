Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D865CA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 23:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A9480548;
	Fri, 22 Aug 2025 01:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N3lzdNSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C090381D5D; Fri, 22 Aug 2025 01:20:25 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0AA8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 01:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6188b5ae1e8so2074439a12.0
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755818423; x=1756423223; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t4QE817T5Lcu+8ZwRGroQSwm5QpNXKS2BBIK7KbmV6o=;
 b=N3lzdNSedY6J4lC8KKMYviG5O+Cc5I2rfFQMEYXp4+jLjAxH+i2FRzp6X00YHSTth9
 /Irn6geUlM6gcb12YjhBAXOxhnUES66DSZY+0vfHHlG0u2H30/J/tjK7LJZ5T9WQD0+v
 ipfpiKCb01yeenxkaFcbY45sorBOojMP92QdCoUY59EXXbf82yRcOn4xVpReAGbem22F
 BEw6rNpOSGHoWWFgbrfTdAFtweI4HP5LJ1krzS37+8ND1XnD6yxhvwHXl+cH9BY6Ih8C
 mTDtrlRbTODT8/bUM+VcJNtEIOGyNFfjgLOIvTys1kluemzQELBE06Y/9pI4IodaKXqo
 sa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755818423; x=1756423223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4QE817T5Lcu+8ZwRGroQSwm5QpNXKS2BBIK7KbmV6o=;
 b=L8nBeROIIyy/zceEBlBESY9/S+/kK4cX7UYdY5sMQbYLAj49gdobhiliBhmZUbTC3g
 7Qg6iM7LKeBlTlvV3xZmqgn44HK61TcO/G24tddnzERRwM4Wlm6NgznON6FPC9rZR2Sx
 xgqCmcS1KKvHArHV8jaF4l3Nn9SqZt6dv4MeGvfjUDnKvxf/VAG7UcoYfzyyZJ54rgxT
 O1uIFi563unGBdB4glAqpXm8WENtg8HTM1OoYLwaFUjC0+TTdCHkwSA/21dxHmFkRQ0Y
 y35HTojuxK85qK8eqfvVTs9xkHTJjy5l+rDz0bituisHgN1uCNIhqaaidrNNnLmnYJTy
 3oCQ==
X-Gm-Message-State: AOJu0YyXzMvM2IMrRe5gqp5DorknqHER4HAY4de73JDTO7nT4/ui7SxC
 SkojvGyRtC+Z8S75fiD8xwSRna0XpY8m/gvBBvFy0O641ZZxIu7QmX5cGhoWCQdXi5B4aBpDrc9
 q54FjYVSH5lxZIBbQ/OpbG6Z+3U4/V0gfEFnOQD4=
X-Gm-Gg: ASbGncuM628DqLjpozOFyCUrRdVZnXn8IJ4At9hs6YpoMwg9Q32QVzodW4F8Z7IgNlB
 ltdobXMcliYdq/Pc26/TSnNPKLVjLhTWmWs4sfZS9T4zjok7Xsp/4RFWgQVrDDmduU0uRPCLmea
 aNJgdgwbXqIfpFd2/wI5ON8Lv4lcuTR/GLiYPG9J2gPyD1rJJmwCEF79DiwvBzTU0lLlK8w24sS
 pchguELyEJHalVYBDtHBs0wLsGLn3gtm692kEWs
X-Google-Smtp-Source: AGHT+IHjFQCox/rP3iO7Y09mHdYnBBrH42FyHFlXq5lQS+gilZkAjF0P2GKtqRkfioSvMmdFK3iQ83J+UjuvveS0e44=
X-Received: by 2002:a05:6402:1d4b:b0:618:1250:ac5e with SMTP id
 4fb4d7f45d1cf-61c1b6f982amr633820a12.19.1755818423175; Thu, 21 Aug 2025
 16:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-2-adrianocarvalho.pt@gmail.com>
 <9a62ccd2-1b25-4d69-b392-50936dfd8217@gmx.de>
In-Reply-To: <9a62ccd2-1b25-4d69-b392-50936dfd8217@gmx.de>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Fri, 22 Aug 2025 00:20:11 +0100
X-Gm-Features: Ac12FXxTr-8agmiTrcrsiQCAhXKsKuAI8Q21tcifHiDmhDpLMF3lwlfCd3m-f4w
Message-ID: <CACAHuLADKdumT9Lbnx0A8JO-iVS8UsksZcq5=PdGyUi+r2et4w@mail.gmail.com>
Subject: Re: [PATCH 01/10] doc: Fix typo in doc/build/clang.rst
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

(Resending because I forgot to reply to all. Sorry about that.)

On Wed, 20 Aug 2025 at 22:54, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> [...]
> FreeBSD 11 reached end of live 30 Nov 2017. The content of this section
> needs updating.

I'll check this but it seems right to leave it to a different patch.
Do you agree?

> [...]
> The proper name is LLVM.

I'll include this in the next revision.

>
> Does the issue occur with current FreeBSD?
> [...]

I'll check this but, as above, if you agree, I'll leave it to a different patch.

>
> %s/symlink/symbolic link/
>

I'll include this in the next revision.

> [...]

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
