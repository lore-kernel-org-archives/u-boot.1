Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44B8C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D438301A;
	Mon,  7 Apr 2025 19:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qCJ+4V+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1148B82FEE; Mon,  7 Apr 2025 19:00:10 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE87082FAB
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac2dfdf3c38so94760866b.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045207; x=1744650007; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kwT1f+KwO+5nW4cVQb9DYNd5k/tH9q8qT46cQ0rHxrY=;
 b=qCJ+4V+gdp3slpnvLKi+Ku9ppSzNvgZBLkMtbFPuFdDc8h6bkgZ4cwGgtolU+mr5vf
 LzkdNe0A9qItV6W6PTaBAJTFgm9uKTEGucWiU14A4je3K3kKmO4+iIpNy/M9XZTMzDDa
 Ul3Fjxe2IAWQ+9ryI0ZXgvXw8R7mmsCj1PC56+4YRzOISxBX0HdZDQ7HByCnivLs9ikR
 aMZLPy/Z9jB1Z035pW5eW08dtJhYpcrO1VUu1gUJoUEM8m2L5SpuGF3vDNqdJAHBw9qT
 VwvRgeZIGFQEZBloK+hdV9zRBYvfoI8d36VAGvCAq5Tdy1q1hsKz2iO8sN+Jb/5hs8Pv
 vEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045207; x=1744650007;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwT1f+KwO+5nW4cVQb9DYNd5k/tH9q8qT46cQ0rHxrY=;
 b=CPlCf2aDgxq+quiPtJNDRngvElwFlPVIr5J9n+H9A5Fibeik0DbEjMGTu6Kwru6ILz
 3TEteC7i/9y76u5xYsVsKpgvUBVO5g94agJC1gicxpZ1bIQ1Gn7EurDUE2F7Lq5hW205
 PzbqzSmU0/6CBTo6NZHEKLXbMu5cdDs55fDpD2bMBt63Y7HuzdM1/L5RF0Z6LdJ6pekx
 tbCIfOLbhTmvadN5b/25mwL7HI1uOBh0c4wafd1eNOkOuY7s6ZpCGcUUFcBwgSvR1Zpj
 G/YqGe71gaqsuIuHLnYBlIgQ02R/yNEZ9AkbC76htAvRjG+LL0Fycrhk/4zEqX2ONndm
 inEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBSdTbXK6681Z/1Qc3d7brsdACuAjCpec357mOfmLiXurs6trVy5ozmRXwaeDpw7XlwdJmwN4=@lists.denx.de
X-Gm-Message-State: AOJu0YysLAw1IL1LVCUCvJ2rMfsvxKRuPWQjWIZCfVbpTL05QG1MfTdc
 2QeMze4yMCrOD6w6aUqICFqPYjOAn4uXs+3aoWJ4n/1EAhY8cKbrjr6crkOVI3Y=
X-Gm-Gg: ASbGncuPIwkfgDxxZwvxYhtrCFY4huJzGxOkGjqmb3ZeXotHYlPPkmy83wkIcf4tBlb
 WGjgdgCmL0rlc69OboFPaeEK2IRE1nj9yj8vN8N0/p19tBi/b+Rz13Puc8p801qzbssoZZdZYgE
 +7TasPBdGlkyWVqyqRcXkkVEPnele0+fMmnYU6IKuLWiYguHfDdHLLXGxwk3m+aE8Qf1w+c/Dyv
 oJK68YW0+FdnDDkeLmxXH1mESqjjPRkUFc6puir6q3I97ouUjzVznTYuZfg9HrvTQAOOyjrXtQy
 bKDN2weGylJpINFuXxsuLQ83egVIhDTryvfb5WFje6r1Sw68q2JjmD/j4Q==
X-Google-Smtp-Source: AGHT+IFxyIp9nF1YiKadnz7Nwq2iuIhH3bnkncL69TG4eFhj/hR3KZvLlScM4ji1L3DbWBAo0t5HNg==
X-Received: by 2002:a17:907:7254:b0:ac3:b50c:c95b with SMTP id
 a640c23a62f3a-ac7d1c6a058mr1202806966b.56.1744045207380; 
 Mon, 07 Apr 2025 10:00:07 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.10.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:00:06 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:34 +0200
Subject: [PATCH 13/13] board: dragonboard410c: Update maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-13-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
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

Ramon has been inactive on the U-Boot mailing list for over a year now and
the DB410c port has not been updated much lately. I've been doing most of
the DB410c-specific fixes/rework lately and try to test it every now and
then, so add myself as new maintainer. Also add Sam as reviewer, since he's
been doing lots of testing and reviews for MSM8916 recently.

Cc: Sam Day <me@samcday.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
@Ramon: If you want to stay co-maintainer please let me know, I'm also
happy to just add myself and Sam additionally.
---
 board/qualcomm/dragonboard410c/MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/qualcomm/dragonboard410c/MAINTAINERS b/board/qualcomm/dragonboard410c/MAINTAINERS
index e78f5b2d6421c7e41436cfbb3292f06b10324c6d..9c10fa3053b042ef0b5b44a2c3c4a2f2956cfb60 100644
--- a/board/qualcomm/dragonboard410c/MAINTAINERS
+++ b/board/qualcomm/dragonboard410c/MAINTAINERS
@@ -1,5 +1,6 @@
 DRAGONBOARD410C BOARD
-M:	Ramon Fried <rfried.dev@gmail.com>
+M:	Stephan Gerhold <stephan@gerhold.net>
+R:	Sam Day <me@samcday.com>
 S:	Maintained
 F:	board/qualcomm/dragonboard410c/
 F:	include/configs/dragonboard410c.h

-- 
2.47.2

