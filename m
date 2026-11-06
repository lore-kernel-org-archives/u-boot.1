Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27178606D807
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kTJFp4SL;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwZSHtJa;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZFY0/wH3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6663560628;
	Fri,  6 Nov 2026 06:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62UaqL6_MVdl; Fri,  6 Nov 2026 06:08:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C5D960608
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793945284;
	b=RuSAXtrLUfHMi2tXOslYqpdLwXSI2gr6qg9dfM4JGGruPdH4jQCov4WUmeKPLRn8QwEQ
	 FHj+SB0jjj/idtmx7n6qYxLQiRWB5crnISienXE5I0MCYsezfyTJhkqlFiSn1l8xSXCpQ
	 mJjGbx4dvl9+xILdXmOwSmUo3NCG8D2b0DYflHspkpUDUdKLt2gE9pXqroFDplFdUBKTf
	 scOtlD2BqOpz7diIHXland+UJNB+hzaXCVOFAJTIdelbAg7E/svK7SN019UXp041/l2nF
	 BCG/aWcwSeRQv51sHy38R6waWaP5syHQtOptpHhr/b+lJxkLG0F3NjWxR4eLiY/J4BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793945284;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PYYCHuWAghXjQfUnyPSyhRhdEJj1HfueSB46DZEX1FE=;
	b=SBG8xSCQnjv4D6ROefEjN5MK2cZJqLg7CGrBYQ5QkUuvG8Zmfia7TVcPUJgQOhIsqw+a
	 JT6OazlTbLd4wOKUG458H/mbjQtM5QYgW5yPN0RzWung7xOEjU/HEIn/I5s5Ogz0v1Iss
	 ZLFulotCD87loHtK5CAiLdkbg3HJfeAnF92j7fUyTV8H9QX6FaShBvCu87paemD4yXHsM
	 zC9TEwquIMu3YbBpQPRpmadj5kpcIPePicgj9PwI0gAETJgrZ9IqcH3vVik0YjOiGgpHN
	 AAXBAhTFTQzozAdXlSEieR/5/VNOxoT5txY+RaCo9iC3ei/WcVN6Ae7ECJE7Te4qjMw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793945284;
	bh=PYYCHuWAghXjQfUnyPSyhRhdEJj1HfueSB46DZEX1FE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kTJFp4SLWNY4a+8dkxoU1G2zUfc7UNu5O0LRgUU8fiiMbK0WgmqbNZwkppVU4F6Fp
	 Fw+EKhr31yIv0YO5AIXWvxSz8A7PzBnSOCX5ZwDc2sAl49APISY/sdjUbmz9FjKnle
	 ujmCRvw0Ff9A1iyzV1IP8oxjS5DDh3PdN9IMWWiGXyZD0v0amhJrtM4lpHet4BGm6i
	 EkiWGW3kkXUt/wtaEQ69wSdl712yAzkhnFRIwN+xqr8ElNS5Dr11a+cedQsMJ64Iaw
	 yfVNii8Uot+8unHR69OMYFPSBeiv66f4ID4bT36SXIeeNJwwC3N6adBrboVhLcKKBf
	 8CR1mJGZy8ZqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C5D960608;
	Fri,  6 Nov 2026 06:08:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 998841E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E48980FB2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gDYi_QgB8Lie for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 06:08:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2029E80FB0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UwZSHtJa; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZFY0/wH3
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2029E80FB0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:00 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6403He3775737
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 06:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=PYYCHuWAghXjQfUnyPSyhR
 hdEJj1HfueSB46DZEX1FE=; b=UwZSHtJa76H/Ofez5QypLB6nhRlglFzrnQYghQ
 Gl8JrziMactHGwgE+AL2293Buh0SR2iQLkwfuV+nx81RGMPLPr+gX2m9BzqOdVbo
 RWOAe0ITbpFDpeYcEYojQ+qTZYO6LeUPd9GGwmzEalunZmMBWGYbJ8eNMIadgj7H
 naPfZZ0J2aHBKLMEX4plttvVM5JtQ/xdAKkv5Kj+WgR/XmcstjfPTcy3oz13VOHw
 INbexa90IFu+E0Z3jFp6cpQg1yERCISonIE+KOcinCUsBkJZD4qoywNaEubjQ3Cg
 /A6Bl1Twke+UIUd1ly3uFLJqMuoFyYE6xYe9BE3qN5tLaJrA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9s7nb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 06:07:59 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso708048c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 22:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793945279; x=1794550079;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PYYCHuWAghXjQfUnyPSyhRhdEJj1HfueSB46DZEX1FE=;
 b=ZFY0/wH3iczJdTajA7vr/DPENIzA3+3w1IGLPetuCmzuTqaB0vgkJJKbkOENg0JWQP
 iJvwfa/H110HCP+8fSD0p2iZoP9ZItrLxu3s8oBRrOZz3P9RtLv/SmQdYJvDZIDFx/oE
 n76tDF6U6aMxgYw87wxbk6selVB0pivJkXWeN3+S5fm1U4WNzD8XHuA9oFF7RGtntV+Q
 aT8URxDVqpeJ4gkXjtqhk6U57U+L+0eqrU4eYid6Ar5QyikOQD2ViSX0NV8/1M7kDZ83
 KUlnq8Srrvn8RVdfP4iMrHUTQTFcdzEE5qNiqxmVZePZunM+ZkLP+AZFt69R52bb5IoR
 UnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793945279; x=1794550079;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PYYCHuWAghXjQfUnyPSyhRhdEJj1HfueSB46DZEX1FE=;
 b=SLh0ZR4M/Fhh2QJU1FYESPVMnBXpni2bVKw8TQlPNtMMNEEpsULTsyFcrdw/J5BQv0
 CK8ibXKBqYzza91d+OH0WIMbbE94LR0q+iCLTeuoV9Q9PsOTsdLoaDdl071hY7HstNGW
 Fq6FKUO7IPc4MSrb+sVgMOq73Pc0CLC8QuLLcbnfzVWFQXadTu8yaBXeg7tjHbu39ay9
 b4OLpwu2Tu5YdQWKFK3B13bvDInW12UfCcnWfieuWgN0HPLwsIaMIh/K5nDbKlATMLAQ
 BhfViw8DSSRmJnz5rdwwuRTTt167T58Xi52vLtQkNm26YOd/yjtPE5URzFz+bfQosdkQ
 Pgsw==
