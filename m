Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479D2C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CE8687A3D;
	Thu, 28 Dec 2023 14:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mi0x/owC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB29787A01; Thu, 28 Dec 2023 14:37:30 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F0087A3E
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35fea35c432so39701405ab.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770643; x=1704375443; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naYq6txQt+TXBe6iYe9hRukySgIcUe32LFBMW26ugKo=;
 b=mi0x/owClCle+0FyhdXTWfxW2y+fp+fD7U+8LLdUcrT7IiAzJJoPmIZRon7G52uH1H
 0FG1lpgsBSmQ2ANTIH6s8b99/f8SlISkuA1C1zqeCKV4UpObMG0l63HI7REPAkmqIgoE
 wBt5XspgDodYsBFP4C1bLkuhqRGlmgk7KLH0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770643; x=1704375443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=naYq6txQt+TXBe6iYe9hRukySgIcUe32LFBMW26ugKo=;
 b=fyt7PVudumVz2/vJkMcI+svjyhiikqKqF1XarMegUfb82MVWQXJswB8gC6pG7qgytU
 BZN5TmBqLVnP85Sedor64VTuV5lXwEXwAlfakcbAtYLTXJNQ2cTtjfLlLI8+jvqBb+A0
 LuESyWrxLAlU7ZW6GaJ7NOepXYEv3LMV4CVzGViQYja/PusjI1ROK1FdCa23wt6vQ69U
 Yq5bGiWjNGkJvb9qoJl+R92+8bfsH6tMLSaVQoh7RCoKYGavQ8pasbSMlc9V73+K07kF
 YHBCchKFk3DfJbKWrl8I4jYxuu1cToURQJ6bqRwFwHSMK7VURbPIcoRxpB3fK4YH95LJ
 TX9w==
X-Gm-Message-State: AOJu0Yzd+H3b1tmo71aO7Sab9tNWYUCuNrjN9RBiManNfhAD/B8wc86E
 RMxCWEmnjw/KENdy6idXZ2nq/N8Rk2TvVJGJlwS+6cL5Afz3
X-Google-Smtp-Source: AGHT+IHMX+lmDMPX7B/CjwaJCv86iPyZJd3KPoNVBY59Npy80BmlTaWdVrMxfG6YFxvkjSbWVTJjoOOs0gh7B6uEr6U=
X-Received: by 2002:a92:c54d:0:b0:35f:ed80:9ce3 with SMTP id
 a13-20020a92c54d000000b0035fed809ce3mr13548329ilj.50.1703770642981; Thu, 28
 Dec 2023 05:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-3-sumit.garg@linaro.org>
In-Reply-To: <20231228115804.3626579-3-sumit.garg@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:10 +0000
Message-ID: <CAFLszTioYajRMo7DBhaVA_zJsB11bbsJQTSJFWaZDF+M76DO5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] Makefile: Add support for DT bindings schema checks
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
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

On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> This adds the build infrastructure for checking DT binding schema
> documents and validating dtb files using the binding schema. Here we use
> devicetree-rebasing directory to provide the DT bindings.
>
> Dependency:
> -----------
>
> The DT schema project must be installed in order to validate the DT schem=
a
> binding documents and validate DTS files using the DT schema. The DT sche=
ma
> project can be installed with pip::
>
>     pip3 install dtschema
>
> Note that 'dtschema' installation requires 'swig' and Python development
> files installed first. On Debian/Ubuntu systems::
>
>     apt install swig python3-dev
>
> Testing:
> --------
>
> Build dts files and check using DT binding schema:
> $ make dtbs_check
>
> Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> use for validation. This makes it easier to find and fix errors
> generated by a specific schema.
>
> Note, at this point dtbs_check is an optional build target as there are
> many warnings generated due to custom DT properties used by many
> platforms in u-boot. It is expected with these checks that compliance
> with DT bindings to take place. Once that's done it can be added to CI
> builds to remain compliant with DT bindings.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v3:
> --------------
> - None
>
> Changes in v2:
> --------------
> - None
>
>  Makefile             | 20 ++++++++++++++++++--
>  scripts/Makefile.lib | 17 +++++++++++++++--
>  2 files changed, 33 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>
