Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61411606A331
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ykrW0EV6;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LIABUw+q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZaAOlQui
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1450A4066C;
	Mon, 23 Nov 2026 08:57:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iGd9tjwAY77Y; Mon, 23 Nov 2026 08:57:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4E10140660
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795424246;
	b=Wxs9sHZzWMNbFKsYcPH2kcQuosXUIBK4190fOUtwJ8+r8/7Ig1JVNqS1iQuVKY8kfF/G
	 VQna41jKs8Ok0IVq6vMvG1bCZ1JycTvAbXlcUaMtJL6e0WYSZOWYxViaksRvN33GbFLM5
	 n4vBgkVDucvuTFydNyeHVsBuUztluBs0fVKhGE45lKzuWTaGhuvdK6rnxvkubU52LjMa3
	 5D/FlhFeBkpjr3iPgTE6a6Xi+OK7yuTWl/hBY3ZT0IY9HNc40R5yyL5FcIL5vjWEzZkF3
	 OxIDB7EWBoNqrmBEq/cBjkEyUb8do/Zi9HqS647fzhtLQDJxxDM6rVM5ETnqfjfidvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795424246;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NKpaQpe82RrkpMiH6hbJHgRhJN733sQNXrEa/Q0Dx2Y=;
	b=l5Cb2SDaJOpFdLQuPiRwDWewmAHpxQN3QA9cTw4IrtGUJux3vYjBwiWv4HgRuLNF+1X9
	 ThG4PKWE/SiejK+oVeTYBXFGkLO0zdC4LjLWEXiquARqkMu3P+b9hcydpF6kioe/juevU
	 G9wmPJpeLArX2f3fbHyfRFitWhEi6IZUWXZFKgKnHS4thntisee9bXA00U7teCGd0EEmv
	 WT6hpdT1ET/xjZquMIchqpQr7sxu/v/e8pqI0jFpVd50WZtxvb8O3qTAQZO7WBs5U9Mb0
	 8it4tF9uR2sweF7PKmstncpCxQuWaM9yzQGal+2a4esJMLhQjpF/3PeGA76EqUY1xmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795424246;
	bh=NKpaQpe82RrkpMiH6hbJHgRhJN733sQNXrEa/Q0Dx2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ykrW0EV6nXQNj7/4ROAnmmxt4FBTJmJgSVTsP9TaAx9KvHH96JCMQ/q5XptHAXQA/
	 WPBfKZ7+5tEgQo2+EcSF4ndOj0CLEwWN8yM5igcHzwiAnUJ/iCy0j6I0geUb/qlEta
	 kN3Wxu7mQyxAP2JYYKqGXKK7Z960KZDDdSCzRdOBDVqg9BKW7Mbw+HWE2SndcRMkg7
	 hx1doh02CgMlc9uiv+mD1i+Nw2v1+Q+AxVBFGtTwooGznFKdJHDZK/95Z1GKWpSYpk
	 kTZqjm8ZelamAdGTFW20gZeXR1grEr0HjX9uZhxGpC1haqSDtSKTiFPZazsZkVi+gH
	 rnD9tYghBLSZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E10140660;
	Mon, 23 Nov 2026 08:57:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BC1E7D31
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A29DD606DB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sl63Htv8EFJx for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 08:57:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE7D360603
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=LIABUw+q; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZaAOlQui
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE7D360603
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:22 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN6Dpu31664630
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NKpaQpe82RrkpMiH6hbJHgRhJN733sQNXrEa/Q0Dx2Y=; b=LIABUw+qyLvYFzL2
 DJbu9Oo+en5fOdUPDE+EKJ6wx+4B1II7ganAYcUgmZ14R6x+R/N7JWBYsQkR64r1
 T8A6iH4CC1nd0bE14Zqq5Xs4H34zIoOq3Q1VgcEHFcJnTStP0dr86jysPUbLn5Ll
 J00lquigZUjLP/5v5nyhmMWRLmOS5SmIZtWk3RZeot82dRQJO9f0eP0HCzs52jes
 VvTDdEtT/UwxtepMgG5t6RgYrCWK6BmasWmXHXKKCvZc0/ekn3mj82wNecx3eDy+
 Yf1k0r6UPbAfEXDee2TTK4S9weuDdYU1A73CBTw66/uFMqx6kc9YH5OQccyjf7yb
 A4yGUQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1p8jqk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:57:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94960131befso477013285a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 00:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795424240; x=1796029040;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NKpaQpe82RrkpMiH6hbJHgRhJN733sQNXrEa/Q0Dx2Y=;
 b=ZaAOlQuiT7ABOsbavE6LcwUtl1o5FZQlLR857IJkCq5pVutczKhOPUJ8rb2F6vBsud
 0EoeXUoHvSEEKvXu2RWzIcE3vyyh0TVJYYd/27CM6CwGaDhwf6DU521B1CGHJ80ZlLw0
 EjFvFaY/zUaS7IFKp7ubbw4nYJNVxQZ+6eczbpNv9pjArYt/dlilt1U7yU61ALfq6uTJ
 KPN2BzFf/MTZYtreKma/yPMqkxYRvvmpeAYEY55zAEcOVgvafeI2DYiX6TEXFNwDsojh
 bHHjRqlj6IGGRrJURmE5Dcyus+sSqq1mOk+imQl1ltK6km+V46gjviAFUZ29PH45nVJB
 f2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795424240; x=1796029040;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NKpaQpe82RrkpMiH6hbJHgRhJN733sQNXrEa/Q0Dx2Y=;
 b=ZKLo+Xd+s463kold2QrDVpk+Tgq/feS4ecG8x+LPZO1gGMNahcWIKKqJjSgA310ara
 5vRIWDzlhcru5lEURd90CQAtlAN8ZpRra5tKfmPlWIkDmDIale94BAGAW3Z8bhTLZg47
 ArjAOtnvLOmX5xh/HF3bJBw+X2/aWEnRYfrWkRAt7RX9y1AJIRE+PNiN++oULJSmRe6S
 TZNHRYNhzeTAcdymatD3xM9jwAuirNYMPC8oeijEw6l/cGsH/d4jKOBmQIAwdGC2EeO2
 3gbQuxLpjVZgYbXJV/fY/Plj2wIP61cy7RFfbWT1AAXdwm/bAqDdsg73GW9bwl38+rey
 MCdw==
