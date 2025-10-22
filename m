Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6F2CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 17:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9774833AD;
	Wed, 22 Oct 2025 19:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WQCGnn25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC558004F; Wed, 22 Oct 2025 19:26:21 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DF88323A
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 19:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-43f715fb494so2208460b6e.1
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761153977; x=1761758777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pd+DXftqJLA1NF4AhwFwCQhZJBiYyCUQEo4FttgzHQ8=;
 b=WQCGnn25W6yG07RmaVf35zkDcO3r9GsEjdwnYx/1tSLFmAT7XyWvOXmPv/ns4FibtH
 6Txmfi1xIQCVhamAf+j9h4vrx4LJPLQ4mkUB9pn0Sr2/iy5zQk/yt6d4PIAxXf+a8Hz5
 4ohQtc7EX0xL0ZCxuovqHsBY0fiq5qPHL9P0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761153977; x=1761758777;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pd+DXftqJLA1NF4AhwFwCQhZJBiYyCUQEo4FttgzHQ8=;
 b=EHBD+W1QesSzs+6x8io1XizxyGNTphZlsIroQM78krxnN/zPDnYUMzSykeNTZrDjmP
 jhvzZyZ5y0gJgy2L7yq/6s/RD5EtVUgkDKaFzJXKkPG6UbKsWP3T97y1FHxRxXimXBCu
 bZN6IdOCDPfCtdF59nivWcj4c9n5FMi4nrONNUNB4Cxqa5ETLICZPrxUmRLe2xGIR1iM
 XItYFigHy8nTn131ax41iQC3uCo9sqPnyAI822cZr2J7yjk1utFobv8hRh6TALabMde8
 LO0WhPAJ8Uk3utPnFjWSD71DCWLyyDRsbsZTIye1lP676haR2LK5G9widastBLD46023
 UuZg==
X-Gm-Message-State: AOJu0YyaJ7jZ8B+A4rZESPdtaDVJrElbJbdVyx+0UdNDf6L99UIlSPzE
 6UM8y7N5D6xI29iq5bIjjVRHoTu0+JZvDI50M6QF6y4mUHo40a0bJFBXnDFR20/CyZUozB3ocxx
 uipEB/omdaA==
X-Gm-Gg: ASbGncvsL1DB3wiaS+uFs7XFPLFcXxl09jxvt52UcXhFrsEynWwNqH5DlmQFXDeAztA
 TiPEWICcUMTRt/uzboeOWUhqRHjE4taZQidqIA/35aowtFX1XezpomxR071SDjJPpnCBzxABn6b
 9LYuBhRHdJRV5CLef/SaLv/3Ijz3w0AQ8gmHNLd7Xi6qjKcPYFJlqPYb37QRlK2lHilcxkwkfBq
 9oP5GGkS4LyGDK0jp9F9ue7pso6Zu30dRFwo2zj5lnS4m5FpwcU5eTURNw9c+J5SqYp79WsPNtg
 ptl7LNbhRt6WhZlD5YA3/YOBg6PjYu3G9rBlAw4XpnSM4yoW9Th5igUHlt/okLeRi+UNStMpIOh
 Z/mPeAvkaA254jtOdLwBc5UcLs9uC3lR7AUFcj+rRN9m0+ctczgYy4PZkrWg/m5N4Ph4gZ8y8PJ
 AytVOh+xhOk0h4SjzWTyUbaJwTwUSdZmroi5yTwvV4QW7ICL57
X-Google-Smtp-Source: AGHT+IGrg4AnwfhcODJhp5mhlIkBZPks4AHs5k1GI5HsxbnhxQTfin9H/EKS+d8QP3+LWIw8khRoVA==
X-Received: by 2002:a05:6808:1a17:b0:43d:3ba0:1ac9 with SMTP id
 5614622812f47-443a30cea54mr9042198b6e.41.1761153977656; 
 Wed, 22 Oct 2025 10:26:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443df20786fsm3453493b6e.18.2025.10.22.10.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 10:26:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <8c1297f2-e6ad-4f2c-9cc2-49ad1df29e2b@linaro.org>
References: <8c1297f2-e6ad-4f2c-9cc2-49ad1df29e2b@linaro.org>
Subject: Re: [PULL] u-boot-at91-2026.01-a
Message-Id: <176115397699.1634412.1751063357355407559.b4-ty@konsulko.com>
Date: Wed, 22 Oct 2025 11:26:16 -0600
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

On Wed, 22 Oct 2025 10:22:59 +0300, Eugen Hristev wrote:

> Please pull tag u-boot-at91-2026.01-a , the first set of at91 features
> and fixes for the 2026.01 cycle.
> 
> This small fixes set includes a change on clocks register value and a
> fix for the sam9x60ek default timer.
> 
> Thanks,
> Eugen
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


