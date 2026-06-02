Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0C0CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 06:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAAAA84884;
	Tue,  2 Jun 2026 08:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nTnOGjlG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GTG+R/2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B495C8488B; Tue,  2 Jun 2026 08:43:41 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA7584875
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 08:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6525isi01316771
 for <u-boot@lists.denx.de>; Tue, 2 Jun 2026 06:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Gbuox/G/kHUJm0jZPWEdBMCJ+qnsPkSkoyv
 AWIkfXzw=; b=nTnOGjlGiVnvca6hVYcw4wrgW9skHdyauo+a4uQZi+fZhYV+MAt
 Cyo47pKFV/IFzPC2exM6pXx8I+pMrWPRE1DRfZwftylhvkVR3QMd+gSQnrtw3kHq
 NsMKCNAd/C/OYfENNcWaw2QWBjN9/qcGzXUWcQIVnULRpVFp2ysTgv2zwp/lTBXx
 6rfLqY3c3hF5w6ZEurcxjTBiSBtCTnIN01TELANqzMBaU/grgpoTxupimQi1MBW1
 DHKTssL55iW9e7/lrlEnPaMMvhhh7neJ+5rcuDRbGy6O9XOnh9Uq6ma5qnUw+6/5
 mIOz/3dJHWnfTlEpb5b3U4t1EW/0vZxhj0Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehs9vr7j9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 06:43:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8423f24dcedso2823297b3a.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780382617; x=1780987417; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gbuox/G/kHUJm0jZPWEdBMCJ+qnsPkSkoyvAWIkfXzw=;
 b=GTG+R/2+6tFQb5K63r38mEpguCWhpDbDvpYQb0Byw2R1VMBZUOPPHLaHnb5/bLc+sJ
 yK34knytSM4dLT2VM+X0EmOfH8hgvHHLsDnB5v718YmBVEpOR3yUWQ5dmfLovZzNifuc
 z3j2U/vo0pYAzu52BfJ4+Z9yAsb//ji1Bb/FSrfKj9wC+Pnz+u2iDWTGmYJiL9pmoVtH
 9+m9T0f78Cc8nbP+vf29Rt8UFpQr+UDDo42oMr/O/qZIFxaalhZnSKu+dDhExU+locgA
 NYmYtshpYygiuEI1zzZX+aRjzS+PKkDKZ/JBjMG1HKEPD7byAaG5Q5LHJ/aC9wq0pKK/
 2vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780382617; x=1780987417;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gbuox/G/kHUJm0jZPWEdBMCJ+qnsPkSkoyvAWIkfXzw=;
 b=GYe7B3c9z9zRdpEl5A5y7baoTvEVbUycuJh2fQUmdFAId/ZeVz/RqAfM8n33ZUmVcE
 dO3NHxKvjgf1u+l7uUiIUN5qAysfTKLrUzN9KAANSyl88JNgESpQe9CM266ZOvYyjBhf
 iuDF8Jl3vcnly/kxMLPbUFp4gCAs4JkB9o9cjdQp+NrGu9vPVnp24yjUWcKAbxAY/tiH
 78CK/AjVrJ5mnc66PI9dWUlm0If/xQkzwngliY+Q4SCmJU1zh9vY5a7IZNc02B1bTIDQ
 rBtL5eimY/Uim4NrH/I9bxFzgpESitgzIQhzGqkfzEZChfzGOXyEF2FH1ICPI/x5GKvw
 GSWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zcRRmdwQFiZRLOEkD0xRcfjPBtyTUOnMJRdYGCeRdVSVC+nnRd2EcIVjfHcg6uIDNVgHhbpM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxxsl0Ywt2myjSs3OGcXMpih0q96Wag8h6NYINjiOGAvZKStf0a
 L42KzNczyQWnqcAxKrBohayP4ndb9P1crC1qdxCONIs86t6qutjDPTSI3jGfSxj4GCQzHZx1xS6
 8Tw/Yo2vIdoIYk4kLRATTGn1RAN68ARk/dSbSvL4wTn/6JVVYWLH8Mnzt
