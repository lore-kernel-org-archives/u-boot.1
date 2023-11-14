Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EA3C52CDB
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 23:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD5187253;
	Wed, 15 Nov 2023 00:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="idA7bXgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FA4F87232; Wed, 15 Nov 2023 00:31:29 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D0B87208
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 00:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9de7a43bd1aso877222266b.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 15:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700004615; x=1700609415; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0+Lo0vT4X6wkZn9W/sak2B9qoOUhh0HQkxBUludQcos=;
 b=idA7bXgv03ueFBpit/fO7wPcxLGMYjBghvsOfoFkwI6WaCysuEq8mOP4gm1xkgp/nn
 L2GvPU2KPQFMycoSrn6iqiVi0AK1zir1yvgaSleTmgoyH9KjGweEUbfjhGCthwztzHWp
 hBRX35lwrMjTwgxVXD4ZK1T3nRDBsXbv9GYjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700004615; x=1700609415;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0+Lo0vT4X6wkZn9W/sak2B9qoOUhh0HQkxBUludQcos=;
 b=Dp+iNWHfEWr1NDOdnQQFdqDMWNCtT3/jAciQsBIqUQrSEJmNiFVpCF7K/5y0LmRsVU
 8kUpqFHvxO1i+nOyWv4tGHM6/bcN5Db3DUzy79mCWjFfjr7SrUqwb+J/WIOubZuRoEzw
 NZaBdcxqkCRE3swSeMk/t/rewcvRaa19P2ZzOwv/LOzIVcY/LIFJirpIGTA8w9BwnWxg
 VHx4QR/hh/I5B6jEokllte8Fo0R4mkFs0/IkKuKE0rnVbBjZNbdby57glLmdz6ugz0GF
 Ik2D1JDLmRaX4LsOH8bWDxIkEIL6SsxjIKa3qFqwHIM/2ScUIw05t3jG+WEIP44QK25m
 FiPg==
X-Gm-Message-State: AOJu0Yx+3k8HMp+NeMpgRvIIMOLNWAnOuNKhzAyiqpPpU4QAZVq8RCxZ
 IfNcTmdKsIcho9fBEONox8lMWbYR8JyFpqX9ig7up3acoxxNWZtAO90=
X-Google-Smtp-Source: AGHT+IHyVbAmtp6jNoZuqbDQ9cd0WqQa0YtzJEtz2MpXnJo1KstCkRTSB3B0cyUX/7eud6bSpnAx6pK1OnvOnDRq8fY=
X-Received: by 2002:a17:906:5fc4:b0:9c1:9b3a:4cd1 with SMTP id
 k4-20020a1709065fc400b009c19b3a4cd1mr7596247ejv.3.1700004614990; Tue, 14 Nov
 2023 15:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20231114113017.999079-1-jkeeping@inmusicbrands.com>
In-Reply-To: <20231114113017.999079-1-jkeeping@inmusicbrands.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Nov 2023 16:30:01 -0700
Message-ID: <CAPnjgZ2YjYbvq+eNoMy1Y9vtRh-HxHRKtmRCJc4zZDWhPG1HeQ@mail.gmail.com>
Subject: Re: [PATCH] spl: fix TPL_SYS_MALLOC_F description
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: u-boot@lists.denx.de
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

On Tue, 14 Nov 2023 at 04:30, John Keeping <jkeeping@inmusicbrands.com> wrote:
>
> This config option enables the malloc() pool in TPL not the SPL.  Fix
> the description to accurately reflect this.
>
> Fixes: fd8497dae54 (spl: Create proper symbols for enabling the malloc() pool)
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
> ---
>  Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
