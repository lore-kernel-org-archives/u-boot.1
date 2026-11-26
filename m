Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0C606A330
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ENfBRy2D;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BsPChA2L;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V07wJuk9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBD6C60A92;
	Thu, 26 Nov 2026 14:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4vAZlaNGaV90; Thu, 26 Nov 2026 14:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B668D60A7F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795703466;
	b=MLccLMlIwAf2qw3np2Tj67uziah7vgbfTzLnhEHyWExiZ2qiHP/nktVKI/dEM1FngXjs
	 sxhGQ1tSsGR9Nh6aWfHMDD7XILhG3Zg/jijkuNkumMgU0rMstse/jrhlXxN7uDL6J2HAJ
	 yy+rwywz2hpGVW5h79BwwKORj26ApB6NN3RosxOe8njZPh6v3lRjwTGNA7DWB2LtlT6jy
	 1KNrDm8UawmAhJyycRtuqHmNAXEuCnvFDtNGy0fixCBh2wctoETkEL62lEJpDz/hsVIGD
	 WeTjozddiK5grb7nuBp+cUcHhGsooovX4jug2d6AppYW98Qs6sb0ine7FxUnXUGCLJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795703466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rTi4m/2d/OfzrGWpZyvWn08lu69GxA0EMZ0OojRCIvw=;
	b=oNTa8hqFV3DXf+btTOnyL463uuLRAiICY/qSrjL29u0QLx7G0zn1t+YPS1zLChCfIcFr
	 rPKNbVmbqlRJZ3R2LudDdMNypafyl0OW0ITsx/pc+1+OOHhP2mjkoXTT0fMAy2noQ1cox
	 qHigeqt87yno1XiZ2fyqwcrI1Go9p9N5jI/saRjHLYtu8bR3vQrB3Ur8sqMBlC+cHNjSd
	 mZsxiTOtowsaVEoAzpqw+362wFNveKUTsrF3iiVlpPsGgy+r2wlMSxG6ILUfSsv6p28ft
	 j8jF6NTjvcihuA7NWhmOw33kY5frQEbFPJTeTXuN9hlmfCMm2Esejy8ENYwHBx5OEew==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795703466;
	bh=rTi4m/2d/OfzrGWpZyvWn08lu69GxA0EMZ0OojRCIvw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ENfBRy2DL8MhHi/Wba7QkVAcW1HNYSLnbSLztvGpAcHiI0CiShQsYM9Ml5xRQIOHM
	 iTZSdFqiivcN5WIQGDjGuabcYvP1fuxHyrCATRVC6/snGopCGKhKsC9WPzedcIrWbh
	 eLH6kSJg6af3jlY2EFjxoPL7Euk2ZiC+/KyYzmA6/Hu5Fi2Fuk8/gAmRieF9CYuXyX
	 IlU0LocSEexHryFysTsbGMv7yXpD9nNYiV6tKh2WUoij1JZwKztZckISBiUp4PBttO
	 O5hCOewgiiIZKiuthtu9dMpS3PUYnAlsECEY6tcqEwNWe1MPG7J/bwEW+5H+XrbZvL
	 RxKBK+FPyx73g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B668D60A7F;
	Thu, 26 Nov 2026 14:31:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F59910B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E988F404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ct-THNBGFv5W for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 439C340111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=BsPChA2L; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=V07wJuk9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 439C340111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:02 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQBVnl2633215
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=rTi4m/2d/OfzrGWpZyvWn0
 8lu69GxA0EMZ0OojRCIvw=; b=BsPChA2LqSxLvP50PgSLCz2qWmUOp9bQIB65hE
 P0JCb3FRdTGklns56m3qUekcuBZ7Oft95SciWus3S9IjE63/LMpH9fAudKluKMh5
 hWz17i1opuHvTrLEAhIrCp0ClamJmdQ94P8elN/D0ZBGqtM+wJTYnuYEi8ReF/dF
 PpnsIDnezyw1lXn1S3G4zGCSoycXW6FUZE9lu8GnS+rcW3V2/08XCUl2LCNhVld1
 QsfQLh+WJb4vtgccryIY0jOLwwZZitm34qU+yGxkoQzyUp/EQzONmne3NwukXR2S
 /ckmN91B2xYOimoRptiTRa5lZo0RpwOzxiyGtZkHxGF5vfdw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne1dxx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:01 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eab0467c89so7414965e0c.2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703460; x=1796308260;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rTi4m/2d/OfzrGWpZyvWn08lu69GxA0EMZ0OojRCIvw=;
 b=V07wJuk91WngI9X3sH2kzEYX58vZL9TRBm9DIs+ueRy/4YUrJmxnJT2ev22t40UfoU
 kpHPqMeeEel/+G+JTAu/WBpSdTc92BszAHeyZWSVMgBJw8H8lhHLGYUP1uft0VmvdH3F
 2mwEM/aNMmHkiyyZskiWobiSc1ZAvFzFr5ymI1rXSMOCyCXoxwbmbdUTf61z1EGxDf7p
 C3Fu7EzXOiQtq+pObCzRYDqGVGaVBPj+8GpqMX4uGkOHFBzZOgtCleaE9fd09Uh0QjLH
 NI0HULgVKNy4FP2lT/hBAzLxf7/rLO6c2FVsrik2EOB790pa0nNHdJjwBkqOByuPWLl8
 pyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703460; x=1796308260;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rTi4m/2d/OfzrGWpZyvWn08lu69GxA0EMZ0OojRCIvw=;
 b=dCPMXrgfv1IQPOLndXa/v7wpb4yaUn9Vh7cwXVercjAxfuM29i0GD+iLo8nm8zJRbB
 TNrZUej7AzO+q6KmZSpESTWGROL2/hh9UPnLUFPpHiJsz3nqNEmeva5a6GQpLrVZeJE8
 kr6IkCKaBxvbNuweRz2FlQ0u60MhvTnCOSufk8iimtDIcRswh4PDsITWP5ggKMgl04J6
 dwFclKnHlEXJxqs6djTOivqZ95OdSs6lrkaRkDo7xYFtR5VvQzojpSdXuamFWkHfh1Ch
 WgqVPO9Azu7rq5qXmBIRA9Rhq8sAOJST+9N2yTRe5Wc3XqAylsrSMKKYiM+Soq1WrgS7
 wUgA==
