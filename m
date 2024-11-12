Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029A7D32D81
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E5A989459;
	Tue, 12 Nov 2024 19:41:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="gb3whNzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B9289270; Tue, 12 Nov 2024 17:08:43 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 435018862E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 17:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb5014e2daso51754591fa.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1731427720; x=1732032520;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nNWNljpnW3WHe1KH6EDZFvBM64Iw0+hXNbTl8vPfys=;
 b=gb3whNzRozxe23P4BN8vytP9PKbTfQ6QFT1bqsj1osXfmFiJJPXyOfwF1D5fH7rONa
 4RlsK9+1V2M8Lt4liRQtX/uHAp834/7pbq0+N0QtGSXRntLKHjiNQQFL4nU97P6cdvZy
 SUK1h6FHOSYud19axbfSES8Vbju2/QD1FSLWxnmkqSjafBtVb1B+B+vHzvHUMI1nnbB1
 twZzU3KXXrbk6uUuzXkrlXYFPRCenWTYytKlALqM4+RQYDLtmDwMWCvwMAVDON/EVHV/
 gufa9O19mnz4F1lS9s10cuJbSI/BPe7mAYd9txVmLiJ2RAg27Ns4rB5l+wNrtsnRpDk3
 nIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731427720; x=1732032520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nNWNljpnW3WHe1KH6EDZFvBM64Iw0+hXNbTl8vPfys=;
 b=HeC9MSjfpKQ4GwqD3FAx6mc3MZ1uWY8XfioqB0vs1Xtr4c+WovF26jC8QZqxbxRotC
 xmwdBDpi7FnnxUWXxXPdhgeOiKSdiqx3Mpf76qE4xnbWKHPpZTNkNuuK3IGcbHZKg6NK
 pRP5uYJdijUS5r8HZBj+yQAfXhnFUg1vPWkOSCGBWVyhoYR6ADLQYLUlEaeUya7CD0nH
 dC9sSjpnhSd0rltMHisaUWnHf3gywThTs4OaVxm/1PF+mV0W4Lcj8FCmGncTQgGr56EK
 ZEUev64QUgcJEQzwtUW8TLNMwGF8b/wvJ0tVL0iArOOWzCSiqZQ4EUFr2lwwcYC7VXQn
 EkzQ==
X-Gm-Message-State: AOJu0YxRy+RevRD4/4XP/Mtw+G2Dvqck17UHwNQdexng2e3uIh+8Vd01
 mPfqKq/c7F2tnqfRcqBFOCmWZQ9tFTar6hMnRHqdBxOqCSjDiHAhRHSq0Zw/jzRi9hxscrhz3HK
 hijMnjFUeG5Yy73WLuky6QgmRm7yGeiWiYDiTbw==
X-Google-Smtp-Source: AGHT+IEIcFLgu2dRoODx8HzIRDW7cZh6nPvdMJpLw7qVJ97gr7hNEq4aoPW/hFOsgV4gVZW2/cEnTic7PacfQNzGLR0=
X-Received: by 2002:a05:651c:991:b0:2f6:5921:f35b with SMTP id
 38308e7fff4ca-2ff2028aa92mr85077641fa.27.1731427720542; Tue, 12 Nov 2024
 08:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20241018215751.322145-1-admin@hifiphile.com>
 <f4b1431e-7782-42f5-b480-727eb08e909e@linaro.org>
In-Reply-To: <f4b1431e-7782-42f5-b480-727eb08e909e@linaro.org>
From: Zixun LI <admin@hifiphile.com>
Date: Tue, 12 Nov 2024 17:08:30 +0100
Message-ID: <CA+GyqeZwSKtc7yn8F8pz-PkutxhNMH8a6iO8A_32ML==jaWjOQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: at91: Implement ops get_flags
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 12 Nov 2024 19:41:23 +0100
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

Hi,

On Tue, Nov 12, 2024 at 2:27=E2=80=AFPM Eugen Hristev <eugen.hristev@linaro=
.org> wrote:
>
> Use clamp (!!) to turn this into a bool.
>

Should I also fix the existing function at91_get_port_output() ?
