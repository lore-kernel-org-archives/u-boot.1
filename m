Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564E606A336
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=drL/0+O8;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B4Vz9bBn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AldCQOHK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17D8581175;
	Thu, 26 Nov 2026 14:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 48726FHq6t0A; Thu, 26 Nov 2026 14:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6553A81176
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795703472;
	b=S/UZOoX/0kYM2ZsicjD3ZKNbVoTy3Szl43krtXMYvDa3BwYX8gCpBPVevsR192eXXcgV
	 DER8xrrdno1JYhnreIRDkb01VufupKcvqFjJC6qQm/RjHkaSN46oSBv/8IDdwVKntt8Iq
	 GWoq0roo2VymqhXheohK65PbEsR+mv7ks46Pkouw7NDqbctV/EOfhHOTDXJK4y45KK2Bt
	 hSNESvHq2ABF1xawWa3mU8lvp+Z/Tw/94svXqVYUmNGk7z5T17JDaJUHscqKS3+LX05LR
	 FH6OMhA0E9Kvo20PEpDHGxdK6znfzMc+Yj5KBDU24v1MI6Ypa+POPi/sF0I/Ro6ICiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795703472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aW5LxFuAZqpev774fiKjWSq5LJG8MrDbHoGMnyxyN04=;
	b=sjjM3+Z19fZbk5X8Q9JApqSVmf+vpO2YXY4O9ZYKoy0EsoDdn7J6tk/vF90w5mEBQV5+
	 67j1FVns/GxpbxbsmKy2X1XxRxBqfnfbbeRRwoxwzZ41Ivijm9CPnbwLUrQ0jZsmAlLUb
	 KuMUONwqAk/+HzPqStXzzBXxeiBry9yZPf2nWc1aM9MP183nOi6yWIiPazw3ATSwpbCWh
	 S9VZp+DrUBdzwgiKSguSJt5nhLK6tCqpXv4zZg8n4wqjQdaPRFj3ewL09BKJp1Y2q0Slf
	 VTYbhU48sxdZtCvM7oT+WliaYlb88DzCbpNnO7s+CVYVUpJumoai15u6ya/FjWSDW+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795703472;
	bh=aW5LxFuAZqpev774fiKjWSq5LJG8MrDbHoGMnyxyN04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=drL/0+O87MFV/PvMk7MjfFncYlMZ1X9OgqITt78/lExZYYLLEdfeN+ERYzNaLhT2h
	 y1bVjsCu9didZCowSxfOVOvyGtuJu0DzaLNVO/+pMmEUD/DBw+KNOGpKFCndm5A67T
	 hJXN95gVtv0Jdt9Wj+Nwlw0Iq05v1xMHsNIqIY4XdzrDvUOSzeMZflYP70I+147KtI
	 p7EqGtzT9FnT1r+lXqlLqt1IJlZYVa1ZJBYNpJ0wRxvJEHynxLHheK+1+own5iAMWF
	 Hl1ZtL9E/z2mo8fCTDnB9/eIM3VX9I2cwcMB5dZppXR/hdThIthvLV9zzn/RxC6Nvf
	 BnjJRsafz4nkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6553A81176;
	Thu, 26 Nov 2026 14:31:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B459B371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A1DB404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UOTHc0hnPx18 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B086440111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=B4Vz9bBn; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AldCQOHK
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B086440111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:05 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEV22H3170951
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aW5LxFuAZqpev774fiKjWSq5LJG8MrDbHoGMnyxyN04=; b=B4Vz9bBnUZI5syxE
 MhR1v3HL+wUAiw1EXaIygRRNIRnetUjLt+SWM/R9lvvVfgXC+gX3QLGlxmQgcXVh
 sqfPurhTzJUXMgNI+1zPNPNf8SQ0b8vOKY7/YY6/WFezG6Ehb1K/wPZ8ThQSbBzz
 VrnVJHZt+jLrnkJhpHIfMqXZpIlGjnqbF/ncd73oeqtlUH+bWyC6hs73m/CpBrD1
 TNrgszQacswrHuBLguLV3lc8zSSIFly2YpwpyatGKyFUz/4Sd1Pni/afq8psSLTS
 Ll1sLVXmOO0XY2fVmedwK065yGHk4VqA5yCWPl3tsrJ8i96Zt7GgkHr0HNsuks/q
 XRRSXw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j66qfba75-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:04 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4ea2c058e67so7561310b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703464; x=1796308264;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aW5LxFuAZqpev774fiKjWSq5LJG8MrDbHoGMnyxyN04=;
 b=AldCQOHKo4coENY6zgQPcWpirCDkvqsDOV6EgFtuk0vww6yIeTZc1nuM9VnxIrRVsy
 hD5DWNXEIlr2HCuRTGOOmfllcbJsJL1AxedTaxFEsiZTveNEXR7w6bm82+JhfzzGQm4n
 wulou3olHBuh3M9+3HlaTM4VzkVGOk9igXIIyR45e7W2wA6tlQ4/wU1sag0JOmFatrs1
 6bspScKslL45MK8l8l1lM/2MmmOXWI5/XQKPXEf4zXtU0xx2qtjedTjSiIYzvWF+84rS
 Dmqtvs3jqo9TmTP8Rs9UIvzgKNpCimXK6WuqQ09LYJj9aulq6vZAqhSn2nP2DQMaCHc/
 Ygjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703464; x=1796308264;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aW5LxFuAZqpev774fiKjWSq5LJG8MrDbHoGMnyxyN04=;
 b=zCsLw3eHRypNnmrg9rgQBh3AAzghRM5sFamM2Zd7l2+U+ojEY3NWz8cqTZfq7xt6nG
 pSBp7gFFXTZMQaWlfxe3xazhOxg4aQwZwbZvD1iXze2njvFllDuesERzWnrNRiMUc1kp
 CXpeR16filJCd8IvZggSFDFK+yh6DU5L8BHbALn0efExr98hBAwHmE0ZW4xx4r5VS/zU
 ewJEI16Kgk7QRnlqmnBMdsHpPQMnIYqU2hJd88OIzIixOAvVfvGHGqqJIZLnIglChHCe
 +VIspsT3LNZA47m+k8Tr/dJdED/8Z3NmtQKG+kbwnjyTE82CpS5iaDxnx4UqwYpSISh4
 cxVg==
