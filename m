Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BD1CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60CBB8482F;
	Fri, 15 May 2026 20:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UYKotFVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2ED1846E6; Fri, 15 May 2026 20:22:05 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C900D8482F
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso7726666b.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778869323; cv=none;
 d=google.com; s=arc-20240605;
 b=ij8KsAoMMq5hFxTKQmvSPE4ZvPOyvsxXha6km4AzgMd917oOLywN/4p1TSjtMVY7ff
 QzVEgbpkTW+HJx5ZFYH4fVi71D13l7SOdSRNB52nHWCSCg02TdEJSsMKjA3V3fjo8AO0
 LpXJBQ0sakzIPuZcnX3LnAhQAyYkZgpcYCWyDAgiaU/OZ0/RkPg7v+ScdPuKxkdHeb20
 DORhqDeQIp7dkn9hVdGk/tECRb62Au9XwDLBcxwsDAbcV+zUWjDRcb8PD6/WlcgLvtbl
 rcuPnlvy+P6C7w/cI5n/0ACOozTkhvFlSuBX71B4xPum7iBOmHiLjbDgL5MEPV24zlNn
 cXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OhDlaQ5ffZffcev2IKvA9XNk1Uf9MTk2ax7U/PhyXdg=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=dUwR+9p6C9V9GbRFbUrDXw6+NQ3Y8KwMqNbL8rrVNzGTa7QjD2IMVes4O4jv3u9f7n
 ILSWsnMh8eReGVaGKNDA6xU5UkYM681yTp8LE41+PjRLu09hu+VW20meszV6ny5Leu79
 zBF+TnXu0zqMa57WFbLZiBBBeBAaaSdlo4R/AHm83JIP7Gc+gw4i3R0E098r/DlyWF6x
 L+n1bnpbHcXeH/IHPm27A/vaGI5/Yj5VZOc2c0jEKnvkThoZMKMW5tHjuvm6mf/KLyD6
 JWWZRC2qz2Uhw0GNEtX2mjg7+ET2TuOcDX5CiNh7tRLtaEcAy8hySwiUqvOwBw1HNkf7
 bR8g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778869323; x=1779474123; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OhDlaQ5ffZffcev2IKvA9XNk1Uf9MTk2ax7U/PhyXdg=;
 b=UYKotFViUdvVA/y0UhISL9TX9l1rpm2OS225Nc9TF08PEF/E8LKYh15FMff1zof26g
 qVJzj7qLKnB3FVo+VRheTS3f3PL2Y9omdprcxXgewcqFFippc4CtcrMWtQXCCbgiBuwX
 gzqNSSRzMktLA/hjrqWFL54vi0GAH9CWcPFN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869323; x=1779474123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OhDlaQ5ffZffcev2IKvA9XNk1Uf9MTk2ax7U/PhyXdg=;
 b=paG6RGKLaNU9gYQLOVsdvFE2jVSp2HG6EkPb2xIFjPwnn+HcNbQrsCIAEYGO6Sk8Wn
 SU1wNnVbOb/2pqNcqgA193GEci9m9zoDyBd7Q0yKG5nLwFxc+lJDgWAtlKaCGg1YL7z0
 n45BSz5AWbUV+eL+/GTOL82VQUfwlaJlpxSVJZhJIQSlOOAJIpgXDkdXrr4f8Ffei0/r
 HO9ufkWM4/skgS6abodICbnFzWcq4YH93CdU/HsZbjkKj5nVPu1Vu+40wHNTJ6q7xzON
 MOX8WQolUrDeQ+ErplB1CScZJ9w3Y+hTIGT23lN+cFAOWOg9OW4iGWpYyLacUW37NGjL
 wEoA==
X-Gm-Message-State: AOJu0YyKfnhlvhPbh14UST0EP1zNRv9Wa+m68s0Khf9Xq2J1/HfK5ob/
 Fsy2UFsgJ8sGSljDc+obYGcKCOXJzc8dW4/jiazWHJR6+Bt41png/p14Cb4dqUVMfHkwiji3H+X
 CHxQaeGyjDWc6oPekgwbMUqnjecjjVpypvixs6AiX
X-Gm-Gg: Acq92OGvujR+ir1dwzGIrZF4T5FGihYO7JxrTfyroH7b1QhgtAwhnT/ean2Bl/NBYth
 KLFYb9rALnPDQsh/+UmPgVxmedf/+qCAvIPEPokrwtaX/daNM8rABz9rhpidpN6TjMeitkaoWk9
 h6dWki13L3C23d+KviJTz+epOM2QZY8iyWcUQ54QLRtLXGcp5YyjDrcRnjeQqqxIEzXQo1b/iMU
 lWV5fm6G7rDQ/BpOpmxsUYhpQOrfbINESWMsqm+MmeFwRnpQSobjBvwF+tlyNi2wGhOLULPAtpJ
 lfgQPA==
X-Received: by 2002:a17:907:3cc1:b0:bd3:5e5d:336 with SMTP id
 a640c23a62f3a-bd51777bbfemr279460766b.5.1778869323189; Fri, 15 May 2026
 11:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-7-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-7-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:21:49 -0600
X-Gm-Features: AVHnY4Iy0jDhB3rYsUrJuQ1BXNv6PqrOFSsD5kgvIx8xE2p9Yn8k1xbx8JF59J4
Message-ID: <CAFLszTgdjP3m+ai-9acqUNiWkz2aqfxz19k6qt_HY5WSLMoLrg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] efi_loader: move runtime variable read helpers
 to efi_variable.c
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
> efi_loader: move runtime variable read helpers to efi_variable.c
>
> Relocate the generic runtime variable read helpers from
> efi_var_common.c to efi_variable.c.
>
> efi_var_common.c is always built, while efi_variable.c is only built
> when CONFIG_EFI_MM_COMM_TEE is unset. Earlier patches in this series
> add TEE/FF-A-specific runtime read helpers in efi_variable_tee.c.
> Leaving the generic definitions in efi_var_common.c would therefore
> cause a symbol clash in EFI_MM_COMM_TEE builds.
>
> Move efi_get_variable_runtime() and
> efi_get_next_variable_name_runtime() into efi_variable.c so the
> non-TEE backend keeps the generic memory-backed implementations,
> while the TEE/FF-A backend continues to provide its own runtime read
> helpers in efi_variable_tee.c.
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> lib/efi_loader/efi_var_common.c | 24 ------------------------
>  lib/efi_loader/efi_variable.c   | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 24 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
