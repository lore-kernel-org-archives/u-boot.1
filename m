Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B13FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7815C845E3;
	Tue, 28 Apr 2026 09:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5u1VE2y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dxqn6l3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80C44842D7; Tue, 28 Apr 2026 09:32:26 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D9683A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S3P3Lx662986
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O7IEzhg7owmT3q3sX2irBPKkHJiMg1+LDzzEHN92VcY=; b=U5u1VE2ykHJ9Mtrf
 gGi++SjF8y/A5j6FCcu+OP3BPYI17VKQAYefFpdl3L9GEGvJ9M1vkulGy31upWPd
 tMDCyJJZm+bp0Xvk34UlF/J7BJURsd7G0Hoa2zPID03uKeIGn4nY1ScVFJ938h3n
 Tg2BTiRCjP/2NMRpRxuuxnD1mxUG3m99s0wv1m9WgDQnXVkLqq3YqySx88l4hzcN
 iitfIVFMXW6OGdy72o0g0OY3Lg4mTwXMhgwT+Z8AMXOdHW+Kmd1u7ud7gRvNSQjR
 o7R+8BSIjrpm2J7bG1iTuNYzqCinhVfXyMg2vOjzXSx31m1v6qKogXC5f6zuuTFv
 iGX9QQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n2ss1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b79f4b35b7so51296165ad.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361542; x=1777966342; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O7IEzhg7owmT3q3sX2irBPKkHJiMg1+LDzzEHN92VcY=;
 b=Dxqn6l3GlQh7MowFro6Tfmk8ougy/WoDHIiXTmT27cf+1/liXDiEpFgBeaKrczNQaH
 BYKMHO1ZrDMYjAV/du2dHBAQgQEAVKQNX7VokiAcoS0p/YLD+A0TRnA154clHK4YCkRP
 axeCE7ae8ZFEyXvi7SmHw7YYVRcSEjtcpd8JCfazSamF38xz05IKYGAV0sxOTw33Hs/6
 2Z86egaX4jn0Nv0vESsjUsHD0QqfEapgwxkUjrzThJUKLHABUW0vqG0lokJtA8fxhQUS
 ASpPYGxRYheOkRmJsg9GmyRB773nG3h0EyJAh3XaAHUS8IenXLARIVoxWhm1OmSjjQfQ
 Qxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361542; x=1777966342;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O7IEzhg7owmT3q3sX2irBPKkHJiMg1+LDzzEHN92VcY=;
 b=YDX9Su84hHJ/0ZkASFw9NKDzi71h4esZGIkvrqwjQFsQkryC1wnttseu3dhayHT+3c
 jDsmszukINyHYHkpMdl01YNfQkKs9VE3B70R19/l3jF0r9OU2CgDqS3uzpkkOZHHiBTK
 LUVzXy26ZoXbLeMEjXJpdMPzJRbcRPfMN2ICHoxnjCaoYp8jO7skJGXNC4NqwQkihSmh
 Uy/HFsy7q4FrH6oPktY585Oc02f5p2H6Uk2Vd8LeKMZi6Bzd1tLZOldgA9PChpDQSQlY
 8lumlonYqaS4Ja4krbJv69bDMroYRZ+4BaXZGYhmwLex8uEKbF8FaDc31CoO2c6wmW88
 OQGQ==
X-Gm-Message-State: AOJu0Ywvb36ZMwwXibcoK9kRlFqAyWNqbaGkym2UOHangxmZC0rEME7B
 +hpgDW38xpNrmjTfpBKg5MBOUd1aUov3NUZAjPEKQwF/qKXe5rJe81wOaQFrYgJEFLcnJ+mKtBL
 tN4LwCZhFQ/CflPpdxLJMsbHdMf6BvV4hQFydFNk5JWy4bib2PDCrQ8Pa
