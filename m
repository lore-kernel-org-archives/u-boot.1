Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823E2E77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B010A80713;
	Sat, 11 Jan 2025 01:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lfCCMBz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC4B580750; Sat, 11 Jan 2025 01:01:27 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68BDA8036B
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84cdb6fba9bso185345239f.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553683; x=1737158483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cxmW22g0vasVwb77y/wKLQrI2B3taWtydIYzvhIdz0=;
 b=lfCCMBz9V67H8ere67GxGfI2QrnqgiEPErXOgq3t0J83FLOjeNSESPgC2QyGFvwQy9
 D8WxbukkqsBqgX5Pann1iUKl7uXblF5JRqw8kRvWH8qaGApvolPYj9CVHmN13qc75cLe
 +Pk/uUrJXr7AGJuYQBG6mN5gIkWC3RbBcWnNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553683; x=1737158483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cxmW22g0vasVwb77y/wKLQrI2B3taWtydIYzvhIdz0=;
 b=Rea8eQ/cy3Q0KB5bNcOvkD5hzJS/ZzVJd0/tM2VWCAunjY8dt7uBZjseoDs9F99mQX
 tWAV3wcP/q5r3eRYNVCjzenx/2nCKpweFfIPHeReA0kWczYKxwdx347dj5UMujwB8M26
 oMO78VbyGkI9I6vwTzFQ5XRLAxSKYNfGW91J4E40wAtTBMCZIH9TlIKisi1Nqehq9frm
 mGVWoTsO4R67KOPb0Atadrv7ehtL14QgbIK7Raut00a8yfDAKpkI2eO5qXpsOXwhcogk
 ZYrNba/YDA0fcdQwrhe9Kb/+U7zCbHq+32IdT1DNsNNJpVskZ5ALJ9ALG0l6StJEiV9u
 Oq0w==
X-Gm-Message-State: AOJu0YxdKAaXTlxZRmh+o0gk3/v/mh6oDdZXCJ+awI+TrFPWrxfdYGfI
 v5dB99xBmwDUAtmKph/5R7SvkKOHYi/ruEHtRDTl4sG/N1K5pNK7UkIgFopC8vopyXSGPxXNQss
 =
X-Gm-Gg: ASbGnctlCFCGTtV4HOeTqvPGGaKWsibRW1Y3cDW0yvlVv3h7JC6nd7bRLWRPr11nVnb
 enQc4YUka3R9FmALUmRAKzT5iUoj1ExGk3f+riRq3zwLJo8vH/b9lr3/EAC9yUwao06+nEArYxv
 mPtaedS2kggni/8ITPQjy5HzhKjlrekkPYVyGqCPv+rsmkZrV/H1CpsUudrK5Y/s6lFJE5ANKw1
 LWgCI43B7TMOvDnn2LslA9XspFv9LXjKHzwFq+gLNxXTnJSH/J/FD9Rda4QGMMCLdAsd5cEh3L7
 5dAk68PEKRGl27srsg==
X-Google-Smtp-Source: AGHT+IEmj6BvFZGoxLIj94fSPN+5unwDjd67qOgcGDBssFMh1E2ERy4jOKtwTJusC1/zwzdq7jjjQw==
X-Received: by 2002:a05:6602:418d:b0:83a:b188:7a4d with SMTP id
 ca18e2360f4ac-84cdfdd7c11mr1219132239f.0.1736553683666; 
 Fri, 10 Jan 2025 16:01:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 16/30] test: Fix inpected typo in upl test
Date: Fri, 10 Jan 2025 17:00:15 -0700
Message-Id: <20250111000029.245022-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

Fix a typo in the test comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_upl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
index 3164bda6b71..90125c4dc1b 100644
--- a/test/py/tests/test_upl.py
+++ b/test/py/tests/test_upl.py
@@ -17,7 +17,7 @@ def test_upl_handoff(u_boot_console):
     proper and runs a test to check that the parameters are correct.
 
     The entire FIT is loaded into memory in SPL (in upl_load_from_image()) so
-    that it can be inpected in upl_test_info_norun
+    that it can be inspected in upl_test_info_norun
     """
     cons = u_boot_console
     ram = os.path.join(cons.config.build_dir, 'ram.bin')
-- 
2.34.1

