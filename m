Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A4606A32A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yfb96lVv;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eBbYM3BZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bRBckGpI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB5E080D8F;
	Mon, 23 Nov 2026 08:57:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 39UJ9JLKIzsG; Mon, 23 Nov 2026 08:57:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CEE080DCE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795424248;
	b=px3CtxkRPOuP8HiCrALD6Z0astsKEfAF2iWpqUF++HzqcZXIc92wQt1eGAx+M4Jv4fEI
	 r/aibTKIBO/qJTAKlcUeJDGxG/utL7/BjBSKcIBB9bzNPPiXblEFSld8IRLAeuYQDPqpi
	 btHl95NT+5FB4vo2/6IFJ7XS5LSIdyygjdVtLJChVt0Degm5TJq+JcUr7FTLyy7A/l8QS
	 IASDHA8oKsyppaPhYsDn7B6ZtKOdQrm1Z3iJvSNbNKarE9jvs2w6jYZB9NDkolEp0xkDZ
	 JH5Fbb4qn/qjBsNguwvQj7LD4kZE/jMQSbCqvmYK0ZpcOiI/5Y8/qtg3sd7/S6BE5eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795424248;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F06bceTIIXZlV3aLskeMs071O4jDwGq7hw6INNHitro=;
	b=BA4p0YJyM0AeYG4XRekTZGrQskibhroDCDYJTZM0crXkrnBWWJmeJE3oBsn8tPphtDiN
	 rMmBWkS9wQX5sGTdZZcF7wquf8DKv5UyfpQOUYhSbPrUKD3e4E1K4PL/nnroi/5TB+Gnu
	 rr/TJjPM+lDNyktzL1UODr6MssUOpd8rEQYw3dTSCCpG+8PNZd3dIy2yFn49zVhgnQHE1
	 FUjgKJXPmWLyYWLz/lmOZ0RWtHrnqzOxO83RjtPLcc2iZJpD6ihEl/pIZi5pRKQgbafuT
	 3KvPtLckDfdp0CNCSasFwLSxO/PCEQbicFbRBwQV3cKCSxh4kjX6liQaozLH269fGig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795424248;
	bh=F06bceTIIXZlV3aLskeMs071O4jDwGq7hw6INNHitro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yfb96lVvcn+TRVCBrJEcWXlTCAgRAI22DaMBEQ6Ia5C3AWKQhMZud2jud8btr2HfI
	 6taMkmpCwjJKjnzUoODnqylXBcvTcIEw+9CqNAdW1zsTbr2Iq2VmuM6BQQ9dKHVy/y
	 SYdVCe/nAKsdU1lvD3rc41eQWGxiiFOeYAPa/tmAknnGUP0Av7vmTNztWcN7QJxX+M
	 +M/p7Ng9xRH3+0JFvtJGFgKbbL8pnMOns9F54t2RujhuGCXSIG9ZDxuZC9Ph9ieDil
	 sBw6R5C8H7YTVaBVju3DFm3zTOmT2NOAqFlLVEswTKh1B5yD/ydMhIoSBwF1pPtWp8
	 WoT3zar70xvIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CEE080DCE;
	Mon, 23 Nov 2026 08:57:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E15D3260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2F1240660
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7UBbeDldl-uu for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 08:57:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40B624064E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=eBbYM3BZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bRBckGpI
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40B624064E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:22 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN6E5gI1422768
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F06bceTIIXZlV3aLskeMs071O4jDwGq7hw6INNHitro=; b=eBbYM3BZEuWxS7en
 ogkW2LAqAMAskAZ/NNSoT6xuH+YZRjLngIVZJ+UQtl51m9oxxq7e0z4JOaOeTuJa
 WbkMmceU1DOkUteOBHVGf6EU7JKHem0xL/qPpM97KFGwvI2l4uIYrDmyM692AwNN
 PSYQ8Qsy1iThwWXTyJ4CCZLuFVqVM8QemBSePC3lKwRFtx05bJqi2hkV/6rbWQEa
 bK4unSotd3cu2PzJFfA0TKzyDgea5e2SgncBMnswEemC5R4UsPVid6sHoxhJs/OJ
 eRUUR8EKhLOvKJZaG66G4XhK9TaOeSvI8W6OGwv8MBs6qn4B8MRKEehY3A3YLSSy
 5ebhxw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1p8j8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e92aad34aso559004985a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 00:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795424241; x=1796029041;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F06bceTIIXZlV3aLskeMs071O4jDwGq7hw6INNHitro=;
 b=bRBckGpIU1P6lPiAaln5gAWfVvg3ZPUeBCFEAfM3Qgme8GI0VoYoHbPcZM7WTT91yk
 I4ELLiZepoWWte6z5+Y02qv/Cc7vCYoLRBf+K9yejI9AYpMA/8qre7ncLb654VNdzpPq
 nXCsSyQR4mgqoBg8Mn/kKUoAC53mi4W+ngLCN0THJ1FcJPNRdYbzX0YUpCr7m8OriZoD
 pQkb23NykIVOwejmIjdO22qOnduWLaHu4Tc4HjK3/Uk9gYt40J82cOmrXyb2KQmcXDv3
 nO1EvKOnWBgWGQ6ZtwEf2zOffhLddJ+jKuqkFXJNdejurkCqv7mA+pJ+V/F+lbJTbKBA
 0tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795424241; x=1796029041;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F06bceTIIXZlV3aLskeMs071O4jDwGq7hw6INNHitro=;
 b=IdKrT867pVJ4p3SLtvNzGFfSxtDIaweAv6/UyHxbHrLKPkYE3rJKrRE3vaEpzWiMhf
 nKsmfT1iFl9ZYxLUSR5mtC6oxrVmaO9oGy+qRta6FN610tAYk+dHrg+prwPlM3HsVa8J
 2jZmMOSaCXsiMsW5waDvCY0cQX61nNfdmmtPuAX2Q/P5DPQHnhXRNVxVi7I0ep9IV5Lw
 a85uR1KKdB81cmS1HdsIS3qSNrGIdt4YS6uu92FKCbiiR84lpexcIY9tUQgjaLB7MKNp
 5B4mU1lejnCCXRQ1Zu0nu1hLBDvoqhYnqxdjEuWcO970HSyQjMsN0CVQHaxwps/3lwmS
 GsFA==
