Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12451EE57D0
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 19:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8D788BCD;
	Wed, 11 Sep 2024 21:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hPy14PUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03C9A88722; Wed, 11 Sep 2024 21:48:36 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A13F8880F
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 21:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f759688444so1973591fa.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 12:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726084113; x=1726688913; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZtWsSYfWDgSfL6DpVuREQbH+tm4BEvxS1J3d/3t2zI=;
 b=hPy14PUv7IDxU7sFjnaShjjZc0HugeLWeKu7uS81e57UZNR5u3oMpEtFrBwSqVQlI1
 vK4C/XvNXhTFJaUOEPzaiVI1bIDVzMq43RKFWwN+FzQG9p6eNff8KmZE9brbf9YSOCmH
 4GGdaO5T2Euc231OzzO0xyhHZKx4Sd/XT2knXohISMUyMRGhgXYJTCShB6t5/2jl/0Vp
 MT/6i/4hPGXTXyfBi1ZT3UqPrW470TfCBneqcNfuZD9UKEHieoRfAcLPNAa4L3wzQwct
 R2jq2oBeDD7UTh2onOx+ZNggqZi+0Mv883XRwy/C3sryiS4OzR07KN9K9REn69RAXW92
 Hpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726084113; x=1726688913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZtWsSYfWDgSfL6DpVuREQbH+tm4BEvxS1J3d/3t2zI=;
 b=TLJ3Ddc9cdfAMEJw6dCp7FJ+Y6GPmre6O8KCxRWJJzzaYbA4/H6F+U3RGS48CZyhLO
 bX/9UFdlEhcdjNWAaxIgQM8xAi3GaDmPwWF+M5c1LuC0jmjH2zzwMMv7CchNxjtgwazK
 1A8bfjj0TClVEmERllbMHlmwdPXNGDuw6P5FFFCOUEB1uQYf5+LnaJ+7yHqMEAos7oKD
 fxRorRYVNUKy3IVVlgBHX4y7bKUAqDFrPmRqYXfpfCVpfSIofUPfQSm7kAImhknGdD7z
 I9TtGKSAF7+hviuAiWYBQ5R7DtKXX6OzaMIpuZa3io3e61lk709rgXzSXHMGM0Ekw/DR
 7pfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8yCGWZA/8Vitbu8DQXuCEBuyyWX7z0xX8YplraYtiJERvRTGjiEOLs7UMnKL7xM/nVrhmbqE=@lists.denx.de
X-Gm-Message-State: AOJu0Yye/PfzPoWaJ2UAb448yJbKgM3xdBoTWEz94CAcV4CXiciC0kML
 AgeVxFrioWye3EnUwl7v5xwyx1oMvxp0kaw5rDJaDTo+OZ0mrYhA4ANqaQdo3/a4Q0Vp5rMwAzb
 GmR4NYAgJRi+tnLyCTSysr6W5XiA=
X-Google-Smtp-Source: AGHT+IF4QM5lPp2ChE1iVYeX/LL6Nt/rwxsaxLYsTSUNVOxUfjF6vG1b9Hy6zql+r/RSjkriGKP4aRPNnNX73VSb6vM=
X-Received: by 2002:a05:6512:3e02:b0:535:683c:cc67 with SMTP id
 2adb3069b0e04-53678fc1842mr295852e87.14.1726084112809; Wed, 11 Sep 2024
 12:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <20240910101344.110633-4-miquel.raynal@bootlin.com>
In-Reply-To: <20240910101344.110633-4-miquel.raynal@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Sep 2024 16:48:21 -0300
Message-ID: <CAOMZO5DxLh24w4owJ63z-aEfRtu0gct+DzGPbZQdyFBt7NO1uA@mail.gmail.com>
Subject: Re: [PATCH 3/8] clk: imx8mp: Add media related clocks
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

Hi Miquel,

On Tue, Sep 10, 2024 at 7:14=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> These are all the clocks needed to get an LCD panel working, going
> through one of the LCDIF and the LDB. The media AXI and APB clocks are
> also described.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

This one does not apply. Please rebase it against the next branch.
