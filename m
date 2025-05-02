Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9407CC3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 07:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BAE81F7E;
	Fri,  2 May 2025 09:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="obIo6yij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FCD81FDE; Fri,  2 May 2025 09:00:18 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 739FD8070C
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 09:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac6e8cf9132so313594266b.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746169214; x=1746774014; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AuvnZqPEOSBBa+TwHON8T7Cu1u6PVOe0yLYGMEkF0Ag=;
 b=obIo6yijjcLc+/pZJ/+/5dbrqbpZCJtMxeAql9QCIKxHa3ao1kk5Qe6u5HxcSLamMH
 75cZJ7pU9r23Ytq0nd/hMW6+V4bAdnDAxs4lk6dSL28M5qKseGLXGqwsbEphGPKioTge
 CLpNmseoBevr+XRV1xNP2eReZnJjsQCPL33p8uAoiOc4Pf1OpVvDESpUH2taeppMM+P8
 OcrGklZhs57IoFUZZQjTp3t7gVMOVAJ+wOPgQYyTd/JlArEF8dukVbvwS1LnH+nRPjgJ
 KMd4eeUeUsob+bP2516Wx+ooirmnnDN0milG/zTuOhBTE74e34CGqkp9+BLQi+ijJ70S
 ayvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746169214; x=1746774014;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AuvnZqPEOSBBa+TwHON8T7Cu1u6PVOe0yLYGMEkF0Ag=;
 b=ecqVLHsluTDp0pEVSGIv6dWkIpJDbo348QF9ErgXgkDxm2c0OvIbTMQV1X5fgxh7AS
 arEIJStY8ITJme14cqG+F/XeAJPJBgh1SsP2vSc+tGQXPqOQokjpGVZkfCJhfVkIdxXs
 ZFS03rcTvXy+P2Fvy2WlaxSp6CtqFSCNY7OHYCXXs6op2GJKPizFqoAOz7iWcFEuDKq/
 kGL4EZ8cSwXd9W/BoSpcaW5rI2SZ+A02fsM+w/ZWpTL+zfMhJW94ugFdSKvIMW17c8Ac
 IxBO/EuEIy2eo7EXRwtnjgNzT4rz1X7bXkToNDn+300h5IqGKu8ByuuWSMcQpaBlpMw7
 mWlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh2hodaUwjYBTWsrV5fkesTuexySAm+/AQllm872co9fJ3UW6TN8Hz2CbWexzzgAI7BoOlEG4=@lists.denx.de
X-Gm-Message-State: AOJu0YzC8O9MjQ3rH3xNAK9Rzt/ERoJ/mZG9ub+/Qi0qtGU8OoMd59bk
 nXwbp0+OzWg1X53B6LdPQzBTShtIFqD7FzrFyaJQ3GggQHNwGpc72iND/HRQ75A=
X-Gm-Gg: ASbGnctGgjrtP1HMZ5O+rz8y73dC0MeFg1qnd2JZSkS/Mg2CaBmyln3h4w7Ib86xQM7
 n4KbsKpsKgYrrjwG6tW2wfT4PaUJaIUcVOyAAwGEpoyLd8tndYhAZkgcoeWNxcte0qI6MgWfdzc
 NgVhpTU8CfCgNawU49K291bPlrdK/fmxr70GO9Ya9v4dPFhIumEmMU9knA0xr12znNZRiMKkyzo
 ArGOM5aHehMOabYD9Hmw7Npt1P6st8rMRz0Bqkj8DL/CM6iyTQMA191ilYBUQqFdMthMzIY6ep6
 JmiSx6BRb8GezYLa0JNJajvAq0v75p+nZOwNqUPhiNCrcKac
X-Google-Smtp-Source: AGHT+IFYQ8f/TD0Yr0RwtDVANb0y/QnFfasgIOobHKKsjuGgwn7UP4a3gwCDzRuqaLqIgs/KMtJuSw==
X-Received: by 2002:a17:907:6e87:b0:ac7:f348:b8bc with SMTP id
 a640c23a62f3a-ad17b8a6210mr143601466b.61.1746169214559; 
 Fri, 02 May 2025 00:00:14 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77bf44a4sm749705a12.75.2025.05.02.00.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 00:00:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 10:00:11 +0300
Message-Id: <D9LHBPRHR4U5.2NRVG9UU0X9LV@linaro.org>
Subject: Re: [PATCH 4/5] lmb: use a single function to free up memory
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Sughosh Ganu" <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Mark Kettenis" <kettenis@openbsd.org>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Simon Glass" <sjg@chromium.org>
X-Mailer: aerc 0.20.0
References: <20250501120239.199829-1-sughosh.ganu@linaro.org>
 <20250501120239.199829-5-sughosh.ganu@linaro.org>
In-Reply-To: <20250501120239.199829-5-sughosh.ganu@linaro.org>
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

On Thu May 1, 2025 at 3:02 PM EEST, Sughosh Ganu wrote:
> There is no need to have two separate API's for freeing up memory. Use
> a single API lmb_free() to achieve this.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---

[...]

> -long lmb_free(phys_addr_t base, phys_size_t size);
> +long lmb_free(phys_addr_t base, phys_size_t size, u32 flags);

Since you are changing this, why does it have to remain a long? It can just=
 be an int

>
>  void lmb_dump_all(void);
>  void lmb_dump_all_force(void);
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 73e1eef5011..fd6aee21d36 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -508,7 +508,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_typ=
e type,

[...]

This will lead to a small size increase.
Can you check the size before/after this patchset since you are removing a =
bunch of funtions anyway?

Thanks
/Ilias
