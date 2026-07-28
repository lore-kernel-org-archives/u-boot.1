Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A97C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC04E40975;
	Tue, 28 Jul 2026 11:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A6QwuTWSkZHf; Tue, 28 Jul 2026 11:16:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FE204092A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785237418;
	bh=L5i0pKIVcDi/hdW3U6upOZjctYD9DGAEyt3IWf/EjDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C9mobUWroNr7LX6Sx92QG4yfZI285nohl5VlODvZfHw/fqMXN43g+9WytFrunDrY8
	 677AefSxlpw9QhFbZT11uUL+7aaJbBf6c9+3lh2rN6TjNPxscdS6DN63GMmmwqOxlw
	 k7qVaU/BBnvlMtT3QY84aARLdFz7KNNMis9fDHJAfNP2riiXotKnkRDFDfy5rzFvv4
	 BuCeza0fHyEQfwjvzYn2CrkDB0VaRXME3VxRpsgf7hd06OLNv+523ByK8sJ5hQHQ+q
	 OFRoPD0UcwdBg/uXDq0rPlm3IVB9UOTDf7Tj0Tolv9/aZ6qlJZUmOREtMR6vwbm3wB
	 1xnI02nZ447UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FE204092A;
	Tue, 28 Jul 2026 11:16:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A70E842A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D45D60724
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZRByhxvcNBk for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:16:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5B689607B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B689607B6
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B689607B6
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:16:56 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05708494B; Tue, 28 Jul 2026 13:16:52 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E19C848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:16:50 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so634838866b.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237410; cv=none;
 d=google.com; s=arc-20260327;
 b=DNOj591nTnF1DEayQD11coyTGsImWR7SAdBdUnYmP1MvueQj1XWWjST+yUjcEdrQXX
 pNQNSx06+g2HFqqZeRVIOhTF+si9YWlxednhOQ+smqClzwft+Q1aIB5tpdhJBuNxcOPC
 r8HurDE/6ph7Pcklqsym/lrw4jBffgC07vVIqQZd3rA2lIo6svcjl2WqKjVncLGmMxQw
 Vp4zNhMLwR8ttBAFA4saTVTxY9OrWGY4Bp/zWaspbc+ZaFvN+sCnivXtUL96yVUjaadN
 xWV1jwuDe3wpmWbnkHupYXftFQic19RMNgnAVPLmUzpNvL1De3tX4+6ZQzk7L9+cguOG
 7dSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L5i0pKIVcDi/hdW3U6upOZjctYD9DGAEyt3IWf/EjDA=;
 fh=DXUE9OJaaCgaQkmrtI0x9tzf1uYpca3++Vfo8aoG6Uw=;
 b=U0zVabvPR4B+EWMQxGFtvS92UuNhLt+52k1rPrX6GuyE/T0Oh12LMpCUxZVsW277E2
 x4CQ7lOK1fE8NyNxBWSMvEuarzxCzLxsyB6+fhF7sR3vvB97TMXw9V2KjMXsk8zVz3YX
 RC+G9F4b0kmSWZYe1+5hlgQr1mZM8thqtQ7GA8Jcd0Ec7fhC4MiEUw1bN4rligHgsC2i
 YCBnLsPmN8RlCOlXA7iEVH4/RwCtasvQRJVGdqIYiNNbIGt2DlrKx/zjfF7fsRad/JIX
 FjFnlV23pSVFJoNdIjyz6m1/0P45bS54hu+EaAORQHM8jdIzhW2ugUtW0QkGXto/BHer
 C9VQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237410; x=1785842210;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L5i0pKIVcDi/hdW3U6upOZjctYD9DGAEyt3IWf/EjDA=;
 b=pIBnxiVCiCdORKRMjc46XaQ0Pd1hgSBs9JU/9t1JIskUzNb7rx5YZEK4ByjepWo1g6
 HMKDQZ2AzJVoCMH+5hJpTu5ZLDt6V7xxN9SzPX/xwUNCvuT26gflhrI2KBaerVdm9XbE
 ubUahTh6xlM/wCRPB97b10xMqsA7uCCvG5gbRZJPom9G/MRoLmCUvl36fX8alLO3888q
 KiVw0klXPo61LXUGwJhkPmFQGG27h7lWnPZyLctSFc+n0rAIxnZGzTFDfC1futscdV7D
 mRAH2wuM7pVtL0NL0HrzCyw4RZJTxievfx8MG0nFctM5ZKUa4oz685sv1MGpmEjhTOzL
 9isw==
X-Gm-Message-State: AOJu0YwQuQ4cRGf+NRkwP08TEzQueG8Lq04905YgXUTrYgkk7PXery9a
 c5VairaAYD2jhWzqP/KugBAPxOVC3ynCOXWyyeROG5cK1zCDgDockGpj4M8A9c+6UczH18ECI+J
 BP8dDEuMCuc06OTxYQMFPD6n4V/pVQSMJP3LxRKOHquWhnCVHV+4=
X-Gm-Gg: AR+sD11MFJX3MwjOpi2f2YvcRur06codhJ69Cd0STmvGOP4jIm1Tx0MaW/1GeuN3ilP
 gHZqNjnVoWIqan0WsNXBKV/s8/F1Be8HF4RE4RPAA7dTuitIRybenekcoGyOPe9yxUyHyNk23dn
 fhjuLEg8uhn4R4y2FwXiUnLvdp42qkcpk8ERh2LTARRaGkoQ6PHX0dlyQ18SOcDB6pqezdyb1CX
 HC5hk7q5DNC6MRVrY4xQ0u9cTU9ANFslyhnYKjQmOIFuaCPAxjicrGztf0f
