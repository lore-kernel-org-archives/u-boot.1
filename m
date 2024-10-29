Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443E9D74948
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8457A891CC;
	Tue, 29 Oct 2024 23:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XAvkPDOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B72F5891A9; Tue, 29 Oct 2024 23:28:27 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051CE87BF4
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b1474b1377so469226385a.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240904; x=1730845704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7fzxASbTMCGqDmKQxqDenl4putZ0YMekwIDC5Cq0vA=;
 b=XAvkPDOtrQX6HgivVrQYEF+j098klcIjt3OIp6cK2L3vNydL5kMbpAyno2lcN6Q48X
 wlNwkFhXHR1VDiNkRoqhNL+m201NK0FTOgeHCvhIOGCmsbju2/hO1gGqANjvK68zNOMa
 ZzYKkY9WaVjoiqXACxgE61+5MCKbk7+Bm/Wa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240904; x=1730845704;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7fzxASbTMCGqDmKQxqDenl4putZ0YMekwIDC5Cq0vA=;
 b=AZVQ+XinMCROqf8em83PlZTyXzydcarWtpTYAzZgmfgq8HB12l1+1B6JJot6rOCYtZ
 vzCi4N5XSG6592Rt9r5arH/p69O1Xnv0cYCUCWaHTid7jUaEBuvB0aAeuAXyBrObHX8s
 VBE1jX56On5SnvfNYqwLyeLMSVHW8kbYwbsPjtbF/fXSRCqFUFasqM5yOcQgEgsKxus4
 keU0SaOqzlpjW0B0KDvqzW9tkYHtv0VStsqSTmt88x9PqNwC7u4BoUeMUFKCj5onldL6
 1uKL1kRJFlaxa5leuBdHMxGfaUXur3wzQ6bz6oFBu/DUw6x+m3jub82R1KoudB6c7S9J
 Rfig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8xttLl8vaN9ocW/euBTKh4KzD5rp3IBlhFJG6P1ojB30uZhiJlsv6F0nOHwztFihZbC2D4Ak=@lists.denx.de
X-Gm-Message-State: AOJu0YxCgNFNk8z0RXc7FCjdFeKSEA/vscqlhzopt27nD+qw+sp1MFEP
 i5VqSJA0gdcsnTeLDnsmzq5NmBmrK7T6otL6HnCpV8hp87eUFfV6whTv8dsvuMo=
X-Google-Smtp-Source: AGHT+IHZMV0oMbpDQ/UbF1AtuKT6Wizg9K5auH4m1PkrXwTNQAy//WrgLUTNWE2zSwH0Tja1d55uzA==
X-Received: by 2002:a05:620a:2a02:b0:7b1:43c0:3de4 with SMTP id
 af79cd13be357-7b193efd705mr1860590885a.31.1730240903790; 
 Tue, 29 Oct 2024 15:28:23 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Artur Rojek <artur@conclusive.pl>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241023052750.1067020-1-ilias.apalodimas@linaro.org>
References: <20241023052750.1067020-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] board_r: Remove duplicate headers
Message-Id: <173024090198.2563570.11273581215179330789.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:21 -0600
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

On Wed, 23 Oct 2024 08:27:50 +0300, Ilias Apalodimas wrote:

> efi_loader.h is included twice. Remove one and move the other in
> alphabetical order
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


