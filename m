Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A924DC3271F
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 18:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 072CE88918;
	Thu,  4 Jul 2024 20:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RWlXvoSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D1188926; Thu,  4 Jul 2024 20:50:50 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00F0088917
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 20:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-700cc97b220so483898a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720119046; x=1720723846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VveD9j0VjZ3nwSob4cRsMISkCVCU9Jq1BHks8bGwxvY=;
 b=RWlXvoSjxjepqq0wvECGiwDFr+tKsOSnpTJHLCJHNuSH83Ya1lCXKBp//vwNcajB1O
 pSRcZzPsXWVAA10F44/oT6WK6xEAJFIHrkO9QFvyFdlMpPGFaqU2KnyIS/42NhxDeY7v
 OpbStJUXwHziJ8Pdg/N+D46nP+BwhSf9dTcA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720119046; x=1720723846;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VveD9j0VjZ3nwSob4cRsMISkCVCU9Jq1BHks8bGwxvY=;
 b=PNENe6chl6YcmLolkvEWRSm1/fFIb7yPt6upDpQSN3Oli7aistfQ9gt0Sml3mKcRAe
 6k1O3TsyEP7nBeigfMU+Ks+urBSL5Qb8UG+mNOrCbaZQ+ICfh5YIdDOcHb29XtMJay1E
 5W5IpCtpHrOmytIoFD7t3kbw7lURfk80Y4nQoNZFUKYqLXu8RL/HvV4brSc67y4z58lf
 4JDb4HiVnXRdXRF7g4S+SJLXMkFnRZgRNiSmZjJ87QijaGyFvurDHfAREssqR6CD+T8C
 UQu5UAb41uq3YxpOnkquPDgIza6733P1/9vLoPntake8uCEzlr4m3LjH+JFbrxZYYX7d
 wSOw==
X-Gm-Message-State: AOJu0YzPA1ZNGNmk1PdECYWFZ/QS88eSJwn0qUctXbsQPqZg+hdoYVu0
 NrK8dnwAy/vuFYgMXvUBX287KkMOskt9jkqtYO1fIeM2fBQ8zJVJfsndVp1iGZpRnoe+uD+iDW5
 zqI8=
X-Google-Smtp-Source: AGHT+IFheQk05VJZreIBDhqJ26V+MaCVpLl5JCEXNi1ws+Qkt4QFiFaFio2SrYX4rQgYuT43cRl1eA==
X-Received: by 2002:a9d:7f98:0:b0:700:cc42:74b7 with SMTP id
 46e09a7af769-7034a74f3c9mr2792961a34.2.1720119045741; 
 Thu, 04 Jul 2024 11:50:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7ac8dccsm2454997a34.34.2024.07.04.11.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:50:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20240618202343.3332529-1-trini@konsulko.com>
References: <20240618202343.3332529-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py/tests: Update some network dependencies
Message-Id: <172011904490.1502730.2321122459261449781.b4-ty@konsulko.com>
Date: Thu, 04 Jul 2024 12:50:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 18 Jun 2024 14:23:43 -0600, Tom Rini wrote:

> On tests which require "tftpboot" we need to depend not on cmd_net but
> rather cmd_tftpboot. And on tests which require cmd_pxe we do not need
> to also depend on cmd_net as this should be handled already via Kconfig
> logic.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


