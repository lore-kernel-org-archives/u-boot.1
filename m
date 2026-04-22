Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2AFF9EDE8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4491084310;
	Wed, 22 Apr 2026 16:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pB3Sr/mq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7468F842E6; Wed, 22 Apr 2026 16:31:46 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F3C842E6
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-694891f8f75so1813433eaf.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868296; x=1777473096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnmuuVOHGNPYbSHzBcQPIVg+Nn/lZvvY9kfHbpJ/f+s=;
 b=pB3Sr/mqcoDK5lUjs/FalP2RcePB07xyeyiBI6lZkqVJFJY4xy+2RnvTwLIokDzAD7
 Cx153RE/gy9bosLoewJFU4a4fHv5z8qOq0+ejLpVjJmsqx86fzYwEVIIigFOLKLCpiRU
 Y+Db/4aoft5MHRIpJnUDDTpBuAptZ4FNBukOIZRrn2+jT2+K5lh5RJrxXyok1pG+qKNY
 eOiJg1DTZ7LlHk+eMRI3dY89mXZ3qSvVn8yJDMpMEU6hfVl0mF9It1Az9FCeeHibyptW
 K6RvxXydiCmKnWAAr/Pg7wJd3uPLmQ4NE8DWZGJfD7MRf8Op6ztxBAEL4GIc6OqUEPo0
 DWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868296; x=1777473096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MnmuuVOHGNPYbSHzBcQPIVg+Nn/lZvvY9kfHbpJ/f+s=;
 b=ssE3xe+1QrylPCs9n3Qux+iLWYs3Jk8pf9EHr6GRIDRiNiVBath7qci7bSODrusmc+
 VBhnpYZ1R+2nRdEf7HUUOH3dzQ/Mb4HFpAp381bPo19Gd7nSEpYuW5peImbHNZgaBE60
 z3HU+MWNbkFJcfmPUyH3CVeFJPeTYLjKijH0AIMFN3ve3Jvnb4S5fFGZrLgDDbRBXPh5
 COq6voFNbqyvNWmSmlCLab2U7PB3zAY12yFK93IIo1dRYJrfjjz6UEXgl3roKn9xtqfq
 3Io1vazk339t4ci47ckd+njiBWI3o7RzjdsVCC5A1+VbvJkpGe1E4ZfKz92qnPsTtzfg
 jDzQ==
X-Gm-Message-State: AOJu0Yzy3a6y2AG5Les2K2Kh81w6y/8xHyRnzX4Ch5gkEMYA1fpo034n
 BTMEfYlHl+XWWD4i00zNK51sYY4KAD4FE+ZyzGYo4/T4nOOZt/K5xX2RclBPH9xwhrs=
X-Gm-Gg: AeBDiev5EdoEzEnfalfVd3cxKujSVEz2pifSO/dcnJd3zk/1ZAtgkHe0B37NO5w2vgX
 tWpkLhoGB92s9NA/TsIjuLYs7fV9i7vrSyrFFThJzaaOFsCp4hUDxY/sFWdgjMRpLilpPpnONxv
 5MOQL+RZNLnBs8Na4noUtzoV9g2kX2Hh12Vs8KHBMWL1p0mgP3qYcuhk+enT24zc1zSmsJj8EXz
 m/Yidxz5jORkDBpUorbDoIbAQyi5yLqmr5Kj//Y0TMwqRJA6EXv3AKVDqqVG2ubEw8o8BANU1ok
 KETWDTOge95ag3NEYuPR5onwBIMVxdCFFcENrUqPaDoBbEEoOX5Qlh6M8iFrE29mltxlO8U1UMP
 z9/4gKG6rd9tBsugeq7G2v0HIXQL4s6Wt5WBBNP7uRGXA828DQ32pcQbHDm8zEAYG3v9+GuUXjX
 521aPAsrXev/8+2UStTefRtUJ+vUlXx0hzdNQcARBRba8SA9hnDIuuvz1npwmDp71ou0Cyvip/C
 eMR8i+qTCon6oS1KP/dls1b613FpKO6
X-Received: by 2002:a05:6820:210:b0:694:a225:6325 with SMTP id
 006d021491bc7-694a2257567mr2318222eaf.4.1776868294293; 
 Wed, 22 Apr 2026 07:31:34 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:33 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 03/16] dts: k1: fix gpio ranges
Date: Wed, 22 Apr 2026 10:30:59 -0400
Message-Id: <20260422143112.1329478-4-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

The numbers of cells in gpio-ranges should only be 3.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/dts/k1.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
index 682d2fb88e2..fc3a693a10e 100644
--- a/arch/riscv/dts/k1.dtsi
+++ b/arch/riscv/dts/k1.dtsi
@@ -383,10 +383,7 @@
 			interrupt-parent = <&plic>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			gpio-ranges = <&pinctrl 0 0 0 32>,
-				      <&pinctrl 1 0 32 32>,
-				      <&pinctrl 2 0 64 32>,
-				      <&pinctrl 3 0 96 32>;
+			gpio-ranges = <&pinctrl 0 0 128>;
 		};
 
 		pwm0: pwm@d401a000 {
-- 
2.25.1

