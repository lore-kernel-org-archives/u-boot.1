Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5AFC41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B9687729;
	Sat, 16 Dec 2023 19:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IrlXMUIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80E6987752; Sat, 16 Dec 2023 19:46:02 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8CF87721
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a1f5cb80a91so212007966b.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752360; x=1703357160; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G+0uw7p43Qf+m57N2TJG5fy6fMfWLwVJqtlpAbQVoJc=;
 b=IrlXMUIhUarc9WRH3VUe3KQ1YQ4gx4yw1uidYHA5yX6QktqKOtC9iq8DuA8zAx7zFt
 JhrPLV6H0L2ys26DdizU869wHa4SxLG0KeCQllGei9Me41188E9VoktNcMoLGbcqm8My
 WZ8ZCoqQ7+GVYM9ZE0jBPJ/okAIz+dqbxPldM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752360; x=1703357160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G+0uw7p43Qf+m57N2TJG5fy6fMfWLwVJqtlpAbQVoJc=;
 b=SEgJTdPoFGi5q4smU8oGvYCPaOkiyYVYD8lgHakVrSzu/8pVTSIdEiXxz0gLkEpr3O
 PkpiqE02m4OSDQb1tHj/cknqk/boCfQTOLH0jYRqoIOebYA2vnatJqlro3MKs6NRz9Eo
 KTBEh9Fp39nm4oJvJOubnfqBO4T69rD81lQP/rGbKA5eV7ux/J8QuDMoPqo3ILgQdJlj
 0c1bRvCJywp5OTE7ZyRH1HM/e/DPkgep3iuL4nt/zjFKuuYM3HzEHZ+oYTN0hiSIV8Kk
 8N1p9Yz60P0E4l/z8O50ye3zDd/Oc92Pvlp992kbyUG5UWY8lXq2NfG/R4vlafnWHUMh
 YySQ==
X-Gm-Message-State: AOJu0Yzk465qcd6UGHbqBGDDsD4fadi5EDxatYMrqiqSQaZnUncM6StI
 vvadmtNxay6tatm2pf7/AgzXutYQLdDbkl25TvvwJW4+DjRSmRKs4C4=
X-Google-Smtp-Source: AGHT+IGt19N7Oj4q8d617rsc7pmT/6xEsnIX9DRESR+mU6HFmytV8NpW0OF3zFW4KOY0ChLyj6nY3iNvfgzEwbbsWB4=
X-Received: by 2002:a17:906:7f90:b0:a19:a19b:422d with SMTP id
 f16-20020a1709067f9000b00a19a19b422dmr4284068ejr.152.1702752359793; Sat, 16
 Dec 2023 10:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
 <20231216081200.7677-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231216081200.7677-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:31 -0700
Message-ID: <CAPnjgZ2mD=+sgLPFCL6Vm1z7CP65JkEkKxvgxacS5y-qSsr9Aw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cmd: acpi: check HW reduced flag in acpi list
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Sat, 16 Dec 2023 at 01:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On non x86 platforms the hardware reduce flag must be set in the FADT
> table. Write an error message if the flag is missing.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/acpi.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
