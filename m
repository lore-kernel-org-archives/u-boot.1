Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73272C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DDC3877CB;
	Mon,  1 Jan 2024 17:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kux/GfTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D5CF87837; Mon,  1 Jan 2024 17:49:31 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331C38779D
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dbd71f33cd3so6384359276.3
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127767; x=1704732567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rmxfSHzDigkFNSY8h0yTUkNRGK1mm0EREmvIe9LeyOM=;
 b=Kux/GfTzM4IOg2r1bSN5cb/Q5vefMDOUOnv9OcNWKfyo3VBeM/til//F5MpnLfTohb
 eg9CisKWhT4hM6TaEhE9XCXLJXJgbP/2O6Ax1PMlHkFZN/7L0zxiTgmw90MRniKIa4FU
 ter7VA2ux7D1IfgWDfNjZKrpzxeOj8BFOVYDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127767; x=1704732567;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rmxfSHzDigkFNSY8h0yTUkNRGK1mm0EREmvIe9LeyOM=;
 b=nP2Fw0hXriVZdyRenWzPvna05Y2CmhvVDeP7OwrywJD7AqzQJsQPlMf81BPo5m+6y1
 Q8RsdJZ0eZ+KKEYqIsYkDAeOGFYq48vPAgXJ/0BEslSDKYNbH917o47osxPmmGcXcS1Y
 3TrpLiaxtf6E78csdX4v65/TjIq2NMZgwdUskBFR8+xav/x9Dx0Yv0bGB7IGIuCHgziv
 Y7Ri3AcK7Fm1DP6r0e3xDKRqtCo2nJ9trg4ZVtk+N/2RFRahrVOtkLtRrGCz5JERn84g
 32FMY+nX8prZeUJ0fezYMb1pJ8gwVs+FI+vzhhT5Z07t2gV9z9f4u4lmms2d/CA9ENY1
 acJw==
X-Gm-Message-State: AOJu0Yz7GifNhzhuP1yDyn5r0vZlDonuUtZhkQS1m8RNQy4LmWxqW1IB
 Tu4ZtF9r6aMPazuu07dYj/SRt4olL5pr4JV6u7IOsxQ/rWkm
X-Google-Smtp-Source: AGHT+IGeNjq41xNlP5mUCavmCmWRtdz2JEN2/5pvyHvfmu0ZBEEovaFWnDoEOl+pj6EJV3LiLdl850UE91luCtsBnn0=
X-Received: by 2002:a25:b225:0:b0:dbd:bc92:f932 with SMTP id
 i37-20020a25b225000000b00dbdbc92f932mr7844279ybj.64.1704127766922; Mon, 01
 Jan 2024 08:49:26 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:26 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231217163627.2339802-4-sjg@chromium.org>
References: <20231217163627.2339802-4-sjg@chromium.org>
 <20231217163627.2339802-1-sjg@chromium.org>
Date: Mon, 1 Jan 2024 11:49:26 -0500
X-Google-Sender-Auth: Yvo2J6SSzw3jCnRWAzwiy1PHbo8
Message-ID: <CAFLszTgNjfdnUFVo2rF61NQDV+H-MdCfbYbdcD=fc3ic_L6eLQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] fdtgrep: Correct ordering of flags
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Two of the flags are out of order, so fix this.

Also adjust the ordering of one flag in the main switch()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Applied to u-boot-dm/next, thanks!
