Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6FF606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xHV4ifkP;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Eti/VwdK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MNUMyAO7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5881606F7;
	Sun, 15 Nov 2026 11:51:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJ1k0f8_LxbB; Sun, 15 Nov 2026 11:51:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B891660628
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794743498;
	b=K9BB8dm4e/ZForLOG3C2AhLob0TFnKvuLFMooSq6oMD5UXrmr9NXCC635IVYff+6ptMq
	 UBOlssHb2+bI7cc/ahFTaUWj1vkU41wy/9xZPDvqDAA/3bhb2v8pPDMzWM5ykP+LO/Slo
	 t8dRUOBshqHDGrjdYavYKzF+6w6BvKboTHym4cq9EZzfTSTB6cJiehrBJHfjRc3bNU7h3
	 /oabTqa5G6lB6dVUX5SZUEvSzZECXMdq4IxsxpTzLq1UxIkOEZ1SOplDa/i1p2m9KZtbn
	 q/Go4X7M1egm3eQhJyRlVv/EeTd8KTcCL8pRiSqoMsrcvmYKQYcR5LSggnlV1IMNHiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794743498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+gdzU+vK2NiRJi8/UdygIqGaqAxKgQhdNBtmZJl79KU=;
	b=LFZ5GjEETpQ0FgZGQ1wAz3I0BolpL6Oxq8prEQY0ApT4/vaiGecDc4WLqWN17euG15au
	 LjE6Pke1CQqQ6n3+z86RFTuoIZnpdXHw0rpCNxD/Ge1MWqBcOuQbMJ8SrBy2Xl0Xgfv2z
	 O7VR34sYk7IsOPIkwAzaQ8LF1qUZCj0G/OqSAbkCfDRs3uLGx7//0wPeQDXWU//mNjeow
	 5R0ch0BvfqevKeyVBGz4A1HiH4C/AaZ1Ciui4JBrW2CBDwPGhYorJdUvmCf5I8ZTUccs8
	 VDecZOWiW4+dA/A1NZ+vONc/kvMkPFGYkqx7BJrvwIQ78SZVgwxbctc2Ef0GKRso1zQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794743498;
	bh=+gdzU+vK2NiRJi8/UdygIqGaqAxKgQhdNBtmZJl79KU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xHV4ifkPNvFLNJxQtxM58cd8MS0YdhIezs4qgcZrM8WnWBA/6WRLVxEw39e9jZXrV
	 sdfjro4kFxuq9fTNiD+FKp1ncIs8jwqKJETzSQSyUWMsFx2cDC1IhMJvWYqpahIoBp
	 SdweHTozhgTFpm1rvOCoJwhzKcQLkQhauBgHuHY4WfhW1iNNHlkQMd6nfTIlGwaJXs
	 LlKxxGZqDEYCD4FHrYBJpag+mdpfRPEu4hQ5OEv2vATVw3n9V7lI8sltIiU/OaTvFe
	 XJgMKnFavQvVLRWpQ5wEwjlrS8o8ZOCM5H6+lmaAZWGKnfspT5Z8Yq64yT/wg8RfyP
	 /dIzXCWeDXjZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B891660628;
	Sun, 15 Nov 2026 11:51:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D34342FB
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C521F8105B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7X27dHXcRW9 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7841981076
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Eti/VwdK; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MNUMyAO7
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7841981076
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:34 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFBlre03604142
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +gdzU+vK2NiRJi8/UdygIqGaqAxKgQhdNBtmZJl79KU=; b=Eti/VwdK4yVmMGE6
 kLDLBK86ZT9FUEcwmOkhRNg6pA6TtPGC4C+E3M4Op5bD5TWBukVt+STAqCxUBDsD
 WxwIusNxyIL8QQO5Eo613u1YivKtZFwvKgLFlvm81pbD+OpGM/UvmrKYXX8n6NNX
 3NeSCYxIhhBGz6a389+KWtT3Cl5AtiHoFllpLtDdqCV/+IzeNGtQXkqaM5MNGY36
 14IxMI2QNfME4Wy7n1SQ/vvqq9O7vDcGHiPwK430nbNlsF8XveQiq9Qnw2WLXCzD
 nbUP9OyD+LmdsxJf1fEzFdAHfPkEF9gJXGxkJoiVVV3QwYv/85B5h2g4R96nFRVz
 8Vntxg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdtv3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:51:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-944138ed63fso408820385a.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794743493; x=1795348293;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+gdzU+vK2NiRJi8/UdygIqGaqAxKgQhdNBtmZJl79KU=;
 b=MNUMyAO70jcZi4D5hp2OeKrPxltRHvyHkrx5oaZIEv1nGkO9MIkOxfkgleUAUEEMFU
 urQJVYN4ToLtpr4MFVwRM6Hhk2NmUMkswITv2q+IT64ISznD4+U/YB4uhfsrrCYU5plB
 +OO07REw3qAiWu3Wtyh8ZdOFpz4IBdJ+Gal4JEr7nS3oeA4M7x94f8Bbvw3MKRTRffMS
 KlROrEFn3pfgtjTJzcJygNvzerwQY9CXgP/WCga9juo1L8FUk/qvb6OIwn/JpPfn9l/E
 9+0H2w5E9tMbzYw8oyxgpl4SUhGn/4qMf/GSsBM4fRIV1/BSV5WAjjmAXCA8ijajS7qF
 AfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794743493; x=1795348293;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+gdzU+vK2NiRJi8/UdygIqGaqAxKgQhdNBtmZJl79KU=;
 b=oFOraqxlPyhy/wNPouqdOnVTydGfibyXnJmzBS6RpVgziLEM4FGAaZ0px9LiIPz+wp
 fndGYV8eqHQGTd9qy5FIhlBPzvlhfGwmjtqpvr94rvxobR6EFcVuKi0PTwBvFaImiAVN
 8A+kMQHXcd9ARNKpiGabQZTFlEDpNhSqoGmw/Fxwcl52ADzyz9A+IK7l1WONw54PpmqC
 4suSXM+o6o6pjnTwiOljKXu7asSc4L4SYWGWGmovO1SwsH/xo2fQQXCkVe9F1Zq8Aqui
 Ic/D55kXxX1dhKmUBIC5d7HQQZ7Ozt4RxWhcvwOSP7uhP+1U2r8BxFprTHQ9xxckNnUA
 D9pg==
