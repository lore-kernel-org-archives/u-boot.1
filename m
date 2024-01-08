Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397ECC47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65FA87AD4;
	Mon,  8 Jan 2024 01:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uf9GkKDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 481C987AC9; Mon,  8 Jan 2024 01:16:40 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6015A87ABC
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6806914dba7so14164986d6.2
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672993; x=1705277793; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oDf30Gy1NMw7fdxB/81xlG7hgH5/8C/jYDQ8ek61MMg=;
 b=Uf9GkKDAfrJGqSQM+3zZh9IkuZz7FcHeTGdY4ZsTokneaPxCe0Awstr1i3RhvYc1RO
 PkB/G8o3HS7nHyd0B0apSe98fvfHL2mdcWOkVsQP5wQF74501L/lDnHV6Wr+rdWkWYDT
 t3suoLUeNzvmZVGM7kIVTbS0pCXxJ+gDbAWaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672993; x=1705277793;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oDf30Gy1NMw7fdxB/81xlG7hgH5/8C/jYDQ8ek61MMg=;
 b=D7MFMZZDVyyxnPKSZwFCAlf2cgniugh9hZ25vqJURu/QYLQbKkpnvewf4ipkdR8z2l
 FB4zqKpAx3zDzIHMEf9ULpE2rJ00qU3GY36JMYBriD2kDjQjI+WK6aHOVTDMJHeWWmMU
 UM9QYDP3qUTIIgymL8N3NQkl+MKQEnA1+8zOBzJs3GwomgqxH8deXcAFeysqIWyG3GNe
 HevA3GEdz0poyf65POlosf/2NcHEF1SYwhiArAhHiNk7wPvamOg27ZUKZBQcicODdtOh
 JF/b0Q88Mi3srZrEu6JjcUAhSMNRSiD2YTSlIKv9fJ1bSs+Wd9fDO5NbkvJCWbznp/6q
 VzYQ==
X-Gm-Message-State: AOJu0YyvkLSrufYvVtrmpk4Y8Y6081WuKr3DUibO7sHvyVmIMN+mZ3Op
 vHybAJrjuEGfS1kYWXs1dztofsQmw/JfLezpeylEqtaWGlBk
X-Google-Smtp-Source: AGHT+IFaukLz9a41VMJgXfO7Apl7BOuTXoMzbjPacW1YxciFwfPntqaC5K1JxGBZ8qNGw1tI/RvrLIwV+leGj3W6gLc=
X-Received: by 2002:a05:6214:3004:b0:680:b6ec:ee4f with SMTP id
 ke4-20020a056214300400b00680b6ecee4fmr3595533qvb.16.1704672993644; Sun, 07
 Jan 2024 16:16:33 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:33 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2mD=+sgLPFCL6Vm1z7CP65JkEkKxvgxacS5y-qSsr9Aw@mail.gmail.com>
References: <CAPnjgZ2mD=+sgLPFCL6Vm1z7CP65JkEkKxvgxacS5y-qSsr9Aw@mail.gmail.com>
 <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
 <20231216081200.7677-4-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:33 -0600
X-Google-Sender-Auth: eeMD5hsEp85WI-h3-P5BrPHiWuk
Message-ID: <CAFLszTgxBqW9QU6SXpcka_Vw4LwV1VNm1URK=OG4+6dcqOwoRA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cmd: acpi: check HW reduced flag in acpi list
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

Applied to u-boot-dm/next, thanks!