X-Forwarded-Encrypted: i=1;
 AL+hErF+FivUMzg3zkW+jZTqOnDImDn1O0/F3udiq7vXfResKbUeEh1lScw6ZoLwtgF4Yg715nXlv3A=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+gHCdmwrG8Dv3Yg0duYLXkv80Rar0mr7pd44ExBXpWO47ygOd/
 HfJbE28ep1uzj7sgWtC9wbsFQWouDSEMMNaB/zoKWjekH2IgXqVsn6xL1O91Ng92eZgHCl/qgSs
 8zlxmqX4U7FvICmJA6ijRdeS5Ev+8bPhQa7HQcyoqqBYgSj6s/vheIS1EXuK290GewGDzykg=
X-Gm-Gg: AZFdTZed+7AP/iwNF9Kt+vkyfCnl2iDj33v2OSzV8EgwkWYCKn/E7CBnv+nNpZKYl/9
 UOQlpvFeU9G8g+QArLrQK79Mgp+lrHFhA44+V+c2lcCuoChTGXJWA00wO3tv7OBaawRXKS5W2Xk
 /6z0eOhI+tVSGekg13NqDnqnBJFzuCGJYK1I9KIWOQ8t2FXz8ulgnZu7IAeRtjqs2w7If+OHeV0
 DuQusSOEl6eP/SLdcRi37N5tlaR/oKSEnVAL8JgUtJnOJdMNhxwvog2nD9ahWfqBBFKl2I+Zg/2
 OMjxrY2LosRddPD71zimXZ/1bEb/AIq7XWRtML1jLCk2/GpDcoK6qxs1NUZwohEZbFPvHkQhuBV
 UuZXF6PTff56JOtIyO1OYzn5Ddjtl5lgkw1vbu5CsGGQAevw+KTEI3cvINtno3nmXYR6EdvE79v
 I7TFopXT1KCXod
X-Received: by 2002:a05:6808:f13:b0:4e9:df3c:c45c with SMTP id
 5614622812f47-57a09c0f808mr20852323b6e.19.1795703463894; 
 Thu, 26 Nov 2026 06:31:03 -0800 (PST)
X-Received: by 2002:a05:6808:f13:b0:4e9:df3c:c45c with SMTP id
 5614622812f47-57a09c0f808mr20852267b6e.19.1795703463342; 
 Thu, 26 Nov 2026 06:31:03 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b03723bsm753575366b.87.2026.11.26.06.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:31:02 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:30:58 +0100
Subject: [PATCH v3 2/2] mmc: msm_sdhci: drop SDHCI_QUIRK_WAIT_SEND_CMD
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-msm-sdhci-wait-send-cmd-v3-2-cf38d2d321b8@oss.qualcomm.com>
References: <20261126-msm-sdhci-wait-send-cmd-v3-0-cf38d2d321b8@oss.qualcomm.com>
In-Reply-To: <20261126-msm-sdhci-wait-send-cmd-v3-0-cf38d2d321b8@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: ErPtrngGw-ZM2pZbfS5RmIZMDpaxz6yz
X-Proofpoint-GUID: ErPtrngGw-ZM2pZbfS5RmIZMDpaxz6yz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXzO6vFjDrV2Cg
 Sol9Ne7OACxxKo35grIE+3RBUpjmqxsb/F0vzsdB5wOd+MHj09qgfro5aq3kk1UJr/OB1vGOqT2
 cBTwxlcK/4irSJF4hPa/F5W+jrcYgUE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXzgcTK/bHsbHq
 NEdNs9x2g5hw71VVcfYv1tKMzLhc6ZOTITRDuZyFKp+7LCx1u8I7HA56rj8IvsnbkSfRY0Ocaoz
 Jb9HSZ07C8sDZG0zoGseAFKfAfbThXPnTHPQUAE/BPvO3g4m91FoA5th5LTwIE0C2+Qzcwt3i2F
 m3rMBTeDXNTH6THjaCbvlflc0xCHR+8uFJ13gkeAfvFbF9rT0A+CRXWuIhoMmZaKSLg3wnktlcp
 NZQ6inT89P9RdfSAx+UU5re42mXca5i8ph2UUj4cIBku/LTg2nzmDBLplWaW+P44ukwNh1JJNqR
 iGmb+92inr2j759+zcVte4DLkT0I39Qqirk3ZybSZNnLduqtWnQovwUsAlH55s3l2zAkTh4imDW
 ZGKs2k+fgjyo8NwkWiuW1Mgb9sL911eszyH5AU4cBFBrymBozffCG2FZ5HfWxeWWFeaRQ03sfVt
 VQrSD67uq77kz6gPvjw==
X-Authority-Analysis: v=2.4 cv=Q5VHcI2a c=1 sm=1 tr=0 ts=6b0842a8 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=T-8G4zspr1_uoGV1AJYA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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

Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org> # DB410c eMMC/SD
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

