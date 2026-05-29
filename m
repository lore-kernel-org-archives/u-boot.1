Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A54CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 07:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E24C3846E2;
	Fri, 29 May 2026 09:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bUf2oSTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 450D0847C6; Fri, 29 May 2026 09:03:24 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27D9844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd8faef2e18so1743312566b.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 00:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780038201; cv=none;
 d=google.com; s=arc-20240605;
 b=SC++R0BaNWf1iTwrJBx1CtioT2CGKXqCCmiwsanF29Aac6t5/dOfIFhPM8gmpiIIs+
 qmDDPzkNkGZ9NaKiMVvBOamvqYJAtfDdJdjBlgNVFqcYK07OMMs0d586E17wzmWUC1B6
 ENe8PE7N6zl/8Qu3926ESGarQegrBA18ICUdHRxZl2Z6X9cUas6N/WSBjDSETRiHzWO5
 2hY7mCNfL0pkWGB3Orc3GkviPwJUAJpdvE7aE6HL7OmmIw0YyjASj0FRXo4Utudzwo+/
 ru8vP0t5rsUwEUqB32cpupUtAEeCl8sz0WnOJwygrKVJT8ehODvqbjf1a8LAfQKFxJpK
 7/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cGsQf9KmSfr1N0II/qRAh3oIP1vtHhmDqo40EmcCCOM=;
 fh=pG65kes1vWDQ1AvYIebNuLUz/8pQiTkb3lwpDruQbts=;
 b=d+zao/Uu1TEbNuzZpoE1yVTSNkAjGo1Ps9KJ/GX04w02IrreqJD+fAqZ8O0271DpLm
 SykYYUIrVeB+S3ufPumGTM5CDbbdkFmoe2IuMSuXQpXRBiRFV3zUh5LNTbIFRZaSFE72
 ZxY5XpqbPP9q3hS+sm1xcY/SVD2OfpznJr5UpVs1n7PHyJ/Shlv2xZyKXVF8umwAlIyE
 kej3gtQ7MoZuEBU0Ez1QAB0obVPuzZBpcM90RahJKZTKuvN8hb4Kk7CIR6aryrXuXhCV
 qw/bQt0oe4iZORwzuUmUjuvUMIDK3ipxJ3lQwG71/Hw/jRJMaIHQnX08K+gN3NjzqdRs
 QUPw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780038201; x=1780643001; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cGsQf9KmSfr1N0II/qRAh3oIP1vtHhmDqo40EmcCCOM=;
 b=bUf2oSTlkee6D/dnwYc13PSqkLyOJgxFDFygmS7kRYumdJSE8bHBUGKv8Ui6s9QIMV
 uLZEV4fBP65mzZ5sAEQf5yB2P2o0arCr266+Hlbe91R+bFNvnHWTH0jVUrseK7yt1hW3
 hS+nOtO8uk2evCg8+lgWKbXHY0PajIqArQSCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780038201; x=1780643001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGsQf9KmSfr1N0II/qRAh3oIP1vtHhmDqo40EmcCCOM=;
 b=MwkA/87rJKnzWkxrJiJsQj51wjHfHaWig7zkf+07cw4mVI8Txz52hN76BpgHF9nS3r
 PiYTKzLlYWF3jJoyuO9nDmPc6EggybZoPC+z+7i3UCPAcV2pm0kNvF+LiSSLZQs0m9+4
 W2evPJ/hrN/B8rAZFdxYkxb9LYjRcyheKpyZdf78Z0Oec12+w/oiotvfJ/m3B9080J0u
 iHDaOubucDXVeL4XKKgT20XsbzjF2oxdbT4hk7/q0zPOblIKf0SQdhgKsAhv5EoCNgNN
 v7vbOocXXSWwtORrWCLQbDvyFSfrtXRVzPUqdM5OJF77fpxc9/EPehn1fCnOCk5iQnlN
 V+UA==
X-Gm-Message-State: AOJu0YzGDQhu61+K4w/XyWLYzF8BA5swC2r+q/Z9ZuZGBCYrVwezu+P7
 jUs39O/dIAyhFNc/An2/w9+XtWbMc7+iIvPAhr+jhVKm8E6hv4SqLVLwHfUTrIvAUsY5gqFLPGL
 3nkObFT6FdNNmwZuop4xPH+L8R/t8KdOqDATjxnar
