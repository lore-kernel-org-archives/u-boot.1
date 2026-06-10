Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71468CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 20:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B5B38486B;
	Wed, 10 Jun 2026 22:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="eVJLx7Id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99B9B8489D; Wed, 10 Jun 2026 22:34:05 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8804E84852
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 22:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4863eae453eso3325250b6e.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781123642; x=1781728442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMQgNbqTrUMBZjLgQezDOWc/sQCMPRnNVKeR5n+vd5M=;
 b=eVJLx7IdUiSQ7JSAPyW0lQuHVqtiSCK9w9pfJZRYK67acFolWzKCkuQhP352XPxAsj
 aEa1go8rLODJQmmJgzfI7w7zHLk8AApJ6tVjAaddfGFhH875zSM30cxAMQ3rkC2u1zib
 G+wCu2woHwLVze4jYcW5+JOHAtYvO8DPxyN7ffsXJ/L3ntZyUh/Rx+LbNhBmilaO1dTV
 uv1i0YKHg3RmYPd69PSwdAttMxA2Ep6ErrrL5XQSjLdVOp+d3POkIObOgEBAgstDpsgo
 Z8aA7FTNUWq/Su8oPYhKp2CzbQVejto6xxfDt+tZUCnMrV/LHOXCVYeAqgwOjHB3uG65
 wLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781123642; x=1781728442;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KMQgNbqTrUMBZjLgQezDOWc/sQCMPRnNVKeR5n+vd5M=;
 b=fzPMHRdro09ABqCGHS0totHQfdajWqRESOWTLGPa5q7obrkOpsV2xjD+/6cABm7aNC
 2pZX5KovV+08WpZG5yiGDY/Gemvx/4vJht1Ot40u+uQYQsntGvut90x/fj5Am3d/BQXZ
 +eLmFelDsipwQnBIhrYtfi98pjZtFSGATDhTu+YSUpc82qhBZQ5J1u+yk1NGc1Dy+eP+
 htuL1JHNVkwTDC07j8wvHxNLINgE1w2hG9BlKA+INJXYL0ivIx/ttec7kNGAG1GpjQSZ
 LGJv4+wBE35OWFYON/wXkeHkxA3Y/Dcc/1IA9fOPe+Ag+nrjqIDw6SdzPPMuSpxJCDJK
 cBUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yrnWYeLR9/uFrbttf/zTe3XpgY+nG4fFHKL62ozQKD1oscqNd3TJmMVgeuq3zwgJECy5Ae3M=@lists.denx.de
X-Gm-Message-State: AOJu0YyQxzB4qUrMfl5S89Ad5Ad3TJQ0qaEOVKgz4kLzbo+iFVh1ANm4
 dwjNC2g+fv61pDGTR90g7qgL9pCv58tQeTI6bm8rUOSvygj4zr/t7Bd5zkoRZa+oR2Q=
X-Gm-Gg: Acq92OH3sih2D0JJtX1ZXIXHzxJUP1LuU7hqZt7+2zdpvOKBSh4mLRjKRt1GU6W/TCt
 8gyIvXOj23BaQopp/1SGpJVsx/asLlPjea5JR5LX3Luen+cLnJ2szXQJ8huQrNEO4kymqqSJVSp
 YglYWOaNC2hEyzfUyfvrs7+rAy7b18ssoTvawZDhfmgTnU0HXUIqYL87bKPTXVVt0KluZxRYlY9
 uG5N84kmdM8anI/p2bXqrHLZxkqdTste+OMFaX+dHKLAJQqrDfqVVZg3YP41f2wIMMdmQKrj4hu
 DYDXcDayTD35cNnkes3/hsSLT7Q8f3NXaNDwGWYWeFOoG5I/P2z06g9TgmeyyAlBQZmTpyZNMCV
 fq+0zeFVDufJwUCcaN74Ol2swRqUMWsKLbMw7VnIyhOp88D4Qk9VAl+9AB25ET6jngsCJjosvKl
 tNo/gcT0WhFoRX6f+EFhJS411PhzBHqqqapSeCJg==
X-Received: by 2002:a05:6808:13c2:b0:486:503a:ce9b with SMTP id
 5614622812f47-4868dbf284emr16276145b6e.5.1781123642243; 
 Wed, 10 Jun 2026 13:34:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d338:698:e403:61a2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b91eaffsm19060604b6e.11.2026.06.10.13.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:34:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260506-mtk-pinctrl-fix-scnprintf-v1-1-56b99d5809db@baylibre.com>
References: <20260506-mtk-pinctrl-fix-scnprintf-v1-1-56b99d5809db@baylibre.com>
Subject: Re: [PATCH] pinctrl: mediatek: use scnprintf() instead of snprintf()
Message-Id: <178112362765.406439.15212533129610769729.b4-ty@b4>
Date: Wed, 10 Jun 2026 15:33:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=342; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zLd4boai9Dw6HJ/+LNKCPXcWvBk9jFxsw0ePK2mbu+Q=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKcouxGTJJzpuRmYWGpqAi/FSLRQEN2PhBOe+w
 c9wAw89DcaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCainKLhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AcvgIAIZk99B/zL/v45fFBpPZqV4lMfiYRULkQotbcWt
 QInAw5PAul9WyHw0vvC/K/t7c+Nx/an5qOoDH6iS0roUr8eMiinZmOCRf6HdFN56V5kk8ggD59K
 PuEDxFSARTyHqSse8Okki8GKszaqYe8gQz1zgWAdlOlA27D7VP0wP1FOmViZ07JFm3frek0tVkh
 d4u9veO07he8/InlOmRo1aV+cz+ZAoECx/mQbF2wxLKIo/yaOB2f0Yp8cj+gn6CkmF4HzQHBVF6
 IxGxkZHkGrgoJEFV0SuTaiz+kqmu3yO9bbhwyr3+GnTYFKM7PnJ/eGufv65ScXWY8qugzz5jsPm
 Vwro=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Wed, 06 May 2026 18:05:31 -0500, David Lechner wrote:
> pinctrl: mediatek: use scnprintf() instead of snprintf()

Applied to mediatek-for-next, thanks!

[1/1] pinctrl: mediatek: use scnprintf() instead of snprintf()
      commit: 2258b6419a9fb94a62c566d7804fe4ff551fae7a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

