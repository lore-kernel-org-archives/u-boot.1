Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB4FEDF150
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9087D83DE0;
	Fri, 13 Feb 2026 12:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GaZin001";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ieTruT7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09DE983DCB; Fri, 13 Feb 2026 12:11:08 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACB883DE4
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D99Dx62733506
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5AgjxGBrV3Z
 zwAP2isAcGFjmdYeTuGNdS12e1rZ0Gok=; b=GaZin001TgGn6PhqNWJ3ukwP9Qo
 YbNIxsjCcwrM7IFfMRDqek/RqJOA3OZa2lUunruilbKX+NLCB2eFdiiYhwbHGDrz
 JJh6s/7SKNyN0EGTIaChgL6y7iiVFJmSnAKFS1bgNQPQ6fOGWOASOsnHkGE+PttN
 kC41vGXYtp+ObgRatCqUfsyZqPd3/Ls0lPEmxp18Br3GE3k//PAHWptYjwh16tCK
 sLDSnaNBRYVyWoxKqTKdENqD03XsZJ3uKrhNLVMCZhn4vNe6r2vXSVXowvilExVe
 6l/QZxS7maDRyzt5Db4IAf/hGA8yGf71pRI+VyqO5msNpB6D2DDQuyPIxXw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9s6wt3ma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:11:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354bf10ec2aso735988a91.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770981061; x=1771585861; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AgjxGBrV3ZzwAP2isAcGFjmdYeTuGNdS12e1rZ0Gok=;
 b=ieTruT7VfyBucE8qMBa9HwJb5sR/SaelwmURQZuoqAeWDZaehMTMeUU5mlcNw9eQnX
 lS68ZWQcmRCIqC3+6nm8K+N2h3A+dSrqYTpTeS4WGqDF2BNlzSx/wpPdYOIdKSDcZxvr
 LSiGrfa7p+3A4LpgBoGo1IgIxaufP4PT0+Rsiz/kDgIHyfmHjyfsLjCXjRgPw7X4rOmY
 d5spfFjMyRjcNXKboXWJC9kWZLE3jmITsnmfLOwRsfHNPDDdQCKl9M5oSckrWd8O7+rI
 5n6AdZO8tjL5jWJvS+DR6ztwLEEYHyNqc6bfTL1wdV7WemfxfnvZJzbWaFU1kMzwtqkt
 2L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770981061; x=1771585861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5AgjxGBrV3ZzwAP2isAcGFjmdYeTuGNdS12e1rZ0Gok=;
 b=L/xwTl3RCMsZfK1nLcO3OvyAUBHiVq8GBqXpM2RJFc40fydLDNUyY1UpioTw3whih/
 8tRxMNLLAKAZT5cpmmhbATS75NRvgr5EpPsHlqoA+EWuSWSUoeRCP+q/GWSrQUISdj5T
 oVudEgI6p10h8Kyii2YsslaWvnua91tXLCRxB/aLCtJ0A1ahZrWdEkRl6tagbMufwBKo
 Hg3JHSL6pJY7TB9OvYQJrdx3d7636ZJAu7L1nRF8M9cEaQsICAKd/VKoxl+I2ep30qaz
 1sEHIGbuJckRQGbuLP42b4nftbccGCu9eQFWX3y5N2CqA1p6YGE0O3mRtM3yXIZzNjFp
 gCwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgBCtJxOcuYRB8JtDd5nDtziAB9zAN8iOn05D6ZGRob7VvYD/0cewI97aZqz75uz8SfB1KR2s=@lists.denx.de
X-Gm-Message-State: AOJu0Yy23hpSeKMR0RHYyKxHg1VSucAeNDp6UFj7Gkiu3au9AxTnLyNP
 vrUdtsCWh66lWGz1K6ww7mVGryJY4SuWiqnFk2JZrx8FgtBRt/PUVwc8UrNMxxTMxzF/j1GVm6/
 2qldA8l0izSdr0L8Ax0Az/0207fCPuvbFynZMtHvbduZ2yNv+aSaoKNnI
X-Gm-Gg: AZuq6aKzZ7iJAPigfwI1Hg9ARv4nbqg+SRcfb+CHP0y8APmbVYftT5sfm2KfyBi8+Nv
 C1YFd7sE9J7rrfC2Iprnn5hw7jBJfLMiHe7j6COqKk5dYVwa4aXPPiXTW+10AW7W0i9axvkw94q
 E39LKrmnsOcMw6NO7cIiw6atIJY9Cq8ABOmRlykTce+U0qZFaly0R6OyAdV00kxFUSlw4txGQmi
 o7j4XWKAsZgxY5hd82jVA1XKsVgtF+/sKt4PIy3fv/vt0FI0aH7UPyL5z/bW7EVeNsS0oOTIXWY
 JbnIX6mS2ZbRo3gaRWG9FI+OIx2xh2898EKikp6yCjnhZlTMA36bzRI+yQbFK3fTogNTl5+9AL+
 eewG0S0GgiVMRe1uuy/qLdBJTpiBn/Cka87E9gL4iCpzW0R/2cpg6XuBi2yJ4bFaOH8U7gFIvuC
 8cOBxUq68UEl4IFYUiL8fN2F+uh8maCc2D3NT0B6az
