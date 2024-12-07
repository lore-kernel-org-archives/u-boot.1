Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959C6E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 15:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAEF68919C;
	Sat,  7 Dec 2024 16:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M5xrq5v5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFDFC89338; Sat,  7 Dec 2024 16:57:14 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F55F88EBA
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 16:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4668e48963eso29944891cf.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 07:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733587030; x=1734191830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeRjsfFokRMZrDUzhzsMOkqKZgPxaLS3L5mFgOG/pHE=;
 b=M5xrq5v5zQw84LZW/kOEIFl4NQtcD5zuoNIacBAOH0+Rvxx8elcSLOZoRLi+A9RAU4
 FcnICZ3PGoOBetmwmJtf2Usqh2AG53Q8wul1emPWlgUWaYm8+Ga4+qPrSU6yZVu7pxZR
 6ey3JMHvUpgHPzX2041R8UN2cNqfo0CcUGaUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733587030; x=1734191830;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TeRjsfFokRMZrDUzhzsMOkqKZgPxaLS3L5mFgOG/pHE=;
 b=jOGNJrSnU7RM08YEmnf81/4mglNlzoYVuContb60V/E6cgsEyMB2iDocPrFaAPi5Lb
 do7EwkOdmXvwLVstIXq0vftTk54NplOsoDb7gHiiNR8VIhBd12g0LoKDkMXmN77iLFJh
 EO991HY8V3MkfkQFTxPzrsL3iQPh02DvqU8XX6kzg5wKcC92JFoWhfJ7GSsM13oVwCrp
 XEgmmKBM4Fe9gpl/pGw3buVzHZe8nsBC7tEpb7W4B8PbqniOw7jlRSkKh8uTqNKi5xDu
 AGR/w5Z312Qr2lSDi4Ekrtge7UHbPxxrzERpj0XDXDABtkwmh4DGr2I78IJdkRTYT8ES
 31Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXq121a4c3b3RMaTUF+G/jrfD2Tze12W9QICRspWnJZV6ofVgjfHTTT27kKmO4k1ZKAeGyaW8=@lists.denx.de
X-Gm-Message-State: AOJu0YxarMdVR5sXbFWTKcWfJB8zbRbPTrwPWKsyPJdzkMeGUKJQtsTe
 nFH/UTzUJzKp/FD80iK3/qNnaulIq9LWUvpH7sea6tAw8gh1BKqF0pf3uT9YjQ0=
X-Gm-Gg: ASbGnctpzQP5yZkhggq/74T0KBxUJTEjEcm5nwIl5KUWwQQOnyAwseE35tiT9+/93NQ
 6C7E7ut2LbkMpH1LLgw5D0UN/2F2Jzl0AmWu36OP0ao2Z8EtJj2RZOqZB0JifQm51UJFiXI2WQl
 yJjtx8gETLumNEePT80msZSpiPQYasA7W6N27p4EIH95S/9DDvWYfNwalHlHHgQgFtj5ixgPj6D
 po8sYSZgyZ6SCB1Dj08I9jXtAJjR9nEYLECIT6ehwggRaSI/A==
X-Google-Smtp-Source: AGHT+IHr9z2QQL9BURHY+TyNOC54t9uLP52jnpd7pvhZwJZfVK9xO3BbUAIv+OLMlOMvrgksd5db1A==
X-Received: by 2002:ac8:594f:0:b0:466:a060:a484 with SMTP id
 d75a77b69052e-46734ce1f9dmr110574771cf.27.1733587030514; 
 Sat, 07 Dec 2024 07:57:10 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d2f15sm32998151cf.35.2024.12.07.07.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 07:57:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
In-Reply-To: <20241206113710.11689-1-heinrich.schuchardt@canonical.com>
References: <20241206113710.11689-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] net: disable MBEDTLS in SPL
Message-Id: <173358702795.3722028.10721248349508182096.b4-ty@konsulko.com>
Date: Sat, 07 Dec 2024 09:57:07 -0600
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

On Fri, 06 Dec 2024 12:37:09 +0100, Heinrich Schuchardt wrote:

> Building SPL fails with MBEDTLS enabled.
> Currently we don't need it there.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


