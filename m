Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BDFC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9C4882C9;
	Sat, 30 Mar 2024 20:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GhcfUVZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A9A882CC; Sat, 30 Mar 2024 20:48:26 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61037882C1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-29f8ae4eae5so953881a91.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711828103; x=1712432903; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFFVsi5xdklqY7iQa7PBsO5lUXD3kcn5fMtiJFy2XkY=;
 b=GhcfUVZ5B3RdCJLYLAgAPgqL0lPuAhj8f9TR4gwFXCyZl8x5SKpVaz7zxJel10mfRs
 XW9ySvpRHXJsuJCHHJwvsWVlepgXQ6rpPwB6lCNrEX+DTmVOh5Fz+qi4SAVdfex9yA+N
 +4ILO4uq+LMH1QRVjI9JvsaIqb7Tm2fnObjozjKYRTKpYgGLkuSQzZDFIR+e+L2gNAAX
 NfEXUWF0GTouFlIw1lHaYR10fzLfoBheqLyH9cqUuqLTvyBHUtU8IIDGrIMLZ7/Jv488
 J8yfMpL0DAUHqfiuP8uTGJLER6/Bye9P38i17bRN3L3lKXIMVGOt4NBgzsAoIob9Ym5h
 qbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711828103; x=1712432903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFFVsi5xdklqY7iQa7PBsO5lUXD3kcn5fMtiJFy2XkY=;
 b=DLs0PemtcHftGgrCSJElDA5UQfXtEqQw6Y3qhWYu6mlaDk0AhfmIpgP9hs3OPYdsz0
 /tjAm3d2DtvJTFfwxdGTkLqMVGCOvf0UDVeQnV4MLlf3ST2RGY3KO20BAJzr/A3N6RMf
 f2MHfvyF630sCLluiPIb2RpLdDWslni3m0I9xaUExuaUAkyaC4YQW6JL5i650yhB1D4i
 5OdT2fe4zomyL+Bkq9mmvDimEAGnQ3Nr3F/bjHzREof9D4CPgrggfzP0fYkWhuuJBlm3
 Jb5iJ9lKCEJ+R6RxP6BoSOLgf7WgrBDtuYNRbvqmDScz4LlFky0KbDmO3CIW1mm5yHUC
 t4bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7RBd3Mx4xhfI1beVDnn7+/ZntJIHpE3ihvUjNL3SqnrSV8necmt9I+dLjb3xl59AdSvvsomHknQapo8eU3reDMbkcoA==
X-Gm-Message-State: AOJu0Yx067k+gxrOGoPBz24Ra6W6YHQiYER//nLOY3jYQ9BeBlrnWLtQ
 1nwPKey7vnQmolOnevZJUivDFG6gxx6nhkUCeYNPYwun6e2evVsTj2nMvzUqjVPLsL6tEOhFWYU
 PCbprwUsfOJxq7gVzABPP8hBZnww=
X-Google-Smtp-Source: AGHT+IG3dfxwVnPTegMp832rHdO4PDa3mlpheREGvVTbRULSaNxgY2zH5Plmphx8h4H7f5h/k6QZ3p5mOSdHZeIZSh4=
X-Received: by 2002:a17:90b:3783:b0:2a2:2d11:c637 with SMTP id
 mz3-20020a17090b378300b002a22d11c637mr1451128pjb.0.1711828102934; Sat, 30 Mar
 2024 12:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-imx8m-v2-0-7656998cc8b0@nxp.com>
In-Reply-To: <20240328-imx8m-v2-0-7656998cc8b0@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:48:12 -0300
Message-ID: <CAOMZO5DDmfi2=2q9g7bgKtK_6G5pYe6+iqbrKy6K2Q12mXqiTw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] imx8m: convert i.MX8MM/Q/N/P-EVK to OF_UPSTREAM
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

On Wed, Mar 27, 2024 at 10:46=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> This patchset is to convert NXP i.MX8M[Q,M,N,P] EVK boards to
> OF_UPSTREAM
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v2:
> - Sorry for the quick respin.
> - Drop the dtb build in arch/arm/dts/Makefile
> - Link to v1: https://lore.kernel.org/r/20240328-imx8m-v1-0-2be5e6657a88@=
nxp.com

Applied to u-boot-imx/next, thanks.
