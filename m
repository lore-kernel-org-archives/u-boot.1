Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AB606A32E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KDnLFfzI;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b3nmChU9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fef/ZEEV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2EC960B50;
	Thu, 26 Nov 2026 14:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4EsDABSFOKEa; Thu, 26 Nov 2026 14:32:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 823EC60B0E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795703531;
	b=Lwh2FORaVe4LHoM38fNPMgr03GHcffjxLcG5MKSzh/bFGNoMreciA7ZWhg68R5uttikR
	 M5MJaIoIgz/Cy4aWtFQQ2PMJDq8WSNrLdrdFq1tzYEr94YVZ44qvL0ZdWz6ehuMpUYzOH
	 I5G/byQHX8PG4IE6hkI7Ehfg4CHDuh5I4/p2h4LOf8+Koz4x8TC85Qf+c6nhnP92Bex2r
	 UxFhsbU1zMWTUHEJkiccs2pRXTiA6XpmgYL0BcQc8s+GN2Dv6zTu+frKmdHq6gwAt8WKV
	 D0oQgIzksN+WQvLbiQJgvKEk3Ylx7KQwDPdOXltIXRN7Oj9+aufuTDKXu06ggJ3OYpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795703531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RSiPg0Sm5X9VvO2Yc2KfdCZjuJf/WRd3meG/bFwv8U0=;
	b=PxVVcOCqFzpccK859tRuEWI2zC7jT+x4j+M0NBGlkjSrFpUrZwcBXj3quphsh4ZkeR2c
	 aFA5F6Xg0Gho+p8/9KWIT+2v3cWGv9QnE+WTuTCu0fKNfX+/Zr5uw6e63/qzLYpIGVusq
	 hL5+OLfgBAPRzFLI12JxPMMSb55r/6Aphq4hBiF820jmAwPbFf89zK0sstrbPb3Ca92mx
	 /obElZl10K4oRpTBZuL7ug9qJDuO1w0unGC3f5xN0LRobu+L3O0zlrGWcxKas0+IMWR8H
	 QkavNtdnJbJXWfhy5wKOAznWaih98XKDPEZnUAbUpirG3RkumvGsLQzd2+j+IHUMYxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b3nmChU9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Fef/ZEEV";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795703531;
	bh=RSiPg0Sm5X9VvO2Yc2KfdCZjuJf/WRd3meG/bFwv8U0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KDnLFfzIM99oM7CZkfR8h8G7s3p/QqkF9bzWarw87IAu5IZGSH9FcJQjvzL8izEdl
	 FI15qUQ4FPEPjR/C15bZ4DdUB+bLmiLN2+COsmVNsxqgPS+6Diq7BOGxcHoixXo9sF
	 NlRBqI0C5ClpSvp7SXhFkzOnsWFe7ZVbUPGub8pduwlNycxzX4Rm9DTZQyfjM+zDne
	 hUfdE75oAt1fYgjwkW7BxOBwQtPycPSuH2PHlK2U7t7Vcx6vfX0NgkBVbmNf8G9xdH
	 5DXPx3uvAZ8wdXyG7+wLD6ISVcA6oOxohmak1lpD6VsPxoA+XV4i63u8mPvSAogWUW
	 JVbP2CJHDcZcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 823EC60B0E;
	Thu, 26 Nov 2026 14:32:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D4BA311
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6290E60A98
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MIzt0v-H8lNu for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:32:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5844160AC3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=b3nmChU9; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Fef/ZEEV
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5844160AC3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:05 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEV8n6320219
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RSiPg0Sm5X9VvO2Yc2KfdCZjuJf/WRd3meG/bFwv8U0=; b=b3nmChU9a2++chNz
 IvnCUQEC2FgIRaLFanOPeM+H266tDoJgAxNefaFjIkRvpjY8JQ+y1Cm7uxKDmh2f
 Y89l/u5qbzzu+fNCP+OIJLKtIqYnAzyzN2SJG5bGuiYlxexKrgeEC1hjU845kmO6
 /6rAa1mmJ6ApREeuIG+N1bX9RDUNqRKqbHKz7N1UavRzQRdFd2wZKvACeqnTD7Me
 CcyWBjoLamtOmq9TQxofmue8ypt3hZjh4yPLxbRwU1x+WmtFdvwuAbBvpqiSucmf
 zM1ZAxDe7ex6QrGVF0cLBzIs9wtvZQHlvL1wT9DZBvVhxpc9Xw46DJNStFWWfGTv
 E+hO7g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62vavadh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:05 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9806756ea40so4214721241.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703524; x=1796308324;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RSiPg0Sm5X9VvO2Yc2KfdCZjuJf/WRd3meG/bFwv8U0=;
 b=Fef/ZEEVKozeddHOMcVKo2WPoQSE8ic02Vw/iG6pFdZgkHE6Z2vGFgn+KHLjqH5K9P
 r8nAXcgjNANkpcVZ0itrEskbVWFecGpKxj/OtmpWvzLB+9CVGY81klcmgco3sq3ZHtJT
 mckFGRFYjwiZ5GIt4zWUppf756s+v1rJ+0Goj0nl3tthxCdmobEsbMG+w/9RcIgsfZ65
 Jic6pDaPtLnVUaPilA3onW9fvcgNdW43LDq3GzOJDV6qWJlrqWsz7FcsIwfUPQQm8uOj
 ZKCxoacuIH5LpbuYMbR3ZfbH0ksoPiNRTMi2yR2a6i9lrGQ7s1SFeHs3WnjNA+7vRmGL
 5EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703524; x=1796308324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RSiPg0Sm5X9VvO2Yc2KfdCZjuJf/WRd3meG/bFwv8U0=;
 b=jRGwHIWh01HcI9NL2/CuIC6rGMW8UoK0asJdwkCEzJOe4GZ/FKyBFUQfVl6I1rGQFm
 vvFUY/zrUv+5f4BusdOVxzDQ+hZKzvjZi3O7jtV5KhDRITTSOBKxBvbfYHq1YrzIpNGs
 rKJVkRz/kpiFwmNyDM+suGA+fJMIwOlLcGGS+GBhnX1qiGRUmAdEWcgGKiqli9BRyYy8
 zGg+6bthd0CuQ+YaTX2tuMI9H4oL+kB5ruSJb6PoZiJpnJykRzwJo6CdZV0R5KucUiz2
 dX2K2rlRkrPU2g3Q4x7qlilrlLAafjIdwPxY5I9BmGOfvWFIrNlay8epFR8PuM4C2Uy1
 vZDw==