X-Forwarded-Encrypted: i=1;
 AL+hErG/ihQnEUsZMAV6OG7Wv4oqm0UwPaDgB680EF0vC9vYQAdbB24wom4DIFRy5dBP7CV8XqT4fpU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+0JDwvYNSZskdu+n6bqRzLdaw/fYwk+KJMb4L5CyoGLJCjURTA
 I1y235PnH6Y2WGgabbem9KxU9t8NToBGR+wTZh3VPudl1twqM9+ZDQvhwe0bMYLft5MYOBgAg3y
 LMJcOxIMpeUgWs1ztc9sOOY8k9Pgk6HzKWdOScTjFKzqHKgfgeQWj71WlqHmWq7wwyUSzQVM=
X-Gm-Gg: AZFdTZcxSuuSj9SetuuEc2BaT/6Tmdho0vRyuzyjj4yxLEJGj7CmGvQVdUYXE2QXorx
 Z1OsHyibO8TwNWZ3yXs/SHUNgcKHXBPkE+OxmYvv83oyEaN8Hu+vqJKc45IEW0tWGzKNJfQjZfs
 6XF+Js8WNUgsDk7o7zqK+XGqPjOAn/tFl1TCiX6LCQ/FeRwMC4bzvqEJVJqEG+GQrwish5pW2Nr
 vIEsCPIXx5TRxKsUngO2iKsz85WrM3ZhgTbdp75fWIxHvnlVa/oNVtisF6P6bUB2VTrHF8yC2qt
 bQHTmjUPAFf/stVaigW34fu7cDuneW2HAHlPZ64LFl4oP2/fsWxTFB+2gcCJDNHXhLxDu8/97+k
 hOJ/qXBPEZGoqlyf+GQEqHn3gosYWEbgpBwaSNB1XWJ7vKtef3ZXwAwavdHUICLHDGJSEcJxKVK
 vHEOfKLKj1w1qf
