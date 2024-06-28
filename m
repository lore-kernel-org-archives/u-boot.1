Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2095DC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0AF9885A0;
	Fri, 28 Jun 2024 21:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NWIEwAd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBB188591; Fri, 28 Jun 2024 21:51:42 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F9CC88570
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-24c9f6338a4so467006fac.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604299; x=1720209099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tkksSk95YeK00XELF1rl+JiqzwvmZGsOeFuGIfV7F8=;
 b=NWIEwAd6O78j0kpKZ86nRu26xsswzKrfZgDZAzfBJfbTwvQnG+/yoClQsdPAY6CS5A
 gy+7KTsJQ+QNhCEUdkszIxX91XA8DMiQsIBZhZO92XI/j10xou4Tfl4UROkz062YaRaf
 8MIDtLczbmKwCZS1Cd0zJk+4xMNpuNVNET5L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604299; x=1720209099;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tkksSk95YeK00XELF1rl+JiqzwvmZGsOeFuGIfV7F8=;
 b=ON6avBc99YvZ7KPMfY1AgDUZMJBKlpmg8lksy3jO2Lqoll2s6RjcUv5aMwuJiWJnQt
 LwVJg1ByAq/LoVbAciZbf5vwjK9gKGw54bYNKjEaXMCE/XPspHNsn7onXOSQPIvtAnvY
 8HfIUIzLQW/IeDVeKPeSOCAqqoxlXyM9lHjUE1rFzBxX+HdshPfooYH5lQfJUJG7/Eeb
 iY0DKNawcevoSLm3h52kKR5ps9UE7kA1H0EN8cSJiHV8nx/f5Tz1sE3x5uUxRX0Yw8EY
 jQhV9QuJSNenpLQSiIcGHpf2dDUcyK9WtIZw5uzH6J9yHc71CzM6LjhOn9/0Umxq7tlK
 GWZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyfkvVUz82+oQn70gZ3rpuFQwtV2ZBbTgg9ynBnv391pQXFTKVqi+1AkQpqdXOaRjdNGUsXxT+ZI24rbJBu72bi24+Aw==
X-Gm-Message-State: AOJu0Yznrx1is+59w28NRK47I7PC426mpElqhymRcnNUhw969oFqxxGG
 jY4pbbylh7OQzQsZ325CjyGm48dJcohsvJFUB4w12ksfm3FWYSqL623itUXy8ln50TsR3Vz5IlF
 DFtTesg==
X-Google-Smtp-Source: AGHT+IH6fcmUq8txBv5izucITfnIOp1OL2Mu6ZF6aZsKYxB8e5dIIpyeBleFGchzw4RB+2eXRX28+g==
X-Received: by 2002:a05:6870:148f:b0:254:8f8b:719b with SMTP id
 586e51a60fabf-25cfcf3900fmr17819508fac.37.1719604299043; 
 Fri, 28 Jun 2024 12:51:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7b3926fsm430025a34.74.2024.06.28.12.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:51:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de
In-Reply-To: <20240615093456.95856-1-linux@fw-web.de>
References: <20240615093456.95856-1-linux@fw-web.de>
Subject: Re: [PATCH] arm: mediatek: fix ram init for mt7622 (decrease to
 1G)
Message-Id: <171960429823.3614441.16316761700138072270.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:51:38 -0600
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

On Sat, 15 Jun 2024 11:34:56 +0200, Frank Wunderlich wrote:

> RAM init on mt7622 based bananapi R64 is broken since v2023.10.
> 
> Increasing the mem-map does not help here, so i reduced the maximum
> available ram in get_ram_size call from 2G to 1G (board has only 1G).
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


