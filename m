Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52175E77180
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B4E80224;
	Fri, 13 Dec 2024 13:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YoMHb8zm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DEF080219; Fri, 13 Dec 2024 13:46:06 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746F880083
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361d5dcf5bso17931705e9.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734093964; x=1734698764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FemKKIYzALdLpYA70zP6qxDBZOd7zFXuN0pcldeuz44=;
 b=YoMHb8zmUTgadcgBGfCaTNYsY8cou6PyYHVGa+C4GUQULLJ4t5YmEs0tTYKzWlQSSF
 Hv/32sd0HMiV7ZQA6yRLlKWEYwVapepqaPu4nq4GkpgwqG6++NbDKzGSI6WzGnxzRh2G
 qHO2+5FlQllQaVA7mxPmsBr7HNr7RpUWiNtYHm6jJfZoVogME7y/DpryaE1p83pj16Ka
 QZcbaSLXdJ/vG7WLMT7BPh59DCShz49km6RKQ4jEgPk0ahkQKXs6cTpdLjYXoMhU39vw
 QUyj+p8CI18PoTmglRHYU1VLgmxONytnZXxV2eiFtHyb5ratWhkMWhVH8roEkkyKaP+4
 XVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734093964; x=1734698764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FemKKIYzALdLpYA70zP6qxDBZOd7zFXuN0pcldeuz44=;
 b=ZP4aXPrVRZQOmWVGyy81LOYxAdcpA0QFofC7flxNOcAliHTNBelEg/pBTRU0XTrSlu
 r/JbyDfQ0OtBNy/lNkcHAEXwvXWsYLHvc5icOePTE4F88n7HODT79bHWXkVpWsrWXtWZ
 UPIbsHzBaCKRDlrl72lWffBtIZpcvN+jLHCOV4xJeldAoWAvlKtj5Pkj/gCe/8IwToM3
 OtQvM2Ydg4f99SNZzU1F4pqjkawcinmCmFnLuPf8q8wblbWfIFGenFq8HpIIQvlw5Koz
 mmNF5eVTR8I3iiNip9R7rA5uGC9S45yuAR/aktm4qy7x5FGPEWAOLlaNgfpz0SfAPXJY
 xokw==
X-Gm-Message-State: AOJu0YzjljzrSKt6jc0rmn3Xt8DzkqrU8/zdUVhGLJ15H5rxq1aUC6ul
 OeLnrVYkiQZPexGPH4dRtgnXfTYZ7Z3J48HwA4Tjw4E+mahw0C4xoIZB2rzBlWOZMUC6BzvkxdW
 hLqo=
X-Gm-Gg: ASbGncsiYsqW7f4GHEfV7pMvgM+TGKmEGdiDV6lR1jGHgxOQMNYq3ZzPSnF/Qhxqwmd
 +DRehMgy7ojfGSVoXfB8mydiZpuflZsTe58x6d0RQ/wNx4cS20ou6bpDElJ2RGNs/jYa54tnCJK
 qiyYkdXkgjVm656rIVShh3wYfwpVTSDlW03J6731Nnq29Pvv/4ya1JxQX49T29hLXqYn0ZXZdkq
 Chbj0l4FpEgI+cdT8MBksNCvWGvP5ucjaoNAYgLJwr6ySO7IEaKaDLTVnn6aMFZHQ==
X-Google-Smtp-Source: AGHT+IEZgN2zaMg9sPpb8xciSnoqxLj79bnetOxc93La+HXU1CU2U9DfwAtCFeIAJVY0qihVTlD5OQ==
X-Received: by 2002:a05:600c:1da6:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-4362aa27ef1mr19202095e9.11.1734093963765; 
 Fri, 13 Dec 2024 04:46:03 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:3390:8f2f:2eb7:90a7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248e54dsm7050988f8f.19.2024.12.13.04.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 04:46:03 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 3/3] trace: document 'trace wipe'
Date: Fri, 13 Dec 2024 13:45:38 +0100
Message-ID: <1833d3884f623ef66b81443be87b773b1e896498.1734093566.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734093566.git.jerome.forissier@linaro.org>
References: <cover.1734093566.git.jerome.forissier@linaro.org>
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

Add documentation for the 'trace wipe' command.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 doc/develop/trace.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/develop/trace.rst b/doc/develop/trace.rst
index 546862020b1..d3c8628d124 100644
--- a/doc/develop/trace.rst
+++ b/doc/develop/trace.rst
@@ -163,6 +163,17 @@ you will see the time taken by each function shown against its exit record.
               u-boot-1     [000]     3.116466: funcgraph_entry:        0.063 us   |        memset();
               u-boot-1     [000]     3.116539: funcgraph_exit:         0.143 us   |        }
 
+The `trace wipe` command may be used to clear the trace buffer. It leaves
+tracing in its current enable state. This command is convenient when tracing a
+single command, for example:
+
+.. code-block:: console
+
+   => trace pause; trace wipe
+   => trace resume; dhcp; trace pause
+   => trace stats
+   ...
+
 Flame graph
 -----------
 
-- 
2.43.0

