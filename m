Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C3606A699
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gb3RlGYx;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RrlpPp2/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BVx3XUTV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1679660AAA;
	Thu, 26 Nov 2026 14:32:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cPHqkuWmzNyo; Thu, 26 Nov 2026 14:32:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 34D9C60D56
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795703535;
	b=lHd0Lhb9m4idnk2rQmSaX6QSV8ximA5bYfdvvEiChd3Du2tnJjP/fqVAc/9dX+xgRjHW
	 CN9O4kqX3B8V7HIhSTZALfKY9AmUOiRpKywhCiAzoMZRgE13TS+SvUc72o8/ff/iPGwo8
	 Fxm1SSECNik3dMcP2pW5ONvLKnBVkaxnt5iZjmoArBkge8k84UMUu3Sg6NnCU50cz1mLb
	 CI6SOWE6cLCbRgAWYTVvjNC4Dc8hGNTQvpZbex6pvB5f22UAF7gcjqGhQFQNioYcmTVyK
	 5Ky3CTHYlnJxpu34o/TFp4gRZvMampUh8Q5GSFUBD8mYkcIYCcfxVwpLkpN60TaK8lA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795703535;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GHt13YHZ9TpIK1wx5ugTl2XnKq2FPjWzrNyyZpQtH04=;
	b=Y58MtWcEZAh02sJvNXleoIS+WTSzTDx4YtNh1D/LsIHjM0dYea6YNw+pYRAlybeMk0CQ
	 Jqwq9T614rRFrNDCSYUi17Vq2RHnHLfKVJHPCYC1JcreYqvLodRM4RPH/kqLREZD3v087
	 1ZTzztyso3eKtbD+bW2LnNonQNAs/5PpalnFmgJrKnNPflFj6VbQvzX9Lf2SMtETT48rT
	 Eij7S99Miiu5iid37/hAOudQNrKdC6KAQjvPpoV48++r/M42XxXOLEdIUYxr0+eAcNKnC
	 +8TQROFTK+ECBiLP/M4qFzk0NQUwrwwAWo9P6LSQzA9KOgUWoaSZ8436ZH0Wa03N8Kw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="RrlpPp2/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BVx3XUTV;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795703535;
	bh=GHt13YHZ9TpIK1wx5ugTl2XnKq2FPjWzrNyyZpQtH04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gb3RlGYxO59xE8xHE4Hsx7FyfDF7iqoZ+gUW3g65xUSdMNRshLtEIuhOFKlpjQ5mw
	 R27KA7DzgpHi1H44zE7SC4B/EFj2jnrCQ+mv1DzYFu5bxbg0/mUY2OVplICPsYyk2f
	 e0W8XOFZZ2wHmEciZ8TcmYbJLfYPt7gl1IyCkr0UlRkqe6TIbH2tUiE1dMUd59ylFX
	 JgscECBOMPTZzBeNE3MqKDcM58AtmTo5B2mUKv/bE4eMdwT+S/esKO8Hr1mYQTYk4b
	 t09Uc098R1phYpvX8gevo1u7HI7J/dLxRQUisJqRtUu6xGvZ0ifXwmburEm8y4Riwg
	 zCS0r/3a+lJzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34D9C60D56;
	Thu, 26 Nov 2026 14:32:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C8D6371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EB1E60B0F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AOROSbew4-ST for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:32:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 68BE860AAA
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
 header.b=RrlpPp2/; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BVx3XUTV
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68BE860AAA
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEUxvJ3563228
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GHt13YHZ9TpIK1wx5ugTl2XnKq2FPjWzrNyyZpQtH04=; b=RrlpPp2/QX4lvIbx
 gOc8F6hP2kMVfyUDJmBARskvkYCgwEO3cJKaYpmze2AbuRdRmCsYzgmeHfGtj7OE
 8auuoHiCCJyRlc1YWsuxXiAjU3Pl27+wR8tdbpd8Rq+Hc8+cn7fE6/uqtWGpu+F0
 BpCSgCO1ygn5cYIz4DY8B53ghc1P9TLHAe4hQse8hE5wExFJedXkAB+/Qzxgu7xu
 2CbG34mmq8fvQYuUSevEVa8wUt2nfYF0VuRrugyGEqjUSqvf5SqdNnKmEmCvQnv0
 4wYGz7qZKG/OEC5CkZsBsa/t+dtQYhk6/BHSyfJRjX4Z7g9k6wEWWYNHQjAfyMlx
 WP+cmQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662sbgx8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:03 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98a829c43f3so1302734241.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703522; x=1796308322;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GHt13YHZ9TpIK1wx5ugTl2XnKq2FPjWzrNyyZpQtH04=;
 b=BVx3XUTVHDCJcf3Dd6mz6XnTnDoZZubyhPzsSghZnepWl0tJqBb6R97OTIbyRM4/Un
 uh/RObkAIQeWo3R2nZipXXafSU0YHleQ45ZOtLau3yRUocaexn4Gi/o9P5FEdwQz7bJ/
 Dm7xiRVEUFd68pQrl5uXijdQ+rxiyYePwF4AhQJm2Oqv8TUAZG2HiM5AY3F5W0SCaOyZ
 /2KPc4Jni5v/sJme6v3Ds7+sgcTTIrkvmIlr5ZLoOaznv1yrnPrrdZCINbfMXfZVYxQ4
 B/2i5jlyIQsixgf8aEGm5sC2JvSPLyKsK5ywOfeoWfTnG1l+CSVHVe2G11N6cOulCOkK
 i8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703522; x=1796308322;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GHt13YHZ9TpIK1wx5ugTl2XnKq2FPjWzrNyyZpQtH04=;
 b=eSjivJ2pgeBHFzeCZGCvaTKTSXOLAx4BwdtNK93WlM9hrDR35scKYNfWbGKqfP1YcN
 up/EuI1wBS/BWL1l9wk+lxoocQAPtP577gulBFXTJZX3jrrjef1VWFT0wjNtyAnHCTBS
 XDTOgWEE7EhCDM0mIwHY2bpL+w2r14I/gfEVwRIr1nr6W6NwMWVBsrV7rdug684x01cJ
 UiPy8i/QNoDEXahxT6MzM/5bc9K58RXHrcfwOhfzoRVUfn3g8Kwzl1ktjHnX5E6bQsc4
 8Ww18KLGpdttaMiqkoqR0SsewmDtjigQfYQrW2N3jQEYBteDzifRmw73lljMycBmg/kc
 wKVQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHvS77226jvVBju6sofj/bsnyDXVVydhZ/L8RgSREgI9bOdykAEiBiod8Am0B1zqjMAuQe5Mx8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/VzTLAm1FbO1RGAQqeLZVhkbC+G4eYbHrYXBm7Tj/5o16Gkb0T
 gc70d+fzjtGQ0VNhH3ewk9LwJjraExz8p+ebotmFN31SsMIU5VgWKKaTfpAFh2ww/JgtjuOQXht
 V4/XYkIebIObWecc6l4a64PxfHGcyaoV+6pgvGwSIa2/89e/reB//vDNcHGEn7Dpk3SH/Vw09N3
 QMF5c=
