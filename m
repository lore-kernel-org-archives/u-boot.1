Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15887CEFD03
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 20:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D4D83FDA;
	Tue,  6 Jan 2026 21:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="le0UuxRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF7BB83F01; Tue,  6 Jan 2026 21:16:20 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7D483FBE
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 21:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4557f0e5e60so881329b6e.3
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767730577; x=1768335377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqPykRl/OQ7aYCH69ufabJVD2eLGWm9RYbgrhA00UNI=;
 b=le0UuxRkPxcAgSGrA7tSjOyD28EhbjvSt0Faj9zXpyOXfe5kmKyG3l098Y4GN4gDoR
 OcWvIJb0+e7djRtOlHjiBKL1uaxlUC0/UGp3Ii7zVxwd+XSiY5cwnpT38SyOTOFgVjFd
 MMn9SWEsHt4sdXRBzxyQa8d9sM5bF035AAFY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767730577; x=1768335377;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zqPykRl/OQ7aYCH69ufabJVD2eLGWm9RYbgrhA00UNI=;
 b=UfMjvM12wh791so0OAPWekPQRqYdcQ3+PZEkH0HsvVU/vFkqR+OQipHxrwPJRv3QxA
 dsU1I4hq6W89Z54gKFVTzxeGdlwhPpAvbOUbwqzW2KFU2JusYj1Q4rJwNsdjeCTQghum
 ntPRoU9WHWF2m+edTJrZ9gPAzuwTkmbtOZeSNu/Xpo2OH8IgFkzmtYXH4JhFgVuF1psm
 O4JP+3XmJZ4twYQQz1gAA3Y7fxXauljsNQFgG8g/VoFYkCXKqTgQQutNUQ4HIK8v3mPs
 D6aJX9XksHoQPtArMd2QEUt9DfPnmW06jHma7zw8TjnA1RXPieVRvpKyy4OpjqmEF04c
 d83A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZBnSpmVsTj8Hsk+BYX1oPwU7SMDFpFg4j59nReNs4hmQQrNLu4dMcVnILRL9Z3t5YadA1Ebk=@lists.denx.de
X-Gm-Message-State: AOJu0YyzUNBhCWz0bTcONU5CMKPBhSVEiaKWUbZIrOQ9QP8BBe6WGdEq
 Et15k+gE6qhedTkGFOrGXOtq5EXDLJpUUlN5nXV2qh1C42INAWq6X7RfIQrTHYLobQU=
X-Gm-Gg: AY/fxX5zKF4vaLdUVj0tmUVgw5kYXkRVkK9YYYhJ+wjzeDUsaRx08qQBM/PusYpCuxo
 Lc4HQCLfZkghjGyqJHmqPRa0UiLvXYpywn+IpIIrPByM48dBg5dUE5HSO3u47EW1QGjeE5uvt6D
 gb0YA66nZgcIzm9oSFLLHpp6lbd5geEVGgmTB9E4PxqxO5HHYLloF+N03FXQkobQ4Unh31hPmb9
 m5KeVEqH9ccAAMR248dsYO+AHR+f+bWUfpDxOxxS/nYn8FzmPmk+J7nQAjZJfYqWRd4uaDgXVHf
 ZGM9JM+19T9I28ajAKn1ucO3SgxPzLFdcupsPRKGMwXfT773pFtYTyYQzW/Grhu3LtNAaNgU+qE
 SsKqT6j629T8JmFduXtbJzOI9i3/IMOdO1ZdtvoV3+CxOH+Tx1pNAZHGMAZtUtUwBmT3NV0O1RU
 jm89JxXFNN4uu/BujosqHgnNrLzvxjLB2XscxLyidZVvBfzMjt6n8eCwuGjFp5Gqq8XuB4Zjl8x
 OZbP6NaZ1r5L4aKgOyxOgq2HkZ5zm/HfmimwA==
X-Google-Smtp-Source: AGHT+IHeUL79UN+iNE7/lqCtMCCP96mlVp40dvKW82ui/ZB3AKsjb/kDsLyjVJEv4bMuzyAR18q6EA==
X-Received: by 2002:a05:6808:5149:b0:450:f17d:860e with SMTP id
 5614622812f47-45a6be8d6d2mr124580b6e.47.1767730577409; 
 Tue, 06 Jan 2026 12:16:17 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af63bsm1962355a34.16.2026.01.06.12.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:16:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20251211-clk-mtk-remove-aliases-v1-1-6a7212269fc4@baylibre.com>
References: <20251211-clk-mtk-remove-aliases-v1-1-6a7212269fc4@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: remove CLOCK_PARENT_* aliases
Message-Id: <176773057653.3765597.12541147208276463656.b4-ty@konsulko.com>
Date: Tue, 06 Jan 2026 14:16:16 -0600
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

On Thu, 11 Dec 2025 16:32:10 -0600, David Lechner wrote:

> Remove the CLOCK_* aliases of the CLOCK_PARENT_* macros. One name for
> each flag is sufficient.
> 
> 

Applied to u-boot/master, thanks!

[1/1] clk: mediatek: remove CLOCK_PARENT_* aliases
      commit: e21edf2620749f1390c9ac3ebe329a6fd261c65a
-- 
Tom


