Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B18C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 20:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931EC84C2B;
	Thu,  9 Jul 2026 22:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nP0a9CwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89AC284C31; Thu,  9 Jul 2026 22:19:49 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FF584BF6
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 22:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso386206a12.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 13:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783628387; cv=none;
 d=google.com; s=arc-20260327;
 b=cpksgHEFQJL6Mp2Bnjp+G1JYf+tCcfIPduyXsXiWs501zUOlyhvE4m98BANTCMD2Ox
 FsLwYIx8LCLMa/PDRm2GTylvCeTSEwEdOxBbzO1dcoJ4mDd6YxglVvSJZ35Olkfmxfs/
 lEkrUmoWQ4tMGWDM82tJ0JsSoNFtMYTYUdV5WTe3FdcyHX4V0BOotpg83KeTHzqtXlmf
 JN8UBvmyITjG58/x11Qm4NamaY9WawmH9qvjEccSg6vrskcP9eZU1fYH+bmdYiFs+CgO
 QK7IWpDTM409WOXXtKI1MEVb4R9BQ1BdslQ4cOq2RGHcYfY3Lrek5lB4ZMsE+3cTUGsL
 aS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JhxHNUo1vuL6SdIF+9eUnvbYG8DWy+JzeG/8sFE+7rA=;
 fh=Pxq0yxYGRjphnM+U5aBE5iEiDvtwTenPIVGTvPAHeLA=;
 b=NhlfksrAEyFRFGWkIGYsdEec1xLS6lCbluFSID2e841NeY+tKC1pqeghmm25vgIbDD
 nTtvWexgJSp/LlaiczkC97/SF67rVVtFokOlniGsVo/3q5MclrZe4KXtE+hvWOzRPNAy
 H8XvJTAIxiC5h+rp1mXleTEbaHLG5ad368he/O/tTAntDeU6FJLVtXVYd4cpShgXRx1O
 rUB2f13Pnm2Cv4d3EdnOavVm9VpNzLROpbIAr3tOGZI784+UiHjaK70QmA8JKJvNhxlf
 KNn1h3rmgXncPaelYFeW3xm2qb6aUJVKZcQvOYkTdtzK8EOII+AZmA7ob4ZQ0CWsomA/
 3mDw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783628387; x=1784233187; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JhxHNUo1vuL6SdIF+9eUnvbYG8DWy+JzeG/8sFE+7rA=;
 b=nP0a9CwLslQ1RVOwHb9EXBxU731s6V03ys6o3V9oEl7q5h4fEy7zhyAEUb8FfDXfUy
 8QiO+aCwERER6r64I8Vf0uAZcdOWNVoN8yHeZrUrqFLEiXbEC8Y8n13D4RIa8iO8dsNl
 pNTYRU3jmZR/L0V59S0aj7pvpkpf9t7rn9BVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783628387; x=1784233187;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JhxHNUo1vuL6SdIF+9eUnvbYG8DWy+JzeG/8sFE+7rA=;
 b=dlzwMdi9J9zDMiTSjf9XdnaXgVqs6ElpNjZ7Pfx2+PLsufRTv3Rd4KsG75+pG+jtTE
 QHjO6UbOAIFfs4v1kmxvMj9+hye6wqIodw2SxbLNSQ1NrBkekuUd1EODCKAGOOTyLkEb
 g6C/7zdJhvxnm3QKkjRGVk1jX3cz51nCiDI+6vnbZPIPA5AWGPoMYlUfj4Emnm6p+IDU
 JeP9SKM3Pgn9sYwAWAqJct2tqcR5uYR6nfIiTQJ/GJbE6Fp2PRTC+W7fOdmWCUxnbD88
 VlZ5pZRm0TnGaz/cafzrwKy2aFszQv4bKOU5NfXRYis868u0oZWXTPFvZK5k5EW0A0mn
 FMZg==
X-Gm-Message-State: AOJu0YwcY/iWC9ADFHRJVyhtga1Dvb/1zkdtwnWK07u3Ad1zOOq3wXDY
 vA229LohTVXJmLQhWoyJ6bTk+Ti6D4tFQuTUP+BdeNKrdk2zNVxMg3Nk1moJpUWhsfd1M7SWtSw
 ceF9yWozb2c7SWGJedHupIPlfDyq1Qafe7wZu4XvA
