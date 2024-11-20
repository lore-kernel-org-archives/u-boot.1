Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EA3D63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D85C789353;
	Wed, 20 Nov 2024 14:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AitG5ECx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB8A895F3; Wed, 20 Nov 2024 14:48:24 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BD61892B8
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa1e51ce601so800327966b.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110501; x=1732715301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BjwyZcteXigfik52kHZmjoul2LiqTeQVPSdJ1i2JhzU=;
 b=AitG5ECxb6quaGxB+2d2vRKP8zbbcNv5ws9jMxaWq/vTBPm206rHNsi0RtcVuJCcG+
 cicCGMpoZijQoLenoTIciK4pB8SusHogU7Iu7uTXHYhsg9z+9XRGn+ylfS4+x6eXVosq
 lFGktubiUqlzhwK8UoEXUvMMvrdSWA0a3Zwvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110501; x=1732715301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BjwyZcteXigfik52kHZmjoul2LiqTeQVPSdJ1i2JhzU=;
 b=TH3wbW9DuHUuAVzcn/lLNhs4I8Ms+PEF89aqEPORdTlBLhotK7Ha7dhE87WotXeu4n
 57wH1mJzXvgDbM8ZF6EEOgUf+3VK5Hs+mZEHAtCxOq7SPgXFNwwsAW1Tk74j/LY9y845
 cUsLnfpMPW/YVFT8wddaNsmrsRR1EHxZPVhmfm8NcygfiwLgP1nXF96MpA2TalpPi4YT
 S+6szCkn5u33IoSymuEoMSZMKDSGOHXzt80Te0USxMtcYzIBXsx5fwaXl5KaBxuOYEIl
 DfoW19cbokdbSRewDo0r9F2OAmsEB4zlpaJHN8/J44i+ZvoSzZo7T3WTpgdm9XyfX0AS
 lcZA==
X-Gm-Message-State: AOJu0Ywd+G0MC83oGiv3nuImvcaqZHvmCOPIzdSRXyDf+F4ZMNn1OZc1
 rata/aOtfpgvI0s3MsM9rOMIi3c5NG+3xNBx4JsBnjJVpPuU3HeWd2G++8rtU4jXn+TbQGcIYjR
 ZW+BnO+OOoNLkMS03qaDiiSBlc4dQ1sQM663n
X-Google-Smtp-Source: AGHT+IGQaxPk9Nyf3s5ZbOZI2o2CfcMM8lSXg2xfNhlS6XA7c4bh0iETB21hwr5RnboLhF0YVGhHmjRANXVPz5lwrPk=
X-Received: by 2002:a17:906:dc90:b0:a99:d6cf:a1df with SMTP id
 a640c23a62f3a-aa4dd731225mr253203366b.46.1732110501416; Wed, 20 Nov 2024
 05:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20241120103722.886708-1-paul.henrys_ext@softathome.com>
 <20241120103722.886708-3-paul.henrys_ext@softathome.com>
In-Reply-To: <20241120103722.886708-3-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:48:08 -0700
Message-ID: <CAFLszTiWf5q+EP9R+stntjgVZHqZw7=rdDzv6EfRcFw-JDFqnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: binman: Pass a list of input directory to
 EnsureCompiled()
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd@gmail.com
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

On Wed, 20 Nov 2024 at 03:37, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> Input directories can be passed to binman using the '-I' option and those
> input directories are now also passed to 'dtc' when run by binman.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  tools/binman/control.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
