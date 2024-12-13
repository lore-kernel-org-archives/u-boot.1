Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C9BE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA8C80141;
	Fri, 13 Dec 2024 13:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UJ7A1ON2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EADAC801E7; Fri, 13 Dec 2024 13:46:03 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB4580083
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e3621518so808894f8f.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734093961; x=1734698761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T4WOs/uCGijb2Ti2avwAulgOW1s4b23FrjpXxKa3cvg=;
 b=UJ7A1ON2obat43wPWmj9lSHmeZNkM2xVQZi9OeE9rzPNEhtqVpMg7r6ohxpMnSK+Ki
 CwyaRvPBn/jIwLOyfRj/JuG11mTDdkIOcbBF6Q90AZ7RRiACIg4oAs354qkzbgM26b9y
 G5PdkyQcCB2BlnihyWvQdIkGTJHLEynRPOymyd8WAwRYOHLTxKiuky4wwdMtVKEl03CN
 d3RWJ8lEUe3Mn90tDQiLsBtuRzMffScta5Rp8Aqog6NGpVYfFSZPfdfY/2LQ4Ev5V/bP
 dm3HnsfJ1fTgBsRHhXEd0msjbJTzXQyiMAnU3bxmYOqDj8vWhPe9S9YHC0dVVAXLGINm
 mpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734093961; x=1734698761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T4WOs/uCGijb2Ti2avwAulgOW1s4b23FrjpXxKa3cvg=;
 b=Be4KGTy3EEfWfMmMQr9Q5ONHDDeIa5/GlNVaAf/4205C+gOAdbaGfCVwTIUSQRxPdQ
 26P9lyGdOUEr0mxfwF9p+x6lXavVmL9zOcF99g6kM82oQCx9cxC1jJLo94kO8vpWBtp8
 gG0nDj9yDehggmli3etiN+VnGKMNUSDE9rCmM/QYFFioaWTpvgqmENLEpRygqmcUUJyJ
 vSO6UMd6SiDD8TBj418mfs1G2Z0aXgkYcimQoc6c+AEWcpc5eBCbJEc+zu1NP910AjX5
 vO+XwrCt2XU/5SNfu8WYCKztHMpN3WxvLJIYPyeBzoXXek6WQc/jS2/Mpww1UV8+HYSC
 rxkg==
X-Gm-Message-State: AOJu0YyezuTJuemyVNzdhtuABTyueWl4IKHlo3x9u9zXIHbgcGG4Ng9S
 pAt6e4kll+56bCMscbauuUMuyFG7fiQ3ElRO7zPvv+oSjmcE+7NzBZIfb+Qr9RJc+sYqKcQ4T4P
 cD10=
X-Gm-Gg: ASbGncv6OyzF5pYONzPXoSDIzNAhA/NmlNj3kW62vl0/ai3W4uanOkXvbT+riH+vaQk
 k9PeSWuUHxW0eIzVrumj8O6LMSLgxxUejy/Bcfsbd7D3nmX9KH+xDx1uM6JBm+gd/j7/4eFAn0w
 PIJhVWD7rCLE/qNJZnkfmprQHd7ST68NF5QZeg7K49Paj8UnWGOlZBxqxeDelYpfef58HHKPor+
 6O+Q7oFeMQ4BrprpMWV0XYlC1LyO2IeOj/lG55LHnUlAujECM0QWfVncdm5q9tJVA==
X-Google-Smtp-Source: AGHT+IGxKrr3LDHhulp8uf5ypi6x2Tm8HkkLLJg6p3el2oRnzD0jQ42F+GbhG8B9vO7gPFJd+ruH5g==
X-Received: by 2002:a5d:46ca:0:b0:386:3dad:8147 with SMTP id
 ffacd0b85a97d-38880adb114mr1426257f8f.32.1734093960713; 
 Fri, 13 Dec 2024 04:46:00 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:3390:8f2f:2eb7:90a7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248e54dsm7050988f8f.19.2024.12.13.04.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 04:46:00 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 0/3] Add 'trace wipe'
Date: Fri, 13 Dec 2024 13:45:35 +0100
Message-ID: <cover.1734093566.git.jerome.forissier@linaro.org>
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

This short series adds the 'trace wipe' command which clears the trace
buffer, allowing to re-start a capture from scratch.

Jerome Forissier (3):
  trace: add support for 'trace wipe'
  test: test_trace.py: test 'trace wipe'
  trace: document 'trace wipe'

 cmd/trace.c                 |  5 ++++
 doc/develop/trace.rst       | 11 +++++++++
 include/trace.h             |  2 ++
 lib/trace.c                 | 47 ++++++++++++++++++++++++++-----------
 test/py/tests/test_trace.py | 30 +++++++++++++++++++++++
 5 files changed, 81 insertions(+), 14 deletions(-)

v2:
- Change 'trace clear' to 'trace wipe'
- Add doc patch
- Minor edits to the patch descriptions

v1:
- Added patch: 'test: test_trace.py: test "trace clear" command'

v0:
- Sent as a single patch:
https://lists.denx.de/pipermail/u-boot/2024-December/574148.html

-- 
2.43.0

