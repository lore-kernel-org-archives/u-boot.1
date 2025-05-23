Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA418C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A185C831FE;
	Fri, 23 May 2025 15:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GOX3HBSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B8283285; Fri, 23 May 2025 15:18:22 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A308310F
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad52dfe06ceso860079366b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006300; x=1748611100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ilDkxZXPqqlNINKHWA79stutUCcYjOLGzH/pS8+5HFU=;
 b=GOX3HBSgrMnlGA00OhPerM6xOJnurGuMdhATUzXslNVB5klcx+lOUR6zyWUpcnu3Xs
 UGGtAhhUI+9ayf9RHDQjiI0yJF6MzNGBt5D95qF0fTmLH88NumYlSiyYalyncSW1PMfo
 Q7+oTb2rUbyxx+mwJjZgg7W8viVJCWk6hDk3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006300; x=1748611100;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ilDkxZXPqqlNINKHWA79stutUCcYjOLGzH/pS8+5HFU=;
 b=ZetMug6tTyBD9sfKVh5+kceynWsrm6l80HsD6RBrcaYf5TorASC7OJf0OEkg2/hfkX
 QHI9r3n9QmSjYFRN28KTFY+hqWIz5XQKOfRQ27W2ttoR5fZT3DHPxEDJMdX7fvnYp1N4
 4ZUIsjf/JPjSzH+AQIYW94nkY6ZiBvHCDTs7VX3IngC1f4CfQbv1CBRPtZg+QNI1IQ07
 Z6s47q7aIJBaQsvhyK2FiYOeOEdRnjkuAdQXOmOKUagqYrBHlWn7t7AqLVhxt1gj9Qvv
 oEbmsh6QaBmHAjBVD7PYxyoW7Lwhu6/7v0wRbH5Frl/NMF2C/brFsVqk7/1AVpLcaeXK
 S0Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9SdZ+GPhVcBYbPVfhphbfxAVeQxqAj4Fc7F1RYwPkTmlW24ONmlNZNNq/7zGJoTJUrb/GjHs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1SvjX5c9JWgThr4DOyElVKOzr5Qv0nUJIMRDXEcojZB+7Nauc
 Sd2gATft0XMsfaDDJIJZE0/nHjeMGuf30WGLlm9cSwztP9aj//F8p7qhN2GEsY+QxewKS8kSFiB
 8e+0il9IbUts5IFUt6zWyrP4mTnzT0Y5T4Yu7tGGr
X-Gm-Gg: ASbGncuCGi2U9awRPwjY1VugWSlvkrV3UWKcCXYiUjoWz7aAhQp6950WpxP/bE7EUNb
 TmyTD0l7Hv+BD+4+19fmixiVB1yzfaBhl/3GOGjD3CetgVyubcFExDk3VGTGoDxVqiA/I/QSm0r
 arXTO0W101kmFQLJINjMNAFu1ryy3zt0UB1A==
X-Google-Smtp-Source: AGHT+IH/r4bPKv5FdDW9EFPQrhxdCN9s7BOkspDB7ieWyvhslnvXvGN0eA4af+6bCRKK7XqPM0rVopSELDXfN8yALpM=
X-Received: by 2002:a17:906:9c82:b0:ad5:e0a:5891 with SMTP id
 a640c23a62f3a-ad7083ffaa7mr276410366b.1.1748006300137; Fri, 23 May 2025
 06:18:20 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:17 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:17 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-29-sjg@chromium.org>
References: <20250504132356.2317305-29-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:17 -0500
X-Google-Sender-Auth: pq9zvpHXf5xJJAGvTzi_28lWCCA
X-Gm-Features: AX0GCFuEv3cACphkdvUwqoRT0NOrY9higevS1oW31j-PQmOgbbpZZpCjcoAB84s
Message-ID: <CAFLszTjnnAZ0rNfUcDC-tdyOuV8ZQ21hjmJaEyBLbWpwJ2rp_A@mail.gmail.com>
Subject: Re: [PATCH v2 28/30] patman: Provide an option to run in
 single-threaded mode
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

Patman normally sends multiple concurrent requests to the patchwork
server, as this is faster. Provide an option to disable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/cmdline.py   | 2 ++
 tools/patman/control.py   | 4 ++--
 tools/patman/patchwork.py | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

Applied to sjg/master, thanks!
