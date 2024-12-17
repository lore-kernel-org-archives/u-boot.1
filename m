Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1440E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335158037B;
	Tue, 17 Dec 2024 20:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E9xxaUOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00AF802C2; Tue, 17 Dec 2024 20:48:03 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE0580315
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-728ea1573c0so4994749b3a.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464880; x=1735069680; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mkngPS/QVBaR2yI7vkyogodu7dq5IOeWQ1CNJgfsdZk=;
 b=E9xxaUOwFBY2IZ+Qf2eNjVqfPeN8IvhExF5XevHXd15MGUPScqRVZy8t248Wo2cYCU
 4VlYS3ZWGpf/tKyHYux0IeAkiOw8C1I8Ysq2I1IgbSHfxiqrYoh5rxiM8nU92MsoChe3
 ny73ZgwvxgLJBaohWZIzG0pdcDj6JreE2i9fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464880; x=1735069680;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mkngPS/QVBaR2yI7vkyogodu7dq5IOeWQ1CNJgfsdZk=;
 b=lvM75Gxl+JmaoVAaKOvAgEZ9dYI9jAkpedAEciPEztX61JOp+kXsbyHh4Ne1z09Wfc
 etJnmrOPWZBK/JT+3uHLHqtlZxW6vT2EoHjly2/E3VvPdoAwfrwn1Pfk1QGw2RhKv3p+
 9RAEBW7HBbYT2eH68W/dZ9KsDZTxMnB6SqcNUeuIbPCzuvXHs9l8oiOqVMgUDlpBTG4k
 VbCsXkKEQPcZUO6UgmUMCERXn4nsWaNNj1lYX++S0ImI1FBwVsK7xryIppH6jRNHrKCd
 qO8xAePUJer/wTCJGm/IEaKhAd5ryjiRb8Foq2Uh8kQ9HD/KZ1euUeAUFscM6WCsPBue
 SWcQ==
X-Gm-Message-State: AOJu0YwQFVTyu0E/rgjKp8X0cZXvOJ7WWb/OaY0Qz4ENYyrR+MsIqzep
 LS/c5EMmiEZAxfogIUVQhRv8Ch5L9tbhjkeMGjO9VfxlfyL9M9bYnqVGtP95bHFrbKdDCqYQ9nW
 iKNhZVTmpbPYs5JXo6ehvmh60IKcKmlk2vZPo
X-Gm-Gg: ASbGncv/efPqjBBnDvbKTjYup7+vnbisR1x2bJb9VB9nkQgljh9Ra1yCf3RWgjj7Byd
 4mvjMilcBqclo43Idi5mLgXb4shUMtEHfsj5AN4U=
X-Google-Smtp-Source: AGHT+IEw5I7gucKW/lNFMwb+cQ9Qor0l1OqBjTizH8MwK3797017YRmagMHvSVyMS0Z1hJ6HBbw4jJTDMmGrPL6gtJo=
X-Received: by 2002:a05:6a20:734b:b0:1e0:c89c:1e04 with SMTP id
 adf61e73a8af0-1e5b49bc067mr375728637.43.1734464880119; Tue, 17 Dec 2024
 11:48:00 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:52 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWj+u+2edj42qcyjHSJzW=41kjE1VOWMYXrbGwibK-Bn8iQ@mail.gmail.com>
References: <CAC_iWj+u+2edj42qcyjHSJzW=41kjE1VOWMYXrbGwibK-Bn8iQ@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-8-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:47:52 -0800
X-Google-Sender-Auth: jahyy9fahvzedR3gMPJEpoSo0OM
Message-ID: <CAFLszTi_aXp7iHfyWMUmZ9R0Ctg2JROtWicf=vvcDRX1G-V9Qg@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] doc: efi: Add the EFI-loader API documentation
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Simon Glass <sjg@chromium.org>
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

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> Bring in the documentation from the efi_loader.h header file, so we can
> see the API defined there.
>
> Fix efi_alloc() to avoid a warning.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Put the header-file in its own section
>
> Changes in v2:
> - Add new patch to add the EFI-loader API documentation
>
>  doc/api/efi.rst      | 6 ++++++
>  include/efi_loader.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
Applied to sjg/master, thanks!
