Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F80DFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0281E84658;
	Wed, 29 Apr 2026 16:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U7MbwmXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302498465C; Wed, 29 Apr 2026 16:12:31 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC36A8464E
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ba8472c1613so1848226966b.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777471948; cv=none;
 d=google.com; s=arc-20240605;
 b=KZBWL+GhSApYUWCXiJm0eTqKkqsRNwzB5Vn60MhVq3C5AT6DGWMInLSeGhQsh7xLS5
 dtHWbBUR3uOnrrO8PAB6+ljnVqqz4WM/bmuiLpTzuhSOAQZ5t1emWHFbmhQM0YGNU8Ca
 W1CAFZb5Wi2Ewy1/lfQSB+obtOHqPlbIDsxZtJse/ANQBnb1yFaHduIFmV01dIJY7U4+
 RNn0bM0MUiQoFFIG2RSy0/gt9EwF2n82qfuhmVCUL60ZirENiYNxTu9PiKKLTeqk1McD
 rDk+KSOtGcBg83VTw7z1fedlh5o73Uf+UeNRTNYCDYbseAV3V67QPdPfcfIoLBuGBSx+
 /K1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gHmq4dDPHFP4GSHP7ixL7EW8WCNudZUEsBztgBPmxwQ=;
 fh=OF00omt3W5XkTWoy8yz+VALjHs5aNJpNm30/GdQrL1I=;
 b=jDJMm5HJqoHcGDL6t5gCkTlI5CZUfnACTE9MWCzlDAXJwDhB5li4kL0k3z+NTKDDfv
 QXKMreaFqE7zt8U8oJE95cI2GzWUpqSGjz5oO6B7r9hKJTeclFfjrSQPEE3rJEi00QcR
 /OAfQmDUKo66IIkPHfTy02W39nlWy3wRSuY+NJKgc12ZUaa1xy21oFnldDmqRjUDanRh
 haClgAUNV5U/t7JzSSSuABYcpzlB7vJppj0eU2u7oDtOWvXmpyROWtiOxCCa7hqy07J/
 /pE+VxPkNUU7ogUECvC2ws7v/2xP9i29wXHu0CvdCEShcg51zQEdr9PLNOSkpK/B6HGN
 pnLw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777471948; x=1778076748; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gHmq4dDPHFP4GSHP7ixL7EW8WCNudZUEsBztgBPmxwQ=;
 b=U7MbwmXri5+IN8j6yq+/+CBP3CGLMzKG6pY3S3L8VPgYaRl3Mg8V1gpHqJ0yKRf/T+
 Hz1QGodrePDGRXWVUbws1OlY+PHxuaeCLXMVC7n/IuFZs8wJzoXYofeKV27G+05ocMCd
 JY2I19jKDypLsdna59wIVy9Tu6IGSPgTB2D5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471948; x=1778076748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHmq4dDPHFP4GSHP7ixL7EW8WCNudZUEsBztgBPmxwQ=;
 b=gDOLXQsNAAp1BOCTVjIdc3rqLhBSbw+tTvu5uZHVn/v0Cwa/k0wus2FTdmin07be9Y
 gGM9iTAM2lm7BSOaLUG3GGrtZRRRDJcplORv9HIF+KyEKE6OpY3Ar/xxU9Bm6K+ROKur
 Wx0LSX1Hk3Jno9NtC0ck2kgmXXVuFjvYGVGoyy71x0AuimXmO48RCmhnhsrtmux3X8TQ
 GjBZoxSAvKyPnqvX2G87owUebUhYK4db9LbYRvO1YE/sl110s3WnNsz8m0oVenlmNi+h
 +Dh0Fz3BuKVvt1Qhv9jhSXJ0zOl5/Zr6/1d1fpTlnuCcUUgCqWSYNpCWVse7n/IutsQu
 gKVQ==
X-Gm-Message-State: AOJu0YyJWEB8bHln0Mhq9x7pYw4FJrXJqrNs2wOGafwyJDZiT3N2mu92
 dxvdGNRa1rcq+CLGPifqJfsbaa8FnSyaU8suuvfLNKfF8642ymQaOjmNI+af44pmS/qdYckpu8C
 gRL2didNmsny0X1QW6/iINmSfmFBYOA9gFPHQVSa6
X-Gm-Gg: AeBDieuf6HAZ1Bf23aC+5qXqqW3NbVjjqDYf2hsvZ32h9p5739iGiVReoM1lpswE0QH
 R8bFC1liSpuradFzW/R7U70YZZ68QX5V3Bi6HVxSsiqsZxMwdcHqQa8TqBbONfxSDv8ubBtWQUA
 4n+qa8dWmt8+1DcRQPnSJ+9et7H2tIjPubkREe+acQbyLI2RmrxCwzQmKREFgsgTPB2Jnl66vtV
 vZowPHszPelUg3lPJSbDO/3PVhTMtkN5S7h9lVTgTv5uAilAgHxfIAAB1f1GTY3OOYkxHP+nfpI
 ZG2w9uORs9h0pA70
X-Received: by 2002:a17:906:f58b:b0:ba5:4bb3:38f9 with SMTP id
 a640c23a62f3a-bb803974a01mr501770866b.27.1777471948206; Wed, 29 Apr 2026
 07:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <f72f15d154edaa839492c211821b5433610fbb82.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <f72f15d154edaa839492c211821b5433610fbb82.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:12:14 -0600
X-Gm-Features: AVHnY4JXSbs51NS_YWCzqiknLj6G002AXK4I8g2UtjwYxdt8elLQTxOFP7TG2Hg
Message-ID: <CAFLszThgn0zN66oRAkmTtaEDcSNdy_m40YW1Vrb-LXHAODLv7w@mail.gmail.com>
Subject: Re: [PATCH v5 10/15] mach-sc5xx: Update SPI bootargs for ubifs
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Update SPI bootargs for ubifs
>
> Update the bootargs used in SPI/OSPI bootmode
> to reflect change from jffs to ubifs for the
> SPI's filesystem, and remove the jffs2file variable
> from the environment as it is now unused.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezlite/sc573-ezlite.env         | 1 -
>  board/adi/sc584-ezkit/sc584-ezkit.env           | 1 -
>  board/adi/sc589-ezkit/sc589-ezkit.env           | 1 -
>  board/adi/sc589-mini/sc589-mini.env             | 1 -
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 1 -
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 1 -
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 1 -
>  board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 1 -
>  include/env/adi/adi_boot.env                    | 5 ++---
>  9 files changed, 2 insertions(+), 11 deletions(-)

> commit c83fc4349c728f61e5f4e77913a401bf70e97ae1

>
>     mach-sc5xx: Update SPI bootargs for ubifs
>
>     Update the bootargs used in SPI/OSPI bootmode
>     to reflect change from jffs to ubifs for the
>     SPI's filesystem, and remove the jffs2file variable
>     from the environment as it is now unused.

nit: should say "from jffs2 to ubifs"

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
