Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FB5C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 16:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3CD87AC9;
	Wed, 10 Jan 2024 17:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GW/efKaz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4E082FBE; Wed, 10 Jan 2024 17:10:17 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F89876EA
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 17:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-557dcb0f870so3204144a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704903015; x=1705507815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fqdx58IyxcLjtTQ0bJx/bnZSsX+1vye06U2Q0Y6vxMY=;
 b=GW/efKazp/ZePd5bUlQNZI7rO17SRTudXj2YzcXk1xzyD5oELpX5zsG+SqAFjTRT81
 +I3efkaTS2nwa/u3dU6Cp1UK/4tiBafxwmZsRPUN1efCEwfdRSXDmL6QEpIvWL/dmrPD
 T2+3b/9xpVR+e2+3Psm9EN5eZorLXe3BojMfQu+LKiD5+rG0Du8IbA38KwA8GBS1Woeo
 HgkDnuH9RAIGJ/zTixHjF9MMWwlPNBATgDaDYpgNMgz/wTNm8uKTbQFQ9bKuAG/YkeuY
 pg5Orv3v/HJAl444lVsd0pMajsFxZdQePyfiNcygVru7IxThDP1KwMwN5FWJ6dU81xQM
 iMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704903015; x=1705507815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fqdx58IyxcLjtTQ0bJx/bnZSsX+1vye06U2Q0Y6vxMY=;
 b=iVA7Wocm0h3fkBlSDDGa0H/yI8igatnXdHu1F1S+tS+70V5mJLx8Me+OBnGHGwG7pk
 +u8SNhE6Fe1of2tIbI84E4Z7R9QtF/QfyBxk3OO5fc/xpCKtTsmdXgSMATsZqNrItE00
 shxl3jUFWIlHNiOT2sJy3SjgxORbtVZEbh/p7JPv4FAaI4Zcq3iWW3Ui26VdIJFaqhTX
 96m4f1xzeWRar2Yb/X9YiLb+85/7SMtqu+I7Wl+gcFZLZc6d3x9qlB027i83ZlikqgLB
 ciuhXUPsiII/0moATSerTzEF1qNbMQZYd8jDnR+4pppn97fHw7fs6jwGFsIRjOEI2FOu
 W78A==
X-Gm-Message-State: AOJu0Yxx1xs26qs6thvdTDz2pdYHabx63+dy946jBi/2meykanF8Api5
 Fy4Q5lNw1eSqDwCQzlAdJEw=
X-Google-Smtp-Source: AGHT+IGi/k269yJpeyVxFM3seWSaWYFfgQ8uQTkO2itRk4biQhNSVxBzYNX+GnxecFbk75YQYRKaQw==
X-Received: by 2002:a05:6402:1852:b0:557:b5e:eb49 with SMTP id
 v18-20020a056402185200b005570b5eeb49mr580353edy.21.1704903015240; 
 Wed, 10 Jan 2024 08:10:15 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 a23-20020aa7d757000000b00557075b4499sm2138662eds.58.2024.01.10.08.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 08:10:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 0/1] Fix clk-gpio driver
Date: Wed, 10 Jan 2024 18:09:55 +0200
Message-Id: <20240110160956.4476-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Existing gpio-gate-clock driver acts like a simple GPIO switch without any
effect on gated clock. Add actual clock actions into enable/disable ops and
implement get_rate op by passing gated clock if it is enabled.

Testing current driver implementation shows that it is not fully capable
and lacks gated clock manipulations.

---
Changes from v2
- restored probe

Changes from v1
- added comments for priv struct members
- return gatet clock rate unconditionally
- switch log_err > log_debug on of_to_plat
---

Svyatoslav Ryhel (1):
  clk: clk-gpio: add actual gated clock

 drivers/clk/clk-gpio.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

-- 
2.40.1