X-Forwarded-Encrypted: i=1;
 AL+hErGc/P87fLGR/aHAZkmLwf9/otqDEs7UD+njDtKo5Z3y7qnbbuDGHAlBFfMT5Li1jmgzzkniC8c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9ZrNEDkWGiAAWiL5bK1xkSjabFX16HZ70tmwA0LUwsFO6UbEYv
 Q27/md7eGR2FlW6pI1ElKCEqpamHrh7uGB+r2IaXkdVZvZdSU7ElL5Vn1NznHlu0+Kr0QAwrqdM
 9U8p8a1YY6VBhmcR/5+J7UVr/z1E6WByH+5sR4xSNDmkrY5b8+YbV42fOqIEw3laW6rV7OzEIxs
 ZHKws=
X-Gm-Gg: AZFdTZeQoJRqPiIglm/bpsVYugasgCfYlfPrTsX5RUVRAt1r/hwDjpSgyTKE++Em4PR
 2QEvIteuHdY9jgnd7yFVK928jVhsWZGB7mHfQsgeOtTH+qa171kHqWiZR0vH81w4myNAwubz1GZ
 zzpqUEfxLhgU2Uu5zZSFgcEoAMsC6LL4Gn3w69w4meopcQtddsIrsae19xcAcMnbhWKVTIwSRn+
 701r6OTDvWPxgR5VvFVeMr90WA/GaPjv1cVZtiXwRIJyy3k69I2pjktmDQ2/+ENQCZnSnSeyqAy
 aqYmt0k5YTMonC0nP7+O8fcAN4eKNP1ozk+jEvH8zrdbLAG2ggOpmxlB3S40LFKvOVVDE4X2P2I
 t/U1X00HE+sxxoi/9nCVq9kEmj7mqKJr7XfhqBPezqvDm7q9wN3ieS+ZTeL/cjzMftWTFzZT6a5
 Hf3sSKvhi4VUFd
X-Received: by 2002:a05:6122:488e:b0:5ee:415e:3f41 with SMTP id
 71dfb90a1353d-5ee8af0e00bmr13218567e0c.7.1795703524107; 
 Thu, 26 Nov 2026 06:32:04 -0800 (PST)
X-Received: by 2002:a05:6122:488e:b0:5ee:415e:3f41 with SMTP id
 71dfb90a1353d-5ee8af0e00bmr13218522e0c.7.1795703523701; 
 Thu, 26 Nov 2026 06:32:03 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b030ed9sm772664866b.86.2026.11.26.06.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:32:03 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:31:54 +0100
