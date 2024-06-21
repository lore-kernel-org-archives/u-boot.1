Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DD0C2BA18
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 02:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 773EB87F8B;
	Fri, 21 Jun 2024 04:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="icGNklyc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A7787F13; Fri, 21 Jun 2024 04:37:25 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6C187F13
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 04:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-632843cff4fso14705247b3.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 19:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718937442; x=1719542242; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNPIBrmrmjiwDCo7qbWcC2mGBYA/2bj3JQjiGaM6f9E=;
 b=icGNklycS73hBaj8F2oTIwRsEum6I6cJS7ThDg12qgHTeXBCdZRsWP6H3tLnrDk0ss
 F1FqRYFJ5g89u0yxEwis7rOt+FbFQRV5qnlnSkdWlHqYtDVHPohcRJXEaEsmSTOqqx/U
 89k3UYVYlYtJCMsf+WNz2H7ldKHsDpiVL4zuvFyZbFWXHPI08IGJvzBMYJ9Crr9EnxQZ
 MEDZvZ/5VSAxVH9jQOpOPAe8rKn1lOtN8VoEtI2v2oWpjWODcSFbPMwut36R5hJJUk+Z
 DWIu8acewWGmLEcybU0p6LHPkBcdB9bm4THmWZbK3x7JlAehjDczZ1qKyGpBsOPHCGNS
 31RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718937442; x=1719542242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNPIBrmrmjiwDCo7qbWcC2mGBYA/2bj3JQjiGaM6f9E=;
 b=tucKx/DPB8qYPs91QmxLdNtnuwNAJjCOntam3o1gpSeqyToIpkByQLNN4vDpUFwc9z
 SHWxRqt/yRhpXjHVelTqncUClaypQldXlZVp2v7b+xidROJ4Eetx1L2eHnYuKnUsB9KZ
 f1a8pqW9wFSfTzdsNhRSSdKf4ctiVQWf5RgSdagI7i7+T8NwbU1coIOvAbHCDBOha0mh
 UYV9ziqkRxJnbfbP1yVZO/qwZtNS03WBss/K66RQyy3uYgH1pF8g6S0WQz75dl8sgREd
 1ObnPwAlXjM4P431ldTqr9dsfDtB4SWyDHuJBd7ShDHpHAPXU9qq10htoa3fgWYdSGL4
 ttBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpsJKI6spU1Yyf5pqGgbNO8NPKqq4kUi2L4drXXo/QMx+9dNNR7nHrVmVwnl2Ozzz4ILzIAVebLwDgERb4OYe/zmnN+g==
X-Gm-Message-State: AOJu0YxnHn8WcVNNSrIQ2lQdZkBPCLF64kb+6SKR3NkzfwzicIzjLKY1
 xVt5SpzuDQPQQM6QCz25kBOKSzeX4exIeciMT3CEsCA1UcacFCGomQyZ90MVS3cu7qhHOCf7MBE
 jTa1ehOQBxJYjRx/vNyZNMf+73NEM2O7pI6aM559AmhZAL1F0
X-Google-Smtp-Source: AGHT+IHEvplNNJvFNFggG54TI5r87UvrFaNf8joRf2F2xe1rmnyXdgEDr7bEI0RwmWQ+LzdmXLunPCzz4RtUXIBr6WE=
X-Received: by 2002:a81:c907:0:b0:61a:ed1e:ecd with SMTP id
 00721157ae682-63a8fed3ac5mr64654997b3.50.1718937441990; Thu, 20 Jun 2024
 19:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240621015135.1570605-1-caleb.connolly@linaro.org>
In-Reply-To: <20240621015135.1570605-1-caleb.connolly@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 20 Jun 2024 21:37:11 -0500
Message-ID: <CAPLW+4=ZJyt0OzXvoJt1FM-qLFVX4kww1SX87_DLsZ2vft1CiQ@mail.gmail.com>
Subject: Re: [PATCH] include/fastboot.h: add missing types.h include
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Alexey Romanov <avromanov@salutedevices.com>, Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jun 20, 2024 at 8:51=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
> Fixes a compile error when building with only the TCP fastboot implementa=
tion.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  include/fastboot.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/fastboot.h b/include/fastboot.h
> index 2ca1b907a54d..b106d6177493 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -11,8 +11,10 @@
>   */
>  #ifndef _FASTBOOT_H_
>  #define _FASTBOOT_H_
>
> +#include <linux/types.h>
> +
>  #define FASTBOOT_VERSION       "0.4"
>
>  /*
>   * Signals u-boot fastboot code to send multiple responses by
> --
> 2.45.0
>