X-Forwarded-Encrypted: i=1;
 AL+hErGQGb/SSu3Xed54va0PRIPSF9x6nkC5K9khCu4T1otq9lX9UaOmFBfeN5CWrLgDPh1Tv6Zm/UY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+/KiUESTqp9Ljc4qklUUf4iuZJEvOpJacVOL7eM7VQEYIe3rjP
 LE68lq4Z/qyoc4hb/6vKn/nQKK60oKR7xkMWzauUjUxrhSHEQ7psh5qZt1GR5jHc1J1WPeaNddU
 o+88x6HqEEPBEs4/yla52lKbiuOUtR6k3rSIGf2lk7mOa6/g25wv/qMOsXv/MOanG5cpGKKg=
X-Gm-Gg: AZFdTZdfykJGJH67i4XIJ4Gc+t2rwAz5CsNpXdXTo2A4B/SNl15CKWemAAK8YrvHNpj
 60EKryUf718XkyGGIBS4y+zkkSwlHeMB5fgh5W0vFItKEedtQJBNsfstcT97/p/NJww2di0e6/a
 M9+nTBMhHYK9Tj8gmactXBcWmeAGWemf1qWy9CmLoXB3Bvxz5a6BrUztVQ+A3g9kGCQybpsAxn6
 99QmFj8vh8yI7swsDk74QWmAokKaNSljCh0AoHk4ShXUZBEN4GM7g5kNDg+pFZ+x/i3MWgSNqWT
 cIF2ZPgjCLtgJciPuOVaHTizzx46Hdt7lbDEh22CiLXx9tugu1P7xTXBjUGRZLxxShueYrQHlql
 P0KOkHOuP0jef6dg15wm9fAWHQTAd2xWu3ZfUWG6Py2gYVK9ovi5+ehiESPp+ZjaV7OzLb0oIjy
 zljYWDu22+slia
