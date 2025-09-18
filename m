Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE524CAC597
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 10:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C7E81E13;
	Thu, 18 Sep 2025 12:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HhOhxON6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76CD382C84; Thu, 18 Sep 2025 12:09:53 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5774580107
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 12:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee1317b1f7so249387f8f.2
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758190191; x=1758794991; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnMW8GGPessiptCIo5arhow92wOVnt+LoNKUi7yvA0w=;
 b=HhOhxON6fJp/3F5qoJBXUqQDloYyhi5/FLpQb8XsQJqxIRzX/emKArNG4oT3PbX0hN
 JFX6kkPytO7OWADBn4ewlA3Cpojl4sIFBEWTeY8sS5JAehFgdqvZQfYLWbE5EvtmZr2b
 2VDGvRQZ92hGTbd5Pz5xQImHESBNF871wwvelU0cejlVSTteExoaBeD5FfE4YnjjVeec
 PC7aJT5Nj7E0HIE+JHpeqBqrciaRCyUMdCrPaGKu9zMANxyo/9TCfXjSpt4bJdNrYJob
 Oi7CnAM6SFQ0cXAdXBO8fBSBh21un9DdOaY1PxTquWyFG5tJSvORhXLUm3P3dfp8Iin+
 DjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758190191; x=1758794991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnMW8GGPessiptCIo5arhow92wOVnt+LoNKUi7yvA0w=;
 b=YalUh1gznuJEKw2nSKizM979x52iDGj503EZ8URBdgJvcsDBf8tBqAf9E+NMp0/sLa
 ZeX75HsJ36BYLLblktPa3qFkEbGo4EFO51FESsdYf+GPlmmEPnaLBu+R75mpCcetmvH+
 564qclcH1TeNpdayRG3X6sI9hCHyBQoYnPvoj0JZ7fUXW4sA+UvbjqnEfBSimTRGyeKi
 DoSIJZMPHYco6l8OP0Krw6OHdNitKlMFZ0S4vvwL8iK7CfN+XMrnC23hnLW6NGr9VS0u
 fac0nimQzi+2vHH86TMB54gq2HaMNKXwzvO9tdjbz1cSevo7o2GG5LV/VgYnLHkasPUa
 dbuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+aFNaEC4ETI+quN3SqEnyWj8s5Q0k1FPtpBGz1As1kzrGDjQm/voCJWxDkU5YrJN6FilCrTQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6P1NYjBzaHWIuTGqjdHPcL95wjVodYF111ow5ZmAZ5PQ9Anx9
 ie1uljhKwRJIYhjhFUngX+D1lxMqKj9XvwD2z1JqknniZg7MkdSq+iOvLPP6QyuqOo+UUT/0ij9
 7c3fa1phXCjAffMKYems8of8zMGuVFnr+w6SfrcE=
X-Gm-Gg: ASbGncv26fjX8Nw42GA/VlbXZE5RsVQlCLzQV1rQxX/afXVOcHZ+S+bT5BxE+1/BnJw
 Pld+eDPOLQ/gxw3f8Lwvqoo3YYccX0LaEkBXGzrQSs+P1/8zzg63ynJIZ1rbyHRtEwN427IYIds
 cBOYBjx0fwNwza81AWise5pQfYbcIrPVRzJ8J8XTY+M+ErMaBERdxkBgsy7ygBPkhgwUwzqmvJJ
 N57uO2fO9NoN0NMHGmEkm769Gs=
X-Google-Smtp-Source: AGHT+IE6pgt6ltWUHsCPXuCMpwju09M/KKNXJhVXRehoiSKrIDEpBW4e3VMAPByVZ0QYUy43PVMgqu4uOZULU0FaRuA=
X-Received: by 2002:a05:6000:18a6:b0:3ec:db87:e8fa with SMTP id
 ffacd0b85a97d-3ecdfa099e6mr5791882f8f.26.1758190190547; Thu, 18 Sep 2025
 03:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250918084207.3862049-1-lukma@nabladev.com>
 <20250918084207.3862049-2-lukma@nabladev.com>
In-Reply-To: <20250918084207.3862049-2-lukma@nabladev.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 18 Sep 2025 13:09:39 +0300
X-Gm-Features: AS18NWA_UMdLwizXNRzGRwWF6HxHMUdobuap1AgCdhsg5lJUqBh0MlaiM_F1Xcs
Message-ID: <CAPVz0n2rT_P4WDD9gHg37yRSbtJg0oATg3FsWHh3_yW7kFeurQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: Add implementation of NVIDIA's Tegra
 watchdog driver
To: Lukasz Majewski <lukma@nabladev.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stephen Warren <swarren@nvidia.com>
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

=D1=87=D1=82, 18 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:44 Luka=
sz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> This commit provides support for Tegra watchdog functionality.
> The WATCHDOG index 0 in conjunction with TIMER 5 has been used. as the
> same setup is used in the Linux kernel driver.
>
> Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> ---
> Changes for v2:
> - Remove () from defines and use hex lower case numbers
> - Move check for timeout range validity before first register write
> - Remove "nvidia,tegra30-timer" device compatibility check
> ---
>  drivers/watchdog/Kconfig     |   7 +++
>  drivers/watchdog/Makefile    |   1 +
>  drivers/watchdog/tegra_wdt.c | 118 +++++++++++++++++++++++++++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 drivers/watchdog/tegra_wdt.c
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

With minor adjustments applied to u-boot-tegra/staging, thank you!

Additional modification to colibri_t30_defconfig would not be needed.