Subject: [PATCH v2 4/4] qcom: bind the RPM nodes to the RPM drivers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-qcom-rpm-glink-v2-4-15707dc6f396@oss.qualcomm.com>
References: <20261126-qcom-rpm-glink-v2-0-15707dc6f396@oss.qualcomm.com>
In-Reply-To: <20261126-qcom-rpm-glink-v2-0-15707dc6f396@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXx3R8l+ahGG1o
 qqOQz4KkW7b3yFTwZGYJ9UruIXKjeZ9P6jHaNuyBcdGKcu5FE8JTWzLxa8r6aASStzRtKKg7S8i
 Lz0Nfhr7cbdFV16YBTV9LbqJBUi1rV0=
X-Proofpoint-ORIG-GUID: ewymKlYk-Y6GM70EC_z6slJgwlSaSMk_
X-Proofpoint-GUID: ewymKlYk-Y6GM70EC_z6slJgwlSaSMk_
X-Authority-Analysis: v=2.4 cv=QZPzLcbv c=1 sm=1 tr=0 ts=6b0842e5 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Mpo36AgKSdgbxWveMyUA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXzTvAkrF+4j4B
 Xca+d/SCI1uSt/ifdZDLe4zyYw351w5HxfCeNWoEx2sG51JwQJBa7aO01JHYcxZdZGljA6Qk5LM
 fIB5kQpRrTAEq2gK92/BpfAZDErfbWS/oLJGjEh5XccAi1A8KLXcaHxd+/xe8mynAwag2iCDtnw
 lL/eKtKG/ZqmN5QLzIldEvSsjexj3PM5C0CEuP5ssyLpwHlz11ZpH+eLsS6tQ+/Jzp2Iw7OD8HP
 5DA6/OFTnBBtidChO6HYVOjZH0dTi61M8rze26zPEFBPXF1QyGS4J6WcpoE7yDeowXUyWlkfOu2
 nNIG2batIV4FT6sw+cduVa/oh1dsua1LDtnH/gePCMEMUamoXoLb5fu+vY1hfFYV7DgTw4mp821
 D6lYM2b4z6Sjm2ql3rPnhn8dJVZ2d49cO+19m4OIcTj97Mp2cshLB93eRBa7+3S82nBlrLwLV/H
 CcZkNFa3kFQHT762scw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
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

Enable the APCS mailbox, the RPM transport and the RPM power domain
driver in qcom_defconfig, and drop the GLINK RPM nodes from the clock
stub's list of NOP parents. The transport driver binds those nodes now
and scans their children, so the RPM clock stub below them probes as
before.

qcom_dragonboard820c_defconfig is the other clock stub user with a
GLINK RPM node in its device tree. Enable the transport there as well,
so that its RPM clock stub keeps a parent. MSM8996 has no RPM consumer
in U-Boot, so the link is never brought up on it.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 configs/qcom_defconfig                 | 3 +++
 configs/qcom_dragonboard820c_defconfig | 2 ++
 drivers/clk/clk-stub.c                 | 2 --
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e5291750aa7..cc89b0e9b33 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -96,6 +96,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SM8650=y
 CONFIG_IOMMU=y
 CONFIG_QCOM_HYP_SMMU=y
+CONFIG_DM_MAILBOX=y
 CONFIG_MISC=y
 CONFIG_NVMEM=y
 CONFIG_QCOM_GENI=y
@@ -121,6 +122,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_QCOM_GENERIC=y
 CONFIG_QCOM_RPMH_POWER_DOMAIN=y
+CONFIG_QCOM_RPM_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
@@ -133,6 +135,7 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_SMD_RPM=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
diff --git a/configs/qcom_dragonboard820c_defconfig b/configs/qcom_dragonboard820c_defconfig
index ff2c960983a..d72d35055c7 100644
--- a/configs/qcom_dragonboard820c_defconfig
+++ b/configs/qcom_dragonboard820c_defconfig
@@ -39,6 +39,7 @@ CONFIG_CLK_STUB=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
+CONFIG_DM_MAILBOX=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_PINCTRL=y
@@ -47,4 +48,5 @@ CONFIG_PINCTRL_QCOM_APQ8096=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_MSM_SERIAL=y
+CONFIG_QCOM_SMD_RPM=y
 CONFIG_SPMI_MSM=y
diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 74825f87580..2098bd3e18f 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -13,8 +13,6 @@
 /* NOP parent nodes to stub clocks */
 static const struct udevice_id nop_parent_ids[] = {
 	{ .compatible = "qcom,rpm-proc" },
-	{ .compatible = "qcom,glink-rpm" },
-	{ .compatible = "qcom,glink-smd-rpm" },
 	{ }
 };
 

-- 
2.53.0

