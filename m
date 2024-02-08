Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDF6C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 20:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F0C787CFC;
	Thu,  8 Feb 2024 21:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RNIqhp53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5DF87CE8; Thu,  8 Feb 2024 21:18:47 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21BE787CF9
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 21:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-60493e299b6so3210147b3.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 12:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707423522; x=1708028322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iIau2z6PQ3az5sv3xyaqV7qiCjAiyayeIy/+0rm7Wgs=;
 b=RNIqhp53ytyUh9winFoXEkLRUz2cS0ZWyHCZWZS0MC3JaoRZBXagwxMnRgAvKsQJ80
 7+aIhk0Em/oM0pU6hdwGMq46JMJiQWA8qqrJQuUcbwr7Jk7R14+BJ1JOd1vq2him0BpG
 T2u8XidGfa/SS9b459b5ZJ0TMJipvyUyJnZVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707423522; x=1708028322;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIau2z6PQ3az5sv3xyaqV7qiCjAiyayeIy/+0rm7Wgs=;
 b=iag8QsTc8UXTuFHTba9xU3boXv6bU1lBoz/uzET8z9J8j9JE41OfFGS8EJPgmUnLYp
 42M/fKWsBInzJp9OZI065amkKwY+hNyRnUM8s0ua6n32Ss7rVJtSzK/VlBuUVsawLhA3
 JLi15A8mlGUYrFeeDz5Z4EuX7N2Bq7w3rcLE67syZv6qmBUz9DPdwquZ9ddiwnlBBw+C
 A1YiIchtAiMQBMUgMN1UMTw4SbaNDLo4PZ8MoOehTktUZQe92kdan8btDZBbFpXxfF+S
 HCuWWJtn/cxAoxiNKqvpfppW2aO5ctmfzoOvVu/3cDHzRELvqW6T0BYdl/eDCSDCKiWh
 z+4Q==
X-Gm-Message-State: AOJu0Yxr9LT9wQ1wi6ytVRuZlpVAI5gqPZh4CtgefBiEcOS1cYEcxyXg
 4GJeUJ/phkzCRNdzlDasQj2n2mgqseAJYUzgkV4B0xGZClMj+8uGVDdUVtdjEIg=
X-Google-Smtp-Source: AGHT+IE7y/fAyABqpwsXlZ901ghKAiBZSVHNUmfpT8jMLqgvsBMtY/tGQRGlPEW2x1+YYfWzOQFeFA==
X-Received: by 2002:a0d:d493:0:b0:604:1c9:62e1 with SMTP id
 w141-20020a0dd493000000b0060401c962e1mr573360ywd.44.1707423521568; 
 Thu, 08 Feb 2024 12:18:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUkO18CqgU1qSZVJNblCpxwuWQd9zY0J3u1GTjNuU/wVaZ6MVcN+H/YT4v3sR99hIee6hRVpNucX+MMeyZQFJOnGBsksibgbjrF37GiagQTsNiICfxGxPSek6B1jp9KqAeqt8I3Ab4c9pBj8iM=
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c70-20020a814e49000000b006040d34e58csm22328ywb.74.2024.02.08.12.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 12:18:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de, 
 Andrew Davis <afd@ti.com>
In-Reply-To: <20230725155416.100678-1-afd@ti.com>
References: <20230725155416.100678-1-afd@ti.com>
Subject: Re: [PATCH 1/2] ti: keystone2: Imply NFS command support
Message-Id: <170742352088.2307340.11272243782800410123.b4-ty@konsulko.com>
Date: Thu, 08 Feb 2024 15:18:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Tue, 25 Jul 2023 10:54:15 -0500, Andrew Davis wrote:

> TI KS2 boards have the nfs command in their common environment boot
> configuration, enable this command.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


