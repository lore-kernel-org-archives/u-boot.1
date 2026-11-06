Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92941606D807
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 06:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qz43v+p0;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U8mJPQn/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YC45aha2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 198F8606ED;
	Fri,  6 Nov 2026 06:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UvMYU3eQy5BW; Fri,  6 Nov 2026 06:08:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67C446061E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793945287;
	b=iPc4wRh5UFoNH/qlKg5bNsRmPvanaYpwFZbXre1zANbQVP9QMFvXtcdNBPeDgJQx8ERq
	 LPxZrHTf45dwKreqYwL6NuCPyRwnei4/quxXKZJr55QcQgX3iMlOZKIO8m2zztt2BLVcL
	 WGV3AU5CIZMRB3Zdju+BVEO7SSIO2IUFMfGQfp76NKX19Q86cyYHwXoRJQ2GXByy+9G9I
	 za9Erqcpv2Xn++mytI1SXsh02BEX22AWdy/QvwQDYQgVGxQH2nvsTQsYnMi7S9eGcDBVb
	 9slj3AV+hRYlss99+Wn8Mt4oiCQAXhPz5Q2SW8q/DeyMyESTFuSxkmkJ1NwV/LfSK7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793945287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	b=mk4TSIUU7bgk/l+EH/BhJ0nqude5IezLM7bFDAqVx+ayrwEplE7Mnqm0aBH/kUXfcG+r
	 g+Ke6KC9EcRgTFIRenI4JdESl7s8b5bXRZwReBTuXJrE4d9JwQv1UTnP5MBMk2lQ0sT7G
	 +twGnkBqX16QW5QW/8J986J+ymJ+KB/ag/uqnvAvJ+wiwiDsm1X0bIWjhEsITLNyP6OIp
	 Dqm1dEz97KO3NsUnZLYKmQHOYO4m9PJ97Nvg7AQgwifbspRLqOBubFTauLlRUmQEluOZi
	 Y7Dh4xXizKqvzailDYtEFH4YzzVVl3t65tp3+xQJiHYFQscpupBB3zI98gtD91HHO4w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793945287;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qz43v+p0FiRnxo0b6oq3NjNMc68TLCa1LUvCnK3kftBNYXCDceH7X5mt2O6EYvgun
	 eGggCdz8mfpRLI6xg6C3T7ypWzHEg05R7AhZ/03s5gvHR6JbI3DppNxSuVBVnSSUhP
	 7YLQioUBGMGBWtZKY3cq3/+7ZqKMcghlf8fdShr2FG6cpaV8/edOHMZXmK5ZoGSc+/
	 +ULZlhlrHYEckrQ7B70DC07fnYX/4uXvgrbJ9nIPJVFKg5fBmgWJKnKvt1OhoHGxHc
	 3I+VKBrWWLFoC1JqKd6GuyhyoMhD+K167yrKSyCah5nGiAq15l42/Temm+44yFiqWV
	 qhUReSrzpj2zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67C446061E;
	Fri,  6 Nov 2026 06:08:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CFA92E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1271E406A1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Wet0mkCUebY for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 06:08:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61F9C40692
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=U8mJPQn/; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YC45aha2
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61F9C40692
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A640HBC2265641
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 06:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=; b=U8mJPQn/thN9Yop+
 vveNX7z1JsHkE6JeX4rqI7ui2+sCGBY9R/aI4R1qoqO8Xd+AahYLXqRy1l+eoPBm
 wVls4Ty4vU80go+HkLWetqEdn7WLR9sMrGqFT1YyvYc5wz9H5NOi5SZTY2ynxjuJ
 tOZkC4ank5lMN/Fqlmd9nZHa302mhzpLhECXhSPedCerPaObScE9huM4BQrB3HLP
 xzl6Zc7GHjevJNo1+dPeAEDDUYKa6ZCxJwGpaXzUu2jbLXNKN2+wrLmf7khvnXLw
 FJJOSzhxrLw2UtG3HELCECIPWy1RvP3mr4jQxBXZCofwES6z/Onrjz1bXV1SuKHP
 I8+jng==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9h6hk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 06:08:03 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b25d977b91so645990c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 22:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793945282; x=1794550082;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=YC45aha2lzPdq7MVMNxkDuEw0f9kNyXQoLBpmxR4rt/Ciw4wdvUSNANTtQTFMsU61r
 zaPJBSvToj7rs/wgcbXbNkDLHO28Rgqdkxm24zGZBRYnQVRkcajGB3WV8IC8Tdm+Oc3e
 yAFVms9yqjMLkORuNeQ+lv+LGf3tP6YvK1A6S5/tWwdlp6l9HbPfAYQkfnIhEVdrovpl
 po+03q8R5AC+QsscuREqHCJzSwkJCWQgtSzL5VURjtfEKrfjeKDR4/NmmxFX5QG0FPiy
 aXbAds4/QtRUI2jbUWGqg1/0g5C5GR0HtYw+fXWeEM5LoAlIJ8JuNF46QAuTcNqB2ieT
 JlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793945282; x=1794550082;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=skkIGrt3ExTgETUyVoEpl3EzpjlJyVDJaZv4AjcCG+70gGPAlQa2+lRR/RDb1cw3v2
 2AceYfLF/CN+Csx2mYBWt0NnoU7Xj0YoIGj/naNTIUpi2TQ6OUpc14WwfBDm+vOWKLKT
 LHuZF6/tN7QzxvjG48GvD5MXMJhJJIkJsU+yqyQZO8W8T0W3R5vgac/k7dU27oX21vaD
 pPKarvD1zp4eazVI8KXBm4nzs3MLGEB/iRb2lfSaxY+irU+e8SiUt0Qbw2KaGv0hw5Q0
 93u4MQ0Z+Poc1Shwpo3m8SShH9VrMiVCm9Xx0Li56ZFia6g8bImUvVIJYlSRcFvOE6Ec
 VpSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSNwQyXaSKWyXgp1ACRZzxxTPWYCvQObg1s8/FT0CB/XYcZcZRHosPyHUat0Gglm7b9RzsKkY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9JNS1IVLg1RLNwU+TJREZ3iga6ygDsHc4dWFUxdp/1vEUPsMIl
 G6B7ZyRGL/zIkUy5DkR0fDZ6oPe3tH1cFz5v5GUp6rwiKZ3jWWNZJOZZrKJ1AZPp54JgTk3DyEM
 FUnz/LK3IaihQQsvaWLq4hNk67oeQ3ZnTJOBjEyYdFpargEKXgsjv4gHHM/WxX3YuFYUaPgA=
