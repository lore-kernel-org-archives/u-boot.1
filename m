Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0776606A935
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PgnJ830j;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pukpDcvD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XShSqiyR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8ECE040971;
	Fri,  6 Nov 2026 09:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dfLzrVBuJgpZ; Fri,  6 Nov 2026 09:43:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C04A140956
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958199;
	b=CbFkHmaERtI7KlIyN6b+iXGcTCxJh6CfP0AQaT/f4r6FeO2CKdBTLh+IvBsJUgT+GSfT
	 H+5tGWbTo5fkOkoSdn+2+5aGzpP8lbPc8+jVIHakt8/FxhSZeBvl3YRxv9aTvdSm6DfcV
	 XoXl8S96/l/zSo3ALqjRwMXWKDU4GWLR8B/1r3kkKbIUd1vsxOcDC6b9K0BWckXAtr3Mb
	 Szi3cfinLWS1TYx5pfH8ehTDiXPQ6dvuXuSCFx5SuuEgNKLd2EPE/GfqAHMjuUpzef73/
	 F52Y+RUa6kHe0/Lc2RIN0QlGo9vLrZskaj9/J0Lr+06GIRFvdfkSPv63zm0+rXpNdEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958199;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RsQQVFF5WrTDGJOaqmgbjNltPGVADBIToGed/aenszU=;
	b=jmcuMbrSoThxRLhWDzozOmZuce0F1CUEIUwnDC2LOE4Cjj4CVpGnJQRduQ1q3kLfLUmk
	 Bmg29VKZHib3xe37b4xMYqqKhXpdWB4I8/VDdvJLbuR8jQZOh1sDetGoDgZ/HhEjbpYCA
	 sybVdxjNNSkmFSTvvmuYOJq26DvfXM2yTqN8oskQyCdJe154vl/UhM4jAOeNh6DSMFHwP
	 4LTxr2AJrMmylHHSmoZGs75vjyvz7RTAB352FBLqGqyuTdDOdJiepsD9A8LkLheFHMiDc
	 04ixQiUM57E6I2tmlo9e+3eRI3YUU3R1TP1FVDWOR5Xp2wm1y/zj4pFBkyZs2qB9SPQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pukpDcvD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XShSqiyR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958199;
	bh=RsQQVFF5WrTDGJOaqmgbjNltPGVADBIToGed/aenszU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PgnJ830jR9srcORTZM/9uZRIhWfx3qUQPkD33/L+HqqWfx+zM/IfSVCn4PPnc1wGF
	 kSoWiyJhXZ6Vax9RW3Sr4gJIoApwhNa9+HBMGKVv52udnYIgkppTSYTZKmOqGfbGnU
	 dIy9YUYsjJmRmcw0pRCIGdn0a4MMesog7R0oAj8AN4bsb06BaRUacTf19u49bM0yp5
	 0FerxCZfcSGzg6pXzNqwJErbFG5TNSqL/0a+63v+zjWLbvUR4i6RGufqrDiD30tbNm
	 wFuBraowgHX6nw9VDrKsLCrZjpMfyK0p3xYPZHtxAVfA4C5jpG2IUqgzlZLj08yKiE
	 nwrixZQZPXB8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C04A140956;
	Fri,  6 Nov 2026 09:43:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC5797AA
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5B644094B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ScWujd-vhTCS for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3536B40983
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pukpDcvD; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XShSqiyR
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3536B40983
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:13 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RTdV2730737
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RsQQVFF5WrTDGJOaqmgbjNltPGVADBIToGed/aenszU=; b=pukpDcvDL6RTp4Ht
 cJjivLVn+rJVG17V/c8vgPfpJc9/OGjTJC2VzGveGmjdmHf8e6CCHqk6Zn9HWrIZ
 FpGxY3sbUZzEwrsyZOaRYVJTfLBeyp2jD3VEQjfQqhCdRjVKwwXCK3wl+ss/sS9O
 pT9NPA1N8XIF9Fdm0GILGzN4dcuxnPLOxoCFGCvMsvp9j/oI99M8Nb14XJFKe8jE
 h2jzRVvjqOKoMdnwKWPyOSWRIBCMI0FXEoSlaziVnVhwoF8RgCez1ZQNwINp+GrS
 pDbIWLu+gftZOnGd4KS6+Kg/3CEWDUjdv2fsvRN3mNHkdyyBqb17D7JDV2A8vZKu
 5K7vsg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9j508-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2c0e6653so87565885a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958192; x=1794562992;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RsQQVFF5WrTDGJOaqmgbjNltPGVADBIToGed/aenszU=;
 b=XShSqiyRImFQdeTKzWG3Ll4gsB5YblRNmTsOqmdhD2bexApsPmEc2rdDeOgozLyptd
 bcBYw7QLyds2HBm8/5E0L10C0G/sCQWCnnJ6TIoSMv2TGNePvFMCYGLguq0pIFoy5lX/
 P2GkeKTjnI3p++qoP0LZ5dBPL/6udAw3yETm0rrfXjuS6BME2nhVlQLYFaWqsHYx1Tlw
 aQNZaAzWLVgtrePYjo7J9HNOUZVtZtxgJQKIHeP6CrE62EsoZUhTBVJ+Hks+r3JPmgnQ
 4eBEVJouaJXL44uAu8iAXtWbE+elQMTblNVUqowYqDa3AjtIVZLdmOxL5yqDlgJbhbrW
 bh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958192; x=1794562992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RsQQVFF5WrTDGJOaqmgbjNltPGVADBIToGed/aenszU=;
 b=wdI9tbdbgW2x2CHTs2S4sJbzLm1YFsFRhi3+26FLtDzH5xFbH2sPHGJbz7OLSSO6wi
 09nkp+0hNqTBlPkrGtds5tVjNR4pnYSJuc4xpcz51C+kuBb+eecVl9ba45yAKHlpj6nV
 vO9ZwB8tO3ddl3kDZiHVooETVptOGtDL27GhGXzAPXspcQXFKb+xoVwKtSGhCNg+pn/i
 nz60Rci8tJDqb29DCKuFpUrtt1/F0XaPSPrE9pDpgNkD3e9p2RYIHaYA4ifMsxnqn4GR
 O1Y5EyzCR8gINQqvI+pSoUAncM33HKSwHjvKkr9FY217L47mcmhAYG+NbeLrmEt+uOzW
 t8+Q==
