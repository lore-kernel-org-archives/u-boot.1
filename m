Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7638C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 11:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BBF282977;
	Wed,  4 Jun 2025 13:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="alZK+OZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C4882B07; Wed,  4 Jun 2025 13:35:58 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82DC981FEE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 13:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a36e090102so3899260f8f.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749036956; x=1749641756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hDdGjGPuo11UAz1vccTrjmr4A1M6TX9/tnnHwyFPGjg=;
 b=alZK+OZTmOiDS5bkmaUYNoWhuzuTjZ8+KSKtWU6PFa3CzXdv8sNHyM/JeXW3/rTLlr
 pwbLkwZitKvLVpDeMqcRYYxPj5baOh/ht1CT4cH8eO01nzC2tnKBsjYi2r/He1qINhTi
 VhEpV3rHfyIyHkWL8lQPfoASaJZMODcMzVGv8eq0bu3H9f/sn7/voqWBvBczbjg1vGlR
 G0XhZYTusFrH8GgvrlY5h8M64w79zpXy1acRH9zOWACGYFGz04JDW1vSr2qgzFKgB/N6
 IztdQY5p+CJLj09953nL8LocqBVdQSvzGvcxtCCzE+tccvXyKacQ9kbEMyKzR3ixA27r
 JqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749036956; x=1749641756;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDdGjGPuo11UAz1vccTrjmr4A1M6TX9/tnnHwyFPGjg=;
 b=KQ3f+7pIkEs0uiFE+jwjhLUD/Ukzigv0IjoAtETGemgjxdX/JDySw6599Zm+lY9xyB
 h7JkaVmTqpXrIlhzAyhPZpAfcTRht7qTAezhyYu5PQq5vYBKanJdRvDAE6WNkbnZPSup
 V8Vv5d9birOFekVKtDfzpavMj7xfuYcLiN+GRFGpGVPDnvHT0vsg5aJ6+w3sLgC81KJA
 TuAThJ6D4mbpDF5BIHfmD5v7M271cswvUxILxpw2EzhTa6tmR+E4Z8clYptrxYw7I+EW
 VF7Wcz5hyu5uB5LXhxhthnT8Y/HYOv6sweIFQWLnBSK9RspLuyfODFGuODS4hRHGJsFm
 EOVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJjz9R/4lBsQrY4e0nKOsSO24iStTy3qcaUt0JzWGYWDKp+ZLXQde4SquVLeEm3YQY2OoQH0c=@lists.denx.de
X-Gm-Message-State: AOJu0Ywr4Eh4bEcLb3sHeHGuInaByzPJQ+5KYrmrAiFT/saPaYmQ5END
 E8D6Kr56mnUKjuxDtuTXR2+nwoMxSbyvnDMKPDq/tJdbyvLyPSZx5ve+/T8Hq+vse4s=
X-Gm-Gg: ASbGncvwP/fGNT9vrEaOa7usWuKaG//LfTrFpAysUjTrIAoDNWPHEzsIrodQ5nIFF1m
 Ql8s0nIUJW3XEMteub6wR8/CN+nENkYea9v3iwBKOh2lmjioecJlITeX1t3zgUiGtcs96pa0GXG
 DytiS6qbQ5lZlLZtmFUJzn0/WahQpZvjmAmmKpojMCfaZEMAC/6faMwB/Xde9vdWtpVR2aTSNh7
 2YSwEbFxsdNsvdoguqBjwKX4MfO8mJdvhm81F61ooBLN+oUnAMPxU9v9fhdbkJxdj1oG3yfuPgf
 tHBZ8fzxssu/8fI32ZRLDCdbYoHHTYKPp8eZHLHLoUWQFd0boclzYk9rB8r31cDFq/iiqcrkcE/
 +
X-Google-Smtp-Source: AGHT+IGW54QClMGmbrC1WuDorYs7jezqP5VB/Uk3pOy4PVYu5LtvQuivHL6Qz46pv1bDc/0jfAGaBw==
X-Received: by 2002:a5d:64cd:0:b0:3a3:ec58:ea81 with SMTP id
 ffacd0b85a97d-3a51dc3181fmr1852954f8f.42.1749036955959; 
 Wed, 04 Jun 2025 04:35:55 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:968c:2df3:c75e:5a31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8006952sm192252055e9.32.2025.06.04.04.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 04:35:55 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] board: qualcomm: add a MAINTAINERS file
Date: Wed,  4 Jun 2025 13:34:45 +0200
Message-ID: <20250604113452.1075503-2-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Add a MAINTAINERS file for assigning maintainership of a particular
Qualcomm platform or board (if board specific files exist). It is
intended to supplement the treewide ARM SNAPDRAGON maintainers with
folks who have a more specific interest.

Add an initial entry for the QCS6490 platform which powers the RB3 Gen 2 board.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 board/qualcomm/MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 board/qualcomm/MAINTAINERS

diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
new file mode 100644
index 000000000000..0c07ea2df728
--- /dev/null
+++ b/board/qualcomm/MAINTAINERS
@@ -0,0 +1,9 @@
+# This MAINTAINERS file is for folks with an interest in a particular platform
+# or board under ARM SNAPDRAGON
+
+# RB3 Gen 2 and similar boards
+QUALCOMM DRAGONWING QCS6490
+M:	Casey Connolly <casey.connolly@linaro.org>
+S:	Maintained
+N:	qcs6490
+N:	sc7280
-- 
2.49.0

