Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA9BFF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 23:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E23848DC;
	Thu, 30 Apr 2026 01:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bpfvtji7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E20E848EA; Thu, 30 Apr 2026 01:51:42 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F87A848D7
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-676d8582a13so645344a12.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777506700; cv=none;
 d=google.com; s=arc-20240605;
 b=QmATIa/Dj+N3RqVHZv7b3x4uNHrmAnCMeuYLuZPzoxhUVEzRubEeqMRyCA/Pd72NwN
 je8INwrCn5fN18l0mKSA3CWxixYba+rM7UN3iAQl+6liRzBvFQv8+R17lTvRw0v6pgiM
 Y6PyoKVo8JW4W+I4S1T4+6lKUUQpkMdJvkwKV3LOZNpznX+Z3v4UNXGuVtiT8pDy7ziE
 RWixIw5mYV4nJSeSZAZXdHJyJ91eLUH1dDJdK0YwmhQ0ng6RNDgWfd2KfgefEHT88TZJ
 FyqKQzIjih7yZAZkfJ3zHH3v9DgNPCdgUb/E9y7j1aADzJ1CrPu0rrICHYwT/XExTCoB
 Y6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bcpSMMBfoXcWtSQaAuviIpilp51lWVifQcdq7WXhONA=;
 fh=qkBxHS+BEhONbDGUcKJiGV4SxHaK5mIDY4uf78y3Cx4=;
 b=SjSEjmg5FA3cQZnCWdwVFCmrnyTCdnzpqSINkaxQwOzxcQSocishzBMFW7SfkVoOge
 fR00FVFq7E+HEE37VrDw86NV1HcADaaU4reWVKOV4fWkryM8HHT0vc6ZWYKMgVXDbPFm
 YSersVtCUgOvZzHOd+FfAzmrt+qyqdHBvZBHLd2S6fN0KORbK1av1VCG6diSeLPfR+6p
 WHDJJ82Rli9nLX5eK8fD0Ha5fdf8C7klN9MJvSnoHjMoc1ZrsdYyTtUADiu6anjf8CBC
 DNHfZcuDEMddmj8WyZjWwJLWzbFd0+fG0HUT/y4qxt4COJRNGYXrs4WwDoo5lyIFPot5
 axTw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777506700; x=1778111500; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bcpSMMBfoXcWtSQaAuviIpilp51lWVifQcdq7WXhONA=;
 b=Bpfvtji7eDRZT9jbNhmbAllvMql+oxnfiB6wYPxIiQAkVpTNCb9WXpMLPUBfg8aSev
 +G1KpM+UzLTf4IUZ4jrs7Jhmb9YPTbAm8QJjyrIy9eSq3SQir9uEY1leWgpyym83Wslr
 /SH9+PCVnPDdYKj89YLjIbqnld/8e9OKjOt+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777506700; x=1778111500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcpSMMBfoXcWtSQaAuviIpilp51lWVifQcdq7WXhONA=;
 b=X/Nk42Co6G6rnAuuodExkXewdhenkVPjt11ipfab60BDxhkNz11jcSVDYHXHM/BAGu
 HUlrUZdFfQqVNhVkdao18pubOkifTRdIdX6jgC05aeJgAGeh4ugU1bclYy6gnU6CuA/E
 uEbnTmHpgSJj4z27o3oesor5PHr+4/M6xTc4udpDDbUBWOAfvBfe85m2g4reZcOqgoK/
 aYsONgwC9YP57uS+3PEimm5a0HrAEzra/QghRHViDJlt04pCXRtvwGDKUbBG7ZltoxFU
 OCCu+CLKlDk5xdMrBe1Qh3mXrAsL2tFxk6gukBQktonBbMNCcX60F2Fx2uKYJ1TXNrN0
 Yilw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8g1ZPCBnLu9ZFL4jfcOjC/RqYey0G3t5RUw9vc+Fb/4DnUkOx/1wRzjzi6DZxhP14dw6X3c48=@lists.denx.de
