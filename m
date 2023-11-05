Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFE4C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 14:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C392C8642D;
	Sun,  5 Nov 2023 15:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mWXeDFgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE2E286F23; Sun,  5 Nov 2023 15:07:04 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 666F58642D
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 15:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-543456dbd7bso9156051a12.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 06:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699193206; x=1699798006; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TwxqI2UwRmrmBsXajK/iCN6nZfT3wEd01Qx7qZ9Y94=;
 b=mWXeDFgEinZFz8Sbhh+s/j69imL4DhPCGgo3c03mwOqV0got+211zAhYpuDUFFge3g
 1IxnFOmVdZD2EC9iO5OWXyN3AWGm4WOwXS1ZCZ/5y041GIRuhhT0z3hzE4zO2h5WfnVO
 KG8C871cBS0jKprk2tChbBwdDKwZzV2HtOQ7/W4UJBn1tkM0UbZYZZCwFqCEQMs5pq1r
 NxYmm8JTaqtj/suj2S1Cm1GiTv6zhx4+rg3O7oWu3VrK+F+Ii/BiAfMV+OJWgAWQppfW
 QqaGb3N5eADir65qaK2+ypk5YHwyDJmia58KAttzj8vXyZ3oJnX6cA215XqhvMIofEej
 jAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699193206; x=1699798006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8TwxqI2UwRmrmBsXajK/iCN6nZfT3wEd01Qx7qZ9Y94=;
 b=XF20JWZvSz4rHaC2FiM1wIAMGJdIk+vJT2X7xXxeAyKK836JE+u6BN3bVSD1IDDgAH
 uVbAvKGg5BdhVTj2WXFVcMYg5ceIdRJDqY6iqD9wAX3o/8saL3sPcX2MpyPARhmz7hVl
 cGZ1vZZt97+TrfDseVhDKRaQ1hGI0zxmVzYqDAiDiNbTKRb/sEO4to3+hKlYVGEv4BQf
 9Ne0ZBRsMZKMuGZ8lPIO+rOGIMSL9TCEwjKmGsI+Ur3xqryJuG3rQ9Mzrcrz9pH8/3RF
 GcUlfxBzqV5sxMaXG3W9LgauHvcG6F055VgKB1DxjhsoFcO5wyu9jdD7+ttSAGrRe98Z
 Ao6g==
X-Gm-Message-State: AOJu0YzcgjGksqRXsWoAg32xgDBydCg/V80guVQXm64mjMrCLXDUhZA6
 cy5Rippsnebl3jBqVF380rcztoft5XC18Aux6fY=
X-Google-Smtp-Source: AGHT+IH73FEY2HWThCLrsNTxhJ3Du8WWjDhKH6UZ7aiTAiPPKM+A8fjGURDTmYbUzffRvjzR903aeqyMFMvNiKtKZh4=
X-Received: by 2002:a50:bace:0:b0:544:3d4d:db15 with SMTP id
 x72-20020a50bace000000b005443d4ddb15mr4385263ede.19.1699193205724; Sun, 05
 Nov 2023 06:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231001191444.v3.4.I134d949e881ebcd532e927119703b28747fe4c53@changeid>
In-Reply-To: <20231001191444.v3.4.I134d949e881ebcd532e927119703b28747fe4c53@changeid>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 5 Nov 2023 22:06:35 +0800
Message-ID: <CAEUhbmU_kjxj8gCFVJvHYa7it5vgihgyCVLB_DJny8+ct=vWKg@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] x86: coreboot: Add a boot script
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

On Mon, Oct 2, 2023 at 9:14=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Provide the user with a list of available boot options. Selecting one
> causes it to be booted. Pressing <ESC> causes U-Boot to return to the
> command-line prompt.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Clear the screen before booting
>
> Changes in v2:
> - Add new patch to add a coreboot boot script
>
>  configs/coreboot64_defconfig | 1 +
>  configs/coreboot_defconfig   | 1 +
>  2 files changed, 2 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
