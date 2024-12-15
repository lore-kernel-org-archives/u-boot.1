Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9A2E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 09:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 355FF8006C;
	Sun, 15 Dec 2024 10:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gXyliI9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283138006C; Sun, 15 Dec 2024 10:21:17 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E225B8005B
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 10:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6eff0f3306fso22947917b3.2
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 01:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734254474; x=1734859274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rBpdmixOveupdNgsYmbjY6MsTVVO5rfy6VD95QlUB7U=;
 b=gXyliI9+0gneB72/H9FPMTQNK5+8LuqzHk+/tH9yLBbJKOVbzHsDDaSMqfgPC5fPsP
 X/hULqcFzFzOdcBywzW3DRxY1eIvs5AChfeL/NYBXwWLU1CImh1pJaioTZQ3vRpkpNZf
 Z2MKmLwy9BadqBuOhavRKzLhrfTv/WSRMAIhLw/V/af9HMwEsdg7BKJfUKoW0qVpZH0R
 lN4+4qt+rjjzbufL5DvE/QbImF6oNpyq3m9dvdGDsk9uOKe18xfVvo4NIe3T0vE2rkeT
 vwlhciOj1+CVoxJ6TSkNf3PTv2qE6JuYLxoXkF2cosOo1JfdqVjRq4IY0AKsS2tiPWo8
 ZrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734254474; x=1734859274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rBpdmixOveupdNgsYmbjY6MsTVVO5rfy6VD95QlUB7U=;
 b=HDDvIsRfBys3XxIs7Kx1JX6Kk+DgdN44emXsmFQA33Nt9Djj8YP1mWW8M0xZx5FCdP
 L+sIJ5v3S8GuZDxrILVGOAx5G1g4I5nseXT0cwEW+vtU1NEB4WJQR//ZASOC2+Zn8JBX
 PqHqMEJ43FvBwBMo6H+X7ojRu2gk5dLlBgOZJ5DhBHouDwODSNUBOf8xcKRDzZEyTXET
 1RW3kVVanT6eiAFMcQkz6xPkYyLtMf1DArB6veIWiKkxSAiKfRHCP0T/3wkUybuGTGrm
 1vru8YCxsf6jqyy4inosAFYtkgPAH3UDPPBN2zDUQgTctiGKhFGsLlyc8xX4toPv9j4b
 jABg==
X-Gm-Message-State: AOJu0YyX9WdFA+rg87NV0+1QZkpmKZR0celqUUvfBVXE5B7ozM5UyFFB
 MBncudEFPbgUAsi2OsDiAxZKaqMKwk4zQJloREwSiN3FVvV7h/53sV04dAVbEYvqCPiNvkia9me
 EOMYxUPfcXn/2ikAv9zMu5VnveqSgDbj1opa83/BcyhtVBIArr18=
X-Gm-Gg: ASbGnctB9tqZiKcHILzCLZtfTGR0+7UQZuFdbqa69lYb+dPq4LtpeAHd9UOREllinUt
 0uM80/bpLvgQcblDrKzjo9DM1Gk1EL/0XLMlnww==
X-Google-Smtp-Source: AGHT+IEAt/2ji/2ZmBGO2f5s7PPEGqchR7/9r/ep138e/rAMnIlfCore3bqkKz/5+RnqB4QfRUojeu7j9dS5v1YUdoQ=
X-Received: by 2002:a05:690c:64c6:b0:6ef:aae1:ac6f with SMTP id
 00721157ae682-6f279ae3757mr79815187b3.3.1734254473764; Sun, 15 Dec 2024
 01:21:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1734093566.git.jerome.forissier@linaro.org>
 <1833d3884f623ef66b81443be87b773b1e896498.1734093566.git.jerome.forissier@linaro.org>
In-Reply-To: <1833d3884f623ef66b81443be87b773b1e896498.1734093566.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 15 Dec 2024 11:20:38 +0200
Message-ID: <CAC_iWjKM3sgZMXSf+AXsSiW7tDC26hBJba4_8io=JSgXsrhP3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] trace: document 'trace wipe'
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On Fri, 13 Dec 2024 at 14:46, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add documentation for the 'trace wipe' command.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  doc/develop/trace.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/doc/develop/trace.rst b/doc/develop/trace.rst
> index 546862020b1..d3c8628d124 100644
> --- a/doc/develop/trace.rst
> +++ b/doc/develop/trace.rst
> @@ -163,6 +163,17 @@ you will see the time taken by each function shown against its exit record.
>                u-boot-1     [000]     3.116466: funcgraph_entry:        0.063 us   |        memset();
>                u-boot-1     [000]     3.116539: funcgraph_exit:         0.143 us   |        }
>
> +The `trace wipe` command may be used to clear the trace buffer. It leaves
> +tracing in its current enable state. This command is convenient when tracing a
> +single command, for example:
> +
> +.. code-block:: console
> +
> +   => trace pause; trace wipe
> +   => trace resume; dhcp; trace pause
> +   => trace stats
> +   ...
> +
>  Flame graph
>  -----------
>
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
