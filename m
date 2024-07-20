Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F3AC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9E58885D;
	Sat, 20 Jul 2024 19:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ReTCdL9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4018D8882D; Sat, 20 Jul 2024 19:10:16 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 757D3887FE
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7035c367c4cso1492107a34.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495412; x=1722100212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSlzYeiivpcN4Cg8DkhEjEZVf89S1XB3p7R0w0JQYMY=;
 b=ReTCdL9LZq17ESI4zWrbHd3UTUzlayOwfjSCIaIE5wZ3NGpaRZLFvaZN0jTIgQ8Erm
 n7swOl5hW4olTvHVggeb/ZY6MDNP9F8d5eRRa4viQIOfBjZCW3pKobTFwyVOlZz2Y/o7
 WNjCnaQ0QjWQnA3TL+TSp4IHx6vrhFCJkzg4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495412; x=1722100212;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSlzYeiivpcN4Cg8DkhEjEZVf89S1XB3p7R0w0JQYMY=;
 b=FQdVIMiBJGo11llfK91Nqc47NAOZqDOm6LGpMcYFPZf9L2PueXyOXjqEoqNA61sF8H
 MZ+23YGd7b+vaY2n5nMM7yV3XhHNeZR6Mt/h6Znw+ymV9xXFXoTAd3SZb5Wtptg0zR7I
 jjGdpriUVJxa/nQo7ZLDVMCXqfk+zKDCNxoIolyXnPR0ZWPNFYTZLITdqh2P5cg0GoE/
 TAkdtxxpoLj9sVDG47/X73VlxxFuZOESwVttpQdgyWpoAQgofjruGYWnBhXu5Lqj3GeC
 SBvt9yFqcRF8R4bymzumogeiAwrO4g3L+iMhgQe41ow3cm1ekqcCnGhx6+m+HCyqNV26
 /zyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzDFwYPPYYKEte/yXaip6vI2vy4RA/7l3kLlS2+eVHAu4Uz0yYVjyM/vFTXoDyxPWBUGmiuiyzvhIKF23y+bhbfPJ0yA==
X-Gm-Message-State: AOJu0Yxqz7+L1g64CwXsQR6DP7V5w+B40k/vQL6uPx1MkRrCrQJHNo0n
 TQz54Tsp+9I1WhJLNWK6KaQPsMtAOuvfIYnkFVcldP+AmlKxHbyICW/XxhTlkZuRPiuKAgymmDJ
 S1Kc=
X-Google-Smtp-Source: AGHT+IHruPz9p1HBsMDpuFPqqz1eAKRDNU41TRtK9ZRAApPm856taGbu3CJBO+viljzfofy8YgFjng==
X-Received: by 2002:a05:6830:3814:b0:703:77b1:c653 with SMTP id
 46e09a7af769-709009b1172mr2948508a34.24.1721495409298; 
 Sat, 20 Jul 2024 10:10:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189bd5sm773037a34.65.2024.07.20.10.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:10:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: bb@ti.com, nm@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20240715111550.543037-1-n-francis@ti.com>
References: <20240715111550.543037-1-n-francis@ti.com>
Subject: Re: [RESEND PATCH] soc: ti: k3-socinfo: Add support for J721E
 SR2.0
Message-Id: <172149540773.3268377.17030858622030082014.b4-ty@konsulko.com>
Date: Sat, 20 Jul 2024 11:10:07 -0600
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

On Mon, 15 Jul 2024 16:45:50 +0530, Neha Malcom Francis wrote:

> Add support for identifying J721E SR2.0
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


