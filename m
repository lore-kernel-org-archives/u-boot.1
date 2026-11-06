Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473C606A935
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sVmAzEDy;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pe3vonkE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O8w3htOV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F30A740981;
	Fri,  6 Nov 2026 09:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 67zp_G5A8TZj; Fri,  6 Nov 2026 09:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5840640986
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958201;
	b=B/T31JT9PDStooUJVVES47XibN794qMz7QCGu4HdTmWP8wiHdMhbp1lwujL89JMp1zeR
	 O/CdSP4Xrpruf7wJc5lrYRYZFStQFlyaBCHcHUETQy+WeYRqlz9H8rPVdTkF4GxcNLvbH
	 adPYDjofhtYQDo5UW4vniVNZ4X2Uo2MHoohE9EGyKXhD1MI57DD+2SPmOsi2Xj4Y8+z8E
	 O5NzY6yhpEAMwq0KzlMYV8xFiuSQRyWJmJ7ouhdXEJKefJi1Y+RApk9ExjsxnZUN82Q5Q
	 YpcjfywauPGWyr0A0ckgOlc9p9QqLymGTcvtoFBJ98q/2o/B1fr299EYscjuV0I3+TA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NZKhWdiTyTKgFJ56veUneijSRF9V3b+axOfDz3a9vuU=;
	b=P/rtK/oTQiEfh/DLapVOnzwig9aVu2jvtGKmOA3G546d1jcVMNiywzYWPk1EwBt5tO2H
	 qFpLy82nbSFzNP2N/CchrelAC6CaSEYOzXcpLppmbupdcyoP79vBn8u2nYtkbJYvFkGXV
	 YP/OipSShmQG99dIWw0UPQj/scytHp5nuaHj39/WgXn/zxMRUMJpji9bV1v4nziSJCQ1q
	 e0mxQXyAbyVkpD5sYbzgu0GdYWJ9AU6o58WAEadKFjeGD3uic3uzLeqgYKa6gX16LF6/8
	 gcdDC3KOBHtsuk8fl9NQjoqpTcrMbFi0PYEwb2+S3TUrAkeXL6XaszQUG4lCBdurhaQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pe3vonkE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O8w3htOV;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958201;
	bh=NZKhWdiTyTKgFJ56veUneijSRF9V3b+axOfDz3a9vuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sVmAzEDywCphHbFK68+6D6PqZp1Tbx8fjlDoxgHt8PbkgtPTC8FDRK/CcHrFM4ccZ
	 y0Vqsbe0X/hFjt72wfs92Eez7vgFg/oej7+JFNNtvaTVIHrEk/shecw8PhDvrbhsOU
	 g6Faz5Gy3esOcgiL6PcnT5wXQS5QG0oo6KkjrIK+C9X4lGfeB8FDdA+KSokX6wMH//
	 KH0YwUTzo7JNXviBTrH/kZD5e+vkqmdj7p0ZamhCZQANW/TebSaxzm10e4y9VMWT6V
	 tuxTt5zElg/8E/r2l0MdOaqa6Qe/FCMihimt+fegXNEKylud6TyoMGiAfgkTjoZVPs
	 yO7V5kEaNNQAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5840640986;
	Fri,  6 Nov 2026 09:43:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED96534D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D38E640906
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6cUa0id5X-KT for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EFD0D4097B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pe3vonkE; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=O8w3htOV
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFD0D4097B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67R7OE3243900
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NZKhWdiTyTKgFJ56veUneijSRF9V3b+axOfDz3a9vuU=; b=Pe3vonkEPRhyrydy
 ZVDq2QFhfXeSode58lqzDmZwa5VFIblN7vrCoEzXiJkctOT76O9AgiHOysUiI03f
 Jjva0QrUCsn2TojQOy2T1PvK3qQtjTFhP03ogJnBdz3vIcgA7U/LKJaD0I2o7euI
 OiSuquy+A85A0PoGtXS3kvg8i+vJ1pkZDm+ZL5076zjXe+8FEdlhpeiDv5A88CLk
 E7WB2QuR8LTok9Yuezlua9ZBKUt7o4J83fxoXAmb25FDEo55P+9MRCwVrByDBnvB
 9Aj0+dyVEew+a8LVWsey+JJYh2XzsY5CqXZmz7h8WTQSJ+lieQcMPxCATwEZ0rIn
 W9VWaQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa24xk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-944138ed63fso75514285a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958195; x=1794562995;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NZKhWdiTyTKgFJ56veUneijSRF9V3b+axOfDz3a9vuU=;
 b=O8w3htOV1L9PyOCSCT7gVQIABu+QfQA3zhA1h+g3Hz6l3K//ivusSI8tBnlIR0RbW5
 8N3xtDNPsN/kT/aHKTcXz2fVozgBlImVxCzLvFWCmsZrSDsNoXHVkMa8gQqWCvTozSgn
 A/+HOXOAUMvv5KgEYSuR5dOHHZh2CwNMHJiZYruM1kzhc1Ib2OJhv720UDiaIcGpm3KL
 eRFFXTKU2P4e7Ndew0uQY/yhhlMtEMZj2RTA4qENAClLXHde5gq9J9yAkYeUqJ0AiS85
 FvieBuyodifWXFu1evSh0/EJuLV9A6wVfPpOuGaKvixzuCkkTB4Vu5YRVXcVXLa703Z3
 HnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958195; x=1794562995;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NZKhWdiTyTKgFJ56veUneijSRF9V3b+axOfDz3a9vuU=;
 b=bsXsYwVNBIQ4QT4yxDm4VqHOS43HwDsKFJatlOchn09OEqgMMJ29A0Jfga//vN37UH
 kZ9etKR5VfSMSo9Q3Z4wXxvVGpTRGfshxxWY6w/JlgaLA+br6zeoxoa7wj/piVk0lhkt
 wh7T83umuyYwOUiIPjJbi1ZCwOgP96cT1qmSgbqqsrJlTtrfuEYPaNzw8Yov/slHZCXD
 w/8x4PMyNW9fKa4buDq9bv2SPg6YUa+bvvIk5+e/QTSZlz3GpwxzjMgR8UjVYs6EdRsy
 Vsrf8DibpHCAjeo7upPHGb0Z5Mna+Trtu+C/+li1CsuAYDURL6RFDYG04qj04Mx5tDLy
 xB+A==
