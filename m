Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21426C28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DAE880F9C;
	Wed, 12 Mar 2025 01:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UtMty3Lr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4238881A02; Wed, 12 Mar 2025 01:32:07 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF3781895
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dcd4f1aaccso88843776d6.2
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741739520; x=1742344320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lh6EZzVenEwH2I7NCyVltN4nA1m57eno6Xr1AUHPyyU=;
 b=UtMty3Lr77w5b13r67zKpnv8/Eba6iSGFYTdE7DLyfzhZIZE1UkKJV5zYrk8ms28Gk
 VMwry3NBi93SgXGRzSUqwYLqwJ/hq+LL38ukIBJmBzcT8aCzkAHXm9UCug+ZcuaWxhnt
 5AvCVAlyMjt9A6DT++RqKlWk0t5qr20i+4AqAu/1KUO310yQP+tHCn8exd/jRbpk+BLD
 UcYr5g620rq1awnuBpb0mEJ0YOWAlVNPL+RA/+FDTpL3WTzF455szCG0wn1HnW4b8CoM
 ItbVekGZXlgP3e+oyGO8/HCcx0I90LXaSfWnQ6mmpEt0mYCvDyanrCB3RfmFdLBdU3vI
 kaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741739520; x=1742344320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lh6EZzVenEwH2I7NCyVltN4nA1m57eno6Xr1AUHPyyU=;
 b=UgHaOnH6ErrLRzSHsP3DZVfpPx287igvERVkHOHpM97XCFTe2OwNAXkOlCbaR2VDO2
 Bgwn+pikp/J3p3DyGnqEciYafcUnvmVbHo+7jxYGH6dP0XIoXb6lioox4L4GDsbORYfy
 Nei1NGgi/rfJursCnJAuD1xHtUqj69jvbjsvgM6nXS0iqCZrZE0bNXA9A3ZtXe5CYrcX
 etIe9xyHO8CVP28Pz5TDasj+56le64GwzkvcgdhHwobUp+Z+HMary0f9Ddu720e5iAeu
 5wJlpQACjE/hP78RcVEsbdTcltWQoyaRWLJcFBqT2sQ/U9KKcAmvnRuWp46FKaUNZtbO
 ataQ==
X-Gm-Message-State: AOJu0Yx2gsHOay4wPwkSoTuBgppl83IjSCroL7f5yuWOARgNXBon9XNa
 6/qzTtp0I+wt497UDWqyXtI58EcRcayC6/SsBwWV/2d+xsl+YVGL+5/j/g==
X-Gm-Gg: ASbGncuJnK0elNzVU7ef1fP0D82fM8pZim/5iJR/nqrtngw0FSyCrPRF9iceEqAZHuf
 ZOUbK8MnPjRhVOvZIlHdobLKtdHOrANiR8D2YaqDPQ6XLpBmwWBsdux8g2Sym4e7Kq1N4Ghrcge
 8etPU8oqizF7CfOnxTcM+reyj9Y6PXca2/koy/svyLnVTgGh5EfsZeS7yC14+3agaWBeCf3zq5F
 ICqFBV+3bcFY/I+9OQSLrXk+H/qhRvDaQhTWM76WN0k6W1pewCfwPb/8phsW++u+1VEI2I3QL3w
 LA25QA7dQi6qDinO2rkp+aDgF0Y/DCE9pj97wuQX6IqQ25jpLu/fT99KLj1Vi9UMwXSSg4izVM0
 564EodVg4T16v1dq+vto=
X-Google-Smtp-Source: AGHT+IEmuYc0l9DKPFnmEJqcCkUzx2IRm7le98q3I71/1ERLNQW9dhp1GhkiuxN8pu+rHv6EnbTmKQ==
X-Received: by 2002:a05:6214:dcf:b0:6e8:f60b:9396 with SMTP id
 6a1803df08f44-6e9006aced4mr256577576d6.29.1741739520474; 
 Tue, 11 Mar 2025 17:32:00 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b798sm78025286d6.80.2025.03.11.17.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:31:59 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V2 07/10] board: beacon: imx8mn: Let clock system enable UART
 clock
Date: Tue, 11 Mar 2025 19:30:27 -0500
Message-ID: <20250312003041.110023-8-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312003041.110023-1-aford173@gmail.com>
References: <20250312003041.110023-1-aford173@gmail.com>
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

Now that the UART driver can enable the required clocks, remove
the hard-coded clock enable.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 board/beacon/imx8mn/spl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/beacon/imx8mn/spl.c b/board/beacon/imx8mn/spl.c
index f03841e5a01..e91d3fdcf5e 100644
--- a/board/beacon/imx8mn/spl.c
+++ b/board/beacon/imx8mn/spl.c
@@ -111,8 +111,6 @@ int board_early_init_f(void)
 	/* Claiming pwm pins prevents LCD flicker during startup*/
 	imx_iomux_v3_setup_multiple_pads(pwm_pads, ARRAY_SIZE(pwm_pads));
 
-	init_uart_clk(1);
-
 	return 0;
 }
 
-- 
2.45.2

