Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611D0CEACDF
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 16:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A600489236;
	Tue,  1 Oct 2024 18:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MdxV45uj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6520F88A34; Tue,  1 Oct 2024 18:03:50 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B56689212
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 18:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3e03d17365bso3531000b6e.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727798627; x=1728403427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=fUfoQkDscu1W4z2m6w2/tsCmCcOfbkf2JWdOdJhO/eM=;
 b=MdxV45ujqCJxoi5Y6VXUfxCE7SAHzAFG5oeeptsSsTa3ttZI4TQNMWGVZin9942EMy
 l9WJPAUEjDBGvqeTxaxAKJ+jyW7XRpsSyBt+MdJ8/frZxDD0d7CyXxxCQVywG60VBP3U
 8chawFBWf+g2w2c2rvqLbLC/dwrACXB86EAPnhUv7Dh/croMAS+Z+3+90kfWS6nELwyc
 3Wyvmtq+x0ohqzk3WXjYh/uoEHxs32H+toKF25axcB1a34EmG3LjEznlQlxQDsMsBJgs
 0knOfkiW7XWM3J0ziO5AAUc1IqslnkCTvlfBkk7x7ytba1TbkXjauWU9xXE9TmFtlxEL
 9ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727798627; x=1728403427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUfoQkDscu1W4z2m6w2/tsCmCcOfbkf2JWdOdJhO/eM=;
 b=dtEWbYCAxnPc9vBbYOcLJMJLG/wR4ICeMavBOTuZdFBSSfLzDmy3Eo0qsjXMnZnlYy
 2oAAjRRbf6+ovvwPf/kFlIzCXC30usmkhL7IyJV/vTc72yc2jQMLdresojq6yShA2+C3
 hYi2sZyY4NWLVjfAUiDYV3C7hT7XJtDFL4rLu7vhmxefM5uya2JZFI/SochhQauUdKLn
 IWo8R6NjDSgvXAYOc9Repks/DOtV7+orbz49vt5cvWPSVK4LVdHUrfHLmhfj4ci+3wN/
 r/4q1Qw0XYXBkzKLLE/v7FNIifx34Bk2CpxYGH3DjiHIJ0bXxaF+81cHMnZyK5AFwifG
 CKGA==
X-Gm-Message-State: AOJu0YxH5qILGSpakdcq28v4OPML1g0BJ8KzcyXLBeOLflg01ab4B1A1
 Dgac9n7wq9qnaMd9N+240q1PuxR1ndsFd27bf+rx4GY+y33W8P9OtiLR3DBk
X-Google-Smtp-Source: AGHT+IHIKAdSd9e2PqZ72Gi7EEtR46nUnIkfoY+w2z1CRIvyGkkbsDcWmQPokmsfMr9X+58wxtYWsw==
X-Received: by 2002:a05:6808:320c:b0:3e3:9a24:4c63 with SMTP id
 5614622812f47-3e3b40e1dc0mr278562b6e.5.1727798626668; 
 Tue, 01 Oct 2024 09:03:46 -0700 (PDT)
Received: from localhost ([111.184.129.17]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6db2bce30sm7403440a12.38.2024.10.01.09.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:03:46 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH 0/1] arch: arm: dts: imx8mm-cl-iot-gate.dts: add no-mmc-hs400
 to mmc2
Date: Wed,  2 Oct 2024 00:03:23 +0800
Message-ID: <20241001160324.3894617-1-paulliu@debian.org>
X-Mailer: git-send-email 2.45.2
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

The eMMC device on imx8mm-cl-iot-gate seems not support hs400.
When booting 6.1.0 kernel we got the following error.

    mmc2: mmc_select_hs400es failed, error -110
    mmc2: error -110 whilst initialising MMC card

Add no-mmc-hs400 to mmc2 node solves the problem.

Ying-Chun Liu (PaulLiu) (1):
  arch: arm: dts: imx8mm-cl-iot-gate.dts: add no-mmc-hs400 to mmc2

 arch/arm/dts/imx8mm-cl-iot-gate.dts | 1 +
 1 file changed, 1 insertion(+)

-- 
2.45.2

