Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB76C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCA5940986;
	Tue, 28 Jul 2026 11:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id St6MK_YL6kOz; Tue, 28 Jul 2026 11:17:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B75A04092A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785237423;
	bh=h1OQmBGde7W40EXUgcySyT4M5HKmse3xifKxzWd87Qs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TjpsgN2KReewiVlsRJuwaI+wrRTHnDcf3nR2UT304P7o+i7YZsCfh6gmbTpkM9mR7
	 1J40RLI5RDBrnw+45Bt6P5uPkF36tt6WwZmz/1PDZIIZUy3153dJOnnfYk+T7y8HEI
	 uCUG3wa2Cim5J/7R/myL3MWjC7RjHFx7vi83eQiKebDQq+b/OH/6EOgKIh0z3q/GUE
	 j9IUQBo9Bze7pUKqkIRgaJVVA9Nmyn2Ozpx5eh+tgid5bLV53mvZ+bAuWvoZ3LEsg3
	 +OcTQv1Q4yIQV85xB++m/AD/clwIkUa2soEdVyuYwSpqD+cM5xqk+B8js4g/RBp30x
	 hJzoudFoh5j4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B75A04092A;
	Tue, 28 Jul 2026 11:17:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74336350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66CD2607E3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qbjW0e1BZwGY for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:17:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 030C660724
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 030C660724
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 030C660724
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:17:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C17C8493F; Tue, 28 Jul 2026 13:16:59 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65540848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:16:57 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so4909504a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237417; cv=none;
 d=google.com; s=arc-20260327;
 b=BeydyLGw2AFmtuQ77gUUE2dYdz96UvaenCJMpi9kRXMxL5/tUnVPfi3kSjdEw/f4np
 n/ZWCNeqss/qQgRZ/gakxmRDcuC7YGfqdtFXAAGHPF7ECd6uDdv213FROvhTBWwME34K
 DMMn+J1gCdznmUEFS8fl6H3J3xf1qvv6B+EwahkGfyIDMsa4o97SBAALhP8rLNggaSVf
 lIoiLajKRREYKHsBGN3+KuFpQIVdBB7+gsdMyHCfliL/HobTyf3g9ulE/8Ia89IpPNm6
 jPDP4PaI7qG7rjlUgxRzzF+pM4rbG0KTe1mw5Vcsw4gEawIvv3yOsxArDg+Mqp55zXEZ
 oIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h1OQmBGde7W40EXUgcySyT4M5HKmse3xifKxzWd87Qs=;
 fh=DXUE9OJaaCgaQkmrtI0x9tzf1uYpca3++Vfo8aoG6Uw=;
 b=h+XwBtOkpUHtJFnv34ZqLaRYlcxUbolOvYD250CdI87V6nZbsiB6nqvNtP0vNmffac
 rFgtGoJeTmX/a8pCW3428pCKD16GC/JFC/UpNWcoe10OV5huTZd67OrdMtq3K6RfKha9
 LULMqjKchcQ/bsqCHzzCw0euex9mGmLTCZKeJSfDgVcQJIc1JK/o5d0ciDbvU8324Wwb
 VNlt6XWSDd8y93m54toSXBlfk6X5E1yepPJo5vpV6/SwwCGx5fGHpMCf8irvbY6CLqVf
 v2KGcX2jpiQFaC26KfhVFit902q7jMXmog3cjm0tAV7UBOrBFD9Us/Sk/VuHEHAVZ79p
 wMLQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237417; x=1785842217;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h1OQmBGde7W40EXUgcySyT4M5HKmse3xifKxzWd87Qs=;
 b=q+hGuyeu6t7Fgn9oQQFZ9KCLzzVjtq8nywQW4RzAa4HifiKk5VEeVaDdLA7U2aMF1o
 372reWkrqW9i5wQTy5HjS4I7+zVtW5Yg1JVjj2rB25p+MGwo9VioShnFX5g9XMnp/CrB
 nRKZ02Z/fdBNF2jlnSv9774D9YBvQRMfBz3jyvjLacSRWqh79fAtxpVzjP7WAmi56zsU
 1JQHX4ut8yLEMtnror6euHqUIMRm9ZV2w3yaJ4djZhn3usVfodrlMV7f/wZF1GEyp7jc
 yz3efNH2xElTb75noWxf8ZUyQzbAIxoBDcnWGYPDPNvrxVgzYigAwrdvuq7Rg3FjGcfh
 9hXQ==
X-Gm-Message-State: AOJu0YzTHVhMiOEGXZwZ4FS2mfRGHKLwxhqap8YzeZeU/6vHb9ygi4pX
 /eSX4SZ00iYvmj1bMYeBEmNUzyMw/y9R3uC1DiYlwjWJ3e/JPYG4TQnbHm1gOqND9MWWsS7hiLq
 OXBCcKbHrKqgmc4q0WJOmXkzwAh3NuyT7T1z7Dw4J0NoC0xrePME=
