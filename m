Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2C606A33B
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ws7LHtC4;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TBntRHKe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NdvMaElg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B4E960AAF;
	Thu, 26 Nov 2026 14:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kNLHpvyN-DVS; Thu, 26 Nov 2026 14:31:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4B5F160A7F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795703470;
	b=XFsYUVOsSGgUIbhmkLzr6K4RUmFSrz6FtD6zJ9CBQvCFPOXnfBhfkYAYq//eQabj5W1j
	 PQnX4tkbP4Q56QzgLp/Nv1hU1SjmbxJT3SNAsoih5xfBswmLp5YGzHzhD78gMXCuGOTJV
	 uz7/Or6NdPwVhv7+8Jm0gOnJVQpD93d6Te/wK6r2EUDgXcBaRIg2eDAVEwwFcgh9mvd2S
	 HFmOyFy66kcuayYLfnbe8SK2hUiMQV5i0lxVH8TZR+kA264y+7E/PRyJ6AfI2//gSpadA
	 tPMDbwmkpHPazR+oKyA4stEUUaTuX3X8Dfcdja2gGcnHClsuyOXa9TlNSvNNdRQ+vkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795703470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OKjdvMlG32QyAuJQ+k9HwyzQajL0gNhJJ90mX8y1Hqc=;
	b=p+dC/75rnAhjA+k+mADipKD5BhMJ8npi2oTEXUz+V5sNWzDZrfsQQ5V60P/b7oyzzSmG
	 8zPGvyA2ShTc4Wj2V49bMjmyEPG30Nx611bWX88/oDK/8c3j6Q6AloMjlVrg/acmRMYOU
	 vWDJVIMtmSOHIx4S3wxA9e5yol3tyL3AttuVx8Z/lIDnzzbYaGZtfuYhxyb0OI5aWTS+o
	 e5mzEHZMp09LpXbMaPeL2ghJVVpMftQHujIdrH8OWHquRX3sWi3MV7G1pMCAlFHDzE1bm
	 ttct+XPwwG/5wLe/VylJ4OSqAVTMbp2Ehri5YSkjh39wExv/uSqtK0UogsRLIicTgxA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795703470;
	bh=OKjdvMlG32QyAuJQ+k9HwyzQajL0gNhJJ90mX8y1Hqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ws7LHtC4baZbZrAJenzJIPu94jgiIj719CvKsM3N4vvu4qe031MhlHJ164rQS2uEP
	 RV7r7zNs8AOUe1S/BsWz+zS47ui374Sa9W0g3obC89qXxCgRSE3mynluL/ZaHadgcL
	 iKubUY+M8jzp6UGWwXr4OUaDADH09QvpSONMcPHYyeCcOr8iQvUeGZ5EkB3kzcpi3e
	 J9LrM53whtqOD4AyIzB5uDJ6QFq5SWR+5knt3plPblqbPDbifQJX73PWvyYGpB8975
	 7q2PDl97g3qCYChpfl2PuH79A+QWQBKBDBvAwb6NZW4h3uH45Y9BN/0jyqm6a27xkX
	 TaUgfY2gLmA9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B5F160A7F;
	Thu, 26 Nov 2026 14:31:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A63B0325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97BEE4087A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3fkPDiJA9vBn for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:31:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5E8694085C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=TBntRHKe; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NdvMaElg
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E8694085C
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:03 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQBVnb9633206
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OKjdvMlG32QyAuJQ+k9HwyzQajL0gNhJJ90mX8y1Hqc=; b=TBntRHKeHkPoEIJQ
 zqp5FyLnCHF7iVVAntuqeFKj1phcUVkA+sY3ndulFJZHVbDkgudkpM8xJ1F9adT7
 y5/KnhhAPBR6VQ91XuzpEMbzDIlYAfmDsRjbPlMtbVDERqOm/XaBE8u/iTIr/LqH
 LXGkLqkfJ5JvSf7LKUWzTFg3+ui22ntlcGO0VsuTXWwrV6UBA8yaOq/3TnYbyUtm
 jqdvvVo5KHPsax6eqML3R1D2sYJdQGW3S9rOVf7uf2CYZe/0feOmRgW0KPhlC9Up
 KgnnF8AGVDPdZV2DghHzyV5BwqNGhcb2gMZr5DWM0v5L7AQC7x1YKGyh72AXJ0gE
 hTSHeg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne1dy0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:02 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-990aa76e3daso1307970241.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703462; x=1796308262;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OKjdvMlG32QyAuJQ+k9HwyzQajL0gNhJJ90mX8y1Hqc=;
 b=NdvMaElgw2pvR54EL4aQu7j5X0xIQpuy7kshHGYtSV2v2zmRE1ttxtgPIb60v+ImDP
 2WdshzZ/KSsqNEeZFJi6syVDOq9r58oK8BPCrAPKUYwtWXb1yPngrYP+oyDHRMnNCUBY
 9uudgQkTkZFr8ApM291w+Yd9WhTXOm5K2gv+COewOFQEXnFLUrHJPARCiNOigxXj5aK6
 V1FS9ljrkHH6j1udFYuCbZV8470wbWaFwn2Hawr36RiWSr9gHHMuQA6V1bHDG5h6/ZEg
 g2NafG5h/o/tRew/7m2hA5/vAatNOqrOTrdxycAVnWnZTEBKRkUn+j8LJ9SESgQF4pJ2
 dl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703462; x=1796308262;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OKjdvMlG32QyAuJQ+k9HwyzQajL0gNhJJ90mX8y1Hqc=;
 b=oGbTKjoL7wzGcRa4Zvg+rCIOr6cmbTVnmFoaERS1xwLV4RoLMYtnt+85/NVej4WKiC
 8DrR+P4oaPnUBrOs4YyHstEuvphrwmZCDa2/z0+jULXaJrpPO0WGNz5/W/fxb4JwzCgr
 Z6DqCgiMSjuI6dq4hykltPrfHEztG3VQl5XP7cehHXNZL5wm373/xzXFg/Chh1raAJ6c
 CkYA1nOQXT2E99C/P7f/NO81MDmV2dq7EjKAhbyxQn7WSz5nBC30XwciQREh8CoubNZC
 tcMN/24brCYGIlVD2KTgfGHbJr4rdLIEGbnxzFSgL5v79g/3h5WZMD9Ob/nToQoLZXPI
 9EvA==
