Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0871BC28B30
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 01:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA4DA8198A;
	Fri, 21 Mar 2025 02:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JKXFJ+nH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2953C807D7; Fri, 21 Mar 2025 02:31:30 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02C8809A4
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 02:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7c592764e54so172574585a.3
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 18:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742520686; x=1743125486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SVJ8MJ9y0yt7hCJrWDXKJDh/cHO7f8GHwirlMlErLc=;
 b=JKXFJ+nHflGb71d6RQx2wKlJhFPbzvYQ7Hg4DjkVqoZ5QKLDitJt8zZpU4pRwqN4hB
 osmeLhPishnNLJpQsC4SgLRm2O8x7lDuc9uiuL/uWhQlDRd+yY2QFCM9vLXus3lakhcR
 foQxxSBrpPSE3oFfLO7EXu91iWPZB9sonTRH8Iv6xuinAsdVGXBDrzvEIpNkP//0fM+T
 8JSV8eFJypdU1qgk0E21U+wEWCnnzcP4RsIN/Qs5BZdr/NmI7WbgDWsaB9A3/GDzf05W
 rZxT6PBVQxkhN58HSzTM0ewsOfJ34WkQKYljOLdlCs0eC1qBt2NyVdswaNAK5Jlmut8Y
 mEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742520686; x=1743125486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8SVJ8MJ9y0yt7hCJrWDXKJDh/cHO7f8GHwirlMlErLc=;
 b=LAIsVPkxE7nC40zUEuYsgzW98FUnaxs34OExrBseviaBFx5dHlfX0glZG6IwdReBRt
 PwBrHNNzkXyuha3m/x7tSlkjAWeOnqG5l6CNNKHG7KM/8JTj/CMtTVI7iO4gVBEKHJS9
 PUu1rqfwnR8mz0MZTGrxOB+7PUSMuY0JyqDXN3eMWqp6yFncCNf7OHqT0criXGbsRjah
 crAeJl7TLZt4bgDs7XL5t3KAKJDs0qF2rsmOkfgKlyZXy+2uIX6/9bMYqKQRb6s9U68W
 CGuQYcJcUAre26gsP37+9F3qTYmsKWynIIVSVFvQbzVH2l+lH3/L4xreuZ+/nekrq8fq
 9NrQ==
X-Gm-Message-State: AOJu0YweF3hCJOBIzcrYTqRJwlnyjLPu/6vHHUlRCgRrFyMduU+5EiIF
 hffAfXEe7OCeuzZGboekQ0MQtNYu54i389+YmFwS2JZqc2izkTy2zVATZQ==
X-Gm-Gg: ASbGnct7qNNMdKNtQefH34DTxFwcD8dJX6TFcg3HK3Z70DVkZYu5CxzcigscslO0CTw
 qxKI20DfMMqozMDhrCwiit11+ZvWOy5sJjHih3N9E1QazGH3Yeu4i6EUyYWVCOCieQeYMv7zBl5
 nxBhlosYVgGc14BJlTL9RDCVboVIXkCSfRWWJdwqME6eBUNfDuu7x3ytDnSlTyE0ahP0bqx5JMI
 FUVEO9itZskX6/D/HqzcDcXgk/mVnOTVtg4Kip4NBl7JGH6oxiFZ/B37DUxoTdF3YfwK/G5/iQ8
 I6QlmdJHlB7/TtSZ2w1o0JLy2Pt+lIENTHNZwtXCZ6IpQrXgfERVSMGNFczNEKRqQ055JYEN27g
 w0KlpnqFvI1TLlgJcPCc=
X-Google-Smtp-Source: AGHT+IFzZV1GgjH3drTO4NB3zOrN6522EIqHYtapbjQQrms6Ko8yp1r7SuBlqDHQlIN+zUW/BTTIKQ==
X-Received: by 2002:a05:620a:2621:b0:7c5:6678:ab27 with SMTP id
 af79cd13be357-7c5ba156d85mr228398285a.18.1742520686084; 
 Thu, 20 Mar 2025 18:31:26 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92d0137sm60501185a.31.2025.03.20.18.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 18:31:25 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 2/5] cpu: imx8_cpu: Print Speed grade if IMX_THERMAL or
 IMX_TMU
Date: Thu, 20 Mar 2025 20:31:02 -0500
Message-ID: <20250321013109.709431-2-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321013109.709431-1-aford173@gmail.com>
References: <20250321013109.709431-1-aford173@gmail.com>
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

Much of the data that is display by imx8_cpu.c is also displayed from
arch/arm/mach-imx/cpu.c, except the temperature grade and active
temperature are only displayed when SoC is an i.MX9. Since IMX9 now
implies IMX_TMU, change this to check for IMX_THERMAL or IMX_TMU
in the same way it's done in mach-imx/cpu.c to enable displaying
this information for any SoC with either of these configs enabled.

Before:
CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
Model: Beacon EmbeddedWorks i.MX8MPlus Development kit

After:
CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
CPU:   Industrial temperature grade  (-40C to 105C) at 28C
Model: Beacon EmbeddedWorks i.MX8MPlus Development kit

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/cpu/imx8_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

V2:  No change

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 53d31b3c0bf..faa6a0704a6 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -177,7 +177,7 @@ static int cpu_imx_get_desc(const struct udevice *dev, char *buf, int size)
 	ret = snprintf(buf, size, "NXP i.MX%s Rev%s %s at %u MHz",
 		       plat->type, plat->rev, plat->name, plat->freq_mhz);
 
-	if (IS_ENABLED(CONFIG_IMX9)) {
+	if (IS_ENABLED(CONFIG_IMX_THERMAL) || IS_ENABLED(CONFIG_IMX_TMU)) {
 		switch (get_cpu_temp_grade(&minc, &maxc)) {
 		case TEMP_AUTOMOTIVE:
 			grade = "Automotive temperature grade ";
-- 
2.45.2

