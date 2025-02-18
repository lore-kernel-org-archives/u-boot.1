Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77795C021AD
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 19:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3EA80F67;
	Tue, 18 Feb 2025 20:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dXLYl0fj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C7180F18; Tue, 18 Feb 2025 20:35:15 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C43C80ADF
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 20:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22104c4de96so58280955ad.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 11:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739907311; x=1740512111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hP04EGERPf2e8YNdtTSbbY6SHJRSXaG9+eVsduieh6I=;
 b=dXLYl0fjrmrclzHWVrHuvdYFgYeTDmeHmRvIT+C3sb+ZNQpDJ7ID+ewO0gEdBsobuI
 40+KlVUnqiPgz6Ej5hH1X55d43R2HsKDr6vPef/vRhk5nbh7dlMqNRp4a8ZZdP/NCmVa
 Enpa1V2SXBZctj7yr7Pc/xBxdcnRADr4QB6U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739907311; x=1740512111;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hP04EGERPf2e8YNdtTSbbY6SHJRSXaG9+eVsduieh6I=;
 b=Qpc8lr2GTMDUQsn8h862jQ6nFfmkk3xcGiSCZeBIOFHMhPFJlcxVqlHQay9EgruPbE
 sQTmwtokA3usbcvOZKGK0X2wQy+Iapreugzp0YFedITdiyyxFuHVSU8ARUdsnG4A6HCV
 bBxs9kntZiIpgWOUmMBGjqI5PqtyoWFbIPFMWaX5VHhoQMSlWQZwA0ycUfsfSGhRrAOk
 DLn9tYqgQEWf1c9jQveyH6cKx/ViUCq65W25xu05pSKilIpQ3XwwCphOXmU8/L5gx7o9
 TscCCaxgBlhhqICNKScRCUKkfHyjf89qCRcWw0ahxTsa8h+ePHyNq9P92IE0SNoZub8X
 5uCQ==
X-Gm-Message-State: AOJu0YxAfP4DCBmV+8bnQDHoj1tuUjjxbU1fnzrBJfP2M9sujuFSBCB2
 Mqk/71wwdQg8GR+lgPJ6jiVKl+xAlf+RwG0+X5DfED+J1OS1EGqDgg0xdOzUsxo=
X-Gm-Gg: ASbGncsNt/uj4mMq8M65Q+9HoNRtwSMlGCTjy0opcMyAqGtUqpcyzrGpCbTgT+XuVJG
 jqrgVMZY4U+vqIprXl5pjuET6mke3jB9mB6KaPEDzli4ngWQVpteLOK39FumTWnQU/kEn4fKHCy
 LZPNhA8NKg/RPvgJwaCkn7WiO5qcC19scvW57mWQAKMs1fcXSIcvSOOm2kD48j/C0HvCF1xG1xw
 0AyC8sfnp21kDDVDz2Rv6Llw0PINWk7Nn83RSJEsHdxHaFHRrfykdqFbeg6Qx0zZjSWPJdTG7Iz
 x2Rsq10lOX8l
X-Google-Smtp-Source: AGHT+IEOaEKIY8CnOqWJi1sIsrC6oLSHa/4zsH29FPPV6wa4VSO2AXp9Z2DFKIGruOv0vcSUuxbVsw==
X-Received: by 2002:a17:902:d58b:b0:21f:f02:4176 with SMTP id
 d9443c01a7336-221040b136emr264148775ad.33.1739907311639; 
 Tue, 18 Feb 2025 11:35:11 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d52esm91875995ad.121.2025.02.18.11.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 11:35:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Heiko Schocher <hs@denx.de>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250212091055.117111-1-hs@denx.de>
References: <20250212091055.117111-1-hs@denx.de>
Subject: Re: [PATCH v1] led: fix coverity scan error
Message-Id: <173990731054.1542939.5068117903308728582.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 13:35:10 -0600
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

On Wed, 12 Feb 2025 10:10:55 +0100, Heiko Schocher wrote:

> Tom reported the following covervity scan error:
> 
> *** CID 541279:    (TAINTED_SCALAR)
> /drivers/led/led-uclass.c: 284 in led_get_function_name()
> 278                     if (!ret) {
> 279                             snprintf(uc_plat->name, LED_MAX_NAME_SIZE,
> 280                                      "%s:%s-%d",
> 281                                      cp ? "" : led_colors[color],
> 282                                      func ? func : "", enumerator);
> 283                     } else {
> >>>     CID 541279:    (TAINTED_SCALAR)
> >>>     Using tainted variable "color" as an index into an array
> "led_colors".
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