X-Forwarded-Encrypted: i=1;
 AL+hErGTfIeufMZr1l7MMc8FMhSxkLnEGKeiarKM/wXLcpGH/WnyEqF1l6c305wqkn2R4jmAqlL6yKw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9tTz8Oy2Uf5HWHuPKP+umM1tKjR5bb5clBiaz3/gmeJ9u4IKK9
 MhTbcv6RaP3rNqSIPwXnfFRcDv/P5IvFjW2nWEXxOBuEutubMMR0/XflbyyQxLPjUfSfYBiq5Wi
 X30rz1pY/BYzmnEB+hFAu3b5FgvJLnB1T3O/YV52Zz9QL5c+4taier8SUWkBBwaGKlyPhx3U=
X-Gm-Gg: AZFdTZfMEw44aKCD/tIzy3ZPrVD+TfKojOWhsL8KCdu/XJ3iUQDAxXZZS9b6NXkO4qq
 +lA4qwTEI6tPQa3CGXfZebGkVsrs37jCGDe6syKX8ugvfs5NLjjFAlH5/jBBEIvFanvu/UQPaze
 WjMZh0fKxpmLcTttxTGezjAZ1buPxxer73FcHuMu4noYE03nSXXSOeQzTrNqVIc8xhjMmdnYGJ+
 5gS8IyICuYW8JS5DT0sRiXUaRLf1342JeTHbfotB5/N7bmtDJlIxtXby5NTP46ZNj2BiszyxWLX
 rcqt4sSKR2UUK+qFEX/nWiZ4HQnHzYhbzmBke4vlycp44pi39dOoTIuOB4mqP5CAPR3VEF9BfzM
 oqEp8pVZKr+75EHNjjpb7Qa54KWkOAgMalmice+kK+oFbdqgMy0f7QsrtqtGV/nZXXH/llpZhiV
 fYj7LhQaYyMjMP
