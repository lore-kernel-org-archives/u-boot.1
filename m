Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCA8C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 20:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5528784C12;
	Thu,  9 Jul 2026 22:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OhUnB0AA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5CE84C25; Thu,  9 Jul 2026 22:19:32 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5CA84BF6
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 22:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so544350a12.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 13:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783628370; cv=none;
 d=google.com; s=arc-20260327;
 b=kZPeqzT22MrdDamBY1ACAIjxqoqndHjzoLOv0/b+Tp7NcMes/2BqhpUYRO7APkeg1/
 EJiHnjYWxnczmAasLelL+jrQ9C3ST3eMVs9r7ghWdR8ozAdk/USKAjtVTwdVt54TJIFh
 QZFxJI+jvaCVvuO9NN+X79LzNVn3Yrl7iDeGD0giCVQT+oCHr3krXYkyeUtNgzn3N/UN
 oHVAfnsh3Wgqo3AYpKKcCTJ5uW3FE491VjtGGfr9XTgkzUEHjdyQJqWqH09I+99rdeWT
 qVFivkiJ51lWDqYv/NIrNA8I7hrjDBtLdePDatmH5d4ifua5Hznp1PP7Gaj54jxfi1Qr
 u6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4pxP6sFlOnjR5a0c4itzKkMGjvHOeQqA9hRAm3OJGic=;
 fh=Pxq0yxYGRjphnM+U5aBE5iEiDvtwTenPIVGTvPAHeLA=;
 b=drVbjB79MpyZhp23UYvJDmsDXyLedChe3I4QxB/RG6v9qe2uQXH5/BWQhKQO/afW5T
 hixJSikREj4LR6dZqdIrY44OAmHXEYtJ1ZroM+MsCHuLJNWvRWZr+K4c69mEwgB+PNfy
 ykO1XxiS1+k4kqWVOb/FOOTwYO86xlRZ0T5Yz8ZOPGbxA41wVyACHsqI3aQYsQyeYzs5
 mAZyJlop9x4dP5rpTjR9fDTDgV0CRqJ66oqt7KqPPbmlIKyjmGD8cqeT2CAhmGLkiws/
 MC/Vdq0xacENEuWN200ZTEnT8YMBvV78zaNqpgGyNtLMIlQE3IUNlPTZisJRCQ68g7Yb
 kXPw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783628370; x=1784233170; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4pxP6sFlOnjR5a0c4itzKkMGjvHOeQqA9hRAm3OJGic=;
 b=OhUnB0AAKs3P7zmyHR1FVDC4ZgBE0fOVVxhszLklPPU9oZ6VmdvrzBw/WfnzYSz6MB
 XzwlqzvkVdIzAJC5HqAzKrPnuetcwsmuD+aT03uXEXpb8B3K1t507SROxvC2wJaUzUvK
 /9ZF3GHm6u7f/GXBCPAVwA3kyDWjSa91dc6Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783628370; x=1784233170;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4pxP6sFlOnjR5a0c4itzKkMGjvHOeQqA9hRAm3OJGic=;
 b=Qo7kQcStsDLTUSnCF/VeB6+y4matoiwyRlMzFmufQ2rjjIruaFFqb51FeabTPqEVBK
 3KI4R7e5gJKqCUFnXvHcQ8jxpiHuJ37Jmn43f2+dDTIhwOOU0J6joY2quYiU3kJtd2KZ
 8CsYj8uHfDZlvkKtTxFFvbbGGDemvAHKAGGs5eKvmr2x9smMNALis0gDeCXXCfqp5CKl
 9Z8TQxc2EL3ycPvN3q6yfHjMbqACO5FiepTv7drpW8BiKum1Xhe0kYs67mp5JoTLSKoM
 YnoeaEG8NgDfbvMNlq9AAcNG/lsUpQZA/CFjsOWXiSWCY5ZKA9HF4bb9/iTa1HeM2lmq
 BPGg==
X-Gm-Message-State: AOJu0YxTGeLmZ5UxJzCNr84RIZlO5zAvWtDNC6JHkC2AVajpxfnU+ajI
 vl6cYu3nTlcFTSXVhWVl1mN7+1CAsBEuLnqyTRyGvY3NhIlgRGhHDqTkxLaDaWzjsrps6GUDo5b
 tNhIJOXy6w8orZqWOiGpepa/Vt5QjHFYKyOrYGflj
