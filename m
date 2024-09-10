Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53368EDE994
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 01:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3133288EC9;
	Tue, 10 Sep 2024 03:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KRr+y/9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A14588EC7; Tue, 10 Sep 2024 03:59:24 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5627488ECE
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 03:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f761cfa5d8so26523661fa.2
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 18:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725933559; x=1726538359; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTiAJW9H7EzUEed9wY52zpbZsb24UnGAFEGZAbiqVW0=;
 b=KRr+y/9b52S1P09QPZoZlLt0LTJ0K3LnlMPlJFBQKNO/NnD/zJCzRMns7Hn76jmYKH
 +Bv0i8TzsNVOgRwPup1aRazJ1jRhcWBDgDSkdbeOM4dtT2Rl4M6LdoqgKOzRjZL2Qzay
 moC1yp81D6pWpplYwxHppC/MMd9/RKKLbKKFFaVVl/hZ8IRT99FyqHzKoQsDQPaSJUP+
 r3FALxoGtQwu+cMOh8rNjnjgsDSAGiPJ2PINt0aAGAjU+UNLW92fWPUTigS1napbW1cT
 4dOfoyO0pcxS+WXdpvb310bsD1ZW+P20RXH9ZfZUhUwC6lBsp+MIs0O/i0Bx3MyZZxgG
 JWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725933559; x=1726538359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTiAJW9H7EzUEed9wY52zpbZsb24UnGAFEGZAbiqVW0=;
 b=W7ZhFBC403/M7/Lo8RbmMKyHMOCOMAeBFdEdrFuPqGRYRFsaZ4gjSYSofQ1MZcqVeg
 1M4sUph9VqK5a1GlmYHjXlk2enVB+Ve4tVdiQ5r9vf6x8WCmXEck5RlCJKHiH5JFTTMo
 cEUY+umQAm68DW9YJvDCeuPM27SGaTMri9e3lcnKzw6Ib3jPI+1nRiYFGZ75fPDFqnSr
 weXtE0i7MuW0U/8XNULlUnuZlO7aoX25ZUvwex6VH3XMesqv2/NsN6UHyZuRJBUJsTX9
 f1+AzLGVpJci4NheaEKu6ZLARNNHeJQgdsEu0st86hlCFfcy3mWEzcgnAu1mcwnm+ojR
 a6lw==
X-Gm-Message-State: AOJu0Yw1zvQK8qZI5Vb8aB0RSRiRqyYMvsbMux1w0XZKpkaZu4Dtjfu1
 W4E4QECbt0pqFSkxJqXaJibeRltXllqkkM3a8KtM3HC6YUFTM9dn+ay29SSywjmifOO9/fP03Jg
 ybUa6FPYGLSt9ol3uKKkTEWv6+Ok=
X-Google-Smtp-Source: AGHT+IGCYsCLd0ai4GHqp5A3aWju2kuUFCxxR+AWJpgv5UgPqMxfsYciHW6c+hDsZ5ZdAZgCkLLEIxqRpoMLKFk/oH0=
X-Received: by 2002:a2e:a555:0:b0:2f3:b582:a914 with SMTP id
 38308e7fff4ca-2f751f86672mr100890961fa.41.1725933559079; Mon, 09 Sep 2024
 18:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240909193003.707732-1-festevam@gmail.com>
In-Reply-To: <20240909193003.707732-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 9 Sep 2024 22:59:07 -0300
Message-ID: <CAOMZO5Cjiibe=rsSFDrMUbch2NGNxok6WAFvoEKC=JvwDKmo=A@mail.gmail.com>
Subject: Re: [PATCH] imx8mq-u-boot: Pass FIT offset to fix boot regression
To: marex@denx.de
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, otavio@ossystems.com.br
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

On Mon, Sep 9, 2024 at 4:30=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Since commit 37e50627efac ("ARM: dts: imx: Convert i.MX8M flash.bin
> image generation to binman") the imx8mq-evk fails to boot:
>
> U-Boot SPL 2024.10-rc4 (Sep 09 2024 - 16:08:22 -0300)
> PMIC:  PFUZE100 ID=3D0x10
> SEC0:  RNG instantiated
> Normal Boot
> Trying to boot from MMC2
>
> Fix it by passing the offset property for the FIT image, just like
> it is done on i.MX8MM.
>
> Fixes: 37e50627efac ("ARM: dts: imx: Convert i.MX8M flash.bin image gener=
ation to binman")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
