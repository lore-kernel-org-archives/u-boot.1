Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B95D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 873C984150;
	Thu,  8 Jan 2026 20:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kg8oQ9fd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF57F8422D; Thu,  8 Jan 2026 20:36:56 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EABC84132
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7cdd651c884so1720410a34.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767901013; x=1768505813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Go6GnVci/gqLwCMKDxYSOI8QZnehiNuThBaIXtkESzo=;
 b=Kg8oQ9fdj9O7rkaDUM/loX4yZr/XwzLPv9NXS0HR+Jgs0yEkcCdzcsNujOZNbQ18o6
 0FH+pA0MZXxnIIOR5kBpxL3xhjoBDwBES+ZesaAiCo0lvrcj62HAzu71S2LcQA3rUe6n
 WD2qDLSGyMRMDhg2hHwh2n+RZAt7lQLHOJ1R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767901013; x=1768505813;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Go6GnVci/gqLwCMKDxYSOI8QZnehiNuThBaIXtkESzo=;
 b=GG0mPur/jtKgb6qoLkypdkqIfT3IHnE1SBAgRMIZYuz7QJpO83SobMjUFvn2CbF1t2
 rcEkXiyNqBfFBD2mXdzlsTbIii1n9WvRHnLJKmitMqg8koG9eNGfPW/NUwtXlEvSRrSL
 2ljenlS53j4lfYjpoW6lmVpUXRnhDHWzk7cbAjBrBklv3k8ef61bawJI3YI9IWpAoqHm
 k8/23O3BGE7ceWDOqB1fZ3TR5h5ezbn5pDNvI65Y1qVSBNnoywlq6xOuxra9z5/koKKn
 wtoE8ujJSvYrUSoMWAVQDUPLbSwYg3E21Q7ExU7b71RkmvlgcMIJuZ8ynBKSUBZYTruu
 YSSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuEmQ8ttQbFtwBIwV0FszGYxJZ7ISBU4inaN/B27+m3uJOa5kRU+sN/wIn2dxZOMv+KQlXhgo=@lists.denx.de
X-Gm-Message-State: AOJu0YwlakRXsPvp2wrQBZzfaY4Kxxz4J5UqaN4MMTKLozlZ8qNZbarU
 Mf9jUfZofcIj8CFPJO8ei/HVtkMf8wJz4L6tzsb3TIZiI2QhS1HPmACjzsA9Vu+JXfg=
X-Gm-Gg: AY/fxX4kLJhiE8XwGSvcIXzuiWCuaMrkDcuPlnBnhhtukvATCBzjAdbHQe1EWYpm8cG
 uEoxHFKHD4GzQhusClcWjgOWlOGJDT2qvidgqqWrvxxX7MPiW+Kf9BQ+y8N0z1AZ72H29VihPsR
 fSBlQzMxKjhaO8ZB6T33RxlapGlJHqumr2vBhXShkKCBzfGqkrVvUWafWg1o0YvMKSHLfpWsXzO
 BmF9R3OX9CyxbHzRZ0bQsZ5tum8LSt9Rwq9j20P+mvXttK3wKyPDclJV9Hp3MBIHtLYIq1/iAwY
 AXWpybouw/7keXkZAVLQtLeSyWxTpRfQO3jOV7QCN8H6Uoug/50bG9eH6Ay8LilEKTK0aMlszsb
 Hrsf3bxK7hG80F+FTZ7P3LIztNu/KGdvoAXJfz1RjcX4qHi50aKRqiUTy7QML0pOsa0nPzTLTnQ
 zx3n1kEMT/OrwmUXAZdipoXRYxe4EkwcC9B/DPFbTTU7LSVP7zrG9p2GekAiZCrSIr2LU866b1n
 QQ5NB2pq2PVyqqnsa5FBcD5CfV1gL2bjxEuVw==
X-Google-Smtp-Source: AGHT+IFBmW2Q5Prg1vann+Ugd8t2YSPelAMF6ZX16hug78BcdWHdNmdpxh8SHuwQYnoyzrjDguP2xA==
X-Received: by 2002:a05:6830:34a4:b0:7ce:519d:1089 with SMTP id
 46e09a7af769-7ce519d146cmr3828885a34.9.1767901013338; 
 Thu, 08 Jan 2026 11:36:53 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4781c447sm5950108a34.9.2026.01.08.11.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 11:36:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: c.stoidner@phytec.de, daniel@thingy.jp, tanmay.kathpalia@altera.com, 
 u-boot@lists.denx.de
In-Reply-To: <aV_DEzC0qGOr1fjX@nxa18884-linux.ap.freescale.net>
References: <aV_DEzC0qGOr1fjX@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-for-2026.04-rc1
Message-Id: <176790101251.1229465.1836975522612031300.b4-ty@konsulko.com>
Date: Thu, 08 Jan 2026 13:36:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 08 Jan 2026 22:45:39 +0800, Peng Fan wrote:

> Please pull mmc-for-2026.04-rc1
> 
> -----------------------------------------------------------------
> Revert "Use max-frequency from device tree with default handling"
> Select CRC16 MMC_SPI_CRC_ON
> Add 1ms delay with 1ms margin after mmc power on to follow spec
> -----------------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