X-Gm-Gg: AfdE7cl/lCVlVgXmyGFKQ82fA9RsF4SYgcYtezYMhbWbH93fZ72bna0o7ob/cTwa107
 JFB8igoJIPVyFqGZZCuacbzCipy1gmakoTdp14u7jxFrjAp4T6oFO1QpDKKm/Nu/5wIKmbybboP
 265PhHHwm2wpcq5KwgB64YGiV2PXG4TGPWzaiMuq6gEOfRsgYCmEHe3dMmeGqFT92+FhbJzt6u+
 40AWYhuYxyabPESonWd0ineoNL4TyuBOu9D+UmhD7T2C2LYRRdE8d+PEBGTZWmEP/CBFi4=
X-Received: by 2002:a05:6402:95a:b0:69c:13:1e4d with SMTP id
 4fb4d7f45d1cf-69c24e7f758mr279610a12.12.1783628369968; Thu, 09 Jul 2026
 13:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
 <20260706-ccaione-upstream-ebbr-v1-3-e742cdd6abe5@baylibre.com>
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-3-e742cdd6abe5@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 14:19:17 -0600
X-Gm-Features: AUfX_mww022LDFgPNJXn8mTn3wWRVs-RWg17fTEvdAvquoVIaqbh_3XOuH3DUiA
Message-ID: <CAFLszTikc9iAwV8yZVF9B=n5ktYdPkqqNgbJpujYgs9oL8b8pQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi_loader: bootmgr: install the firmware-owned
 devicetree
To: ccaione@baylibre.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <floss@jetm.me>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Michal Simek <michal.simek@amd.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>
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

Hi Carlo,

On 2026-07-06T15:06:41, Carlo Caione <ccaione@baylibre.com> wrote:
> efi_loader: bootmgr: install the firmware-owned devicetree
>
> SystemReady IR boots through the UEFI boot manager, which does not go
> through the per-device EFI bootmeth, so hooking the bootmeth alone
> would leave the boot-manager path (including autoboot) on the control
> devicetree.
>
> Consume the firmware-FDT source in efi_bootmgr_run() too, so the
> firmware-owned devicetree is installed via efi_install_fdt() regardless
> of which EFI launch path is taken.
>
> The firmware-owned devicetree is tried before the Boot#### load-option
> FDT, so a stale or broken load option can neither override nor block a
> configured (and possibly signed) firmware devicetree. As a side effect,
> a devicetree passed directly to efi_bootmgr_run() now also outranks the
> load-option FDT, which previously overrode it: an explicitly supplied
> devicetree is the operator's immediate intent, and stored boot options
> must not replace it.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> lib/efi_loader/efi_bootmgr.c | 50 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 7 deletions(-)

> As a side effect,
> a devicetree passed directly to efi_bootmgr_run() now also outranks the
> load-option FDT, which previously overrode it: an explicitly supplied
> devicetree is the operator's immediate intent, and stored boot options
> must not replace it.

This behaviour change is independent of the firmware-FDT work -
please split it into its own patch so the two can be reviewed (and,
if needed, reverted) separately. That patch can go first, then this
one becomes purely additive.

> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> @@ -1305,7 +1308,8 @@ efi_status_t efi_bootmgr_run(void *fdt)
>               if (!fdt) {
> +                     ret = load_fdt_from_load_option(&fdt_lo);
> +                     if (ret != EFI_SUCCESS)
> +                             return ret;
> +                     if (fdt_lo)
> +                             fdt = fdt_lo;
> +             }

Now that you have an out: label with cleanup for fw, this early
return ret; is inconsistent - it skips firmware_fdt_free(&fw) and
the load_options / handle cleanup below. In practice fw is zeroed on
this path so nothing leaks today, but please route through goto out;
so the function has a single exit for error paths.

> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> @@ -1320,11 +1324,40 @@ efi_status_t efi_bootmgr_run(void *fdt)
> +                     } else if (err != -ENOENT) {
> +                             log_err("Failed to assemble the firmware devicetree (err %d)\n",
> +                                     err);
> +                             ret = EFI_LOAD_ERROR;
> +                             goto out;
> +                     }

EFI_LOAD_ERROR is really about failing to load an image; for a
devicetree that couldn't be assembled, EFI_DEVICE_ERROR (or
EFI_NOT_FOUND, when appropriate) reads more accurately.

You are adding quite a bit of code here, so please split it into a
separate function if you can.

> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> @@ -1296,7 +1297,9 @@ out:
>   *
>   * Invoke EFI boot manager and execute a binary depending on
>   * boot options. If @fdt is not NULL, it will be passed to
> - * the executed binary.
> + * the executed binary. Otherwise a configured firmware-owned
> + * devicetree source takes precedence over both a Boot#### load
> + * option FDT and the distro one.
>   *
>   * Return:   status code
>   */

Please spell out the full precedence order here (passed @fdt >
firmware-owned > Boot#### load option > distro/ESP) - that is now
the interesting contract of the function and 'Otherwise' hides half
of it.

Regards,
Simon