X-Gm-Message-State: APuU4Z8bx3kP+JlXXFgyQSmqti37x+LhKXEKxwf/EHpmtWfLJ0880zyM
 ARYDN7GTJ7wMwcpeXiueJ4PgnaPtpriRo8gUYwz370vm0jDhAtAtGCyk5z8qflKkjOZRhJ2UGcO
 CoOFI4wIg5GFjzw42jIfLcwm5ONq/J+Gvl7eO8s3P8Wi2okTRRp9y6uxd9LvbkVfQwIm3W5g=
X-Gm-Gg: AYBFou3usVRjeX7xJkCzt7mcwGLZned6rW6FtK4CMhMob0CFJkML/7n12KG89X7gy6y
 96H731+2KajvikFGsuU5XjVkkmDJsgwn5ox2Zq+ofY7UCUyF9lnadVJOkyhhdrQFeF6S+Xp+DSi
 RfdsOk6jnGDX9BCjFNjpoLlVkeBqyPmiuEItia9iOp8oBeVundoVxEB7L7+Qq1igE1V4Aw4l6pM
 akNsPHk39EAbJkt01jkY3E//mmrXXhC2WFznJAo/mJi01JkonelJPLsILFEAVeFz93lzqxyG3W7
 5mLMTejsiXYDIgD1rGiZI9mjRtRZrN7I7enWBkYZ+oQVY6/GGZGxMrnVkIFIxmdrUecJWxvnmyy
 OUWJZUb00DG36ufF1Oo/a14aZd7L/gWXJURkZJqZDTQ8h+IN85FxbXYlx5PbX1ePhr8XtyDA1P0
 xhtyU7ob0QduuV
X-Received: by 2002:a05:620a:4414:b0:93e:c12c:9b6a with SMTP id
 af79cd13be357-945f35f185dmr267523385a.69.1793958195527; 
 Fri, 06 Nov 2026 01:43:15 -0800 (PST)
X-Received: by 2002:a05:620a:4414:b0:93e:c12c:9b6a with SMTP id
 af79cd13be357-945f35f185dmr267520285a.69.1793958195112; 
 Fri, 06 Nov 2026 01:43:15 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:13 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:40 +0100
