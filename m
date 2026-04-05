Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1FFE64019
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 12:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 739118352B;
	Sun,  5 Apr 2026 14:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mGdHFNjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DDFE83C14; Sun,  5 Apr 2026 14:03:35 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8609E8341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 14:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b932fe2e1a7so411137866b.1
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 05:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775390613; cv=none;
 d=google.com; s=arc-20240605;
 b=Q+UfbfE30CLBnwSb/bOtqTB4TbGfvH3w2T2X0WdHCMDPkHowy+VeO6yQZzEHCpLx+t
 dtK+tUekaZc2NQc5YeqDT+FIVJaK/crwT4fA4qBAFN8zVhDXCg880+Mg33e3eyTL5Miy
 Ic9UUucnI3AOwS5WvsBiBdEAGl5Onpc8GLqpWKXLzU2vOQ4hVV0uiutce82u3JerfmYS
 eCNDxDa7dEj0oZl7kqRLcpZq7IBt2Dqry+9ouz9CKeXdFv31tcun3XOCP9Iwrf4Pm+Ev
 lZWBcUmJrbu6nty92qAvIifQb6m5Axx4SxXZl60RNOsjUNAmRDijEd3jSnzS6U++yfag
 SCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yCsh6WwENpxV2tw4vaNPkk6rYvn6Y/7PD11rGWqJC3o=;
 fh=lXH+6hb/t3TLMTAIAl5lIQH8ALMwkkfDTdeqrvCL+gA=;
 b=R23/Ux5ecTjrTfDmbtigfn4rxkd1eAD8wBpIyZT02dYpi8lUGtP2i5+y5krwOW9Q9P
 kr9gJswDT40hatUNwgmm/UlQxgZGi9N1R+/zsSK05qxmNeocDL0DrY2bfx+0lvi2V7WY
 fiSud5rFPoUXhVDu2Xf7WOQsAWguDVg8gvK1bgtr6+JDDwdJuHNDAzs8kTMqz0XeID9E
 Ij5UxWScwC2qpdvDbywb/byyQYyno4BQYduEdR9v37FDeFBDecF+boXMslHH1qCyd6kv
 T+7hC/DMmEeupO5OZxHZemb3k6aghklvh1wloPoRea+lFZi6/RzlPZWqlUErV+VAb+cO
 twzg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775390613; x=1775995413; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yCsh6WwENpxV2tw4vaNPkk6rYvn6Y/7PD11rGWqJC3o=;
 b=mGdHFNjM6EY4gCLeg4b7OTTPB1dTfdOyLZnuNA1MDX3aGLu9o5B3CyAZIDBbawjXUh
 GZ/D2g8B6ClOnp17TxTNMXXhm92GfVk3CFIK0ceWo3lkvl4FHUWVrTmoZIfq+Q7TWM16
 hwHo8iTxcm+d7Lyi4yKt9LenOsRXJa9TOPIik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775390613; x=1775995413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCsh6WwENpxV2tw4vaNPkk6rYvn6Y/7PD11rGWqJC3o=;
 b=so63nzsuyh5KBOCi/Wihi3QCJgCEYJXmZ7PmOvbWwhGjdtzZ8tVAK1JUUsM464/ZJF
 qgfR9Q5PpCIbL6cWPeIHtzVMRbV/qiv0wmXvWgMVlIJV8w0HXCvWADInNDh0p5RK/FcU
 08qWKZQUx/5gNnNZYu07Jt9auCkRgras3D5x+ckRafeYK7EWg/mZIo/X9IwX46sPNy18
 QcC5dV1QItypooD1zkwJG5cW96J4ByxMEAxla7VC2C+2Tfs75xv0x1ldKHdyQsbp1O2u
 GDDm1cu71htc48ctMYUbUop9MhUKkrIn5V+5mhtO5D76WgIe3sAYVIn0yZmc2Z/C9m7X
 Ozaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcyo636KYs+0gZ2cnHfIY7zQdti6KbX3g/xmnipwISpkRiCDKyQJdGsbdzJHeeTxXE+iHwKQs=@lists.denx.de
X-Gm-Message-State: AOJu0YwYPUwhj1Ihxwg1V9XeMOcK9qaLspSgBfwKdegAi8UgDcvP5Xrd
 sXeiq03MA4j53J4AcM9RUdI87s8aBBXix6PZUX+QBtA9d76eF46kt7ZxJhRWMRUmn2Awk3ByUrm
 33+3NQgjWkKOxkiRJk1YDyrLDpVt0KabVJetsiVgI
X-Gm-Gg: AeBDieuqAseM8tL3jgCb6FtLDFclFoXIW0PVPnhog8+klLZt41eDD3aZLFa4TPLPpZi
 IgmuXhO2ofnIKGWeqThqgPIVAeF9KR9edDh7QNORLePypcnPqT+0fgQUjOA0qLGq7C3NNh3yvb5
 RTbdj+j49YEtC4h+3rvIww3loDFhO1Hf1WbS5v/McelHAxj56MUmFoiw2oeW1/uliXMlmGXme2C
 MbHN7njDFxRl8H3FBg3vmH1mfg/PGq9yZ1jTAZ369gKYH4GQGnyXlH75cy8LWvCnzz6bB84Bz+E
 HXnOi3xfkCb8Fkh8
X-Received: by 2002:a17:907:a0d3:b0:b9b:3a1b:e2ed with SMTP id
 a640c23a62f3a-b9c67957cc9mr474172166b.24.1775390612940; Sun, 05 Apr 2026
 05:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-4-ilias.apalodimas@linaro.org>
In-Reply-To: <20260403090109.3564638-4-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Apr 2026 06:03:20 -0600
X-Gm-Features: AQROBzCeHeAbGRsMH45nT6-nLaZ2-evYfSjNE23q_D9IcOlQr8UDR6m6Bl681U0
Message-ID: <CAFLszTiWwbPFYfMByEAff55AK72mhYXBG_V6AxNkBXx7hQFDbA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] common: Clean up setup_dest_addr()
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

On 2026-04-03T09:01:02, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> common: Clean up setup_dest_addr()
>
> Right now the function does
> - Re-adjust the ram_size based on Kconfig options
> - Set ram_top
> - Set the relocation address
>
> It also does not set the ram_size in case ram_top grew
> from it's initial value. But ram_top and ram_size should
> always be changed together.
>
> So let's make things a bit cleaner and move the ram calculations
> in their own INITCALL
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> common/board_f.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Good oppty to change the debug output to lower-case hex and drop the 0x