X-Gm-Gg: Acq92OE4OOfssbvsBtsqpjkY6vPZ5Ua6FwkuuFNSnlVgmNcgi/t7Bp5sne2mTgWXUPp
 ubm1r6Tjf8cah1TTVKNlCROFjpnJi4uECbF4gK9qQDORur6QxpMTRZsALcr9tF65ri4ro7cMEoY
 Sx2kuzxVQX6TFf9+DKZLxR3i+SEgJM5NG5mKCv6DCeCRgm/2QJMYUW1vRmdObtUQu9H6MURK+Wo
 ESqxJ09KSZQ8GfrbpifJa2mmmEx1BPlOSfzAsNizfgTI9/x8G/slb/O4L6a6o9xNOz9AfXR5maU
 z59Davvkg2IMq19ec4MxbhiVNzSbZOJjY3b7v1eJ2ewFp3qJ3p2OavEqDsC7s3run/QGyg7zmT4
 uI9MRY9TJnPcduubsJrisn00yLsXQWBkgLUmTARU9E9uRWYrw31uQ2CsOqmrHx1mxvVAL1me7k8
 WtPG1Z2N5eiME5tF3X03DRfo3SAyCZLN5tY5/Fbh+t2jn36+D43s0=
X-Received: by 2002:a05:6a00:1889:b0:842:65f8:bb3a with SMTP id
 d2e1a72fcca58-84265f8beb0mr3858192b3a.19.1780382616661; 
 Mon, 01 Jun 2026 23:43:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:1889:b0:842:65f8:bb3a with SMTP id
 d2e1a72fcca58-84265f8beb0mr3858165b3a.19.1780382616085; 
 Mon, 01 Jun 2026 23:43:36 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214ce54b8sm11860464b3a.48.2026.06.01.23.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 23:43:35 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: hs@nabladev.com, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.denx.de
Subject: [PATCH v1] i2c: geni: reset controller on NACK to recover from
 invalid bus state
Date: Tue,  2 Jun 2026 12:13:22 +0530
Message-Id: <20260602064322.2409171-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VkR1gdCdcTKjFZKkwRPz4pD3LMtm3TA-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2MCBTYWx0ZWRfX/P4u/LGYEsBM
 kg293LL9mkiL0heNO6q4/IoJCeIUCaeNri3oYC1z/lnR+vurIHRnM3WTnYdbCIXM/HidXbTk6r3
 QHxkKBMPzEDduGMlZaQEjGbNaqllHjingl4PimKJsWSS4Gj3Hy6so3AIH+SnGzvojbf3DV9rdfi
 UFTvpJCYr1kMBs5e1e65tlrDdpydVvMPhIgHzSTo3ImaYaE5A+9dlOaiK53K4S+RwbHxb47Uo7c
 WcO4Vpfu7szcjONAC2w99FmbSRLwR3uxcWCUFG3tZF3KLCYF3HMUTMnohlIMJxw8YZfTNWoW4xF
 +XfUtXg3TL5/r4AykQ6FQ+eMtImAzRs/NuvndErOfIvW5CKHbFMhpoa+IDsLDv6CqsCgKQT7axm
 Zl9nTVFZcOCl0Td+prNh436yEqlKANvx3Ep0xb1QSPbbp5Jsu2FdILlIwX49Ys+Yd0FvRmMrlcd
 +fkEnMtxXCInE4Uuilw==
X-Authority-Analysis: v=2.4 cv=NYfWEWD4 c=1 sm=1 tr=0 ts=6a1e7b99 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=PckQBBMBZqG5TA6WuygA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: VkR1gdCdcTKjFZKkwRPz4pD3LMtm3TA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020060
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

During i2c probe, repeated accesses to non-existent slave addresses
generate consecutive NACK responses. On GENI I2C controllers, these
back-to-back error conditions leaves the controller in an invalid
or busy state, especially at lower bus frequencies (100 kHz and
400 kHz). As a result, subsequent transfers fails and valid slave
addresses are not detected.

Currently, controller recovery is triggered only on timeout errors.
However, NACK conditions (-EREMOTEIO) can lead to the same stale bus
state.

Handle -EREMOTEIO similar to -ETIMEDOUT by issuing a command abort
before starting the next transfer. This ensures the controller state
machine is reset and the bus is returned to a known good state.

This improves reliability of i2c probe and allows correct detection
of slave devices under repeated probing conditions.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/i2c/geni_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index fbe5ab0ad0c..7498cbcb41a 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -285,7 +285,7 @@ static int geni_i2c_xfer(struct udevice *bus, struct i2c_msg msgs[], int num)
 	}
 
 	if (ret) {
-		if (ret == -ETIMEDOUT) {
+		if (ret == -ETIMEDOUT || ret == -EREMOTEIO) {
 			u32 status;
 
 			writel(M_GENI_CMD_ABORT, geni->base + SE_GENI_M_CMD_CTRL_REG);
-- 
2.34.1

