Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083ABEFB7EF
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 03:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DB283DCB;
	Tue, 24 Feb 2026 04:50:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L1G+lKhX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N9BZVUSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E6083DCB; Tue, 24 Feb 2026 04:50:25 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BD583D3D
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 04:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61O3KrqR566629
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 03:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bqdtJO6hl8g
 6cMfuzGmltG6rGNRWPtSFiAD0SP5i0TM=; b=L1G+lKhXjjsBqmV8fk/SuKslOy8
 6ro1wBdSbpyk+Qq37mfgG+gSfjoXpyc0U32CEZZnCaQ9ucNk/jpgvUzRrIebqjyY
 kzQ3eMDhUwCNyYBjwW/l7isV+OvgvT+lTXKjGf5JA2p4ATtsmybHlpjk9nQqu7WM
 GkH5RKayhBYnO8GXQavveGbhBgirpb0g8x71+LGkQknpMLwWf+VAeuuarnKXoh8s
 Y8V5e1TYh+Q6j7fI58oYJf+0fa8rTkqlLnz1EiMT7xBQ3JEzDKL9sWg6c8qpZefK
 atnY2OhxEgQfL3aZMxkp0pMGlvXr+c4DRHC6zCm3aDK/vyIQvEvOTP/Q5QA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtv9snh8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 03:50:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a77040ede0so58111005ad.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 19:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771905021; x=1772509821; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqdtJO6hl8g6cMfuzGmltG6rGNRWPtSFiAD0SP5i0TM=;
 b=N9BZVUSLkCQG4mfHoIaMGsd01XaNguQT+lgQI00O5jFRnMFo6hKTkzPNEsnNkOgl07
 D/ZTjZyCyuFutwTdZPpUZrGLCX3gf4LjNjKZCBOPtS9kbvist50bwJWZ6ZAW3tPCvXzG
 xxce+mvFd1Nh7zmkQP1LiUXl2dt2/kcyxxAN343khALLRHgSYKSwrf/0U8wysjY306W/
 Se2YyZycyFpBgraseB5nzLAInnS5zb0NnT9OccayElcnEkuCNjd6YkxxTBfHRe4yftBq
 6uqNShxIqcv4a6vXmNQ18513e8rXDfMUtpuWatGSEmngnjqFS5p1UkqQFaq/FtoD9dUD
 zHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771905021; x=1772509821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bqdtJO6hl8g6cMfuzGmltG6rGNRWPtSFiAD0SP5i0TM=;
 b=Ir1D/6D8y5EhJGnhFDWehVU2iPjpnXSfMaih/qzMtt/A0t4K8uAonTwq4aYMOaMfG8
 GK1weW1rtpJWb8LrTUCtv3iXi+NnK+bDXea/7QSD1Xdhax5wifU5vWAgaQOHwLiX4GOP
 CUD5baHPUzVAY2Bx/u175GoHDSmKahxYFOo1i+JsAfeNp5mYquvx+tG90quFdQZac1MG
 Bd/6UrFxf5g+t3ohWPqtD3OwRzRAFD8TVfJ8lPe0dKUhwEfjkiFP3a+ggQz0EtPrUnxw
 Mf5yMKbKxuSD5FKvj+16bhFAnpjD4F3z86SY+sIae533w2YHGGrVuotFRtzB52Sm9NOQ
 wpDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxEJixMVW0VRd6AM4tllZIhDe94WDwp2QTxqNwAlRurv0XRhWPouCJuqXBzJ+6YL1X6dnyAqU=@lists.denx.de
X-Gm-Message-State: AOJu0YwSBDcRWdxBj7Ph+p3sI/LrMBK4obqrMta7kpd761nfDBEbJqGR
 OI8Gb9IUqe7xy+pOkuzgvc+t1Z5SdPCDYRJKLSJm9WI2qjlUl9rNG6U4CE8psJmDO90RainDeYO
 QBlusN+MFQTciEjro3NLVOyxZKphxsFj8IxMPjdH9uWmj2eYZuir9kntV
