Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBE4CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE80F8467A;
	Fri, 15 May 2026 15:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lo3SwVFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F8884694; Fri, 15 May 2026 15:24:57 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA54684674
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so1062132966b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778851495; cv=none;
 d=google.com; s=arc-20240605;
 b=UZ6q3dFH7/gL6GVCvrMnSIoT07JD1/BJvpxi0XrZDQdOeT+e3HMyCx9dG3ZWdOKj6p
 AxKbUV2Q4kFsslRLFns0MnIKgH/jx/eccp+kdeo0O9tNJEmydrFg0OCfOmKGZhrUX3qk
 A6c1flx8OeSuWpG+mZpSVEf7O7I9cBtK9rTQyf4WY5U+dHpHl+2QGLdLFLD3+P+kg9/E
 ftix/LJyUtb4pNUeKTzPMyqcsshdVkGgUBdVdtTpLejdaoaukIwWiVFPFh2IGp5OKRII
 zJUnNBCvu2ZMKMNtJdtGkIpNlzllde/cbqSBnniLIT/2mpwHuwY5jvAQIytXWY6iYmFi
 4b2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4KZ6rv/GWWJ52Lx4UNdnB10JbVU/FnMyIQKyFO6AGG8=;
 fh=HwJnEC+xd4QKdPJNFFfV4yjwbumrPIfArwVBKmoTzh0=;
 b=H2T3AGcV8aVfHKGshf3NiS0FEEYqTSB6ihTrVM5XkZ+j0DwrIqQy43IIwK2wJKIL0Q
 kBYJM37h/VrnaibezOc3ZumEULkkU/tjDdTyIWtApHHKEY58qcEhLtiWA42NWQ9GfMwl
 Dl9ou66/zw4ntso9ZLa6Ray/757bXS95wVOEXbkfex1E8M4vX32XQdxmoUXdzeYrzZfu
 EKOwUcupF9PsNh6ehWeEo7pypAvkfMtSjSP/wBAuTNK/tkZ5hMV1OvdffLTqTsNmvNJz
 3gznYwE9QVVr0trgh5MRJFVLvBwj86YEOyTLYsNNm3cSKYD71+vSwkPnLoV1WI3TmwZ0
 B8AA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778851495; x=1779456295; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KZ6rv/GWWJ52Lx4UNdnB10JbVU/FnMyIQKyFO6AGG8=;
 b=Lo3SwVFxDoRwQOtkQVH91ucZ1bS4xvlFRebtV8rlbOZEO+xkLmQ4dnMU/Qhi0y7EWj
 51ffuMGKbF8mbfEJnDqL3I0SOcdFiW/R1W0wIeK+OG7lI66DNQA02CbHjSMDde1UszIc
 MqYbxq87va7izBYcdNXWZUhZLjtcftnTnIjPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778851495; x=1779456295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4KZ6rv/GWWJ52Lx4UNdnB10JbVU/FnMyIQKyFO6AGG8=;
 b=Cp8xn+QYSD/zbsS6eWgtRw8BQjbSBMZxrx4Xvv9Lbufjq9iakE2q4GjaSOFyix2FDA
 AWzuuEQAkXh1yDsvThhGtPvBn18+QfL/G2C9SbLLajswUxVOsMj7WahvSFY4IaE3rrZd
 W0kdXHjPsWQAotApAcY5tPGBXsuhV54bGx3jKyr3gk05UA7WZ5f/ahe/2wy5IODec5c8
 8EfqFzLwYI574zFK+rUa6Fkq2JHVyWrwVrsSPf79Qj6rwwBaRx7nxC6XcTCuPVndPZ/O
 XD6KvcMWvG0antSFDNry9Iwnr1y5fopzHvEPP86kJk5d2Q8X9Xm5rvv5MGbn/d/h0Zj4
 p6Tg==
X-Gm-Message-State: AOJu0YyC/cu8S14duQ34uqPfMohs/i/4b0WV3Bf8Y3VgP52pgQ7hbZXC
 oUJoEzc5I3XLLd3NrcghaJwB8EGdtW2thU8LMTejzZ/nwiXd8uNAaVwC8FZGs846PoiaUbNWRuv
 u+MJW3/QB+xlEl9DkjzgdzpMKLUFgeWmNaHm6vHZU
