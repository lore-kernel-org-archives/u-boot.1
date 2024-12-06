Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2A1E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB898973B;
	Fri,  6 Dec 2024 20:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ahNR7BcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D8B88F20; Fri,  6 Dec 2024 20:21:12 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B518973B
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fd21e4aa2eso1131720a12.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512866; x=1734117666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tJTYFPFlPSGIKwclm/X/Vg9cQfEXrNVQ+YD2bWrY8Sk=;
 b=ahNR7BcS6ubyLPKVC3fdrzZRE4CS9tCaI72WDDZG5ATQhrQt6ihB+tRAiHmO4ly+yy
 KZeBhFB9xH+iJBAXoBhRRhitmWXiwwNvfeFCRxANTK/OKmvQFroRNOysOkt+bkg98eH/
 9sb5Q6o3D5X/loyK3+YTTttbs5u9CnG9KF1ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512866; x=1734117666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tJTYFPFlPSGIKwclm/X/Vg9cQfEXrNVQ+YD2bWrY8Sk=;
 b=ckRJKJ0uCpb/kE1tvjKrf3VKWo+9CF7EgHw727R+byMKvWNEH9pLWsjzvKi2yOID7t
 hh519iAALovwRFMeESJqKWcRm2K9SquNUyfV3s9jhabOKpz9a/BSb7SoL/OhwlQi/h6V
 FGXG0NDG8OONv4ujH9X3qRNfUCNhf3jBWAcqz417mh9pTwRtD6GbE4F8Cf4WUr5KXcTH
 oCLJEIndoknpX5QY8uIkZsYqOlNW4wWbsjub/rvVaxobGyYwrVM4VFxwAMeKoPpPhaSj
 z0b89iixCM58fU2ULATak0gAdwEqQFwwASS6q8nBflChxoHSdmcpr2YCm7DpzsDNIDBx
 wPNw==
X-Gm-Message-State: AOJu0Ywf6zfB6ajLpsu3e5Gbmpuqzin3QBdYFvagdnVlLV2E/KWlFDfh
 3mIfbAG2yCDubVs1KlFBsVN/Wo4+SkLuYQL74RWju6Jf0JUF7xhCQNYBIhk2O3QwbnoxPSvZpOo
 vwMc3udqibtAdRQCCJDzvUC2WUlJNruOEDrq5
X-Gm-Gg: ASbGnctREdmUTv5Bkdaw2S9dUhxpYxTfoVq/Zrq/+6jur5HkI94GfutKgdkhW7w94fd
 wl6RdFALNYt/59Rox0sCXJqsW5QqWgRDW
X-Google-Smtp-Source: AGHT+IGjtS14YD5bjYGbFZiptxHhSBt6Zv9ZFs7owINpTqR00ymfzekRS2Is/3uokNo2juLrmAarlGxE+XwNuWEVAU8=
X-Received: by 2002:a17:90b:2b4d:b0:2ee:f22a:61dd with SMTP id
 98e67ed59e1d1-2ef6ab270cfmr5993277a91.32.1733512866641; Fri, 06 Dec 2024
 11:21:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730452668.git.michal.simek@amd.com>
 <90b613796aee38158252c8bb1dfc3da0420f089d.1730452668.git.michal.simek@amd.com>
In-Reply-To: <90b613796aee38158252c8bb1dfc3da0420f089d.1730452668.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:20:49 -0700
Message-ID: <CAFLszTjsaBq17EvqLXxya6Rd08MxOhScX_O65BXtL=vc7OXzdw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: zynqmp: Generate u-boot.itb and QSPI image
 via binman
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com, 
 Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>, 
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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
> u-boot.itb has been generated via mkimage_fit_atf.sh but it is on the way
> out that's why convert it's description to binman.
> Compare to script binman description is not able to configure BL31 and BL32
> load/entry addresses which should be done separately.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - new patch
>
>  arch/arm/dts/Makefile                |   1 +
>  arch/arm/dts/zynqmp-binman.dts       | 111 +++++++++++++++++++++++++++
>  configs/xilinx_zynqmp_virt_defconfig |   3 +
>  3 files changed, 115 insertions(+)
>  create mode 100644 arch/arm/dts/zynqmp-binman.dts
>

Reviewed-by: Simon Glass <sjg@chromium.org>
