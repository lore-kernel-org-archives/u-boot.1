Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB21CF319D
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 11:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43D8C8391B;
	Wed, 19 Nov 2025 12:14:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="csXuQ/7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80CB483923; Wed, 19 Nov 2025 12:14:00 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A865280FA1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 12:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so4337265a34.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 03:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763550836; x=1764155636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UKhLZ2h2a6+ai/MepQyz561fmFT0OtR3vXMKArpqWs0=;
 b=csXuQ/7WxozKzYutieSOP6+Hj3rbDMqAHNYqJ10l0lASrk5vxfmPhlyNuF4CSovkgS
 tUSn8EvdDPSxizku+wJnYRDjvScUw+zvrGD1fL4sLWsMK8WXB9UFiypymuOzBuZbz5SP
 B06hbFEoPkPCGNrWoTAaLpmL0kBz5rxGD9u9OcAQKcGaEgabBPiZmGtaZIC+RUpDoSNs
 RcwudaNjho8GqPs4Fr1KpW8MFSj1VQguIbkL4lvc6vaEkF/o4MdenbJ/Zv2Ct3nWE5Cs
 tHp4Ne+qbNkWdJ1wnohRlVvL603XMtFxqoxKAeaxbyxFVRJR2LanPFc4mh0bmcjpBMeF
 8a2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763550836; x=1764155636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKhLZ2h2a6+ai/MepQyz561fmFT0OtR3vXMKArpqWs0=;
 b=a3ftrRoa107k8I4kO3jymAvznzhdwDN7L30LsqDf+BGp+kp9gCxwohmHmyCXh1wY3X
 abDQOh2aPwq2/onMzvGLewCaBcI/cXPHJ07dCrRc95ZXHosXc1NAhGoJtFJvd66ha8ni
 KaFU58gN4sbm0rMPjy5+zTsJLEpiTxeUfzeNnKwxim2c2tbbAHVOPfsdBJ1hn1dhB5vI
 P8nqi2js2jYSr2DUt3HMcnKIL9SHeYKz5qkJmYlU03sHY8g+29nWqGYYsNZtM2rEhGbW
 UeePyjpZ4PmhuRi5JrbcTm+s9SsDIAASGh/hurkDRw593PzgVlztfE2y96vj310N+DUX
 iGdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYIQc1VdBnq60LPKvZBUkXgnVKavkowy6RG++OrA+mFavpv9WwtsaSwar/fR0dTKbwRly6GAw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5P5nRnii9LMra0kgzBXW628wsENRJTWm+6DTl4bSpYG+6tndM
 KNNirh3WWwun5jm19fYjziAyOFil21sKKdYgsYTO9pe1v4KPwyr/GKZZ/+wXZioPQD6HhSqrKx1
 ozPWtiqNClQF7dq0VUDY6JgckVRv6A/Kc+kEVi/I=
X-Gm-Gg: ASbGncsDmjOM7xc0Gcw/BHnEmf7YYpN8m0pIdzL69pKac731szGk58gWSrVuxdYmsV0
 C8QgkE5K0VtoEm1md4aPmYD29SrO0wO470PFbOEUtDzrEGultF0EXgXAKSoLc9enxZGxXqMGLpN
 NcRSw2OJVsLPaMe/ZlSlAfI1DllkZiu3CGaExO+JdsnuXN/+gkDyEbTOoNA8lw3qj+kvXUcVSll
 DFJn0rnvq9ox+EQi/fkOYm6TpIBwwD3WAovn4Euh6fuCJPt5+3f5ZI3d7an/hq1vMYnpkQ=
X-Google-Smtp-Source: AGHT+IEKj9ooLfmSxIR0CDkYYAtkLRwU46PeLF7QI/SFhUIieV8K03BNbsg75mvGFNTURK5Uja5A5Da9wNuuQ6In4G0=
X-Received: by 2002:a05:6830:6d06:b0:7c7:69d9:d8d3 with SMTP id
 46e09a7af769-7c769d9e1b4mr6166655a34.12.1763550836271; Wed, 19 Nov 2025
 03:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20251104223023.1613-1-briansune@gmail.com>
 <7e31b494-1ce1-4fb5-af49-d203830add7e@altera.com>
