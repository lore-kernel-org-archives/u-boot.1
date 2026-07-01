Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC19C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 19:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E5784C3A;
	Wed,  1 Jul 2026 21:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gs6rUiIS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0132984C40; Wed,  1 Jul 2026 21:54:16 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA81D84C39
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 21:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6651bc57458so850930d50.2
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 12:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935652; cv=none;
 d=google.com; s=arc-20260327;
 b=Npb/pvZ+QOYAKwfPJpA0j1i8O4CWUpB5mkMm/gWHevDa+P41PePyqXPc1YW5vkW4ox
 raVWUZIjAC5YjTK/8Yq3Hg9qkPY1NE1oVGEaw8aW5MRHzc8BTIBe2sWfD07J2lXfaW9D
 l14WJggd7ry7eTp6dFMw7qHMo0sopd+i0SAjvC3czRBprPV6FXz8qppJPF2fKB8FVRjM
 T6m2mN7kgkQQAOsXD0U3PMtcvADeEEIkt+si3GhEXkcOun2tB05I5El3YwJtK7oFo8L1
 BVGnp/vLKVw4+NTdt6W6J4LZNltiINjewqK91oSxAzOCb5FzkHpBX99cjfOOMg8eW2tC
 Z3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0dQO2eUxAqP2JAoHZCuVFhn2eHFe0e6/ZXUXNJj19Jg=;
 fh=w4tsVMWxQhqwa1MnJ0ILkJc4ZA42nwAMaUvPco+oz3s=;
 b=ntoDiAFutWZ8WNo3BvvA3FagktYq/gPvndTe43UFUA6q2XJNPqo5DurmiPVfdl3uQq
 8HGab27Nls+1h/ieDecafeO1GmynWtBpLPlQoDI+uQXs/XckcYqCGJRXWPXiqgQOPK9E
 TgrMJ9yRhJ01saG8yN/tySmRPRO6NmTirlwZ9mvuM9pyPm4ZPP3AaroZXLTlz8qIC6Q1
 jvMfnU0UttGKj7h/F34rG8LHJGk3vLWKmQsy7bPDhsAiI833fjvYwcX/DThccNafJdCb
 USm+Cp7+Ws/TkORppeHr+Bn8ujAw595MdGIY8ZdVYXajRAG5YZg9iGvwHW0CcGLtYJdp
 Z45w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782935652; x=1783540452; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0dQO2eUxAqP2JAoHZCuVFhn2eHFe0e6/ZXUXNJj19Jg=;
 b=Gs6rUiISVfBOYhkr39Dlyg0FG+4LFiakv7v9JBZD42K31Dvs090Ad0fTEyltCb6YAW
 x5gTanAUS+VNopLPvXTVXEjEW+i3ZSpqOC+XDo2evE7lwch8SwPA/BaQhyDG78agdDnZ
 9yF76v25YzvtWrw+xvRFudY8BXZKZQmElkDW+M3b/BpIRVl6y6VNcz0p17h7WrXWSL/u
 x3Pn9x9N1HRGMM3V+aZuCZseSJzFBp7xgUFArCsVpefIEHmfmUaY4IfByeePiLjiqhKj
 R3049cUrivTkJYwXQJeAAknco9q4R4+hgJ5u4QMifWoL62O3LUy7CTVoMvW8cQ44AKHm
 +swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782935652; x=1783540452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0dQO2eUxAqP2JAoHZCuVFhn2eHFe0e6/ZXUXNJj19Jg=;
 b=jRM2X1YjDZNWkPBeO9RLgIUB30CR0hyclf1/A97B+L1orw9u85uyCBom7TyJqNH+8v
 qfVLTHkf2eLQ01DqinlxeQKaPlWwfcX4hE4zgp1roxAb48XQqz8QzIH+zPsEHzJYxW4L
 1k94V40OoTGXFeY3G/qHhjHXwCaRiuwvWBWHEKET1HkzzOoLKMLCkEOTGTTxRhduvfMq
 lGs2+etyqnjWras9BGj0WrJ51PcZC19uVCmevHOg1YBKOdCdORkW3WPeo3UCPP/EWpKd
 n2RB4pWP2TrYhNjF1MMw6yI8DjcRjaqOsiZb7HyMUwgXUxMLaDOBNp/oytApDZRfR+pM
 apcA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqem5J/UcQHiZreFjQGyRGIhoRK9I9LbODFUQ1EnEf0e7B5+3y7YL5uEjrUoGbFhplVWscjAMs=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy7Zr5rNCBQmWo5XweLCocsF9w2PA1Mj6Vwwnxf6c3/B0zCCth
 zJKU7JKmtnA06kY0S56hFpoHq7NobMjKOmArl30IwJbj3pJ09qiACTiEwfxpMW8CDlej2dAVVJB
 kxoEmXD+hf0j2DRBytVSr28b0+fTmwdVTjuDJb3ABjxSpT7YdQAT5v/CKfg==