X-Received: by 2002:a17:90b:1a84:b0:354:a439:d9e0 with SMTP id
 98e67ed59e1d1-356aad8f6f1mr1534302a91.36.1770981060502; 
 Fri, 13 Feb 2026 03:11:00 -0800 (PST)
X-Received: by 2002:a17:90b:1a84:b0:354:a439:d9e0 with SMTP id
 98e67ed59e1d1-356aad8f6f1mr1534279a91.36.1770981060008; 
 Fri, 13 Feb 2026 03:11:00 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35662f8cc57sm12364399a91.13.2026.02.13.03.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:10:59 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: trini@konsulko.com, sumit.garg@kernel.org, jh80.chung@samsung.com,
 peng.fan@nxp.com, neil.armstrong@linaro.org, tien.fong.chee@altera.com,
 miquel.raynal@bootlin.com, msp@baylibre.com,
 alif.zakuan.yuslaimi@altera.com, balaji.selvanathan@oss.qualcomm.com,
 w.egorov@phytec.de, varadarajan.narayanan@oss.qualcomm.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org, me@samcday.com,
 marek.vasut+renesas@mailbox.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v8 2/4] power-domain: Add warning when power-domain driver is
 missing
Date: Fri, 13 Feb 2026 16:40:07 +0530
Message-Id: <20260213111009.1254360-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
References: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xNG3kshKxP85S5JnaOAKBxdnqNB82_U2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NiBTYWx0ZWRfX4hh2PxyKfLr8
 Cg3cE7iKWlRbN4qIRm/JTw7OAhTnXh+6z6HHo2km/Q95FQO8vzhhGC1Cq6YpInHot0cI/FL5RyA
 6zhzLm2QEz7dATsH2wLKGni04BqOSZi2aSIXBluk6waj/Ty/d4UUr6IGQDiwAKVgKmaEQ4cDFMt
 Qom3Rplp1z755R1KcPs4dxvisyz3abg7OrW7nBacpjuTaEuIyx44w/slHX/DrKhPuVsc+jH0b3a
 roQkoGn5pttsSE7z6HkweiEp4X5VvdxLEl5id69K8E5o/MQINB5S0r3m7t0msU/WWyrSOG8gjwl
 6RhrxDG6wqGTsOpqsPlEokKzCpIemLvd2xlDXVvipLwzZGct1eYKw/UYJLf01Uqopd0rk7iZ6Gy
 1nigeednQRoKDDzlZULTQjYhSybHXdCCtTnTAzE8LwyWwztNltT1cGX1SDgIHxB4F+ZbKQRXoxF
 9QTPOGIZUoPlaQAf+og==
X-Proofpoint-GUID: xNG3kshKxP85S5JnaOAKBxdnqNB82_U2
X-Authority-Analysis: v=2.4 cv=CLInnBrD c=1 sm=1 tr=0 ts=698f06c5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=oaKz_nLDyQCm_LzWltEA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130086
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

Update dev_power_domain_ctrl() to log a warning if the power-domain
driver is not found (-ENODEV). Return 0 in this case to allow continued
execution, while preserving error handling for other failures.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v8:
- No changes in v8

Changes in v7:
- Cleaned up the warning logic in drivers/power/domain/power-domain-uclass.c
  when power-domain driver is missing

Changes in v6:
- Newly added the change in drivers/power/domain/power-domain-uclass.c to give warning
  when power-domain driver is missing
---
 drivers/power/domain/power-domain-uclass.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
index d9fa8ad4bd2..52f56f57658 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -10,6 +10,7 @@
 #include <malloc.h>
 #include <power-domain.h>
 #include <power-domain-uclass.h>
+#include <dm/device_compat.h>
 #include <dm/device-internal.h>
 
 struct power_domain_priv {
@@ -184,6 +185,12 @@ static int dev_power_domain_ctrl(struct udevice *dev, bool on)
 					    "#power-domain-cells", 0);
 	for (i = 0; i < count; i++) {
 		ret = power_domain_get_by_index(dev, &pd, i);
+
+		if (ret == -ENODEV) {
+			dev_warn(dev, "power-domain driver not found\n");
+			return 0;
+		}
+
 		if (ret)
 			return ret;
 		if (on)
-- 
2.34.1

