Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E4EC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82418070C;
	Sat, 18 Jan 2025 05:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S/D1klOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C7B8036F; Sat, 18 Jan 2025 05:31:41 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27DB18073F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso514583666b.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 20:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737174698; x=1737779498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6lCr19uN5JuLYVEzCl2kX5XmLsM86yQqKYYcwDX0KMU=;
 b=S/D1klOQ3CGiR34ccRvZxN6WAu/Iinn95KEmn/lJBl7ueywH0YbWHFXf7qdgAzciuz
 sYZ5IqK3tzWecUgOX7SL2fXZrWUNX2j4+vVqe+8I2Dk7xmaF164eSbb4ec79Xbcm/6yZ
 MPf4McO1oaa7Z9QSrtIjcIF1ooQ0m3+R8jMCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737174698; x=1737779498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lCr19uN5JuLYVEzCl2kX5XmLsM86yQqKYYcwDX0KMU=;
 b=duoWHLD960bmZ6YiUA+7+uP5sU36u3OSn1PWhnplC+ZfH4ou2qhcgpveZi89+UjOwU
 iEqjG0bZdznC1elvs6ZqeGu8QDEt+dOOqgvri39lsSG88/Pqbp96mmLihmPnXO9LNpcg
 2yOXTawcku41Cm2AzuqrMDF8S20/dhQ7rMKLBWqUweH3ATBfDMJvJ4b1/5p1kZD4Aqnk
 4XTb+TxiMRh/DotihosAC7xVkrnqmuCHg4W86LZVPjLNhoCckwxX5pe9bRXxxC2P9WAM
 +Zs86W+iDhoE5XWj2DYwCu/FGwcaiJodjI1frGr4UEV2glqu46dOkMIgYxoCgOg/GsOS
 B/zQ==
X-Gm-Message-State: AOJu0YzDnXI4yDBNRc2OaD6eemr3WNumClJSIEg5I9Xzlb3LH4oX0DY2
 ylsXD66C7eIzgILupovM/b7u93mnoTZ03rBPBT7C8wkytkAAlKQX5u3ccyzUV/KI0e0496o3DGi
 YfL8BYmvzv07UhaW9+87mIKr+tl+cFsl90WCan6XlapElMQk=
X-Gm-Gg: ASbGncuwp7IoTqbwHDUjc7dnNf/NfEt5694hjbRZYuQbbD5pZANmwork25zwuG6STve
 CCh2Bu1iYlRPMf9GSZu3Sj1peUG41FfnNS3r1N88qCrGTisAQNbboy/jvy2IYTlqirQmCu93nw8
 4x0gj/h4Ev
X-Google-Smtp-Source: AGHT+IF8+48dyO8ihL4P2uZOsuFLjRa9pcKDlEqQEyb0L0Apr8UnCUVpTJC657rl6dwiQKBKP7GnKbJROj1NSaVExoE=
X-Received: by 2002:a17:907:1c13:b0:ab3:47ca:2ece with SMTP id
 a640c23a62f3a-ab38b0b917bmr429583066b.8.1737174698635; Fri, 17 Jan 2025
 20:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20250115200144.951530-1-raymond.mao@linaro.org>
 <20250115200144.951530-3-raymond.mao@linaro.org>
In-Reply-To: <20250115200144.951530-3-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jan 2025 20:31:25 -0800
X-Gm-Features: AbW1kvY6063QgR-2V5EZo7ZySfAjBrkGccM7IrciHx6sQ0TG3SZuqY34V4blW48
Message-ID: <CAFLszTjYm8UBchOffiayzjbJrTsj0_HsV3qL6zwmAVQZSv++rg@mail.gmail.com>
Subject: Re: [PATCH 2/6] tmp: add TPM2_PCR_Allocate command
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Tim Harvey <tharvey@gateworks.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,

On Wed, 15 Jan 2025 at 13:02, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> TPM2_PCR_Allocate command is required to re-configurate a TPM device
> to enable or disable algorithms in run-time, thus this patch introduces
> the implementation of PCR allocate APIs and adds related cmd functions
> for testing.
>
> To test the feature, ensure that TPM is started up.
> Run pcr_allocate command to turn on/off an algorithm, multiple calls
> are supported and all changes will be cached:
> `tpm2 pcr_allocate <algorithm_name> <on|off>`
> Run startup command with argument 'off' to shutdown the TPM.
> `tpm2 startup TPM2_SU_CLEAR off`
> Reboot the board via `reset` to activate the changes.

It would be better to have an automated test.

You could create one using the sandbox TPM, and you could add a pytest
which can run on my lab (coral has a TPMv2).

>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  cmd/tpm-v2.c     |  94 +++++++++++++++++++++++++++++++++++
>  include/tpm-v2.h |  29 +++++++++++
>  lib/tpm-v2.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 247 insertions(+)

Regards,
Simon
