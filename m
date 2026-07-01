Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEF8C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC88984AE9;
	Wed,  1 Jul 2026 11:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ivl8R7VY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7820184B20; Wed,  1 Jul 2026 11:50:31 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F9E847C3
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso3971055e9.2
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782899429; x=1783504229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sg0AzkeNhSMybU3lsJ27N00M0cPULVHSkvbxmjvObSA=;
 b=Ivl8R7VYMIYjf6WAKyyWY29ehgIflY0RWpqUYnbzLIo4Om/K/xaWO2p2rXN1s6VTVo
 n9A14oKWEQILmP1rnPramE2LmVSNrtvPKo/7G/wI9nVYaHDtL/PzrlbDnlDQrDLdnhy6
 n4GsaOpyvOaJavRbJvWGl9mN1dEb5fYALLPcgTHHXodL1tCGLYUwB0/TQG/IC+AYIIeQ
 C8TKSFqjRIQgUVPsKlYrv6gYtF1TmMyKsMKVh+JNrz7CW/q4S62NALkZj7e1vX882nvw
 5g0rKWPOwY5ztqVHEHvVyHLWbjt2bxJXstrZq+fhB8ouAW+oK/IYCBZY53A0Q/sfTnMy
 bUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782899429; x=1783504229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sg0AzkeNhSMybU3lsJ27N00M0cPULVHSkvbxmjvObSA=;
 b=BPaWpVH1hhD1q+wFa71CJuPMHWegd4jMhVeSO8D6diBACzIND96g0qtBZLigKqX5+f
 Dh5kYOEs14kGgeAgdDDsp8q+tNeLjDqIKnL1l/it4PQfzCvCkGx3+jdrMZF1DChesx0/
 EdxjpTwLdCERa6aFH4WR7nEMRptNEPySDyIGgmzWRK+cVyiV7j/esX4UOnvkRE8XlfFf
 yzjz7TLCQ00yDW+tIZL5Wv4zxUug9njrJJOQcEatrCEofwnpg+l/nwRfL9apqnIjMsQE
 RphZzqm1iuG32Dvrd+WrW9F46fRjhVtoNTwyrvmzM6N+iV482lY9YK5rUeSMLpLHzrS1
 cGEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gjyNov4lA1YdKzHS5vBN/8Bhwgdvqi6Y/UgEW+IgfYv23X4bd0da3nPS+FW0jjjBMqysjXRc=@lists.denx.de
X-Gm-Message-State: AOJu0YwJ22rAFy0eTSRKciEcORjh8jUgw/XqjXJXL7NeecpXpgqs0k0+
 sJi9ttCb7Q+pryYABh9Hb/r74pF83U6new+we+WC705bJCVUlUSc9bNX1+3LIlD7Ffo=
X-Gm-Gg: AfdE7cmrGgSr15x6b5mkmRoBM+FdEQ4zEHFwR+Ug+/4olBjZL8a/7MMsYc4cYfxQJY3
 asSNfsfCaiLX/e5zPUBboOToKkA6/NduuDxxvA8QGAymBkgtsaLEXIYbCnUuVWiiPJVGMniuNTm
 jeRqGjeDLoqLeZCXWeRWT6dPfFxnn6r9vt7dvO0hTVYkUeKZq0Xlme3lWG2UdxPC+YQ6SQO8XKd
 A9aoe8+29bGPJA3yq4+2QXPaldl+7q61sLj4WMBBI9buXOeeXntXtTZoK5VKXQYMSHi3UvZKwck
 4EAnyL+zyVR/RlKnjI7hSjn+EQSsD3D5SLx5QpdXiniKrrK6wImUM+b1efh8E1EO9R7/OnnUbrt
 0uhyT1vAVKdQD/3ITORYGfNAQEZJmJ6jFeuc32JoC4oa3YKbyxMAvDV8Wlt79B4rrZJXmLcd8f1
 AM062vktZsuJNl
X-Received: by 2002:a05:600d:c:b0:493:bab4:183a with SMTP id
 5b1f17b1804b1-493c2b3a053mr12502425e9.5.1782899428859; 
 Wed, 01 Jul 2026 02:50:28 -0700 (PDT)
Received: from toyger ([212.133.41.27]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4fc1ddsm69111585e9.14.2026.07.01.02.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 02:50:27 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	u-boot@lists.denx.de
Subject: [PATCH] get_maintainer.pl: tighten up git contributors cc list
Date: Wed,  1 Jul 2026 11:50:01 +0200
Message-ID: <20260701095003.212997-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

get_maintainer in U-Boot is configured to include contributors and patch
reviewers from the git history in the CC list, going back 1 year if they
have contributed more than 5% of the patches.

This is well suited to some core U-Boot code that has a long history and
doesn't get much love from any dedicated maintainer but for newer code
and board code in general as well as defconfigs it can be frustrating
for some contributors who do not wish to be CC'd on patches as well as a
general issue when dead emails are included.

While it would be desirable to just remove the --git flag and encourage
those interested to configure lei or just add themselves to MAINTAINERS
it perhaps makes more sense to phase it out gradually.

As a first step, reduce the time period that will be checked in the git
history from 1 year to 6 months, this still offers plenty of leeway for
contributions to the last 1/2 U-Boot releases. In addition, bump up the
required percentage of contributions from 5% to 15% and reduce the limit
on the number of "git maintainers" (i.e. unique S-o-b/A-b/R-b tags) from
5 to 2.

These changes should reduce the size of CC lists while still including
recent active contributors.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
Cc: Marek Vasut <marex@denx.de>
---
 .get_maintainer.conf | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.get_maintainer.conf b/.get_maintainer.conf
index f916cfbe480e..302fcee9699f 100644
--- a/.get_maintainer.conf
+++ b/.get_maintainer.conf
@@ -1 +1,6 @@
---find-maintainer-files --git --maintainer-path=.
+--find-maintainer-files
+--git
+--git-min-percent 15
+--git-since 6-months-ago
+--git-max-maintainers 2
+--maintainer-path=.
-- 
2.54.0

