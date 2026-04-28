Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87603FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 21:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECE4846A7;
	Tue, 28 Apr 2026 23:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="DZoJb4uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2BB0846A8; Tue, 28 Apr 2026 23:15:15 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34073846A3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 23:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-68244d317e5so6946787eaf.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777410912; x=1778015712;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JftKLfVOwOyBio0J2bZAy9ie/47DVoJehAPdL8dKXho=;
 b=DZoJb4uchIgXGnRSnHe53JrbbYh8Ri7BfpKAtpRdmanwpCldxCiLz/u6k3CLYx86dX
 uTrE4sFmelnonZANCGL6jgXKaHgO9/rlU/fmeeYZPZYHDCtm7QgJLQoc7x5Dw4b2Swon
 lZe2sp0OlIWAMM2aYc+WWsfCm1MTPozK26C4at9IUHje25peEboAEhQPpSthuNnfCwTl
 Q9b6aqfi1cKDlYwHfINmofCvwL9Hq7YK3MxMgbbbDGgviq75g90diK02IcEL1GwCS7E+
 uaPOb+SJuJhcPP6OeUypJfu6fKZRl1hpfoQAoDDUTYGpAEOA/IyLujVHFrW9/qaUXvjs
 5BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777410912; x=1778015712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JftKLfVOwOyBio0J2bZAy9ie/47DVoJehAPdL8dKXho=;
 b=WrXCVDnBYe5R5pg2SAY/PjwbP8jQo7WFMa+UoUY5ab8tE4mpSW1rSQNCrAVDm0hUYl
 Yo4+q8fN1Nyz87KPjJs6gnmy6vyUAgDMs4xsHp9qbF5riS9wPozkkVyhbKzS6hRvZUze
 x/i39JopI2+etUphQxYWU7EGhwj9hwDZ/5I2dUnmAlkkk9u2jw7t9jLlUw3uKVA5+VtD
 cL5SOuYdL/f7JyRepwCXYocSKZ11z7FDBnLCVyzfvQ+FQ9IoupTW8lO2VjE3lZu53sGT
 489Qwbfb8FYw2Cu0h4ruZ6uAv4brSKLoQnYmXnZUBdPgY7+OO6tNhWvD6/dCvwMiwnXl
 SCrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oHzDMNFz2Iv7Ox/syZleRqfs2hYRJ5Ul2C/xdDUfyRw1TQ5JPNwwWN5keZHoCe2ecbKZAFrE=@lists.denx.de
X-Gm-Message-State: AOJu0YycDtvdMZD2ru4Vo84ASErexOd3LluWKRo8OMDQQmXbtb2SsQzS
 sJaBiJow7CwUNs5y42On+R34hc6hPb6Sh34yFvWJrNFfCJW43UT+IGjCW4Q9CXm3nuk=
X-Gm-Gg: AeBDiesp0P4ID3fEM8nAhJ4zg5n5jKxSLWKY+XZhGtx3Jy83CXJ2Kw2Ahxue+RRR+Ko
 PHe2zJL9LqGC0EeYe3bFxzmsHpavBfpp41IiMJc18BSNBHeF5HSm35xEe30d1d/FWBGjdIlBug7
 5tGBfOeZHj0O5pBJhDaiG7bHOtM/X+7MMFHQgTq6ykcTr3AglryqH6KutsRqp9hTh9HYbZtcO2O
 8BxZgvhH0OdIhB9cAMYJa+HFdMF0i4IGVaa4mrS9sLXNqnEDTRsbnW/RWnFchbs7fQ/Q9MLmwba
 owRiuaOOisalRDKSLj5hEq+LcDJP3eOtf4Z7S0kea4jIUNEK+dASDjM9Qkm67WClm+Eo7deQZGx
 VM5BYzZiu3c5SmPmVrZbF7pPkYm/NzMu85zbb8Awezl5or9DdSmB6oAcP3RPUv9qGihzvDH6dFi
 o6W83V3SfcAtvLS7jWN0BsfcXL1mbVm7RAtd0l1u7AKfQeIhf65sB7sihgjGPnMNOIMK3PfOAA8
 LH04/AvteQl
X-Received: by 2002:a4a:e904:0:b0:696:2509:1ff2 with SMTP id
 006d021491bc7-6965cbe03eemr2828105eaf.56.1777410911918; 
 Tue, 28 Apr 2026 14:15:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340e919d76sm300990fac.9.2026.04.28.14.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 14:15:11 -0700 (PDT)
Message-ID: <ca1e9c61-accc-40bc-a8ea-6afea4d0bad2@baylibre.com>
Date: Tue, 28 Apr 2026 16:15:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] configs: airoha: en7523: enable pinctrl/gpio
 support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
 <20260428153448.980150-7-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428153448.980150-7-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/28/26 10:34 AM, Mikhail Kshevetskiy wrote:
> This enables EN7523 pin controller and gpio driver.
> 

...

>  	eth: ethernet@1fb50000 {
>  		compatible = "airoha,en7523-eth";
>  		reg = <0x1fb50000 0x2600>,


And FYI, this ethernet node is missing #address-cells and
#size-cells which causes compiler warning.

But that is a separate fix for a separate series. :-)