X-Forwarded-Encrypted: i=1;
 AKwUvByPprkmi+XwSH28istYjFguxsxOVbuUwisMimhISVLTOQEdphO97EOHYzzAp3fn8R6gjtc1GB4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Yg/4mVMhZFjoDURCvYDbiBMnRumIFbI2RJfzW+c7qKxykC/Hx
 2k/AxKA9+IZurDp7sWV14ZfpVE+NNeFCOHlv0uTDqJQjEzfYB/06aCx/HywLA+8RN3YJG7JXIaF
 XmgoTaDLU5DFoaHU/KWxUaDu35soAbIvzgsV066cTHLCuBvpG1WkcimCcM8pflqQArm5mXRs=
X-Gm-Gg: AYBFou06TFRa3EcBiJl8r2FeeI1xTC+SUkH43jOTlU8JH9lhlUZnghEurO/wrgmBrLv
 pvksV/n6FIpvRC7xWNnvsPfhlvC1wiwJRhHlrLSY1iuHp5ZGrfXlDMXG9N/hQoHbXLIuHrr+eqH
 Rk54xlimpbxxnvjaqiJlKTQCXAjGd5oOJNSQmkhVAaEgdM1h2XTfztTdODZZGe+FPVnEtuqLvq6
 AKz49PYlt7cfKVP2UYNzH3eB6qDYZ4nspmwWj9VytEiLQgtxqRdGNq1nIJCgKZsONNKfnhuGwYj
 kHMOMssJrGMJ0UH8/4ybd0ZJqJWmEo68NEcjdL4GY0POiaokngy2UbQAvMfxxzQKAanNYXJCQyF
 LKFbGsFZhKiFg/0Y81OpD+QnltsRWFS5d5yu0GcxpqO+kn0NqJS3GJd4qKrqvUwgqhNJpDOhNBj
 0AMyJdLSsJvdNI5+MHzSqplq6276zOkiEh+tFL93AF/zze9he7n9XVvUEtu0OV4zxoriT4B11Iv
 lrQ2Dg=
X-Received: by 2002:a05:7022:ea8c:b0:176:2095:1ac4 with SMTP id
 a92af1059eb24-1b25d30851dmr1782228c88.18.1793945278927; 
 Thu, 05 Nov 2026 22:07:58 -0800 (PST)
X-Received: by 2002:a05:7022:ea8c:b0:176:2095:1ac4 with SMTP id
 a92af1059eb24-1b25d30851dmr1782201c88.18.1793945278360; 
 Thu, 05 Nov 2026 22:07:58 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4a610fsm2341373c88.11.2026.11.05.22.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 22:07:57 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v4 0/4] tools: qcom: mkmbn: Updates to support ipq5210
