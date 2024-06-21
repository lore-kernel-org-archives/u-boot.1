Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8845AC2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 05:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B0A88093;
	Fri, 21 Jun 2024 07:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CBeOkoIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB7887FF7; Fri, 21 Jun 2024 07:49:06 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2761882AD
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70635466708so1586606b3a.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 22:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718948942; x=1719553742; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=euDJDaTFyQFq13+6sJFdOh6anT+XbrRARCTcp+3aXkc=;
 b=CBeOkoIazrw3IJCZEl8DDm10ZIUypCSzBBjg0qzdXaIgtAy4ewuOy0rnqjqog3Itn4
 xaDqARwUawFQ6Qsp9QByR66iUb2sxKv+YQGM/qDFcz4wEm0n6gVzlT6Bg5579mcRRaOS
 e+cNHO0pDJjGI1vbwcm7yqX0rzB9hJcoxeALrcdr4DgBI0W2XZmSti9VBBhPQQr4Jlch
 aJEq8+c0cT17teQoWev94arHwIpauiMwnFqekXuPc6+/traLgdJitlyFn+UKr4yWz7pR
 RoNnclcxbogYHAWGe8JIt3cLKJqan35jdPg2o3yzGdk3V6v3mrRL9Xf9fk5OJ7m0Oavu
 dE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718948942; x=1719553742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=euDJDaTFyQFq13+6sJFdOh6anT+XbrRARCTcp+3aXkc=;
 b=AltqHrkh5brHitKVYdP2ZdLlwGKr83oI40k6joYN7Z8Q8U5wcPs6M1RAVBQi4AAQR8
 C55KwscJkHqDkr7eSYOVPI0a/WrrkUh177OH9saOsEzejyHHkiJhYU3q6pFXV6EDwH71
 +Sob5wfOpwzm/YCYH68sAiJ62OmP9zgia1hTYVIons/8G9SB/zbHT2dz5ZtIrHDB97n9
 V56aAMVnRXqJ1AjQ9oKPz7gCfBFYxXNZgMn9J7/TacbQ1rw06PNR+uED7NKsi+agTAYT
 vGPzsMyFEX1j3jLIhbm3Q55za7xCpfSTRKtxmPhxvjMF0IDoxPptxfmCMURcMc1imsBt
 uaqA==
X-Gm-Message-State: AOJu0Yx6RfBamKdV2lPUg0KVDy6NkWxwSeGT8aybK1cMjstLyEsPATEJ
 oBRUnxM3vdcyLpmsax0aIVzeWBGYjvzAjmeg7rPkw614FkZ4+K92QqM8WDcMJrvh+Qm43Mbi0EU
 NqquVXqICozWjCKFLnNxdyEw8Ig20+cwvZvPxEw==
X-Google-Smtp-Source: AGHT+IHCLiqGCISeZMT01rGEM/71e4++vS86rOi0LLfce9ZLQANut7Sh9KQhpbTLD/0ggAMA3C5qvZWpX0QNo5gA5Y8=
X-Received: by 2002:a05:6a21:9989:b0:1b8:807a:49c2 with SMTP id
 adf61e73a8af0-1bcbb655bd0mr9587908637.50.1718948942206; Thu, 20 Jun 2024
 22:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-11-sjg@chromium.org>
 <CAC_iWjKtOjR9evF81MhTVUKsn6OB5s=8O40+CZE-Y4+YfQO9GQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKtOjR9evF81MhTVUKsn6OB5s=8O40+CZE-Y4+YfQO9GQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Jun 2024 08:48:26 +0300
Message-ID: <CAC_iWj+uQ2z=SQpWhdZqVm02csoyFkeE-gXd7YWWS-MqYjxG1g@mail.gmail.com>
Subject: Re: [PATCH v3 10/18] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Sean Anderson <sean.anderson@seco.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Fri, 21 Jun 2024 at 08:32, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 21 Jun 2024 at 02:06, Simon Glass <sjg@chromium.org> wrote:
> >
> > It does not make sense to enable all SHA algorithms unless they are
> > needed. It bloats the code and in this case, causes chromebook_link to
> > fail to build. That board does use the TPM, but not with measured boot,
> > nor EFI.
> >
> > Since EFI_TCG2_PROTOCOL already selects these options, we just need to
> > add them to MEASURED_BOOT as well.
> >
> > Note that the original commit combines refactoring and new features,
> > which makes it hard to see what is going on.
> >
> > Fixes: 97707f12fda tpm: Support boot measurements
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v2)
>
> There was a discussion in the previous version, bout enabling these on
> CMD_TPM as they are required.

Or switch this to an imply instead so you can disable it ?

Regards
/Ilias
>
> Thanks
> /Ilias
> >
>
