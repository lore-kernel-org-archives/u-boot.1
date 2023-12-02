Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84FEC10DC1
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F6AC87702;
	Sat,  2 Dec 2023 19:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WdHdyGuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9811B87702; Sat,  2 Dec 2023 19:24:27 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E42E87642
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5d33574f64eso33730597b3.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541464; x=1702146264; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=adV1n00/sXXqCXvgsDtqWjpC19NNP/zECM1AxbR5JCY=;
 b=WdHdyGuQAzpvMRdFYT62VdLE7KK52xi0YwrjqlXiFMf3v6BIZK9lE6TDEsxcC2xVQn
 m3L9kbJ40AWpkvFqACA6BbL5PldHMwMwaaZvMVTJ0HUAAv6R+IrtaljK6WJYqEGBOYp6
 TfCxvoIi+wTXQgwFMX9BM3o25zNnp2maHrRSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541464; x=1702146264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=adV1n00/sXXqCXvgsDtqWjpC19NNP/zECM1AxbR5JCY=;
 b=A/WXZdVkpMcW0IjAo3Bhr+Q9N77ARHR1QMEposcsyFDCW9eJyYH78oNgDyxfnYEYwq
 d12pq0II1Y9zh0LoX9TKf3Q7GluyNNfdyljov6FtRyM4gI7E6YTr65gjVfmfRJbfyJgV
 PQMu+NmvTGnY35iEVyz5ZxznFZxklO5dly8MVmfYZtQuzflkT7z7vnNsPk9sRpM25hcP
 wPaF1Uz1Uy6aa2x1sJJhX/HifAJEvcBtL/D6Yg+5VDbWWsZp2hKe3dTOyYUYtElSCThw
 GDhvYmvk1mT0Lz2DUxlCu+h51M8ojAjkDoyuo0KGq+rLM2BD4Ayzqfl+Y+miJh/PPqZ5
 mllg==
X-Gm-Message-State: AOJu0Yw+Xe3SDn3zYEsv7zvLMC5WiBj/sqavuFa/6TDF/xep6djjec7v
 ymAKjvYSsAr0/9C0nap5rBp1LPHu1V5JhbpvK6TWPg==
X-Google-Smtp-Source: AGHT+IHhQhQHCiWMRYycLxDq+4ELzRuvcqpaQEcDrGmNseJHSbR5lZNeADByqjVU8/rxeKWshv1wwR44A/TDsETo1h8=
X-Received: by 2002:a05:690c:d0e:b0:5d7:1940:b38b with SMTP id
 cn14-20020a05690c0d0e00b005d71940b38bmr1455554ywb.87.1701541464152; Sat, 02
 Dec 2023 10:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231121152740.24783-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:23:17 -0700
Message-ID: <CAPnjgZ1j67f+mx7jGgBuoJJH4oEUgBNsgS-KUfBsnbwsehOCZA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] risc-v: add support for QEMU firmware tables
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Yu Chien Peter Lin <peterlin@andestech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Tue, 21 Nov 2023 at 08:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Enable the QEMU firmware interface if ACPI tables are to be supported on
> the QEMU platform.
>
> Enable the QFW MMIO interface if the QEMU firmware interface is enabled.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         depend on CONFIG_ACPI instead of CONFIG_GENERATE_ACPI_TABLES
> ---
>  board/emulation/qemu-riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