X-Gm-Gg: AfdE7cm/nOWAtNDrwjKqjr5hPUddLfREFAJYPVL2jcWh0/0CeHK/svjb1OGBDNGbEXw
 C6Tiy/OrgERYdwduh8gnqUq4hcoRZHBNjZa2VGMjg9bo2nP2jkkx3B4wqQr5urgagjpYWDHGwAK
 0ksHSxIehQMMw4GG9cVppxR+oK/GWC6daIJkBXxQSumyOHH8xlNKEfNrjmMdQTNdgkSaCcncsW9
 EH7lBX5Kd9f7HqNbiH905FD20/5mPqrLsAjHU74JPe32BTlPRqWt2Egor8xYi962SqdUQ0ITZHJ
 HKtDRpRV6qQF8nAnXNAQTSFbp8aAurh9LzNND7I8xpwgWBDjsaU9EPULg9pYfymgwrkikZprI89
 9UcsfVe84sqZqNZbZPRlI5+4xFEpjSH+4L0VEBhY+4hFz5JWyg4g/gJIaQEQRTVfzK8DYpLVOAq
 l2IQ/bSMqVX62fXu0uBGv+DPIF2TDunf29YRvPCKn+tvGr0ChqYQ78fsAsSNX8Y9xSHMruDQizT
 OBRhThqU7MUCBYVtJb3xemq2iLBweiv18kGPXOppvbV7neGXrmTHh6YLH6o0qCmbyACcRQEOPej
 0l4MGxZ/vC9aUdmfWD5peU6U69lAICij4x/d64yahh3JG36nG+TcjzyM+RXSue2YrJVkrOlS
X-Received: by 2002:a05:690e:169d:b0:664:ae6a:ef3 with SMTP id
 956f58d0204a3-66596697bacmr2401823d50.81.1782935651968; Wed, 01 Jul 2026
 12:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-11-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-11-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 22:53:36 +0300
X-Gm-Features: AVVi8CfZP-MQ3MTCN7sE4kusVJ0qaToJ-Gq_Bpe-UOLRvChjDndXFg5yr8FpmSo
Message-ID: <CAC_iWjK+DY+JYgWJ7k2HsBKBQX4YZhNxL1dAEVgZzAhDiY1_uQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] qfw: fix RSDP ext_checksum recomputation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

On Sun, 28 Jun 2026 at 11:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> table_compute_checksum() returns the value that makes the byte sum of
> the buffer zero. If the ext_checksum field already contains a non-zero
> value (as QEMU's firmware-provided RSDP does), adding that existing
> value into the sum produces an incorrect complement. Zero the field
> before calling table_compute_checksum() so the calculation starts from
> a clean state, matching the pattern used in acpi_write_rsdp().
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> v3:
>         no change
> v2
>         new patch
> ---
>  drivers/misc/qfw_acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
> index 721f42ecbc3..afa3b820395 100644
> --- a/drivers/misc/qfw_acpi.c
> +++ b/drivers/misc/qfw_acpi.c
> @@ -265,6 +265,7 @@ out:
>         struct acpi_rsdp *rsdp = ctx->rsdp;
>
>         rsdp->length = sizeof(*rsdp);
> +       rsdp->ext_checksum = 0;
>         rsdp->ext_checksum = table_compute_checksum((u8 *)rsdp, sizeof(*rsdp));
>
>         gd_set_acpi_start(acpi_get_rsdp_addr());
> --
> 2.53.0
>
