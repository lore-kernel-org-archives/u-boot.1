Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15831C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A75B83B99;
	Thu, 10 Apr 2025 14:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CpBW0lnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C0783C29; Thu, 10 Apr 2025 14:43:47 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8E983B98
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-86135ad7b4cso21149739f.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744289023; x=1744893823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w55dLa77SMOeN68ZlS8nTMHdPfm1EkSDnBi4YrywvYs=;
 b=CpBW0lnRgBl/TdTJ95erWdYjr0ZL0/UTMzWhpkkewj+VcbbrxHZk3sXONtALb9H0UG
 yJPbQzumoIiAlqSzPZ1fmjzJnmeu1xiKwcUPCgPOkepRSMuyOhqB5s8yZ3briTPxEewt
 lC7uKhNYEcfLBufxv8+rNwN8n6XI+sV+EMH/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744289023; x=1744893823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w55dLa77SMOeN68ZlS8nTMHdPfm1EkSDnBi4YrywvYs=;
 b=JD5mRQeek7IIg/63bvFLfpdqWS8eg73y8xMISOEQsgy45KZTyupmrsfAsIMXz0VcK9
 Wfb2TmvLR2lYXR/AKPa/HbwXq9vk4eUssCzEK7BPu7u/s1J2gzSIT1/dmoZwkjHLK211
 yTcwFTFeSk/V3tlF/4DatuF2QyeYokK4IlCH7oik+0sA+Ou5AQNfJjBNLWDHEMgQ4BlW
 CJxqRLypd+8E43LE+phD0vtZUpJ6lEpFthWS7tAFNiHsJaDa6oCNS4Q/Z8Ns0g7IEX14
 4ddjpm/IC1wFEiIvt1LpH6UyWRET9GIX8uGUOyc0Fdu8GCxs67/pREG0+a7Colcu+Cfx
 RIIA==
X-Gm-Message-State: AOJu0YwEaD3hvmF/HvqoHr8X7KeHQ2o50aQr3Tp/zhAH2lVJskYN1IIe
 WPoYo3IljZ+it0BPC8e3JUQxFgFpjP8J94E4iBvnYsomnWHnn0gWoczx6PvaM5tRz1WBLRkj3Zg
 =
X-Gm-Gg: ASbGncs4+k2dcCAzK0PTB58RJhq7oGCpLEmI++Y4Ri1Eu++0RbG/T5K/egYuRcdQBbe
 3shfcT9OuFTurgApiAdZGld5UuugESObCnkSoZ29E+4/oka6Tf8z5MrLzFK3Pn3nMo0xvY2Xk8I
 08RcZhiC9Hek86uUWaWMxHMsyjL/fdLrEvhw0Uc3X3+fN+qBH9j8NtZpPk28L0xBR4uPGiHLhFa
 +bH0sMuFxFzmw2QqTw1IkJut4RlcX219pJwRnWhYperEGrae12TuL1YIHwoohDriTPeWQf4ecKQ
 vXlU/VLZ/ZT9zVUyBB9YtIeCWVdycu8noq2LyvAxdbFyNI0c0Ux2g42ApoAEtB2IEe+j/62GMjY
 idA==
X-Google-Smtp-Source: AGHT+IGedCm5yngI5DVGDeKCza3+v7n8Ghf1T858FsD5nKedSkngDrdgGFphhWN6w554oHihauqr4A==
X-Received: by 2002:a05:6602:7207:b0:861:6190:1d83 with SMTP id
 ca18e2360f4ac-8616ece5dc2mr271591839f.1.1744289023330; 
 Thu, 10 Apr 2025 05:43:43 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d170e7sm729471173.32.2025.04.10.05.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:43:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/8] binman: Add coverage to requirements
Date: Thu, 10 Apr 2025 06:42:58 -0600
Message-ID: <20250410124333.843527-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410124333.843527-1-sjg@chromium.org>
References: <20250410124333.843527-1-sjg@chromium.org>
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

We need the code-coverage package to run the coverage tests. Add this
package.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to add coverage to the requirements.txt file

 tools/binman/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/binman/requirements.txt b/tools/binman/requirements.txt
index f068ef75a30..7db72e888e3 100644
--- a/tools/binman/requirements.txt
+++ b/tools/binman/requirements.txt
@@ -1,3 +1,4 @@
+coverage==7.8.0
 importlib_resources==6.5.2
 jsonschema==4.23.0
 pycryptodomex==3.21.0
-- 
2.43.0

