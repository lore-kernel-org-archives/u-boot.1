Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2A606A32F
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sT6vvkSB;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hkvcpFrw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UygBYtr1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59745811A2;
	Fri,  6 Nov 2026 09:43:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0DEx4KyFGxG; Fri,  6 Nov 2026 09:42:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 36CF38116F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958179;
	b=NUjJPhK3sdbu99kEl0Ipu6HxI3QIFjtzO5q/u6H1vGUKijzdcjX6XUnAgpouVbls20vU
	 40vdaWjUGNNiAe8o8YEUfBjitok/z0pK+Xpje2JtyKGJGbS0kQqw2YDAI0xRzTAKFULHj
	 36b+hMToplUrRSdyobsD5xb4jVbVvxqHsCr4K+mD61OzhdIzusVVF46X/E8sLL3yLa7oS
	 syZ9QR+mBFq5hu9kGe/GRyWDtXl7fjVYbtey5jmhoFW6f2+eeI6Na61MFyqRa/HAZtN0E
	 nPgYqyWC6eCNJ8AbqAVxyAVUIuGU5sjYtkgMOxhbbdXwQajm3/pIgiHl7Wh4RGnnDnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7b/pLqj35NUcw/s7ZJIhfONoRN+icTW1pTBK68DFa28=;
	b=ilXzsmEFk+WHuRUFnxjy8ZDFtw5HYtsP0pk/m319ACx3CDSWWpwOkVUemE/8XdlV7160
	 clGuwNcO8HMWv8kLf/YxJDSuqdUhAPp3CXQKAfg8W1xZA5EL2YchdNsw4/jO78A5bqrvs
	 oa4N8sZYgmCWV57bgXuv/nyAE1FbROQeZjzFRw/m7RHOotzvgT2CJIWX/HzRXQN7yOhrO
	 FFR5yyww6HKpew+UZkyShZcWGDa4FIfF5cq/XSmkILxmeixb+/tu4gkJqzeJR4gXkkZzm
	 WvNVbvUBqFpu91KcglW9q67GdYgNf766FQZNVCjMJeSZYnVa6khjvhp+LIVt3FrMlLA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hkvcpFrw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UygBYtr1;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958179;
	bh=7b/pLqj35NUcw/s7ZJIhfONoRN+icTW1pTBK68DFa28=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sT6vvkSBYq54ELTTJV6CUMMlt7KubZ1x1K+h2a78B2rbG8qKKJjnfUPrDaocdgSlC
	 6dhqFy06+sxCE6oeJ8dbH0uHFrZ/g8GAeIkbmDLCVAqx1Ao9GibnQWaMESctIHNYhv
	 USHVV+5EWhg3FZ4IbHxYolMe0FwYAT92OJqk7Ruy8kBA6PGPAQptQQvRsdJRP5+Uuf
	 xVFEvq35xW7XnuAhUjazk3m5irhfrJaDFSt6DhWr/HrbQs8S9kV0xgQDJCiPvmj0Dp
	 Kb8SdVG7XBUt7eKX+ESCmheI089oLBY+wb4nPxapuTVlvnFjUD0503ESogYCCS85YU
	 EjPbqUG0JCkSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36CF38116F;
	Fri,  6 Nov 2026 09:42:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 116D034D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 027738119C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:42:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cEVnNFdNwv4q for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:42:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFB578116F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hkvcpFrw; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UygBYtr1
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFB578116F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:42:56 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67R7dx3243884
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7b/pLqj35NUcw/s7ZJIhfO
 NoRN+icTW1pTBK68DFa28=; b=hkvcpFrwsvUPtDxzd7zTdk4LWKoI0GuZSqclCl
 OwZwiFR7lrczm2E2V0A6szSyTAf3+dadkpFiS+002xZfJX/WOagGYl381YkRv1+2
 9zo9n5A7Ebd6PQvyQdYDbTJRlmx4iyVtDI0A4K4jUvgNUJZKZIdruOsR3RG4DMpg
 79k9LDTSdTbcNEn3yJy8xr5xdzZADoUj1KRVQmGhm1zSi1PlvWk7+8TW0gVykk1B
 wzCleDy/pL3AqXLWkRervuDBUi723fUrjQDkNFTP3PShSymW5Tw/PLc2Y8KuZ3kW
 JgFR6pbDyQyJkcMwdK4wFyide/qn9Oxd+x33ksjSFynE8GJA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa24us-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:42:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f20addba1so89904085a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958174; x=1794562974;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7b/pLqj35NUcw/s7ZJIhfONoRN+icTW1pTBK68DFa28=;
 b=UygBYtr1i3NCJmZmNuvsC/mA4t6B6zt+/BMXx5tvVCBcMnhTFu+BhSJAinu1SnZatn
 Q5nka35LhN+VFxkz8EnDasM3J95z9PLUOQOrrz9s5sbVvH/gq2ahGDzRtOU1O+KuUndf
 Xxdb4N+N5h/8bT7EeA1WRkC9qWSBBHWwL5zLI4EgmfxLRMTUVCYv//z9i0EuuON+BK/N
 sZ2OWSgP9EqLw2CaKz3GKf7L3OmdPTct8a3RsZNhiNleNh1k1Vs4z/LjkzBpgPfTcxiB
 aTNe4Ne7oEO53AnohJFnqD0iWIJSIm8HXSpMsCDQ1JZLBZgbnjwji84nMDd1DGgui6PB
 e+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958174; x=1794562974;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7b/pLqj35NUcw/s7ZJIhfONoRN+icTW1pTBK68DFa28=;
 b=kPM/hBZcNbr8ohCoRe8Xe4iwWgprm63hS1U8QR80jWp+dz+Z0rzKz6PX/qcTbgIkxn
 L6ehqm4b4DKmBLR0RL1gCXkG34jO5fesDyhTV6HFY1GTdXSIqzsLXAmKicFMJmypH+Gm
 /Iheh83GW8rtGfNe6PozTrAvH0zOKoO7mQ21u2M7zedo2FmPkYgQHSy4kLd8a+FLt0J4
 Opyus5Z+hoXsFZULTc5tZ9b6ahYhheWqyv7b0YK+ddcHjpeeXLyOoGqENuIZtS20shkj
 Tud2g2i5yTlMgedf4BZ5mNulI5tAUyp5bmiH1jGMJ354uHUcsEpiowcqB9SC18B1nsM6
 ozpA==
