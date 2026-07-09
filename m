Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0EAC44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 141D684994;
	Thu,  9 Jul 2026 03:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h35oW8xr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 313A284A1F; Thu,  9 Jul 2026 03:24:48 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D5AB8496E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697763eeafcso2342250a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783560286; cv=none;
 d=google.com; s=arc-20260327;
 b=gLNqiUeXlweBpoOJt6GE8Vz/AJsOBCtSWlmQ/F4lzqq638B9Po/L1pGUE+NTydXpXS
 +XwB4g2/Seuk4DSBg2oYicojqxegZImWgo3r+pTiavh8CT+7DpaRPu+fuN2swdA+pPtz
 s8IwJcIoAWUgD8eWU7YqSgW+qKjVhcYTz0LDBZZY8gKKLTftYfcU+gzFH7BuWgy2NVt+
 TLo/jzB4hjIDpvVqhd1MBMnXmEvUOPUZwl7BSBT7o8yfknuqmv0xTVZAKZurtVGx/bWJ
 VBjFeyRDTTYZGenito6eqSMi2WpQ+uiv8LrJ0dEwV+RATHZCYwLlATR+nFitey4AxHtd
 dJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=36HUDd1f2S/DNtE4DS9YPN9Llm9wwngCyGLaVRGCopw=;
 fh=+6povcerqHjgn+6VFq2cIMMHL8V1jKmE0QZ9TDr4nYE=;
 b=P6HcVDalOC7XxsUWnVvAjAlZs+3QBvCxiV2+FHaQ1ztKY/Z0qOSX6D3im2P3XnaqmX
 hS9kyiEqdvx4h7idVvVpqYq24odVdxnucrIZAj4DBHmKwhh3xSQVnVLEW4/G+FlO6O9D
 ZdWGcRqwmnA1pX/a7FqDZRI0mtCmZ4m2DigJ4nP7gjhQ0+l28xXIVcY5pcoX9os7ZZLa
 02gKynw28tsaX8hl1jrY9+l6ZsJyKzvqHt7UjbAYxP0c6+cxRVLctGXWhREv/wi3tfGl
 5ruymuU41BHppw9lZ/2dcajDZL51gwnMCPBKCdPRmJY60QaqP52aE2QsuR33mMePgA8H
 tOaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783560286; x=1784165086; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=36HUDd1f2S/DNtE4DS9YPN9Llm9wwngCyGLaVRGCopw=;
 b=h35oW8xr7k1EhYkq1n8BRbnYnzftTEfYrpirpu/MbHHYjn4KKO0mBU4w/DuUKtA6Pu
 19QSqmdFY2+MMzCvwpBaWjPI6b0hAe9XqIAwzMLM55IxUyae9vALBYPIPfvSYgiDScig
 BuS2JkEsKKaMDwgXzYs+6LIxb1Xq7SoJ9EHsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783560286; x=1784165086;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=36HUDd1f2S/DNtE4DS9YPN9Llm9wwngCyGLaVRGCopw=;
 b=rBZETQejG79MoHegxBKBIP3Q1SIepz8dtGsI3xyUUXU6fdBxqvLoPMEds2a3ngW49d
 ZiAHt563M1ce1MJRTUrFUoE50xS9JfnV8546j5kntWjDMVLMpORWz1a9j+41gz4oSqzJ
 ueinQUs/vG9d56zezePIMlJmUoZ6yWeDe/9dKdOoX24KZtm+6UIa8J1XeK5fsoupWiEH
 KUamvRY8fiSFD9X1WK/a7CRCoAh7AUdTjRBv5F0NCO3+UUlBwStkE2Th7Vb5UviUVe0d
 IHnHWkQ1sI/L8xo6p0V+jmy7HQkq5VpWxGLsBjIX61U6eTSKBue2AMsvZ9OwizVdSr/7
 juGQ==
X-Gm-Message-State: AOJu0Yyq9bPVDuki9yN2t5GVQmaoE+g7aTTIIRy2pL2d0EAjgflgAt7q
 DH9RB3FNXkNVmqyB/bXhxt07b+r/GKW7Sk5+8JWUwIS0qeK+WmBJb/ps0ychV+ahHLGA6rpPMDB
 h/xphwNr+XUAMunMGqqiXrNhby+cPBuKm9JqJdPEd
X-Gm-Gg: AfdE7cn1mKxHAEc+358SXghSuf7Aa3jHrmv1g4fZ8LwzfR27wIWzfJz4AUOTrcMteYX
 bWCqrJiLtnWWzp/4I0sFJXwh9keytTPwY1cZRjMmiTGRTdb1fA4/eCTZy1cJhnMdPwzOkYFPO3B
 wgPsWaTz5iXstLLf8dboyQChm8G6UM3P6Sz7ffWswpoYv0lo2+coodN/X/fjMPmyxXwFxP6SgsM
 6UPw/Mw4FSjQrVL+VijKC6DdcME+RVP5/5+Z9wnhbYEb66uM9LUtlFqK1sI18EqHR+PgAk=
X-Received: by 2002:a05:6402:51d2:b0:698:be56:d7cf with SMTP id
 4fb4d7f45d1cf-69ab4477801mr2070830a12.16.1783560285807; Wed, 08 Jul 2026
 18:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260705212037.319801-1-marex@nabladev.com>
In-Reply-To: <20260705212037.319801-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jul 2026 19:24:33 -0600
X-Gm-Features: AUfX_mxqQ_WMD51oBYS0Mf0HQElH2Ge2XTGjRj_-ZsdVOqIUx9JZAfoOQtMHdVg
Message-ID: <CAFLszThTW2_-NFEywfW6HDOTJ9u2eyvYwXkZCtXX3fgoET9weg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] binman: imx8mimage: Generate FSPI header in binman
 instead of mkimage
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
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

Hi Marek,

On 2026-07-05T21:19:05, Marek Vasut <marex@nabladev.com> wrote:
> binman: imx8mimage: Generate FSPI header in binman instead of mkimage
>
> Stop depending on the current mkimage method of generating the FSPI
> header, instead generate the FSPI header within binman itself. This
> is more flexible, as the FSPI header properties can be configured
> from within the board-specific DT instead of being hard-coded in
> mkimage at build time.
>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
>
> tools/binman/etype/nxp_imx8mimage.py               | 95 ++++++++++++++++++++--
>  tools/binman/ftest.py                              | 23 +++---
>  tools/binman/test/vendor/nxp_imx8m_fspi.dts        |  1 -
>  .../nxp_imx8m_fspi_fail_columnadresswidth.dts      | 19 +++++
>  ...fail.dts => nxp_imx8m_fspi_fail_devicetype.dts} |  3 +-
>  .../vendor/nxp_imx8m_fspi_fail_flashpadtype.dts    | 19 +++++
>  .../nxp_imx8m_fspi_fail_readsampleclksrc.dts       | 19 +++++
>  .../vendor/nxp_imx8m_fspi_fail_serialclkfreq.dts   | 19 +++++
>  tools/binman/test/vendor/nxp_imx8m_fspi_pass.dts   |  1 -
>  9 files changed, 178 insertions(+), 21 deletions(-)

I'm not sure if you are planning on a v4 based on my other comments.
In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
