Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E2EC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C48C1841F2;
	Mon, 20 Jul 2026 10:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d8TkSOsn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LTHPvwap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13A78494B; Mon, 20 Jul 2026 10:52:19 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845B780517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RUcj1665557
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BEUF35xhWU0
 9N8fpRFwXxu5yb6p3/EGpRAZwEw8tMjI=; b=d8TkSOsn2AeBTedsbnTtN1lNjKu
 vmDMk8euP89LvIgb94M42b1ibD3Sw6pWSXidSGcrtXTYKLU51fECCfRWfHRsXdva
 bCulLWqkQZsdZyumOBjgnJwgaMD0gCn+q2rIOPJc4aC6VNbEd1mdl6gNRjTPiDsP
 YALqQBOeH5l+EkcgaWHbGWjzHrrVbXZeG9PHPaPQsjsT2QAH5HW41Mptu5X4Z/Ov
 6JsrU27MU5fjQnkGwLBxccq5A+IUr8BU0vxFoJSZuMAUeS+gqzTk2I2SVMKBH93m
 lOQ3i7+EqJMCbdRcTwE3Da//I890Vn/g/5d0k7cYpIpFaQhpanxVK3LHztQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04v9r6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:52:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51e4ba1cfabso116499151cf.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537535; x=1785142335; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BEUF35xhWU09N8fpRFwXxu5yb6p3/EGpRAZwEw8tMjI=;
 b=LTHPvwapPTyp6ki61olPQafrmhDwixgxmodh2tbUS4ISPIjcYyKx1sga+XXS8qXu2j
 2NOlmZ9C0TpUuRlzKTdWIxoaMEYc0JL1yDMM+HA8F77S5RABT4ASUxMZold/RORTWk0i
 w8rpHHVNWhZ2qDaWf7Gpi4KvJvQefzQqpsqRhBIUfsb51zexJFYxQycEHqouox/fvlcA
 KJVZJJASn2yUU3UD024xKye86vUHtxyRfj5Q+GnZR18UhAmyNkCrs3CPKo2paYmvW5IH
 SwB4qxe92fpyEHgJllv1YZORskiOhgzseawazmLogObNXxV52VpBq7XsqDS+8yTPKJeX
 qNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537535; x=1785142335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BEUF35xhWU09N8fpRFwXxu5yb6p3/EGpRAZwEw8tMjI=;
 b=eOkPqxdpiRpihiMuPv+l9oVj4Q+ZtDye2Ngg8nRiwTwMgDHiHQ57eSVp+8ej+Y5UbV
 Y2ClJILDTF8SIqs3NiC+NfOL7l/AOJDxdPGuF51yz0qshUSsFeziGxRe9BBEkRpAqmqf
 gueya6YzbBbzynE/WE1ZzFURJ2lMN84WMAS3YHbyRG4jWZ34FtC8khEwpN3b8c+WOigs
 sNqHTiY8vaRazD07oGyaYaDAtqouyvl2NaEWDYoiwoOow8E6AYioCZCAA7D6CdHpM0lt
 0LJn7rM8IhPAVgUFNOGKshaoqRJ7qGB/cMpBNGxqrBr+IpYi6TwHuuf8z/gDd+hiUukN
 52yg==
X-Gm-Message-State: AOJu0Yz0Uc2j+qzkKbHDwULwY8ydF8xxxvKox1YZSRiyWDcVECYZiZoe
 zDdw03ChgNBFtNTTngMYA2QgmCtifqK+GmNbaSJP3K6aLPk0VCU1JmG34/EcSBO3DERnYXqatVj
 Up0tWYelu1glYWnTFa7V6qYqKEpOePS4eV9l8SlLFHXR+C9K/sIKj7tgg
X-Gm-Gg: AfdE7cmZvHJBTZ0wHYPvXVpUZunchQzzWYwYRGI4suVVdfohAw1IXyaRxxiUwJxHVE6
 m6726HvzHuPsLFToZq/Ka9sDnU+3c1uu0NUReQEavgygICYDznEwp9WAeALjRpFgGDddUVqA4E3
 PHDkfH0X7CKCe0sLKLJXhYvaVBcEo5M8Dt+xy4bxL0JigaL4O5qA0pEOk8g1i0fNoBHftUB8V1y
 RL65cEW3dTcn1VbtIi01nkcRwMaRAYuo8+9H3v6NUyC0GHKjE8FLNA6W5Eh6H4jeBEodJBCWeCS
 1io1G9tCv6Cu7xzo6eC3qVKBZhZMUM3HwfzC525KfU6/iRXzFr5GyrHorv1omgLqz5jwLcSvy4q
 hRHxXhuI4lld0BnWy8pMnGHNcnxrCIg0Wkd7E3Bf57W3w6ASUaI0=
