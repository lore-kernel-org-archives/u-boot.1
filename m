Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A23E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A072D895B6;
	Sun,  8 Dec 2024 16:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DUNE4K1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23416894B7; Sun,  8 Dec 2024 16:29:33 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3627289606
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa650ccbe0eso199993366b.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671769; x=1734276569; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nUQ5ulqkXaCokR4mawud1k+StXgYh+CdqIg3oOKaup0=;
 b=DUNE4K1eajMdPE3KyuaGfWS2FCKGKU11D0Ymnd5kTply6ay5lp+5FOAfqkuY0QiS5J
 6D62LjekLw6qES5O4SnJ1iqrj5/+5XCfjjEygZcdJvL6TVEPmhmOf31C0RN6GNpXKDdq
 9dJItOWbLYtqyZLRKNmplZ182Z33XSWuxnuCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671769; x=1734276569;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nUQ5ulqkXaCokR4mawud1k+StXgYh+CdqIg3oOKaup0=;
 b=nPJeL29u9prAMdUzK4oeSCRxpC6KmtApLTpL0iht6RQrNZTFwuVCEJb0EVooekRATK
 W3VXfHLe0+UG+ZBaOVQw3IJ9Ti1vvYktLbVuqOOqHqVF1cXK8UtCeqyOEtLjtv1FXLPb
 TfKkJFekBI6ogNO5vSbXcLaXpNCnXnHwZABCif5RqI4cMb51IiyJNG2hNwNYoBlfJgjo
 uKieYCqBzYMGJ5WjMZFxGT8NqXLZz9FVMXikRE6km1Fe1BJVDgXeq2k2T48CVHsjzgKQ
 6EO62UUqQmfAm9CdFXoJ672k+btSj3PxhzRmoXnKRHHvvMuDSYezPRrYWSFQrwTeuE8s
 UGfQ==
X-Gm-Message-State: AOJu0YzMKfkoJcEt1AVYCfJnzcMTuCffPgEhGZv+Bnc5EYttL7hpXG/2
 jjCP/VXcHwmeh6NGbdjMxLjIAgHm2cmCHRamtZU/opRXd8Ri+ZdwrF3IL2d4ljyJnb2eeLQcyS8
 paINF91NeUErf0o/t06KfuaCtMCrX5x/i40Aq
X-Gm-Gg: ASbGncthANSsThI3Ajm8fpfpG4UmHd8Ph119qe6+YWD9chPkiWc/yL+Xu969icRunWZ
 egHH0UlCLGq4kGRRoLHY8S3QyaVRfk4Cp
X-Google-Smtp-Source: AGHT+IEFgFqn52LMJYZ5/9V2rrUS6FeifAZ5y+9XdvKXdOBs4mD81aAwdXLh9z1uvJ5xZuHcfFhbtUBv1Foz381LNVc=
X-Received: by 2002:a17:907:7814:b0:aa6:19f3:d083 with SMTP id
 a640c23a62f3a-aa63a07357dmr927006866b.30.1733671768789; Sun, 08 Dec 2024
 07:29:28 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Dec 2024 09:29:27 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTge=ZUqn6WbC-ys-qfrc+8=0pJyJTMKCsrLC4ZzMQ62Hw@mail.gmail.com>
References: <CAFLszTge=ZUqn6WbC-ys-qfrc+8=0pJyJTMKCsrLC4ZzMQ62Hw@mail.gmail.com>
 <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-5-mjg59@srcf.ucam.org>
Date: Sun, 8 Dec 2024 09:29:27 -0600
X-Google-Sender-Auth: owPU29PbF3gOd-nL29NKQc4Z4o8
Message-ID: <CAFLszTgD6cN=scO9ZB+EM8y156k_fmQ5+3sCk4V0spu3aKH2Ow@mail.gmail.com>
Subject: Re: [PATCH 04/10] Hook up EFI env variable support in the EFI app
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>
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

Hi Matthew,

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> Add simple support for accessing EFI variables when in EFI app mode
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  cmd/Kconfig        |  2 +-
>  lib/efi/Makefile   |  2 +-
>  lib/efi/efi_app.c  |  5 +++++
>  lib/efi/efi_vars.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 51 insertions(+), 2 deletions(-)
>  create mode 100644 lib/efi/efi_vars.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Again this needs doc/ and test/env

Regards,
Simon

Applied to ci/master, thanks!
