Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE09CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7300684832;
	Fri, 15 May 2026 20:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kVP/nfF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31DC9846EB; Fri, 15 May 2026 20:14:40 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 070A88482F
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd0fc4c336eso8333366b.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778868877; cv=none;
 d=google.com; s=arc-20240605;
 b=j8u39sHu06KD6BNgBD79qL+AtUPvNbY6FsfM0v/vzztRqTVJJn8CWvN3O5zqxy21s7
 iuY/hKkAHkL6m2rFBQO8AWzLzqx5KutHVWTz35rJ9+wVsC5HJeR3iIUGFpWdYTaut40Q
 RL4+DP+36NpBMMDI5v9p9HOuMnazpXN8/BBnvn7T1Jer8L1HWUBdtqaqZWKX9V+A0UbM
 SDiapIGxnyjFoUne4dwcsokH8hA16Ni+6jK3Vfl4l5Y+QYlu/Oz8LuksJnkpw3Soog13
 NI/l63D4m2YrUbThT1+FbUEk2Jw93I3O9mw1/qpW7Kj04IAQy4kpUATwZGZFvt4uhZI/
 rMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sWrnUVV/etlaBf2oDSoCs5K35pfDloP8A/yKIGng1ws=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=VgkdYMZodQCd92G7ZYj4Cwj7Hor2JzI/PPnI4Q0EyKPSG1Wo00B58iLBCy2pWahYEu
 3kouKi12OtA/EYSA6/U4C/RBz7woXw9X63B4QjYyVEiTkl7Jg1sPGqoCa3Xk9dBh2jjH
 Pnam2bB6wg95SI5D6t6hx1OW8QUS/yCU/2FOIG9BmnZ2qm0+ng2JuG8c+Itb8MgQ07c9
 XX2OvZvQcpW2gL+CxNWEHN8UnpA6xOrO/Ks4FZl/j7y/LC2xpKQ9hrSX7TbFS7+tXl51
 2jWbvvdiXLnX8CEv/h/ymkUJJTuEslsLo9obVYjVc3/KLmNOyMQszd4NhJR6cNOIkx1K
 ndYg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778868877; x=1779473677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sWrnUVV/etlaBf2oDSoCs5K35pfDloP8A/yKIGng1ws=;
 b=kVP/nfF9GTuwlGalOfgKHQxOk5y6IYnkIvJYGFk/D9On5oBNL52kwONNHFQHbZ7LoX
 lFR/rxmw9J5PdnwOdVpqbIg7cM/qd0S/kK1OiA9rc/fg5nzBhMiNi0vt99aC0BLppROe
 kJxLsXxb/AvgzblOJOqNSIFsl3/bqtuWizQ5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868877; x=1779473677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWrnUVV/etlaBf2oDSoCs5K35pfDloP8A/yKIGng1ws=;
 b=RkzSi6AnbS7MrFXt9XOfI7H9ILNp8JuYSXEja/Qy34J7RCauLaEsi3OoC9R1ogJ26h
 J5MXCAVq+XeNUBrRtsZjgPEgex5buz2yA7H3/yjuACgimPKW7j9/pu4TEAh3RNInmqWA
 cv2rK46DNuMwn5uAy2zlChj0qjq1c/nWlzNOwx5e5uVUSN51F/wNOvbYaJaaJjmZ1Lj8
 q0FvWpMGk1aQlqvY0D3+hzCb/DYoaC9X7AUCBrWYoAjHcsdsloMyIEMpRVdS6ni/25nB
 kCfXm+RxG6Foz4L5IApda23dvMOdPW4oM4TLZfiefgBHlgyVM6Lq/0nhFSAKpvCdyapL
 preA==
X-Gm-Message-State: AOJu0Yy5rheO8e0asDp+3yjR8fSttt8OaM90z0sUtBlF43lgoHjigIcu
 QPkRHi8ec9kh+blcdrOHhcdQhmu0OTQAdkgwv71je2yH9a6/zfY+vGLX3bzFCbtO9vc5JCkTQFE
 ZR18QZjNgZlac5EvoFOqd2sb+BmnLtfIPK/adJbuTQJuXBRcHmlw=
X-Gm-Gg: Acq92OFEl+TBvdX5o3WPCOVSZr2p5QXYtxjOHtLlMbS6ry3uqqswet0SwBjWsEUGyo/
 1P6Pzh48l8M0t6yOLnjuO3gPn25b+BA1v3huNnBljgnLaLVIz+IrIrPHfYg3HasFm1PUPUPO81x
 iXzureagviXqKw2bQor0wCQy+QCLpPGsiZ2Rb5udXjn0LxD2TFoafg0Ka4gk1GgN3gLA3BeyB7Z
 4nDZWR1SyEbPFxaYoI4GTPfkL4Wc16mHqqh7Sz920Lw26itcPJmKp082GCYLKl0n46ugpuRhSzp
 4w9yx8edMlTmpB79
X-Received: by 2002:a17:906:9fd1:b0:bd0:8b28:1e13 with SMTP id
 a640c23a62f3a-bd5177dcc3bmr285357066b.17.1778868877424; Fri, 15 May 2026
 11:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-2-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-2-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:14:24 -0600
X-Gm-Features: AVHnY4KvSRYbQ5DkPgIZOUsZyivA27xoCsMYytaE3kkkQ9cHli9wBhuDJHBCHSs
Message-ID: <CAFLszTi-Uf9yvEbrOBi12OMzC+N1kUWuJ8vyiE7Txb-hz2aTPg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] efi_loader: add runtime memset helper
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com, 
 sjg@chromium.org
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

On 2026-05-14T12:49:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> efi_loader: add runtime memset helper
>
> Add efi_memset_runtime() for EFI runtime paths
>
> This keeps buffer initialization in runtime-resident code after
> ExitBootServices() and avoids relying on non-runtime helpers.
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> include/efi_loader.h         |  3 +++
>  lib/efi_loader/efi_runtime.c | 20 ++++++++++++++++++++
>  2 files changed, 23 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
