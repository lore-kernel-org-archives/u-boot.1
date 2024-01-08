Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EA6C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 18:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D35C87A38;
	Mon,  8 Jan 2024 19:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A2t7CZh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB3687A38; Mon,  8 Jan 2024 19:24:08 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A132186E82
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 19:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ce99e1d807so139118a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 10:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704738244; x=1705343044; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aGpmpqcXIL72u6VEsot+KhT1QnR9pcA55APKFfW878=;
 b=A2t7CZh45jGah86Q+w+PRCtBS5ihKRaAnxp/AdJyx8eh2gqvLC36MNZKG06TAIxyVh
 yI8HYdE9U1UUy+MMhQe3QgKCpuAbcRWG2ms+7Epld8PnkKYi7na3wvplJt6os3K3dpzE
 fxKYfe1dnYyCbDhEJIlfZ0uCkPPmDvFPyZidGfHvCYL2pTbkEmMleoz8af911Ucn5M1+
 9b4Y841MnXu4DJlGDi+ZG89lM3N3OyQjDCgVgO/jrd2/GLMXlYLFj8BCoOMSLCP7+RJ7
 u/0NwfifSLCEcaiwG+8ZpYe6gDdlPFNn0JE8HRXBZZu83eaxGmFRYtT1YZpZm7Jr46t8
 aM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704738244; x=1705343044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8aGpmpqcXIL72u6VEsot+KhT1QnR9pcA55APKFfW878=;
 b=EleM82LwpKbSwvseMjJ180wRwxTzAnHLPEpBa6Lr2EnBSWgxnN7M5Ua7u/OQa3YuUl
 1wwHw95TQkmWTzvneX41npLmXNFVDT+NK3MMfSLnMlXU1wCixdjRZgwVZ8J+0q9uXlmC
 npBmBevt7u0S4m8ICfN8P/pXp/3iEec/FTM2lpQ0WvDjfq8UyCXyhdc7gmhFktMcP+7k
 EyK9NE3ziIGQNpcFuLsMGCzxKJchXlSwuyTIegmYWih+ewhSx2vjLrZUmEoeYKL1twMm
 /ma/Eft4r3DgcAxLdq9LfhgofDbzWGWk2I3syVJvMFwWpbFgPSnHp3WaQwREYRvQIVqW
 jQRg==
X-Gm-Message-State: AOJu0YygrR2hkLGecuQiQVdcDBATbxJNA9gWLdbUNn0Bb8qxzx955Tk7
 rnOg+VYiOv2Ovs+Zs/Om4IcX9arsMdIfPo6T5NM=
X-Google-Smtp-Source: AGHT+IFWp+u4E+YwzOECkusc/FMjmAqbaot8f9rA1NE7NLd+rJ3vKB/Eg15vCKE30g95qkTAvHIRaV3uOIGestmdtY0=
X-Received: by 2002:a17:90a:d58a:b0:286:4055:63e0 with SMTP id
 v10-20020a17090ad58a00b00286405563e0mr5734688pju.0.1704738243809; Mon, 08 Jan
 2024 10:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20240102121207.3963-1-francesco@dolcini.it>
In-Reply-To: <20240102121207.3963-1-francesco@dolcini.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 8 Jan 2024 15:23:52 -0300
Message-ID: <CAOMZO5B8OaaTZJdnNMUCH4+BPW3zUU1R6zAHrZ5koVEqoJZoKQ@mail.gmail.com>
Subject: Re: [PATCH v1] verdin-imx8mm: Remove stale fdt_addr env variable
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
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

On Tue, Jan 2, 2024 at 9:12=E2=80=AFAM Francesco Dolcini <francesco@dolcini=
.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> fdt_addr variable is the location in flash of the device tree blob [1], i=
t
> does not exist for verdin-imx8mm.
>
> Because of this the bootefi command fails unless the optional
> `[fdt address]` parameter is passed on the command line,
> bootefi.c:efi_install_fdt() assumes that `fdt_addr` is valid when
> present.
>
> Fix this removing fdt_addr from the U-Boot environment.
>
> [1] doc/usage/environment.rst
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thanks.
