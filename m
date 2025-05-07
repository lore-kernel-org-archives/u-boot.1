Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D02C3ABB6
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 07:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 350268215B;
	Wed,  7 May 2025 09:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="ArqtWBly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 638AF8211F; Wed,  7 May 2025 09:08:05 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A0A682114
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 09:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471GsVC021940;
 Wed, 7 May 2025 07:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bsh5fvC7RpZrw/5t+YKjyfvCV27o/LH/z2foxpmWbIY=; b=ArqtWBlylVH9mQrX
 HZR6DTL2lnQ+v2rGaXV4EivVRICeSzPY61oloWNm9tWtgxSoZAkRRSJGbeE7Hxrr
 2YpyGQibrmtjBPG3vk0blI//TTubwjWnCdzTqv1jvuTM7zm9Tesr9JFWtTdDUDvx
 liLq77q3THdpRQNtYsprW3sfP2yN4wO7yhgj/vFHabndSwa9wmb8+kAtFgANMk6C
 ugSb1cnY1mdI73SdDMH+eD8BAoIoPjlH4p+kRz6YAsNNZZmu5khcwq+DaYU6lJBB
 fSo0lhye5+y5GUqNPA1iKn9/uIzFRFbSWTuHJMFPdXwiZhTRiP9m5qK0KlXHklXo
 vFU6bA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5uuvtuh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 07:07:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54777tOL011281
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 May 2025 07:07:55 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 00:07:51 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <clamor95@gmail.com>, <robert.marko@sartura.hr>, <me@samcday.com>,
 <sjg@chromium.org>, <marek.vasut+renesas@mailbox.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v3 1/3] drivers: sysreset: Add sysreset op that can take
 arguments
Date: Wed, 7 May 2025 12:37:31 +0530
Message-ID: <20250507070733.2871986-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507070733.2871986-1-quic_varada@quicinc.com>
References: <20250507070733.2871986-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=681b06cc cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=4CW6uQ3dsC97Krx8dn0A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: TwY7E7alZGsL3seuFUkXeuySGB0N32Id
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA2NSBTYWx0ZWRfXwxy+zYBZtQsJ
 7HTrhOQoYUww/IYltSFWZ/7gBxbjPTFhFVWJ1Rjg3BNfPuWhSfn75LEAb/1T2U4y07kDubx1rw7
 bXTt+gbR37w1m5zEhYcNec0R4ovbqyEq1cUpX9HPmMrFK//Oc0btG36TrGD1vtYm50ugnjn3EQ+
 8NfgyxjmtEe20WL7xsZ5hKEPr9+fJTu36QTTlzXOFaEtgjTk5FQCCObqX8KTbNKL5snqC52prW6
 MynLB/cMoiG1Bk2XnyTuNfgufD2VBDiVbnxLfTIBZFUCtuTlzWRW8XefcgPIlysWtXkr0/gZQCn
 21OOS/Tj1Y8vDb9SLtiFP8vLSfsnY+21Zm67skwuadfONoArs/h8PDHq/KDC16lyVcEO8GBzjBV
 sH9mnC7MO6+WMkJZrZt6i/6/adiEacTzvZDN0qUrbABmI3Q7hJnFK+orfyf1fBgAk9fxu4Pa
X-Proofpoint-ORIG-GUID: TwY7E7alZGsL3seuFUkXeuySGB0N32Id
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070065
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
 drivers/sysreset/sysreset-uclass.c | 32 ++++++++++++++++++++++++++++++
 include/sysreset.h                 | 18 +++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 536ac727142..0782df55d3c 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -32,6 +32,16 @@ int sysreset_request(struct udevice *dev, enum sysreset_t type)
 	return ops->request(dev, type);
 }
 
+int sysreset_request_arg(struct udevice *dev, int argc, const char *argv[])
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
 
+int sysreset_walk_arg(int argc, char *const argv[])
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
index ff20abdeed3..4c2d8633188 100644
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
+	int (*request_arg)(struct udevice *dev, int argc, const char *argv[]);
+
 	/**
 	 * @get_status:	get printable reset status information
 	 *
-- 
2.34.1

