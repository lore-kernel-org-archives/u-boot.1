Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1212EA71B7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2401184181;
	Mon, 20 Apr 2026 04:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gJqCLm73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75324839D9; Mon, 20 Apr 2026 04:51:15 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94E184181
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba25fd27571so366427066b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653472; cv=none;
 d=google.com; s=arc-20240605;
 b=j/YdAhTK53vbcojInnKLZLkYPXXRYcPzYUiZdLwCr6IwkVulKx/NdE+LZ86wXcAgD2
 dWnxrJn7rrOg5HNA6B3Ep04/LxlWRkc2AbXkNxjrjvmyEPbAo21ejaiVcBP3uy/8h5BL
 H/Ia9tZKPZLkK5akAuhFYWyWQZ3HQqDX2ob8iCNRNapFSYwSW54Qi/hcztDPAk1jhVSG
 831t3OMXs/xsQoyZETf2Y49gkWFcPu7W85MfpHDxyjYW+0LKwTjt5eg3mRNXDEsfFuwd
 GhlN0jgx4E5H3iPzuSbG5AEuAY1asz7Dg9gEmc1dW+MslnNNM6IgZbhSeKOzh5Pd2cWl
 li+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TUAM6+u32iLZNQTgGdGPsqlQMhxoXgWWYj6m/dDXepo=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=MzqMA8GNWSyJ4wtbk2OMcxUBoqx+JkLbv7A9PnjS/NnHK0iYhxyHbhNttK2Hb2bKqB
 8+I6D3HrLVShb9ajHW06xw9pmABcVUilzoEfcOFxsy7GdUi2VLQD3+1GLTmjc3X/wdbP
 sLjyEixiIA+V2g0WPxVkpKGQXk3XTfzUA+IFr76Bbk+YAsHVUstv2cGeaRwpWhxOWyEq
 zdKOG6d0xmgT+SF+lheK/BTPrNc5Fd9+PqOPFtD2kLeqnv+rDjjPWtsOw9Cml7LBniuS
 FXt4lAajC12hgbatWk6lP/sX4kf3zQMnh/4N2mCAutf25W739Ii6YukG8u/yMedo75zS
 /dAg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653472; x=1777258272; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TUAM6+u32iLZNQTgGdGPsqlQMhxoXgWWYj6m/dDXepo=;
 b=gJqCLm73x0tey7md6ZpWsWtupjc4dGHYo2fSN3WfTrgd7FT7QexBp3JbAYBYrUGHMh
 SxaXkCFmX+vJjB+GgoGiOiSRgaYO0sECG+BNC/6JLh+uFAfsV6Ie3UZtwPDoiJyc3bH8
 3VIgDd9RVTneg7AB68MfKXn7ikjvut0Eu/B2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653472; x=1777258272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUAM6+u32iLZNQTgGdGPsqlQMhxoXgWWYj6m/dDXepo=;
 b=fNqvQRjk2fe6dkagmEDAn7NFdA4OOtu1yD+gYTuVMRxqrILn1urVXs0aCpPekbyLdK
 OoNEUr255fQvz6c5Thd0R8GCYahGxQZ5zf35s1xYeMy/sjOIcDF1urj8b4E06AtfYIFI
 BjLWlpGRO7BrVqCQLoSLX5EEzJj8nWZjkqbH8bNscl9Tr93TSNt2APf4xSbFD2lvvuOu
 UVJ3JBHIvYSe3VYA3063XBirssehWP0xEdgq9pmH13YUnsOyHYLlDY5DOOg9Pb2/oS8w
 X6Cjfiu5aEVoXkE8haB8dhqmF3biBJv2ZYb43LWXfKuw6DzsW+0u7NdexBR36LcDqLsI
 qa1Q==
X-Gm-Message-State: AOJu0YylJC+wayHnDgMblyu0WIDyTw1q3rWQ6ZMxlMNyFTcFmk0KTVGl
 LOi8ekXSM4EVwTpwvBCi1+piuADZ65xBxGs5pyalaD0siuCzI68M5C2g01DL1WqEipz9WLS/6xW
 0sR6FFoHI7r/jksKqg00wkwd7SM9NduvRAkE4Ji1C
X-Gm-Gg: AeBDietCN6TYEinz4enz2UM6yHd9Ax110SZVZosKM0jWTWTRK6Qecx9uuw6gAjM5iIk
 UUGy+cajxNoagT6EvJT9mlquqU4EJA7yWNEpiDkWdPSHy++2kKwDz7jPSl+jlfDr6L2OK6vCkFY
 YSORvA4fJWM6G9E3vD30FZG0cs0iopx1USQbf9nKr0bylJMkR1ZG2UkKoY8SJ3l2yp8VuvykCpN
 P+b5QWQptJ+jT6JvhuXMLN61U4WfgP3bwE7b+2iDjhM+oRosjtUWCQuKCFrcYkt206ZxnYnPI66
 j8mx8T4+Qjq5P2QRQF3O
X-Received: by 2002:a17:907:e110:b0:b9f:174c:5b04 with SMTP id
 a640c23a62f3a-ba41afe9999mr342161266b.38.1776653472112; Sun, 19 Apr 2026
 19:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <63a35f9608c046f37f610fb0679c7217c93016f3.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <63a35f9608c046f37f610fb0679c7217c93016f3.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:50:57 +1200
X-Gm-Features: AQROBzBM67_-rSAzuyRIe-YWVgYsWl51tkx4rhN43pi_SnKmLGu2jZWkc104fBw
Message-ID: <CAFLszTg-xE4RcK7j8e9m4ViQCoEfSJrh2SMia+A3W_8Kkoqv+g@mail.gmail.com>
Subject: Re: [RESEND v4 04/14] mach-sc5xx: Switch from tftp to wget
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
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

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Switch from tftp to wget
>
> Switch the nfsboot and other relevant commands to use
> wget instead of tftp. This also includes the addition of
> the httpdstp variable for selecting the wget port.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> include/env/adi/adi_boot.env | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

> diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> @@ -15,6 +15,7 @@
> +httpdstp=8000

The default HTTP port is 80. The commit message does not explain why
8000 is chosen. Please can you add a comment explaining the rationale,
or use port 80 if there is no specific need for a non-standard port?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