X-Gm-Gg: AfdE7clruEsCDCVKmD42/Yqc/fJwxJvQTU4HZ1iV3tjOat7LrQUNRvhi2wtbqzDIzxr
 BfNwa93HG3zOGbyy42hBhXEtYbphkDYRcoCcoyvaQ7zYE1pdUjd1ydPR2VzPVTx6lDgy/+VmmUI
 wpWN4p8Mzi9PVp+Dr8QIJ9SIxLxNE3wxXz4G94+KllunyC2IprGu2i4jX3f5MMeL8utE7msb4qY
 IOPAn7UwKh4zjnIpY69l27+bmvpr/m9ceogqD3S4OWwrit+pTZf0j4lWyKEZ8kloPvOxb8=
X-Received: by 2002:a05:6402:1ed6:b0:699:fbe4:16d5 with SMTP id
 4fb4d7f45d1cf-69ab44531aemr3594457a12.1.1783628386765; Thu, 09 Jul 2026
 13:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
 <20260706-ccaione-upstream-ebbr-v1-4-e742cdd6abe5@baylibre.com>
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-4-e742cdd6abe5@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 14:19:34 -0600
X-Gm-Features: AUfX_mzOjcffHJUljaFozCDapf9XCtoOMbeoBMj5cNCsvqAtZN46wTb9qfytYIQ
Message-ID: <CAFLszTiYvbAHSGqZGRPSHfXq53JA4CmS=ra_uYmDXeVzzYhjEg@mail.gmail.com>
Subject: Re: [PATCH 4/4] test: bootstd: add firmware-FDT source tests
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
> test: bootstd: add firmware-FDT source tests
>
> Add sandbox coverage for firmware_fdt_load(): a python fixture builds
> mmc11.img, a GPT disk with A/B 'firmware' partitions whose first
> partition carries a FAT filesystem holding the FIT manifest (fdt.itb:
> a base DTB plus one overlay, with a default configuration that applies
> the overlay and a base-only 'conf-base' configuration).
>
> The tests cover the happy path (default configuration, packed size,
> both fixture properties visible), configuration selection via
> 'fw_fdt_config', and the fail-closed semantics: a missing pinned
> partition and a selector naming a configuration the manifest does not
> ship are fatal errors rather than -ENOENT, an unresolvable
> 'firmware-fdt-source' phandle is -EINVAL, and only a genuinely absent
> source returns -ENOENT.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> arch/sandbox/dts/test.dts |  24 ++++
>  configs/sandbox_defconfig |   1 +
>  test/boot/Makefile        |   1 +
>  test/boot/firmware_fdt.c  | 292 ++++++++++++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py  | 110 +++++++++++++++++
>  5 files changed, 428 insertions(+)

> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> @@ -614,6 +614,115 @@ def setup_rauc_image(ubman):
> +    mmc_dev = 11
> +    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')

Every other setup_*_image() puts its image under persistent_data_dir
(or lets DiskHelper do it). Please put mmc11.img in the same place.

I have a pending series to move some of this around...I'll see if I
can send a new version.

> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> @@ -122,6 +123,14 @@
> +             /*
> +              * Not read by U-Boot: the firmware_fdt tests copy this into a
> +              * live 'firmware-fdt-source' property at runtime (and delete
> +              * it afterwards), so the source stays unconfigured for every
> +              * other test. It also keeps a phandle emitted for &fw_fdt.
> +              */
> +             test-fw-fdt-source = <&fw_fdt>;

I don't like this very much. Poking an inert marker into the shared
bootstd node just to keep a phandle alive, then having every test
mutate the live tree to graft the real property in and out, is
fragile - a failed ut_assert() in the middle of a test leaves the
tree half-configured for whatever runs next.

How about creating the whole thing (including adding a phandle) in the test?

> diff --git a/test/boot/firmware_fdt.c b/test/boot/firmware_fdt.c
> @@ -0,0 +1,292 @@
> +BOOTSTD_TEST(firmware_fdt_test_part_mismatch, UTF_DM | UTF_SCAN_FDT);

No coverage for the CONFIG_FIT_BEST_MATCH path advertised in the
cover letter (compatible-based configuration selection against the
control DT). Please add a test - a manifest with two configurations
carrying different compatible strings, where the base compatible
from the control DT picks one of them.

Regards,
Simon