Subject: [PATCH 08/14] doc: usage: describe the firehose command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-8-e7591c12fc65@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aeda134 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=_vNykRv4iukaC2QdluQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX0xG/43FEEs2f
 rub4rU7bT63FAXKJ+fz4neFUEz8GAmxqGlECyOSy2PCcJo9qRXGUM6kEvb0rSfs5j7s9ABz2e1H
 Qz/w8v/tmjUvJABzRfnuLnxc5DIux1A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfXzhONBDZKvzMM
 Js/NyZb5CsbGthqmow1Th82AzUSGTAzKM3P59NyaQDyEJXC2WsHb3ASzfSX7c1ny/INAlfQhp/l
 aRXQ/CAQ8kIXnOFWKRNA2RvFlh2YHJghEEIrex53o9whAy6E+fWfdOOX1UGwZjdhJlWL3gMJul/
 H85BxmwnH0q3Hl2JiFI2qYITp9n66GhXJRfPmWe3XO7MWJ/ihKgsfv9Yf+NuMMSrfuTeiXnkSVs
 3huiWKQR4ek0/v1PjAqB2KMuwErGKA+NbaYEAg41FFU3Uel32IYaY2NuJvn91Gm7a+liQ+XlraI
 EMByii68P4hPs4tVmU5wFuVQquTeTBKDDX5AXRVvukd8Qr/o2RptvGIxsN/FoaCpqlb15DIWFzr
 jCp9cSPgdUiIglgAmKYLR2MzJFIePdWSiqyMZ2ObfFqGoNQNAqW3PWcSDDOg+Iml7OV92WXb24L
 FYhrYxFWH2NEqq5bO7g==
X-Proofpoint-GUID: uUD35o_VKQ4BonMSF5wVIDfbY0HOtGbf
X-Proofpoint-ORIG-GUID: uUD35o_VKQ4BonMSF5wVIDfbY0HOtGbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
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
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the command, the supported subset, the storage selection and
how to flash with qdl.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 doc/usage/cmd/firehose.rst | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/doc/usage/cmd/firehose.rst b/doc/usage/cmd/firehose.rst
new file mode 100644
index 00000000000..f8c075374e3
--- /dev/null
+++ b/doc/usage/cmd/firehose.rst
@@ -0,0 +1,81 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: firehose (command)
+
+firehose command
+================
+
+Synopsis
+--------
+
+::
+
+    firehose <USB_controller> [<devtype> <devnum>]
+
+Description
+-----------
+
+Serve a block device to Qualcomm Firehose host tools such as QDL [1]_.
+Firehose is the protocol used to flash Qualcomm boards in Emergency Download
+(EDL) mode. With this command, a board running U-Boot can be reflashed with
+the same toolset used for flashing any Snapdragon-based device.
+
+The command stays in the USB loop until the host sends a power reset, which
+resets the board, or until the user presses Ctrl-C.
+
+Only the subset of the protocol needed for flashing is implemented:
+
+- configure, program, read, erase, patch, power (reset) and nop
+- physical partition 0 only (the eMMC user area or the whole device)
+- sector values N, NUM_DISK_SECTORS[-N] and CRC32(<sector>,<bytes>)
+
+USB_controller
+    USB device controller number
+
+devtype
+    interface of the block device (mmc, scsi, ...)
+
+devnum
+    device number for the selected interface
+
+The device is either given on the command line or picked from the
+MemoryName of the host's configure command: emmc selects the first eMMC
+device (SD cards are skipped), ufs the first SCSI device with LUN 0 and nvme
+the first NVMe device. A UFS device has to be scanned (``scsi scan``) first.
+With a device given, a configure for another kind of storage is refused.
+
+Host tools like QDL only probe the EDL USB ID 05c6:9008, so the board has to
+enumerate with it, e.g. by overriding g_dnl_bind_fixup() for the
+"usb_dnl_firehose" gadget as Qualcomm Snapdragon boards do.
+
+Example
+-------
+
+In U-Boot, with the storage picked by the host::
+
+    => firehose 0
+
+or specifying the storage::
+
+    => firehose 0 mmc 0
+
+Running the flashing tool on the host::
+
+    $ qdl --storage emmc prog_firehose_ddr.elf rawprogram0.xml patch0.xml
+
+QDL skips Sahara when a Firehose server is already running, so the
+programmer file is not sent.
+
+Configuration
+-------------
+
+The firehose command is available if CONFIG_CMD_FIREHOSE=y. It allocates a
+1 MiB data buffer.
+
+Return value
+------------
+
+The return value $? is 0 (true) after Ctrl-C and 1 (false) on error.
+
+.. [1] https://github.com/linux-msm/qdl

-- 
2.53.0

