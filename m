Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507E5F88090
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 07:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3360841D5;
	Thu, 16 Apr 2026 09:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="odKrACGg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TZdu8XeF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E40F841D5; Thu, 16 Apr 2026 09:03:59 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A4A84214
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G0MFvp3733590
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NGHZ+i8DbOI
 kCHzNej2dba/IbQnRoOUzhKXfoGV4A6Y=; b=odKrACGg0S4KdsOLTaQaIHhn9Fg
 29nwmzvonWYP/cT3jmPYVVnog9ktQZ7DcTm0RbintSgnMBvQKxB3hD5+z0qNSaEl
 m1S2Ws5kkMIwgKTvJCVr7S5bfNCeFmu7Dk8kB4kSjtExT3FCRiXtLnan5Ju7fj68
 YltYRgwo0kgertnaycyu9/CuNqJyeACdpozImlsOBPVcdiX7DSCo+9oM+OKK/4C9
 Wnhhx6ka9Q6sERDOt08FcGv1487jPGUxO+pR/cHo2V8AzeihHM28Fsr048cf4tUB
 LpA581Q9WcxIfhrkv0Y0orfUOUIxkeA4qfm6nokhxyl6jkmbEF7azTYHByA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcqwjuf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:03:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b4654f9bb6so43953965ad.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776323035; x=1776927835; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NGHZ+i8DbOIkCHzNej2dba/IbQnRoOUzhKXfoGV4A6Y=;
 b=TZdu8XeFhnpL5aMPOrXBu/do9WForYkK2k9SId1O+p3a5OM7OMLdHjsWUQrRENjFGT
 REzwE4hFXygUPRdr8RhrOVhP2zWOqFAgZrn4ifNLNDaCa/FuP71IYn3SZZKUU3exCAbz
 wrnC1X9Eivt+Ci1mWYKal3J0SCxvChGuHXAaie+shzucH/wTT3hvFb+/dMeog4DyuLCF
 IYcrqFZXSQF6mA/SWnH34mecoCVZktDvgPwTC7e/iAHQ/mwY7+LXIvkSppR53muS55Fc
 9jv/pyW9Z0gSOQXPW5PUhPKZ3ildGZQ8Jjw2Aq/I8m+7J67evjJAS1tMvbX9zneb1rBG
 +XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323035; x=1776927835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NGHZ+i8DbOIkCHzNej2dba/IbQnRoOUzhKXfoGV4A6Y=;
 b=k3T7yLkOTHefxpgPGGtB4pNPfhhHDWMg2JWICiYMgGyNwHdZ32rBVU+S/9+F7k7X++
 biakbb5gKBxX62wxBRAxJJwFw7kF6XJvUdJ7vaWnA4NR9W2WeQCcY7OoPO+iX9RPHVGs
 0ApJS6C+QrrGD/DFLZH4BoFCd8n1q0F5WSxU2Rr7nGFPnbisuqZig/5U4ggzqRQzQycS
 hYtngZcySfTeiDsejU/5P8vQMzBLw4SHf8Pzc31ERIjCDLuTkEOzWc8yJLdlIpJReqPy
 vGYZOdCUlRQ0pFT+h3a6ezf960j/AVPYMe/p9fkzAp+arxy+LWKWMXa/RbyVwgf9lJCU
 9d8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zXsdvx0T0WtwQFEl2tA4Fo/lqgwG88X6WuaTyIhok7SbAiUq/7Mr+oBC8qHhvGG234yGAhNg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0qa7YZDV5q1zK3SpcHBlVZfI3jgR8xe5H7qQiCPaVw+N5YW3z
 lc0k0kNxT1tqZkX5WRZqcJj1bsCvsHNETfDpjr56X38E4Dt2fZytdcY96Yde/qv9J+euXVji8+6
 ebFBUawiKqGjngbiO5fhApigtWs9QWQDd5StwAQH9i19jRJkgn4PY3jg0
X-Gm-Gg: AeBDies+yPK7/S0WR99qld+KuEuKg/BoAPEKBamWxQPXFkZDjuhPU1T+xw+jIx4uYh9
 W5IWnUBxCmPEIPkvCTFBoQXM431FuO8h2P2C5Z0Wd74sxHhkNUHfLVYpS87c74BqJL+6oEYso61
 l+XXsqEqs2nHU2W2OvGE3orQ9DipR6thQlDHNrzKznhzorymVBw/iiOIk5gFTiq3osvX34YNtBo
 7dJ517CpvNiitGfBstDTOUXa7tR8zx/ZkLwNHb1P9BC3QlnEHPWWFZf6yRkfOAvSWllV1RBC3oJ
 StWl0OJdkm2y4K/8zFt9RjN1plZ5s6vVQ0ko3c1+U9XeDEq3xmkTdH7GPkMACmpd5eMp2+E+u8X
 +j8NbNGcEBAbbyiem6StB4JB9R0OmOBqYOcWYmjOmnF07nUy2nLsUvEl2oihDECXrxLsk8GYNny
 AJ7kUi6+ld/e6xUE8KFzmCQxClNjBZ3dm4+tCFcXlVPfs9VwH44Ck=
X-Received: by 2002:a17:902:7003:b0:2b2:5258:a23d with SMTP id
 d9443c01a7336-2b2d59808d0mr177952625ad.14.1776323034502; 
 Thu, 16 Apr 2026 00:03:54 -0700 (PDT)
X-Received: by 2002:a17:902:7003:b0:2b2:5258:a23d with SMTP id
 d9443c01a7336-2b2d59808d0mr177952195ad.14.1776323033893; 
 Thu, 16 Apr 2026 00:03:53 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b1174sm54195255ad.70.2026.04.16.00.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:03:53 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, aswin.murugan@oss.qualcomm.com,
 simon.glass@canonical.com, tien.fong.chee@altera.com,
 michal.simek@amd.com, visitorckw@gmail.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v7 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Date: Thu, 16 Apr 2026 12:33:27 +0530