X-Received: by 2002:a05:620a:2a12:b0:93f:1e3c:4a31 with SMTP id
 af79cd13be357-949bab5adf6mr1815788985a.61.1795424240975; 
 Mon, 23 Nov 2026 00:57:20 -0800 (PST)
X-Received: by 2002:a05:620a:2a12:b0:93f:1e3c:4a31 with SMTP id
 af79cd13be357-949bab5adf6mr1815786585a.61.1795424240466; 
 Mon, 23 Nov 2026 00:57:20 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc6fb3sm374976466b.62.2026.11.23.00.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:57:19 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:57:02 +0100
Subject: [PATCH v2 2/2] mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-msm-sdhci-wait-send-cmd-v2-2-5de53eb34ff6@oss.qualcomm.com>
References: <20261123-msm-sdhci-wait-send-cmd-v2-0-5de53eb34ff6@oss.qualcomm.com>
In-Reply-To: <20261123-msm-sdhci-wait-send-cmd-v2-0-5de53eb34ff6@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNSBTYWx0ZWRfX5LcplwGoQmea
 HptdxmypTCz2bxupP8ZqeUT3cxi7D2QiBPk3GzNV6IcCGUUzbUmvxGrVSqUmBZ9jM6zxwimMUVr
 rHgK8rJa1Gi4PwGnJZvqWkb+9iVbkqlCrC8S425xN9WnFX8GF+lmxEugcD/dxFHKWvXShg/h7Xp
 DncPj0GJef4krak/fbJcXYQONlVkptBkK68SJ04/ovepzaabAVvABT60zDKflPr4GUIk9Ydgk6g
 /T8pVLOo5q4jrx2EL0PdrpJyPj6x/Z0H6MTnKbqGOBYMqvboVUEtAsbK7uNJUchPhXZLry3iZR0
 6wUUyTlB4fhkwWuVjxSNq5gBO2Nwlpww8fEqDB48ADrTBao9lIVtWvw5Wqc5r59nmcEosDcyrQq
 /nruytTMuZWj4glBKwqQgMXCr+72+Ho0m6Ykxu7dGvK+1QR7nb27dA1n02nnEI3eaaGXz5vTe6F
 zTq7KKWjntvZ66H8+jA==
X-Authority-Analysis: v=2.4 cv=AeIkjHXG c=1 sm=1 tr=0 ts=6b03fff1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=T-8G4zspr1_uoGV1AJYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: _CRtXwkmd5fUaJ7-Hra0ouumsfw4FmFo
X-Proofpoint-ORIG-GUID: _CRtXwkmd5fUaJ7-Hra0ouumsfw4FmFo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNSBTYWx0ZWRfX+EfLNqG2VyjM
 FnbXfHNWquBrH6TdEOUZZQ2FY7tVzZP0cDkPPIO0zF7OyJEHCztxVM1bz96xj64OViIXQE2gmHS
 GkAQOBsKE96bsdEe++jv7mtWa6/cilk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230035
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SDHCI_QUIRK_WAIT_SEND_CMD makes sdhci_send_command() sleep for 1 ms
after most commands (R1b commands without data return earlier because
of SDHCI_QUIRK_BROKEN_R1B). The Linux sdhci-msm driver has no such
delay.

This delay postponed the final status clear, which is what removed the
stale CRC error left by an R3 response.

The previous patch does that for the affected commands only,
so the quirk is no longer needed.

The quirk is costly: a multi-block read is CMD18 + CMD12, so every read
pays 2 ms, while a 128 KiB read from an eMMC in HS400 takes about
0.4 ms. USB mass storage reads in 128 KiB chunks; on the Arduino UNO Q:

Test results:
                     ums read, 1 GiB
  with the quirk     46 MB/s
  without            201 MB/s

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 9cc11a5e269..ab217393a54 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -198,7 +198,7 @@ static int msm_sdc_probe(struct udevice *dev)
 		udelay(200);
 	}
 
-	host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD | SDHCI_QUIRK_BROKEN_R1B;
+	host->quirks = SDHCI_QUIRK_BROKEN_R1B;
 
 	host->max_clk = 0;
 

-- 
2.53.0

