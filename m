Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21381FEC102
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 19:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B416383CE3;
	Tue, 24 Mar 2026 20:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aRmE0S0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF1183CE3; Tue, 24 Mar 2026 20:43:36 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 173CF83A41
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 20:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-46808125d28so1072763b6e.1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774381412; x=1774986212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+tA0kKc9VPs5+CpYroaJWJoYk9jb4OAMkTU9FqSEWw=;
 b=aRmE0S0+kczt4uThene+dkNkAiWZ0EKclh0n/VGE3A3lqfD1vU8wjQg4xnazRK8cCu
 bgfI2D/eN5XAGMw5T8XrNHu1LLvbmylwZ20sdmJmQts6aGmPvaa/tyhw7KPDrcwQviqF
 AN6UGiCqfrNKKqiNlgxmLJaOiNsUaA3sERWP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774381412; x=1774986212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g+tA0kKc9VPs5+CpYroaJWJoYk9jb4OAMkTU9FqSEWw=;
 b=GAmKMvJmYc74nMQ5hk+Kbh+HHPlL1JmwkChHN0gcDkXDHy3zI4QdiN5iOdlUTNoBnN
 5R8Um6NogmATg1dev7lkEVW5yEJyb0+omgAo2VMaxg3uqD+xQn6fSYBsqSIadFHmX2O5
 +vtUiACD+BPAcD6gdS2OKbWVsM97RAwVnRwejp7KcF8Jp81nN+hYhOF/64cSqNz6MiEi
 LBpdjJGQg/5vtUBuBFIu65OieUBlEzO50kFXUfID9Obs2aW7JaKV2fp1BuyRNBwWgKNB
 HahO8kSuohlNG1+f/eBdIUMswHIA6+cBJoJ5lY95xuDTQMVpFDRmbZFOSN9hMB+K+BNW
 skrA==
X-Gm-Message-State: AOJu0YwfAnncKHwhOqg0vFKog0pUAqfMegn0dnI9+NPu1A6n+qfnA7+6
 krmNP/c+ToJ8ZmL0FXH0sS3Hn/WzStFERJf096FiSe0bfKrXT25/aCO/Lpux9O/2VaIm+s7E89M
 a8669dg==
X-Gm-Gg: ATEYQzwXj7MCPzNrCuq4XaXJ1BEteRLevXk3fbJsKrNW6uqA/CGJYoW/M7epw3TMPKF
 R/+5+9PVyUKYf24cWr7XSMUXW3QkdOiGOhSUw6k8HsAq+ThorT3smVQdLgh1DKOaqh9PjnKENLQ
 sJqH8qRCarr+RGllyHl5kJlDblaXKKSzwMFKJv+wFTBUKmJXcpKIVUhRLyavhmE6TDobaw/k9aR
 34ehq/kNfI6qyrDuI59D4OE9uHLYx/uLzrjnqarWc+zPRMj1WX+k4Bnnhz7QdPb6pA+egiJdHS8
 q3AztMHiZ38tt5whzteNe6+pvvRhaMYn6IYNDU3ybU3i0nyVGiW8Y+li0ch+FAolspqhoQ/GEpD
 jrV5gB6fXNJI/rph+gpM4/KeDd/i3y/mP13o4yLO6YOarFspaZyWpA2Z5Nc7j3+x78bdluPZtTd
 W8CZgxZJWwL5JXQsIDGg==
X-Received: by 2002:a05:6808:bc7:b0:45e:e20b:aa14 with SMTP id
 5614622812f47-46a5c7be89fmr427342b6e.54.1774381412227; 
 Tue, 24 Mar 2026 12:43:32 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c88218654sm3714784fac.17.2026.03.24.12.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 12:43:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] test: Rename test_fit() to test_fit_base()
Date: Tue, 24 Mar 2026 13:43:17 -0600
Message-ID: <20260324194323.2335679-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324194323.2335679-1-sjg@chromium.org>
References: <20260324194323.2335679-1-sjg@chromium.org>
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

The current name is uses as a root name by a few other tests, such as
test_fit_ecdsa() which makes it hard to run just this test.

Rename it to test_fit_base()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_fit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 42aa3b76ddd..5c0e74ff81e 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -119,7 +119,7 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('dtc')
-def test_fit(ubman):
+def test_fit_base(ubman):
     def make_fname(leaf):
         """Make a temporary filename
 
-- 
2.43.0

