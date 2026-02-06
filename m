Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E89EE6B44
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 18:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1545583BE1;
	Fri,  6 Feb 2026 19:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LtkhW0xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF2D83BC4; Fri,  6 Feb 2026 19:15:26 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C950C83AA9
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 19:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d15b8feca3so2115296a34.3
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 10:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770401723; x=1771006523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPZZNRGhw54v+UrsDIrczYtW4+Pzb/4jeW2uAYpdzRw=;
 b=LtkhW0xehdQLk4G2vpYtTQDAQZ1L4s8hXDXyEcQ0i4ttUaAVf09B2Evp8iuvzgoNR4
 ahzbpRXhX0xnQHJXNL5KUynM4M75TvXPIJvuas3zgKLq2mFp2zxvTRZBvXpRamgaYvv5
 DAiWrPt0WmSweMSC5yjcFlMznE8W5WGleGGpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401723; x=1771006523;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HPZZNRGhw54v+UrsDIrczYtW4+Pzb/4jeW2uAYpdzRw=;
 b=u44yPXFfDyZWz51YFIm7zV1NruELPZNL0zFaZXkxjDhW4Kp2rhJUhFbclShL27N0t/
 NKH9fcbXHCKaxLAMuqlZUQTp5wRLytuRfxzWsrpSLLyyH3/j5tH3gMp00RhlEmF3S0zN
 xtIu+Z4kJ3RRkz1GCxLB5/v4Kb+8ptHGyLp39aZV4jgEZ1g7YjQ1FHAvoMv/9EsryhpA
 ehdJHLlsG75r1kr9AVIkISc7oDLokG8U7XhL2tBKuW1TntWim5i1fQlI5+xFzNv4uhlr
 54X9p5gnUEY4P2OC5zkLPBnquou7we9Fi0+0aVsgo1+Oa2oN50szGd5JPibLBmPXJm7z
 KWkA==
X-Gm-Message-State: AOJu0YwQ6JN89mRyOUb6tLPrjpr9tlgjh/zSUdIlgf4U8qtJHPExn5ss
 0m3D2gEKe4KpDFa6Ww50wTJCsJvR1iJtZlnEFW30QfO8kwFRXAMFG3vn1SusSTtR1kY=
X-Gm-Gg: AZuq6aKC2EmLQtJp+8pa9lJu5JVpRDpS8Ro2ePePULJOhUxplIIcOoufUWbYw0RuwZi
 t6zWpDhhZ5KYLzQytBgrnN3tdCiWxFjU5ARUTgELgbRFoCfdqpKkxjVy1JRqtwV/T0C57DXVBTi
 yuDzE3bzTM8eIYIqDl3bw2FrJJ/KlRUpbjU/Qk1o78nnP4AknAZQdd0CgGdoguoKgZY5Sr5otcQ
 dtu5URVpXy2J4aOuYJ1/fL1ygHgu9obeicj5d9bCB8B/S7T4gaQqIBztu/puhdNEHnEnFOggSOh
 JUX2gQanxUf59wMBzmmvUj/gqBIPqW2nYPRXLE8YEvRwoTYFiN+xeM+ryKoeNvcPFYt6VrYTvwY
 MVYxQXy4Ke1gxeaFX9nSuyhYMEcZ6AHq13b6sTkE+3MHicqqoBt/vM0dI9XXFdFIPLwiT6mnv/y
 pi3amrtn9wqnBQZF0qZx/ZZHSoIq/PdCBZWmHSNM5MtAEINu4t0mHTaEZDhf1VgQ/zLkTlG5fvy
 euUzLaUBUgOXrGZfO08Wr19NrP7oUQjXWm/Ng==
X-Received: by 2002:a05:6830:6288:b0:7c7:8113:6f6e with SMTP id
 46e09a7af769-7d4645817demr1522094a34.27.1770401723603; 
 Fri, 06 Feb 2026 10:15:23 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d470914a1bsm97426a34.27.2026.02.06.10.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:15:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260128194049.278542-1-marek.vasut+renesas@mailbox.org>
References: <20260128194049.278542-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] gunzip: Fix len parameter in function signature
Message-Id: <177040172252.4023747.17238969478736007723.b4-ty@konsulko.com>
Date: Fri, 06 Feb 2026 12:15:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 28 Jan 2026 20:40:40 +0100, Marek Vasut wrote:

> The only call site of gzwrite() is cmd/unzip.c do_gzwrite(), where
> the 'len' parameter passed to gzwrite(..., len, ...) function is of
> type unsigned long. This usage is correct, the 'len' parameter is
> an unsigned integer, and the gzwrite() function currently supports
> input data 'len' of up to 4 GiB - 1 .
> 
> The function signature of gzwrite() function in both include/gzip.h
> and lib/gunzip.c does however list 'len' as signed integer, which
> is not correct, and ultimatelly limits the implementation to only
> 2 GiB input data 'len' .
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] gunzip: Fix len parameter in function signature
      commit: 02ffe4a0c9d2885899648a5ffe22090e6c7ff9a5
-- 
Tom


