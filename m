Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54FFCCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A98844D2;
	Thu,  9 Oct 2025 16:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UpSVeo8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D8384408; Thu,  9 Oct 2025 16:18:54 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D7D842E7
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7bc626c5467so847027a34.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019531; x=1760624331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPSE/7m/F1vvEGEpV5pDJhqZaNE+4vBO/F/j7zklsEM=;
 b=UpSVeo8fceWs/YAMhjROFMgdOwps/V11UKp2xMlzqb/hlPLQLJx6K0VSRe7cYBD83s
 okEXbB4FYNKoBThoudIiJYmagmKu1yZvRvaJVedG97FW2bfPA9PM3glVfXRfdGxKTwHe
 0WvRc5+6H0JHO7mJWUYFvp08fXt1VHfJHjEWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019531; x=1760624331;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPSE/7m/F1vvEGEpV5pDJhqZaNE+4vBO/F/j7zklsEM=;
 b=gRSPynlRwWVdgJjv/DMIf5N3ysyJWDPCqMJphFFMdXjewJ19rY6KI9lQJa/WziwB+b
 9nU0mSE24fGFZH4DkBRyyAVifKwy9f8zLzwWD9I5QzBfdx2VcLL+alEt/jEKdIRJMFm9
 hpaOc14/j6ZYcsJMQOJkOlDdvl0qBgCYHz3xjDtVeWewwlDa9mty0HEn5gRffPQkBaf0
 49gQ9O0xpF3fAj9CHfRL0G8oPbKC4d1IBgHls7ndK1P/sgwfcaEOwS4epRyBOBpEOWt5
 SngXe9QJVV0Z7t/0zcVHGrL9ghToZcHB6PFACk4hpbY9+5Zypbg8bqwczmKtKJ/okEXQ
 OldA==
X-Gm-Message-State: AOJu0YzOW7jsNDkOX5x5jFkf859RPPr99DKMgeydGexYIwYmEOMoYV23
 jZ1mTzm77Ja9wZyLWXx9pVNlV7kn/NpbDaKOiAVmjeu0HYZr3svqImSKbSgTwasHmMZuGLTFIBa
 Py2NTyjE=
X-Gm-Gg: ASbGncuJzjBeu/Rtj7ZJH7j99lfBNVCNJkife2JGB1aPbqK44LLgNWpncfkFDxY905c
 jB4mv2rW39d7cFtLSHDCjqWcHZEWzzYGfMN1zl5PAWj2ecvuVROm7gXANVbaSVuxuTa6AeP8TbC
 DDAA5CQ3WP4k7+D2z0QQwgq/PQuV+RZXrPwr5u44LlLkag7nV9UOfuqCvN6+XOjiYWj8+vAQUU2
 zbG7GDhLv17QzV2XvhcvXuSAA3ENMLYN8JdM8CeN2/lykOfsL3WoMYKab0ILAQBA8EjGFvsaAh7
 Yq5X3PfpkRVp1o/D4q9YU71tapVegkUpOWxAZU6+e6EwUSfvqliYAWyqxnTUlnjI38LMv75REnc
 4yF12l0xOacO4nZ7pHGEmDvobGcQbseCWFUGwPTiGUKDZwOG7m8QjfLWDwGTPGPIb4ijhrOP7pF
 TNvlwAPEdmKnYzl78yIIw=
X-Google-Smtp-Source: AGHT+IHDwAd+m6vrDNjK32F1TCpnS3rk4jXMpVi2G6iDnkl3SS25+H3rmMMARatjgkvwYhB3qOsEeA==
X-Received: by 2002:a05:6830:82d1:b0:74b:3422:f33d with SMTP id
 46e09a7af769-7c0df5ca9a0mr4816942a34.0.1760019530878; 
 Thu, 09 Oct 2025 07:18:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:18:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250925205026.3561694-1-trini@konsulko.com>
References: <20250925205026.3561694-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] test: led: Add missing ';'
Message-Id: <176001952985.3159859.11805388390381860028.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:49 -0600
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

On Thu, 25 Sep 2025 14:50:25 -0600, Tom Rini wrote:

> Some tests here had not been compile tested before submission and were
> missing a ';' on the end of declaring struct udevice *dev. Add it.
> 
> 

Applied to u-boot/master, thanks!

[1/2] test: led: Add missing ';'
      commit: 9b937cdaa3a701d106de73ef846d2edd5c818593
[2/2] test: syslog: Add missing include of <env.h>
      commit: f293019b6b9ca369190c620e0232227d950d2187
-- 
Tom


