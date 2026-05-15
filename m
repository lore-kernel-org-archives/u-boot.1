Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227CACD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F0D846A7;
	Fri, 15 May 2026 15:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jh5gG9An";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B73846AC; Fri, 15 May 2026 15:11:50 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D9F846A4
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b936331786dso1166045566b.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778850708; cv=none;
 d=google.com; s=arc-20240605;
 b=UeiG3wqsTmQj2twEyfvKTocXRFZW55/ZjG7/SlCGrP5+GAj0RGbHicpV6E+Rd/13yE
 jTccbs55LrKXabkfyMymDVrgB/ehIuvNnuDaJX9qmsjR82+aXKCXT4elipjb/bWv3LRQ
 Og00ZpjWdbMGQbHspSKi0qUQ823k0gBXT5YmSzYT9YlXdH5Mt8VDp1BEwG08wyv91B4i
 RRWizWXn5vDrPECcsPWjKMgR0rfgheAU/jKtR4+keh1spzdYE9lm1Yq7BeFgpcPEFzwO
 ZYpGS4Du78AhPkz8+dOq0AF4bvLesdHixh78Qj57il2UqA5AYj9Mf5b5lwD7m9rttabV
 QCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fwHSC6ndZ+el3QzmNy5qDLmH6FgKEyH51LTVrqbWueE=;
 fh=BHJwo1NCU5Q1RuouQFc6mIvO5V5nJA16WaR8JNdAU2s=;
 b=XVXqzN1e+mw+9iDhqyw1Vd+aE46GMd74zw+xDiW9mcGKJ0FLZkrxD2fdL3x8n18rV6
 MCZptO1y+D4pHnTuY1pWY96wdi4mo4+dvxvcLeDcpxg7RAh1GZXerUF3UBV9WwUci5uX
 cdc7pVjTpupVdgU8LOz5730duSqa6wRWycq+ZsyQc6fGxQX9IAH7WpxvoKkx9vOZ0Gp7
 v+FVEA7Pny3UTo0pTU1kL6HSVLafs24oUwtxcsq9pBjDH2l+KfDfpx/SyxY2gYtlDuOD
 6RiwBfBuCpuZ/6nrs6Q+JD8m1OeYO5Yv/QZRXAMH4egpJ0GmK9ekTFLq/w0aK/3MdnIs
 eBVQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778850708; x=1779455508; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fwHSC6ndZ+el3QzmNy5qDLmH6FgKEyH51LTVrqbWueE=;
 b=jh5gG9AngRFsYe9e6emnGnEc/1iA6bQHkbHdU0mkcfnqprZZ6mC6ZNvxlwKfrBY15J
 +2KKTbX4AZVu13gislxwp6C6dzdn/1Rd9sGFhHOeCP7PlPQZGO27Pmey+Ke2b07VdBVW
 L+fdArd3oNp/pxDK9JcDTqs3XTywhlQNATgS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850708; x=1779455508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwHSC6ndZ+el3QzmNy5qDLmH6FgKEyH51LTVrqbWueE=;
 b=jByY6aBa3mALRjQlblBh6UhoHY/TqDRQoYcQM4bmLp+4gF2QQ15NnYLsx/7SmM2U0L
 U4/5HOl+6u3sDLeyAI+BNi5umJTRD82xh2LfEpO37hVQS+T/A/R3/9wgWqE6Ly/Uokv+
 XSnQBfA+WxTaiZ1uNTTDhte8h+t+2Afb6Ctf3a9Nh1jiLkrXViAzCOYG5cY2Fxq0rT6D
 7Q0XGpR0pfX6derBsvP7T8bHRoGagrq3aJYNQFIu45S2WRZI1XoXH+x7pewOG/+tiiYz
 H7F0gapwLoASH3bBZwaQD+2ephxxbtSwPGiA4BVT32oetDNgKwQ35d6bCgZLDi4irJ9G
 WTVw==
X-Gm-Message-State: AOJu0YzgWLDKEknwgmqjz1CcOyuc1j6KN5wxXsFQkcUMbSLiBUDeJb6w
 W0QPfBL5bNf4Xqt4+JzqqDzp9R4g40v+nBdx9A+ctFF7wvkbhY5Ko26IVHPPWKt03CiLzlahlXK
 G7ErnXkKrKagXZ783M9dIYUCscGIUVwXUdACsgvhM
X-Gm-Gg: Acq92OFKU+7/DMoByeKnlsU8T5XSLOeg+0s7P6a9WWjTvUX9u1Zh4YzEfOwR4CjxTzE
 5IVFjouq9RXgBbNK58POAx1VyeYkUiXkTGgJifEOkxXBpo1j0opaFnozwdaOTDFGKFr+GuRhtzj
 x7vKY+4IfxnPGUfq1odA08rkLhz34H2T2NElBlQbiyy58C7Gg4KdWLSgQLqkzhEyFQgxFYkxCp/
 WcvRevvntqa7GwEhwYLoJ4765JpG1UhS97kv+RVsJ5iNjjN4LDdTAWw9uxQN6M8TRRMYr09OiLT
 d3q7wkJwEkJSSrx6
X-Received: by 2002:a17:907:26c2:b0:bd4:72c8:140b with SMTP id
 a640c23a62f3a-bd5177afec6mr205183166b.10.1778850707764; Fri, 15 May 2026
 06:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-6-aidan@wolfssl.com>
In-Reply-To: <20260513002625.76915-6-aidan@wolfssl.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:11:35 -0600
X-Gm-Features: AVHnY4KijeDTi9_MVPDsIdrxX0nBSFyztiLSuR-0goy7RfYOnMJzga2wpt_XvXU
Message-ID: <CAFLszTjOuzKUug1te52YRdKLHdrmFVxTkPG4gg8bPmTYEADCeQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] sandbox: dts: add TPM SPI emulator node
To: aidan@wolfssl.com
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Garske <david@wolfssl.com>, Simon Glass <sjg@chromium.org>,
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On 2026-05-13T00:26:04, Aidan Garske <aidan@wolfssl.com> wrote:
> sandbox: dts: add TPM SPI emulator node
>
> Add a 'sandbox,tpm-spi' slave on the existing sandbox SPI bus and
> a matching 'sandbox,tpm-spi-emul' emulator node, so the sandbox
> unit-test target can exercise SPI-attached TPM code paths without
> real hardware.
>
> The slave device sits on CS 1 (CS 0 is the SPI-NOR flash emulator
> that other sandbox tests use), and the slave's sandbox,emul
> phandle points at the emulator node added at the root of the
> sandbox device tree.
>
> Signed-off-by: Aidan Garske <aidan@wolfssl.com>
>
> arch/sandbox/dts/sandbox.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
> @@ -286,6 +286,17 @@
> +             tpm_spi: tpm@1 {
> +                     reg = <1>;
> +                     compatible = 'sandbox,tpm-spi';
> +                     spi-max-frequency = <10000000>;
> +                     sandbox,emul = <&tpm_spi_emul>;
> +             };

Just to check - is there a reason this is in sandbox.dtsi rather than
test.dts? Only the C unit tests in patch 12 exercise this emulator,
and test-only nodes normally live in test.dts. The existing sandbox
TPM nodes in sandbox.dtsi are arguably an exception rather than the
rule. It's fine to have the node in both, though.

Regards,
Simon
