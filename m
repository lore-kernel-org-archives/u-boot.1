Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ECCEEAA56
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16DF9869AC;
	Thu, 14 Sep 2023 18:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QsOJpp44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F2E387071; Thu, 14 Sep 2023 18:21:04 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7EE86672
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b962535808so19086941fa.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694708461; x=1695313261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDvrCmEs4AowbUl/thMcgKJCloHgFxRz4FWB3a/1gSQ=;
 b=QsOJpp44qTLVg2iIUr1aiqkyGWo1RsSMz2AtoZ1SFIp5J8fFwEgyAPel+gUhrntAvH
 fs7IdA1q/G9tNUCMx96i6KT8QVuMcZ73lNppooGTV7V0sHe1i5PEHGf5rt2KNW/RFAzh
 fh/wGE46b/rzrgVZ9ipezi0Kqw7DBNK44M7ALUCGoGb4yteHUsj5YRHVfIH0/znTsKLA
 +p4dj/qyvw6F4YygQLfijLjrP9lajaUZm4wFbBnZNgcNsh0hWiyF5k+9MSO1cLMSborC
 ehg/EVwHO2YBHOxeUnXGtjFpJqHgcYYHY5ehYbviwMnwsxK0ILy1CGT/JravtBsJuXX1
 rz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708461; x=1695313261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDvrCmEs4AowbUl/thMcgKJCloHgFxRz4FWB3a/1gSQ=;
 b=g+hR4jeHYtG9IMUqXkDg15DFMa0DxTpJFJP7dmiJTwR30GtBFhNTm1Hg4Q1Xtg+4mC
 LIJoMhD2E6g8NhBWlSVU4nJpbgLFKgOOpaMqVOyb+9UW5l/ucIGer/ZwsP1i7R1iNIsR
 PAb6fTbtOuDlMmYaK4+d/tBgELkq5YshsB2ssTalHrxwyttLSxlezawYJ2bxi/2jfVrt
 NmjzG78Yd2giO4/B0S409MAvb/4pmiA10Wkscs/8liuriyQOiBUQGfpx241VXfYdBM6b
 zOsWmxaVYt7JDP/jTSbVppqSaoMUUZhxAcYyofXIydkAnl3HHBfIzDYbz/YQatHOjzI7
 JNlQ==
X-Gm-Message-State: AOJu0YwV0YCshT2j+oXzt9RSYxXZdpDkVJtZKw3frMP5WarIObhG7ube
 SoxCIOPXdPSYg/xRfpOOvBccdcRxHdCxlKu52a7x8Q==
X-Google-Smtp-Source: AGHT+IFjAzf1PBzdUsM4GjdPKBhGNzd2tIiYiv8rs3f99jckDtfQkd3/2JPaBcuYP371oxLAGszafQ==
X-Received: by 2002:a2e:9d95:0:b0:2bc:bef0:8612 with SMTP id
 c21-20020a2e9d95000000b002bcbef08612mr5818528ljj.23.1694708461337; 
 Thu, 14 Sep 2023 09:21:01 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a2e8e8f000000b002ba7ae1f52asm346919ljk.0.2023.09.14.09.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:21:01 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 11/15] net/lwip: update .gitignore with lwIP
Date: Thu, 14 Sep 2023 22:18:24 +0600
Message-Id: <20230914161828.3662-12-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914161828.3662-1-maxim.uvarov@linaro.org>
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
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

ignore lwIP library code and reused files from the lwIP.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 net/lwip/.gitignore | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 net/lwip/.gitignore

diff --git a/net/lwip/.gitignore b/net/lwip/.gitignore
new file mode 100644
index 0000000000..7b5dacce90
--- /dev/null
+++ b/net/lwip/.gitignore
@@ -0,0 +1,8 @@
+lwip-external
+apps/ping/ping.c
+apps/http/http_client.c
+apps/http/http_client.h
+apps/tftp/tftp.c
+apps/tftp/tftp_client.h
+apps/tftp/tftp_common.h
+apps/tftp/tftp_example.h
-- 
2.30.2

