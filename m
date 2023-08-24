Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3A2C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECFE286A64;
	Thu, 24 Aug 2023 21:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gznLLOpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B6F86A01; Thu, 24 Aug 2023 21:59:35 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10223868BB
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7927f84525dso314039f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907169; x=1693511969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vi/VbhOQ7GH9BD351BzJZ9hvx2dD5oSS55MB98wB9Y=;
 b=gznLLOpNCf4vdQuNzZmwla8mcDbp8b9IkF262gBM6GrTmb2hXSJ8EacylR6PfuyjvN
 UhU+YeViJfEe15wwvw15EpMQHQoq3gu4ObQkTQ5qP6vInWLYsRzQjacvF/4rbSuLJ38a
 DKF08opcokeTlLujwVSgsbVcb0F+eyVgI9Rw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907169; x=1693511969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8vi/VbhOQ7GH9BD351BzJZ9hvx2dD5oSS55MB98wB9Y=;
 b=dWWsxn6l9T1O2XJKIsPCTQxkGzx10v32rLvgFpnHttjPV4WSbzKyoPP1e69w9gvHw5
 7/NlqD5dLtMXJTdz8/J/5eKoyMCNs0SOB9yteSatXNzLfPmACd3SlhArBXQyn2cBQ2j1
 8RODrtcGRy+Fbyb7qxCpUd7LaeY4TN+N9ZHDF2QjvBqSqRtI+6BXrkYrVCiTWpN1SY7+
 Ha2yLBwaJaotMbusUWDxfDu7ncNUg7fmNNrMMlNUO1z3Z1hx2H3xl++0qd7ee63TQxDg
 /DPBqiXtDKURf8vjncFMKqOnzsiROwJFTtCvqxtx1hf1FVBt1LN3BDMD1KgGJksSfHqv
 Cybg==
X-Gm-Message-State: AOJu0YzuBLfW8XDsgywODd35iznvMRfB9/ss03yEF0GVLxltykhVY4Ar
 gbqPRsa2o2wEuzMVFmwUiLItYCG+axNzG5ujTKo=
X-Google-Smtp-Source: AGHT+IErwCVh5fR1O/UoGYBGx9EzCCrNqGao0ckcMrMAA4YQqfMKN22QXKIf8K1CXmQ8j5tiH+gfiA==
X-Received: by 2002:a6b:4f03:0:b0:791:1739:d525 with SMTP id
 d3-20020a6b4f03000000b007911739d525mr6710249iob.20.1692907169728; 
 Thu, 24 Aug 2023 12:59:29 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marex@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH 03/19] video: Hide the BMP options
Date: Thu, 24 Aug 2023 13:58:54 -0600
Message-ID: <20230824195917.1687886-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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

These appear prominently in the main menu at present. However they are
selected when needed so do not need to be visible.

Make them hidden.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 0b09bd68bd13..844531a59eda 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1169,12 +1169,12 @@ config IO_TRACE
 	bool
 
 config BMP
-	bool "Enable bmp image display"
+	bool # Enable bmp image display
 	help
 	  Enable bmp functions to display bmp image and get bmp info.
 
 config SPL_BMP
-	bool "Enable bmp image display at SPL"
+	bool # Enable bmp image display at SPL
 	depends on SPL_VIDEO
 	help
 	  Enable bmp functions to display bmp image and get bmp info at SPL.
-- 
2.42.0.rc1.204.g551eb34607-goog