X-Gm-Message-State: AOJu0Yxuflq1VFeIyBevxi7gFwVatTp8loYWynsPVEk5p8/42eu6w+P+
 MI4UammRID8y8s0nPw7yw7/JycKbn6jUMDM32uq06wQkKjdNJuNGhht9GiJWm6MSsuFDaBRVUUs
 Dp4cpq7xfOmtFDmZnAkxVvub+Yu26aWZIrMPWNrF/
X-Gm-Gg: AeBDieutsBpgAIgJYG9antpEmdqDNGwdADzdNFMOvsvu8cVcrqkUvoTTbCYqlvk1BP0
 U8Cu48a43Sb4zNdI2VWfqk/Y9aOVRZavL1U6v00cBa3Wr4jGK8z8GeHA86bcBxMc+Hxr7A82VIH
 Jy/Or4TTOG4kQPpSaR+dsx6907Bdma91AGWwXA3gdspnIKBNHjkAFwn8JOyE7s3UXrx+Rg2NRKc
 yTHSWiR6dfXGyP3seSves875Nk6N+d0McR5hWSqVnlyZ4v6cv5EbLXzu8HnXmRIzyfV4kqIVCd1
 BiNjlY5bEcAIg99/
X-Received: by 2002:a17:907:c1a:b0:bad:ad5:300a with SMTP id
 a640c23a62f3a-bbac67c27acmr49162766b.26.1777506699857; Wed, 29 Apr 2026
 16:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-6-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-6-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 17:51:28 -0600
X-Gm-Features: AVHnY4Ki6olieWzwtDfqfpVLLvmhgMR1b3o2b2JQjK8XfWxhpQny5jAESQ8k1AE
Message-ID: <CAFLszTiJBdkSEgk3UipouAOTz61yhZF8cUYRUSEcLq=E2Z40LA@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] arm: dts: k3-binman: Add template for packing
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
> arm: dts: k3-binman: Add template for packing HSM firmware
>
> The HSM M4 core needs to be booted at R5 SPL stage so that it can be
> used for further Authentication and security services. Therefore, the
> firmware for the HSM core needs to be packed in tispl.bin fit image so
> that it can be used by R5 SPL to boot the HSM core.
>
> Add a template for packing the HSM firmware in tispl.bin. The template
> also contains necessary fields which will be populated in the boot
> extension and load extension in the x509 certificate for HSM firmware.
> This is required as the HSM firmware needs to be signed before invoking
> TIFS to authenticate and load the blob to HSM core.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>
> arch/arm/dts/k3-binman.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> @@ -297,6 +297,26 @@
> +                                     ti-secure {
> +                                             content = <&hsm_fw>;
> +                                             keyfile = 'custMpk.pem';
> +                                             proc_id = <0x80>;
> +                                             flags_set = <0x04>;
> +                                             flags_clr = <0x00>;
> +                                             reset_vector = <0x00>;
> +                                             dest_addr = <0x43C00000>;
> +                                             auth_type = <0xFD00>;
> +                                     };

We should use hyphens in DT property names. The existing ti-secure
properties (auth-in-place, firewall-cert-data) already follow this
convention; the python side can still expose them as proc_id etc after
the usual hyphen-to-underscore translation.

> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> @@ -297,6 +297,26 @@
> +                                             proc_id = <0x80>;
> +                                             flags_set = <0x04>;
> +                                             flags_clr = <0x00>;
> +                                             reset_vector = <0x00>;
> +                                             dest_addr = <0x43C00000>;
> +                                             auth_type = <0xFD00>;

Please use lower case hex. Also these could use a short comment above
the node (or alongside each value) describing what proc-id 0x80 names,
what bits flags-set 0x04 selects, and what auth-type 0xFD00 means. A
reference to the TIFS interface doc would also help.

> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> @@ -297,6 +297,26 @@
> +#ifdef CONFIG_K3_HSM_FW
> +                             hsm {
> +                                     description = "HSM binary";
> +                                     type = 'standalone';
> +                                     compression = 'none';
> +                                     os = 'hsm';

The os = 'hsm' string is what r5/common.c keys on via
image_os_match[IMAGE_ID_HSM] to identify this image. Please mention
that coupling in the commit message (or add a brief comment) so it is
clear this string is not free-form - i.e. changing it silently breaks
the post-process matcher.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