X-Gm-Gg: Acq92OEP+I8QQSnVmQm5MLVGoh87gCfPjFQ5+VTU/dHT6OFxPCG+yDn5Oiq2H4Ou9Iz
 G253FFEwaksVPfgSlgZsDK7n1Mb1IfMrD/gac6vXlKopkJ2SrhlXAZrQMAFYvOHwZRrscwDAl3R
 yx+eUzDpIizqkRPJ/Mn84VwEJmvV1+mNnrayUWldbZJwW8C2cPb5cGbtYCXXpaNqn0eCQFzpPD3
 0gpIqDZxfwQKQNBIP/ZWSGLB0QSgo99Jr3MdexNWqnu1eZKk2AHKyW0wWV5gLD84Dn/xFxVMxJY
 T0ujsRDshQjR+E2p/yk=
X-Received: by 2002:a17:907:9994:b0:ba8:8094:f7af with SMTP id
 a640c23a62f3a-be9c92415fdmr75586066b.18.1780038200529; Fri, 29 May 2026
 00:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260528114900.1505642-1-ludwig.nussel@siemens.com>
 <20260528134802.v5.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
In-Reply-To: <20260528134802.v5.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 02:03:08 -0500
X-Gm-Features: AVHnY4LTT0ElV6GIm2-N9ltvT0i29m13abhW-W1PbOJoeeKc-kCoFGz2LrzuJ1A
Message-ID: <CAFLszTh9iEsBrfVBE6-dBebZ26Mk2sWCe+JF0-FGcPtoAdJwvQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] qemu-arm: merge built-in DT
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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

Hi Ludwig,

On 2026-05-28T11:47:57, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> qemu-arm: merge built-in DT
>
> The keys trusted for FIT signature verification are supposed to be
> embedded in the device tree built into u-boot. When running in Qemu it's
> convenient to use the device tree provided by the VM which doesn't know
> about signatures though. So merge both device trees at startup.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> board/emulation/qemu-arm/qemu-arm.c | 47 +++++++++++++++++++++++++++++++++++--
>  configs/qemu_arm64_defconfig        |  1 +
>  2 files changed, 46 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> @@ -144,10 +144,53 @@ int dram_init_banksize(void)
> +/* QEMU loads a generated DTB for us at the start of RAM.
> + * When using signatures we may have a built-in FDT that contains
> + * our known public keys nevertheless. So merge the built in FDT
> + * into QEMU's. We cannot merge the other way around (eg in
> + * fdtdec_board_setup()) or board_fix_fdt() at this stage as U-Boot
> + * might be started from a ROM location. At the same time U-Boot
> + * needs QEMU's FDT to initialize serial devices even before
> + * relocation.
> + */

Please use kernel multi-line comment style: '/*' on its own line,
prose starting on the next. Also 'eg' should be 'e.g.' and 'built in'
as an adjective is 'built-in'.

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> @@ -144,10 +144,53 @@ int dram_init_banksize(void)
> +     ret = fdt_increase_size(qemu_fdt, 1024 + fdt_totalsize(*fdtp));
> +     if (ret) {
> +             log_err("Failed to resize FDT overlay: %s", fdt_strerror(ret));
> +             goto out;
> +     }

Missing trailing '\n' - the next log_err() has one. Also, qemu_fdt is
the base we're growing to receive the overlay, not the overlay itself;
"Failed to grow QEMU FDT" would be clearer.

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> @@ -144,10 +144,53 @@ int dram_init_banksize(void)
> +     ret = fdt_overlay_apply_node(qemu_fdt, 0, (void *)*fdtp, 0);
> +     if (ret) {
> +             log_err("Failed to apply FDT overlay: %s\n", fdt_strerror(ret));
> +             goto out;
> +     }
> +
> +out:
> +     *fdtp = qemu_fdt;
> +
>       return 0;
> }

On failure we log and return 0 with a partially-modified qemu_fdt.
Please propagate the error - otherwise a board with
FIT_SIGNATURE_REQUIRED (added later in the series) silently boots
without keys merged and presumably fails much later. The (void *) cast
on *fdtp is also redundant, isn't it?

> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> @@ -38,6 +38,7 @@ CONFIG_CMD_EFIDEBUG=y
> +# CONFIG_OF_OMIT_DTB is not set

The commit message doesn't mention this. Please add a sentence
explaining that OF_OMIT_DTB must be off so the built-in DT is present
to merge from, and note whether qemu_arm_defconfig needs the same
treatment.

Regards,
Simon