X-Forwarded-Encrypted: i=1;
 AL+hErGL5z4FJi5TLtEorHkieVJdXSPqPDQcPIh9w65dsYyoduTEeYBHfhbzLZr50Kv5bexbYqSQ1RE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/UtvMdwRkMxqeS3IZEi033uMZ3nxQcVZGw2apoyLldIvsXZK82
 2UTbbFetUlvx/LnopswEiQDfZ0BTtXruiL5G5qNlsxr2LQxApIrLtkLWdx2ktLA2FJO1oYDsnzI
 ankjmLjEU0CtoN08OYI+SVnEkRRVwFpr/JkWJbyYXFcUwQ7r921FbloRiiJnW5/WnTyeCoXI=
X-Gm-Gg: AYBFou0E95OV5FzuuyiXcLEil8a2KpsW4CJ56dDODVK1+zjsWueHRDSGYFkPAy4saPW
 vpL8SFG5jNwIn+pkqryv/rjgYKxbe5kqCV4pvQ21MVIkjzVwNqMZ5e2aFlpdrx1U3ic5Ihx01DO
 hYfARDJEJzzBPfYFOu+APUv51yUvyc7ZJJMXMq9Xz8TaE7HN4lTGFjG21XuOLw65Iq2JkEudQUt
 PTsEi0L1JCnJ7Clr2AP8kHIQpa20FZTMU7/I4XYZTiBfa7aZ3doINLLS+u/zub5gftjBhED4qMI
 HppSiOGeNHT+OrJiXJcTkD7+SM3yLtm8hXbzX+7LaRkMJqkzEcBsrNtAtVTPGPXEL1w43WBuff8
 CILtMI1tup4AYNMxV0NUQho0T+NgsPmyJF1l+lFGZR841XvzThXkcInPECvoEjeeex4l0G4vhS1
 yhc2AkJp/dsisQ
