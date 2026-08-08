Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C701C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12C2B80E9C;
	Sat,  8 Aug 2026 17:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7uPw0Z5kzJ2a; Sat,  8 Aug 2026 17:23:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4678B80EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786209823;
	bh=SR3dcBE15dw50rSFyrGgP50hCgY+yl6BasuS1fhxMCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I4DL4/BUSxwW6wv1Rs2rtGa8et3QzwubVDNsH2r5Ct+9TMl0XamDCfZiTsOmbgwXH
	 trk7U5sIdruKoeKEI5CfUtL1l8xdnTRQZrZTCiLfuGajD3/It8zU/sUAZdoxJBRnT2
	 +UAb9iQZWamSGzQhdaUyd28FFEYejpExKn76X4fixL9Ad30K2eeRDgupzytlC7ZHmM
	 Js6fGE5jP8WNSDatPnrsinRxBEY+PI2AG4OkqZsj7pr55/1hFJT0a7zXql/ukk3Upe
	 KnZaIqQyxxWz0EdZBNji4SPsPMbkO30GNwlo2n/Y/RB7vlWU5OASIw0xRcuRwZHnFS
	 SyobCIEDkZ2Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4678B80EA1;
	Sat,  8 Aug 2026 17:23:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DEFFC144
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C61B980E9C
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c6Q5SL7qZjx6 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:23:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C9CAA80E28
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9CAA80E28
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9CAA80E28
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:23:40 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a1b51723a9so810505a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786209819; cv=none;
 d=google.com; s=arc-20260327;
 b=HF6/wpwGwFgIaLpBlYMe0atmdhbw8hWVxNbomHw4hPZ5RSHKutNWezr139eO7HDwRQ
 yrDD5cXAv4L6dQ0S5vtYrlazHUFOiVre6xDbob27PNze0eNPoPM8bMq1+avaMU40JVRY
 x181ng1+FcptsSH7wBcoUVGk9euDvpZ54ndO0zj9vEdePfMrkWThbOdOWp/ukNYuTw+h
 URdXHRVZV3RkV4fVAY6VItAZrDWZlqsyCVc/P1XZDBOhY1zwDA2WMR2BRBN4HGFrC82Y
 ai8763DVGSFKc9l7NgIssLc5sC8y367i3CKUYKIacx67I4Bfx8zmJT0p4vrn+DqLPUUj
 Nrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SR3dcBE15dw50rSFyrGgP50hCgY+yl6BasuS1fhxMCY=;
 fh=Yvqp1IYQMFjLj9zCkC4w4ectsS5JIuQOsnvOWh99j8w=;
 b=OaxHZCe+4xBtgR+5R71jsh1IHdgCYSgHNLIemB8Umttyp0FW1CWaopm5s1D9KjsT4I
 Raj/611+QwnZr1HRr6pidRPMYt8URTmNREmBi0HuWE84G7G4gDsNZ4ECj49aN8I4rcOO
 t58/nqTm2QOT+u5/kHmidy52Az6Jh7ABAKdDPQ6civtfAw/QWrXEW6t8C5PI1tIyNspd
 i434h0pUlLhFkR5OY6E525pFZhKUHhi0yGLMM1WOoOB5HDwBZZ8dWdlX9HtLE4CDGvBr
 3+oNovqQvtUTh6RX58JoQfvhq4DYm2xPnxyifB3PSZEYZpuVxSK/bP4vrNYeEb4wyVOo
 8NFg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786209819; x=1786814619;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SR3dcBE15dw50rSFyrGgP50hCgY+yl6BasuS1fhxMCY=;
 b=H2tm4G1Ax2i4KvuFtr2f0bvB31I5Cd2YI7XRDs7U6BBtaXLPX3/WL8mBjmlnfgdjrV
 UfuOObg6tT566ngK40hSxdul4n29Eagn5YuTLCtweUSegT2v3Zs4brrDsl7ropWJ7wb7
 zUg4/lWzrs8wmR1vXemjBwDyjLFf6kCe4r3chXs8EpXyq1KeW5hi044mj5on0UaYeJak
 Su1t6vHSPXu4B420/Iz1cARCsv1E97g1dL4/KrZy3AmeC0iJ7LqHzCb+DCHojq9KGMvy
 9GMB5MbNOLxQJ6nnFEGp3iPf8O6Eu1WXne1N9gHS7v33qlRz/KBrG/1uHA4RWJvDYXlZ
 PO0Q==
X-Gm-Message-State: AOJu0YwxfCV7592pn+XhEp1grHpuHgdsfjQ44JVJm73zyykuMQBbm0N/
 005YU4HCyQ4UxR5ybtQ6toEWpmCC0xYzGKoJvRnbqROGBHe4ycZI49jGkJv1nXtY0RICTT4pbL4
 CQt85TPdlSAZWvqenGbcchBB932LXlZxvj9Y9UGN6gJQPoWsbhC4=
