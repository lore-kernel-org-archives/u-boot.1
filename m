Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394EAC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF1586BDF;
	Thu, 26 Oct 2023 16:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U/eCYi3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EDA4875E0; Thu, 26 Oct 2023 16:26:25 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95DD86484
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6bd20c30831so211377b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698330378; x=1698935178; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4AarLQyIU2DVRIqTvoJi6oztjOEE59AvuW8aFMgxdw=;
 b=U/eCYi3UcStEPTLj8Tg+5WPHe4/Aku3uO0E8IbIIQazQdDUy1CjgE7lX6c6/Kf8u/U
 c44ok/c4YLK3Sros1q2q69Hzse6/pE/kjWZkSLSQr5lbZxrTF47f4NensygOx7JvVqSa
 81EUNIvzK1J7gIwPacqMBzJtBH5FlTWQ2LiarfvPShj81akC4glRbvIzQhiNw6DGLyxR
 1dyv/SFXyAAqtZA21k/T8jtXteIQBvLttcBtCVSWGlSFR/WM7ob/1+5L0XDZGL42Aclw
 kRMbqWU3tU4J14tNAQPVOQ+VnqdIiFyjF+Hhde7KSNDsu4iBKQy3mKKDUt987TvRomNx
 MOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698330378; x=1698935178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4AarLQyIU2DVRIqTvoJi6oztjOEE59AvuW8aFMgxdw=;
 b=ucMyr4tmXM6WTgCqSfP9Zt4Mie2RRUIVtWZDvXkIrKHjx1RyQ/zif530JBevOE5Fe6
 7tuwPhgaljpCo7scvsS7C92gmNNSmGkHKd5FtvejGB1aAJaaqa3iEOKqYAnBaXVE7o5z
 vzoXnml+wDpqQlHSmdh6hB3y02Bcn++CxmghuJ+3Wxmndwg3paiw//Bc2kuIUkav2YVJ
 P9KJU5fdz0kK3t3po8YWapZ8W6C9/vGPM54N5A2zIZDPV13CRTm5FTtrB9a/HWQydYpx
 O02IRS1mrzBJm2pWfuhPlywT5I03C49jKvIKL8Gzupubp23zB0PbOlBS2T+bfggVC2IF
 /FNQ==
X-Gm-Message-State: AOJu0YwEou7GafrQlzDM3BkUP709xStGPmy7ERzjUigpB4yI7vCR19J5
 CC4XHfhB9w2olchxotxYO5OxuG3MfJvqky6K+hI=
X-Google-Smtp-Source: AGHT+IEQhpMbM2/YN94gEhKUDDkJzvMG854w1ivW4u3/zm8oc2Hfpko4731Z3/UMwihNhQuqX39UKCQgQ4QMXIeMN0Q=
X-Received: by 2002:a05:6a00:1a8f:b0:6be:cb8c:92c7 with SMTP id
 e15-20020a056a001a8f00b006becb8c92c7mr19775483pfv.3.1698330377692; Thu, 26
 Oct 2023 07:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231017205816.318531-1-hugo@hugovil.com>
In-Reply-To: <20231017205816.318531-1-hugo@hugovil.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Oct 2023 11:26:06 -0300
Message-ID: <CAOMZO5CpK8JnZZaeASMh17qgMSPzUct9m6vCCK=cgCQpd+Pxbw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mn-var-som: Fix broken EEPROM read
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
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

On Tue, Oct 17, 2023 at 5:58=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> On branch WIP/17Oct2023, the EEPROM can no longer be read:
>
>     U-Boot 2023.10-latest (Oct 17 2023 - 15:53:43 -0400)
>     CPU:   Freescale i.MX8MNano Quad rev1.0 at 1200 MHz
>     Reset cause: POR
>     Model: Variscite VAR-SOM-MX8MN Symphony evaluation board
>     var_read_som_eeprom: uclass_get_device_by_of_offset() failed: -19
>     initcall failed at call 000000004022207c (err=3D-19)
>
> Convert EEPROM-related properties to bootph-all so that the EEPROM can
> also be read outside of SPL.
>
> Fixes: 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node as pre-re=
loc after relocation")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
