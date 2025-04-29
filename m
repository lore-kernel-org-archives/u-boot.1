Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2ADC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 10:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F13C680BAD;
	Tue, 29 Apr 2025 12:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B4ydDGnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB78A80F03; Tue, 29 Apr 2025 12:10:53 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95047809A5
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 12:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6ff4faf858cso40540857b3.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745921450; x=1746526250; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vHOd6FueeE70puXFH/29o+joy3AcHhGF4KXApi0DxQI=;
 b=B4ydDGnSuKRH+h5oZa6Pq9ihg3q9gcYBRSouKKy9REWRW9MwjQIdQM4BQ9gZea29Pz
 onqedbYnsMyo/NXp5KDNFxILgFRdJ+T2sKwWnX6XRr8mXTJZn4xQslIfaAnw4bjT4k9B
 E3/saes7aqJUJ/IBs7tAnsoDH8P96VieiM2AInizaBVCC1sHcUC19L8P2y243qTSNxbe
 5nws5/S+fI97WTsL26LOy0QjbM2KExGmWHT5J90bQiJiwg9HHpLj6A2144JM4bq0QJnh
 2NqpimMEE9pB/TK+6eExBEjLExNWNPt2BQRFoFd8TFykJkJIp9ybFbOpRLSJeHoLn5NX
 zbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745921450; x=1746526250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vHOd6FueeE70puXFH/29o+joy3AcHhGF4KXApi0DxQI=;
 b=lDOEYBjJU9feOUSBFgF/KmS2mie9Do9HiRtsO6BOdE2Mkf9YNea2xktbhTwqGg1Qq1
 5Q/ChgIYXXAbQosyxj3/AoeUD9gTcDkvlB1hRDkzLTdVdAcg1GqMIizs127rh42Twl7T
 FpPyUUkQ+pdeVzMZTkfE8FmCkwF4UghO3mkwbhn8mIACNVflF3Tq4nnvZpY3PoFDXbxB
 mkUXTkpinodzOXQ146vZHB9Ydzem9aMhTWdoeLcPtAR0+X9yPRMOkdzEyMXOXMGIzNBd
 /fhHmkqf227aU9djkA2GahDmyB/Aow2N5IXOBHgFUYVMmc6Ku57eWy0jAGkzKzIwdaaV
 tgEg==
X-Gm-Message-State: AOJu0YykqK2s9zUP1Twz8fcJHxQtbN5/01AWuNMmBYDrorgMtp3MS4vi
 c3PmLzfhiTTduX3/gRC0czXAcNmxH/qWfr+Vi3F3ST51L9zr3llFiiOKntS19p4dnA/dDOb6GpI
 kT4m17abMg7DJ1RAGShdUX8EbO0hvSex+0tD5dPTEF8xZLmvglbs=
X-Gm-Gg: ASbGnctRt/t65Sc+kzZlS6RKp3FXNr1N+cQZDHXHrxwaqrpYbhcR6mpKGoXsS285XmF
 irbUUQwccMl2KI6qVX4DSNrRklVA2caTa6SdUwtl6Lb5xeRM+/jhu9i49mZr2zIe4BSPplSqtCZ
 KU9VpHixfJKK+IXkBaXp0xF8s=
X-Google-Smtp-Source: AGHT+IGk/88jS3Oj2EHqCTtLjto7muKtJbnihI7z7hZICq9ZwIRHIKwKfXySCsRR2ktr7l5caKq7pnzH7ZUUjk7c1YI=
X-Received: by 2002:a05:690c:4507:b0:703:b278:db30 with SMTP id
 00721157ae682-7089963d783mr39908647b3.4.1745921450452; Tue, 29 Apr 2025
 03:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250429095747.3867260-1-jerome.forissier@linaro.org>
In-Reply-To: <20250429095747.3867260-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Apr 2025 13:10:14 +0300
X-Gm-Features: ATxdqUERs6ncOQ1Yv72tT4FEBN9_sOIy1Q_nMF6I8FmRK0NPzEwI671nc5ohAsw
Message-ID: <CAC_iWj+DYuUjKT0-ypY-N0pAxueJrsmuOjTSJ1pNVb8_DYXfgg@mail.gmail.com>
Subject: Re: [PATCH] uthread: doc: fix inline documentation
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Tue, 29 Apr 2025 at 12:58, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Fix Sphinx warnings:
>
>  $ make htmldocs
>  [...]
>  ./include/uthread.h:56: warning: cannot understand function prototype: 'enum uthread_mutex_state '
>  ./include/uthread.h:64: warning: cannot understand function prototype: 'struct uthread_mutex '
>  ./include/uthread.h:56: warning: cannot understand function prototype: 'enum uthread_mutex_state '
>  ./include/uthread.h:64: warning: cannot understand function prototype: 'struct uthread_mutex '
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reported-by: Tom Rini <trini@konsulko.com>
> ---
>
>  include/uthread.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/uthread.h b/include/uthread.h
> index 89fa552a6f6..11a19aa9488 100644
> --- a/include/uthread.h
> +++ b/include/uthread.h
> @@ -51,7 +51,10 @@ struct uthread {
>  };
>
>  /**
> - * Internal state of a struct uthread_mutex
> + * enum uthread_mutex_state - internal state of a struct uthread_mutex
> + *
> + * @UTHREAD_MUTEX_UNLOCKED: mutex has no owner
> + * @UTHREAD_MUTEX_LOCKED: mutex has one owner
>   */
>  enum uthread_mutex_state {
>         UTHREAD_MUTEX_UNLOCKED = 0,
> @@ -59,7 +62,9 @@ enum uthread_mutex_state {
>  };
>
>  /**
> - * Uthread mutex
> + * struct uthread_mutex - a mutex object
> + *
> + * @state: the internal state of the mutex
>   */
>  struct uthread_mutex {
>         enum uthread_mutex_state state;
> --
> 2.43.0
>
> base-commit: b249e08ec9b71f9d0b4eb48e3e63f63e8366b7e6
> branch: uthread-doc-fix

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
