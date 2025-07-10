Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E32CC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139CD8362C;
	Fri, 11 Jul 2025 00:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PqyXsB4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9831883754; Fri, 11 Jul 2025 00:42:08 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C9683741
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73cdce0d62fso791261a34.2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187324; x=1752792124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nS/99TII7Mvithfl7bU6/7S+Zyyq4iZqSqeqaDklTT8=;
 b=PqyXsB4gcbkRjD03FiOy4DVw5KUj/P3ols7t6ihfXiLG1REyHFdphsezeX8O/0zgzz
 jHsJ45tESCztYIgryegAQjQA2vURTmBtguWVtWGKIR7upgakCR7AwpSfOF5myiY/QwZh
 gZBnpHF44IaANWMkIM4ehefmzwmob4ckfblVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187324; x=1752792124;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nS/99TII7Mvithfl7bU6/7S+Zyyq4iZqSqeqaDklTT8=;
 b=V/BSYzxNrMytu4U+/QfIbmyyvJPSuEf2FWfqkGFOdwQGLXBY8xr3LWrnQb2tJGvsUf
 MOPGSdO1irvGi7m49r3dfFwrd2AMxqqz6Jd1W1CL7pn7AEawgEQWRkAYUSH/bNBJNQuK
 EwikKzafIvIE+DFJnqN2wzqHpG8E213goNhiDt+YTXctJDeU1DzH6fjKVzOr6XtZ454A
 PWD8ATsQQqPvW2s3ZDMlIdAgNSfJ6v2TYFuZaiblV7VCZ5NKIphKaWKz9aTdHYd7u8po
 vse0l4GKcghR1lqPbw1IoKlB0BEYOdeUuVIrM9Cdm//ow3UVdCpnR33GzjhBsM3qGdKU
 2Zeg==
X-Gm-Message-State: AOJu0Yw3hqKGQ7btnZ3QWRTj8hX6XZ0DiC7jfSslzUdfpCAn65PtCeRh
 0e5dpgx7busclA1hS4JH9hXgtThtHKPqKaXkxcCZs9r5hc7WZ7sOqAVJ3/Sv/6y+taBDfYjgvdj
 82WnKjK0=
X-Gm-Gg: ASbGncu//RobaYRT1/ba0NTfs9DVy5ioCwI+YdYWHswPfS/fxxx1KITaRPvQeDIux0u
 8yN1iSPGGy70gqvTvyxqlkDn49KfcBHAI2QvAwuiHpkfiZR5LTlL7LyPF1BsjnpscZaLj3u9Plh
 DBXt/YiiOphLzYE+oW4RWcRZQmhJ/UWDP6nQeIWjh125hxaLj0cAakLY5CIMjpPj1tNjfGbxUZr
 oHM00ym2okzSsblkkzqrpQu2Q0k0Rg7jv234iyzkqn6QwwJU6G2ESHw0NqJyeYB6XYXd0Cg3RYl
 pRW+FTTphZP9ZnUG4tnkl3ErHeLWF/uc2eyS0gxbw64BSdcEGXtOu5NH8eTVst5PnsihUartgC/
 tlLq+8NBaB+7BFGf54hoFIqAWM9DwyBM7tVdKjoxUpeEOQFB025DvGPgK8dJZIGQ7Lg==
X-Google-Smtp-Source: AGHT+IEIfMjB7a4Chac0icQJOxx4W+aQnNH1Zpf0kaB/nvuCB9/uiPLzxQaukchk2XoYnzUIZxP01A==
X-Received: by 2002:a05:6830:4990:b0:73b:26ed:237 with SMTP id
 46e09a7af769-73cfb261cc0mr371987a34.28.1752187323667; 
 Thu, 10 Jul 2025 15:42:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010432.18977-1-trini@konsulko.com>
References: <20250702010432.18977-1-trini@konsulko.com>
Subject: Re: [PATCH] adc: Tighten some adc driver dependencies
Message-Id: <175218732294.2073260.4334007038174551594.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 01 Jul 2025 19:04:32 -0600, Tom Rini wrote:

> A few adc drivers cannot build without access to some platform specific
> header files. Express those requirements in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] adc: Tighten some adc driver dependencies
      commit: e7342decd5ec1e55126e16cb761c61289c150a1b
-- 
Tom