X-Gm-Gg: AYBFou1fbB5TI7NBQO2aSq7mbvstiiiBTnqGbbMDlkNn/AN3RvmKyhHdNBm+V79kKtP
 8Whhch9uRk3F5nTEo3LCJ2ffT4sS5jAv5OVAt46pBbzSxXZ3nopDS30d+m2+EKoUoyFlYxUA2dg
 0pvCegx4ukBZ3uaIvb2zDa9dD429QgPHLyed2hg6CQEykHT+1Bdx7GEMvPsrXuEaIXv8DJavZWq
 3Mn1Zh0xQ1CFeds+AWkkT+agqOS5fR0UfhAZbgjPVwcPudZAh5le/QyzGMe3OF9oXzMNqs2geuB
 42k3vMfydPJb37JL4dOlAHWTZBH6RATPrPW7fTiPc8xLuBW2UWndElqXWoc1O8SgtZnwh22S30V
 n0wFhwb+t4DNs+FNOmJS2RMP+5nqqpcXzZdXn90ONbM+PHp9ixbIt8gUBBPthg7OmZzV8qGDKEK
 0nKX2OOGKoVeOjQGVWpC2DOv5y9XkPHxuTwpmKvVLiojEHiGEFlE3veHw+z/GuhULUyZcDoKFRW
 yHUlQE=
X-Received: by 2002:a05:7023:90d:b0:185:4ad4:3d15 with SMTP id
 a92af1059eb24-1b25d28c74bmr2385291c88.1.1793945282326; 
 Thu, 05 Nov 2026 22:08:02 -0800 (PST)
X-Received: by 2002:a05:7023:90d:b0:185:4ad4:3d15 with SMTP id
 a92af1059eb24-1b25d28c74bmr2385258c88.1.1793945281747; 
 Thu, 05 Nov 2026 22:08:01 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4a610fsm2341373c88.11.2026.11.05.22.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 22:08:01 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 11:37:42 +0530
Subject: [PATCH v4 1/4] tools: qcom: mkmbn: Fix ipq5424 MBN version
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ipq5210-v4-1-5af12cc2b601@oss.qualcomm.com>
References: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
In-Reply-To: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 9sWMVdL1lBNMrt1WkTNb4Cew3SdMlx7W
X-Proofpoint-GUID: 9sWMVdL1lBNMrt1WkTNb4Cew3SdMlx7W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX2rStyR8KhoIy
 6oR1Kj/z/baXQIe7fNrS9eKa0e/+o6+5bNQX8GUArwcD2zZiSZKfIg0iu4pcv8UKeCPrntT4j63
 QPi1nX+dZ+M4aKWKq6aUaJmyL9NYurU=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aed6ec3 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=5oOYJkjiZhHqBJ3UFLIA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX/j6mU7w9PMQC
 TvEMBKiXfSKqkvROtcZcWHeqm+u5vtG55LP4SjX7lPa4NygaqGkpHtaFgECcoDklvsO9o2i+v5G
 kIHZOyf3eoeeZYsA/nC5jn155LoFI/BaGny/MuhUQqggjQ1Vj8MUS/PuLlCrD6OUhcOnrpE01le
 y1kZB42RGeiD00imAkTjAve+jKoE4tTYqWXdf6cpb3F8w6AsDXI70hfgI2kFReCogGnsMnfsg2w
 LATpWza17YCEvjeN3fqSSFoFiiNBPam5rIuBdQ1JEvVseApElDMwTIuLV+Xdcq97CJDEECZxG8z
 vlRtKQ+7Oy2tGKSXy/SzucLT9FKXOxWfj5BJteYfxW/CI6kyq7OveeayMX+vLtjoZS5VUtZFxLe
 Mj1stwHE2VgZEirhASCJSpw4quYUAkY7wIuTKQZakXbfwee4pVUTcDuhunlBOBUlc85cZGO6p4G
 lOl0LbyjEQEtlIvpmxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060024
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

Since ipq5424 uses MBN version 7, update the ipq5424 entry in the 'boards'
table accordingly.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..8d2078acc30 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -85,7 +85,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
     b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same

-- 
2.34.1

