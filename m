Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C8BE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1916F8921B;
	Fri,  6 Dec 2024 20:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CGx4U/tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3BB48921B; Fri,  6 Dec 2024 20:20:55 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F7E88F20
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7258cf297d4so2433489b3a.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512850; x=1734117650; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h5AlQbkrrlsdRpIstQTV2K+4tSCpQzb4dMziWnPm3RY=;
 b=CGx4U/twHhaeYFYrsrlVKMqRYSnF959jfN/ooXMhb7h43kChcwvNGKOtj830DLVBb+
 nGB7TWtMHBLgH7ompff8mG6Q2mIJ6NhdBPUH5CCcw68rl9jWlBVSZBLdNGg61A5/0XJU
 4M5wTaQBLx9bVZthwGWHKGo+heRl/+b9SRX3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512850; x=1734117650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h5AlQbkrrlsdRpIstQTV2K+4tSCpQzb4dMziWnPm3RY=;
 b=epsaoYQnz94BwF6gVQL0tubYQDKbMOQEqncpLanmRrHiXcvPgYZVG28V6WPpYRhTV3
 rtEhKe09pdl63y2oBHebMtBSqoEDr+Adx6GR1uv3iIETnjkhSSaNmyTEJJ6HqXqAN6B8
 V2mzXjQZ1UdoXOHKH2sU6IfYai8EpJpGoAHnlUAWhddQR5kOpaZy1Qks8aASUVMoTmve
 tgHIubGIS3HGlPfS88yh1E/tQn9nTmsIJQ+/UkE18QXic2i8/vOiKUmmuJMycJbV+JWG
 V9M/huSTGLllHfcIxLv1D1uaaZmel+hkGuNTZQrsTAaH15kYJm6/FwF0m/+YnImOcXS+
 5yYw==
X-Gm-Message-State: AOJu0YxAiV1F6OtECaTG8lZAHkXwt5XVnUogwpUOKJb/smgV7aaQdsUg
 MxS1uX7T5Qix6utfU03n/7KMcMbdH5m0c3cK8An371ookp7gCyACKPfPFjpPsAtUXxadW6Hw53d
 O88z4LLZWBeDTWF1XNdlKCkx3PJ69wQTSRvj+
X-Gm-Gg: ASbGncukCgFMTWsMsBKEg1S/XnWyaWadPeRLN2cqc1TXYYWNaW4Bvedc++4ZEXlXw2g
 TBz9Bwp6NJMCMWuZKSpusiW3wQ2A/DuFB
X-Google-Smtp-Source: AGHT+IHC561dE74ZmrXA3zbXRGmYo+BADk4jJibk1PBxE751RfAkdabsjwLEH56ugg3Td62zZfdP1AkvalSxnZyF7jw=
X-Received: by 2002:a17:90b:17c2:b0:2ee:44ec:e524 with SMTP id
 98e67ed59e1d1-2ef6aadde15mr5635515a91.35.1733512850424; Fri, 06 Dec 2024
 11:20:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <cf438091e43c4c9d535a9cfa2886673aa42a4370.1730452668.git.michal.simek@amd.com>
In-Reply-To: <cf438091e43c4c9d535a9cfa2886673aa42a4370.1730452668.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:20:11 -0700
Message-ID: <CAFLszTjq7MwUiY5G5J_q5UWFvOsE3uWmeXVYMq9enwGkvYYe2g@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] arm64: zynqmp: Remove mkimage fit script
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
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

On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
>
> Platform has been switched to binman that's why there is no need for this
> script and also Kconfig symbols.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - new patch
>
>  arch/arm/mach-zynqmp/mkimage_fit_atf.sh | 240 ------------------------
>  boot/Kconfig                            |   1 -
>  2 files changed, 241 deletions(-)
>  delete mode 100755 arch/arm/mach-zynqmp/mkimage_fit_atf.sh
>

Reviewed-by: Simon Glass <sjg@chromium.org>
