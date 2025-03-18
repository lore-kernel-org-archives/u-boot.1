Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BF7C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:28:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E750380F4C;
	Tue, 18 Mar 2025 13:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RKFPsRZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B395B81026; Tue, 18 Mar 2025 13:28:17 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AECF0800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 13:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-30761be8fa8so18339451fa.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742300895; x=1742905695; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jg1EABg/zuws0Ln8iScR04hN01onExWKNZYsMaa8wn0=;
 b=RKFPsRZQH3Qyg/NAR+sW6YhMu8dksADy+sTVG86CsrfaPZ7eHSz1XQoJRxqEYCEAFT
 CVh9imosMuSdzi+GSHTZlpPax7jSPyQ+yWAmK7O4MhWmHNaj3778aYsx4/41iloqWTj1
 4pNSZ28c12/wuhPaYmYc5Uo1+tO1BKKSWgL/k6UaZuUY55/UlVxeDo5NmWLULW/L+x6g
 QnmNrjAQWxPzkEqqnQDMJNUz3gDrLHS+jmTy1o3KBjLYRIZFXnID4//lNZ7maJOYzOFP
 VtUVcTwncY0qif9KnfFBDboh68II9s7RZJpZKRV69wqMYeeIsQJf77vjItZd7vFM2pdc
 P5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742300895; x=1742905695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jg1EABg/zuws0Ln8iScR04hN01onExWKNZYsMaa8wn0=;
 b=gjyQigtaYpJ1lxpE+M+BPpFz8waG0VquJvGRsXAwSYYsXP+tYk0RVQjyBZo1ryC/M9
 GLjoCVz+4luIu90ImTsNwD6T2mVui2g4Btz5Rx91TFw4J04FNii0f+hnxj/IJRJrMInA
 Ln4QZQfxC+wJNNTdSfYySczrKs0kB4BNJ6PvrU3dOVi6HG7Rejnr4F4emHiPAvkwWVmf
 QrZMu9rPobmEKIS7AYCHzuZKRlEsjjKU8NByNUvLvEvvdydO/zVGvTl0h+BAG8GK6aN3
 5osH36w/IRqjy3emCyhN2lPXX0KTegee/bFC2V9WmanN8XEr4E/jtqi2/PbnD/oLK9be
 ftvA==
X-Gm-Message-State: AOJu0YxJ4qIDGlgRi1xZ02o/hNSYviegrTw9M3fSGOxv2ZUcXNIb7BUa
 beffGweMdWdCq+v0BqCj0UongiW/O/lZKS24R24LhpKryGyGDh3uvg+4Fm2fdXx6MHSju+k937z
 olxXwWE5VqHoqMe+mLVxWTEpZtBM=
X-Gm-Gg: ASbGnctP2TRbk77Ncaadl5EjdE1nYik9YdVBE5CqBPkIkcI8RwmkeDHGkgeb9J6J0q/
 2xw8PS2Q1FyfkKLi2PucLeko0uFZUTwYpi+m1oejK95besYJbd48nUBgkmCzlg8a0ggiUZf+fQa
 HxahiXaQbRek7HPNzMkx/gwHUzrRU406ABQ2AizJml4548+29elsIoi+od0Q==
X-Google-Smtp-Source: AGHT+IECZqlesMPle2d3dRYoiEANEqU8it3Xsgm2MyLSA6GwYsWrgV3aphD8vjiX1oJ7ZlueY6f9FMC9E+VqYYKTmuk=
X-Received: by 2002:a05:6512:3d86:b0:542:213f:78fd with SMTP id
 2adb3069b0e04-549c398d073mr8614160e87.40.1742300894677; Tue, 18 Mar 2025
 05:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
 <20250318104659.1114340-3-jerome.forissier@linaro.org>
In-Reply-To: <20250318104659.1114340-3-jerome.forissier@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 18 Mar 2025 09:28:03 -0300
X-Gm-Features: AQ5f1JonD9-nX9pKYhq24x6AKcDoNfeP6f1nXhAvfiSp3nLUhZUYKoqVfStHv1c
Message-ID: <CAOMZO5DRxYEgL7aW4s86i9GBWCZTwTQKQWLw8d-SrrvHmKF-wg@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] arm: add initjmp()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Tue, Mar 18, 2025 at 7:47=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Implement initjmp() for Arm.

Please improve the commit log by explaining the motivation for adding
initjmp() for Arm.
