Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C258D262B2
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 06:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699248397D;
	Wed, 21 Jan 2026 07:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="djcvug4q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRYh7glC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E4D82A9E; Wed, 21 Jan 2026 07:39:41 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DB7E83A6A
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L66kef798267
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eJus4oD0s5J
 NlJbYLQqE2KlQSg/3ORc2d21ML6cM/ZU=; b=djcvug4qjpIjyCiaWUyYwQB92mo
 mmALqNre1svDg3KgEeQfAub62xmKL5CnZU28nR5bcq2x8aPTbNA3JZB1aFj7kK6i
 ALizwpNimZUdAIVY6rPL9Vf4CTA/pTWG7jdhR3Qmy+otkKtT6WCxNAnmwbG5vUCl
 DgzI0Q2CG5v93U4cw9t7B7L/k5LDVLcaBxZHWv+fcXxu9aVCUnD63n8sjaMMsp7o
 j+ICxahBANaX1dw/vw/1sDjf+PPZlctErq6fQUlsP7KLOAfmQM2lryklHAQy/GqK
 u+gkXu/o8ZaKKilqxpf4tnhejdOo/rqdppnL41Jt6OU3BPBydeHEIZ43kwQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bta6q3b13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c551e6fe4b4so3865506a12.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 22:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768977577; x=1769582377; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJus4oD0s5JNlJbYLQqE2KlQSg/3ORc2d21ML6cM/ZU=;
 b=WRYh7glCxAk6DKw2WZPSTbKOnvgXfgndgNLw2IhvJ3EumMErIbC4aZRsHIAotTh4tq
 RVqHI5m3lVZX+RhgE4LxfoCEbQs7szXuEQqvczA25YcNcV18oMiLj1MxqABQfjhQ7HfL
 py5+3HMD0ayLAhNcI7/PJ19dOhveoCESklydNQd/4vYwvB62Uj6IYNq+2VA7J5BlQAOt
 bj92ESNlw8Qi6PQcGTKy5t85/ViT/L7qH4sZWQFyR77XWhvMP73JxbFsG+YfEIKYNXox
 GBiZl3HoN0vtgm8jPEKaqv15penRonRpogoiRfojPm8yaze8RlG5dd+5/SxcP6GHyfXR
 455A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977577; x=1769582377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eJus4oD0s5JNlJbYLQqE2KlQSg/3ORc2d21ML6cM/ZU=;
 b=eRNVhPvTi7roMFUupOWRc4F1EJyftjUU3PSWAPLbaz+lbZoyafhUoucuc8xtJ1yGes
 N2Cpk5Jui3Z/yHOv0e+ZIfxedW0GggpsD7UbKebB6KbytsKp3VyFzvII4Fk75/SCjZnP
 EFSTHRsR8bQh3noBKi6K+XdM19RuOFFMlPmlhI2cGvwjFE3dfze/pHTEYKc3IvQHP9eQ
 mF00JMw75TgLc8lz+SYOuvIUwdwgfMshgG3BZcsj5ihmJ+dMJ1lJfbkBa424w8OCrk3E
 mlBGUubSkHv7H8e3KCH8Sfv/QseXp4zM6OwcHlr/UktSS4RIaliE4FkKWDH1Hl2ZL8yS
 V0yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk+vm9A9sR0ph3WpnhTDCmdN1C6wp31nBPO0c3OW8XZPuzZADmWnThF4J58WaftcEyCbpYGX8=@lists.denx.de
X-Gm-Message-State: AOJu0YyfViSjJHCup8kaeClTDYlofeY4qtu6Xktfm0xjm8yBfO19dBEW
 6JipsP5tDoT6UZtoB6r3kxYcM5Oy5qZlOrSslIemZn6/N3lPzmoaATfeYntHRI7mh/XzKZfUQv1
 auFWFM30HuzJ6DIRHQaDUxRbrkhl82lfLQ+LF9sZ39MGLnirier0/KM3M