X-Gm-Message-State: APuU4Z9X+etOTjo0gcftpJVgVtDPSWkkxOr5KTB7K4opQ3j7PkuRtIyw
 LLxrKvEwyDSKdXwrL2Qv1tN3158Ila6QhOxr14BuaOXi4BCCNOdXSGaJCh+0YcsIf1By/7io5vk
 Q2tUX1h+NDtZfOlyEOFu96ZfwM0AagGe7Y5Ne6/r4lw7NIqDBIFusEpLLH3iumDTmHe+k7No=
X-Gm-Gg: AYBFou15zsguSozfTCarUc2Nxj/Vh/xVpMj21MaQWim7kAn94QsQwMuCvawflinmCsC
 TvRFUe/wS1CBiZ0+Wn/1/+3ahHFTPwkWCgIBOKPr3iHb5ANhu3AeyKXzBJRGEnXT+PDFhrief4j
 4yejjiEmJHjVYPb3ZvGJcURySpbmRNgNWpgWHzC7y45o6X7FUDyOLoD+Oq78/K4xirc67ljbV7w
 4SdzvFHnpc4UzkOy9X6WyzrNa2iR1e49FjZbyaMlWzj1HM3ojf7mwnEqjhanEZ2rwvLcSmxk9Ln
 gi+IGCI3rTvA66pf/CptKt7riX0QGYZGErBXTKBT7nM4qCfEkCrGCYmMgCN8yPBtu2gMCGPtW6q
 QzrDhKGYltXmVCG/ChMV49I6TU/ftmvtxp38hvOXpl9xQsLDG1wNmFMs8O8Df8wv7aHVV6kJa39
 QvbFP44D3C3h2h
X-Received: by 2002:a05:620a:17a3:b0:93f:2985:40d0 with SMTP id
 af79cd13be357-945f34ebc1dmr267526485a.34.1793958174404; 
 Fri, 06 Nov 2026 01:42:54 -0800 (PST)
X-Received: by 2002:a05:620a:17a3:b0:93f:2985:40d0 with SMTP id
 af79cd13be357-945f34ebc1dmr267524085a.34.1793958173971; 
 Fri, 06 Nov 2026 01:42:53 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:42:52 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH 00/14] Qualcomm Firehose flashing protocol support
Date: Fri, 06 Nov 2026 10:42:32 +0100
Message-Id: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBPUxKKrRAuzMWejoSCBePek5
 Vv836BgJiywsQYZKxVKcUBODFyw8UZO1zAooYyUwnBPGUMqyKvk1i/Oz6d2qFcYxZPR0/vf9qP
 3D9ObDPpdAAAA
X-Change-ID: 20261106-firehose-v1-af7cf3b4ce48
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
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aeda11f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=1VxDqnHFAAAA:8 a=EUspDBNiAAAA:8 a=WwDmlQMArVpSdK7AtNoA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX8xj03JCJWbrT
 5qO9/88pGlgoKznujmV1yRaD8X7eiWmH1GZutoglLVCLoy8gKSwILLmYXaFzQT8AXKF1PQcW8ip
 8Uhuv8m4t889MzIwfYLZQuOtHR6aBRY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX6JO4tk332g8t
 QxyMrlREYWVKZ7KGBZvCuSyiE0w80+QJkwIvTHBf1UkItlYMphU86Traci2DFqJAjAsfz08xLsf
 C9JTfZlzxwi+EQl5JGr3QIxfhvWWQdDej8gxBeCA7n9nT5xC+rRPJauBpg9g9CZy7TeduE/i2Zn
 5v+uLngMMVEl/W+fO2YUQpNL9jfBFHcQi41sip9638VbK5oR/TSzCVUHxfLNbP8uFyK2ikoErhA
 yIIsWU+jgZj/qgD8EAwG+odkec+8Biv6T4BkDEd8NuQGarX83nc89rmxYIqUDUBQRlp9TDwJI5z
 Dm+PztXnpRGQzr3lqcei3sKu0zLPF57uk0HJqaVDeNj042A5Y+BhGCgA2tHVywdc3KHcI9yabo2
 jIOCW3p4HOXIivE1islMbrIoX8PHiXSI6/nwUoUuEpeU6EJRmBeGV5d0tkAsQYZGZ8q+nSaEY9+
 vHVOJfswj1lRipSnQkg==