X-Received: by 2002:a05:620a:4004:b0:93c:9c0b:3898 with SMTP id
 af79cd13be357-949baa1565fmr1677246985a.59.1795424240388; 
 Mon, 23 Nov 2026 00:57:20 -0800 (PST)
X-Received: by 2002:a05:620a:4004:b0:93c:9c0b:3898 with SMTP id
 af79cd13be357-949baa1565fmr1677241385a.59.1795424238731; 
 Mon, 23 Nov 2026 00:57:18 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc6fb3sm374976466b.62.2026.11.23.00.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:57:18 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:57:01 +0100
Subject: [PATCH v2 1/2] mmc: sdhci: delay the status clear after a response
 without CRC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-msm-sdhci-wait-send-cmd-v2-1-5de53eb34ff6@oss.qualcomm.com>
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
X-Proofpoint-GUID: tuM7eGfC4K4Wtam6Zc0IQ0bYDxA9_1PB
X-Authority-Analysis: v=2.4 cv=K+O3jCWI c=1 sm=1 tr=0 ts=6b03fff1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=2diJqn6QHJFZazVFkGMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNSBTYWx0ZWRfX4Yn3RfSBbsQ6
 WOrYfSdpVGIGPnZfTh+WjQSUc/CvcqH61sft86IHNrBZZtXA8B9Agp8KTGTAHE03B7aIuFw6M9c
 2pPY2lPzHxnF5MYJviUXVcd7e5iFk+k=
X-Proofpoint-ORIG-GUID: tuM7eGfC4K4Wtam6Zc0IQ0bYDxA9_1PB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNSBTYWx0ZWRfX3Bt/uDWPfU1L
 3DPURQ+ng3MH+yDjJWEBGnXMY70BjdB9mlk2kKj5UVk+8tjGKNW5DFpJKZfkVjhNciglRQ32YpK
 Vva6Sa91J28RmbZ4DB8bCuD9GvyBYXp+4DCTuAAUOu0aVd2XLQGpO79xZAgzBmaRNIRzYDAAU3K
 0eoTWl4xWzHr//WlFV4A2Vgka4XhN4dkTxDi1Qm/5Xb9+kJltNOORqRazzZxuEMyA1U/mMtPjQk
 WBEUWPzEiTL1Onqx8LNiy/av3louZ4xjL4E7c0HIHIbXfQsMCVEgkaOJYLWs7ixFfVyn/GUW+fe
 TYW7djkY5mUsYfWjDgZZKvAfxBiIXF6f7YjYb8450VMH9J9s41mjIczN6bo0AH0/33wcFxHLJU5
 XP3IR3sy+qf+F/BVwFpcT1JJgDYTN+MYQR5XWoWwXX7gFiT1JavmALgmrk0V0PKLxtX+pNb7GAE
 40DDZ0aIZh1eFa3qD5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
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
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/mmc/sdhci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 97de02c262c..ba355096761 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -346,6 +346,19 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
 	if (host->quirks & SDHCI_QUIRK_WAIT_SEND_CMD)
 		udelay(1000);
 
+	/*
+	 * A response without CRC (R3) can leave a latent response CRC error
+	 * in the controller a few SD clock cycles after the command has
+	 * completed. It is not visible in the interrupt status, but unless
+	 * the status is cleared after it has settled, the next command that
+	 * checks the CRC fails with it at once (seen on Qualcomm SDHCI). Give
+	 * it a few clock periods before the final clear below. Such commands
+	 * are only sent while the card is being identified.
+	 */
+	if (!ret && (cmd->resp_type & MMC_RSP_PRESENT) &&
+	    !(cmd->resp_type & MMC_RSP_CRC) && mmc->clock)
+		udelay(DIV_ROUND_UP(16 * 1000000U, mmc->clock));
+
 	stat = sdhci_readl(host, SDHCI_INT_STATUS);
 	sdhci_writel(host, SDHCI_INT_ALL_MASK, SDHCI_INT_STATUS);
 	if (!ret) {

-- 
2.53.0

