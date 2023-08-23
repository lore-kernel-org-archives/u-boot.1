Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D85C3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A24378646D;
	Wed, 23 Aug 2023 20:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cKN/I1CQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE2D864CE; Wed, 23 Aug 2023 20:48:11 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 152B7864D7
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34ca192f8feso15376485ab.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692816487; x=1693421287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0tyUKd60R2HMIvPZRZ43n+w+lKpnM7XhEqsNZGdIdk=;
 b=cKN/I1CQKsbdOTpeKz9q1p7IxL2VoUz8mDT3kODMdofbO24fd6Hl6AvRpSRxsM0d8r
 llRDsHd2HD5cDMYsjp09aTw6kEb7tLdCXynrnrCHc96WVyzxix0cztjqoBIPrF+qBwQN
 wSkC2fSjYsonc7D9bJAL+Vrpr7dt9X/4I94Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692816487; x=1693421287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0tyUKd60R2HMIvPZRZ43n+w+lKpnM7XhEqsNZGdIdk=;
 b=k2PlkBVLbANyuEHclaxsLRifaznmVZgQdaBFwJBBZCxrRXmWzSONLvbngA0j8BPRg/
 0d/x1lDli2C696q94bI9Q0rW2sU45XIehYKw8VHzIxxGmAsK5EvtMj7jNe7BXuBHZcKY
 QpyDzuET2ovUlSQU7b2eNkpMeQe/II+xEt/TfDzfpNBABsZrd2OkxlF/QgWh+jb/f9Xm
 TLi5ZQVYhWv9yzgU5j+LujDAscZ4aSIsdiTWWVSnV00kpSxq1dWB6kt1u+VDWSjudOxv
 N3Umn+o0ig+S1/DZ/mhtQqCm6875sSEAqYXgxCtTA+KfsXVsqBDiOZj2rjITbWEsNL9a
 BGog==
X-Gm-Message-State: AOJu0Ywbvvn/C8jH2D/W82tuQ1seVxyGxoXpTkOPetjeSWrjoIa4gFAw
 G0jE7w/L4o9TKLi+vTAffZWzJbJNCocfoImbgjk=
X-Google-Smtp-Source: AGHT+IE80/lhHFtpvUOrrt97wvkzkQ7gSXFcjmz5zvmmCS5O21oDJQMSWZnuvNdQKB5QAkiba7lhew==
X-Received: by 2002:a05:6e02:178b:b0:348:ddcb:137 with SMTP id
 y11-20020a056e02178b00b00348ddcb0137mr4170495ilu.16.1692816487571; 
 Wed, 23 Aug 2023 11:48:07 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a02c054000000b004182f88c368sm4070929jam.67.2023.08.23.11.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 11:48:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 7/8] spl: x86: Avoid starting up PCI automatically in SPL
Date: Wed, 23 Aug 2023 12:47:40 -0600
Message-ID: <20230823184746.842091-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823184746.842091-1-sjg@chromium.org>
References: <20230823184746.842091-1-sjg@chromium.org>
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

For x86 platforms, PCI is core to their operation and is managed in
arch-specific code. Each platform has its own way of doing this. For TPL
and some SPL implementations, the full driver model PCI is not used.

A recent change enabled full PCI in TPL/SPL for all boards. This breaks
some x86 boards, so adjust it to skip that for x86.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 0062f3f45d9..13d7b1a742f 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -800,7 +800,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	    IS_ENABLED(CONFIG_SPL_ATF))
 		dram_init_banksize();
 
-	if (CONFIG_IS_ENABLED(PCI)) {
+	if (CONFIG_IS_ENABLED(PCI) && !IS_ENABLED(CONFIG_X86)) {
 		ret = pci_init();
 		if (ret)
 			puts(SPL_TPL_PROMPT "Cannot initialize PCI\n");
-- 
2.42.0.rc1.204.g551eb34607-goog

