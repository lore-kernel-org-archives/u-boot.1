Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0859CC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 393868786F;
	Tue, 26 Dec 2023 16:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cw++8Z3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330E086F56; Tue, 26 Dec 2023 16:48:49 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3633B878FC
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50e81761e43so618225e87.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605726; x=1704210526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npN69VVzc7obA2Z0hr4liDGB2Jr09YIPDZiBD6W8bC8=;
 b=Cw++8Z3iQSoWJb8eTd2D62Z7KTMxweq3bk6fRvV6JWiG+1r7CllXmcSJE2qCrtmtS5
 mZvsjsZ3ZmPr3WiRX6jAeMk/6QC1mVbeSFn2HhFirSvwd71s0mBQCF3nOHoJD6JM3SI2
 r49W+xC/3pRa0ySEvyxxuyN8RihD74kDir4QESU/xQR71YUjRDBSES9p5vcpnD8/1HQo
 boMVk14ytZRNninPS4q4Ky4Q2gtDioUBkzhPAo6gC5tWau15s3eg8wC+aZPVM581M9ZS
 Yoj2KjbW2kYk6b9xZ9qG3qDSmj1F5p8g7j8AXE4/fHnW2gzmHzP/+Xn8uAbOPPxkqdeA
 cU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605726; x=1704210526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npN69VVzc7obA2Z0hr4liDGB2Jr09YIPDZiBD6W8bC8=;
 b=phHy6uzyZf9BK65uOiuZXw+fwD6DROSBnICxbpdUueKxiqZ58T1Z7v4k+Y1h9+HtWN
 ZrlMprZu6CAVc6v3/e7s9hhwa0+nFcW7KcTGLSilrgJp26z1NroKnfhGLAD3FpSqVu5J
 JfJsNBDk+sqcZBhnVgA4miMGg1dRgBIbetClyoyw7huVorNtT/oNLXI+kjzK2NHbkeh4
 nxAaBPeeeVMFsaOnzAJRoBl5rTp30IQTLwpCL+v9UZ89cKzOjnzEs7rBhT7u0ooYg4uc
 BZsWCvK1PhV+DmIuhy7iS1HYJoTlndvJbhdjE3fhV/uOQprgQL9WqvgQ09IUTjFguaMU
 opSQ==
X-Gm-Message-State: AOJu0YzPbenATHPNnULQSlvDsPuLThKLGbfyaksdVM98eV0UrzrhnBbD
 cM6lmijY64gTXrna9dfAK/0h1hZVXv/vzYy/0R2va6WYJZE=
X-Google-Smtp-Source: AGHT+IGojvBBKvY6FUrzGZnBy1Iu5FMtmCetV3dE8+CocuF23raM3MWjM+O/hR9OKi0lDOWExO+Mcw==
X-Received: by 2002:a05:6512:b84:b0:50e:7d4f:b402 with SMTP id
 b4-20020a0565120b8400b0050e7d4fb402mr1059388lfv.117.1703605726303; 
 Tue, 26 Dec 2023 07:48:46 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a0565123d1900b0050e743b0b2csm1089336lfv.34.2023.12.26.07.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:48:46 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv3 4/8] driver/net/rtl8139: remove debug print
Date: Tue, 26 Dec 2023 21:46:15 +0600
Message-Id: <20231226154619.5071-5-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231226154619.5071-1-maxim.uvarov@linaro.org>
References: <20231226154619.5071-1-maxim.uvarov@linaro.org>
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

debug print delays reset of the driver. Finally I see
bunch of "rx error FFFF" errors in the screen. CI can
not handle many prints. While network works fine there

Reproduced with:
make CROSS_COMPILE=sh2-linux- r2dplus_defconfig all
qemu-system-sh4 -M r2d -nographic -serial null \
-serial mon:stdio -net user,tftp=`pwd` \
-net nic,model=rtl8139 -kernel ./u-boot.bin

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/net/rtl8139.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/rtl8139.c b/drivers/net/rtl8139.c
index 106bc1c7ae..d8f24ec81a 100644
--- a/drivers/net/rtl8139.c
+++ b/drivers/net/rtl8139.c
@@ -453,7 +453,7 @@ static int rtl8139_recv_common(struct rtl8139_priv *priv, unsigned char *rxdata,
 			  RTL_STS_RXBADALIGN)) ||
 	    (rx_size < ETH_ZLEN) ||
 	    (rx_size > ETH_FRAME_LEN + 4)) {
-		printf("rx error %hX\n", rx_status);
+		debug("rx error %hX\n", rx_status);
 		/* this clears all interrupts still pending */
 		rtl8139_reset(priv);
 		return 0;
-- 
2.30.2

