Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C900C25B77
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 02:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90807882DF;
	Tue, 21 May 2024 04:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nQ/k0M6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B2187F7D; Tue, 21 May 2024 04:06:37 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C176882DF
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 04:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcmvbkbc@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f0937479f8so90934715ad.3
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 19:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716257194; x=1716861994; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LxcANeXuPmFqAmW02kqkJoUtHE29r1288KRizZqVabU=;
 b=nQ/k0M6XpYOKD49P5G3KAHC/1poONdanvKszm/fZQrtOBGLXX/WQQOnkEZUHAh61IQ
 cKJ4WrCGs3QnI51/gsh0M75kGKjzPL5Ye6/XdWjZdhW/KgtulfFk5Jg4FA4xlx834Sf+
 HyF3/WCWT5tmOS8jxGykqqmpYHMYQM2CAhAJSbv4LwoZuzjkC6/hGXqVgV42MwLBPq6p
 GD9H515IPxESYj5HcMSr+0TMyqkvBYMn3ZafPJT1GiMqyUaxRMMnf9bF9w+mh+gx3X2z
 0rZLtVpF9WnGxHcalGEupK2snntjhuM91BYhPWPXEyK7qi1zdEvMXpyIsIsOkmBfjhEO
 uNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716257194; x=1716861994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LxcANeXuPmFqAmW02kqkJoUtHE29r1288KRizZqVabU=;
 b=xHZ0pOItpQUkjbo3WPFvh1Eqb1UKhRweautTQcTeHRQMG5D7I4KxVMfMi818fEck+G
 YXLG7XinifGpOMH+HbtCUQkXUONdPxy8Q24XzYQMO4/26gcY9nPoFDBNnnwZAJAIF6kt
 vYLdryugI3obCKZm5/WnftTpxFik8tQIXOdOv8ijyLAohiR4eX54InBzxhegQBzcnU6N
 P2BSAoCrwEWvWD5cbBH5eo+fBy/qFT9jyWS/Ntk8/qdCm5yCeOQPu9xLijgpptf5avfA
 dTu9TLu6kwclGYJ/prSthndkzi5hHZtatbwlasX09GrODCnC3Q0OdfHYMV1BXwJPuuUi
 QO9A==
X-Gm-Message-State: AOJu0Ywc5m1kIJbC4Wrap8rKdkSstYTE3YH09AXcLjp0nO+c1TgYhNV8
 LfyY+zl6SYuyOmleGwSjHv2KPaDP6toBm2BhVUYHbhn06ZFp2f2PGqSZ73ied4+pbsmIvTfDnHT
 ZjwmDIopEap8CCLCasrE0cLThsbY=
X-Google-Smtp-Source: AGHT+IFDmQY7u06PihXp5cMVIKi0p+E2txA5DWB4jJ75J9GBVpqMe0IC6JrJFjO01YRyH1n0I4X11757RHxub7oRIYM=
X-Received: by 2002:a17:90a:77c6:b0:2b8:ff5f:32df with SMTP id
 98e67ed59e1d1-2b8ff5f33aamr23505135a91.34.1716257193640; Mon, 20 May 2024
 19:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
 <20240519-qemu-xtensa-v1-5-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-5-8fff0cb11c19@flygoat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 20 May 2024 19:06:22 -0700
Message-ID: <CAMo8BfJJfK9k5SQOcYzcWELyH=BGOb6Vqa8CLPaCNdUk3Qe_nQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] xtensa: Bring in semihosting headers and config
 options
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
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

On Sun, May 19, 2024 at 1:53=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
> They are all directly imported from Linux kernel.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/xtensa/Kconfig                              |  27 ++++++
>  arch/xtensa/include/asm/platform/simcall-gdbio.h |  34 +++++++
>  arch/xtensa/include/asm/platform/simcall-iss.h   |  73 +++++++++++++++
>  arch/xtensa/include/asm/platform/simcall.h       | 110 +++++++++++++++++=
++++++
>  4 files changed, 244 insertions(+)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