X-Gm-Gg: AZFdTZfqzL6b0q7JfS9FB3wmWkxQsteG43lQ1GA52tBWlmcKX4YB+5gpLSlmbNxBZto
 VNXXqhAsE3C1nz2Ia3n7TfkdQEzsNN861bqUQ2D9sGlbBdpE7nY63HVEhMxbux0tNMqMAP22jbJ
 BsNA8/6rSaYjJgABh3qnBe6OQh/zHhWqdUjNUA8jA3K21+O0pHe/Jt4RpYqD+9JHqalZRRklR5z
 BFDbjuKGOw9tL/KP696/gob3BcV/0+UzfI0o4OEYP8sSOo3Vl9GJ9CQNK2ItK8pAFy6pLyDDwnu
 +d0nNhqpBC9yKno2Fqbu0+iVWH63pMnZXtXh0tEm/i8UQoex/14HMAIAcPf2SF29wMXuvqECgIj
 0czi5nKxXtl9XmIRRnkVwEzXP8YsiIa1trwG/G9dx0ReP6Ial4RyBL3DsT21eIEXn4QCLQxOtdk
 9pGULy4zB8SXqp
X-Received: by 2002:a05:6122:1c88:b0:5ea:e188:a5af with SMTP id
 71dfb90a1353d-5ee8aeee7dbmr13248845e0c.11.1795703521566; 
 Thu, 26 Nov 2026 06:32:01 -0800 (PST)
X-Received: by 2002:a05:6122:1c88:b0:5ea:e188:a5af with SMTP id
 71dfb90a1353d-5ee8aeee7dbmr13248757e0c.11.1795703520622; 
 Thu, 26 Nov 2026 06:32:00 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b030ed9sm772664866b.86.2026.11.26.06.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:31:59 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:31:52 +0100
Subject: [PATCH v2 2/4] soc: qcom: add RPM requests over the GLINK RPM
 transport
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-qcom-rpm-glink-v2-2-15707dc6f396@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b0842e3 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=4kWKgBmTg4NQTj_ncVEA:9
 a=INik-KkDAxYrZTjn:21 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: PjbFWSfM2ZPAve52KmaMWTl4afy65g57
X-Proofpoint-ORIG-GUID: PjbFWSfM2ZPAve52KmaMWTl4afy65g57
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXy3nrVyETy3hr
 Ue73/jYTlFtsFOCo20RnmLNfuP7yjYcDICaEcBHuqvNh4maCGo/XNcJieUdt53tj34RbM/XHxP1
 qbcPzxLho2pFcT42+yQG770t4mFOnegl7zotIOoOg4UwLFOde4E3qXJ/zLuk9AFmjfeFGzFZ9BL
 iGpGBEiqhIVs56R0j9w/gNeL7i8c170tEZmThsSA4eyny7J/G3i62Ge8JRrAIGG3LPmJL4U3pHB
 r/BBDHVfWAd+cehmQOsTCYCUif9HhO+SzM33UkMy6c7YmNT//g1a1/kz+yoEkhNAerFOG78Qutb
 rUAxkVhnDVGaHxc4tzl81XZg3xZi6WrhC+oBpDEeHKWJnrisJCXeev+7u282E+tRvPrRoWqRBg7
 A8JNABULqam7/33QL+afWycDYmEvfchx3ltHp5YAVn6V9co5AJkdOjVsQHIHSS6lAuw8E32py1Y
 St/3OQ5wGOxozqzPE+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXznb0QAA9rFW4
 43lSRBgQuKmQoPdMNpJfpYNmubXNsdGOmBfDZg3KIj9oARhb3JTCb7xxuL1ku/FEJpBzW5BPl9F
 wtUqyveQQlmYtQh7+0oNwGohc46FX6A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
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