X-Gm-Gg: Acq92OHR7QEJLwUXpFPHcwcJGn2Rdl75ONWyuNwvUbk5IPo3Z87CyF6+ZJpZUD8fRSx
 GV73QPsE5WbWWKP2kje2fOYWzZPgC41dGNTtPetSizqfKeo0+xUPTKXuvnXWOOKwpfXgU6v2vPo
 6et8vha5fLxld/yO3jy7xBZoAJryzNWwSQLjAy2/mB8l70RL1KJUKcRRB7o0m2CDRpDxJMOguQS
 /UBU8KpGDVFczD9OpKx5F+SAgrY/vbghfipxRNqUdBQ6ggRIFfaNPWwudKGtQVffefy3/kNdxkL
 BVx4yQ==
X-Received: by 2002:a17:907:c291:b0:bd4:e590:4238 with SMTP id
 a640c23a62f3a-bd517812d92mr224927466b.17.1778851494978; Fri, 15 May 2026
 06:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-11-aidan@wolfssl.com>
In-Reply-To: <20260513002625.76915-11-aidan@wolfssl.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:24:42 -0600
X-Gm-Features: AVHnY4KIoJVARKmoWxuvBJgHJOLWvkDyElDKmiro96xoUS7PYn19YpuSwXs53aE
Message-ID: <CAFLszTj0EwKxC47eE3HrwDUWpjzaKcfn6shT0rgr+fDaN3rzJQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] tpm: add sandbox TPM SPI emulator
To: aidan@wolfssl.com
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Garske <david@wolfssl.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 2026-05-13T00:26:04, Aidan Garske <aidan@wolfssl.com> wrote:
> tpm: add sandbox TPM SPI emulator
>
> Add a TPM SPI emulator for sandbox testing that implements the TIS
> (TPM Interface Specification) SPI protocol, allowing wolfTPM's SPI
> HAL code to be tested without physical hardware.
>
> drivers/tpm/tpm_spi_sandbox.c (new):
>   Emulates a TPM connected via SPI by implementing the TIS register
>   set and SPI protocol:
>   - SPI protocol state machine: parses 4-byte TIS SPI headers
>     (R/W bit, transfer length, register address) and handles data
>     phase with immediate ready signaling (no wait states)
>   - TIS register emulation: TPM_ACCESS (locality request/grant),
>     TPM_STS (command ready, data expect, data available, burst
>     count), TPM_INTF_CAPS, TPM_DID_VID (Infineon SLB9670 IDs),
>     TPM_RID, and TPM_DATA_FIFO (command/response buffering)
>   - TIS state machine: IDLE -> READY -> RECEPTION -> EXECUTION ->
>     COMPLETION, with command-ready abort support
>   - Generates simple TPM_RC_SUCCESS responses (a full implementation
>     would integrate the sandbox TPM2 state machine)
> [...]
>
> drivers/mtd/spi/sandbox.c     |  30 +++-
>  drivers/tpm/tpm_spi_sandbox.c | 410 ++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 431 insertions(+), 9 deletions(-)

> diff --git a/drivers/tpm/tpm_spi_sandbox.c b/drivers/tpm/tpm_spi_sandbox.=
c
> @@ -0,0 +1,410 @@
> +                      * Generate a simple success response.
> +                      * A full implementation would call the
> +                      * sandbox TPM2 state machine here.
> +                      */
> +                     priv->rsp_buf[0] =3D 0x80;  /* TPM_ST_NO_SESSIONS *=
/
> +                     priv->rsp_buf[1] =3D 0x01;
> +                     priv->rsp_buf[2] =3D 0x00;  /* Response size: 10 */
> +                     priv->rsp_buf[3] =3D 0x00;
> +                     priv->rsp_buf[4] =3D 0x00;
> +                     priv->rsp_buf[5] =3D 0x0A;
> +                     priv->rsp_buf[6] =3D 0x00;  /* TPM_RC_SUCCESS */
> +                     priv->rsp_buf[7] =3D 0x00;
> +                     priv->rsp_buf[8] =3D 0x00;
> +                     priv->rsp_buf[9] =3D 0x00;
> +                     priv->rsp_len =3D 10;

Every command returns the same canned 10-byte TPM_RC_SUCCESS. Any test
exercising tpm2 get_capability, pcr_read, pcr_extend etc. would either
fail to parse the response or silently accept garbage as success.
As-is, this emulator just lets SPI bytes flow.

