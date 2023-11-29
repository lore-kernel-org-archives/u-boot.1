Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E141C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DED877BD;
	Wed, 29 Nov 2023 19:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="avgqmTSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B1F7877BD; Wed, 29 Nov 2023 19:22:32 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E688779C
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2809748bdb0so17662a91.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701282147; x=1701886947; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IJmdDyT2/HGzK52pT0PFzGWMnOWC2JjSGm7G1bGqBU=;
 b=avgqmTSuaO0kjH0XoAR67BCtzZZwwmjB7jYRUnPjrl7DwNkiispyHJm0R2MlIlTq/k
 j9UH6aMLflrQaqKZ6RcGFrQ7l1BRVsdT00O/mGN+EbtlqAyh7JKct8t0M4ba7qf+gElO
 XCvGGuczwA5/eIhH0GRUbdundVjk/ja4qJkISEaK0nsMMm0J+5HSTdw5OorEMxj9fezm
 WvXJEQF4xhnyRzzCCMn+X/QxqpX52NTVQy48KGxoRxD+g1MrIBMNTJ0qAKzAfi1EG5ap
 ykR5f0AmJzdh+ozApv+vaT0JXH9HwmNLqAZzMTnBiQzyPkNTDNuHCLKtXSLtKTBp0GJB
 fE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701282147; x=1701886947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4IJmdDyT2/HGzK52pT0PFzGWMnOWC2JjSGm7G1bGqBU=;
 b=Trh1UTujKsEFa1ya+N5nHfQgZQLCP7RfoGEdZfwXUwY0EjDpsuMwrtoRfsWdyrzLKG
 aur1vIf7/22VOGtOOlrnvCTydK0ftvIbC0ndj+e4vcxWI9aF+3vkRkkWAXaH5g1fLjmz
 ruqgO/AcuCnAFUIdYhZR1N/x/8zGcCmpOJ5D76d44wYh30vtcNlNIRSXbjR19ZfxN9Z9
 PUObEpg9zqS8ZQsAUc7Sf4VNyqjvzMRfAGA4EfjCOw7CUpimHOoUCdWKtfzjdYaVo2SU
 i2lcFxyFpjCKmCQUKCAxCcp6FnJaURmNQXJ/Hqui5dYX5+uqVXfpR3xeqO9jKrnFPnQ/
 L12Q==
X-Gm-Message-State: AOJu0YzdXLlx1RUfr4ieZ1Xa+lgDv9h9g6QECy5uYDsoU9lt/rRI8lN3
 Fih0X48IgykQwO6pv9zmRh4Dy2LXBp1kWXm51VU=
X-Google-Smtp-Source: AGHT+IEMTrkyr/VsO5oBmPOpimBjNvVvWDQP2SzB6Wmj7dAVm8oZ8w1qyiVudeBj1dXmr8Qni1kVs0mfqXj4tgGvZWI=
X-Received: by 2002:a17:90b:713:b0:283:5405:9e90 with SMTP id
 s19-20020a17090b071300b0028354059e90mr19266356pjz.3.1701282147281; Wed, 29
 Nov 2023 10:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20231127193658.685119-1-tharvey@gateworks.com>
In-Reply-To: <20231127193658.685119-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:22:17 -0300
Message-ID: <CAOMZO5A-kBwAXvEa0nCxZzDgSh4rjtO+t_oXQb0+NJ6T52rKyQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mm-venice-gw72xx: add TPM device
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Mon, Nov 27, 2023 at 4:37=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Add the TPM device found on the GW72xx revision F PCB.
>
> This hangs off of SPI2, uses gpio1_10 as a CS and gpio1_11 as RST#.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