X-Forwarded-Encrypted: i=1;
 AL+hErHNpACgcKZ9WyVpq1P3EW2yJzcX36KIHrjxSG8/iHWqBRJVWzLsSX3quq8xvpK7tIioiQyyi8k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9eIfJJaoC/DumRbN7XK6RsJCFHr+lO4oZUhZKrP+u7pklqqjec
 QVOwYNET/NkPA5P5OXbqoyH/NYrPSFO8cPyQmk2OS7aIrKI1aY0ruZ4qdHgyUd+v+kM2kWW1AJX
 uIMiU1LQ5g/m25lXnUobWktadD/jW5TZz42qbX6UwTuXB07HYNtUe0VppLv1B/1B4pZtywRs=
X-Gm-Gg: AZFdTZepAesf8o7F2o3LoXLswYfkuIU9BqMPN/pBJWaOXsw0dvi9Q2lcc2XrdtdXGOw
 eu5uNs4h1IyyJxB7UjvVvQyE+x9DnVyf/Wh4T4mTgsXJbP2gHBxuitCarb9KtxwU1hxPIEAJm2t
 eS2nWuDVQioJyYtJFjwU7BQ7oTHIY4Jg7qcNn0uajBkOFNDTcMAiyxmfmcHeGOp648ouwJWPhwp
 0+JWuSXMWk5TRfBJuU8BfVrKdV16CyetDYAXSoDcTeSXMTJLmydhtEZshh5TTiMRC/MFC80FHDk
 jjoQ+wk5TDsd9T3xBSxap58W8btL0JjrW91D8+EXXMMu/Hu4Oy9ByGonc6fIHvPT5UZFIEvQhce
 2HMESy8M3Iy2iKMrS6PE+2uJCUzm8Yoj8jxUTsgzLONKBnxq79n3/rZc/K7vYfaMxfyiMTPiasC
 MbU3zWlCaSQJ2P
X-Received: by 2002:a67:e713:0:b0:7cc:1192:563c with SMTP id
 ada2fe7eead31-7d7395edf5emr11030653137.25.1795703462074; 
 Thu, 26 Nov 2026 06:31:02 -0800 (PST)
X-Received: by 2002:a67:e713:0:b0:7cc:1192:563c with SMTP id
 ada2fe7eead31-7d7395edf5emr11030615137.25.1795703461504; 
 Thu, 26 Nov 2026 06:31:01 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b03723bsm753575366b.87.2026.11.26.06.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:31:00 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:30:57 +0100
