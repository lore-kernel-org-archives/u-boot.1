Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CE0C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 18:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4CF82B2F;
	Fri, 11 Apr 2025 20:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MR8lDtFt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB9D84212; Fri, 11 Apr 2025 20:32:27 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3239882B30
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 20:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e61da95244so3999278a12.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744396344; x=1745001144; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2/yIwJNBIPKWLqelSTyQAggi9uif67lNWnJ8Kvz2RXY=;
 b=MR8lDtFtpjzWzidNYhfds55N+v1AHLlH7k9aAC08m/wpwmCq9KIVM40GL12Dg0O8fD
 xAVhlMu8QdXlXbjZDqdMZieXlhRYSc6u8a9b6yKF8AyvBEXo33wflORV2L7ptBS6HSnm
 eCAFWWkfHBiJRwbSs3ncE8JddlPkkUR2zXyu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744396344; x=1745001144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2/yIwJNBIPKWLqelSTyQAggi9uif67lNWnJ8Kvz2RXY=;
 b=YIh9ScIHJRx48bg3wAmaIY6FU9jPpJnH/wiVjkIPw9cj5SQjs9cSrlXIuO1+TqYHzI
 1MxKwZl0nzuz1mAZgqh6p7MVcvsZ4m+hmCyRzKRPslQaEjHiVb3z2ouGThqlwNu9Q6Sd
 dOrMIviiFud9T8SmTUkNs5QS/D7DuFN46q7qlcNTy29i8bJvnyhyQ4Ae3gsUNBHiRtWZ
 rQBkE0PF9KQ51iGusVVRdzNvXbsynpKK6PW/uYzgNnZfbAImOWA7NrvWG0hyCDpMRjhQ
 ay7+3kVfmoy+CQfGpfqBZGACpvyXdnC5fNn1caYHQE83Rusy826fo4xSiD0XUxvXKzYZ
 gNRA==
X-Gm-Message-State: AOJu0Yw9RvtwLL6K85u+xsh/KH20CyEpoYKuNrdfsBiIYi6EuL2pLmQk
 3KNZioDXoqtgGUZzEbr482w8L6GCT0nKdvxXL3yos7bx1M6F6CWGOmgm42ZoJMCFulJtUQ9m077
 fvnDBGjVrAauUcmzXyEz9aWfGVDITohBc9vlt
X-Gm-Gg: ASbGncuwHRzx8NJD2fXLLWAuFVLPk6MELoGMDftMTpUbAx7ytI8Et0qZtsuVMxMUfjN
 CLvGcb1ilO+p7usDV9RdWsKYhQ0+uRJ8j2guZC3N63pvgxrXtPefmhUPegsbRoqe1ajWLFgBOc/
 JXkFeE+dQSK5Y4XjjjM1YKytw=
X-Google-Smtp-Source: AGHT+IGQ1APagyAdJKXA+I23Ppn3dhCG2XwwwATT33UMa3HcpWHNSBP2P+Ma8tHTgVMiqHaMB2uqENIuOAqdxW0nNfU=
X-Received: by 2002:a17:907:3d91:b0:ac7:391b:e689 with SMTP id
 a640c23a62f3a-acad36da6b2mr358878666b.59.1744396344354; Fri, 11 Apr 2025
 11:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250411153040.1772000-1-jerome.forissier@linaro.org>
 <20250411153040.1772000-2-jerome.forissier@linaro.org>
In-Reply-To: <20250411153040.1772000-2-jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Apr 2025 12:32:12 -0600
X-Gm-Features: ATxdqUE9mVJD7vux2J8rZLULaoQSRV47TQZRwQBJqTdzmT8XhRFPNpo9xpWBRFg
Message-ID: <CAFLszThbA1fjziOrLFfRwFQ+aP=FZuF_M4cBYsnTZAqEMr8LTQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] efi_loader: make efi_exit_boot_services() call
 bootstage_report()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>
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

Hi Jerome,

On Fri, 11 Apr 2025 at 09:31, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> CONFIG_BOOTSTAGE_REPORT is currently supported in the bootm command
> only. Add support to the EFI boot.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>
>  lib/efi_loader/efi_boottime.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>

If you have time, could you take a look at unifying
announce_and_cleanup() with the duplicate code in EFI?

Regards,
Simon
