Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA58C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E538792D;
	Fri, 12 Jan 2024 09:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JWjMBcz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A3487980; Fri, 12 Jan 2024 09:40:53 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE1287142
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3376ead25e1so4125476f8f.3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 00:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705048850; x=1705653650;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gdJgqujDt+Z5ugTl2V8rJkNWcMHo7h8Wp4OqLrioad0=;
 b=JWjMBcz1rdVyrjspnSGqejpAyXLacDpAqDQGueMABBUmDTzTmJJVJpjr3dBeFoDt5b
 Nb86nBb8qioD0LocrJICM9Oh+quH9+0qTLCEAF8JVP8GI9jAJAL8VZcFMe6uVzZtl5Is
 S/2wk2p347LeiGayQsd5iCVLJLH+MbSbBkxRqihTU3Sac8whWLxdaQugnMli66gYCEGw
 rK4dHxUdJ2r9Suhm+bet83WH/cwhGrxidBT7hS/eKuLMdwkOZqmQvzE86AZyKeoBnUnR
 4auZVEcZ59xbrCDLHnD3yZvftYADRSUrQv+GJBi/+1T4BAqW9AOxWQe4XMIFh0hF/sBq
 JXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705048850; x=1705653650;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gdJgqujDt+Z5ugTl2V8rJkNWcMHo7h8Wp4OqLrioad0=;
 b=p+Df6E5C8rNSQp4VQxvDdoJhZNtTRlmc/DBYD/ZrcKeG6iZT9NWL6d46wL1+F6FM8e
 +pkteKi1Ir1QW8AFGTjqLWCXQu5WThnIVmH7AvYezhJOxH1d+SHUEkuCya4qzp7rATRL
 daUfC7wv+gXF/UnjxTXazX/huACDZa7vi00beyt5kU6WI1Syt6gJbWf/RzobFOCoPPNm
 DnSwcuADKZlyzZQ91PgiH76iz5S3sXSBlkf9PPXM2P3dvKDUVtwM8MS7QKqZcaByGghw
 NdAqtojUENqhe/ujFxQPs8dXJY2Z5RgBhIMP1bDThco3BGzDoAFIZwYVwTTUjWNvUbbc
 6aXA==
X-Gm-Message-State: AOJu0Yz3EhBKAuFaCpa/8PsrIXb+a3+9KEysP3hRd8ApUVmwKqW9kGZT
 kbzpjf/aSTOI+ZapzXzcjTxUv8Sb+6sIyQ==
X-Google-Smtp-Source: AGHT+IF+wl1CwkSbXJy7NK2QoarDDsoobLXvvu7ITJfiJFiN25MAUlvDNuRvJmbHenSneYChoUU/Gg==
X-Received: by 2002:a5d:6648:0:b0:336:ca00:4801 with SMTP id
 f8-20020a5d6648000000b00336ca004801mr470220wrw.122.1705048850582; 
 Fri, 12 Jan 2024 00:40:50 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d4a07000000b003365fc41bcasm3202118wrq.51.2024.01.12.00.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 00:40:50 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/2] MAINTAINERS: add Mattijs for Android AB / AVB
Date: Fri, 12 Jan 2024 09:40:43 +0100
Message-Id: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAz7oGUC/x2MQQqAIBAAvyJ7TnAtLPpKdDBbaw9ZaEQg/j3pM
 Ic5zGRIFJkSjCJDpIcTn6EKNgLcbsNGktfqoJXuFKKWh+VwVygmaRdJyqPDoe2NMVCjK5Ln9x9
 OcykfYpDyy2AAAAA=
To: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

Igor has not been active for quite some time on lore:
https://lore.kernel.org/all/?q=igor.opaniuk@gmail.com

It seems that Android AB and AVB could use some help maintaining.

I'm interested in helping with maintaining the android_ab
command. I'm a long time android/aosp developer and my daily job is
still doing android work.

Add myself as maintainer for Android AB and for Android AVB.

Note: the patches are split because I discussed taking over AB
privately with Sam, but I did not discuss taking over AVB.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Mattijs Korpershoek (2):
      MAINTAINERS: add Mattijs for Android AB
      MAINTAINERS: add Mattijs for Android AVB

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)
---
base-commit: 2ee7a8ec6f1711abe9619fd8765edc16742be9de
change-id: 20240112-maintainers-ab-e0f1c1837666

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

