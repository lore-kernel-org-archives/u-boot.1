Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C95E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 18:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6038B89739;
	Fri,  6 Dec 2024 19:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="brI3uda5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E8A88921B; Fri,  6 Dec 2024 19:58:59 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4441F89740
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 19:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d87ceb58a0so18937736d6.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 10:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733511535; x=1734116335; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtZ5MjJQjWpNaoXqd7UXcEkBqcp47Knjd+ygFLp90VA=;
 b=brI3uda5qlFmfydD4JllzYLZ69P9818erg+6gQOMJMh1UQw9H6U3A0YH3lRUjFO8Ob
 qaeU1eer6a150ors32AfjzZf8JKwBqpICNBOUGxh925dCURaTGG6vCNl9ER89t0RQLw/
 9fAukE9zVFVT1ieg2WW+O3cBfxYSm2lJOTlc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733511535; x=1734116335;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtZ5MjJQjWpNaoXqd7UXcEkBqcp47Knjd+ygFLp90VA=;
 b=nhFV1Qf73J0dFUUfiTpHt1rKG0zNBfzHq9L0azeSrI6IjtkCCcd2mb+IcQG8BtwgjW
 ConQ8gE9H8jb5W90empSuhl0GWZw3TqhaisWW3BfIUg1q/nAkBad2HqenPmWiji/redD
 ZBINOr6lzlbhvAxWnU/PjpU3Xmjyo+NQi94T3cRIVQWTGVyIeaXJa3vGn046tsxO7YFl
 LfuIuT545B7JnG7nE/Hllg0J4IZfdVl+YVYBynrrqxHgFOaeRLN2yesHFiX5vfzwBKyo
 MicIUpDMVfOU3W941xKFmbCVsVLcdWu+EAWMbBa2HvazQbPkFQhgXTmVw1ZNcKuv7di0
 D0CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7pl5NskVggAXAP1hnS1BYGiH7+Dk1Wpkx9KpsMc8F99unyDEaXcWb1C0Fk5vrgUIKCOyLfPo=@lists.denx.de
X-Gm-Message-State: AOJu0YwHARx4kZ5mU+2wwUqiq+2MEoF/4X7dPOEI45zbT4ESUnvS7JE3
 ZDG5lwFzR8JSyzGpLvSy1RWT2/Oa7ieJxd8vf0w+8bk9iwhoWCqCWet3nFmwckI=
X-Gm-Gg: ASbGncsKRKbiFRTSBSMmboGhIPgQjU6OHE9eNggpCvAvQPUHERe3KCOXNZxOsE85ywT
 BbQ7yB5QfYsP7qHKMhX8auXQI/kMV3mJmaZO7V7vrf70VN9Mh6YxDWRgig9tuK1KL80X6rxq1Sv
 WRaBNqm/Ia22B8csevUtEeuxOaRjkFGPt8iLUS76q4ExRAZ4ixTPAXV9iKsTGn3rRbRrq3QoPS7
 uMJ01GIVawryXc1Sz4J/3nb04ncYixQIQkh1hhwK/OXIa9v
X-Google-Smtp-Source: AGHT+IErjCeJt8xzupqX+/y8TmxfQ0qrNQOJSFY6CuzfCHRqZcEBj51AuZAvcAm7iocXWwyWBsQHkA==
X-Received: by 2002:a05:6214:19eb:b0:6d8:8667:c6ca with SMTP id
 6a1803df08f44-6d8e72043f5mr49341546d6.32.1733511535264; 
 Fri, 06 Dec 2024 10:58:55 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da673441sm21909066d6.1.2024.12.06.10.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 10:58:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, Udit Kumar <u-kumar1@ti.com>
Cc: n-francis@ti.com, afd@ti.com, u-boot@lists.denx.de, nm@ti.com
In-Reply-To: <20241119094723.1296689-1-u-kumar1@ti.com>
References: <20241119094723.1296689-1-u-kumar1@ti.com>
Subject: Re: [PATCH] arm: dts: k3-am68: Enable OSPI boot
Message-Id: <173351153388.2516797.17489858089717873775.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 12:58:53 -0600
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

On Tue, 19 Nov 2024 15:17:23 +0530, Udit Kumar wrote:

> Enable OSPI node to allow OSPI boot on AM68
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


