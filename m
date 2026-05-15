Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6CFCD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1158846B5;
	Fri, 15 May 2026 16:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a0FzgfZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8058C846AE; Fri, 15 May 2026 16:11:51 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92391846DF
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd4f8260e4eso361529066b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854309; cv=none;
 d=google.com; s=arc-20240605;
 b=XPwKBSivNkDK5xe+/JF6X5/JiwnqjekBIHSvPZI8oi4wWAvf0gZHsmupIrkXVhd+n6
 /LEVIOTnVR7kRxIxpjwtjOyYqRjNxRZgkoveUDGghfWrj0SD+WPWCR5IhGZYYZYarYdF
 r/uai8VibnNRFJcqaWeUy5dZuQMhJdU1keXbu83gaQzxM9KFf7rc0CseOVgKfpGpqDLp
 +FQZbe+c1pM5dT526Lmw0eKuTm3a6/TtlnJ9nrKVK0eXIYnIpd/qNQbh7asCeDbX/G4u
 kHlojJ+QLZVBxsjr7rFMgsko3QUQpg3qqM63+rMFV8QB0sMwTWitmLifpXaoehawTXeG
 VYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5bcEhctd/cgKgKTZR23HVycHBksZKPdc2CPpFj2zCbU=;
 fh=jgQO4Aeu3CLg/dHz22XG3eiG9v59GvuBaCBQDgG0QZ8=;
 b=IVMq/XJZH3ZHWbkxC+9H8rwkF5reKpZnw6MG0HSZA+V+zfcHPQV5A0+3FnPzMcjd5m
 Rd67O/xxUPIB4LdMbg+hIEsnSC/0c1sSq6Z+TcsUjc43CB8fdV8fjjrLxnSqVRAZ0rPE
 XboAOTTYfrBl7i63V/thPoS6kEJv8UJAEhc8SuilniW8BFRgoL/erkLFjB641z74AHLQ
 k6P8Vxd+HGO8uX5oWboA2HEqhvCv0JJXSX8IpMsEDW8Klpnm5ckl+kxtNKhC/E6Kg3mm
 VK8yYC+wLkIriAFqt8jIC8BnFODnWOKB4MyBeMHo1hGlEHtq9xMzrIYxZJDCpQ9z/Y1p
 iZjA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778854309; x=1779459109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5bcEhctd/cgKgKTZR23HVycHBksZKPdc2CPpFj2zCbU=;
 b=a0FzgfZTiV6l/K+hVJnOI2vlpOnmVy0pWbQSN0ATo6RGfqmT8boM4OcjFCRb+xfqx7
 iY3a/xEcxe3C+tIsLRi/kv5DF/8DUUusCVIaIFZWJpW+lYPGnIm7SG8MUUL5wERC0Hpu
 420i0AZiZ6M+pQeYMDTPEhtL6UukPNKTfA63w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854309; x=1779459109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bcEhctd/cgKgKTZR23HVycHBksZKPdc2CPpFj2zCbU=;
 b=i6P1W8M3FVgnRgcFoXXIDd+tHfl6appah3v6u+g8S3tVcKPf1i2YgkICYk00nf5KvW
 dHVtwb9o38pjmwl5ykypn1KvlW347hTPIG2rKFpNEW+PbT2PZl7C4ryBK253tVckhQiL
 n5vHCKivsHm+p0SC2LFlIyNt04RziCxvfM1nEn87kzPm7VBeSsnBIkeAZsrsK/0ZF8cx
 rrqccyuMOMZ7eyKmdXhF5YW91MfrqqRaaBoMUc3dZQyDeZcIRzpYLZdLXPkXFWs+uV+P
 dUm9Hx4OgwKF2QvDH8gHROMqSiqkVoZKdwiXJVuXZL5LP1xG3HK9dUcYYSUQquVl0Qsc
 hTTQ==
X-Gm-Message-State: AOJu0YzApbRnMBiGrBeeAWERJJrkx0cRRZbpnLeSuKIod4L5ot63hol2
 tC+SLlHyTPoqyB1MQvhirJ0GExygtAQNW36DFd4iU2VuMQK+w8cQsnUBQZp9ARKYWVUXwAP+AvC
 h9OfX5YwdJ5rUcqaEYg+MakQ4Tg+1Q7zrMrMi+cDT