Subject: [PATCH v3 1/2] mmc: sdhci: delay the status clear after a response
 without CRC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-msm-sdhci-wait-send-cmd-v3-1-cf38d2d321b8@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b0842a6 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=2diJqn6QHJFZazVFkGMA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX82w+B2UfTxl2
 fd5T0l1ixBjEH54/fqBtdHyB2Adoob15ojlFrZJCLJgLMEaP/7P5D5Q6k3W3fxOneFNPP32NGRO
 TSw9dSZIfagz3XpBb9LmMETObkBP7rPAPBAYpdkZUsbZk5vSz8YA4UCQKr1IS/fyX43+7nhjbud
 F1YW49b9pVLBuphfJNng81kGJZsrXHccSRu1czrk13FC7LtCN/73VXXT2GFoD0pYwsOEds+AxTM
 5xOrmM4KspG6Yv+Dcd4DIIqcNofIlZnrB2f/7i8sE5UI5gd00/y+hrNMgOZwwTEIwPo0FIsd0Rl
 PVzozsc1s2PmREkcFq5djN7GTwxYMpiCGH7b0RXjGHIFENNnLIVMnZ3RY8KzlGaYw2nQ628tgSR
 BQPJc+PKL7eVUaQyvEklO7VVQHsh9sAObS33Z2uJXFfO87r3Clxnj0IbdyatCAV0l5oc6S8+xbA
 ogHwv0TYwu3UxQoymeA==
X-Proofpoint-GUID: LFk63MezpTkv81KZrX15a6BaDl4PFCS9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX8deuKcmvvEKF
 n9trW4FlbzxgDIqIJ9zOJaMUNQQa75J4QB6TEr+J3Fq+8roMFTKwfSOF+Gxrca/FFJPtXsvwlJy
 N1jSWps0GK6iU8R2TY1m7xOcmpRoprw=
X-Proofpoint-ORIG-GUID: LFk63MezpTkv81KZrX15a6BaDl4PFCS9
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The issue was observer on Qualcomm SDHCI controllers, where the
first CRC-checked command after an R3 response (CMD1, ACMD41)
fails at once with a command CRC error:

- SD: the CMD55 after the first ACMD41 fails, the card is not detected;
- eMMC: the CMD2 after the last CMD1 fails and only passes on the
  MMC_QUIRK_RETRY_SEND_CID retry.

The R3 response leaves a latent CRC error in the controller. It does
not show in the interrupt status and does not go away with time. It is
removed only by a status clear issued a few SD clock cycles after the
command has completed, and the clear in sdhci_send_command() comes
earlier than that.

msm_sdhci hides the problem with SDHCI_QUIRK_WAIT_SEND_CMD, which
delays that clear by 1 ms for every command.

Wait 16 SD clock periods before the final status clear of a command
whose response carries no CRC. Only CMD1 and ACMD41 are affected.

Tested on the Arduino UNO Q (QRB2210, eMMC, identification clock
188 kHz), with a status trace in sdhci_send_command() and without
SDHCI_QUIRK_WAIT_SEND_CMD. First CMD2 of "mmc rescan":

  Without this patch                                 CMD2 result
    as is                                            fails   6/6
    50 us .. 10 ms wait before the CMD2              fails   3/3 each
    final clear of the CMD1 delayed by 1 .. 8 us     fails   6/6 each
    final clear of the CMD1 delayed by 12 .. 32 us   passes  6/6 each

  With this patch (85 us at this clock)
    as is                                            passes  30/30
    1 ms wait before the CMD2                        passes  10/10
    10 ms wait before the CMD2                       passes  10/10

Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org> # DB410c eMMC/SD
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/mmc/sdhci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 97de02c262c..76acbca405b 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -343,8 +343,17 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
 	if (!ret && data)
 		ret = sdhci_transfer_data(host, data);
 
+	/*
+	 * A response without CRC (R3) can leave a latent CRC error in the
+	 * controller (seen on Qualcomm SDHCI) that fails the next CRC-checked
+	 * command. Clearing the status a few SD clock periods after the
+	 * command removes it; SDHCI_QUIRK_WAIT_SEND_CMD already waits longer.
+	 */
 	if (host->quirks & SDHCI_QUIRK_WAIT_SEND_CMD)
 		udelay(1000);
+	else if (!ret && (cmd->resp_type & MMC_RSP_PRESENT) &&
+		 !(cmd->resp_type & MMC_RSP_CRC) && mmc->clock)
+		udelay(DIV_ROUND_UP(16 * 1000000U, mmc->clock));
 
 	stat = sdhci_readl(host, SDHCI_INT_STATUS);
 	sdhci_writel(host, SDHCI_INT_ALL_MASK, SDHCI_INT_STATUS);

-- 
2.53.0

