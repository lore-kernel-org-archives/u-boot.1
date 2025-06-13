Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362F7C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 05:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D30282CA0;
	Fri, 13 Jun 2025 07:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="D7/WWFY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C69C82CA6; Fri, 13 Jun 2025 07:20:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1481782B97
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CGUBuk002408;
 Fri, 13 Jun 2025 05:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2x6ymJhdCd8g0Pd5iuo5CSDY5PAh/DG6pshm5fEHCgE=; b=D7/WWFY6dSjcPYCk
 /Z6R51FG7kOOzZd+88RpPz+1MWjsZV6IbY27zDNv7YbwZhG9J/hJ0Ko6Go3wUOW7
 lnl89uYrcDGf+K2eiFjQaa2PJGHdVLPtcSLiGY5vx149bgFqvrEitIRcjC+qn4Nj
 /65WXapP5k7Vc2Gormy84thsX+ApMZLS+xxfbF201sRP+x2c2lWlxQY698EX2Cs1
 E4SgX0E30IjCONeHjvAHku9twqoMrS/8n9mhO4XLUZQ0pKg4q3J0IE/KX8EPPK3G
 n0LYXQWS1z+Xfo1kR2eU8lHUk5CYT+7ek8r3Bl4qf9zWfv8zgaX7pEYNv9daR756
 eqYpPA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dgy2vpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55D5KSPx025740
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:28 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 22:20:24 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <jerome.forissier@linaro.org>,
 <sjg@chromium.org>, <patrick.rudolph@9elements.com>,
 <clamor95@gmail.com>, <me@samcday.com>, <robert.marko@sartura.hr>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v4 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Date: Fri, 13 Jun 2025 10:49:54 +0530
Message-ID: <20250613051957.3159564-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613051957.3159564-1-quic_varada@quicinc.com>
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: uBRj5HntDkEbDbuQgCls7Udahileq27M
X-Authority-Analysis: v=2.4 cv=HMbDFptv c=1 sm=1 tr=0 ts=684bb51d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=v2ldV8uNSCBI4ujoSEIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: uBRj5HntDkEbDbuQgCls7Udahileq27M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDAzOCBTYWx0ZWRfX2P4AnXtY8uNv
 8SfjUJ6XKBQHlBJk3R5BSwYwzYHJLqlOIpI3ABBLI3Pg3Z291nW2uJrxo+HDiODTrFKq2OMAemY
 rp2zAgxatlp4YVEPbyAd7uiFRsdfIv1h7eX0zoYLedkY8hMf+qChK6553WmII5Rc23w5c6O7lve
 GbGUIiFVWJhz072cM5m7Mhs0T8vASS0KIzWuNApcUXBwdUTdFcfM4kXnie21eYTeBfPh6aWADRk
 cbckIqjTm2L7YzaNkngD5Pzr5qKbadVHNxNxuElEFKq4TiTy+4tOeFxs7ZcOB1fdZkX2XRTz7dn
 d4ObhrrmRJN+1pFLzlbEqi1oZ/du92OWZhdFlNS8Sgp7h3AESwj1YsYA9oDbOr2cMdB0vCDQAcE
 kxAcR0f5+k8JRMJJArkDkT3e5vh1Ux5o2PUT8f7YUViLWTGXvlbLf3nIQA7Y/M54aOTQslIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506130038
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

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4: Fix compiler warnings -> s/const char *argv/char * const argv/
---
 drivers/sysreset/sysreset-uclass.c | 32 ++++++++++++++++++++++++++++++
 include/sysreset.h                 | 18 +++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 536ac727142..6eb090a37aa 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -32,6 +32,16 @@ int sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return ops->request(dev, type);
 }
 
+int sysreset_request_arg(struct udevice *dev, int argc, char * const argv[])
+{
+	struct sysreset_ops *ops = sysreset_get_ops(dev);
+
+	if (!ops->request_arg)
+		return -ENOSYS;
+
+	return ops->request_arg(dev, argc, argv);
+}
+
 int sysreset_get_status(struct udevice *dev, char *buf, int size)
 {
 	struct sysreset_ops *ops = sysreset_get_ops(dev);
@@ -71,6 +81,24 @@ int sysreset_walk(enum sysreset_t type)
 	return ret;
 }
 
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
+
 int sysreset_get_last_walk(void)
 {
 	struct udevice *dev;
@@ -132,6 +160,10 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	printf("resetting ...\n");
 	mdelay(100);
 
+	if (argc > 1)
+		if (sysreset_walk_arg(argc, argv) == -EINPROGRESS)
+			return 0;
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

