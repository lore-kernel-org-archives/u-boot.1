Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B43C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 358DB87A9C;
	Wed,  5 Jun 2024 11:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sAOy2+6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC8A88191; Wed,  5 Jun 2024 11:26:11 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF0C831A2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7025f4f4572so524701b3a.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717579567; x=1718184367; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b4AabuBAA6PGLPkfGCBO9YsIq3srW+/hv3iLHnE6SYU=;
 b=sAOy2+6LJEYdTLp0gqmhnFrcdI8Gy/imuhaGtspztwHM3YNedlmFXZJ+7BxerS9DaP
 /+fgu7q8hbauRBK1YaZpXHRYsn5yaECBJKMPfI6jUeOM4X6LzuJaOh5tXSSWDMXb0i2c
 kbp9EpOhtrCON+8SYNLBB8VTNqaxYufZemcOpuPZ0iHcrGnFucV/N2cI6P/Lk82bj+Nf
 ShXAvcYV9TqNXMCvSa0rhFRP2Nt94F3AWgjRebtCNXI5nd/b+eUk1KDjKxCCCLNPbLr5
 7nzwsO2Wi0ZAxmeuRGZzb69kDjh2CQBqA4MpAqZWdtGWlWBbpnRx5FxxDg0AMQecJp+A
 O4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717579567; x=1718184367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b4AabuBAA6PGLPkfGCBO9YsIq3srW+/hv3iLHnE6SYU=;
 b=g74foyjcW9LUIEmh9mKWGAvDP/Erlrwb9LFneA4TXQLRHzAvnrATTPkQDHWlc0i4I2
 XoM6g1CdS15pv2xtITrLuD9IDkX82SUzzm6xdT83ejsLf2Ls0dZWC2VppwO8MQKuMCAD
 Nx6ZgO3x8zaHo0SuWaRTL9CQaOlPxjxP/d6CJUzlnIbxpKLyY70ROwQ9VaQtSyGbfe8M
 LwbvBI0ggd1m0RPjSak62XNrFRQiMlvSYjzCh0jv6NS7o8ko21iUfZngF7MTyLOLBSTE
 bA0nhNzElW7ZSlRBzaCwcT33hnFdiF/LSiP2Xl47vOdCd/doEi1I4VOqGCqXd/pY6a4C
 wPyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFkYXSKBOP0MevAT6uxXyRMC3Fh4+w1d6aCZ0Bz1QlDnBOw0bq41PJVyhivMipYtgnsbQXUgnj+nBYja3559UqkjKgRQ==
X-Gm-Message-State: AOJu0YzYVXfnPYxPrxAL+ojNmxN9W1Www+KqCbyOyyec6ifXVWTzxiMX
 vVWdlK1ewtpNwQHY53VSGlBGUIWi0Q92bT2hDGS/mKbijPUcJ5tPIfPGBZSiCikXZYBwkoK6Ye/
 QCPdvRk5ziyZcScTsVcbZKhjD3dYZOiGS6RLu2Q==
X-Google-Smtp-Source: AGHT+IH2C3aIfMSRWyBDOYW5Z8i9qc90gPswqOrEpNZdrUPdM/udTcc5Y5PBUEHPnucJ/VRTQUZuA9Z9c/E6N7Vo1YA=
X-Received: by 2002:a17:90a:f986:b0:2b2:195a:d7bd with SMTP id
 98e67ed59e1d1-2c25303fa30mr7330447a91.2.1717579567533; Wed, 05 Jun 2024
 02:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
 <eb3681f0-ecb9-4775-9093-5640aa408f50@gmx.de>
In-Reply-To: <eb3681f0-ecb9-4775-9093-5640aa408f50@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Jun 2024 12:25:31 +0300
Message-ID: <CAC_iWj+s67woD-USmT3+hDq7yO9K_G=WS1DG-oJMM1byPb3JNQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] tools: add genguid tool
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
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

Hi Heinrich

On Wed, 5 Jun 2024 at 09:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 5/31/24 15:50, Caleb Connolly wrote:
> > Add a tool that can generate GUIDs that match those generated internally
> > by U-Boot for capsule update fw_images.
> >
> > Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
> > with the board model, compatible, and fw_image name.
> >
> > This tool accepts the same inputs and will produce the same GUID as
> > U-Boot would at runtime.
>
> This functionality should be integrated into the mkeficapsule.
>
> Just pass the device-tree into mkeficapsule and generate the GUIDs
> whereever they are needed.

I like the idea of moving this mkeficapsule which is already part of
distro packages but,  isn't it easier to pass the compatible string
node and the namespace?

Thanks
/Ilias
>
> Best regards
>
> Heinrich

[...]

Thanks
/Ilias