X-Gm-Message-State: APuU4Z/KHF38idAp+GTl8juaNDpseYHi1iFiGfaAwQoB5ibi/07yDflC
 qks3tarlRt4SU7oa9Rx6bIgJ28WenHQjP1p7ZGCCtn5x+lorfSaPgDslPkG9gZayi25qG6oGHwu
 BFGMqlokI6d3tb9BFaoMq+bjEZdEYEXak0QOSqFVegg+WqSLt+xDYlVt257JGTQ2qBJFSRMs=
X-Gm-Gg: AYBFou2syN1+XmgRT4iXNu2Gvzz4DeQ1ddrbCD+v3muhKgFyxfzeWQv/eNcmkqKU7gS
 Z5IOa2OMF3T+hyHBnn0ReYtrgLaNAXtVSQpNBKAr8qk6lud/PNdQT3CPraXR4JJ+a8EwDNoSUcI
 VYIcjpANBW3xk26L0o8f3Rs3hmJWlZtBLZ1ZTvFKcPbPt89ohHoLp5G5dW1tHg7QZxJTukVaV6h
 oUXDVklogYjipniwTziRLMMRhQ55wzNkto1NmTwMkELxx3fqJREObec/Sh04ZQB2Wg0+z41AI9V
 5dqklWfwWi2utMXkrzwdGawsD3i2IlStHcu7Gq91ISCwxap9Iy7JQ2YzSg4kYbsFpAuSuZuPxBn
 Mbn3XeuKOnBbaRd2q4toyffRbDcThCUWXCLDNygIFfWuRK45vVmQ5zG9YQqa9Ku7okWt/iIWn5R
 YRDEyFni3YXvCf
X-Received: by 2002:a05:620a:1a16:b0:93f:dea:3b7e with SMTP id
 af79cd13be357-945f344d73bmr269218785a.24.1793958192262; 
 Fri, 06 Nov 2026 01:43:12 -0800 (PST)
X-Received: by 2002:a05:620a:1a16:b0:93f:dea:3b7e with SMTP id
 af79cd13be357-945f344d73bmr269216685a.24.1793958191823; 
 Fri, 06 Nov 2026 01:43:11 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:10 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:39 +0100
