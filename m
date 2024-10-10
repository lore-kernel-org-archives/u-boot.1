Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB14D24454
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 21:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FFC38927D;
	Thu, 10 Oct 2024 23:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pRz4Wu8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033C2889EF; Thu, 10 Oct 2024 23:34:17 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E37B888A3C
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 23:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbceb321b3so10948026d6.3
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728596053; x=1729200853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qP5YChChvyxWFcL5VyAzL4M23ebTiDB1SLhHNRYouJg=;
 b=pRz4Wu8YRobl/HpnI7x4rj8tcIupnEk2kwc2yuRn+qkUgKGOxWm70CStVZN/JXMuAi
 kFdV4tQ8l7xVHE6XKOzwG1jTu/j8b6agA7CitSkrITstIrJj36plyJvr0Js5yqR1druw
 fzggncNG/BmG48F5BVgcdMhV6aG1bjcUtXG8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728596053; x=1729200853;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qP5YChChvyxWFcL5VyAzL4M23ebTiDB1SLhHNRYouJg=;
 b=W8U5dcASGkZlhM5G7TI4nhKot6cp94atGDRsmXw2Y4wwJAyoy1/JQfapREo2jfcFe4
 TAIRKn1c6RlRLrfrUgo2MXLTSL6G4JMRxS/h3FT1BGTI19kVDXHPboaDyJOS1J5rtyRx
 U2qB52lu2CFO/nidPEHTVH5J9S8+qxfNr9V61xkoepKk1Ff64uFYLJZbRXN74zTTS54m
 HnkteGFdmcjA3UVdtyf2lDZdSj7KAE6ynXBGjxG2z1UFMUj5/PHxosllI0+N7NDkfjrw
 LY27Zk6EzlqKaW6+0ZB1xSmufUP87TW7bjhO+co3RE8zSqf9Dg1xMEOFLDLzuPoJsLyr
 U4WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkdn0Y1wHOoicboS2UZdobCINxRRPAq9Myy2SaIt7NaBi8YiyxQ8LsHsed0H3lyNfaqIkhgOE=@lists.denx.de
X-Gm-Message-State: AOJu0YyiM5PPg43/ZFkDKO39PHjgyxNoqXb2QIrtsGzelPZCP2B87xF4
 4HYw/WeTbl+5y7RfqUhRfAZMrUSw/MyKOo02GDtU9l5njMx4IuHLFKydQ7whP5I=
X-Google-Smtp-Source: AGHT+IEAhMoFt180Vps0YtFl7KTqiacQK4l5RxersUtp/8CD174ArW6ciLEfN9z+Qbt+wXXBUH+2sw==
X-Received: by 2002:a05:6214:3289:b0:6cb:83a5:8403 with SMTP id
 6a1803df08f44-6cbf005c186mr5989186d6.50.1728596052713; 
 Thu, 10 Oct 2024 14:34:12 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85aa56dsm9096566d6.26.2024.10.10.14.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 14:34:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Fabio Estevam <festevam@denx.de>, 
 William Zhang <william.zhang@broadcom.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, u-boot@lists.denx.de, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240703010934.1735889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240703010934.1735889-1-mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH 1/2] spi: soft_spi: fix miso gpio property name
Message-Id: <172859605058.435814.5578227529870247925.b4-ty@konsulko.com>
Date: Thu, 10 Oct 2024 15:34:10 -0600
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

On Wed, 03 Jul 2024 05:09:33 +0400, Mikhail Kshevetskiy wrote:

> The patch fix a missprint introduced in commit 2e9fe73a883a ("spi: soft_spi:
> Support the recommended soft spi properties").
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


