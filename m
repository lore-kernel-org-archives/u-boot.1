Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0501EC02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 20:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76BD3800CF;
	Sun, 19 Jan 2025 21:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J3jOyq6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4FC801CF; Sun, 19 Jan 2025 21:08:19 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B477E80085
 for <u-boot+nodisclaimer@lists.denx.de>; Sun, 19 Jan 2025 21:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7be6fdeee35so197991785a.1
 for <u-boot+nodisclaimer@lists.denx.de>; Sun, 19 Jan 2025 12:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737317296; x=1737922096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qFAfo+B14BtHJQc+ZHq1WlpBmzK3nwZevybGzgrIE8=;
 b=J3jOyq6KXdn5NpfddtHVbFGvatI1OGLM1xsBhzJOEs3RhPx75ieXP2lO7RbrDUrZGW
 f/obhaeewOxmBfRGVJc99RxWSGMrzJzAHlQQz/AE7GXvu9039tlQmGFumLrd7B35sw4O
 l50D/seUQJS0eO5hsAupSbmrL0HlbHYnf5EkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737317296; x=1737922096;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qFAfo+B14BtHJQc+ZHq1WlpBmzK3nwZevybGzgrIE8=;
 b=G6+lwxovZ4N9EAU6H4wdcjHXjql2oH8RV40NRU58xJ8yAq9u5r3SZ3hgX3dfDqoOou
 Ke4CKZ6qBpSbNO5jTyW7rtddoo8yPztzD3NF5RmvX8ykHbzEgAQ/h5AXzo6h2/O6wdD1
 l3HK8jNw+/lJ98jKsiBAOBduQf5HLdsx30yR424sdWQv62E16XEmTHpmBI+GWGFO+jkj
 CpT7B0mhuCUKDTNBuJ0oa2BBNIA+RQgaOQtH7/tB4Fo8zwWD0Zt87tITzpjJGPY5uyXs
 WdwM9FHRLcoanCerVRXbai/+BU7fAk2cXhgTB/cIXVgfp5J6xdF78qZIjKeaDn14Eid9
 ZCnQ==
X-Gm-Message-State: AOJu0YzpxJBdf3GM8cfRyXBQyOtSDoeX37x1laC28S69PjJ2EVm6WApj
 ty+XwTsir7imZeNjvS3v6jPAen+8GETlY34i3SQ33pzTGq8hwAKSmd35oOvl9ho=
X-Gm-Gg: ASbGncsMur5pKI+VIxkNh79oQp4dVh1BoZ/gi95DRZTSPTlMOnGoq+nqtHrk1xdppVt
 j20jhR5JqiW7m5CDnPEPjdNgrn/FLSUzOST0W65RfX3VBDcFNNjj3fCHm3iOKP6xFqpcyLHDbxf
 C3JnQZ88XOKmLPDnU5j1EHSH9+siRtPdd3TuJrNl1y75RQTcAOrRDwVBg+5xfZe7aFu5d10elhq
 cYa24aBiSKjp9pF36awViE4xyLtDIns7XXd8DLfrf7lWDIb85J4tVJc3W6EtpSnyg==
X-Google-Smtp-Source: AGHT+IE6u4HCVe/7st/tEyyW7sTTfYUy8EOrFOJQC5c65VSytgrZCDv3GYWIsJzgHDaN70k9roeNCQ==
X-Received: by 2002:a05:620a:472b:b0:7b6:d632:37cf with SMTP id
 af79cd13be357-7be631e714cmr1746378185a.3.1737317296673; 
 Sun, 19 Jan 2025 12:08:16 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be6147f46fsm357354185a.35.2025.01.19.12.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 12:08:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: sjg+nodisclaimer@chromium.org, raymond.mao+nodisclaimer@linaro.org, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: u-boot+nodisclaimer@lists.denx.de
In-Reply-To: <20241219130554.49825-1-philippe.reynes@softathome.com>
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
Subject: Re: [PATCH v7 0/9] add the support of sha256_hmac and sha256_hkdf
Message-Id: <173731729476.2667992.1360295520121065824.b4-ty@konsulko.com>
Date: Sun, 19 Jan 2025 14:08:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 19 Dec 2024 14:05:45 +0100, Philippe Reynes wrote:

> This serie adds the support of sha256_hmac and sha256_hkdf.
> A first version was sent several months ago just before the
> integration of mbedtls. This new version is based on mbedtls.
> 
> The first patch of this serie add the support of hkdf
> using mbedtls.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