Please use lower-case hex.

The real sandbox TPM2 state machine already lives next door in
drivers/tpm/tpm2_tis_sandbox.c with sandbox_common.c. Please wire this
emulator into sandbox_tpm2_fill_buf() and the existing
nvdata/PCR/hierarchy logic so commands actually do what they say.
Otherwise the wolfTPM C unit tests in patch 12 can't meaningfully run
on sandbox.

> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> @@ -571,16 +571,28 @@ int sandbox_spi_get_emul(struct sandbox_state *stat=
e,
> +             struct udevice *emul;
> +             ofnode node =3D dev_ofnode(slave);
> +
> +             /* First check for sandbox,emul phandle property */
> +             ret =3D uclass_get_device_by_phandle(UCLASS_SPI_EMUL, slave=
,
> +                                                'sandbox,emul', &emul);
> +             if (!ret) {
> +                     debug("%s: busnum=3D%u, cs=3D%u: using phandle emul=
ator\n",
> +                           __func__, busnum, cs);
> +                     info->emul =3D emul;

This is a generic change to sandbox SPI emulation that affects every
existing sandbox SPI user. Please split it into its own patch ahead of
this one, with a commit message justifying the sandbox,emul phandle
convention on its own terms, and ideally a doc update. Bundled with
the TPM emulator, the reasoning gets lost.

> diff --git a/drivers/tpm/tpm_spi_sandbox.c b/drivers/tpm/tpm_spi_sandbox.=
c
> @@ -0,0 +1,410 @@
> +             /*
> +              * Handle FIFO writes - the FIFO is at 0x0024 but any addre=
ss
> +              * from 0x0024 up to 0x0F00 can be used for FIFO access whe=
n
> +              * doing multi-byte transfers (address auto-increments).
> +              */
> +             if (reg >=3D TPM_DATA_FIFO_REG && reg < TPM_DID_VID_REG) {

The comment doesn't match up - the TIS FIFO is a single register at
0x0024 and the address does not auto-increment; the host repeats the
same address while burst-count drains. Because the SPI layer does
priv->addr + priv->data_pos for every byte, you treat a 3000-byte
window as FIFO, which masks the issue but is wrong if anything reads
e.g. TPM_INT_ENABLE_REG (0x0008) - one of your #defines, is never
handled. Please hold priv->addr constant for FIFO accesses, and either
implement the other registers you've declared or drop the #defines.

> diff --git a/drivers/tpm/tpm_spi_sandbox.c b/drivers/tpm/tpm_spi_sandbox.=
c
> @@ -0,0 +1,410 @@
> +static const struct udevice_id sandbox_tpm_spi_slave_ids[] =3D {
> +     { .compatible =3D 'sandbox,tpm-spi' },
> +     { }
> +};
> +
> +U_BOOT_DRIVER(sandbox_tpm_spi) =3D {
> +     .name =3D 'sandbox_tpm_spi',
> +     .id =3D UCLASS_SPI_GENERIC,
> +     .of_match =3D sandbox_tpm_spi_slave_ids,
> +     .probe =3D sandbox_tpm_spi_slave_probe,
> +};

Why a UCLASS_SPI_GENERIC stub with a sandbox-specific compatible,
rather than reusing tcg,tpm_tis-spi so the existing tpm2_tis_spi.c
driver binds on top of the emulator? That would give actual U-Boot TPM
uclass coverage on sandbox (currently zero for the SPI path) and let
the standard ut dm tpm tests run against this emulator without wolfTPM
in the picture. As written, the slave driver exists only to make the
DT node bind, and the emulator only ever sees raw bytes from wolfTPM's
native HAL, so the U-Boot TPM stack still has no SPI sandbox coverage.

> diff --git a/drivers/tpm/tpm_spi_sandbox.c b/drivers/tpm/tpm_spi_sandbox.=
c
> @@ -0,0 +1,410 @@
> +/* Maximum buffer sizes */
> +#define TPM_CMD_BUF_SIZE     4096
> +#define TPM_RSP_BUF_SIZE     4096

These 4 KiB buffers live in priv_auto, which is fine, but the existing
sandbox TPM2 emulator caps responses at TPM2_MAX_BUF_SIZE in tpm-v2.h
=E2=80=94 please reuse that rather than inventing new sizes, especially sin=
ce
the goal is to integrate with that state machine.

Regards,
Simon
