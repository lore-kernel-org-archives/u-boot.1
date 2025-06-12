Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13E9C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 22:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC80C82C2F;
	Fri, 13 Jun 2025 00:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JsUHZqnG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D83482C30; Fri, 13 Jun 2025 00:15:26 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C57D82AA7
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 00:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-735ac221670so781976a34.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749766523; x=1750371323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDzh1P3ArXwAZ8Ia6yxXC34yK0b445MJtLQyvjphoQg=;
 b=JsUHZqnGR+0S84vnLMhAl66OtHyEcqigDesQuCRYRIwtp1Ou6cDGaB4vgRZ8cGGHlf
 u2o9LyB2/JnlSyHBpP8aNFbek+XLkoQWpZzzeLDx71wanZgtEA/3TjMoaiilcwjPjqq5
 BWfjYQsNHRkDhfMW2P+SQ0ZTIrQODbTQoQv28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749766523; x=1750371323;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dDzh1P3ArXwAZ8Ia6yxXC34yK0b445MJtLQyvjphoQg=;
 b=ByV/s8QUtCrPcP7CZYvzmo1EhAM2L59r/QQWUzSd37W9e8JMtfnsmguaiT6T1lNQ8D
 jZJIggc6d2hoMBddZVxYYwCj/oVNZ4wv79sITPcZdDWdw8R9hfFzE73P+kFIcpNyCTZd
 4wiLrpipWRi/zD04yLuvX9XXxSOq0KyalGnl0SC9lYC9eVdbIF3ERXimu5qq6PT2Obu1
 Q0C/5UhoQwG/0wLaxb7PniZGbL4qpCsM4054K5sdXTsrvOogAT+ozJqnIsCuKH+OJ64L
 MFxi7FH9dtvqLnUhAwy4QvQuLSrCCgwhCAvljoQHXqJDXYXeSMmwgmmlQW166rw4/hTx
 0iRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkv2dcpya0wJiYvXOXSsqTLEDjeT/5GJEUouVPfqwRC/Cg6uy0tqIBP9au/bl6AkaywbvP9mE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx530WnqdK85oBHGaNCY77jP7heodq1j9GorsoaTMKh2N3oBCIV
 IROAt0d6EEQAOaUmu8nLnB3HyYgRjmqVvKanv50R51hn36e78Rdlo2TihJ8YAyX1Vgg=
X-Gm-Gg: ASbGncvZpjpiw+XX/Nim+k5wcDfJ/ZCHLtwhL7h0MdRGtS3vO1GsL8G/OIkWK5WKJKB
 F8g+OlT0iEEQrNw7kUcxem0hIcDmLkXu6o0gf1HjSJr9SSweBa2zv59A7BfAU9XlWy2Rw5AU3z1
 BQrDewiCf8WQ64FCWaOEePqyWn7lWktZuR7YJhZO2PS9c3kMYT0AC+kB3CKNgaHAzhfIzeqUQUR
 toeIc14uHrBnFyMXcXU29aPYwb1F4wzgiATe7nZ3ZBdPK3tuHzypvpztpDKOYg/sv+T5w2grlKk
 EF56DgST0AQKJ7VFrZc2og+RpafPKOb2j9DnUXmJ71/OPSLzfJsE/a47fFmaMdBCdi1qhjpMqRE
 lFAHz9yMHrOHZErMyJtupmomKW51VRp6F
X-Google-Smtp-Source: AGHT+IEf1wcXkOkl+j9Qvym0/4+XYzJnptJBhTLUOKpUgnbG0CmKGJuAtW9CiigMNYxSIu+nDLXFrQ==
X-Received: by 2002:a05:6830:6c0f:b0:72b:7d40:5fe2 with SMTP id
 46e09a7af769-73a27a84bb4mr160250a34.12.1749766523050; 
 Thu, 12 Jun 2025 15:15:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a283e3198sm7145a34.10.2025.06.12.15.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 15:15:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Apurva Nandan <a-nandan@ti.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <20250521072149.21007-1-ghidoliemanuele@gmail.com>
References: <20250521072149.21007-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] arm: mach-k3: j784s4: Call do_board_detect() before
 DDR probing
Message-Id: <174976652212.365589.11863773954985914311.b4-ty@konsulko.com>
Date: Thu, 12 Jun 2025 16:15:22 -0600
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

On Wed, 21 May 2025 09:21:43 +0200, Emanuele Ghidoli wrote:

> Call do_board_detect() hook before the K3 DDRSS driver gets probed.
> It will allow boards to adjust DDR timings in do_board_detect().
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: mach-k3: j784s4: Call do_board_detect() before DDR probing
      commit: 79ae5510a211d788b01cc5cb7f4ad15e9f5f528f
-- 
Tom