X-Received: by 2002:a05:6122:209f:b0:5c7:fbb5:6ea0 with SMTP id
 71dfb90a1353d-5ee8af0c762mr12895956e0c.4.1795703460236; 
 Thu, 26 Nov 2026 06:31:00 -0800 (PST)
X-Received: by 2002:a05:6122:209f:b0:5c7:fbb5:6ea0 with SMTP id
 71dfb90a1353d-5ee8af0c762mr12895891e0c.4.1795703459629; 
 Thu, 26 Nov 2026 06:30:59 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b03723bsm753575366b.87.2026.11.26.06.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:30:58 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v3 0/2] mmc: msm_sdhci: drop the 1 ms delay after every command
Date: Thu, 26 Nov 2026 15:30:56 +0100
Message-Id: <20261126-msm-sdhci-wait-send-cmd-v3-0-cf38d2d321b8@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNwQ6CMAwG4FcxO1vCNjbQk+9hPADrZIljSnFqC
 O/u4OJF46XJ3/z9OjHCwSGx/WZiA0ZHLvQpyO2GtV3dnxGcSZmJXGieyxw8eSDTtQ4etRuBsDf
 QegOFrKQV5S4VBUvX1wGte67y8ZRy52gMw2t9FPmy/W9GDhw0Wl1WpuGqUodAlN3u9aUN3mdps
 IWO4sNxIX9zAnJQBpXERhbW6i/cPM9v1Vf3NxQBAAA=
X-Change-ID: 20261030-msm-sdhci-wait-send-cmd-4383f2792022
To: Sumit Garg <sumit.garg@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, Sam Day <me@samcday.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b0842a5 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wzO0mAoEWfedGYpSfHEA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX38EQw3oi1QY1
 hDJbnIzatslq4Lg3RU0LVj9MORwzZSNWEuVdtPkBEqlyXRmMADkbbg2bdTvBLtfPdSmGiL/riWL
 hmCw2Kd07yV/SzXZFaLFdpNSkAYIQcNB9BtAr7TFKn0nek/2zUB6Wn2Sv80RqSPIz+Lj9izJ09o
 Radl4Ok0QV0i6+PSTLNqImlF4fF2EblEijMPDlAaKBjoGqOW46c74SdgmVEIheP/8g6JF4Gtj82
 3jRgB38LuPs8l2lZ61YcYDEcok3Dn9lpoBcaVDd0ZlKfOjcKZoPHiXnRAtbzoCYvK/puMImIs3y
 Der+v4xXQWaHr3JNLz3C4xt6tKmH7u6fxE6C6z/Pn7HeK5VtduvLRM9d8gvp5QF5vu32dNEo9Cg
 Nb1zLHkietTi3K60yJZphnmDAr7NqvNMMU0M8Bz0+x5F5tWZcsPLNnPB+D/byL+hyN+Y7KQFb3x
 e73I2ZmJeuAB0YYajGQ==
X-Proofpoint-GUID: oJJv1NYh9aQZy6hbVuFtbT9ihdRUNbT9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX2Jm9/nr3ZG5B
 /kfso+Iltm3YoFEqTinkvNRV2Ohh9sAgOkqsyvBDxIxUNFlDWMY7nD7pEmRTmD+XWjxoc8z92Ka
 jOA0deWDU1PSFAWtxAK2oe+dVgcpRto=
X-Proofpoint-ORIG-GUID: oJJv1NYh9aQZy6hbVuFtbT9ihdRUNbT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260056
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_sdhci sets SDHCI_QUIRK_WAIT_SEND_CMD, a 1 ms sleep after most
commands. It costs 2 ms per multi-block read and caps USB mass storage
on an Arduino UNO Q at 46 MB/s instead of 201 MB/s.

v1 only dropped the quirk. Stephan Gerhold found that this breaks SD
card detection on DB410c, DB820c and RB3 Gen 2: the CMD55 after the
first ACMD41 fails with a response CRC error.

Root cause:

