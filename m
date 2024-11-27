Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8B5D609AE
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 08:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F240895D6;
	Wed, 27 Nov 2024 09:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b/owkTiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B21895DC; Wed, 27 Nov 2024 09:25:48 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295D38958F
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7250c199602so2762158b3a.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 00:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732695945; x=1733300745; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uUJZZFotZINwhaZi4vs3xAlHtlOhGJEL+xi1R+L0Jis=;
 b=b/owkTiC4Nm244kln6SG3Bpvt3Ey1dhmTdAvvRVpmzfsTs/IvLDXhyT/1w5v/HWCUp
 6e86CUAtRtQH9Fq/0oBC+UhiHl00/MloIKd4O35gwmdf2ELHcWyD+R5g2mzaurzEeTIV
 6FPredHo3A/HJcWsVvogWg1/1r/qlViU4z5T9tztGj3QfueN6V9VWiXsEz8WF8MiZmQy
 JdM7MZM5+qQUq1pohMfPZnro3N7nKqrYJeCcy7eWh63SOvH/4OvYViXcMlnu6suUZenQ
 0F19Zuc2xYC/AQ0G7vZY6W4Iv8XPSvLZID9L9UtsL6lMevg+bytj0VNx0kbm9WPCRaNU
 FnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732695945; x=1733300745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uUJZZFotZINwhaZi4vs3xAlHtlOhGJEL+xi1R+L0Jis=;
 b=wmN4XYgS/J3gMS5ja37iB3KBQuvWJl72TQvmHeLtBE6rqFIVOUg60zV/qDudoHBLUI
 V/HLY3kgEQYaoeyyqUdt1Tnye96pB8Zku9c1qaPq8ppcWKEU2M48Ka+MXLt1n1Vyx13O
 GPbVcNjXBhOfEh2CMPOV3qr9YtQLHIlzKCGS81uRPX1rdmPWKDOpQX3o7CGxVB2l8dEJ
 DGDUHT2RnPKGsVC5uqnT3sS/CCbcrQWE+iSRbb35810aFXwEWISRjPCO2HwkxDSskRXt
 3Co4ybzCKj5RBcGTVF7YfvoGRxjpA3yPKdaaqnXVkZxwDXjoV84csp+YmHFTTObLNSNJ
 Qbqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGC0enQ+ioecAgvEIvoDpl4ywUimLcX7bWIsFGBRkKVVPP2spGXEx9rqs4/t9ZnjH4WRZZ8Is=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj9cQBmaTzscn/axPVIr/a3zLMK6U4RKfJNiDp8hDtWYtUAJBS
 Xe8YuoMW2vPCPWgqJ10HYgAkUSLZRIzbyDtsdEfYVdWA29p/LypvuIYf6BmooZBwnS+ojRsZ45N
 HC2bomzbn9AoLKnhXGMbPCXGfGc1UdH8X3rIgig==
X-Gm-Gg: ASbGncvCnvTRLh8qV+ralfMkf/LZVVDySCYWjp6Y7Bdp9w1ZTk73YpMV7uRAZlE/ILZ
 0Jm55D4RfHI7/8FZDtxr0fm5i0bGq/Q==
X-Google-Smtp-Source: AGHT+IG7gQMll9SaBCiJWCOJj8Ew9smk3T68hhjye+iYIvP1MRGORAKMI+mAcwqs8Rpu5Q2miZRTBcsiN+vvvPQDBj8=
X-Received: by 2002:a05:6a00:4654:b0:724:e77f:ffb4 with SMTP id
 d2e1a72fcca58-72530102495mr3035297b3a.18.1732695944685; Wed, 27 Nov 2024
 00:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241127070631.16412-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Nov 2024 10:25:08 +0200
Message-ID: <CAC_iWjKp=LiOWAiS9=zrLT+oP36ycL6VZLD4usr3jpvf7beuTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] configs: sandbox_deconfig: remove
 CONFIG_AMIGA_PARTITION
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de
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

On Wed, 27 Nov 2024 at 09:06, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We do not actually test the code.
> Scanning for Amiga partitions of the sandbox is extremely slow,
> especially on the partially implemented USB device.
>
> For build testing the other sandbox defconfigs are good enough.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  configs/sandbox_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 718e4a8283c..683888f238f 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -142,7 +142,6 @@ CONFIG_CMD_SQUASHFS=y
>  CONFIG_CMD_MTDPARTS=y
>  CONFIG_CMD_STACKPROTECTOR_TEST=y
>  CONFIG_MAC_PARTITION=y
> -CONFIG_AMIGA_PARTITION=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_OF_LIVE=y
>  CONFIG_ENV_IS_NOWHERE=y
> --
> 2.45.2
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
