Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AD5D60D14
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 383488941A;
	Wed, 20 Nov 2024 10:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B/R9v71/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A705589668; Wed, 20 Nov 2024 10:22:50 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA6B88F20
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso36578435e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 01:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732094568; x=1732699368; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h2g1IJOlV47mLYsx3TtOtxyneiqzUiITMnK01RqI4uA=;
 b=B/R9v71/BPT1/vhs0tcQAEAe4e4CC7D0FzW9Xl1VnfYd9lZkX5L+2qbUYoB/bzI+4G
 MuuntbfncIBP6BsuHtS1bSDgVf2uu/54ySKXotOHf+MDUiEsNxxzMniw4UYg9ISZi0e/
 RRReHEesiR6cWbMnVxA1+2eacLwI+odO6z/eUhp8O+AL1StMXLwNx/cWX5ZcaBMWPq4n
 FpvcYMbrst3LvKReVuxl0GDm9wytLqTnuDIKmF/+XgZifeWw/kRU3BoI/Z3AHQnu4oSO
 HD7chLofF2TT1xxr89lOcdWN9tWNutnMB53xL7cKTZKJ9EXuoJXwhuXFVKq+iRTUKnuY
 LBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732094568; x=1732699368;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h2g1IJOlV47mLYsx3TtOtxyneiqzUiITMnK01RqI4uA=;
 b=IdyFPcpQzBEIXfCHQ6V9F0xnoAL6gXToa0MJ1IfFB4rfKODoN/nQUbxJeWvwTTG/s9
 21VVYOJdxuXcZfff5sNuhVsd5ESX+ou23TwccgD/T83N/emexsGG13bCgyQfb6EsOBm4
 sB2zV9OfAGcmd2TrMXZqKTgLp1iVwDMnyuZjoLJmnG8CSciXRubP4VnayiHu0cnZLFFk
 sNUx67PIJcXXq+q3U9IQHuaR+CAo/2DP9zgWJzNh9z0ugGK2lDKNCiDuNOWEoOlidCoX
 8+xZ+IzIDeWUM4qcUxuvi3ahlv7X1LVoDDqK9AcGQ9f0S7MMb1/bQDk6T0ICbhfSn5Tv
 BFAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp9LQmTx9fBs2u0boWYU4bMvS4I/X/gdJrO97fWDYdeT9h9mTr3541O+/KDpMFGD3I3+Hnj3E=@lists.denx.de
X-Gm-Message-State: AOJu0Yz44Z1VZskUd82VaAmZ/sC+sYX7PfBoJDCHfIHNEjd6eJpHG+SO
 LVK21mppNI7alCJzJpax2iXw36Q3qJWoo747fpXZsNqoOpbSMxIcdoVJMDQqYxGVrk6L7Qge29P
 O
X-Google-Smtp-Source: AGHT+IGnlsZ024xdHkM3F24ItpH9C5ze45ZBttU2DXw1nNJvVQSxnoKrRaUJJYb7UaQmwAdOGcJYFQ==
X-Received: by 2002:a05:600c:a46:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4334f020269mr15641375e9.25.1732094567771; 
 Wed, 20 Nov 2024 01:22:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825490529fsm1557333f8f.4.2024.11.20.01.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 01:22:47 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/6] ufs: core: initial cleanup and defines sync with Linux
 v6.12
Date: Wed, 20 Nov 2024 10:22:41 +0100
Message-Id: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGqPWcC/x3MTQqAIBBA4avIrBvwJ4q6SrQIG2sgTDQjkO6et
 PwW7xVIFJkSjKJApJsTn75CNQLsvviNkNdq0FK3SmmJ1xnYYnYJ7UGLzwG16XpFxtmBBqhdiOT
 4+Z/T/L4fIkkgPWMAAAA=
X-Change-ID: 20241120-topic-ufs-cleanup-23671e3fc9e9
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WTmfeuCjUtKvDuKuiFa4Aut7GeqFJNQDY06vf6iJ17E=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPapjJrhYQoNRIrRHHqrDmXiFsXS73vUPRtkxKbjv
 ftPhsNuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZz2qYwAKCRB33NvayMhJ0T1rD/
 9Wt3KLb3wFLQTDMgXz3pbiLKruUJTnfOPKLCULXZLvHY4L/+5hVZ+TVzvyzJPkYuH2KMtoPk19o+n/
 I9+0U2EvPhiLcYp9sMfS7hl2CQDw5/ElI/pyboDLcljp2Naj4e5Za0fIgFE844N3ckU0IJFHRlxJFJ
 gqeeCpSzMxk5cuJEWTi3aPhylMnfspSQHZeAwRkPIm4Y8Z7q29M5DYAWTuRh01GM3ZIJygyMXXNPFw
 4Tvn4N3ZyenzQVldlzY1Zd5VcxqQ+7sIxxaA3qh6yn4VyONwLm2K/7mO1xJOY0Ui79Pg21An4Qmyxk
 c79IG0vHMEp8jQWVpmj+YpoA7lWem1OUnzsWyoahZ3MrKieAqVXywX2t8CTA/1Y99qi6B7zPJXrL4B
 KeW4usKtLzoHjjWMrMQjVoipEw1gifREr5uY7Smaneb/qWRBWWsfEIpHzsWxTcmuwE9rWs/8vhnmOG
 l15phtdnzq9d+GmNsL+wyoNQ5q5f8z1v2Etyl9cVPr85p/8Ok0T3KYOud74/ofj3p4wFM0m8I7fPBX
 3E9AOjICeApTeh0azjR0C7uJUk1vUJ9EJlN9C6sBz2NMK+2As3ywgJ2ztTPi/XEaW24zsz7MRhutZC
 6pvbhEVy9c4K/h5pOcX9sNHYZ/mHNpy5gx7rNMqkZG2OPpE08EKe1WCFOP8g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

This serie fixes the build and checkpatch warnings, and
does a split of the ufs.h into a separate ufshci.h which
helps syndhronizing the defines from Linux v6.12.

No functional changes intended, tests on hardware
are welcome.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (6):
      ufs: core: include missing include/ufs.h
      ufs: core: mark unexported functions as static
      ufs: core: cosmetic fixups
      ufs: core: move ufshci defines in a separate header
      ufs: core: sync unipro.h with Linux v6.12
      ufs: core: sync ufshci.h with Linux v6.12

 drivers/ufs/ufs.c    |  43 +++--
 drivers/ufs/ufs.h    | 335 +-----------------------------------
 drivers/ufs/ufshci.h | 469 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/unipro.h | 128 ++++++++------
 4 files changed, 571 insertions(+), 404 deletions(-)
---
base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
change-id: 20241120-topic-ufs-cleanup-23671e3fc9e9

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