X-Gm-Gg: AR+sD10woSKPA1u+MdH65TDQ9YuakrhfZ+62MQ8uekgImWgbKkpCEq6D0+3ZU7J95sJ
 My6OrXmutRsERRyJlT+Kw9rY0c24T1PUKyjVvsV97VrVzU781QYlUeaFh80Z7GYXCFklSFD7mFF
 2tXBp4hqO2wgd6CD8jGGQolHCENA0T/ZhMahepK4s8aWSl0/xDTCCVhcMWsfcx+LSQHAhgCXAIs
 DH+XGGQ6VGFcaIEbb2ryrf+mMI72i9O7pamNAoRjqHZdCESOx+QZSj+yzW/amZCr5t2x46Vw1g3
 I0Ud2hiPf4DmAawzVGXXn7FTu5rhVXirzTe7+ATjgEc=
X-Received: by 2002:a05:6402:52c6:b0:6a0:a4f5:f4eb with SMTP id
 4fb4d7f45d1cf-6a14f0a1377mr14063730a12.4.1786209818838; Sat, 08 Aug 2026
 10:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-tpm-trunc-resp-v4-0-5dd1a634ea4d@byteray.co.uk>
 <20260729-tpm-trunc-resp-v4-2-5dd1a634ea4d@byteray.co.uk>
In-Reply-To: <20260729-tpm-trunc-resp-v4-2-5dd1a634ea4d@byteray.co.uk>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:23:25 -0600
X-Gm-Features: AUfX_mxFNiy0p_LchJeycW9nHMK4rumqt_bK41p6Z8orRXWcNXUVQmZygKVksPg
Message-ID: <CAFLszTj1vG5cg6h0LFbdY_c=YKq2aemHPNwQDdcv6WmF5Nb+uw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] test: tpm: check malformed capability and OIAP
 responses are rejected
To: shahriyar@byteray.co.uk
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>,
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786209819; x=1786814619;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SR3dcBE15dw50rSFyrGgP50hCgY+yl6BasuS1fhxMCY=;
 b=D+wVkQdKsWLKTpOJs1WnKYsHg94OFPklH9TaPoiNk/ND0e3aavNRyE1Ei8Xkx2lQVC
 WnLpySK3UE5aRhRRgH8tI35FtdZAiJ5bO4cpW6dmIYIe0swMXLy1xHrEZPv2QY6+wbL6
 ys0PRHksxSIPp7z7PjYkzNVUI4dV2VfHRwXkU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=D+wVkQdK
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Shahriyar,

On 2026-07-29T18:25:21, shj <shahriyar@byteray.co.uk> wrote:
> test: tpm: check malformed capability and OIAP responses are rejected
>
> The length of a TPM reply comes from the device and cannot be trusted to
> be well-formed. Add DM tests for the malformed replies that the length
> checks reject.
>
> For TPM2 GetCapability: one reply too short to hold its header, and one
> advertising more data than the caller's buffer holds. The sandbox emulator
> gains two test-only capability properties that produce them; the short
> reply is caught by the length check in tpm_sendrecv_command(), the
> over-long one by the caller's buffer bound.
>
> For the TPM1 OIAP helpers tpm1_load_key2_oiap() and
> tpm1_get_pub_key_oiap(): a reply too short to hold the auth trailer that
> their length arithmetic subtracts. The emulator answers OIAP with a zeroed
> session and both commands with a truncated reply, so the length check
> rejects them before the subtraction underflows. These paths need
> CONFIG_TPM_AUTH_SESSIONS, enabled here in the sandbox config.
>
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> [...]
>
> configs/sandbox_defconfig      |  1 +
>  drivers/tpm/tpm2_tis_sandbox.c | 28 ++++++++++++++
>  drivers/tpm/tpm_tis_sandbox.c  |  9 +++++
>  include/tpm-v2.h               | 10 +++++
>  test/dm/tpm.c                  | 88 ++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 136 insertions(+)

> +#if CONFIG_IS_ENABLED(TPM_AUTH_SESSIONS)
> +/*
> + * A TPM1 OIAP reply carries an auth trailer that is subtracted from a
> + * device-controlled length. Check that a LoadKey2 reply too short to hold that
> + * trailer is rejected, rather than parsed with an underflowed length.
> + */
> +static int dm_test_tpm1_load_key2_oiap_short(struct unit_test_state *uts)

Both OIAP helpers now have coverage, and the truncated
LoadKey2/GetPubKey replies drive the length check exactly. TPM_HDR_LEN
is 10, well below the 55/41 minima these commands declare, so the
guard trips as intended.

Reviewed-by: Simon Glass <sjg@chromium.org>
