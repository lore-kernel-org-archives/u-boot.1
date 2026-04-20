Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD91EA71A4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB1D842C7;
	Mon, 20 Apr 2026 04:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cUNEVe8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C013E83FF5; Mon, 20 Apr 2026 04:52:41 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA4AC842C9
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba8472c1613so26185766b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653557; cv=none;
 d=google.com; s=arc-20240605;
 b=G52bKbCkKhBlElOXtKY7/xUYGl2V94GlNvxAF0NFl1MTve2NQJerUps1NQgMHPzJpd
 HPRNxTyLa5WureBEvrjFF9P9kokOpEisoH/UUYkmbr6cN53j6Aocn/Hr7rARKcNSDNJN
 3/oc9Vk5ykh4LtnW6L/XwMFcog1lCFrcP+WUboJGTuWpD5kh8ZjnxQjXTqUm1BAfGtxH
 y3oQjqmgxbrv3m4+Ts0GaZfndpzJMcvVJH+ikgJSgAJj2hxCUSETPmQfBJEw9Y5gNOFk
 C+xer53LeweII2Rmq5qxYHU6Q2Sdgt898G/H0hhaYr7eiLSf6guDewwT3AoP6ruo8907
 fmDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YATU4BrIEOXdwwNAxkrNh6g5hhVLrTqvqey9CR/9lEI=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=aQfPlzitKUE1mVD1DfcvRTfh4vqBZbXW7wQ19A/cXnLGG+4OY0xOAn6nO0433i0iEQ
 EagDw0ycoohH/HrmaYUJln9P15E9qyg77dHsb6NQtznd2jSHCUGtEO9XfeOO08IXk7Ed
 dTEZJJ7sWvL4cDkBtPa+c/bEXPiiIZ1xVDUE2x9fB7ZIvwCJNgCPmXBbSTlnBHjRMzzr
 JH/5AwtO2Uq3VbMMEy+eMrksC6GbW5jzpQD8V21iRCsuPMKrq0UQSIdBtn+ii4ifB7mn
 h0FTo/5+uG3ji7VAkBQpaAUJkFhVr7GgtZLufzBY4KyaQAWKP9dy2Pz3sSX/3w0F3FU1
 6pLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653557; x=1777258357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YATU4BrIEOXdwwNAxkrNh6g5hhVLrTqvqey9CR/9lEI=;
 b=cUNEVe8Bv+rypyJt4EwOrms05pETbmYGtEMgAQC+qnt7TUlqSobR5bUP2NxW31Vo3P
 5m9HEa29c18LqZuHLdx7watx9VHBXNRulnLzKQiUyWD12fmps1eTy1JsQjDN/GI9gc2r
 Ug4ysIBrFuzEXGS0OkjyGl7xp9YbRAe4vvS0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653557; x=1777258357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YATU4BrIEOXdwwNAxkrNh6g5hhVLrTqvqey9CR/9lEI=;
 b=g9sWtEdZZZNyhGn+5cRU+3ySS1mwlhUBH2kvEcBcYaSmhT0q7RNT7Wp3VVSlnNAN2b
 pwJUVY/lUwpgkguoJABOIurgdqbb7UaESPAfo8B85JyMj1MlKdFFg101KBELNofbNjRe
 3k+ESczApzrzip+4EsBbZovBPbUBDJBauFc5e/aS1ntzRrMXUYUUWuEZ3WtSM5+34iuJ
 K47VD5iUIdn0zU6Qtta00cyJiODu6IVSe3RmhNerFOt4DaQu5NApOwM0UDo5/yPLNVev
 NqAwCz469+HWTGMwbbcvUwORXmWh1ye1+ruF7JkkfkoulNyGX3IBTOlA/3qdjsrdQqVp
 yF6w==
X-Gm-Message-State: AOJu0YzDjH9VvjOCmC98XE1logbVAeN8dgTSoxPCjnnKC3UIq8zso1kA
 Ww2wsUlJM2IG3tTuT0xsNzesNCX1yOJdx8PrUuf/mYQhPvHl7WMdBx8b/RWsYI2S/frhgxXlzI1
 DIt0HVz5nR1GOdJJOKGbTA1XTiNXcwg9l1YAoFSBb
X-Gm-Gg: AeBDiesDcUFE+TdJktll3eGiHps5a2lVUN5/iXT7/gfXzDBzTWoW+HBXAj9fqkKKkE/
 xjrBINT3KP/JL8YUF+aKPomtqcOtsTAYPV4eDQjmSfazOnMym+oQYHX+wQRYXG4qgbRVhmCJrhB
 ESn2GD/TSlammK4zfhiuImxRmz0S60evH0fRRSyerG32k9nqGxLTdaQVI7BG6PulJfDpWCDvsRD
 OO2pjThvb4Yy/fbFX/zTG/T1S8J9y7F+MH200t/OFiT9PWDa2ORu3TXH/ox2dv0nks+wS6XMydQ
 5oiQe7wsw/7z7ZpEUkLA
X-Received: by 2002:a17:906:4788:b0:ba3:99:29d0 with SMTP id
 a640c23a62f3a-ba4188881a3mr566191066b.18.1776653556704; Sun, 19 Apr 2026
 19:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <0067cab6ebf6390aa2fe97ce8f403c4e6b8ed940.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <0067cab6ebf6390aa2fe97ce8f403c4e6b8ed940.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:52:18 +1200
X-Gm-Features: AQROBzDC2vpwkV1_kSvaQGBoCem4p5KYKMem6VacPnp5R267gYhTbmL_P2mLF34
Message-ID: <CAFLszTjg_xRup_Ap5F5Ji6CPXbWF-g1yy3q0v8SEPNBqTKD3OA@mail.gmail.com>
Subject: Re: [RESEND v4 07/14] dts: sc594: Fix gige-reset line on EZKIT
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

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> dts: sc594: Fix gige-reset line on EZKIT
>
> The gige-reset line on the EZKIT was updated for the
> sc598 but not the sc594. This commit aligns the two .dts
> files since they are describing the same hardware, the
> EZKIT carrier board.
>
> Fixes: be79378 ("board: adi: Add support for SC594")
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> arch/arm/dts/sc594-som-ezkit.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
