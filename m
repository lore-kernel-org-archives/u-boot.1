Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB70C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37E4F8141D;
	Wed, 12 Mar 2025 19:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QwuplJ0s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF2078141D; Wed, 12 Mar 2025 19:39:49 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 459C480756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so458327a91.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741804786; x=1742409586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/azYb3m0PpobIfy6lUlxbRmVRc2FZdOFxen+svpQ3Kk=;
 b=QwuplJ0s+rWd5nNCh1ESTdvvebl4NEDyKRYw1pc531OjNStayKQvqbvy4pNgLOzmpk
 XyVz8DExEe8L9/2Fr+Q54MmlGfsrqwXH95ACSoOhuwQyfrPGYJxhEmVCJLRxz+rD372Y
 qL/lQX6JfjyCyD5g2quksJ+2tQHXKMd9/LStD0GzVM0bOtL9P6Wn1jUxiCCssRQ4FY1M
 r3QZ8N4yxMipzWiU17OIzDorP1zmj1NGr347TLYNCuGYNirMOl1Z8o5nzVjBSEJfzvXX
 dnVipOBg5uggAnOyshWaojPic/Ty3FeSS7SypbrNcpnt+2su623B3FdqAOieIhsDcJ1b
 s+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741804786; x=1742409586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/azYb3m0PpobIfy6lUlxbRmVRc2FZdOFxen+svpQ3Kk=;
 b=O3rSv/24tf4xqckDFpNFc0vnH+1eCyM5zSFJBzVcb6r9YKGrirbv0fUZRqcqR3wpDz
 Zhb0B5q+/l2zUVEw0Un8pY7EqhdHJYAJPmV47mltgSPhzEYzGLTELMnP/avUrulIX3Jr
 RQjAnlCbuGw0WqFqUsBkJtQx3yk7WSRrei3rkplFF9A1jyZJMq2ygDmeIu2fhMQxLIYo
 +JYiIScfnHZlxUEY8U9RkPblJqojMwRO9wgPqmLzAO+djCvaPrKScfUdKub15RoG9kHb
 LE+Fnc/yU7IdarS7dtbcnE16GhiHPulJWT8+znF4UHFbQRukzPyotuKEceuP2cZEfNU7
 1ZiQ==
X-Gm-Message-State: AOJu0YzfSsq9st6S41VLd032YsZ5vSMvznth28qXUya7oAsCmtGNEUCC
 N5BY65eXshCIQBkfMp7JquWHL+wq//7dlUQf2a2Fx1eZRJUH9CJ/
X-Gm-Gg: ASbGncse+gbAp1Y6K+LNTB5sax9Q1SlGeJ/MoiszDXvFUoW4f438q6u/Yd0gnD/vWmQ
 v0YJ+Y9rXuqCEAEs1X1WeGOphtV7nK49StFOYwvuH3deUIQKcBt5djL03uzTqnFU3esb+THUmsf
 PnDuC28bpF9puCu7YjJsaMZDP5t1xLfiyxq7uAtLBvy+EKlWgvY5bCu2KGwg2ZnGDBfYL7j4XT0
 Xy4qcFpPy1nrcSoxCJuXKrfV9CuTxyt+uN0C3nwPwBpC0/h+F80iwUZnP2WbTIswce/dsVnBQCb
 FdAeiJ13fSL7aKNRVktNbDat/c55d10Qs8aBjv7usZ6/9IpeOvYq+uSzex0=
X-Google-Smtp-Source: AGHT+IFatk1Gfy5ckJVxiqozrwyVcL0eBrPd+2AO7IC8DPaIgmokfgbWYb2pyz0M66d+knYMYpfY8g==
X-Received: by 2002:a17:90b:28c5:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2ff7ce6f0demr33185977a91.8.1741804785608; 
 Wed, 12 Mar 2025 11:39:45 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bb06:49e3:76de:6a9e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3011823562dsm2184598a91.17.2025.03.12.11.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:39:45 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250312
Date: Wed, 12 Mar 2025 15:39:41 -0300
Message-Id: <20250312183941.1394738-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit a383b9bd4d7e430fe7c254297540bae596649dba:

  Prepare v2025.04-rc4 (2025-03-10 17:31:52 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250312

for you to fetch changes up to e1a9ff95304957a774642ff1bef2b1851a4ae96a:

  imx93_evk: Fix wrong VDDQ voltage setting for LPDDR4x (2025-03-12 15:34:59 -0300)

u-boot-imx-master-20250312
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25106

- Fix VDDQ voltage setting for LPDDR4x on imx93_evk.
----------------------------------------------------------------
Ye Li (1):
      imx93_evk: Fix wrong VDDQ voltage setting for LPDDR4x

 board/freescale/imx93_evk/spl.c | 5 -----
 1 file changed, 5 deletions(-)