Message-Id: <20260416070330.3006528-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0Dc3XW2RI9hvo9Tz91RwFpyVy9WTXiTM
X-Proofpoint-GUID: 0Dc3XW2RI9hvo9Tz91RwFpyVy9WTXiTM
X-Authority-Analysis: v=2.4 cv=XOIAjwhE c=1 sm=1 tr=0 ts=69e089db cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=k-42gJp3AAAA:8 a=k2bqWL-eJF5qEUxKWYMA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA2NCBTYWx0ZWRfX2KHgezZgT18H
 GtTP+u9eoH6HJSJ0o4mhyxmRs2VRHxhQygvdENj2GvCo18Y3UHr6Uoxb4038p8vx8DBltzESabx
 EMBGupV0DeyM+9CIn2LegB1UVdnsJvj6XxSB2TybNo7KRx04xdPUSD198f+H97UWnVCVsycC3Ih
 7lpjLZmuOOEoxq+StNq1s/M39JjiiTc2kwywh7mqEevY8kbTpXj70YOL6O76UHQIHcRsFuCVxMF
 zAFwGrsqAMvLx0a3cypny49C3y9KrBbO15C4t7PbqgdXLLpUb3MOLP5rvqZqJb+R7zmPhDcqEjq
 PMbla97NAVJJVuseI7yUWxxuys4ZpTYrVitVHLOGXtzfp4UuaDzl1gejZVHF5XjCA4CozGJ5LPd
 O97BxYGE27k22W0bzE7lfOCxJuLLEn3DBH92xwscj6xR6k7qhCDtVMGG+mnkw/5iwIgqEh8yes3
 XHhW2NTBSfRJztVMWPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160064
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

Add a 'request_arg' op to struct sysreset_ops to enable sysreset drivers
to receive arguments given to the 'reset' command. Process the
request_arg() op before the usual request() op.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/sysreset/Kconfig           |  8 +++++++
 drivers/sysreset/sysreset-uclass.c | 37 ++++++++++++++++++++++++++++++
 include/sysreset.h                 | 18 +++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 16ef434a8d9..f589ad15418 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -49,6 +49,14 @@ config SYSRESET_CMD_RESET
 	help
 	  Enable sysreset implementation of the reset command.
 
+config SYSRESET_CMD_RESET_ARGS
+	bool "Enable reset command to take arguments"
+	help
+	  Pass on the arguments received by the 'reset' command to the
+	  sysreset driver(s). The sysreset driver(s) may make use of the
+	  additional arguments for implementing arch/board specific
+	  functionality.
+
 if CMD_POWEROFF
 
 config SYSRESET_CMD_POWEROFF
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 536ac727142..f25e09e9cd0 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -32,6 +32,18 @@ int sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return ops->request(dev, type);
 }
 
+#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
+int sysreset_request_arg(struct udevice *dev, int argc, char * const argv[])
+{
+	struct sysreset_ops *ops = sysreset_get_ops(dev);
+
+	if (!ops->request_arg)
+		return -ENOSYS;
+
+	return ops->request_arg(dev, argc, argv);
+}
+#endif /* CONFIG_SYSRESET_CMD_RESET_ARGS */
+
 int sysreset_get_status(struct udevice *dev, char *buf, int size)
 {
 	struct sysreset_ops *ops = sysreset_get_ops(dev);
@@ -71,6 +83,26 @@ int sysreset_walk(enum sysreset_t type)
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
+int sysreset_walk_arg(int argc, char * const argv[])
+{
+	struct udevice *dev;
+	int ret = -ENOSYS;
+
+	while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
+		for (uclass_first_device(UCLASS_SYSRESET, &dev);
+		     dev;
+		     uclass_next_device(&dev)) {
+			ret = sysreset_request_arg(dev, argc, argv);
+			if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
+				break;
+		}
+	}
+
+	return ret;
+}
+#endif /* CONFIG_SYSRESET_CMD_RESET_ARGS */
+
 int sysreset_get_last_walk(void)
 {
 	struct udevice *dev;
@@ -132,6 +164,11 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	printf("resetting ...\n");
 	mdelay(100);
 
+#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
+	if (argc > 1 && sysreset_walk_arg(argc, argv) == -EINPROGRESS)
+		return 0;
+#endif
+
 	sysreset_walk_halt(reset_type);
 
 	return 0;
diff --git a/include/sysreset.h b/include/sysreset.h
index ff20abdeed3..d1cc9ebc542 100644
--- a/include/sysreset.h
+++ b/include/sysreset.h
@@ -43,6 +43,24 @@ struct sysreset_ops {
 	 * (in which case this method will not actually return)
 	 */
 	int (*request)(struct udevice *dev, enum sysreset_t type);
+
+	/**
+	 * @request_arg: Reset handler implementations that might need to process
+	 *		 arguments given to the 'reset' command.
+	 *
+	 * Note that this function may return before the reset takes effect.
+	 *
+	 * @dev:	Device to be used for system reset
+	 * @argc:	No. of items in @argv
+	 * @argv:	Arguments given to 'reset' command
+	 * Return:
+	 * -EINPROGRESS		if the reset has started and will complete soon
+	 * -EPROTONOSUPPORT	if not supported by this device
+	 * 0			if the reset has already happened
+	 * (in which case this method will not actually return)
+	 */
+	int (*request_arg)(struct udevice *dev, int argc, char * const argv[]);
+
 	/**
 	 * @get_status:	get printable reset status information
 	 *
-- 
2.34.1

