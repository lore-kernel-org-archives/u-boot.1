Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09F8C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 20:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742BA83B63;
	Wed, 21 Jan 2026 21:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JivAR7i7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32BAC83AB7; Wed, 21 Jan 2026 21:48:52 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D4B83AB0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 21:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d148f6833aso104367a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769028529; x=1769633329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uK6KFIiBAdlhs1+TdZgdSiNhLJZB7wXcSqkvpZTfSwk=;
 b=JivAR7i7FNQpaKB2g8Z7qoYkYoNjX50eTU9272V+cVFZLErO5W7GlNi2mc0ImuXYBo
 fJBXe5/w8HK/C8YRHcxBitKt10vEYoeCNJ2b/UlBmvVKzHAF1Jhpu+CbLGA6kYvKdtC0
 H2rXPZGQK+g/y1tbFDzMiORwlndjoQ3/RhisM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028529; x=1769633329;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uK6KFIiBAdlhs1+TdZgdSiNhLJZB7wXcSqkvpZTfSwk=;
 b=M6FToKuiIsUP/vTg56NmztKJTFkcPg2TMgbxbrhgmzhZsXoidSn3HnqDZDtqb12cAv
 HTdEYZJwNUY1eX/AQJ+cViUNIMY8KXovh09x7aovGTwykGbi4Lv33Z+MMgexh/ZcKL8Q
 yOk2Awow0hZAlLntJBrIByTE87v27tB0XnDKd8av9THpWDyJb3nKhXFSd5VablbAehgQ
 ioUf6LVIzX5EUxozFeDjiuvXqfhgiaK5Qug+sgAP/jbiQCZcQ5xHHqn9X9s/qnGg09/d
 b2PpbRhB3NPXu9jJh1fGAs7/M1fvmX5891NlgsduAVE5ieZJJQl0jYZ1+DkWbH05Rtxu
 KJfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR17HbipyYnx5zBo7JWruVqmAX4Zyrqrgi68PA1xH/5W3gnkOqnvzel7T8YCjibPtgrN39g94=@lists.denx.de
X-Gm-Message-State: AOJu0Yx55cDgzRa0djs79HtnNNhuY84AmnAXCVMDJPax/0NAy8uwWEZB
 2DdHoFk4cHZV1i2we/IYFxQn96gE+lZYUWNSpRmXaefZqDbdCKKCwm6mGt46j8Qn7ICIvSiVvJ0
 bccq1H04=
X-Gm-Gg: AZuq6aJ2FI7vwJmbtb7T7vsDJPhNJrgbq2EhwPCElAq7Ac33vQG+CnBxmOqQLUKAk1E
 egRMfrbS/KUgXOOql1lzdSVEF1OnvO08yBcfu1IISpVdRpv+jLwmGU+RLUp9P4mvV89RSAvEvoR
 zrmrxJ9Qu/4i7KfX9eCMEZplFv1twfRF/Dkcg5dsxs9tn/N/08TumHnYNHnjVZbgq9jFS1mZrlK
 ywQUJbKocKWnTAx7ZaWKiFMB07kzSzEIabEAwWJGiOlJXFZfxuwXuGtUtMPecPefph4O4Qw5zuY
 NDlFG4P5dvGWUBlbpMNyT47vqrmDL4P23SycAXCDn2AlQZg/Oj5Lj+P0xK69gcnHVrdg63WldIJ
 KXS4ahteu5fZHeBHIaCLyZEuwCnxUy/UxM3/P7A+cgVmIB2S/myRk+h+NSqWywqnaDMWnAXCyzU
 HdvXWbQhBYmWYh7b4QGN+chxaYxzT/ooC4N98MMX8OE8hDm9MwGhMZI2GEXKHLFS2PJt/g7eLWF
 g+C3tIVt/xJilyI66OtbgO+2UlB+0vr9rTlTg==
X-Received: by 2002:a05:6830:3788:b0:7c7:6348:594a with SMTP id
 46e09a7af769-7cfded3f3a6mr10631144a34.7.1769028528670; 
 Wed, 21 Jan 2026 12:48:48 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm11134487a34.6.2026.01.21.12.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 12:48:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260113-pinctrl-mtk-mt8365-pupd-registers-v1-1-4bceaa52198a@baylibre.com>
References: <20260113-pinctrl-mtk-mt8365-pupd-registers-v1-1-4bceaa52198a@baylibre.com>
Subject: Re: [PATCH] pinctrl: mediatek: mt8365: add PUPD registers
Message-Id: <176902852788.661474.6148850710825810506.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 14:48:47 -0600
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

On Tue, 13 Jan 2026 19:53:44 -0600, David Lechner wrote:

> Add pull-up/pull-down (PUPD) register definitions for mt8365.
> 
> 

Applied to u-boot/master, thanks!

[1/1] pinctrl: mediatek: mt8365: add PUPD registers
      commit: fd871fc6bb497c6ddd7b39622480b89add78f57b
-- 
Tom