RPM-based Qualcomm SoCs (QCM2290, SM6115, ...) vote for their rails,
regulators and bus clocks through the RPM. U-Boot only stubs the RPM
nodes, so nothing can vote, and the eMMC reports "power-domain driver
not found".

Add the GLINK transport over the RPM message RAM (polled, with the
APCS IPC doorbell) and qcom_rpm_smd_write(), following Linux's
qcom_glink_rpm and smd-rpm. The link comes up only when a consumer
first needs it (qcom_rpm_smd_ready()) and the edge never fails its
probe, so SoCs without an RPM consumer in U-Boot never touch the RPM
and their clock stubs probe as before.

The RPM announces its channels once per link. If U-Boot used the link,
it sends GLINK_SSR_DO_CLEANUP for "apss" before the OS starts and waits
for the RPM to reset the FIFOs; otherwise Linux logs "Invalid open ack
packet" and never reaches the RPM.

Tested-by: Biswapriyo Nath <nathbappai@gmail.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/soc/qcom/Kconfig   |  11 +
 drivers/soc/qcom/Makefile  |   1 +
 drivers/soc/qcom/smd-rpm.c | 772 +++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/smd-rpm.h |  41 +++
 4 files changed, 825 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index cdd9e30f43e..03e7c7ffcaf 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -25,6 +25,17 @@ config QCOM_RPMH
 	  Say y here to support the Qualcomm RPMh (resource peripheral manager)
 	  if you need to control regulators on Qualcomm platforms, say y here.
 