X-Gm-Gg: AR+sD12yVk8uU2Rq7EHpWaYJlm5KRmjF2Gd9knnuM3b5eaT0O6/zhsbX4Ro22sX2gTO
 Mm9xi1J3WefRBB3tHRPsnO913JaULzQrwPv9pKFucgOdD81QqyA1iiX9E8C9c7TPHv9W7pLDz8d
 yqcEcX/iuRY5lmR7YO75gnSx3fYWh8Xauq8c++qNoEC/tUqSQOoMl7mULerHaJR5RxZubvAIqLC
 pZ3jGZskkZAmmfvB+RsSwKb0GSXpUA/d8ziVG3Qlmzj0w0NrCMirRkDnN9p
X-Received: by 2002:a05:6402:241f:b0:698:585c:f07b with SMTP id
 4fb4d7f45d1cf-6a0349e9615mr1001568a12.3.1785237416701; Tue, 28 Jul 2026
 04:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com>
 <20260717-k3_binman_refactor-v1-2-4089220b4fd4@ti.com>
In-Reply-To: <20260717-k3_binman_refactor-v1-2-4089220b4fd4@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:16:40 -0600
X-Gm-Features: AUfX_myMg-HgMrmV-8FTVl3kuogUaGk-WIXGJfhXEl2Xvy4gzQZhNFC6BQHIyqw
Message-ID: <CAFLszTi2Rc52TKKoGOicXEHF25GUm09gcyuZz0Y5zTjBw1W+pQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: dts: k3-am625: add template for tispl.bin
To: anshuld@ti.com
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237417; x=1785842217; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h1OQmBGde7W40EXUgcySyT4M5HKmse3xifKxzWd87Qs=;
 b=neXI6IYO02Rk6K9O93gdD5OXQVNDYAVf1H4ezz9AJ8dPhHrGlSn2xQPXAEqbAAfYcG
 VsBBGK7mf/rqH1ZBw31x2UT5IrODzTzUEaULRggO/O36aNvE2gb9lCyZrmwiX0Gw6qWx
 UEJCHCRCUFZ7MN/VUX1W42KXt8WfHPgFpWvp4=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=neXI6IYO
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="neXI6IYO";
 dkim-atps=neutral
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

Hi Anshul,

On 2026-07-17T10:42:51, Anshul Dalal <anshuld@ti.com> wrote:
> arm: dts: k3-am625: add template for tispl.bin
>
> This patch addresses the duplication of the binman nodes responsible for
> generating tispl.bin and tispl.bin_unsigned for TI's AM625 SoC based
> boards.
>
> The common nodes are factored out into a template in the SoC level
> k3-am625-binman.dtsi that each board in-turn includes.
>
> No functional change is intended from the patch asides from the addition
> of tifsstub-hs and tifsstub-fs nodes in beagleplay's tispl.bin which
> should have no consequence asides from growing the binary size by few
> kilo bytes.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>
> arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      |  92 +------
>  arch/arm/dts/k3-am625-binman.dtsi                 | 240 ++++++++++++++++++
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 241 +-----------------
>  arch/arm/dts/k3-am625-sk-binman.dtsi              | 288 ++--------------------
>  arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 185 +-------------
>  5 files changed, 270 insertions(+), 776 deletions(-)

> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -63,99 +63,11 @@
>       ti-spl_unsigned {
> -             filename = "tispl.bin_unsigned";
> +             insert-template = <&ti_spl_unsigned_am625_template>;
>               symlink = "tispl.bin";
> -             pad-byte = <0xff>;
> -
>               fit {
> -                     description = "Configuration to load ATF and SPL";
> -                     #address-cells = <1>;
> -
>                       images {

Just to check: the FIT for beagleplay now also contains tifsstub-hs /
tifsstub-fs entries even though conf-0's loadables only references
tifsstub-gp. Have you confirmed that the resulting tispl.bin still
parses cleanly and SPL does not try to load the unused entries? Please
note the beagleplay boot test in the commit message.

I was unable to try this in my lab:

       arm:  +   am62x_beagleplay_r5
+binman: Node '/binman/tiboot3-am62x-gp-evm.bin/ti-secure-rom': Cannot
find node for phandle 100
+make[1]: *** [Makefile:1410: .binman_stamp] Error 1
+make: *** [Makefile:189: __sub-make] Error 2

> diff --git a/arch/arm/dts/k3-am625-binman.dtsi b/arch/arm/dts/k3-am625-binman.dtsi
> @@ -121,3 +121,243 @@
> +#ifdef CONFIG_ARM64
> +
> +&binman {
> +     tifsstub-hs {

The three tifsstub-{hs,fs,gp} nodes are unconditional within the
CONFIG_ARM64 block, so every A53 board including this dtsi will
produce tifsstub.bin_hs / _fs / _gp regardless of variant. That is
fine since the blobs are optional, but please confirm this is intended
and does not regress packaging scripts that consume these artefacts.

> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
> @@ -392,16 +155,15 @@
>               };
>       };
>  };
> -
>  &binman {
>       u-boot_unsigned {

Please keep the blank line before &binman - the file is easier to scan
with the separators intact.

Regards,
Simon
