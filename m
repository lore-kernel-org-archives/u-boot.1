Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D82C47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F3787A8E;
	Mon,  8 Jan 2024 01:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AlHzc7SN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C5987A82; Mon,  8 Jan 2024 01:16:23 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC8C87A4E
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67f7bd86cafso14558616d6.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672978; x=1705277778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h+XNdi76JwjLfp278XgT7QJZWZAFU8gCep+26R0b1xw=;
 b=AlHzc7SNwv9uKhaXrqqfXZfF+059P+A/rn8/SYHAHILGiypqljCjSjrjyGFh2Kkawp
 4nu4gogFNcxRAuYAKxA3m8KLwrXpqqv5urLKbZdIL8nmYxH2bO6p5V7M4nLFiM4rLfri
 iug5Iygxpr6cQ7NLz0xyIzsad6qqgJfTu8+Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672978; x=1705277778;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h+XNdi76JwjLfp278XgT7QJZWZAFU8gCep+26R0b1xw=;
 b=hSi7/IhDoeOdnFr1nuBwsx39oaE6TqwDRI5Td1FMwwRLzS72gNtftWttaJi+NHKQjx
 ZNYJfjjuTwuQqTjWxiZ7rtZpL4hu+BUMqEms7/Kevk3mnL0QBiKH8ETMUT+2i6QMBC8S
 ROLTRZpBXomzxd4iEHbxa2oP/7L4V0EvGaxfWpB6PRwlodjfdibe/l4ok6AueNMrJGg1
 5dOHJ/a/INj05w1VWCWnHsA4CNHx9UhXySpyH/zP5Wx2o4jxvgJ0UVFY1CNRNs7WdBrJ
 eGh7WOk2dPemAYAYC+xDSqu0IZh8W/Y658oSNIsZJVRrVezDLu9h/DWk4NrynhjgQZCN
 Ibmg==
X-Gm-Message-State: AOJu0YzbazUrqirKXct6yz3dVT8TgTsgabrAUtu6b9VbtgWN4qJ/dHuS
 +HSCh06ar1m+ndFeusYWew+ownJkXj8ckZwyHyMJ/QJknb8B
X-Google-Smtp-Source: AGHT+IE0lEnXAhtwaDcoP+S1dZlfiE2b9BZP9psLLFQ+kOy91cSK7sJb7v/m0HcQ8s0TyQtJ++WNABvh6bc67hKwfK4=
X-Received: by 2002:a05:6214:1303:b0:67f:2201:81e1 with SMTP id
 pn3-20020a056214130300b0067f220181e1mr4443046qvb.13.1704672978341; Sun, 07
 Jan 2024 16:16:18 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:18 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231231152555.464874-4-sjg@chromium.org>
References: <20231231152555.464874-4-sjg@chromium.org>
 <20231231152555.464874-1-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:18 -0600
X-Google-Sender-Auth: RUPv1AjU1Iow1RUmh4TLXxn2uys
Message-ID: <CAFLszTh+S1AsnKUAR-kmeTM5vHLmreYv3odb6OF51DZkwuPvbg@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Add definition of the SMBIOS 3.0 (64-bit) Entry Point structure.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Bring in this patch from Heinrich's series

 include/smbios.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Applied to u-boot-dm/next, thanks!
