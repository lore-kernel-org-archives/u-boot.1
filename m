Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918C5C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 23:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA7781CAF;
	Wed, 19 Mar 2025 00:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gmlo57e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBBC81DD6; Wed, 19 Mar 2025 00:43:07 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6481081C67
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-474f0c1e1c6so59873041cf.1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742341384; x=1742946184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJJCNhsnsZ4shfL8SQD2JiYc2uq9un0HaCgLAhWf2Xs=;
 b=gmlo57e6IvtwBLnYYEFJUubsnR0ENP7BPDlvP2G8HnFOr7z8RhPPJbUVs44DKF8gct
 Dsw5TCjob1BmjlnpiHHJwAjh52zAFk6xOEfL/ZfHPy291f5cgBi94MT8gYOxZbg51bKI
 Q+DhfUTszEdXCUP5T+wRcA1bIp6CJ1TX6/RVdbvgU2c75e+XNYiAVXdkzhhR/N0BUn6C
 b+7LSg3UNalndDissIL9Bu0pD5cnVz2tD7CiJFmReMIwCLLEi1zXo1Xe9I/xdYjwAM04
 rdn8Q97u8/fStM9cS7hkri2IH6oE2xKVVRRH7Ao3SE5Y9RvacfwKfAulny5lYci0HIJD
 h3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742341384; x=1742946184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJJCNhsnsZ4shfL8SQD2JiYc2uq9un0HaCgLAhWf2Xs=;
 b=M/PgcykXhDZdZCkDG7DbwIX6b3s9hhsEODyRZZaE1Kp2Tk8cDKyV3ksr5B+lQoTF3I
 z6yYIoCDsUHy3jSakz1tS7pdWSFHESZtkowlR0bK36hrsv/nfIPpG3XvHpblUmF62eGy
 h6fteKONCmON9L6CJ5eYapFzH8yRg3ejyT8O8NL1OtoTB6FoOpt4RbrSTadHO+2iB1BO
 feXps5Y583praupxAYbjZOzGrDrGbT1QIfalCy8NBaZWfTNNdEmCjJiPMryW4dhX3KL9
 U0Oz0OJ7/eNL0RYwwaTW98/c2f+8HjPE4BPw1Jqscs943qr7zFxxDu6EWO+QGIFkcpps
 luvA==
X-Gm-Message-State: AOJu0YwfECOGH+CJ6mHb6O64WANX0CwsNNm4MycUn2sFzmuOul5eUM1d
 e8p8oPpxnN+yPiZpjnpad38C1XTc2KEhiJ6sbRn5MAc2lSnKNE+/0glckg==
X-Gm-Gg: ASbGncs3P7omg325LrTbVNzUTHOpWiEMoTVCIl6ermH31zjCwnak69elme0ktjMwJ2l
 +yulvT1CfIrpifjykkZkGMdZ4SByo5s0Hk/OJnVrTuw6YBPhxpNWfUg3cXCBSj5QNuU/0gHf79E
 zqtOO1ZDQR5NeE84QzqtA74yp7loIEqdgTjVb5AWTQjAeXXgsm0S0fQauPBZeqlWz900fTxn4Gw
 +WsAy3/SNwFdpFPbKdW8dHF27FbzgTDtd0n83efn6o6hvqgujOhn/kSzKghZ415DrWXr4xSuov+
 dVUWWBDQLSRqXyo6eo76Zva0Ja+OHU3W2oX88fI7bk9Log9fp273QLxxErqM+VgusUj8hpBwhk4
 S03bSqhM/USowRvxCku+vxCtIeWhDkg==
X-Google-Smtp-Source: AGHT+IH1HT0VvKhnkap9+n9RdslPcKJDZvovDvQmjgWrq4yQkLHm6pTUR+5EJZH9+A4WE9F6uLJB2A==
X-Received: by 2002:a05:622a:2514:b0:476:97d3:54f with SMTP id
 d75a77b69052e-47708375328mr16267271cf.14.1742341383995; 
 Tue, 18 Mar 2025 16:43:03 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm72518261cf.74.2025.03.18.16.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 16:43:03 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V3 10/10] board: beacon: imx8mp: Let clock system enable UART
 clock
Date: Tue, 18 Mar 2025 18:38:38 -0500
Message-ID: <20250318233849.587520-11-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250318233849.587520-1-aford173@gmail.com>
References: <20250318233849.587520-1-aford173@gmail.com>
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 board/beacon/imx8mp/spl.c | 2 --
 1 file changed, 2 deletions(-)

V3:  No change
V2:  No change
diff --git a/board/beacon/imx8mp/spl.c b/board/beacon/imx8mp/spl.c
index 30d577f7e0e..6b357d90a3f 100644
--- a/board/beacon/imx8mp/spl.c
+++ b/board/beacon/imx8mp/spl.c
@@ -112,8 +112,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	init_uart_clk(1);
-
 	ret = spl_early_init();
 	if (ret) {
 		debug("spl_init() failed: %d\n", ret);
-- 
2.45.2

