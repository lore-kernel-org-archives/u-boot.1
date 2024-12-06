Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60692E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 22:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 662F789578;
	Fri,  6 Dec 2024 23:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X9VmSngj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880BE89607; Fri,  6 Dec 2024 23:30:20 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 545588937D
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 23:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6bf4e3de1so84320085a.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 14:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733524217; x=1734129017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M0lK9kGUXqG/S7u6M5LDObhahJ6PiyWMNSUQTZQoUnA=;
 b=X9VmSngjBZiGiOpP+w4GthK87Xh2tl71OMrQUiU3T4ooGlczvOXev7GmD/keSxXCEw
 Eui0ZhP+xcpFI4+K1QtQQSHrkOS4P31lC709i5huzJqLGiMNITqsVIWnXs+n0KYmcG1b
 586AFCndnGOa2Pzeaf8WB/MBWcaAQdgTyz0Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733524217; x=1734129017;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M0lK9kGUXqG/S7u6M5LDObhahJ6PiyWMNSUQTZQoUnA=;
 b=phgTKdVEDTsq26rYFwPCRcqqZrxW2ouC92xZauIl+Lz3a2MGkoNsyToA5dZ91oB0y8
 CcMC9U4/arlcXHAK9JfaXAA2bjsDiB0fjZZoZBZQXSi5aVlAGPVjQvXMSUJ2ajnbKy78
 VCFkMmJclDkKBMJWwFiWRMbWBPENsTD8uTAV2zrez0CSONDs/p4PSyK3VYM88tKEUpbC
 vWkC0pqUPU0fOhkqIss6Sq96UXsWLiNs6Bt1tkuWz9Ozp2u2vRY6R+w3iS1hFNDTJv+v
 Njag19674kv4x+1QurKNCCnMzG/YtxIhg6ne063T++aV7g9OW+IucaViwDScwkMkSuM3
 GluA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVueh2NwBWV3PmsWUrde1NeuG0azfRcTQyyJJMXQx5UNPgNfLXpkPOP6FYBaOja9hmfZpV24Rw=@lists.denx.de
X-Gm-Message-State: AOJu0YysRD+sCqPC1NPKnd3Oh5GJNjzC2Qupzp8lRO0OLcJqOGGUM9rC
 fIM8oum1gjQ1pTn8dxkBWMJHyURjmkO36dMQ0o0E23PuSk72DrWt6KK/4XE7PZE=
X-Gm-Gg: ASbGnctEqrD7PaUShGtQaRSDA7dXcBJ0JLwPRFWfVh1XPKEPl7F14y17R9EwOlWfv+l
 PHeIQXT85xlWReEnMo0I61/ajYZIfO30CIZVe7rSDn9KQ+6hWHljU7h7h7HYH0MMtMiMo1cji43
 YMcbFnDA9nPj9oRFaZqUGPYWN5KAHznZw+zapPgNW0vuBwADqp2LRR/iiMlJGaxFYq9u4Es8xIw
 WfTTL0decb5XzNfl2wmoiF/iupKDTbZLcbrtbTcGaAmGnGQXA==
X-Google-Smtp-Source: AGHT+IH1zkzYJeoUcxcqJ73EeADJj7yXnG6B8iEdqY5GC5nGLBtB5Vkr2f4QYFluGBOB1gJnTCAqBA==
X-Received: by 2002:a05:620a:294f:b0:7b6:78e9:1ea2 with SMTP id
 af79cd13be357-7b6bcac8926mr809242685a.4.1733524217169; 
 Fri, 06 Dec 2024 14:30:17 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a5c69csm215557585a.39.2024.12.06.14.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 14:30:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20241110115054.2555-1-ansuelsmth@gmail.com>
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 0/8] led: update LED boot/activity to new property
 implementation
Message-Id: <173352421474.2540666.11875866338493899273.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 16:30:14 -0600
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

On Sun, 10 Nov 2024 12:50:19 +0100, Christian Marangi wrote:

> This series is split in 2 part.
> 
> While adapting the LED boot and activity code to the new property
> accepted by Rob in dt-schema repository, a big BUG was discovered.
> 
> The reason wasn't clear at start and took me some days to figure it
> out.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


