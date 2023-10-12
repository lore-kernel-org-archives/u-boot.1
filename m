Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE499CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FA3C86EDE;
	Thu, 12 Oct 2023 05:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q5JsCBIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 856BB86EBF; Thu, 12 Oct 2023 05:45:00 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A786186E8C
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a2536adaf3so7538607b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082286; x=1697687086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=irR+wUcZMecBBuQj3nEUNNDKREuFzidtQ31Stq9iBkM=;
 b=Q5JsCBIy0mAw3BFvRtDBl8bLQXDr6R5wrJl0vRoCefSUhlnFDN5INz/6Ymv6bceHfj
 ppO3PI3cNkuzZor0XaJSUWVrmYSR3DjxG4ZTQbPa5qY8slhLJoKDuxwYX9JBS4Ua8KkE
 zj+4BZcCASeHJpcIoq/bUWTKYdwiz/j9BsS3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082286; x=1697687086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=irR+wUcZMecBBuQj3nEUNNDKREuFzidtQ31Stq9iBkM=;
 b=F/rrciOA21p7g1Z5n3VYh8p+GrOmsuJ6Ucwi87CL3DZdlmctW8e4e1wDDjpRsFFYxy
 eJgn+kkf/EBxRestbDYmapZTmFGxEMSs3oTS1dytSRuH1EA35wfHP/HpP3hL0A2dTP0e
 8HhShCWW6IQSi0+ebzPSsTUyj0yaHVBNrJZhb9CS/1ETsWZz7DGFmfOK3vXJq95qGkiG
 YckHwLrOW3ICleeV4c64HuS5wiVBp7pyY92c+wvjUk3mdMXZ6HJCzrlhNJHyL1WWrEkE
 Hw/FaEG3jgjan5zaVXLZc2WUTEntPdw3ML2//qYDHWcb6MG4q2j7a9CSedxkQDAo0fWa
 zeCA==
X-Gm-Message-State: AOJu0Yz83NaFhCf9HGd81rwOnRvFFxjj6mshEMa70ZZ+LYsWH+f0LHrz
 OaQFYDspTrW1MZtnRXXk45Rc+HT1O8EXRV1tc/+tHQ==
X-Google-Smtp-Source: AGHT+IG8dMdqq0bU4xNWuYQv+ip7Faxz6S4atgNiDz6VLYwSfeOnW1bwn5p73lhFLMTetcCRZqHlNYRiPIyIPcU2QqQ=
X-Received: by 2002:a0d:d183:0:b0:59b:5170:a0f3 with SMTP id
 t125-20020a0dd183000000b0059b5170a0f3mr26582960ywd.36.1697082285972; Wed, 11
 Oct 2023 20:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-15-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-15-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:08 -0700
Message-ID: <CAPnjgZ27NXN1Z_tTRtpaqBWs4SjCp+9Y-GjpS4CcK60-L-pyqQ@mail.gmail.com>
Subject: Re: [PATCH 14/26] net: bootp: Move port numbers to header
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> These defines are useful when testing bootp.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  net/bootp.c | 3 ---
>  net/bootp.h | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
