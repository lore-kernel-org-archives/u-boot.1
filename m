Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FF1C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C5C28754A;
	Wed,  6 Dec 2023 04:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CgtYjRhI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06AA587630; Wed,  6 Dec 2023 04:54:28 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5785E8754A
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a1a496a73ceso41271766b.2
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834864; x=1702439664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xX0J4Ze6N/R0sPVs6QdgiQ78rg1p19mikJU2goGezDE=;
 b=CgtYjRhI0/1EtUoSRbuSLdSfxSacnbyVYElF//8HHiHkBtio1xRwjHqGGIzKyEp7ou
 /Vb9x/xnfNA0nV1dDWjoWxdxbIPGUqUx1w32jYaF8x0YoZ/lEU/QCzy488yHvsblEbWz
 2tgwkhIlSUXWPV9DdnOOgtllqaBwGNFZ/Yz+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834864; x=1702439664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xX0J4Ze6N/R0sPVs6QdgiQ78rg1p19mikJU2goGezDE=;
 b=jRRVQ/V33F64BjhTq3XyGJDtzqrHK14bpV5r/9CUjFAVjZyAyQME7TJaYf97G6pmvE
 Bdhsrti+fyloBm9cHF8ItfxnlliybPM/lHDEb7e+b2eH8vGEMpS7v5c4aUv4GpKmg08K
 dDbQFS9X0yLDLGSB5mfZzBbkAZym8FRBnM34tD1FNWc3nxIASLkDyW1jbPUWLlnP6Ezl
 zT5QrsyrpXSZLbYz8tv7TszGgCc1YNa7/NnwsiJMtt4T2XZFDBH3/E+72K6yTcb4WRMC
 vXxg9lMPPWfs5kaKpAEdK7+6tljmfSNhgnxuGYrVy4PPLOqAU7rTy31IaEpYZCeumnCE
 FM6Q==
X-Gm-Message-State: AOJu0YxkpZBjC73IBf+qHeTdjzmw22SYk+dEDz2awVmjAfEB4ag8qe0N
 09HARU9di+Mz5TBCEo1HDvdfjqwubgw88SUsaPUbrw==
X-Google-Smtp-Source: AGHT+IEPMklcrygqMl6L9BahbaRxSkTiqqL32KgjgBgHWxH8mdy9mm9/ANpNyeoyAD0FDiwjbfPNzQCPMyHfUbyCxWU=
X-Received: by 2002:a17:906:51d0:b0:a19:a19b:7893 with SMTP id
 v16-20020a17090651d000b00a19a19b7893mr131065ejk.86.1701834863692; Tue, 05 Dec
 2023 19:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20231205094220.2301360-1-n-francis@ti.com>
 <20231205094220.2301360-2-n-francis@ti.com>
In-Reply-To: <20231205094220.2301360-2-n-francis@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:54:08 -0700
Message-ID: <CAPnjgZ0J2GLhVEdfPR78kP6d=T8Yk3wMCTTODc4x+7jzf5N-sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binman: etype: dm: Add entry type for TI DM
To: Neha Malcom Francis <n-francis@ti.com>
Cc: marcel.ziswiler@toradex.com, alpernebiyasak@gmail.com, 
 u-boot@lists.denx.de, hs@denx.de, christophe.leroy@csgroup.eu, 
 mr.bossman075@gmail.com, afd@ti.com, m-chawdhry@ti.com, kamlesh@ti.com, 
 nm@ti.com, c-shilwant@ti.com, u-kumar1@ti.com
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

On Tue, 5 Dec 2023 at 02:42, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> K3 devices introduces the concept of centralized power, resource and
> security management to System Firmware. This is to overcome challenges
> by the traditional approach that implements system control functions on
> each of the processing units.
>
> The software interface for System Firmware is split into TIFS and DM. DM
> (Device Manager) is responsible for resource and power management from
> secure and non-secure hosts. This additional binary is necessary for
> specific platforms' ROM boot images and is to be packaged into tispl.bin
>
> Add an entry for DM. The entry can be used for the packaging of
> tispl.bin by binman along with ATF and TEE.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
>  Makefile                        |  1 +
>  tools/binman/entries.rst        | 14 ++++++++++++++
>  tools/binman/etype/ti_dm.py     | 22 ++++++++++++++++++++++
>  tools/binman/ftest.py           |  7 +++++++
>  tools/binman/test/225_ti_dm.dts | 13 +++++++++++++
>  5 files changed, 57 insertions(+)
>  create mode 100644 tools/binman/etype/ti_dm.py
>  create mode 100644 tools/binman/test/225_ti_dm.dts
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Is there a doc/ update somewhere about TI_DM ?

Regards,
Simon