X-Proofpoint-GUID: S9AT022skfLQGEdZgprJIUyBNFU9zP6I
X-Proofpoint-ORIG-GUID: S9AT022skfLQGEdZgprJIUyBNFU9zP6I
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a "firehose" command that serves a block device to a
such tools as QDL [1]. Firehose is the protocol used to
flash Qualcomm boards in EDL mode. With this, a board running U-Boot can
be reflashed with the same toolset used for flashing any
Snapdragon-based device.

As discussed on the RFC [2], only the subset of the protocol needed
for flashing is implemented, and the XML parser accepts only the subset
Firehose uses:

- configure, program, read, erase, patch, power (reset) and nop
- physical partition 0 only
- sector values N, NUM_DISK_SECTORS[-N] and CRC32(<sector>,<bytes>)
- no VIP, UFS provisioning, getsha256digest or getstorageinfo

Btw, work is ongoing to make the Firehose and Sahara specs public and
community driven, so soon there will it will be available and used
as a reference for host and device implementations alike.

The command usage:

On Snapdragon SoCs the gadget enumerates as 05c6:9008, the EDL ID, since
host tools like QDL only probe this VID:PID

Usage in U-Boot:

  => firehose 0
  or specifying the storage
  => firehose 0 mmc 0

Running flashing tool on the host:

  $ qdl --storage emmc prog_firehose_ddr.elf rawprogram0.xml patch0.xml

The device is either given on the command line ("firehose 0 mmc 0") or
picked from the MemoryName of the host's configure command
("firehose 0").

QDL automatically skips Sahara when a Firehose "server" is already running,
so the programmer file is not sent.

Tested this implemnentation with qdl v2.8 on the Arduino UNO Q (QRB2210, eMMC):
- reads of flashed partitions match the images
- write and read back of a scratch range, with and without a device on
  the command line
- erase reads back as zeros
- GPT rewritten with gpt_main0.bin, gpt_backup0.bin and patch0.xml is
  byte-identical to the original
- a read of physical partition 1 is NAKed
- power reset from the host
- test/py test_firehose.py: 3 passed

On sandbox, the ut tests dm_test_firehose_* and dm_test_cmd_firehose
pass. UFS and NVMe are untested (no hardware), and so is a full
rawprogram0.xml flash.

[1] https://github.com/linux-msm/qdl
[2] https://lists.u-boot-project.org/pipermail/u-boot/2026-November/638973.html

---
Igor Opaniuk (14):
      usb: gadget: add a Qualcomm Firehose function
      usb: gadget: firehose: add the read command
      usb: gadget: firehose: add the program command
      usb: gadget: firehose: add the erase command
      usb: gadget: firehose: add the patch command
      usb: gadget: firehose: pick the storage from MemoryName
      cmd: add the firehose command
      doc: usage: describe the firehose command
      mach-snapdragon: use the EDL USB IDs for Firehose
      configs: qcom: enable the firehose command
      configs: sandbox: enable the firehose command
      test: dm: add Firehose tests
      test: cmd: add a firehose command test
      test: py: add firehose tests with qdl

 arch/arm/mach-snapdragon/board.c    |  23 +
 cmd/Kconfig                         |   9 +
 cmd/Makefile                        |   1 +
 cmd/firehose.c                      |  50 +++
 configs/qcom_defconfig              |   1 +
 configs/sandbox_defconfig           |   1 +
 doc/usage/cmd/firehose.rst          |  81 ++++
 drivers/usb/gadget/Kconfig          |   9 +
 drivers/usb/gadget/Makefile         |   1 +
 drivers/usb/gadget/f_firehose.c     | 849 ++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/firehose_parse.c | 282 ++++++++++++
 include/firehose.h                  | 117 +++++
 test/cmd/Makefile                   |   1 +
 test/cmd/firehose.c                 |  40 ++
 test/dm/Makefile                    |   1 +
 test/dm/firehose.c                  | 204 +++++++++
 test/py/tests/test_firehose.py      |  99 +++++
 17 files changed, 1769 insertions(+)
---
base-commit: 709a97a05df66e394f40d249105d0baade46f107
change-id: 20261106-firehose-v1-af7cf3b4ce48

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

