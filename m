Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6576C48BF6
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 22:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADC3D87D2C;
	Sat, 24 Feb 2024 23:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HSPyRvj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97DB987D0A; Sat, 24 Feb 2024 23:14:53 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8753A87D2C
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 23:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so836324a12.0
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 14:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708812880; x=1709417680; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBmWj/jLYo/QcnO1vf117RSR7ptB274e4VlsTv5rcIo=;
 b=HSPyRvj0pym/F7hm0zB7uIewu4Bq63/yBbpJdbyRXgEf4M3CTa4igEMdsIT3CYKpbn
 4M34nNeQPXktFvV3xb5IfpT3ksUVfzb5A68SFEukhoLQxzHyxeztD2gmxwNypw8HO9MX
 G2jf7n/7B0kkHVUylqVLVOvNpXG+7ukK9TeAUeuN5XwgiOV+MpYUOg8SnTJIBkM2wRL7
 QZ4E6/ASlu8IcG+Geb5h4OEHwft2qpDTClD6d9U+NoeZCvtw7UciFsq21YJTPq5X+RQ3
 t7xZA/+sLIrEYKT+D7Ej4RaOIaQOHH/ZwYCdsbYnyrQfah7kVTjwKxPFxedI8M9Cw9Dm
 k+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708812880; x=1709417680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JBmWj/jLYo/QcnO1vf117RSR7ptB274e4VlsTv5rcIo=;
 b=l5lq2vRROxi8xpJcKtTZ2M/JCEAHz+D4baH29Vt9VicEjXquwvliYFq4y960RAQxe5
 cfHPtXbAbcYjNmi+YeErlBmaylNJt4696bKv1FLtFdeAotH5P4yFq2KvVKpAk4f+ilBc
 IfeQRUEwleqRSURxd5P880bLEOfdgcitg0l/cSYXaQ0PodC6B2Y8LzZbncfCh1QNXTiA
 r+EohM7uw6ubNoiiP0Lg0ewkPKq22/OkNGIwewlL4cTc5pwwqIY5x8utDdmWyKoweDRG
 DoKiGfRh761A7CaCHeMOBIg4C2JOrv6Qv3VoKjnHj7o6jQt/L6duldxCddYtVdfk1Esg
 zp0w==
X-Gm-Message-State: AOJu0YyxsmUwRwaZYfeWaf99o7VXCNDTUkQywEpNluYtKnSi1dGSeZj5
 ynhMBRwqLxN+snUIpgv63EoJgNBrCKTPR45wMd8s6LCPyKqP728a1BlcbX4hNzoQDw4zlXRreu8
 veO8iy5Thv+2SDjXeNkkeKAMtNzQ=
X-Google-Smtp-Source: AGHT+IHcP2SaJmZyQrMnF5pLvDq1F5hpzD4qryd+q43IMtdXx32XLdEuhsgAHnOrToxLivFLVlsRJit01XQ8k8jXqJ8=
X-Received: by 2002:aa7:9dca:0:b0:6e5:9a9:56bf with SMTP id
 g10-20020aa79dca000000b006e509a956bfmr391066pfq.0.1708812880457; Sat, 24 Feb
 2024 14:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20240223112804.15559-1-sebastien.szymanski@armadeus.com>
In-Reply-To: <20240223112804.15559-1-sebastien.szymanski@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 24 Feb 2024 19:14:29 -0300
Message-ID: <CAOMZO5AegjcxeZcqHjSMkvbYU90CHjEWC0JoM2us+6VuACdm7g@mail.gmail.com>
Subject: Re: [PATCH 1/1] opos6uldev: Convert to watchdog driver model
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Fri, Feb 23, 2024 at 8:28=E2=80=AFAM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
>
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>

Applied, thanks.
