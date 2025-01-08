Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B91E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 21:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F11800D0;
	Wed,  8 Jan 2025 22:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c/0Mxy+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4DE780196; Wed,  8 Jan 2025 22:10:37 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F828001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 22:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-305d840926fso1083881fa.2
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 13:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736370635; x=1736975435; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5KZnVnA5TQbhBqnsCE6eHyYTu4axY6MuS2yU8ttQSo=;
 b=c/0Mxy+jVCXq4csaqWRX78/LgeEHn1zG6l8I9yz8PC9D+5ceCe46eA6c7ci9lUVJ/q
 UnvrbsoNc1O7Y6Se/QYWjzWAK+95zUS5CVv4lHL0ok5fb8mXpTD+NdV6wmzMw0F0MOlX
 LxTyIsM4alGOr6F7sec7G6guG5vejyrAUDpayHf+9cL2J1TFWPJtBOyzEXG4DPQEMFzH
 gG/vWB0aHRmAKNHi/68pUMBqHlymBHnqPbzE5Uo9mf1EnezDw6V1GAdiY8Bt3ZN1dazd
 aSFVDbhpsc97YLYrYEuccjjub/FyAIHD6X8exGdtsQu2l83R9EkOWmppUQzXtr5cHtNg
 iOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736370635; x=1736975435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5KZnVnA5TQbhBqnsCE6eHyYTu4axY6MuS2yU8ttQSo=;
 b=NRofCSEhelUWSORdpf3hzhqvrUMPI5f5PoFX38wSGcrcbIesUhYlfu/+belTfLB2oO
 YmTHljAoclVODQ3tzeaMK64D0t+lppy1d9F8GOBobOnm8RWMIlihNaq3P6/v+yyLNcg+
 Wui2VpWN3fTMK2No9bn4HL8ja8korZoOtnLUtjL0eZj9LzlppkEkSM4XITtsEdhZgVU4
 +vEquyWakUrzmGL9qS/M2vb/OcRaNvBb3z//K3iz6YhK+RFrUWy2JNQ0Mt0lrPtVn+YS
 Iwo2tkImT32nwxHECNdbBva34G3gh4/71AW9ZhX2j9RsHgbmzMJs1MXUY9VOWdYP9r0j
 dSMg==
X-Gm-Message-State: AOJu0YzI5vDnp7HVJw9XRnTh//aeWK5POJwqXG+CltmPq6jkEQnxl10p
 s185wTmVpQG2Lxe3NXcpP5CCQ6gHoEsWSFwY2xa+AsSbDHEWaldUJmJlR/G711jg3gkPoyd0Wmj
 9ecodVSWW1TMH7OP0tO1DzjVKvJM=
X-Gm-Gg: ASbGncs4CLwAFGswOTSctFG1tJ0BnhgVTMklWzO34Bj+scTj1aWTLszrkq2MJrAmzrs
 +D9pxKzVzZZLZx/8MHcvERd5sNCQTEndL0I/IQSiS72269YBohiKV5VVSb3BNWf+hIoJdpw==
X-Google-Smtp-Source: AGHT+IGnxyvLP9ShVsCABs2ANFAqs/lC6HrdQtSWSoMG5s/xdvo8YJT9dIvTthUL5n8d0v7ugHC9dIP65n4ZovPLAa4=
X-Received: by 2002:a05:6512:4024:b0:540:3566:5760 with SMTP id
 2adb3069b0e04-542847f9ea2mr1269643e87.35.1736370634535; Wed, 08 Jan 2025
 13:10:34 -0800 (PST)
MIME-Version: 1.0
References: <416280384.272214.1736325010687@webmail.liwest.at>
In-Reply-To: <416280384.272214.1736325010687@webmail.liwest.at>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 8 Jan 2025 18:10:23 -0300
X-Gm-Features: AbW1kvZwGeaev3OeMIxzVc-oQkFCYoBgoXeAMuNViMw67WAfSLK2WYUR0PxRa30
Message-ID: <CAOMZO5CZz49YBL4YtVY-O-1e0sv=8g0EYXOatg9r68Osrivxfw@mail.gmail.com>
Subject: Re: Issue JTAG debugging U-Boot
To: tanjadeu@liwest.at
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Wed, Jan 8, 2025 at 12:49=E2=80=AFPM <tanjadeu@liwest.at> wrote:
>
> Hi
>
> I am trying to debug the NAND driver (U-boot 2016.09) and ran into the fo=
llowing issue:

That's a very old U-Boot version.

Which SoC and board are you using?

Please give it a try with U-Boot 2025.01. Maybe the NAND driver
problem has already been fixed.