X-Received: by 2002:a05:620a:4106:b0:946:f22d:1efc with SMTP id
 af79cd13be357-9494bcdb72dmr1315088485a.67.1794743493300; 
 Sun, 15 Nov 2026 03:51:33 -0800 (PST)
X-Received: by 2002:a05:620a:4106:b0:946:f22d:1efc with SMTP id
 af79cd13be357-9494bcdb72dmr1315086885a.67.1794743492877; 
 Sun, 15 Nov 2026 03:51:32 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b3dbaesm299969066b.32.2026.11.15.03.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:51:32 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 12:51:20 +0100
Subject: [PATCH 3/4] power: domain: add the Qualcomm RPM power domain
 driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-qcom-rpm-glink-v1-3-6255beacc93b@oss.qualcomm.com>
References: <20261115-qcom-rpm-glink-v1-0-6255beacc93b@oss.qualcomm.com>
In-Reply-To: <20261115-qcom-rpm-glink-v1-0-6255beacc93b@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6af99cc6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=AGc_htT3jLklbCNWXXUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NiBTYWx0ZWRfX8I7uThMrHhHj
 aKfp2pbqy3fEIUKEkEOCb6LJ+OMtfL7yzqR2A1S8IE4Y//EaDHSJ16DR3bYhYLIt+l8sBnLhZtd
 +/bx5TeaKq2d7SCGJCcQOrTS8KApSXU=
X-Proofpoint-ORIG-GUID: OtcrjcT_jyJT6isM7oFwOowmHQC7Xs4s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NiBTYWx0ZWRfX+fnSqLLaQu3C
 zpTXA7pvCS7l2oi4RxhWJFvmV+mZhIdOLG+if+zqAsJU7Vm10JbmucH/5wfv1LMvkVolz9gTzih
 hn+kvtV0aWLr/6mot4CUARkju5MdCV8H3Yqm/jxYALVGrnpCeUup42maPjzWwRDXCuw0HS17NX8
 n8spxWCTbsv1m0ESHMm82babGtkSFPI8MNkTZTRyH8ndlnayW2JD7DfT+9a4kYh0rRIkhlLtRQa
 1EMTNJc1dkJfPS8xQzQ1Jc4UhNXZPPm1TYyi+KKTr0BxEhmtLs+W0qNkKD73xSe5W75lWmqtrgs
 kvkQMW8xd+TwDFXvHrhgE4v7PNVtUBa+weST+8D7ucez2EbPSlbzQSnf4FBuUwMkuZ6wJqllS0U
 EiSdpT2oc/HLttpmOmgY4W/G2k7n3WLQzCdRYR/2zezDM5mKt80pkOtmy4iV1O4Z6TILZ9usWP1
 2irWzlmVp5up9YoRh5g==
X-Proofpoint-GUID: OtcrjcT_jyJT6isM7oFwOowmHQC7Xs4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150046
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a power domain driver for the CX/MX rails of RPM-based SoCs, with
the QCM2290 and Shikra tables of Linux's rpmpd.

Powering on sends only the "swen" enable vote, like Linux's
rpmpd_power_on() without a performance state, so the level voted by
the boot firmware stays. Powering off keeps the vote: dropping CX or MX
before the kernel starts would take the buses down. Without a usable
RPM link the probe fails with -ENODEV and consumers carry on as before.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/power/domain/Kconfig      |   7 ++
 drivers/power/domain/Makefile     |   1 +
 drivers/power/domain/qcom-rpmpd.c | 169 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 13a661ce04f..7a469468298 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -102,6 +102,13 @@ config QCOM_RPMH_POWER_DOMAIN
 	  The RPMH power domain driver is responsible for managing power
 	  domains on Qualcomm SoCs.
 
