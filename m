Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6541CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EAC184706;
	Fri, 15 May 2026 16:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G+48o0ri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934CA84705; Fri, 15 May 2026 16:11:21 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C6F846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67cd93d8affso11054606a12.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854279; cv=none;
 d=google.com; s=arc-20240605;
 b=Sl8ZzOcK87wsRzVhC0V9RosTouVuSkyND9FVicAfwMPS2wLHcHzYKjU+TmqsG2FG8v
 SdYnXul7URS3k3p4kiP1AOnm79PA5Puc0crb+omCGaVDA/qZcbeF/cqEtlZx4xOzUYYG
 u3VXFlPCHrW0+Buq2Seb/s/BV7lEW0MmX7+C1Z1kPUeByb3Ky1tHy2/vem64LPS6jcmd
 kRK/WwAyFLL7B5aFTGB6zqS6jfTnLYpw6e96jAbnU7KOP8xqfFFuetIR4ZTWhN47V4qN
 wprbKW7Nu8/VJ1SlBglyvVFOxayNixq5XBWXNBXrc4wqnexEcjORrG2EhrCnUHMfWh0w
 Vphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=irnocxKVVsRRi4D4MlP2jrjaA/ZmxHuualpAn9jnij8=;
 fh=pG65kes1vWDQ1AvYIebNuLUz/8pQiTkb3lwpDruQbts=;
 b=ge9VwZefs43z1G0UblToDrdXYW4ljGwqFebz5VJexcLcDrA87Q1ZOHw3WaHVu9XAwq
 AwzvXqDePhtRh/gSA72W4LEJ/YGHk78PMwoKfp1SlrNbBM4qVt+ew7r34NccGlYviS92
 OoVv6QMAtG07rzwkdVcpy3BNNyov8T7URC9by7yBGqABz6MVj6ZMF0hHjPEQyqq/dDT9
 PDacGYXs9j3i6PKcUVXHGRgWBG4uLgkL5xHW7O9L8JDS9Q/SToD7JP1PvO0R6OQQRjcs
 jtSFLY/VTJBM16jdPGfHvv+U2ukobLGj61HPJmMCwfxdvX2Vllmcz3fEoNxmKL5umDTI
 x/dA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778854279; x=1779459079; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=irnocxKVVsRRi4D4MlP2jrjaA/ZmxHuualpAn9jnij8=;
 b=G+48o0rijZ3p6WliRWbNhcFk/Or79zZ3y4vvI/5g+y84TMUKqjW/jowYJlxk0LaPjL
 T+CiYWuuI/bScQvhBqsisniZ4W68s4U/LBwfDoUmIW84c1dRJIKxOnZtsV6Bms+vcXAe
 Yhd/210Sl87ZTeC5pgNcWmzcMIDuWbVZyQC6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854279; x=1779459079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irnocxKVVsRRi4D4MlP2jrjaA/ZmxHuualpAn9jnij8=;
 b=HEn/4xPiZvtJHxjf/7TkZESkivVliPuRusC9H5VUKbqYSXhecPeLllQTgCLS92F/Ug
 XqHzV9bYXkina0kKYzAIYQxHh3aODOd3rBcrtWwlpEIcIYNzRR7GAoFXi7lZVON9hp2t
 w7iGl+e1HOItcBIR8siUt/EgsKzWSTYSMoKA+yYJx6ia9KfsitCEGLYrrkkeVP3t5J07
 2pZS0KX+D3Qdm/FRtfsU3oFllUUnRKjDXw+gcXFUGKS6IDBnL6TsnH1RmKLbjKISTnqN
 288YfCCTXBXNbeMQaxud+7j8e3GB72lgs5Ieql0mC8RaXd/1ahEcdOfic1sN//FwYZN2
 539Q==
X-Gm-Message-State: AOJu0YxMS+UiyYVpfHofORm2cZyq7BlaVGNFAMmh3rpE/vuxSqIjGSDB
 jmWidgor2owkMIO7xf+E+rHC51trK4OjkU3svPFBivt+o4RuA2Nl4X8XElpUHXXQrvQsvnFsELx
 v3Jx8AR4dJvaNYEpQ8DOdvpFuMUdC+3AsnSeuD07kyery5lNmGww=
X-Gm-Gg: Acq92OHpt/f1GhTcDiFM3fPEY+YaOb4SFnWFQ18sUGYZ5xg22V9JvTKPNxUKAGuyPFN
 ixz7T0khUFK1WHA2oIgG0NTDueluLGTjJjB7o+S0t+HS/pwBHBd/LExoey7gfDK12KjzyT5+/qe
 64N13SNq+9829BkkeCIiUoFWKETrVswXLbuujtgHiLPIp3ZyfxqAi3l8xPWFiit3/9POOnqZfov
 Qwb123/1vwl/7lyfzKOxRvPa3UPUO/oAjWpAy9FPikJZ5245/FXXRD4/1DZQvzaN16eqs70X48+
 PwiKVw==
X-Received: by 2002:a17:907:72d6:b0:bc7:73f8:9f4c with SMTP id
 a640c23a62f3a-bd5177d53admr222518466b.8.1778854278913; Fri, 15 May 2026
 07:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
 <20260513160816.v4.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
In-Reply-To: <20260513160816.v4.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 08:11:06 -0600
X-Gm-Features: AVHnY4LovR4-hmRBlhmi4A_bQS9kzVcrVYp9wb1KO-1BbLQ3k6-Dy-nDa0cJE_I
Message-ID: <CAFLszTip4YxKemViVkr+kK4sqBgY45XyfXa1k05aYrQ+7LRe-g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] qemu-arm: merge built-in DT
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

On 2026-05-13T14:08:10, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
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

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> @@ -144,10 +144,53 @@ int dram_init_banksize(void)
> +     ret = fdt_increase_size(qemu_fdt, 1024 + fdt_totalsize(*fdtp));
> +     if (ret) {
> +             log_err("Failed to resize FDT overlay: %s", fdt_strerror(ret));
> +             goto out;
> +     }

Missing trailing newline

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

If fdt_overlay_apply_node() fails partway through it may have already
inserted nodes/properties, leaving a half-merged tree, yet we return
0. Please return an error here (and for the fdt_increase_size()
failure too) so the boot fails when FIT_SIGNATURE_REQUIRED is set
rather than silently continuing with a mangled FDT.

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> @@ -144,10 +144,53 @@ int dram_init_banksize(void)
> +     if (fdt_check_header(qemu_fdt) != 0) {
> +             log_err("Invalid QEMU FDT at %p\n", qemu_fdt);
> +             return -EINVAL;
> +     }

This is a useful change, but worth calling out in the commit message,

The subject says qemu-arm but only qemu_arm64_defconfig is touched -
do you want to do both? Or narrow the subject to qemu_arm64

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