X-Gm-Gg: AZuq6aJKpKBI3dwFFgnN/fXaWgZXrHUlI+Z8RO6FJdufLb4g2l+73hS3XLUIwFA5jhC
 6MYXbvFFVwP6J6QAhcTuMxENSbmJU/Ic8epVLd1Nue+Vm9yl2SBcTBOw97/Nz4JMQOke2ubmy7v
 4m53mVRdq3fQ297NsNMZD+vLPEzPr65kkFYETEoL8ry144jf6V9DTHHttBl2W+qrhZrZ3kgoSsI
 m9trrxkeROOUL0rTjTYBsztPyhLWxnpbxbJgnwjVSIUlmhTq7cStm0hv83Q1hj0n7svW98/bQru
 p8+b7ttsAFMP15FuQwr+ke1aTLX0Hu+dblAv4lgx4fxqQGhIckG0EYEpwY/6fchSCCiYbgdtJd2
 gcG5sNBolOKM62NliCa0Oy+b3qwpcFX6GLXHBMVSdSFvnj7yF85Y9NsF0+E2lw3F65SShrW7IBi
 ab8CNsM0y3yIrpIKsBHm5m79VugN2WE4lOSxAIC54=
X-Received: by 2002:a05:6a21:e97:b0:34f:b660:770d with SMTP id
 adf61e73a8af0-38dfe770a12mr15216387637.55.1768977576849; 
 Tue, 20 Jan 2026 22:39:36 -0800 (PST)
X-Received: by 2002:a05:6a21:e97:b0:34f:b660:770d with SMTP id
 adf61e73a8af0-38dfe770a12mr15216360637.55.1768977576247; 
 Tue, 20 Jan 2026 22:39:36 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193fc8d9sm141392315ad.79.2026.01.20.22.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 22:39:35 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Date: Wed, 21 Jan 2026 12:09:17 +0530
Message-Id: <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QohTHFyd c=1 sm=1 tr=0 ts=697074a9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=k2bqWL-eJF5qEUxKWYMA:9
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA1MyBTYWx0ZWRfX29fLNTndzxUw
 /04v5M/Tb77oQkAgimWrECSBi/k8h9dyllCR/lc7DgJgmTCUTvsodgM6qvbl3swp+wZDcGxVUJs
 wDb1SWm50tH5UCt1UW9g5dFjhq8gSY6NRZOxjYjC1EisPAKE7tAt8p6p5GmZrKy7CCfNJigtooy
 b5XW7H6QVWc6X6qCZ9JA8lovR6WRtSp9Trupu74OA+t7VeP2qH1nGejNcIl0NQYc4PdCbIhm2yY
 pKfSlKFp0CLVwkCjj2Z/RbTtuiEXO44+Owfo5IteBSenxebwbEjfqMEP1Mi2QHbbYIHm4Xrq7dZ
 tK57ugmFS8PTuc5LepHxQWg5F8cLS4Fl04UdsXDfGCX7zcssQyE3OK2iX8mTu3w+lyC5d04Yrfw
 pRhWlsC3ZwstM8IxCPnh7tILQHr9STR8SJNA+yfF9J2G28XZd5+a1iE1JJhb7i9igfBpqS2li8e
 f84MAI7Vc+PdjleK/TA==
X-Proofpoint-GUID: Ic6-IthlO0JPYFxs60oiUZfbhkFA_RB7
X-Proofpoint-ORIG-GUID: Ic6-IthlO0JPYFxs60oiUZfbhkFA_RB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210053
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
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v6: Wrap this functionality inside CONFIG_SYSRESET_CMD_RESET_ARGS
---
 drivers/sysreset/Kconfig           |  8 +++++++
 drivers/sysreset/sysreset-uclass.c | 37 ++++++++++++++++++++++++++++++
 include/sysreset.h                 | 18 +++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 0181f6cd581..6fb0ca81dc6 100644
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

