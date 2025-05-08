Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28178C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871DF82A7F;
	Thu,  8 May 2025 09:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WbfVqxzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACBFB82A65; Thu,  8 May 2025 09:29:39 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC69082A56
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3a0bd7f4cd5so203699f8f.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689377; x=1747294177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PlvXL0Zf8K+GRVKdRat2groTQMztxyYaQY3s4Ep8ups=;
 b=WbfVqxzqvm8If1nIMgv+X7e9ycRNKol/j4imlxPFFfbArEkHgJfspwfm5TFcn2pvIM
 sG4sdzBREk5kvqyvwlXg5W6hmZyxYAhSDq9LUzwzbEQnBIKugTm76iBw0V7azDLJudFF
 4g/QrjUWVUFwA1pQHZpRMdoDShbB3r6ac/5Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689377; x=1747294177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PlvXL0Zf8K+GRVKdRat2groTQMztxyYaQY3s4Ep8ups=;
 b=eYD4RFu+GQOZ6Co0MjULwuL8UTtfo0RX8MOxqtdHPlhvEANGZW75dIJG6nFnvV66sE
 2ksnqc5NXGRWAqFcsI5qDWvwte5/GdIro+8kvFMHK3akU7q5vx73vE5mM3UsfWZDEba7
 SsnjKI5mHLfMPQ7/GYSywqSeDXJwxbkLb9OMpifDexMd70pgJ40aRRpjKKMxfuy8DFIa
 tm/XNbMGSQXLNc28XU6KIgFqtr5Mhvn1AHQR05/OYfnmNRtytbLtZMqlEtb5motQM7yV
 OwA/3RssqND7f24CCbXLu4SmfbjSUyC7k4xmQJag4QVtGPkK0ODSU+h+3cxmRRZnQJaK
 2iIQ==
X-Gm-Message-State: AOJu0Yw2sPw5zk1J5YqzPreBKJGy2JQRzByXVyopL7ZIAgnd2BVvatLy
 am9Eyh34/wlwDCfHQ2EMr9dsFlv2c/wL0wsibz58d24XGI1XrODqguFAvquvZ1Ni/AtoXbE+zhM
 3is+s+Y3VSQwe
X-Gm-Gg: ASbGnctq6T1iGHydsehs2KeOCn5GOzHyOHk1g9TveuiVfxBf89s81RrmULL2mCM7b4h
 aTVfM/h5psIIsMQKDp5Sc6G0ipF6nR7uu2TIT3p9GHVvemw+ebCuA5dLmE3qUkWhWlx+pCllQ97
 JgrEEVK2tvNjG4PdXSKX0DWW9B2tDBb5RvL0/76zYuLOMMqBU25vGdD7LuI8lXGk6azzmesoxYj
 /7Ge/TrPv24ubGxOCq+5Y1Q99ad898Ng3YxQNSES1xlENmpbGKme9QU126MNS6x7ULhxG/gn2oM
 8FEUZAwPe5QaT+BYyE4AIQv65748bO/E1yYTkw==
X-Google-Smtp-Source: AGHT+IEnbRA/xdmrm98MFC7TmFxJVQP9TUFbVUrsPLlfqY43vugzADSk7xXtBtYiSF3YD6PolzvYnw==
X-Received: by 2002:a05:6000:4312:b0:3a0:7a5d:96f6 with SMTP id
 ffacd0b85a97d-3a0b4a14a6dmr5451680f8f.38.1746689376686; 
 Thu, 08 May 2025 00:29:36 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/20] patman: Use git to set up the test config
Date: Thu,  8 May 2025 09:28:36 +0200
Message-ID: <20250508072907.207175-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

At present the branch information is dropped when writing the
configuration. It is easier to get git to set up the config anyway, so
update the test to do this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 61df82312ba..d055a7e5952 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -448,6 +448,11 @@ Changes in v2:
         self.repo = repo
         new_tree = repo.TreeBuilder().write()
 
+        common = ['git', f'--git-dir={self.gitdir}', 'config']
+        tools.run(*(common + ['user.name', 'Dummy']), cwd=self.gitdir)
+        tools.run(*(common + ['user.email', 'dumdum@dummy.com']),
+                  cwd=self.gitdir)
+
         # pylint doesn't seem to find this
         # pylint: disable=E1101
         author = pygit2.Signature('Test user', 'test@email.com')
-- 
2.43.0

