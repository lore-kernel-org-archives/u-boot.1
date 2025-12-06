Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85009D3B7D1
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 14:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BE9839E8;
	Sat,  6 Dec 2025 15:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IZdWlkfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC63E839F1; Sat,  6 Dec 2025 15:10:56 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A3C83979
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 15:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45085a4ab72so1613138b6e.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765030253; x=1765635053; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UUllkZab6Cbz8xtlD6A7w3EWon01ADuB/Vew2VcTBa0=;
 b=IZdWlkfNK5fjrh0VDhGsS6CWj5RzswXLWE9tlcD6SjU0OVCL4RmcodYrX2gpx9Fkzu
 CHPJ6Rex/3p+62mD/ZiSpAYsmhEdnfV4SB1g/cYBFcxOyoIVsPrXC6TFCENXa7rBxU/J
 l3V7dUDzNE3KMxIn3qJBy6MQbNHUQUOvCUjes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765030253; x=1765635053;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UUllkZab6Cbz8xtlD6A7w3EWon01ADuB/Vew2VcTBa0=;
 b=FPR2MUiOKafGevoMeJXpiXv352Db4ZmpGEfHaz78g9/XN4qq/XBWdj3l1Dz4AnynaP
 2hEAHIacL0QX5wua8ePJrAO7x8DA0dAuXKpAUz415xRVobWzS51Hsk6qpp0gV4aJIQrh
 sCfbjItmg0cJUL9EG9pJIzMbxKiZgRP4kZTkEkU2VfQ3nmjzw4ZCAuAzLzhtg3qIalZS
 jzopv9gQz4K8Jhm39dA1pnMJFARBEMeuqwRD/asocvAbznJRTKfw3wvcI1a6P49fz7fL
 J2DiGj/Ox5OBw1NRp3fuKK5EHvfSMfHuvwEe2r2HNtBmW8POzwlyQR6oe9F21ctinUa0
 NDrg==
X-Gm-Message-State: AOJu0YwuHawgDtq0qbotAi1GX+NtR57+8ABaB0Tdauxoz8kdtQo7tYKm
 l7R5Bh0PCv1n4BDj1cmSjjECNJv54C2UA571sCtKijrUdy4kn4dVFkKa0NTOk6kp6YBvGDyczyu
 u6Th3ViI=
X-Gm-Gg: ASbGncsulEUjp1CjH7kIAJ2Y0FyVKTjnXS8Ipdx840jYfd+f01gPKF4xZhGrN8JSR1a
 oEScc5xg5O+psoNRUMVZMc+V2Ps7XVkuxZkpkA2MhAXGOOhrkoAElh2bl+6eWAuqWT6+7GbbAYP
 1mkJBSOwEAqwar94rImx8tIN3+Pj7RylrH8p05nXNOFpg7fgo0jJozSE5lc8lzuNKm30tPk2+jG
 xVJbroTQ0MqNmKpcx+1hwjr4E08aiMQjaksjI1CZ7ZTGsg4HMb5v9VOiYmNOPasrKlVZwLaQLqy
 cx8pbwpy220DPLUXUGOVBxfmnWl5WVCarZgCkjSZVMYaz4axeidt6PQx+3xudBwtVq0FEEn5Ku0
 8thBf71T+WvQoxL1s4fVYgKVkAPjCvdt6TV+h2UnEUgMORMCKn3vCef+9IhTqC8dLrWrvsUCFve
 atS43PjfJmS6T4dXRDUzEx+5axAH0EVcrNbvm1uy6dQ6QmStjR
X-Google-Smtp-Source: AGHT+IFJmqtJZioTiyOX8JX/y5gRrbKRy7Cr6tlVOZFMUbiSqOYCsT8O8KzoPZy84FZZvtO2gOJowA==
X-Received: by 2002:a05:6808:2104:b0:450:4443:6421 with SMTP id
 5614622812f47-4539df6fe07mr999403b6e.26.1765030253419; 
 Sat, 06 Dec 2025 06:10:53 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acd733bsm6078499a34.26.2025.12.06.06.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 06:10:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
In-Reply-To: <BESP194MB280527E186AFA71E91BF5295DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB280527E186AFA71E91BF5295DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v2] firmware: ti_sci: Fix memory leaks in
 devm_ti_sci_get_of_resource
Message-Id: <176503025271.2523567.11529309442182851712.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 08:10:52 -0600
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

On Tue, 11 Nov 2025 11:30:19 +0100, Francois Berder wrote:

>   - Fix temp memory leak
>   - Free memory during error handling
> 
> v2: rebased on top of 365a7079fb918643da0f0709660a7d8ea76dd6f3
> 
> 

Applied to u-boot/next, thanks!

[1/1] firmware: ti_sci: Fix memory leaks in devm_ti_sci_get_of_resource
      commit: 00e1fed93c8c3e4c9037741ea1b70a9e693a6e65
-- 
Tom