X-Received: by 2002:a17:907:a688:b0:c12:7b74:7812 with SMTP id
 a640c23a62f3a-c1f724889f1mr100220666b.59.1785237409808; Tue, 28 Jul 2026
 04:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-k3_binman_refactor-v1-0-4089220b4fd4@ti.com>
 <20260717-k3_binman_refactor-v1-1-4089220b4fd4@ti.com>
In-Reply-To: <20260717-k3_binman_refactor-v1-1-4089220b4fd4@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:16:37 -0600
X-Gm-Features: AUfX_mzthhKSOkNQQ2e4VknckimRaA0eTc6PhRHFA1UBLHS0TyPyV1zNk5bxwgA
Message-ID: <CAFLszTh2mAP1COO0V9own5rX8vz1Ly+RvBB=dDAiNNfRKf8wXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: k3-am625: add template for tiboot3.bin
To: anshuld@ti.com
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237410; x=1785842210; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L5i0pKIVcDi/hdW3U6upOZjctYD9DGAEyt3IWf/EjDA=;
 b=kjOp8HsWJ5Pq+aOIRK6g8pftGp3lIUqMLEqtfNi0URl5Dj4O401GZTqt4oEyR6ld3w
 NM4V8mqPKIjkS2i0C9b+uU0+iIKO8NCE+KbQrkXt9LYXZhGfefxSuIVqTAX4glR/IVtD
 ahnOI9kPQH7JzKEw8U316x5DoedjiEqFEG2Os=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kjOp8HsW
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="kjOp8HsW";
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
> arm: dts: k3-am625: add template for tiboot3.bin
>
> Currently we are duplicating binman nodes responsible for building
> tiboot3.bin binaries across boards that use TI's AM625 SoC.
>
> This patch adds a SoC level k3-am625-binman.dtsi with templates for the
> commonly used tiboot3 variants (i.e hs, hs-fs and gp) which can be
> inserted by the corresponding board's dtsi to promote reuse.

Please use 'i.e.' rather than 'i.e'.

>
> No functional change is intended from this patch.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>
> arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      |   2 +-
>  arch/arm/dts/k3-am625-binman.dtsi                 | 123 ++++++++++++++++=
++++++
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 116 +---------------=
----
>  arch/arm/dts/k3-am625-r5-beagleplay.dts           |  33 +-----
>  arch/arm/dts/k3-am625-sk-binman.dtsi              | 117 +---------------=
----
>  arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 116 +---------------=
----
>  6 files changed, 137 insertions(+), 370 deletions(-)

> diff --git a/arch/arm/dts/k3-am625-binman.dtsi b/arch/arm/dts/k3-am625-bi=
nman.dtsi
> @@ -0,0 +1,123 @@
> +     tiboot3_am625_hs_fs_template: template-tiboot3-hs-fs {
> +             symlink =3D "tiboot3.bin";
> +             ti-secure-rom {

This bakes a policy into the template - that hs-fs is the default
tiboot3 - but the hs and gp templates deliberately don't. All three
callers (sk, verdin, phycore) already set symlink =3D "tiboot3.bin" on
the hs-fs node themselves, and on the r5 beagleplay the symlink lives
on the gp node. Would it be OK to drop this line so all three
templates are symmetric?

> diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am=
625-r5-beagleplay.dts
> @@ -33,38 +33,7 @@
>       tiboot3-am62x-gp-evm.bin {
>               filename =3D "tiboot3-am62x-gp-evm.bin";
>               symlink =3D "tiboot3.bin";
> -             ti-secure-rom {
> -                     content =3D <&u_boot_spl_unsigned>, <&ti_fs_gp>,
> -                             <&combined_tifs_cfg_gp>, <&combined_dm_cfg_=
gp>;

...
> -                     load =3D <0x43c00000>;

The original hardcodes load =3D <0x43c00000> whereas the template uses
load =3D <CONFIG_SPL_TEXT_BASE>. These resolve to the same value today
(the ARCH_K3 && !ARM64 default is 0x43c00000, and no R5 defconfig here
overrides it), so it is a no-op - but please mention it in the commit
message under 'No functional change is intended' so the next reader
doesn't have to chase Kconfig defaults.

> diff --git a/arch/arm/dts/k3-am625-binman.dtsi b/arch/arm/dts/k3-am625-bi=
nman.dtsi
> @@ -0,0 +1,123 @@
> +     tiboot3_am625_gp_template: template-tiboot3-gp {
> +             ti-secure-rom {
> +                     content =3D <&u_boot_spl_unsigned>, <&ti_fs_gp>,
> +                             <&combined_tifs_cfg_gp>, <&combined_dm_cfg_=
gp>;

Just to check - the property ordering inside ti-secure-rom here
(content-sbl / load / content-sysfw / load-sysfw / =E2=80=A6 then sw-rev /
keyfile) differs from the hs and hs-fs templates, which group all
content-* first and load-* last. Both work, but since you are
consolidating anyway it would read better if the three followed the
same layout. What do you think?

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
