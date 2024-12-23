Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F47E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CED280655;
	Mon, 23 Dec 2024 14:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EnwIw9p8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ADD2806FB; Mon, 23 Dec 2024 14:20:47 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525B88062B
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53e384e3481so3836000e87.2
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 05:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734960044; x=1735564844; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvxrQpaY1vgpVWtJdvBX8H5TU7eCM30xp3xOaoXJ4ng=;
 b=EnwIw9p8RJ0W5ZHdEylILveWBAvz30HpnFcvmCwKRUA6NDKkmXcYyV5O4v7O9hmKmD
 l5GqzNykZW7uO/7SCpPoSamduGUdt4l0M3DP/TRNXwcBVlTx69sWgUHY/NIRLG1KI0Q6
 kFKYrf5arrBemccH9fRWCuItjFr2Q+mg8QE21f4MY8EB8oluWu7WnCdJYKy7dFe3D+uW
 g6dRDYzwrv/JKtjPyg+sYrDzZlQswVqTm7DzP8LUbR2a01HfjXGfUdBEPEtt1oemYPgz
 6++9G3fFxXY5ynJGJYH8/FZd/UIUKzMJXLeD1zjws5QcfifANs8a1ME2MKpiWDh9eCmT
 hwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734960044; x=1735564844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EvxrQpaY1vgpVWtJdvBX8H5TU7eCM30xp3xOaoXJ4ng=;
 b=cLe6VM7CooaK/qm7diQb5W0EkUXhSMAFICPNS5xOZnOTsF05BLAUuAHD6iDUjuN45m
 e+zIq6wnD2gBfx9/X1mfao2ZZxkjBfExo6W3vfVBQ8kVc8ulhOnyhDWsUL5U41QUgMDd
 qK6Js0loIS8wbF9tb62qGpfsjLsRazXBsCW7SvP7iArVyoRFddc3JFK2GdYHIuV8LNS3
 1dlhPj+qNj8GJ6mMU7bIWBQQMDmdGr2XLLJtor2+nYoXVGrEK5fKw+XTHXqXK/vvuF3q
 /XquKqdFFp9VXCUH2Q3kVvN/Dc7k/fbvgMq/bfE5vHtpJqF9On6lGD8ijZVWii2V6AoE
 eQYQ==
X-Gm-Message-State: AOJu0Yz2ot+Y+sbbEUqRTLHJkVsvYtR415vriP197FLze48tFagpj+Yu
 8+0m1KBWF8sdcQaz5hFPFCygvimnkI0qBrWIH9yxZhDx50OXHzoGLDqaPXofnmjmXKsxVgxrBSu
 +dqhzVXx+0eKvc173p6Wx5lfddr8u3g==
X-Gm-Gg: ASbGnctK5Lnyy1bVApAJiHQ8KCp2/ltCN+0vrN0Omt7ip6+XxNSJb3j5vdOfM9DfEHL
 Q9uaC+BFMmsfAkY+sfQpk+DvnSxanKo4yphkzjHxOq1kDF1pYbmYDuVEHsU4gPJhF0YNQ
X-Google-Smtp-Source: AGHT+IEFrf/qDkf7g5Sb/EryCDGyzTpwOnlPE4qiciHYHSeVZysPaWXMmNpeJRDdrtFZ7vyQ9IPVJWTnX//1yt/LHno=
X-Received: by 2002:a05:6512:6512:b0:542:297f:4ec9 with SMTP id
 2adb3069b0e04-542297f4f6bmr2893404e87.14.1734960044443; Mon, 23 Dec 2024
 05:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20241218194731.1867864-1-tharvey@gateworks.com>
In-Reply-To: <20241218194731.1867864-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Dec 2024 10:20:33 -0300
Message-ID: <CAOMZO5Dz6K3o8ntY_SWPNn7B=y=p37piu0e=q+i0_d+ZmDgYSw@mail.gmail.com>
Subject: Re: [PATCH] imx8m*-venice: define suitable address for
 SPL_LOAD_FIT_ADDRESS
To: Tim Harvey <tharvey@gateworks.com>
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

On Wed, Dec 18, 2024 at 4:47=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> define a suitable default address for CONFIG_SPL_LOAD_FIT_ADDRESS
> to make it easier on folks enabling HABv4.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot-imx/next, thanks.