+config QCOM_RPM_POWER_DOMAIN
+	bool "Enable the QCOM RPM power domain driver"
+	depends on POWER_DOMAIN && QCOM_SMD_RPM
+	help
+	  Power domains (CX, MX) of Qualcomm SoCs with an RPM, such as
+	  QCM2290, voted over SMD RPM.
+
 config RENESAS_R8A78000_POWER_DOMAIN
 	bool "Enable the Renesas R-Car MDLC Power domain and reset driver"
 	depends on POWER_DOMAIN && ARCH_RENESAS
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 3b816ed3bed..b57fe297d44 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_TARGET_MT8365) += mt8365-power-domain.o
 obj-$(CONFIG_TARGET_MT8366) += mt8366-power-domain.o
 endif
 obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
+obj-$(CONFIG_QCOM_RPM_POWER_DOMAIN) += qcom-rpmpd.o
 obj-$(CONFIG_RENESAS_R8A78000_POWER_DOMAIN) += renesas-r8a78000-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain-test.o
diff --git a/drivers/power/domain/qcom-rpmpd.c b/drivers/power/domain/qcom-rpmpd.c
new file mode 100644
index 00000000000..59910d0a84a
--- /dev/null
+++ b/drivers/power/domain/qcom-rpmpd.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm RPM power domains (CX, MX and friends) voted over SMD RPM.
+ *
+ * Powering a domain on sends the enable vote only, as Linux does until a
+ * consumer sets a performance state: the level the boot firmware voted
+ * stays in place, and U-Boot neither raises it nor clobbers the sleep set
+ * an always-on peer shares with the domain.
+ *
+ * Based on the Linux rpmpd driver:
+ * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <dm.h>
+#include <power-domain-uclass.h>
+#include <dm/device_compat.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <linux/errno.h>
+#include <soc/qcom/smd-rpm.h>
+
+#define RPMPD_RWCX	0x78637772
+#define RPMPD_RWMX	0x786d7772
+#define RPMPD_RWLC	0x636c7772
+#define RPMPD_RWLM	0x6d6c7772
+
+#define KEY_ENABLE		0x6e657773 /* swen */
+
+struct rpmpd_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
+/*
+ * The AO and VFL variants of a domain vote different keys or sets of the
+ * same resource; for the enable vote they are all the same resource.
+ */
+struct rpmpd {
+	u32 res_type;
+	u32 res_id;
+};
+
+struct rpmpd_desc {
+	const struct rpmpd *rpmpds;
+	unsigned int num_pds;
+};
+
+struct rpmpd_priv {
+	const struct rpmpd_desc *desc;
+	unsigned long enabled;
+};
+
+#define RPMPD(_type, _id)		{ .res_type = _type, .res_id = _id }
+
+static const struct rpmpd qcm2290_rpmpds[] = {
+	[QCM2290_VDDCX] =	RPMPD(RPMPD_RWCX, 0),
+	[QCM2290_VDDCX_AO] =	RPMPD(RPMPD_RWCX, 0),
+	[QCM2290_VDDCX_VFL] =	RPMPD(RPMPD_RWCX, 0),
+	[QCM2290_VDDMX] =	RPMPD(RPMPD_RWMX, 0),
+	[QCM2290_VDDMX_AO] =	RPMPD(RPMPD_RWMX, 0),
+	[QCM2290_VDDMX_VFL] =	RPMPD(RPMPD_RWMX, 0),
+	[QCM2290_VDD_LPI_CX] =	RPMPD(RPMPD_RWLC, 0),
+	[QCM2290_VDD_LPI_MX] =	RPMPD(RPMPD_RWLM, 0),
+};
+
+static const struct rpmpd_desc qcm2290_desc = {
+	.rpmpds = qcm2290_rpmpds,
+	.num_pds = ARRAY_SIZE(qcm2290_rpmpds),
+};
+
+static const struct rpmpd sm6125_rpmpds[] = {
+	[RPMPD_VDDCX] =		RPMPD(RPMPD_RWCX, 0),
+	[RPMPD_VDDCX_AO] =	RPMPD(RPMPD_RWCX, 0),
+	[RPMPD_VDDCX_VFL] =	RPMPD(RPMPD_RWCX, 0),
+	[RPMPD_VDDMX] =		RPMPD(RPMPD_RWMX, 0),
+	[RPMPD_VDDMX_AO] =	RPMPD(RPMPD_RWMX, 0),
+	[RPMPD_VDDMX_VFL] =	RPMPD(RPMPD_RWMX, 0),
+};
+
+static const struct rpmpd_desc shikra_desc = {
+	.rpmpds = sm6125_rpmpds,
+	.num_pds = ARRAY_SIZE(sm6125_rpmpds),
+};
+
+static int rpmpd_request(struct power_domain *power_domain)
+{
+	struct rpmpd_priv *priv = dev_get_priv(power_domain->dev);
+
+	if (power_domain->id >= priv->desc->num_pds ||
+	    !priv->desc->rpmpds[power_domain->id].res_type)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* As Linux's rpmpd_power_on() with no performance state set */
+static int rpmpd_on(struct power_domain *power_domain)
+{
+	struct udevice *dev = power_domain->dev;
+	struct rpmpd_priv *priv = dev_get_priv(dev);
+	const struct rpmpd *pd = &priv->desc->rpmpds[power_domain->id];
+	struct rpmpd_req req = {
+		.key = cpu_to_le32(KEY_ENABLE),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(1),
+	};
+	int ret;
+
+	if (priv->enabled & BIT(power_domain->id))
+		return 0;
+
+	ret = qcom_rpm_smd_write(dev_get_parent(dev), QCOM_SMD_RPM_ACTIVE_STATE,
+				 pd->res_type, pd->res_id, &req, sizeof(req));
+	if (ret) {
+		dev_err(dev, "failed to enable domain %lu: %d\n",
+			power_domain->id, ret);
+		return ret;
+	}
+
+	priv->enabled |= BIT(power_domain->id);
+
+	return 0;
+}
+
+/*
+ * Keep the vote, unlike Linux's rpmpd_power_off(): U-Boot switches its
+ * devices off before the OS starts, and the RPM holds the last vote until
+ * the kernel's driver sends its own. Dropping CX or MX in between would
+ * take the buses down under the booting kernel.
+ */
+static int rpmpd_off(struct power_domain *power_domain)
+{
+	return 0;
+}
+
+static int rpmpd_probe(struct udevice *dev)
+{
+	struct rpmpd_priv *priv = dev_get_priv(dev);
+
+	priv->desc = (const struct rpmpd_desc *)dev_get_driver_data(dev);
+
+	/*
+	 * Without a link to the RPM report "no driver", so that consumers
+	 * carry on with the votes the boot firmware left.
+	 */
+	return qcom_rpm_smd_ready(dev_get_parent(dev)) ? -ENODEV : 0;
+}
+
+static const struct power_domain_ops rpmpd_ops = {
+	.request = rpmpd_request,
+	.on = rpmpd_on,
+	.off = rpmpd_off,
+};
+
+static const struct udevice_id rpmpd_ids[] = {
+	{ .compatible = "qcom,qcm2290-rpmpd", .data = (ulong)&qcm2290_desc },
+	{ .compatible = "qcom,shikra-rpmpd", .data = (ulong)&shikra_desc },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_rpmpd) = {
+	.name = "qcom_rpmpd",
+	.id = UCLASS_POWER_DOMAIN,
+	.of_match = rpmpd_ids,
+	.probe = rpmpd_probe,
+	.priv_auto = sizeof(struct rpmpd_priv),
+	.ops = &rpmpd_ops,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.53.0

