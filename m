Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D54FF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 23:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60949848D7;
	Thu, 30 Apr 2026 01:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e7+4AMYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2ADF848DA; Thu, 30 Apr 2026 01:47:15 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26B7A8487F
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ba51e69988aso42245166b.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777506431; cv=none;
 d=google.com; s=arc-20240605;
 b=Sj3swFNkkr+Xz2ChEBxmlUvCH5dS79QdsxQ/BkePXQKGg+v4qbgDPBInVfBumrd2HG
 y5U0uTuAJCX+84bnV4sEPQM/qwWSyW9WnkNMPODbFeiY7qGJTYUt3XPhFvRgXdsls8EU
 pZMFVulncAyHmSrANBaGM2rGYLJgG98pdHvlNPJt5lUgF7ZI8+Cy/L0iVHkWNK5HgYHq
 Fct/vy+ggLuewEEl2ppfOvui4bC04dcXHBpRGD9UlBQIoFjUll/BZDpOYugS3Ze/6bHl
 APncD32v7gVHGhLKkDu4QCJwXg9hVIqDcOamHJLAy7S9IOC+/gooGlGxQcgd4a7jVlcC
 Uumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8U3iPlPxJNFGGqGMXTI3oYqSZfoq7GEFrEJaNGiBKaQ=;
 fh=qrOaaotlfj7rJTEoVec3VuIUj43QdfbQVBhf16G8DcM=;
 b=g/6pC3ixHe3dVva3t+O47M5AVjKXRcf9Wcxce1sKCpO0NgP7SbY4zHIqer6bPympqV
 DGe6A4TvjYCG1eon9yDx0ocqrbb4od2hFe0GTlmmQcNDvqwZSZYQyY4IHRP+q22+Ih05
 /WvDcvvB9JfgNdj/G4XLHhlHpNh7LTlUi2KCQzyosX0daSPVykdbbd7hHlviLD47oMSa
 ymECjewRnLGjN4kLK5Xhgz68Lnoa01damfcGglaGgNlP0ye3VEi7hcW8GXwDCq2Xj5o9
 A/xQv4Q+Q7QmpL2iec80EyP/TzLcF/fXqoq5TqgAVvvgfAb3AwXWfn7ksNDMDan5QD2G
 5NtQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777506431; x=1778111231; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8U3iPlPxJNFGGqGMXTI3oYqSZfoq7GEFrEJaNGiBKaQ=;
 b=e7+4AMYVFxB96U7WtKpnvlgY7pfa0ui0qnvEMFm+2+Wf++uDzMNlhe4JQcnoRFcarz
 lXjvQMoF+jC0tveTtTuRdP5nPX/O1dK+/C81uxDEf3wBZRMQcQ37j+1duXNjrrwni/M2
 /FYAhJkX0WRfNEoCpCWiuC39boUTuJ1vPL/mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777506431; x=1778111231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8U3iPlPxJNFGGqGMXTI3oYqSZfoq7GEFrEJaNGiBKaQ=;
 b=naqXWKAoqQLKyLlix60iDACSvGvtvH4WMKaveE19Mg6vVv/Vk1lpRaMTTYBJtcgYpk
 dvwLdnXbmwId1UPjfJLZDIajHXIQB9xAuyEeOCYixKeMaQkx98hZP6Hi56XvfzsC/sWM
 DcYUSRddjHix6PtXsrca1frar9QNtfAI2M1hLW7kE67pHZ3my3mNy91tih4VWTC5JAwX
 63V24W/40xEtns9b5uKgEaMRHTAKwz/v4iY8m56nk2rzmA7F+DjKEVfiER43wW7/cf9X
 Ayw/LSbRdqtU99Cb5iMFBQa7nUy/kxg7cGzQAjNxzS0oRHUNCkp5UUeU9iAOzVGVNzor
 zFWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SNLIgYdwemtMDJ/QR+DGT9AhK4k/ut236NtHbR128IW/qitz7KUXaQrvznmFXIjtjiqnzbsU=@lists.denx.de
X-Gm-Message-State: AOJu0YxrQz0lrRxg0b+EDB9W1Wb9G6AzbmIXN9ZqcI4Xbrjk99eOEdBF
 S0WayTbr9LaRRuCdlqAko2BqerZMfRB47JCFJWek1Bos9XrIZO3UpgXMAGb1JrtFZ2qUw3TRjpT
 2Jpa7FDCoSTRwDbl+12A7FpkrIm0MUJ/FwIMBeqCq9qFcWqLBmp9QLQ==
X-Gm-Gg: AeBDietEO0NyuvjTxqhgAg8dymFdW/Tf0LV8l3haISjwMJVj+5sosjz26WdVeOIwqdf
 cOk72AskpIyZJoQkt3TfkYoaI5C8cEoTWj7m4O1kVdFE9Il6NmUgvXsGvBpYB4lu/DM+WTjh7kC
 uIXr3RFXDqnRh2r4f9lcXhVNwiZX8NiRORoxaI+xK07QalSzMzXPlOLQdZt0yvnvmiv8PLdz2/5
 S6LwgaDtr/YlQTUGGrTMtmxJbtQpUCvyBtwzLVevTXy8npurCXieizamK6xz8RJAadlvGEbFbM0
 q/86HnEU8I+tCaUw
X-Received: by 2002:a17:906:f58e:b0:ba6:5855:1cc0 with SMTP id
 a640c23a62f3a-bbac5bcbc94mr44490566b.2.1777506431547; Wed, 29 Apr 2026
 16:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-5-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-5-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 17:46:58 -0600
X-Gm-Features: AVHnY4K9GIeESwTc8r7tdLtPTzitXKXMo6LhA3UF6Duxre-c2MxMN5p_RrV77Pk
Message-ID: <CAFLszTjFFDBSbVtvjeSmiM8TB6bwsZJ0fiv3TtfboajPqn9YuA@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] arm: mach-k3: Add config option for packaging
 HSM firmware
To: b-padhi@ti.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

Hi Beleswar,

On 2026-04-25T03:37:39, Padhi, Beleswar <b-padhi@ti.com> wrote:
> arm: mach-k3: Add config option for packaging HSM firmware
>
> Some K3 SoCs like J721S2, and J784S4 have a HSM (High Security Module)
> M4F core in the Wakeup Voltage Domain which could be used to run secure
> services like Authentication. Add a config option which indicates that
> the SoC has a HSM core and the firmware for the core is available.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>
> arch/arm/mach-k3/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)

> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> @@ -198,6 +198,13 @@ config K3_REMOTEPROC_PRU
> +config K3_HSM_FW
> +     bool "Package firmware for HSM core"
> +     help
> +       Enabling this will indicate that the system has a HSM (High Security
> +       Module) M4 Core and the firmware for the core is available. When
> +       enabled, the firmware for HSM core will be packaged inside tispl.bin.

Since this option only makes sense on SoCs that actually have an HSM
core, a 'depends on SOC_K3_J721S2 || SOC_K3_J784S4 || SOC_K3_J722S'
would prevent it from being offered on unrelated K3 configurations -
compare to how K3_DM_FW gates itself. What do you think?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
