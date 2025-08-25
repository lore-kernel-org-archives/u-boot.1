Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C872ACA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 21:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E85182DA1;
	Mon, 25 Aug 2025 23:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GA/9xfvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 138AD83020; Mon, 25 Aug 2025 23:59:21 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB16828A2
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 23:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-afcb7af30a5so838350266b.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756159159; x=1756763959; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QA0k4H3x0oAHUL1JrMuCzbx9stqolY3KtXEUK53m7CI=;
 b=GA/9xfvfQgBHfdxZh5zvoHqtaGaZCxyeRTu3h7vMUs0uQxy2EXzxb3vS10k6hNpXRW
 DZLGFtrEZjGzwGc1FuQUKVyF9i56m6QZ2KqrpgeSE62BJnljpPunw3eH29T8nKusfL2u
 h944AwvaNV3YEEYmPUJnT77eEfVA+f+up0W5LRM891Ob6JVVPFgyKPjo9CyKOOuxOXCU
 INllCaFUAgSMDx6sga4ggnX6FG2XRtduoTyMjEPM5fQeVGhrXirF15rnt5++nH8jlWik
 pVQgYMLxYLy7uJLXHOogawrrf3SqOXDH+hEeY/HqpWOwlx009Ugw2gbmnAsJlPz1VLcO
 2Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756159159; x=1756763959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QA0k4H3x0oAHUL1JrMuCzbx9stqolY3KtXEUK53m7CI=;
 b=B+QrvLBdNhzy5n/jq2EooxwMDggYySYMWLZhtyoJy+btoECJpkRnk6NmfVWbLwqqlE
 cWboMNapC15yj4oduc8qzhdWt2+TjLYJko2ZH6hyB9nly9wWpJxEB5pEiseqcvUuvAV7
 zCR4VR4/pdTQ8AP1oh4pc41Hf5rbVcVGhqx80rcaFm6OxOgvfY+TCXSaciJyphYwQaIZ
 ZuOacvcRtcd9GmVTMXIayXTqsElZOWyzZVcCdIkFCNHA/uNhiVkZc9CC75Nq8nRY8Moy
 dDUhaG7jBXz1gu5WSrWhph2OKApRMzQePX2fpZN7hoURKtQeRus66F9ZipZzgq8Bj1he
 JNig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz8VmJhDJK7+JLidX0YHkPcPmWAgSO20dSUZYdeOQPotGRF1ixZmwpjl7nfdwAiVDPfxzI1J0=@lists.denx.de
X-Gm-Message-State: AOJu0YzRntSuQEocx1q0cPYDfJKTvkkYt8SJlH15q5K6UafXdP/FsdjH
 ICot6NNEwjgHw4ke5zZg9ujfg1XgcezYaEDY6GKpuH/6vfmbRd+T5ITZy3/tK5DuFXjJ8MXAoKx
 qq3Qfke57Iu2JxfF392BU1yPDooB+gVs=
X-Gm-Gg: ASbGncuP1Bfu2jL8LBYs292tLmrasdbdJarojnt0k7DpHHfnxgobJBNc5psNeSZVRmu
 kKfEEwtb+KiVOqvIoRHsIaNvts/xPNM+Dst2ivGo4Ny3wqfKFrtZPiWAWC9a9IViH5VtREM2AA2
 QgAKV69/0/N5EFO1MnIMJH2xy/XgxFEbTXSNfjGLvYygDYh1hlJvUJlUOVh0/I7nGJ8GQC8ftXQ
 hYQ0oNAORF9V7grnupY4/u2bXpjTRnH9qnuww==
X-Google-Smtp-Source: AGHT+IEdsm+tSqDx5yiU2sV8EB4WT3C4B+6Y8HI9sB/wlKcUSjYu1i+k04Q4ZuAPkV0fdekR7RLVsG6PBAmgaiYX7KA=
X-Received: by 2002:a17:906:9f87:b0:af9:c31c:eeca with SMTP id
 a640c23a62f3a-afe295c0d8bmr1338662766b.48.1756159158297; Mon, 25 Aug 2025
 14:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-7-adrianocarvalho.pt@gmail.com>
 <b8fa5fa1-0028-43e5-bb14-db94fd16bf3c@gmx.de>
 <CACAHuLDQ9gp6G1KnbPTH2bcdFChY4x_M1HC0fJU-SJ0ozkghKA@mail.gmail.com>
 <CACAHuLD=fkEKq9e83f3ePQHO1N5dnVsRuFHwR6U12jv2EBJnew@mail.gmail.com>
 <20250822214045.GP124814@bill-the-cat>
In-Reply-To: <20250822214045.GP124814@bill-the-cat>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Mon, 25 Aug 2025 22:59:05 +0100
X-Gm-Features: Ac12FXwB_lyUUZ81OTFeZUGCvADQKOmC1sRUaKgBXiVWkFGc42u7oMi7phIxHto
Message-ID: <CACAHuLDXaAuWTey1iFw4NUCq=kysuy4PKLWXRSypGtdK4XprVA@mail.gmail.com>
Subject: Re: [PATCH 06/10] doc: Add riscv to the list of architectures in
 tools/buildman/buildman.rst
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
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

On Fri, 22 Aug 2025 at 22:40, Tom Rini <trini@konsulko.com> wrote:
> [...]
> There's a few things well out date at this point:
> - The output from '--fetch-arch list' shows what can be downloaded from
>   kernel.org. Keep in mind these are public toolchains, for the Linux
>   kernel and are also fine for us. That's why it lists so many more.
> - The section "Check the available toolchains" should be replaced with
>   modern output, and you need to pass -v to get such verbose details now
>   rather than simply a list of what would be used.
> - The section "Install new toolchains if needed" should be replaced with
>   output from using an architecture U-Boot still supports such as arm64
>   or riscv.
> - The "toolchain-alias" parts don't list what aliases one needs and
>   since 'riscv = riscv64' is needed, rephrasing that earlier part of the
>   document should be done too.
>
> Thanks for working on this area!
>
> --
> Tom

I hope you don't mind that I'll leave that to a different patch series.

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