Date: Fri, 06 Nov 2026 11:37:41 +0530
Message-Id: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK1u7WoC/22OSw6DIBRFt2IYFwMo/kbdR9MBwqOS1KKgpo1x7
 0VM0w46IbnknnPfijw4Ax41yYocLMYb+wghPyVIduJxA2xUyIgRVpCS5tgMI2eUYM6AKsGFrrV
 EoT040OYZTZfrkR2McxBOxydqhQcsbd+bqUlqmivFNFe0Qnu9M36y7hXvWFjsx8k6TH0mF4YJV
 ozUulSSaMnP1vt0nMV9t6bhiaol+8XLL57tOKVKZlC1tIA/+LZtb/IQLU8TAQAA
X-Change-ID: 20260714-ipq5210-52e1da5af9fc
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX1Ix17PVW/ZcO
 KIRm0KtLhTXOU/xDOpho2b3SBr3uuIQkgs6Xxkud0LA7A1sb/fuR7E9zY+5QXT03aED55legKSt
 f4uAHUpBxC2xX0tyDY+gIiUGvtuw3Uc=
X-Proofpoint-GUID: CVZA-7exbeegIN8_cWCxmNdArywv6Hzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX9IHuEJcUoCbF
 skvPFbfcTjYUK8DsCe79YT5v0mnlC7JEXDe07UTBy8yINZXW6IetB9JN4jQT9e6WdUK+uNDkrGM
 xwsf3bytsz0zP5EnaxVaPHPzdaOo3N0bxQgU56sUPBV3BmiMC7VYTUbcAmPIh9Cnf92kq1qv82c
 yxtxwbDYL3Z+ObecExh9mJMIcffu8L51iyGbzmji8vwqT5JB+r72/EXMCKcZF0wVVeikWA0CX/e
 /ku50cqF5MgVTN1DDIC17zvBdtR7yQPeDKzAxm92OFA1GFeEyVHUCbpmkXuofX9Rjky8H6lqEeX
 vn5Er2zlmqPwj+oClrdFgx6Zw3o+YrOLdJlWUTdx8+EEWt9iRoKIQt3ZLaT975u8Yy2T8pdZMH9
 IjDAF5Eb5TfIWRims0ExlNRDCyEg4tXe3fU9ZXcJFsnR4c7ktRIqYXd0+o0bPiU183xHRE37WCo
 O1K6fJZ9MXEFvj1hu3A==
X-Proofpoint-ORIG-GUID: CVZA-7exbeegIN8_cWCxmNdArywv6Hzd
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aed6ebf cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ut7fy3Y2aEGntDmQLfkA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
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

As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper support,
the mkmbn script has to be upgraded to create images that can be used
in the ipq5210 SoC.

These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
bringup' series [1] to use mkbn.

1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org/

While at it, fix the MBN version number for ipq5424.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

---
Changes in v4:
- Drop sm8550 full defconfig and instead add a config fragment in board/qualcomm/sm8550.config
- Remove SPL_TEXT_BASE from mkmbn.py error mesage
- Link to v3: https://lore.kernel.org/r/20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com

Changes in v3:
- Fix review comments
	- Add CONFIG_QCOM_GENERATE_MBN to qcom_sm8550_defconfig
	- Remove load address from MbnData and for all entries in boards table
	- Remove '--melf' option and modify the 'bin' argument to take
	  multiple files for combining into multi-elf.
- '--melf' was actually not removed in v2, but included in revision
  history. Apologies for the mistake.
- Link to v2: https://lore.kernel.org/r/20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com

v2:
- Remove 'load address' from MbnData and get it from .config
- Add qcom_sm8550_defconfig
- Use 4K alignment for padding the MBN images
- Remove '--melfs' option and make them positional
Link for v1: https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/

---
Varadarajan Narayanan (4):
      tools: qcom: mkmbn: Fix ipq5424 MBN version
      board: qualcomm: introduce sm8550 config
      tools: qcom: mkmbn: Add support for ipq5210
      tools: qcom: mkmbn: Add support to create multi-elf

 board/qualcomm/config.mk     |  2 +-
 board/qualcomm/sm8550.config |  5 +++
 doc/board/qualcomm/board.rst | 12 +++++++
 tools/qcom/mkmbn/mkmbn.py    | 85 +++++++++++++++++++++++++++++---------------
 4 files changed, 75 insertions(+), 29 deletions(-)
---
base-commit: 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee
change-id: 20260714-ipq5210-52e1da5af9fc

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

