Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719CBC35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 18:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB3581A0C;
	Sat, 22 Mar 2025 19:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DRnO+Q0Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112498197D; Sat, 22 Mar 2025 19:38:34 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E095D810FE
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 19:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7c5ba363f1aso292818585a.0
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668710; x=1743273510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WflOdqcQy6URYRhBYVdrRqZS1C2r/ZRVUM3yD0dtWmo=;
 b=DRnO+Q0Q55fkh3ehwxV706afdPm9JchQCvydV3imjSr+SEF/TLVK3oTCGyO2hu/U6R
 cOotiLeTnnHOizIMW024uQ/8mKYhRzRAjazgWZmFvpR53gkam4B9Mi9n+F0n1VaviQul
 cVNDWgmsWZD1mnN8m8EHSh+QtrMAfZEpozWq1mJra08vS8h6lJHYLlm/kmXfjD3GPTnM
 qn8B7XYNx5mPaC4qirK02C8nj70WJmlDpabwuaeWH6tWVs5oBX+WzdankkOSulsQO8s6
 Hhq4fR2Wueaq9ClHRG5649q1Um4foRPB9x+Esy7xR+8QQE0ljeJGwfBJmhgCjxbA5XMF
 5d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668710; x=1743273510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WflOdqcQy6URYRhBYVdrRqZS1C2r/ZRVUM3yD0dtWmo=;
 b=o7JaPfK4TStnLMA5cxasYngs43OtYn9kReRFfk9iRhPiqocN/NFrpn0jrG+TkAg2ry
 gkwJ8tW+gkmPdW4wXRmo66OOI5iLe1eZdCis+jxmOyZYHrYD1DChfmowoKZ/Y5IDnO/8
 4hrEkSJ44SLEY9SoaVF4k9Qm+08pDo4+qiIB+ThowYA3kJ6Q19EqkujXDEZi13NrdRAy
 fe3Gp/SEjbXQHLLLU9AWOBKObcPa4qdh9dTpzsuZ5tsCSRnq3Heqq4g97AUNc86rCVbo
 Za6pTitxvLhJJvwSMqxuWiQJtu/+aeunh6xGdVWa7qvdjzaZGpV61YwJ8+7XCLmh9ImY
 zK9w==
X-Gm-Message-State: AOJu0YxQogYEbKmsO2lOfNCSZ8MF3jaOXQB8L94sEUMoRzJCk8+7+Gz5
 qrxNXN6Bzd+o74s49SP1uezQe6sYtsIuiR9VRNY+Jml04bPm6yW67BWOnA==
X-Gm-Gg: ASbGnctDSH4kHMpGgHmvPb4Et1JnrIhLjAqoQQ2UsPFSVE9cNj/b4pqqEAjUevHNL1y
 /E9WQNPLNCHSLJyORsSEAJDYiO+kn2IVEb+CbTSM8W/MSJaobgUA4mquh/UMDdJSU1KG5aofwtZ
 +pZQKE7BeJlMGVIDEgECLEe22vs8zK5d7K1bJNkl5dNRpxNor0+/0sn6HpLemv9Ki4+NNAK6zoF
 96p0f2SoTZ6vrJHbikIJjhjmfdCjvG5dEhZGA01Fh8Vb13gdOCXzpr9YyElN3P99IMySk2z2siM
 0cR3knS4NUJH/WkUxbqRbxGJ6rc5VdG6qDxZr4P5FGSyaDa7vXwDgEe3qQEkOGThFJ9USjFH9B7
 fTD3tVuDJMe5WNVasIZo=
X-Google-Smtp-Source: AGHT+IFgJexjRifvbvgRxBuArnsnsJhB6Dn8O/DIlps9XIC3x0AllQWM6wR0yBbHCPS2eKu+fI8emg==
X-Received: by 2002:a05:620a:4588:b0:7c5:4d22:2149 with SMTP id
 af79cd13be357-7c5ba18febamr1208014485a.30.1742668709752; 
 Sat, 22 Mar 2025 11:38:29 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec648sm278126185a.61.2025.03.22.11.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:38:28 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Teresa Remmet <t.remmet@phytec.de>, Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V3 0/6] Migrate IMX8, IMX8M and IMX9 to use imx8_cpu
Date: Sat, 22 Mar 2025 13:38:02 -0500
Message-ID: <20250322183812.784676-1-aford173@gmail.com>
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

The imx8_cpu driver uses the driver model to represent the processor
cores in the dm tree as well as display the processor type and speed
on boot.  Currently, the imx8_cpu driver only displays the temperature
grade of the processor if the processor is IMX9, so in order to display
that info, the check in imx8_cpu is changed to check for IMX_TMU
and IMX_TMU is implied for IMX8, IMX8M and IMX9 SoC familes.  If
users want to fall back to the older method to display the SoC type
or remove the temperature grade information, they can.  Doing this
at the SoC family level reduces the number of duplicated config options
for each board, and was done at the request of the IMX U-Boot custodian.

Any testing on an i.MX8Q or i.MX9 would be appreciated as I don't have
a board that runs either of these platforms.

V3:  Added the imply IMX_TMU for the 8M family and added the imply for
     CPU and CPU_IMX to IMX8, IMX8M and IMX9 families

V2:  Changed the check in imx8_cpu to drop the IMX9 check and instead
     imply IMX_TMU in the IMX9 family


Adam Ford (6):
  imx: imx9: Imply IMX_TMU
  imx: imx8m: Imply IMX_TMU
  cpu: imx8_cpu: Print Speed grade if IMX_THERMAL or IMX_TMU
  imx: imx8m: Imply CPU_IMX by default
  imx: imx8: Imply CPU_IMX by default
  imx: imx9: Imply CPU_IMX by default

 arch/arm/mach-imx/imx8/Kconfig  | 2 ++
 arch/arm/mach-imx/imx8m/Kconfig | 4 ++++
 arch/arm/mach-imx/imx9/Kconfig  | 3 +++
 drivers/cpu/imx8_cpu.c          | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.45.2