X-Gm-Gg: Acq92OHFtS4ulmip280lN4h9Qepv4iHqPNpGqGae+SPLX8jPFS19Et44RGUDrC7Gpa9
 4S6jfhoe1R3eNhzEpxeVnTMcAkUT+yHaRpVOjXP8/2xt8tQaQoE2CCjY1g4smRcVy9oL1nHX9BB
 rRbXGeXqLt2JUvIJGWcOAZstX8zF9P4E/j13pE9Zck+jwio4MnMCIeDiRGESVYo+m8biynUgQX7
 IQ8AMXe5onn/lgGHaKSsHtsACDYnsnrK55ORbte68yc0cxYAaukvla/VSIgPRDxr7ftI+vvcQdj
 GLE4QA==
X-Received: by 2002:a17:907:e849:b0:bd3:94f4:6db0 with SMTP id
 a640c23a62f3a-bd5170b1ecbmr241175366b.0.1778854309051; Fri, 15 May 2026
 07:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-10-aidan@wolfssl.com>
In-Reply-To: <20260513002625.76915-10-aidan@wolfssl.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 08:11:37 -0600
X-Gm-Features: AVHnY4JG2oM7PXdDtLRlhRmNMXDL7tQ98KNcSq8EuGoQEW1_rJ5oUD6MIkV1-Ug
Message-ID: <CAFLszTijVSSb+yhubb6cfaEpv_qqi_JkycQe-eSvGTEbjdG9vQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] cmd: refactor tpm2 command into frontend/backend
 architecture
To: Aidan Garske <aidan@wolfssl.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Garske <david@wolfssl.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Jerome Forissier <jerome@forissier.org>, 
 Sean Edmond <seanedmond@microsoft.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Heiko Schocher <hs@nabladev.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Brian Sune <briansune@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
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

Hi Aidan,

On Tue, 12 May 2026 at 18:26, Aidan Garske <aidan@wolfssl.com> wrote:
>
> From: Aidan <aidan@wolfssl.com>
>
> Split the tpm2 command implementation into a shared frontend and
> two selectable backends. This allows wolfTPM to provide its own
> TPM2 command implementations while keeping the command table,
> dispatcher, and help text shared.
>
> Architecture:
>
> cmd/tpm-v2.c (frontend - always compiled):
>   Contains the tpm2_commands[] table, get_tpm2_commands(), the
>   do_tpm2() dispatcher, and the U_BOOT_CMD help text. References
>   backend functions via cmd/tpm2-backend.h. When CONFIG_TPM_WOLF
>   is enabled, additional wolfTPM-only commands (caps, pcr_print,
>   firmware_update, firmware_cancel) are added to the table.
>
> cmd/tpm2-backend.h (new):
>   Declares all backend function prototypes that both backends must
>   implement: do_tpm2_device, do_tpm2_info, do_tpm2_init,
>   do_tpm2_startup, do_tpm2_selftest, do_tpm2_clear,
>   do_tpm2_pcr_extend, do_tpm2_pcr_read, do_tpm2_get_capability,
>   do_tpm2_dam_reset, do_tpm2_dam_parameters, do_tpm2_change_auth,
>   do_tpm2_pcr_setauthpolicy, do_tpm2_pcr_setauthvalue,
>   do_tpm2_pcr_allocate, plus wolfTPM-only functions.
>
> cmd/native_tpm2.c (new - native backend):
>   Contains the original tpm2 command implementations that use
>   U-Boot's TPM driver model (tpm_api.h, tpm-v2.h). Compiled when
>   CONFIG_TPM_WOLF is not set. Common commands delegate to
>   tpm-common.c helpers (do_tpm_device, do_tpm_info, etc.).
>
> cmd/wolftpm.c (new - wolfTPM backend):
>   Implements all tpm2 commands using wolfTPM library APIs directly
>   (wolfTPM2_Init, wolfTPM2_GetCapabilities, wolfTPM2_ExtendPCR,
>   etc.). Includes Infineon-specific firmware update and cancel
>   commands. Each command initializes its own WOLFTPM2_DEV instance

This commit should be split so that the refactor is first and the Wolf
stuff later.

Regards,
Simon
