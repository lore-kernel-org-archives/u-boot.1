Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C818FD0C61D
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2109C88F92;
	Fri, 25 Oct 2024 16:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LdvqTWNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0602287F7D; Fri, 25 Oct 2024 16:52:17 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B3C8903B
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb470a8b27so29482711fa.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729867927; x=1730472727; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9l2fRNzuY0O3RnYfcLWVLPAha2NHmqL79LfNgA/xts=;
 b=LdvqTWNGh4SAtgaowH9DUOOmsc575fd+FbBGIpa+x4OLI6/6uHqfoPRvML3KXdtUEd
 HwmRML09N+ggTpoi9pYvz8M644e7NZ2KjrowNvBlNpmAo6QGPAThEj3BKRVGQShJaumw
 qiI2Evx34SQrZHf1kr7dv7HzxVH+freHyt3Jb+W2m9HIJteDm6kGt7RoED0magSBvYJB
 2XyK3XIE42Qqw770i6WsHEMNrsNPtrUClmdvZHFFtVdFOlekr/0sFru6VpYjWPZr8wc9
 3QEfEsb4dYk+KYx/ePkhooQlm85eSkr5Xn6Gak8o0tocjvx4SV1Qf/xRk8JsRjaWTADj
 lKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729867927; x=1730472727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9l2fRNzuY0O3RnYfcLWVLPAha2NHmqL79LfNgA/xts=;
 b=HxLolRe4qiwPSCL6xL2un3AUMz2vD65+HqyTfwyzaZesnAeuUY6Y24qa7lGKSD2DNd
 57XBGBgHNGxd/lskvxgbyYEvGWVW5IYCxC8ZrjnKg9ve1R3VjXMegvhiFZ1LyQJeZZYI
 I+mKGa9MDKJJspbHRPls2sNjqV99F/eFD7G/8tEaKNX5etcil31V85W3LRYD6vlKwxrg
 xvbPrNR10DKmdEyREWVIn0mwwmW9Gwm3ezho//7Qq4xBXY/A1Oc0SZFVwQIK5DEcNRDE
 RAlHAKHxXiCeRwNqinS16tLdymhIrDM3qd+OaiwhIsujj30GwMrS9ooU3OBCKn2zxnd/
 /VBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzzCEDl5xwS5hYBs+7K5MIIdWuK15lPq4H4bcnN7ihJQbYRftMlIpAVukVqe/YCD/efH+9MTs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywqs1qTcKYlnBngt2vWDnD/7UUnA7mV7Fxdf/qUStOi2eHRpdqF
 gI4c8OvSoqIPy/ZquKvEtYnQLSlFCmsW98woXlaBn3Mmnxy4ZSuhZ4uSQDcDy0RddNGbujDu2Bp
 FsvhwK0BuyNptrotEABTzB3YylOk=
X-Google-Smtp-Source: AGHT+IFt+KAc+nuChB/jEwzCLcRBbkc9NG+OyXXQ+JLkCgxJ/TvkFsTkCHoDdr2U/UAhBgLpMwtUiApVk+7DnTUzgrU=
X-Received: by 2002:a05:651c:2226:b0:2f3:f287:17df with SMTP id
 38308e7fff4ca-2fca836154fmr23503561fa.20.1729867926463; Fri, 25 Oct 2024
 07:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241024122735.893319-1-ravi@prevas.dk>
 <3606fb53-c36e-93c7-6ff9-9947ae43c408@denx.de>
In-Reply-To: <3606fb53-c36e-93c7-6ff9-9947ae43c408@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Oct 2024 11:51:53 -0300
Message-ID: <CAOMZO5Aae_0cDXX-E9syhVPwMF7_NVu2__40m6Tmi7daePyVbg@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
To: hs@denx.de
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
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

On Fri, Oct 25, 2024 at 1:36=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> Hello Rasmus,
>
> On 24.10.24 14:27, Rasmus Villemoes wrote:
> > Loading flash.bin using uuu fails when flash.bin does not have the
> > right size.
> >
> > When flash.bin is loaded from some storage medium (sd card/emmc), SPL
> > just loads some random garbage bytes from beyond what has been
> > populated when flash.bin was written, but when loaded via uuu, SPL
> > hangs waiting for the host to send the expected number of bytes. Which
> > is (size of FIT image aligned to 0x1000)+CONFIG_CSF_SIZE. The
> > alignment to 0x1000 is already done and is necessary in all cases
> > because that's the exact expected location of the 32 byte IVT
> > header. But the IVT+CSF blob tacked onto the end must be a total of
> > CONFIG_CSF_SIZE.
> >
> > This is exactly the same fix as 89f19f45d650, except that this time
> > around I don't know how to cleanly get CONFIG_CSF_SIZE.
> >
> > Fixes: bc6beae7c55f (binman: Add nxp_imx8mcst etype for i.MX8M flash.bi=
n signing)
> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> > ---
> > Heiko, can you check if this works for you?
>
> Works fine for me, thanks!

Applied, thanks.
