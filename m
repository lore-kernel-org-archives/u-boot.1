Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3290D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995C389130;
	Fri, 18 Oct 2024 01:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kkWMPB2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5406689155; Fri, 18 Oct 2024 01:11:57 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663A789121
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbce8d830dso9823716d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206712; x=1729811512; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9MNh76dezqvCC1lsyDSAjt4Plzi1M+eJukHxPntkaQU=;
 b=kkWMPB2o2hdeifCyBjutnxbrdgAhEMOAtalPjCiSXXug2PkUB6r4J6RlVwJTakAIsq
 y5BYVZZDdgXw8pGJBeTRg4tA3QC7QUDVwG/brxOmv11OtsebJKUuV0Be/+d3RiINc6qS
 8eBvDa9iM9sQ/I+bSDvDYOqT3AU20kUnZXpa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206712; x=1729811512;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9MNh76dezqvCC1lsyDSAjt4Plzi1M+eJukHxPntkaQU=;
 b=Y7ji7miOCAb14TULAdwMl/jp1npUP1HfpyLT92J9zDU3qpw13JtxCRergV+aRzKtW1
 0PsnSbJkZEtwcbiG/xr3jkN989pefSoUmyvO94opP8YRSGSxYwQdZNFaW+/LkUfy6eIs
 4S85YcLrUftDAYBho2PKF2ddM23dMuJ0Ackplh5Yi0dNuenjdJSh2DLkrShax5zrlhUN
 Cq4rUKsHiO/9SYqxtSq1+yvBUbhVZcvsWC0VdNERTv2qKlZabQUwnVSDi+t51rqh8c3y
 F4DP5MFMLS7GyXP2VAYUx/DDaK8MFWrNx3aoQKPk+jzjUfq00Ui1046Wy0+VT+mw26y6
 rBTg==
X-Gm-Message-State: AOJu0Yw3DeYwl9e6YK+AksTwMr9ZCMP+i7MhNkQ9d/zXMNgpyA85hWB2
 qYerxcLm0fz+ts3dUO6aQ5FwRTFfn7EfAWxrAL38zy8yAxHeqpp7wksJ4C8YjlghmAV4dzTL/Qc
 kF1cIj2VgGZsOd+ovPtCY9XNrTNABFNvGrWYn
X-Google-Smtp-Source: AGHT+IFFVopj9dxYcf63y/GJIX2SoV/JYuho9PMLXmrhlAGI0eiPKw9o5YSxjGmpcUVsUeyCXZWBESlfIsS/gV8jxDs=
X-Received: by 2002:a05:6214:328e:b0:6cb:4b65:950f with SMTP id
 6a1803df08f44-6cde162f5dfmr6911196d6.50.1729206712242; Thu, 17 Oct 2024
 16:11:52 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:51 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTiEM_TNJc2o3Hu4M3GGaJRonYs19SLMkn=DXVCp360rPw@mail.gmail.com>
References: <CAFLszTiEM_TNJc2o3Hu4M3GGaJRonYs19SLMkn=DXVCp360rPw@mail.gmail.com>
 <20241005143356.10069-1-marex@denx.de>
Date: Thu, 17 Oct 2024 16:11:51 -0700
X-Google-Sender-Auth: f6_Mk3OphxQrsFu1THkPfnG0Sws
Message-ID: <CAFLszTi6n27X3vaHpOhZNX+aPKFQ7+1U_C00gShyDvn5Aad9Kg@mail.gmail.com>
Subject: Re: [PATCH] sandbox: dts: Add missing sandbox,
 emul phandle to sandbox-pmic
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 5 Oct 2024 at 08:34, Marek Vasut <marex@denx.de> wrote:
>
> This phandle was missing in the sandbox DT, add it, otherwise sandbox-i2c
> driver cannot look up the emulator via i2c_emul_find(). This fixes the
> following i2c_emul_find() error:
>
> "
> $ ./u-boot -Dc ""
> ...
>        i2c_emul_find() No emulators for device 'sandbox_pmic'
>   sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
>        out_set_value() PMIC write failed: -5
>        i2c_emul_find() No emulators for device 'sandbox_pmic'
>   sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
>        out_set_value() PMIC write failed: -5
> ...
> "
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/sandbox/dts/sandbox_pmic.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks



>
Applied to u-boot-dm, thanks!
