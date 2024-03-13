Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EECDC54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 00:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906DC879A0;
	Wed, 13 Mar 2024 01:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cD3mxEmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB3887E57; Wed, 13 Mar 2024 01:36:50 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74D1487811
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 01:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-221d4c52759so756834fac.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 17:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710290207; x=1710895007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5T3AsRJnwdqSn68o7s6puHUAcP6VDpf1zxqYAUAUPx4=;
 b=cD3mxEmJP1TI5mr2nMTgtnkCxgW9cBIZ7cq5p+opEt1ZU29M79OKA/qyRqzwKur6SQ
 l4g7aX8SJukGPyGVGf3W56TooPlQBN+qUDc6oc8e//WgDlkIeZGVV1deU1H9DhM4DJgs
 Pkv9TfA8NSDZrrn3iXybo9lBI+1GUiFhW9YBLq1GgsD2SvWqDG1dyyptPPotlCXIc4HK
 M6VbNJcEtqcbpXidHoQoLdWYHl4/Bu2/wuOQLawsxXVboe3AFqdad1IM8t1Vd/6L/eRv
 4WYyq+/6lC3oJqdPByrsf8mhOxRTNG3fZIRJu1ccm/YGnG5zXomynzLdjsEih4CUaCGv
 S5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710290207; x=1710895007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5T3AsRJnwdqSn68o7s6puHUAcP6VDpf1zxqYAUAUPx4=;
 b=iRKYuJ98OdKx5imy4YVpwTORfxHQwCoB9bKKOVMN2PyZI7M8ZvJKG5Xyy6h4M/pucj
 ADvFQGW+b2woWgLi0rSU10D7lvMRleorwHRb/vO0cheOTuaWceiBrdmlU+qmPy13acNe
 MHldr9m96zgaAbtSaXHJ8NCV8d+jdnWD8RBmonTeZEdxzQTxZPHctuMTOk9U/MIW5aAZ
 xKmEqnkSMZ570TaNrX/HHiG8TKm+wT+cIQhqPLrLLV5OfZ6EXWZSqZ+1aS1M2Jmp0YNX
 scRB59U31OD9WQvwxuJbIEgfRIoi4SafhRF9J7/m80RypXnmFx/JgEKv/mpIx0lObuvH
 /3VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZxnnXXLNTyH9p3l7/+LjQmML0pZHTimkfHgeyb52E6pSLA+4aYlBUws7G4Gx+Ke+8hh84eMUIDfKS4K3dOj0pVTon8A==
X-Gm-Message-State: AOJu0Yztn6xHUUuBAQVhqmkdk3PN2faCA9y6Z6cl2lv6UzyHuhkF46IL
 rk693L0hNb1rztDDQzeTaNXQpl032cQUDuyRwq/pUWCQi+HGcr6y
X-Google-Smtp-Source: AGHT+IEDHMwseKbu62ylVxXY+MLNgzrqRZ1frWwKYElQm33Q5iBXIyEtNzRqFj0O1QIMFBZK8ONXLw==
X-Received: by 2002:a05:6870:a990:b0:222:239e:bd04 with SMTP id
 ep16-20020a056870a99000b00222239ebd04mr3017672oab.1.1710290207054; 
 Tue, 12 Mar 2024 17:36:47 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:6994:9b01:a251:4ea2])
 by smtp.gmail.com with ESMTPSA id
 fa26-20020a056a002d1a00b006e500abadf1sm6717184pfb.111.2024.03.12.17.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 17:36:46 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: festevam@gmail.com
Cc: marcel.ziswiler@toradex.com, hiago.franco@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 joao.goncalves@toradex.com
Subject: [PATCH] colibri-imx8x: Fix sc_misc_otp_fuse_read() error check
Date: Tue, 12 Mar 2024 21:36:41 -0300
Message-Id: <20240313003641.2650648-1-festevam@gmail.com>
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

Commit aa6e698a7acd ("imx: toradex/colibri-imx8x: correct SCU API usage")
made an incorrect logic change in the error code check of
sc_misc_otp_fuse_read():

-       if (sc_err == SC_ERR_NONE) {
+       if (sc_err) {
                /* DX has two A35 cores disabled */
                return (val & 0xf) != 0x0;
        }

The other changes in this commit are correct.

sc_misc_otp_fuse_read() returns 0 on a successful fuse read.

This inversion causes board_mem_get_layout() to report incorrect RAM size.

Go back the original error check logic to fix the problem.

Fixes: aa6e698a7acd ("imx: toradex/colibri-imx8x: correct SCU API usage")
Reported-by: Hiago De Franco <hiago.franco@toradex.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 board/toradex/colibri-imx8x/colibri-imx8x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
index 2c673a4a6b06..6fc8076163c6 100644
--- a/board/toradex/colibri-imx8x/colibri-imx8x.c
+++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
@@ -46,7 +46,7 @@ static int is_imx8dx(void)
 	u32 val = 0;
 	int sc_err = sc_misc_otp_fuse_read(-1, 6, &val);
 
-	if (sc_err) {
+	if (!sc_err) {
 		/* DX has two A35 cores disabled */
 		return (val & 0xf) != 0x0;
 	}
-- 
2.34.1