X-Gm-Gg: ATEYQzySIVJngxlfstYKLOHPJhA5ilMhV3sNIZiQ93fKcFqGENJSBWXBehGLsoEwah3
 JJ1HonGGvxgLas5EtxFoEAggcUe43+lsQgFhB2Dq6BRhaLnPx6nr+ExuaH0pPGv7KVi3te5q82r
 8JL1cbyW9c0GkdW78OxvvwuTFQOkp3Iszm68Ou+fmLq+IfgtJu/CWm53uJZTGk1Oi1J2EZMwEuq
 /IbYjidIEO6WkAZUUajeyGrXa+BTi8F2GvpLKpaUqPhcg5jTlF3U+NbcSmQ/mUAkLmrrhkVK5gD
 Ax4/dtvR8yDgOVk/I2mjtCEAP8+ZkOO2OuFi/NuklQHcbTzO5qNSd4QBXbGuoznXJsqRTslJedu
 Y0d6GNntfs8MiKbeeR8gNm+9bMf49bBaUBAa2P6tEpTjNnFjfR6z5ShjSXzWY0jt4UoDLjPVkas
 xXTIySXPUb738AU16hjfSDA0LsGNNU0BsuBN0V8e2Fy+dKn87GOeA=
X-Received: by 2002:a17:903:2408:b0:2aa:f07f:a776 with SMTP id
 d9443c01a7336-2ad74538457mr108109925ad.43.1771905020735; 
 Mon, 23 Feb 2026 19:50:20 -0800 (PST)
X-Received: by 2002:a17:903:2408:b0:2aa:f07f:a776 with SMTP id
 d9443c01a7336-2ad74538457mr108109615ad.43.1771905020256; 
 Mon, 23 Feb 2026 19:50:20 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75027affsm86037945ad.66.2026.02.23.19.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 19:50:19 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, christopher.obbard@linaro.org,
 marek.vasut+renesas@mailbox.org, me@samcday.com,
 varadarajan.narayanan@oss.qualcomm.com, gabriel.dalimonte@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, balaji.selvanathan@oss.qualcomm.com
Subject: [PATCH v6 2/2] configs: qcom: Enable
 FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH
Date: Tue, 24 Feb 2026 09:20:00 +0530
Message-Id: <20260224035000.1617869-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vaf6/Vp9 c=1 sm=1 tr=0 ts=699d1ffd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=nsyQm3mfEbPBaua3R_wA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAyOSBTYWx0ZWRfX3mIByiljVswF
 6i6FRCJ9FG2O6CzfcEDDAdWDMlNGcN3SQeK+AH5FsOmNBBkXwwjwyp9XUn2qtAhPG3CJRQDAz/6
 gMRx0y7iJs5iLEgFdVZ/ayVTupHN7oDotpXO1Vi5CC2NFSCo+DBD9A7axgTqI4O+E6O4LU2AVMj
 Lf/+Ok+GynO5iWHH1KewdJAm6A9/7wW+UxOaWKhzsiDni6BdgQzmNfIwgfLlsWXq1nyoa4dgX/y
 d+JBQe4D4MZmsGrdHoIdJu8J/QXgmxeR3iYKbLnEYd2UwURl2eTibQIVaUWVSTMvQyqvV3kY09H
 euDdqZp8jsPTYZXP+6AIEGpKqPYr23UN1negEgcXFkaMDBZFrKSorwROHsZzPmH4tE6AIPSIsLS
 6NgnH0uaL3Iq70Dq++8bfr/scqEog4uS4z7Alwh/2vJvTTuLhrkUUpcT8bdYbdjvhI2KzS0wKVO
 pssdJ+3q8ZJZ9fpbEWw==
X-Proofpoint-ORIG-GUID: LAAcKBVnLXE2Y9rSp7vQFATwLFXCP1DS
X-Proofpoint-GUID: LAAcKBVnLXE2Y9rSp7vQFATwLFXCP1DS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240029
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

Enable FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH to handle the different
combination of FAT sector size and device block size present in QCOM
platforms.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1fd..baad5f09455 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -147,3 +147,4 @@ CONFIG_NO_FB_CLEAR=y
 CONFIG_VIDEO_SIMPLE=y
 CONFIG_WDT=y
 CONFIG_WDT_QCOM=y
+CONFIG_FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH=y
-- 
2.34.1