X-Received: by 2002:a05:622a:1a8e:b0:51c:478:32a1 with SMTP id
 d75a77b69052e-5213bb216b1mr125934901cf.18.1784537535139; 
 Mon, 20 Jul 2026 01:52:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1a8e:b0:51c:478:32a1 with SMTP id
 d75a77b69052e-5213bb216b1mr125934741cf.18.1784537534715; 
 Mon, 20 Jul 2026 01:52:14 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm26450052f8f.4.2026.07.20.01.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:52:14 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, trini@konsulko.com,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
Subject: [PATCH v1 4/7] ufs: rpmb: retry SECURITY PROTOCOL on power-on UNIT
 ATTENTION
Date: Mon, 20 Jul 2026 10:51:44 +0200
Message-ID: <20260720085202.537019-5-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5de1bf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=dNplHGv5OaZk4fVmYA0A:9 a=O8hF6Hzn-FEA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfX1O18R/oIMQ1G
 /6d8G36Oh0erwV1pndy2kuplbnKgwo8UqH5dsq/e0z7zjc6bg3gD/D7BSpcnlLvqAmUyRr0qpBp
 P9Xm8CHw9LbsBjHjqlfuOKw1JfkIbuFFBJOhVT8HpIqj8DeyuIcyhir0oVwJaA991qjEY9Y/+hi
 GHVfKNMB3Sn71we0TfR3Ys5fHJJ6ofpcNNfUyl+GX3tz5nJHtG3sHcdyl9k+aIJPwkWSXKdwnZu
 F/P6jBSeS6F0EyYbrfqgqItVrf4X9Bc2K8YiAtwvzc1IHKjwRJEDG4FRn2UGm0OlAjggn4a6Hy2
 Ykj5Ws97VH6lk+GcIw15aLXeepIWwuWiKol7c0Qw7gBTs2JGtnrrt1vFebk3aYZOsm195xBTRA5
 HBEmWjnUtoyc0p2Af8arR8wKQxFPM8CVq7s6S9xZqCp0YUb8qY6ZKRNTkgR/zrDin1HFriADnlx
 NXNWXWa549GUMLwVXvA==
X-Proofpoint-ORIG-GUID: zl70hyndw9tQvJUf8722QaAk5mwVokok
X-Proofpoint-GUID: zl70hyndw9tQvJUf8722QaAk5mwVokok
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5OCBTYWx0ZWRfXzWSPdrQuTfFU
 j3fjh28bqZgsLZrOBFGrdLgUX8xJX6wikV8+bnDKI6OlLI8Rppj3l0yt3ZTyD60bHEGqSaKZa1y
 +GJWiQGJDsVuTbQ1COS2EzVa4MPXu/Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200098
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

The RPMB Well-Known LUN is untouched during boot, so its first SECURITY
PROTOCOL command after power-on is answered with a CHECK CONDITION
carrying a power-on UNIT ATTENTION, which ufs_scsi_exec() surfaces as
-EINVAL. U-Boot has no SCSI mid-layer to auto-retry, so the first RPMB
frame OP-TEE sends (the write-counter read that verifies the key) was
lost. Reporting the UNIT ATTENTION clears it, so retry the command once.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/ufs-rpmb.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index 7919162ddae..1434161682b 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -19,6 +19,8 @@
 
 #define RPMB_FRAME_REQ_OFFSET	510
 
+#define UFS_RPMB_UA_RETRIES	3
+
 static u16 rpmb_frame_request(const void *frame)
 {
 	const u8 *p = frame;
@@ -34,6 +36,8 @@ static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
 	struct scsi_cmd pccb;
 	u32 len = nframes * RPMB_FRAME_SIZE;
 	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
+	int retries;
+	int ret = 0;
 
 	memset(&pccb, 0, sizeof(pccb));
 	pccb.lun = UFS_UPIU_RPMB_WLUN;
@@ -54,7 +58,13 @@ static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
 	pccb.datalen = len;
 	pccb.dma_dir = dir;
 
-	return scsi_exec(scsi_dev, &pccb);
+	for (retries = UFS_RPMB_UA_RETRIES; retries > 0; retries--) {
+		ret = scsi_exec(scsi_dev, &pccb);
+		if (!ret)
+			break;
+	}
+
+	return ret;
 }
 
 static int ufs_rpmb_send(struct udevice *scsi_dev, unsigned int region,
-- 
2.54.0

