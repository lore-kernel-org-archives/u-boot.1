Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C012C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 21:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F20287CCF;
	Thu,  8 Feb 2024 22:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eTwH22PJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5665587DDD; Thu,  8 Feb 2024 22:21:13 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E71EB87B85
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 22:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e06ba6d01fso56666b3a.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 13:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707427269; x=1708032069; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwIjYo5JuWU88BDTzw/KmiKMdbl9QiQmyfLuv5zwnr0=;
 b=eTwH22PJ0q3YfwnDvNyAdq0Bjp9VPys+EW9j5f/qGn/imYGfA78X2D62Cf5hVtnUmC
 J8E4+JoOua5kXD2N8pTFo50IItQ20447+e7Csjl7waH0KSFtJLkcsBi1+w3umHXr8CNY
 6winIKWS0G03TUV7VkPnD4gF9KOglO09KBqVtADNDgbLo0aYAfaKr7FoCxpZSYs4X7mG
 RCvKRCEJD0cIWLhHS0OMcDr871OIe51D3dtZI4BViheflAYjmGz6/pTFLEdCl86n6x5J
 CeRQyLwiOHWECb+Km8od2/bUzjTQlM4WiENkePNj8OKJ9kVDRHeUTTBztmclKBnhDsPv
 4eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707427269; x=1708032069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwIjYo5JuWU88BDTzw/KmiKMdbl9QiQmyfLuv5zwnr0=;
 b=Z47vJuyjVnwD3cDTHAIohXn9E+ta1dhBmjq2H+G1TTuOjAnZz4svtJnuodI3L9V1sp
 PpHL4nS/5dB3B8P9Cp/USv7EgJ8kwd8E1nOBk6TuFrDD20ghV5tlkPyrMmhqyLNyozLd
 jqI0Y79j/RTHs12LWU7x5abz1Hka7Ce6wng1URr2fsepCRyHD6EYth3hKBrvC/MlLv7d
 p+hvUASqQICIowqYfXA+97zHnj2/v9ck+qWXZ9/4xOJixKDue7Nan2GNzakN7tke+cxm
 /JMQMYsnW/UoOt7efFNpPdBpNOcpcCfW2L5d3AcDe76Pw/wiKEamByMndraRL87TV2hr
 bAkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3xq7fCe+WXw9gL0duEQNlmBdvdNNxCh5PzSSis+Yqr5W+/uUzft0GxDHFKnAN0JBmWLRXW0QT504tVUe52IpFoUrTTw==
X-Gm-Message-State: AOJu0YxwGbn9TInSBJfWc0zN3/3hnXknHv6bdsGJahnHZGsPn5/IVh+2
 5SfiTGLVAX6c+zXL8t1CYRuMShf8CJalade0O3+PM/Oxvx8Wc0HvAzIpUNzR8PqlrokNvmna3B1
 Msy65wfyzWHKMi/Fbg0XDqEm3mLk=
X-Google-Smtp-Source: AGHT+IEzFI/+jMUPX9gtmv46oJIa9LMnKC5CMByQkxSbvjgzfgYftBqSw5QeRC3CCM/j6pK7FjaR/NneBN58PQWXOK0=
X-Received: by 2002:a05:6a00:1c87:b0:6e0:5de3:7915 with SMTP id
 y7-20020a056a001c8700b006e05de37915mr537552pfw.1.1707427269170; Thu, 08 Feb
 2024 13:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20240208094518.391-1-othacehe@gnu.org>
In-Reply-To: <20240208094518.391-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 18:20:57 -0300
Message-ID: <CAOMZO5DhQqjsAy4eoZqKdaTT96EWfRa+Vra3gvRCwXP+6fXt0w@mail.gmail.com>
Subject: Re: [PATCH 0/2] imx93_var_som: Enable AHAB support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
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

Hi Mathieu,

On Thu, Feb 8, 2024 at 6:45=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org> =
wrote:
>
> Hello,
>
> This enables AHAB support on the imx93_var_som.
> I was able to test that I can boot from signed images on a closed board.
>
> There is one issue that has been discovered and that is discussed here:
> https://lists.denx.de/pipermail/u-boot/2024-February/545404.html
>
> This series can still be applied in the meantime I guess.

Just wanted to make sure I understand: if someone programs the fuse to
close the board,
it will fail to boot U-Boot proper and this means that the board is
bricked. Is this correct?

Is the boot failure related to some malloc size needing to be increased?
