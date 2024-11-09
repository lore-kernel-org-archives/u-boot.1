Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB12D64099
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 00:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF0388860B;
	Sat,  9 Nov 2024 01:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mqBljs3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF0F892E8; Sat,  9 Nov 2024 01:33:22 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0209288486
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 01:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so2313791a91.0
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 16:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731112398; x=1731717198; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oKs6h26QxFNIwfkk0MhzjdQ8Mkl/l93j3ZF8BxR98mI=;
 b=mqBljs3xzgcWYhl0/xljL5r2ZbhwaGS7TflKkUO5edrmrbd6aXh4WGWJ0t8CXmW8nE
 rLr6MNvYh1XpR/K1/zDBEBulvhspck9Dcg1MJaAeEOxOmorcua8rR4FryykXHqvGmbjP
 g1ixb+PZUMjvo/vEdpRFdqcNmrlLGeSxHTkm0nXRn24O/B3YrFkAupday0r1kEKNfNQ/
 mzhiCrWqCL6kQGV21omwHedw5rbXvuMLsxB5AOgboFw/4Y/8BSw8vha0QEUzAEcBxxP9
 aKMCOloLZ730nd5ZitpY0+8VA98l6r+Z0diSYaejmP0pamgDq12PhRoZNv7PovjuNqFg
 SG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731112398; x=1731717198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oKs6h26QxFNIwfkk0MhzjdQ8Mkl/l93j3ZF8BxR98mI=;
 b=t9UHuR/EcqtGhCur8YwWHbNHOSl9mu8MmhzyMSg7xdHFz9rOHYTFY4BXdM8fo7m6L9
 BncHqoEtYlamgWgwnlA7wus/HJF1/iL43vKXuz3ndJiEOymLM3/D2wvf7AKUrYSw/bLd
 QHFghnIa3TPWuqC7taDscATnl5AQhwS6waSyMqRLzkLkI9MPHo2IVOspf3uv2LvAUSPl
 otQE6BhMs9J3n7inOit9bZw6yMdVGwJTi9adlmPN6yUGklZg1ZrxEMO9JcvjMVm/1ZPM
 oGvfgJj19hMtCHT4Q0yYSgurdVsObjnQGy0vDyAkw2iWlrbe+/weBp8DjtyIL31Ix9LB
 71/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA1/Qtw7ebKy+JQVQzPtkC60/1T03SpUX3t13DUiyr+CMQDFNkRGFyBeRUNK4qafNAw5xZC2g=@lists.denx.de
X-Gm-Message-State: AOJu0YwUZWYE+7IZd/mvyVJ0Jt4Q+D9PjT60gVKYTIT87GUDcXLRsfAY
 odjkYXiix2t6jXZs9AWmk8aN/IIUVhCOTexVRORUHP40F5JPCpMSN1Td+6N0PrmZ/BhtCh9R9LG
 Aqq1M5VZjc/45Esxu8HcRnfcz/zZt4da3dDHb5qmQxmFlPKHOxGE3WA==
X-Google-Smtp-Source: AGHT+IGoZMJ+CZQ/sAcE6pi8Cqs0k46p4EpQhHsMI8dWs+qHY7tnBX6bWJf5QxP+wF8gcDxSM/ZvHWQz290MT02OkK4=
X-Received: by 2002:a17:90b:1e0d:b0:2e3:b168:70f5 with SMTP id
 98e67ed59e1d1-2e9b172afecmr6972004a91.21.1731112398539; Fri, 08 Nov 2024
 16:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20241108174526.16390-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241108174526.16390-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 9 Nov 2024 00:32:42 +0000
Message-ID: <CAC_iWjLyFArsDTfNgrj54ddoXV9PZyvM+9xEjjmacaxQpBtvzg@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: lwip/wget: correct SERVER_NAME_SIZE
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
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

On Fri, 8 Nov 2024 at 19:45, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The maximum length of a domain name is 253 as defined in RFC 1035.
> So SERVER_NAME_SIZE should be 254 including NUL.
>
> Fixes: 3c656c928bd7 ("net: lwip: add wget command")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  net/lwip/wget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index b495ebd1aa9..a66b14d1161 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -12,7 +12,7 @@
>  #include <net.h>
>  #include <time.h>
>
> -#define SERVER_NAME_SIZE 200
> +#define SERVER_NAME_SIZE 254
>  #define HTTP_PORT_DEFAULT 80
>  #define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
>
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