X-Gm-Gg: AeBDiev0aaMVeQTJYWuJ1WKMsI77x1i/yr5vDt0Q5doPBIYUxLfIbhI878++fpw/ULs
 VUx5kEy08gwtMx6f999Y2VnM8qIIF4JhMNEK/10bN9RVzisXPFJ+gdWJkSFbh6emISDwfi0FUsW
 /zXi7WY9mv1GCOXiunHKb8rwzO7kO4BgiSoGE9cbHLNv+zXhQBNke9wHdHMy7cUa+YBGC/gKZre
 QUPoTmYk7gv1isgOoS/wMP9JZrNaMLNb7J+BRYVklJ5VXKRHg60/CjJvvxnL2pH/J//oPtXjS4g
 zF0jGCV1ZGSPGJJh1LfHdPI+qvc6IYcCSle/z5nODCogJNIbKWQ4eupjQxb44bvsJg0bj9K+fx1
 MDUIpcdqIQNfdHiiJmsmo6kzK/cu/3rR1kI0n+4q8aHj+3i6cnXWOmZavCDAAT0DpzYRDdx5kHi
 lRB2hvQDrqo4R+QSMJsLyAG9Hq91SQwmaPJtVzYdnBPUw7Jc5Z6Lg84xraPmv7
X-Received: by 2002:a17:902:d714:b0:2b4:5d87:a1fd with SMTP id
 d9443c01a7336-2b97c498fb5mr14408085ad.27.1777361541793; 
 Tue, 28 Apr 2026 00:32:21 -0700 (PDT)
X-Received: by 2002:a17:902:d714:b0:2b4:5d87:a1fd with SMTP id
 d9443c01a7336-2b97c498fb5mr14407785ad.27.1777361541300; 
 Tue, 28 Apr 2026 00:32:21 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97aabaecfsm16054405ad.36.2026.04.28.00.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:32:21 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:01:45 +0530
Subject: [PATCH v4 3/8] scsi: Optimize scsi_get_blk_by_uuid() loop
 iteration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-type-v4-3-b7051dc45a88@oss.qualcomm.com>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
In-Reply-To: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777361510; l=995;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=2SDxwmcuB6aWGO+A7/rZmKS1No5fbiOofimHUns354A=;
 b=9/4SYGb/1fVcJj60pwArQuALufCQUto9dDXDH5D5nG66/eFTHrBHwmlOfnmWxRvh9Q/ygTOyJ
 X/KZyI7gP4aBpzwT++2XLA2issG2l7p3H6qtDUxjpHg4QB+FtQYenDC
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfX0+omT9MWXQ/3
 X3U2szsV9sHarPxW6T14VD0WW5VG3nAs9GkHgXHBwat5TeCzND2Pd/fm2CTd/qi8m7cvKol3FUc
 mT4A5J8Nt1Uf+nUW1y14r49Xatyjb5l7jKHubPvGgAIpEusUuE0OQYduBSvIFlkm0zvC6N5K6K2
 ME3s9l4SHEdVUBzYOupeR8dzE2fsPa3oARjnDSnlnRtiPtLZT9TQtkLR30AYqE6PWnXcsH48GG/
 XEmlXNzoUC+f49DoNpeerOl0K2EqwS4Jh+pxoH9MjPnkNtBks276Y+LjRCkGfCWzo0hKlI329pm
 aM1ldCoTNcuPWMTnGT7zvlPkEMO/douNRvMISmr3jygklmdJlWzNHuhExmxsP3FJZl1yl1cjcrt
 2Az7uCpTWrYh9gqIZ77eyosLZLex5BcrrAL5zpuNaj+qzbOyhdAtLBoWsbQ8VXs8EaZ/n9ZfwXr
 oEE+hTBKX8wgZsckERg==
X-Proofpoint-GUID: 7AGK8MShcqshz1LI1C7cAVqX3xE9Ytx2
X-Proofpoint-ORIG-GUID: 7AGK8MShcqshz1LI1C7cAVqX3xE9Ytx2
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f06286 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=DtMCEMCe2gnqSNlAdNMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280069
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

Compute blk_find_max_devnum(UCLASS_SCSI) only once instead of
on every loop iteration for better performance.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Newly created in v4
- Has only scsi_get_blk_by_uuid changes
---
 drivers/scsi/scsi-uclass.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index cea6d771f7c..031dc01b9de 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -30,9 +30,10 @@ int scsi_get_blk_by_uuid(const char *uuid,
 			 struct disk_partition *part_info_ptr)
 {
 	struct blk_desc *blk;
-	int i, ret;
+	int i, ret, max;
 
-	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
+	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
+	for (i = 0; i < max; i++) {
 		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
 		if (ret)
 			continue;

-- 
2.34.1

