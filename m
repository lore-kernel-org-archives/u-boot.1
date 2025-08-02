Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3628EC87FC9
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 05:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B690283B5F;
	Sat,  2 Aug 2025 07:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VtCwVO5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D630F83C29; Sat,  2 Aug 2025 07:11:21 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005D083B05
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 07:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b7825e2775so1964038f8f.2
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 22:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754111479; x=1754716279; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UNzGLcIkoTlkU9A996SXI6HBCQDwAnyedYyGPJdkX8=;
 b=VtCwVO5ajpNdoIF0o/tBBkLYZj05ng2D8yUtCzdihW6HGcOTxXFkY+Z0TScL28PH8o
 /ogn+WOtNrPn7j5awbCiD4dtKpoej3rZ607Kt2A0JmoZJPn/iUnyojLtIeJfXaSNSSEc
 yW03qi3jNifTrn4UgX6RMt7FaR9FCXjCgJG/sNyLI5rQa1FOHUvziqISpBw3pgPF6Ial
 sgN23vAWcTL1gfyGYcsISBhHCDIjZgydno/NNgreq0qjxxu6D3WV8urURcU+rsT69Uo6
 wddnBpTvU/apAkY+sZoo6XeqyPbMa9Lffe9WgJPL6KUMccBfC3OxN6eo6IEIN4xa3bSZ
 NlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754111479; x=1754716279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UNzGLcIkoTlkU9A996SXI6HBCQDwAnyedYyGPJdkX8=;
 b=NZkny1qiJAZKtSrk+sAlhRKSjVcudMAllZ1II9HD2SqnT6TkLRHnw+EqiX6JLALhbb
 14V6NVoxX4TjFw9bhHWLiGBeXYF1qWtgUH6eCV421+QjG3BQA2I1/6IiGlyeLlqblSZl
 XoxnRXNbofsgjjD4VlfkzEwlPpzMsiS/Whfa92Mf77/7HfjztMW8ODF2NPtcUxSPL+mL
 GXujXBPx3H2bQZw15Qk74AJ1Ad8V4EDaI9VrdIA52vcklPIXk1gUu6Jj3JyhUM7Q7hpy
 LkzkMeJONBP0MWwpYalAoxqNxa75b5d/jwV7Ytu+6rvPMeNpq282IlrjBgF3cdTiYjpF
 U32A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2T5+zSNquUgETe/qN8TYpYcgaVDSvIj0kUHiU/KC2GohZbgxx2vRo3jskwfmHXUz11O3jy1M=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp2OgI8DurDUZBSwgv8BBF9Wl6BI9POlxlgLTwV7pBOysqPZuq
 tBmKiv3No5U7FCUKIujMMOgAly4Pt0Pcc82og8iSPR+KwP3nxtj8NYzAIW5LF3gfmQcWg8pqfki
 DP2I66h0Xm12HNz4asBCMebPGJ/S7lvY=
X-Gm-Gg: ASbGncuzhbqsTLO947lsRVwU/c0X4FgZ0I4/cbSVkaiIW1nVlJOLHmM/ankaUZ5sPDU
 qVAUzvjOk3icfqcJYVMAFQcfBDg9LYXiVVPw2yQU7BoItAPw+v62S7EolJIOypG12BJq2KMRlIk
 k0a6w/b9j7+OBW5t/qwQvHtIBwGUCV8w/drqyv8wZvJeB9YfvQgtL8BeBGCk9a6C1+rarry/Sjq
 +OFRQrD
X-Google-Smtp-Source: AGHT+IFK14exIub+BxmIHPu0YhZq88G9gyvKUtLgiMUFWdz6xqGRQxyPXR+C0eYR31izce0PzJ++Q4MA08dQkGyAP5c=
X-Received: by 2002:a5d:5f54:0:b0:3b7:9a01:e52f with SMTP id
 ffacd0b85a97d-3b8d94c4951mr1489286f8f.44.1754111479387; Fri, 01 Aug 2025
 22:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250731193656.286806-1-ion@agorria.com>
 <20250731193656.286806-5-ion@agorria.com>
In-Reply-To: <20250731193656.286806-5-ion@agorria.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 2 Aug 2025 08:11:07 +0300
X-Gm-Features: Ac12FXzE-e3oUAzQtxxWclvGyVZM8gDy9BiKJ0Y7J-kaV0clcSFp0b9BIT6chaM
Message-ID: <CAPVz0n0zZ0JzU860s6CoOE=mQsagMnJ1JmS2VRFqMYwM1L6=FA@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] video: bridge: add Samsung CMC623 image converter
 driver
To: Ion Agorria <ion@agorria.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
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

=D1=87=D1=82, 31 =D0=BB=D0=B8=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 22:37 Ion =
Agorria <ion@agorria.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Add support for a Samsung CMC623 image converter chip found in several
> Samsung devices such as Samsung Galaxy R (I9103) and Samsung Galaxy
> Tab 10.1 (GT-P75xx).
>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> ---
>  drivers/video/bridge/Kconfig  |   8 ++
>  drivers/video/bridge/Makefile |   1 +
>  drivers/video/bridge/cmc623.c | 234 ++++++++++++++++++++++++++++++++++
>  3 files changed, 243 insertions(+)
>  create mode 100644 drivers/video/bridge/cmc623.c
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