+config QCOM_SMD_RPM
+	bool "Qualcomm RPM requests over GLINK"
+	depends on ARCH_SNAPDRAGON && DM_MAILBOX
+	select QCOM_APCS_IPC
+	help
+	  Say y here to talk to the RPM (resource power manager) of older
+	  Qualcomm SoCs such as QCM2290, through the GLINK transport in the
+	  RPM message RAM. The RPM power domain driver sends its requests
+	  through it. The link is only used once such a driver needs it,
+	  and is handed back to the RPM before the OS boots.
+
 config QCOM_SMEM
 	bool "Qualcomm SMEM support"
 	help
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index f4102f9155a..fece2caa580 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o
+obj-$(CONFIG_QCOM_SMD_RPM) += smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) += smem.o
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
new file mode 100644
index 00000000000..c548f1bb183
--- /dev/null
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -0,0 +1,772 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm RPM requests over the GLINK RPM transport.
+ *
+ * The RPM exposes two FIFOs in its message RAM, listed in a table of
+ * contents at the end of that RAM, and is interrupted through the APCS IPC
+ * doorbell. GLINK runs on top of them with a single channel,
+ * "rpm_requests", which carries the resource requests. U-Boot has no
+ * interrupts, so the receive FIFO is polled. The link is only brought up
+ * when a consumer first needs the RPM, so a board without one never touches
+ * the RPM state the boot firmware left.
+ *
+ * Based on the Linux qcom_glink_rpm, qcom_glink_native, qcom_glink_ssr and
+ * smd-rpm drivers:
+ * Copyright (c) 2016-2017, Linaro Ltd
+ * Copyright (c) 2015, Sony Mobile Communications AB.
+ * Copyright (c) 2012-2013, 2014-2017, The Linux Foundation. All rights reserved.
+ */
+
+#include <dm.h>
+#include <mailbox.h>
+#include <time.h>
+#include <asm/io.h>
+#include <asm/unaligned.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <soc/qcom/smd-rpm.h>
+
+#define RPM_TOC_SIZE			256
+#define RPM_TOC_MAGIC			0x67727430 /* grt0 */
+#define RPM_TOC_HDR_SIZE		8
+#define RPM_TOC_ENTRY_SIZE		12
+#define RPM_TX_FIFO_ID			0x61703272 /* ap2r */
+#define RPM_RX_FIFO_ID			0x72326170 /* r2ap */
+
+#define GLINK_VERSION_1			1
+
+#define GLINK_CMD_VERSION		0
+#define GLINK_CMD_VERSION_ACK		1
+#define GLINK_CMD_OPEN			2
+#define GLINK_CMD_CLOSE			3
+#define GLINK_CMD_OPEN_ACK		4
+#define GLINK_CMD_INTENT		5
+#define GLINK_CMD_RX_DONE		6
+#define GLINK_CMD_RX_INTENT_REQ		7
+#define GLINK_CMD_RX_INTENT_REQ_ACK	8
+#define GLINK_CMD_TX_DATA		9
+#define GLINK_CMD_CLOSE_ACK		11
+#define GLINK_CMD_TX_DATA_CONT		12
+#define GLINK_CMD_READ_NOTIF		13
+#define GLINK_CMD_RX_DONE_W_REUSE	14
+#define GLINK_CMD_SIGNALS		15
+
+#define GLINK_NAME_SIZE			32
+#define GLINK_INTENT_PAIR_SIZE		8
+
+#define RPM_CHANNEL_NAME		"rpm_requests"
+#define RPM_CHANNEL_LCID		1
+#define SSR_CHANNEL_NAME		"glink_ssr"
+#define SSR_CHANNEL_LCID		2
+#define GLINK_SSR_DO_CLEANUP		0
+#define GLINK_SSR_APSS			"apss"
+#define RPM_TIMEOUT_US			(5 * 1000 * 1000)
+#define RPM_RESET_TIMEOUT_US		(100 * 1000)
+/* Packets to and from the RPM may not exceed 256 bytes */
+#define RPM_MAX_MSG_SIZE		256
+
+#define RPM_SERVICE_TYPE_REQUEST	0x00716572 /* "req\0" */
+#define RPM_MSG_TYPE_ERR		0x00727265 /* "err\0" */
+#define RPM_MSG_TYPE_MSG_ID		0x2367736d /* "msg#" */
+
+struct glink_msg {
+	__le16 cmd;
+	__le16 param1;
+	__le32 param2;
+} __packed;
+
+struct glink_data_hdr {
+	struct glink_msg msg;
+	__le32 chunk_size;
+	__le32 left_size;
+} __packed;
+
+struct qcom_rpm_header {
+	__le32 service_type;
+	__le32 length;
+};
+
+struct qcom_rpm_request {
+	__le32 msg_id;
+	__le32 flags;
+	__le32 type;
+	__le32 id;
+	__le32 data_len;
+};
+
+struct glink_rpm_pipe {
+	void __iomem *tail;
+	void __iomem *head;
+	void __iomem *fifo;
+	u32 length;
+};
+
+struct glink_rpm {
+	struct glink_rpm_pipe rx;
+	struct glink_rpm_pipe tx;
+	struct mbox_chan mbox;
+	int link_err;
+	bool started;
+	u32 features;
+	u16 rcid;
+	bool remote_open;
+	bool open_acked;
+	u16 ssr_rcid;
+	bool ssr_open_acked;
+	bool msg_ready;
+	u32 msg_id;
+	u32 msg_len;
+	u8 msg[RPM_MAX_MSG_SIZE];
+};
+
+/* The message RAM only takes 32-bit accesses. */
+static u32 glink_rpm_rx_avail(struct glink_rpm_pipe *pipe)
+{
+	u32 head = readl(pipe->head);
+	u32 tail = readl(pipe->tail);
+
+	return head < tail ? pipe->length - tail + head : head - tail;
+}
+
+static void glink_rpm_rx_peek(struct glink_rpm_pipe *pipe, u32 offset,
+			      void *data, u32 count)
+{
+	u32 pos = (readl(pipe->tail) + offset) % pipe->length;
+	u8 *buf = data;
+	u32 word, n;
+
+	while (count) {
+		word = readl(pipe->fifo + pos);
+		n = min_t(u32, count, sizeof(word));
+		memcpy(buf, &word, n);
+		buf += n;
+		count -= n;
+		pos += sizeof(word);
+		if (pos >= pipe->length)
+			pos = 0;
+	}
+}
+
+static void glink_rpm_rx_advance(struct glink_rpm_pipe *pipe, u32 count)
+{
+	writel((readl(pipe->tail) + count) % pipe->length, pipe->tail);
+}
+
+static u32 glink_rpm_tx_avail(struct glink_rpm_pipe *pipe)
+{
+	u32 head = readl(pipe->head);
+	u32 tail = readl(pipe->tail);
+
+	return tail <= head ? pipe->length - head + tail : tail - head;
+}
+
+static int glink_rpm_tx(struct glink_rpm *rpm, const void *hdr, u32 hlen,
+			const void *data, u32 dlen)
+{
+	struct glink_rpm_pipe *pipe = &rpm->tx;
+	u8 buf[sizeof(struct glink_data_hdr) + RPM_MAX_MSG_SIZE];
+	u32 len = ALIGN(hlen + dlen, 8);
+	ulong start = timer_get_us();
+	u32 head, word, i;
+
+	if (len > sizeof(buf) || len >= pipe->length)
+		return -EINVAL;
+
+	memset(buf, 0, len);
+	memcpy(buf, hdr, hlen);
+	if (dlen)
+		memcpy(buf + hlen, data, dlen);
+
+	/* Never fill the FIFO completely: head == tail means empty */
+	while (glink_rpm_tx_avail(pipe) <= len) {
+		if (timer_get_us() - start > RPM_TIMEOUT_US)
+			return -ETIMEDOUT;
+		udelay(10);
+	}
+
+	head = readl(pipe->head);
+	for (i = 0; i < len; i += sizeof(word)) {
+		memcpy(&word, buf + i, sizeof(word));
+		writel(word, pipe->fifo + head);
+		head += sizeof(word);
+		if (head >= pipe->length)
+			head = 0;
+	}
+	writel(head, pipe->head);
+
+	return mbox_send(&rpm->mbox, NULL);
+}
+
+static int glink_rpm_send_cmd(struct glink_rpm *rpm, u16 cmd, u16 param1,
+			      u32 param2)
+{
+	struct glink_msg msg = {
+		.cmd = cpu_to_le16(cmd),
+		.param1 = cpu_to_le16(param1),
+		.param2 = cpu_to_le32(param2),
+	};
+
+	return glink_rpm_tx(rpm, &msg, sizeof(msg), NULL, 0);
+}
+
+static int glink_rpm_rx_data(struct udevice *dev, struct glink_rpm *rpm,
+			     u32 avail)
+{
+	struct glink_data_hdr hdr;
+	u32 chunk, left;
+	u16 cmd, rcid;
+
+	if (avail < sizeof(hdr))
+		return -EAGAIN;
+
+	glink_rpm_rx_peek(&rpm->rx, 0, &hdr, sizeof(hdr));
+	cmd = le16_to_cpu(hdr.msg.cmd);
+	rcid = le16_to_cpu(hdr.msg.param1);
+	chunk = le32_to_cpu(hdr.chunk_size);
+	left = le32_to_cpu(hdr.left_size);
+
+	if (avail < sizeof(hdr) + chunk)
+		return -EAGAIN;
+
+	if (rpm->rcid && rcid == rpm->rcid) {
+		if (cmd == GLINK_CMD_TX_DATA)
+			rpm->msg_len = 0;
+
+		if (rpm->msg_len + chunk > sizeof(rpm->msg)) {
+			dev_err(dev, "RPM message too long, dropped\n");
+			rpm->msg_len = 0;
+		} else {
+			glink_rpm_rx_peek(&rpm->rx, sizeof(hdr),
+					  rpm->msg + rpm->msg_len, chunk);
+			rpm->msg_len += chunk;
+			if (!left)
+				rpm->msg_ready = true;
+		}
+	}
+
+	glink_rpm_rx_advance(&rpm->rx, ALIGN(sizeof(hdr) + chunk, 8));
+
+	return 0;
+}
+
+/* Handle everything the RPM has sent so far */
+static int glink_rpm_rx(struct udevice *dev, struct glink_rpm *rpm)
+{
+	char name[GLINK_NAME_SIZE];
+	struct glink_msg msg;
+	u32 avail, extra, param2;
+	u16 cmd, param1;
+	int ret;
+
+	for (;;) {
+		avail = glink_rpm_rx_avail(&rpm->rx);
+		if (avail < sizeof(msg))
+			return 0;
+
+		glink_rpm_rx_peek(&rpm->rx, 0, &msg, sizeof(msg));
+		cmd = le16_to_cpu(msg.cmd);
+		param1 = le16_to_cpu(msg.param1);
+		param2 = le32_to_cpu(msg.param2);
+
+		switch (cmd) {
+		case GLINK_CMD_VERSION:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			if (param1 == GLINK_VERSION_1)
+				rpm->features &= param2;
+			if (param1) {
+				ret = glink_rpm_send_cmd(rpm, GLINK_CMD_VERSION_ACK,
+							 GLINK_VERSION_1,
+							 rpm->features);
+				if (ret)
+					return ret;
+			}
+			break;
+		case GLINK_CMD_VERSION_ACK:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			if (!param1 || (param1 == GLINK_VERSION_1 &&
+					param2 == rpm->features))
+				break;
+			if (param1 == GLINK_VERSION_1)
+				rpm->features &= param2;
+			ret = glink_rpm_send_cmd(rpm, GLINK_CMD_VERSION,
+						 GLINK_VERSION_1, rpm->features);
+			if (ret)
+				return ret;
+			break;
+		case GLINK_CMD_OPEN:
+			/* the upper 16 bits of param2 are the priority */
+			extra = ALIGN(param2 & 0xffff, 8);
+			if (avail < sizeof(msg) + extra)
+				return 0;
+			memset(name, 0, sizeof(name));
+			glink_rpm_rx_peek(&rpm->rx, sizeof(msg), name,
+					  min_t(u32, extra, sizeof(name) - 1));
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg) + extra);
+			if (!strcmp(name, RPM_CHANNEL_NAME)) {
+				rpm->rcid = param1;
+				rpm->remote_open = true;
+			} else if (!strcmp(name, SSR_CHANNEL_NAME)) {
+				rpm->ssr_rcid = param1;
+			} else {
+				dev_dbg(dev, "ignoring channel %s\n", name);
+			}
+			break;
+		case GLINK_CMD_OPEN_ACK:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			if (param1 == RPM_CHANNEL_LCID)
+				rpm->open_acked = true;
+			if (param1 == SSR_CHANNEL_LCID)
+				rpm->ssr_open_acked = true;
+			break;
+		case GLINK_CMD_CLOSE:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			if (rpm->rcid && param1 == rpm->rcid) {
+				rpm->remote_open = false;
+				rpm->open_acked = false;
+				rpm->rcid = 0;
+				/* refuse further requests instead of timing out */
+				rpm->link_err = -ENOTCONN;
+			}
+			ret = glink_rpm_send_cmd(rpm, GLINK_CMD_CLOSE_ACK,
+						 param1, 0);
+			if (ret)
+				return ret;
+			break;
+		case GLINK_CMD_INTENT:
+			extra = param2 * GLINK_INTENT_PAIR_SIZE;
+			if (avail < sizeof(msg) + extra)
+				return 0;
+			glink_rpm_rx_advance(&rpm->rx,
+					     ALIGN(sizeof(msg) + extra, 8));
+			break;
+		case GLINK_CMD_READ_NOTIF:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			ret = mbox_send(&rpm->mbox, NULL);
+			if (ret)
+				return ret;
+			break;
+		case GLINK_CMD_CLOSE_ACK:
+		case GLINK_CMD_RX_DONE:
+		case GLINK_CMD_RX_DONE_W_REUSE:
+		case GLINK_CMD_RX_INTENT_REQ:
+		case GLINK_CMD_RX_INTENT_REQ_ACK:
+		case GLINK_CMD_SIGNALS:
+			glink_rpm_rx_advance(&rpm->rx, sizeof(msg));
+			break;
+		case GLINK_CMD_TX_DATA:
+		case GLINK_CMD_TX_DATA_CONT:
+			ret = glink_rpm_rx_data(dev, rpm, avail);
+			if (ret == -EAGAIN)
+				return 0;
+			break;
+		default:
+			dev_err(dev, "unhandled GLINK command %u\n", cmd);
+			return -EPROTO;
+		}
+	}
+}
+
+static int glink_rpm_wait(struct udevice *dev, struct glink_rpm *rpm,
+			  const bool *done)
+{
+	ulong start = timer_get_us();
+	int ret;
+
+	for (;;) {
+		ret = glink_rpm_rx(dev, rpm);
+		if (ret)
+			return ret;
+		if (*done)
+			return 0;
+		if (timer_get_us() - start > RPM_TIMEOUT_US)
+			return -ETIMEDOUT;
+		udelay(10);
+	}
+}
+
+static int glink_rpm_parse_toc(struct udevice *dev, struct glink_rpm *rpm,
+			       void __iomem *msg_ram, u32 size)
+{
+	void __iomem *toc = msg_ram + size - RPM_TOC_SIZE;
+	struct glink_rpm_pipe *pipe;
+	u32 count, id, offset, len, i;
+
+	if (readl(toc) != RPM_TOC_MAGIC) {
+		dev_dbg(dev, "RPM TOC has invalid magic\n");
+		return -EINVAL;
+	}
+
+	count = readl(toc + 4);
+	if (count > (RPM_TOC_SIZE - RPM_TOC_HDR_SIZE) / RPM_TOC_ENTRY_SIZE) {
+		dev_dbg(dev, "invalid number of RPM TOC entries\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < count; i++) {
+		void __iomem *entry = toc + RPM_TOC_HDR_SIZE +
+				      i * RPM_TOC_ENTRY_SIZE;
+
+		id = readl(entry);
+		offset = readl(entry + 4);
+		len = readl(entry + 8);
+
+		if (offset > size || len > size - offset) {
+			dev_dbg(dev, "RPM TOC entry with invalid size\n");
+			continue;
+		}
+
+		if (id == RPM_RX_FIFO_ID)
+			pipe = &rpm->rx;
+		else if (id == RPM_TX_FIFO_ID)
+			pipe = &rpm->tx;
+		else
+			continue;
+
+		/* tail and head indices, then the FIFO itself */
+		pipe->length = len;
+		pipe->tail = msg_ram + offset;
+		pipe->head = msg_ram + offset + 4;
+		pipe->fifo = msg_ram + offset + 8;
+	}
+
+	if (!rpm->rx.fifo || !rpm->tx.fifo) {
+		dev_dbg(dev, "RPM TOC has no rx/tx FIFO\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Only look the link up: an edge U-Boot cannot use (no message RAM, an
+ * unsupported mailbox) must not fail the probe, since the RPM clock stubs
+ * and other children sit below it. The error is reported once a consumer
+ * asks for the link.
+ */
+static int glink_rpm_probe(struct udevice *dev)
+{
+	struct glink_rpm *rpm = dev_get_priv(dev);
+	fdt_addr_t base = FDT_ADDR_T_NONE;
+	fdt_size_t size = 0;
+	ofnode node;
+	int ret;
+
+	node = ofnode_parse_phandle(dev_ofnode(dev), "qcom,rpm-msg-ram", 0);
+	if (ofnode_valid(node))
+		base = ofnode_get_addr_size_index(node, 0, &size);
+	if (base == FDT_ADDR_T_NONE || size < RPM_TOC_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = glink_rpm_parse_toc(dev, rpm, (void __iomem *)base, size);
+	if (ret)
+		goto out;
+
+	ret = mbox_get_by_index(dev, 0, &rpm->mbox);
+
+out:
+	rpm->link_err = ret;
+	if (ret)
+		dev_dbg(dev, "RPM link unusable: %d\n", ret);
+
+	return 0;
+}
+
+static const struct udevice_id glink_rpm_ids[] = {
+	{ .compatible = "qcom,glink-rpm" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_glink_rpm) = {
+	.name = "qcom_glink_rpm",
+	.id = UCLASS_NOP,
+	.of_match = glink_rpm_ids,
+	.bind = dm_scan_fdt_dev,
+	.probe = glink_rpm_probe,
+	.priv_auto = sizeof(struct glink_rpm),
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
+
+/*
+ * Return -EAGAIN for the acknowledgment of an earlier request (one that
+ * timed out), so that the caller keeps waiting for its own.
+ */
+static int smd_rpm_parse_ack(struct udevice *dev, const u8 *data, u32 len,
+			     u32 msg_id)
+{
+	u32 type, mlen, hdr_len, off, end;
+	char err[32];
+	int status = 0;
+
+	if (len < sizeof(struct qcom_rpm_header))
+		return -EINVAL;
+
+	hdr_len = get_unaligned_le32(data + 4);
+	if (get_unaligned_le32(data) != RPM_SERVICE_TYPE_REQUEST ||
+	    hdr_len > len - sizeof(struct qcom_rpm_header)) {
+		dev_err(dev, "invalid RPM response\n");
+		return -EINVAL;
+	}
+
+	off = sizeof(struct qcom_rpm_header);
+	end = off + hdr_len;
+	while (off + 8 <= end) {
+		type = get_unaligned_le32(data + off);
+		mlen = get_unaligned_le32(data + off + 4);
+		if (mlen > end - off - 8)
+			break;
+
+		if (type == RPM_MSG_TYPE_MSG_ID && mlen >= 4 &&
+		    get_unaligned_le32(data + off + 8) != msg_id)
+			return -EAGAIN;
+
+		if (type == RPM_MSG_TYPE_ERR) {
+			memset(err, 0, sizeof(err));
+			memcpy(err, data + off + 8,
+			       min_t(u32, mlen, sizeof(err) - 1));
+			dev_dbg(dev, "RPM error: %s\n", err);
+			status = strcmp(err, "resource does not exist") ?
+				 -EIO : -ENXIO;
+		}
+
+		off = ALIGN(off + 8 + mlen, 4);
+	}
+
+	return status;
+}
+
+static int glink_rpm_send_data(struct glink_rpm *rpm, u16 lcid,
+			       const void *data, u32 len)
+{
+	struct glink_data_hdr hdr;
+
+	hdr.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA);
+	hdr.msg.param1 = cpu_to_le16(lcid);
+	hdr.msg.param2 = 0;
+	hdr.chunk_size = cpu_to_le32(len);
+	hdr.left_size = 0;
+
+	rpm->msg_ready = false;
+
+	return glink_rpm_tx(rpm, &hdr, sizeof(hdr), data, len);
+}
+
+/* Acknowledge the RPM's open of a channel and open our end of it */
+static int glink_rpm_open(struct udevice *edge, struct glink_rpm *rpm,
+			  u16 rcid, u16 lcid, const char *name,
+			  const bool *acked)
+{
+	struct {
+		struct glink_msg msg;
+		char name[GLINK_NAME_SIZE];
+	} req;
+	u32 name_len = strlen(name) + 1;
+	int ret;
+
+	ret = glink_rpm_send_cmd(rpm, GLINK_CMD_OPEN_ACK, rcid, 0);
+	if (ret)
+		return ret;
+
+	memset(&req, 0, sizeof(req));
+	req.msg.cmd = cpu_to_le16(GLINK_CMD_OPEN);
+	req.msg.param1 = cpu_to_le16(lcid);
+	req.msg.param2 = cpu_to_le32(name_len);
+	strlcpy(req.name, name, sizeof(req.name));
+
+	ret = glink_rpm_tx(rpm, &req, ALIGN(sizeof(req.msg) + name_len, 8),
+			   NULL, 0);
+	if (ret)
+		return ret;
+
+	return glink_rpm_wait(edge, rpm, acked);
+}
+
+/* Bring the link and the rpm_requests channel up on first use */
+static int glink_rpm_connect(struct udevice *edge, struct glink_rpm *rpm)
+{
+	int ret;
+
+	if (rpm->link_err)
+		return rpm->link_err;
+	if (rpm->open_acked)
+		return 0;
+
+	if (!rpm->started) {
+		rpm->started = true;
+		writel(0, rpm->tx.head);
+		writel(0, rpm->rx.tail);
+		ret = glink_rpm_send_cmd(rpm, GLINK_CMD_VERSION,
+					 GLINK_VERSION_1, rpm->features);
+		if (ret)
+			goto err;
+	}
+
+	/* The RPM opens the channel once the versions are agreed on */
+	ret = glink_rpm_wait(edge, rpm, &rpm->remote_open);
+	if (ret)
+		goto err;
+
+	ret = glink_rpm_open(edge, rpm, rpm->rcid, RPM_CHANNEL_LCID,
+			     RPM_CHANNEL_NAME, &rpm->open_acked);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	rpm->link_err = ret;
+	dev_err(edge, "RPM did not open %s: %d\n", RPM_CHANNEL_NAME, ret);
+
+	return ret;
+}
+
+int qcom_rpm_smd_write(struct udevice *dev, int state, u32 type, u32 id,
+		       void *buf, size_t count)
+{
+	struct udevice *edge = dev_get_parent(dev);
+	struct glink_rpm *rpm = dev_get_priv(edge);
+	struct {
+		struct qcom_rpm_header hdr;
+		struct qcom_rpm_request req;
+		u8 payload[RPM_MAX_MSG_SIZE];
+	} pkt;
+	u32 size = sizeof(pkt.hdr) + sizeof(pkt.req) + count;
+	u32 msg_id;
+	int ret;
+
+	if (size >= RPM_MAX_MSG_SIZE)
+		return -EINVAL;
+
+	ret = glink_rpm_connect(edge, rpm);
+	if (ret)
+		return ret;
+
+	pkt.hdr.service_type = cpu_to_le32(RPM_SERVICE_TYPE_REQUEST);
+	pkt.hdr.length = cpu_to_le32(sizeof(pkt.req) + count);
+	msg_id = ++rpm->msg_id;
+	pkt.req.msg_id = cpu_to_le32(msg_id);
+	pkt.req.flags = cpu_to_le32(state);
+	pkt.req.type = cpu_to_le32(type);
+	pkt.req.id = cpu_to_le32(id);
+	pkt.req.data_len = cpu_to_le32(count);
+	memcpy(pkt.payload, buf, count);
+
+	ret = glink_rpm_send_data(rpm, RPM_CHANNEL_LCID, &pkt, size);
+	if (ret)
+		return ret;
+
+	for (;;) {
+		ret = glink_rpm_wait(edge, rpm, &rpm->msg_ready);
+		if (ret) {
+			dev_err(dev, "no RPM response: %d\n", ret);
+			return ret;
+		}
+
+		ret = smd_rpm_parse_ack(dev, rpm->msg, rpm->msg_len, msg_id);
+		if (ret != -EAGAIN)
+			return ret;
+		rpm->msg_ready = false;
+	}
+}
+
+int qcom_rpm_smd_ready(struct udevice *dev)
+{
+	struct udevice *edge = dev_get_parent(dev);
+
+	return glink_rpm_connect(edge, dev_get_priv(edge));
+}
+
+/*
+ * Hand the link over in the state the kernel expects. The RPM announces its
+ * channels once per link, and the kernel's GLINK driver waits for that
+ * announcement before it opens rpm_requests. Ask the RPM, over its glink_ssr
+ * channel as Linux does after a remote processor crash, to clean up its
+ * channels to the application processor: it then resets the whole link,
+ * FIFO indices included, and announces the channels again when the kernel
+ * connects.
+ *
+ * Linux itself never sends this for "apss": it sends DO_CLEANUP on behalf of
+ * a stopped remote processor and waits for CLEANUP_DONE. The RPM answers
+ * the "apss" cleanup by resetting the link instead, so completion is
+ * detected by all four FIFO indices reading 0. Nothing is done if U-Boot
+ * never used the link.
+ */
+static int smd_rpm_remove(struct udevice *dev)
+{
+	struct udevice *edge = dev_get_parent(dev);
+	struct glink_rpm *rpm = dev_get_priv(edge);
+	struct {
+		__le32 version;
+		__le32 command;
+		__le32 seq_num;
+		__le32 name_len;
+		char name[32];
+	} cleanup;
+	ulong start;
+	int ret;
+
+	if (!rpm->started)
+		return 0;
+
+	if (!rpm->ssr_rcid) {
+		ret = -ENOENT;
+		goto err;
+	}
+
+	ret = glink_rpm_open(edge, rpm, rpm->ssr_rcid, SSR_CHANNEL_LCID,
+			     SSR_CHANNEL_NAME, &rpm->ssr_open_acked);
+	if (ret)
+		goto err;
+
+	memset(&cleanup, 0, sizeof(cleanup));
+	cleanup.command = cpu_to_le32(GLINK_SSR_DO_CLEANUP);
+	cleanup.seq_num = cpu_to_le32(1);
+	cleanup.name_len = cpu_to_le32(strlen(GLINK_SSR_APSS));
+	strlcpy(cleanup.name, GLINK_SSR_APSS, sizeof(cleanup.name));
+
+	ret = glink_rpm_send_data(rpm, SSR_CHANNEL_LCID, &cleanup,
+				  sizeof(cleanup));
+	if (ret)
+		goto err;
+
+	/*
+	 * The RPM answers by resetting the link rather than with
+	 * cleanup_done; do not read the receive FIFO meanwhile, the reset
+	 * discards it.
+	 */
+	start = timer_get_us();
+	while (readl(rpm->tx.head) || readl(rpm->tx.tail) ||
+	       readl(rpm->rx.head) || readl(rpm->rx.tail)) {
+		if (timer_get_us() - start > RPM_RESET_TIMEOUT_US) {
+			ret = -ETIMEDOUT;
+			goto err;
+		}
+		udelay(10);
+	}
+
+	return 0;
+
+err:
+	dev_err(dev, "failed to reset the RPM link, the kernel may not reach the RPM: %d\n",
+		ret);
+	return 0;
+}
+
+static const struct udevice_id smd_rpm_ids[] = {
+	{ .compatible = "qcom,glink-smd-rpm" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_smd_rpm) = {
+	.name = "qcom_smd_rpm",
+	.id = UCLASS_NOP,
+	.of_match = smd_rpm_ids,
+	.bind = dm_scan_fdt_dev,
+	.remove = smd_rpm_remove,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF | DM_FLAG_OS_PREPARE,
+};
diff --git a/include/soc/qcom/smd-rpm.h b/include/soc/qcom/smd-rpm.h
new file mode 100644
index 00000000000..10d2f188b61
--- /dev/null
+++ b/include/soc/qcom/smd-rpm.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm SMD RPM interface, after Linux include/linux/soc/qcom/smd-rpm.h.
+ */
+#ifndef __QCOM_SMD_RPM_H__
+#define __QCOM_SMD_RPM_H__
+
+#include <linux/types.h>
+
+struct udevice;
+
+#define QCOM_SMD_RPM_ACTIVE_STATE	0
+#define QCOM_SMD_RPM_SLEEP_STATE	1
+
+/**
+ * qcom_rpm_smd_write() - send a resource request to the RPM and wait for
+ *			  its acknowledgment
+ *
+ * @rpm:	the rpm-requests device (the parent of the RPM consumers)
+ * @state:	QCOM_SMD_RPM_ACTIVE_STATE or QCOM_SMD_RPM_SLEEP_STATE
+ * @type:	resource type, e.g. "rwcx" as a little-endian u32
+ * @id:		resource id
+ * @buf:	key/length/value triplets
+ * @count:	size of @buf in bytes
+ *
+ * Return: 0 on success, -ENXIO if the RPM does not know the resource, -EIO
+ * if it rejects the request, another negative errno on failure.
+ */
+int qcom_rpm_smd_write(struct udevice *rpm, int state, u32 type, u32 id,
+		       void *buf, size_t count);
+
+/**
+ * qcom_rpm_smd_ready() - bring the link to the RPM up if it is not yet
+ *
+ * @rpm:	the rpm-requests device
+ *
+ * Return: 0 when requests can be sent, a negative errno otherwise.
+ */
+int qcom_rpm_smd_ready(struct udevice *rpm);
+
+#endif /* __QCOM_SMD_RPM_H__ */

-- 
2.53.0

