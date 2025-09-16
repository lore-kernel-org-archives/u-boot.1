Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05A2CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3CF8832FE;
	Tue, 16 Sep 2025 18:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pn/fyCSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A88832DA; Tue, 16 Sep 2025 18:14:50 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E7E8331F
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-332e66cd8e4so1168880fac.2
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758039287; x=1758644087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2JPKtJHT9aHE6Fpx/d5WrT0qQi7KfhF1ih3aECrb3gQ=;
 b=Pn/fyCSOr+qQN+hDb96xBDQjqabYi2fia8dpSkC8W9aFxioCI9koht/oK/LH9BrTk7
 xw0l2iuoAm/t05JBBWxG4gKp1dw1Jn8mSB2ySP4E3eI5cj/12c2GarS1cXpEatddzwB6
 RrXu26piTHf9Dt0TvUqOE3DRkulBO95tRnVis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758039287; x=1758644087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2JPKtJHT9aHE6Fpx/d5WrT0qQi7KfhF1ih3aECrb3gQ=;
 b=xNI3kIvuZ9JkNmuzrn+P6YcQTjOxMfTohKewlHam6g8qYLCxvyVp4tYR29epws8Oul
 yW3upLPA1jZg9qbX5epIPCgCLitZB47yoY/d+LF4yuXImH5ngtOwhjh+SLYgmx5x8hhB
 hxp37/1o/f7bvvrAXwZPQFDR6zG4wx+f/4jc4ASA2tKvpAlopENfZsRPzQIMrzC8GREV
 hfCEhSTjnN/TPgVpQd7E3wK8wZNbrGhYMTWN3l282Prr6xRdf7S28ToJcpOQ9IDqNXaC
 0dLVmaIC0KOalCWCPb0lQ5ieTxEV/Zrfb+Pd0pS4unzw9tcBe/lqnR/r4S5ivmgPFFXg
 zj9A==
X-Gm-Message-State: AOJu0Yy1KCPLSLtBwzxhFZNMn8f5yDSYsrWppqCmP5439/3eBIJz+U5k
 1KaRkfgBbONxjWYEieqtf264UxYdsFyKiMU0PHXGZQcGX4CyGjFeqp0H2+HV0lp2D+/vazTeej4
 wXt901Co=
X-Gm-Gg: ASbGncu6Sq1+aqsW93WLFnwZ/aFHgS4nwXmV43BM75YsnImPmlCKZ+IdVWKlUe8PqQJ
 5KEul7AkVx+nSIL7lqBiRl0MuJM7asb0tucAHw92CK4igy4FNXxLm6mcqiVOHEqeQfy9iMzN5RS
 uYHgyweMV7CYky+Kt1gSDs7gqRMyO9vdAcJMczwc3gyYwtP7SHD7I6WDYx0ehwSzOsb2S/rOcIA
 mLYYL4f5jRD/tq/YN4Ku+6Dr6SBli0WU9rtad39ISCPFQnKuBwDJKyaecEnMHvjwqNg4I1fY5AP
 dv9kaJS8OnSE8Vf6eBWsGt32menJBz18xcguFsNLjV7Ih03BR8RXX4BbV3A4twLmxisS+x680ie
 ZinVPrx5HZhYccywIF0J0stvXNPwY/GTU/O2qN5aXWIqjHHOqGgZ8+Fq6ynY=
X-Google-Smtp-Source: AGHT+IGG/hyH20z0oSSzxHimKTzdkYfpdThSB4knEeF5ReHeqS9zzg1TC5Zu+8XPmd53VQE+4bH4EA==
X-Received: by 2002:a05:6870:a990:b0:314:b6a6:687c with SMTP id
 586e51a60fabf-32e58137109mr8689895fac.50.1758039286976; 
 Tue, 16 Sep 2025 09:14:46 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-758d8131976sm1728790a34.3.2025.09.16.09.14.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:14:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] scripts: checkpatch.pl: Extend some checks to "env" files
Date: Tue, 16 Sep 2025 10:14:45 -0600
Message-ID: <20250916161445.582540-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In order for the U-Boot specific tests we've added (along with the long
line test) to be run on ".env" files as well, we need to update the line
in the process function that starts to limit the file extensions that we
test on.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 414019c5b896..763287e02b18 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3791,7 +3791,7 @@ sub process {
 		}
 
 # check we are in a valid source file if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
+		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts|env)$/);
 
 # check for using SPDX-License-Identifier on the wrong line number
 		if ($realline != $checklicenseline &&
-- 
2.43.0