In-Reply-To: <7e31b494-1ce1-4fb5-af49-d203830add7e@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 19 Nov 2025 19:13:44 +0800
X-Gm-Features: AWmQ_bn0yBvH0C_DiUIMpBIdkwxaQEunGWaRAx8fW7zhWGczM8eHhVKdKxwyTpA
Message-ID: <CAN7C2SAMWJUqK_pCvz4YDxnD_rHL8zh5VVJkYEC0DEOMV_2wog@mail.gmail.com>
Subject: Re: [PATCH v7] Add optimized Makefile support for SoCFPGA handoff
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

typo aligned on both so it wont be an issue from first place.
However indeed should be fixed to let user readable.

Remove: else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA10),y)
is enough meanwhile when users don't place any folder or path
parameter it will simply bypassed.

Brian

> +ifeq ($(CONFIG_TARGET_SOCFPGA_CYCLONE5),y)
> +archprepare: socfpga_g5_hanoff_prepare
>
>
> Typo: socfpga_g5_hanoff_prepar, it should be socfpga_g5_handoff_prepare
>
>
> +else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA5),y)
> +archprepare: socfpga_g5_hanoff_prepare
> +else ifeq ($(CONFIG_TARGET_SOCFPGA_ARRIA10),y)
>
>
> You are binding the rule to:
> Cyclone V
> Arria V
> Arria 10
>
> However, cv_bsp_generator.py applies only to Cyclone V and Arria V.
> Arria 10 does not use .hiof and does not use the CV BSP generator.
>
> So this part should not include Arria 10
>
>
> +archprepare: socfpga_g5_hanoff_prepare
> +endif
> +
> +socfpga_g5_hanoff_prepare:
> + @SOCFAMILY="$(SOCFAMILY)"; \
> + if [ -z "$$SOCFAMILY" ]; then \
> + exit 0; \
> + fi; \
> + echo "[INFO] SOC family detected: $$SOCFAMILY";
> + @set -- $$(awk -F'"' ' \
> +    /^CONFIG_SYS_VENDOR=/ {v=$$2} \
> +    /^CONFIG_SYS_BOARD=/ {b=$$2} \
> +    END {print v, b}' .config); \
> + VENDOR=$$1; \
> + BOARD=$$2; \
> + if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
> + exit 0; \
> + fi; \
> + BOARD_DIR=$(src)/board/$$VENDOR/$$BOARD; \
> + if [ "$$HANDOFF_PATH" ]; then \
> + echo "[INFO] Using manually specified handoff folder: $$HANDOFF_PATH"; \
> + else \
> + HANDOFF_BASE=$$BOARD_DIR/hps_isw_handoff; \
> + if [ ! -d "$$HANDOFF_BASE" ]; then \
> + exit 0; \
> + fi; \
> + HANDOFF_PATH=$$(ls -d "$$HANDOFF_BASE"/*/ 2>/dev/null | head -n1); \
> + if [ -z "$$HANDOFF_PATH" ]; then \
> + exit 0; \
> + fi; \
> + echo "[INFO] Auto-detected handoff folder: $$HANDOFF_PATH"; \
> + fi; \
> + HIOF_FILE=$$HANDOFF_PATH/$$(basename $$HANDOFF_PATH).hiof; \
> + if [ ! -f "$$HIOF_FILE" ]; then \
> + echo "[WARN] No .hiof file found in $$HANDOFF_PATH, skipping BSP generation."; \
> + exit 0; \
> + fi; \
> + echo "[INFO] Found hiof file: $$HIOF_FILE"; \
> + echo "[INFO] Running BSP generator..."; \
> + python3 $(src)/tools/cv_bsp_generator/cv_bsp_generator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generator failed, continuing..."; \
>
>
> Arria 10 boards require the A10-specific filter script under:  arch/arm/mach-socfpga/qts-filter-a10.sh
>
> Invocation pattern: qts-filter-a10.sh <handoff-input-directory> <output-qts-dir>
>
> It processes a set of A10-specific XML and RBF inputs such as:
>
> pinmux.xml
> arria10_hps.xml
> pll.xml
> emif.xml
> core.rbf
> other Qsys-exported XML files
>
> Because of this, the .hiof detection logic you added will always fail on Arria 10, and the QTS conversion will silently be skipped.
>
>
> + echo "[DONE] SoCFPGA QTS handoff conversion complete."
>
>
> Thanks.
>
> Tien Fong