The same failure exists on eMMC, where MMC_QUIRK_RETRY_SEND_CID hides
it: the CMD2 after the last CMD1 fails on its first status read with
INT_STATUS 0x00028000. Both cases are a CRC-checked command that
follows an R3 response.

After an R3 response the controller keeps a latent command CRC error:

- it is not visible: INT_STATUS reads 0 before the next command;
- it does not expire: the next command fails even 10 ms later;
- it is removed by a status clear issued a few SD clock cycles after
  the R3 command has completed. The clear sdhci_send_command() does at
  completion is too early.

The quirk worked because it delayed that clear by 1 ms.

Testing results:

Arduino UNO Q (QRB2210, qcom,sdhci-msm-v5, eMMC, ADMA). A status trace
was added to sdhci_send_command(); the identification clock is
188 kHz, 5.3 us per cycle. Each line is the first CMD2 of "mmc rescan"
with the quirk dropped:

  Without patch 1                                    CMD2 result
    as is                                            fails   6/6
    50 us .. 10 ms wait before the CMD2              fails   3/3 each
    final clear of the CMD1 delayed by 1 .. 8 us     fails   6/6 each
    final clear of the CMD1 delayed by 12 .. 32 us   passes  6/6 each

  With patch 1 (85 us at this clock)
    as is                                            passes  30/30
    1 ms wait before the CMD2                        passes  10/10
    10 ms wait before the CMD2                       passes  10/10

The 1 ms case has the gap of the SD ACMD41 loop. With patch 1 the CMD2
is sent once per initialisation, without the retry.

Both patches, no trace:

  eMMC mode                          HS400 (200 MHz)
  1 GiB "mmc read"                   302 MiB/s
  CRC32 of the first 128 MiB         same in U-Boot and Linux
  Linux boot from the eMMC           ok

v3, each patch by itself, same trace; "CMD1" is the duration of one
CMD1 in sdhci_send_command():

                                     first CMD2      CMD1
  quirk dropped, no patch 1          fails  10/10     587 us
  patch 1, quirk still set           passes 20/20    1586 us
  patches 1 and 2                    passes 20/20     674 us

A host that keeps the quirk waits its 1 ms once, not 1 ms plus the new
delay. Both patches without the trace: HS400, 1 GiB read at 302 MiB/s,
Linux boots from the eMMC.

Stephan Gerhold tested v2 on DB410c with eMMC and SD.

Not tested:

- SD cards and other boards by me: the UNO Q has no slot.
- Other SDHCI hosts: patch 1 is in the common sdhci.c.

---
Changes in v3:
- Patch 1: the new delay is an "else if" of the
  SDHCI_QUIRK_WAIT_SEND_CMD check, so a host with the quirk does not
  wait twice (Stephan).
- Patch 1 stays unconditional rather than behind a quirk: it applies
  only to responses without CRC (CMD1, ACMD41) and lasts 16 SD clock
  periods. Say if a quirk is preferred.
- Collected Tested-by from Stephan.
- Link to v2: https://lore.kernel.org/r/20261123-msm-sdhci-wait-send-cmd-v2-0-5de53eb34ff6@oss.qualcomm.com

Changes in v2:
- New patch 1: delay the status clear after a response without CRC
  (SD detection failure reported by Stephan).
- Patch 2: commit message reworded ("after most commands", Tanmay) and
  shortened. The code is unchanged.
- The Reviewed-by tags from Aswin and Tanmay are not carried over: the
  patch now depends on a new sdhci.c change that they have not seen.
- Rebased on snapdragon/qcom-next.
- Cc the maintainers of the boards that use the driver.
- Link to v1: https://lore.kernel.org/r/20261030-msm-sdhci-wait-send-cmd-v1-1-6ef678db1585@oss.qualcomm.com

---
Igor Opaniuk (2):
      mmc: sdhci: delay the status clear after a response without CRC
      mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD

 drivers/mmc/msm_sdhci.c | 2 +-
 drivers/mmc/sdhci.c     | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)
---
base-commit: 36d2b7b46c77b44021f0a6f36684a123e5560492
change-id: 20261030-msm-sdhci-wait-send-cmd-4383f2792022

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