Subject: [PATCH 07/14] cmd: add the firehose command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-7-e7591c12fc65@oss.qualcomm.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
In-Reply-To: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: quTFwS9_Ctep0R263MEp-DDS1tqt3kDn
X-Proofpoint-GUID: quTFwS9_Ctep0R263MEp-DDS1tqt3kDn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfXym0acwDMVv49
 S7f4YHm/zyz9ulX5SgEnKa0e10FZgUyOtIHmNA8U3vY435CYC0jJttPZ8yZmzXrGe40m74Cy/z6
 Z8LJGr/Z7R7cBrokA9rfbZZRz+pwF0Y=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aeda131 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=34UYCvCbboqybGAe5PMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX9fzcxV7Y9Szu
 eURqOUYx75I5nZm92edq1KDIBOp7neom+G3bon7ySH+8hTnpc7L3xCaAkusp16tq8/T1C8CUtbg
 Snmb1GXXdRtPnIhVGoEWQpLs5rXOgeILjUR6MR0ItQghVv2Do8tmJtG5OEixYmBdhaRiNprmkAB
 4MT35lbzUxDWNsaWXThFaAWsrsMq9FNRyCjTMqri9C2SC43b+U1bk0dE3chrkXrqDXZax9P2jfJ
 eMUGNsEnHzf/85d+MiyY0wmPJTj/KRhtxAKo/O2g7fJmaktnGrVCexbfU4hHKwKCR7rrOOc1CE8
 gqsVszEzPT7HjzbUVfsQM7hQ5z4J/ep7dlT4AdEUSw0cw6jCw8aETvGe9FiKBZqkJNvPn5IXBH1
 YCiI1px5PT/nCEU5o1HoLAytq5Ls/FXZoQhlAYenShyI4+aQ2TwNPnyHHcX2yjW5UZJ/7DkZBbb
 IAJMG0ZHAY8v5XNMrIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060038
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

firehose <USB_controller> [<devtype> <devnum>] serves a block device over
the Firehose function until the host resets the board or Ctrl-C.

When device is not provided expcilitly,
the MemoryName of the host's configure command picks it.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/Kconfig    |  9 +++++++++
 cmd/Makefile   |  1 +
 cmd/firehose.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ace0b2e9c80..f1fc55dd43f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1880,6 +1880,15 @@ config CMD_UMS_ABORT_KEYED
 	help
 	  Allow interruption of usb mass storage run with any key pressed.
 
+config CMD_FIREHOSE
+	bool "firehose"
+	depends on BLK && USB_GADGET_DOWNLOAD
+	select USB_FUNCTION_FIREHOSE
+	help
+	  Enables the command "firehose", which serves a block device over
+	  Qualcomm's Firehose flashing protocol until the host resets the
+	  board or the user presses Ctrl-C.
+
 config CMD_PVBLOCK
 	bool "Xen para-virtualized block device"
 	depends on XEN
diff --git a/cmd/Makefile b/cmd/Makefile
index 7c3db81e524..507fa6e6680 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_CMD_EXT4) += ext4.o
 obj-$(CONFIG_CMD_EXT2) += ext2.o
 obj-$(CONFIG_CMD_FAT) += fat.o
 obj-$(CONFIG_CMD_FDT) += fdt.o
+obj-$(CONFIG_CMD_FIREHOSE) += firehose.o
 obj-$(CONFIG_CMD_SQUASHFS) += sqfs.o
 obj-$(CONFIG_CMD_SELECT_FONT) += font.o
 obj-$(CONFIG_CMD_FLASH) += flash.o
diff --git a/cmd/firehose.c b/cmd/firehose.c
new file mode 100644
index 00000000000..f7b7f8b6392
--- /dev/null
+++ b/cmd/firehose.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Serve a block device over the Qualcomm Firehose flashing protocol
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <command.h>
+#include <firehose.h>
+#include <part.h>
+#include <linux/usb/gadget.h>
+
+static int do_firehose(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	struct blk_desc *desc = NULL;
+	struct udevice *udc;
+	int controller_index;
+	int ret;
+
+	if (argc != 2 && argc != 4)
+		return CMD_RET_USAGE;
+
+	controller_index = simple_strtoul(argv[1], NULL, 0);
+
+	if (argc == 4 && blk_get_device_by_str(argv[2], argv[3], &desc) < 0)
+		return CMD_RET_FAILURE;
+
+	ret = udc_device_get_by_index(controller_index, &udc);
+	if (ret) {
+		printf("USB init failed: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = firehose_run(udc, desc);
+	udc_device_put(udc);
+	if (ret) {
+		printf("firehose failed: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(firehose, 4, 1, do_firehose,
+	   "serve a block device over the Qualcomm Firehose protocol",
+	   "<USB_controller> [<devtype> <devnum>]\n"
+	   "    without a device, the host's MemoryName (emmc, ufs, nvme) picks it\n"
+	   "    e.g. firehose 0 mmc 0"
+);

-- 
2.53.0

