Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C9606A32E
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TBTBBVcQ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e0Sk6I2g;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DU+92gNx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9852640960;
	Fri,  6 Nov 2026 09:43:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vrUgoLXsHhXS; Fri,  6 Nov 2026 09:43:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4882E40971
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958192;
	b=c9hDbikxXdo3icD/v/JTAMYru6uLNCt8EmrdPaat3bCU8Is5nv7qgvVYoE1F8Txp3J3V
	 pMXB298JePLreKYYxNBQugR+411IY/UZBWBectEjxCYV+Md3oz2cniaVaZmwfeULm0nT5
	 X3mDLhdZ7SX9qQt0yH+WeaiJ0rRAi9n1BqlgFahOebupC+L/rRS9shWMwMcC4j+s9XDP4
	 V1Q4KviPbL7kzcUj5xBF78g9/wIAtywmuOAWYgNCmvJ2KaBD3rgmQW83T2K/dIO5tvNQR
	 nToc1tN0XinwTNqt/p1nQvcgxQY89x6/WYry0Gg+oEdZ5I30Tw5DbJ1yoORzs8+YLjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t+aAv3hRfX88doi4DOMqtGyFLGH9CcsfYow6tMQsnWE=;
	b=rQW8Vgy6xVoxboE220tpHqbZ6pp3Yqq/ELFxeV/pjAjXfZKyVMw+bNYhLeEnJB+38Azv
	 W40b1HvVXre3rrL7Aa9P7hJP2nQhfhIwlwsQXu3I+RYXtlWTtJDMr1Amhyyxhtat9tTET
	 tnJol81SgROYV2OElvo+pZtMnED2r4jZ9HVN2q0pNQkm6KiERQ6aRiQ+WT1DYjlfAInal
	 GX2Q4mud2EnYhmehJW4vmm0iuAZUGZmR0hn+l6vfbzZQUKCmgAHcRky1qZYS1ZoDagN8a
	 T26OS5GZGJUavebV87joRYzgreTgSqdCLx1U0VXYNl2j9A6n3hfOcwn0z00mFCfmuUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958192;
	bh=t+aAv3hRfX88doi4DOMqtGyFLGH9CcsfYow6tMQsnWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TBTBBVcQHuKGtWCFRYJEgnE+9SQ5+BoFiBoMMWRX2zGEkf0nS/cf9iIiXUxwyfXwg
	 PZiR3kUxWawcyqcEiYGWEpIObheZS78//03YfBViU9vaFpePMzZsl25ol5TjuSosCd
	 kxMfotH8TSTvgSJvzRIkgAijUR3bg+D4mVngKaW9dvEejn8mKAdlAQJa+YTox/Yi1k
	 epvy8RmdVZOblCwMq1puf0BQ1gKnPk1zk6t1Zlv7bxQH97Ehz8JLqGmeDVEVWTf5j4
	 moagmYDiwJDu1mLsruwh7dLWtivCVgWXFeO9G3EL9m2Fr8G/wO2lrT6hEnC6w3ToAa
	 0ALpdXNOdY/bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4882E40971;
	Fri,  6 Nov 2026 09:43:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E95031E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF17F403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6tnqvVNZXF5 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1329B400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=e0Sk6I2g; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DU+92gNx
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1329B400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RJ6o1679467
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t+aAv3hRfX88doi4DOMqtGyFLGH9CcsfYow6tMQsnWE=; b=e0Sk6I2gWdk0Bbfk
 ncDsk+1LMtSLiJqIhKbYQ4h8Z9o92wySB2MXbVa7MsNAs/aOUTt/OL4H9huD2eJE
 9fU+ag3pXSlEOx6xSbwyTjCzA04nOPm30BjQEXI+iRysrNEIPLAr9aSVcikK2dUq
 IYX0Kjr2ntVTn8qP5ZY45IfK0VMVo8X7Z556vy2DJggnUTPNvNWb+4oVGcXq/6dz
 LdEa8UTxT72Mv5PShs65EYEq0it31yaPA35R+SHkkX+kUzUMnCzrYhx2dMb0bkti
 K9JPOuZdTB+0KtGz6zb6sYxUKDevk+JQFqv3mbVkB7+YliE3a3GX3Odv7NLyH040
 fxUOag==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pca5j8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e92aad34aso115613685a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958186; x=1794562986;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t+aAv3hRfX88doi4DOMqtGyFLGH9CcsfYow6tMQsnWE=;
 b=DU+92gNxpVpf9yTJWl2vH26clQFUREvS9/dRgJp/LD+d9Oazo4q/D9gyH0kP77BaXS
 FuUzkkfELqTLWtV+Gjx/8LZdk1ctie2IMrDe4co/n3GN7+gTddZ3tHfZaSRrrVzYeOuz
 yB3688Vl8jLL7hsx4HOUfcC4mKJU5jxpWa/WPO0Kim9/pTVuY2DyXI+kPGCKlTmWR2mJ
 Qq7bVHNm6aoutqjuIvnwRtFvF7H0iPhNh9+NHMIucweYRF+oYyl0a2QIsKL2IeZsAcT4
 MRonACWe7ycUA/itTGpuFbbpSpCgFCJqpfCiw9B4qS7zaltyFtnX2hWzt7it4rZsIZj5
 SVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958186; x=1794562986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t+aAv3hRfX88doi4DOMqtGyFLGH9CcsfYow6tMQsnWE=;
 b=axV770PP3n161wOumsLEiS3YLaFjijPBuUZfUCNz8iiGZ1MH+pygYW6hC6jyi8465e
 +rssm/Zwo1Er9DY4AQbWDe8TQ93V+T/MQRsE9DBbEKD9TZDHQx0wVeqHvJUdJ6zPz20I
 emKXDzUcexvkmkVkbth6vpLKyyxJqzLD3/3YEYfanuRQnqwLnJZYSuzMKQKFvopRxz2T
 /e5TlEtV+34uSCXzViIrz9+SWuoYhw4H8fHbYWHS+wsemphmkToSMIuIJWGO/InMqA6j
 m/VdwS+xOCF3mXwle9T8ACr4bmp7AiWZtM/t+wOD7rfMDm3GGNaxSgr3UaQWgs24P89W
 zJTA==
X-Gm-Message-State: APuU4Z9aqpUizaPcMrras+W9nMhgBDcV6W+TnJMIMHqSanynLiTVIqn/
 OJGagVATAQAkxP+qXtRJ1xgVvJYXd9Sb/8I65vksqHCKO4Hu+1zWLcpRNJUzL9uqOYA5ddumfIt
 6Dvs8Hy8t69a6EJGg7a+ZBahc9plWEZCa8wRCeEqrJ2FfWze1cGImVBiGoDeDTYhDOEgmiRk=
X-Gm-Gg: AYBFou1gLshL7zeWMu+dAK/9hSl1RTjXdEQavbHuzROsFsXx+S0Jg3KuMcsc6NfyGSM
 3fpJ1N4ZugIPBLdVSBzfmaFRjxloL2kd6wEOJMevGlhdrVr/xnM7zsKcTdzU0eTCKzdqFIPo278
 kRtiWTOmCi++W2yzZ/hfk+pDsCO1PKQevnlFZYV/hOlDja7tWb9Y7JItQSQFS6Fmtw5mTH8YM23
 NwYzeI311b5g+luaWCrjvCr970aDpC4AYQdPQN8bhzN0JMrQ9p43WzjCf5cjStfEUbOSVYGb5S7
 qPcpf7Xs4NDvGgM9nsUNYun7u+W/DOg/UiwiZ+kYukUoUV577LFrCL2+gu/0iABEFPC7bPEBo+v
 LVKJYMlRm5YhBrE68zYmNOuEjON/UQopOiAVOIdbB/ROSAsI380nJUYb3XgrpK/O0XSpdZDjwWg
 Eu0PCpT9xf9dwy
X-Received: by 2002:a05:620a:28c5:b0:93f:2940:1ff0 with SMTP id
 af79cd13be357-945f34b5572mr260402885a.24.1793958186102; 
 Fri, 06 Nov 2026 01:43:06 -0800 (PST)
X-Received: by 2002:a05:620a:28c5:b0:93f:2940:1ff0 with SMTP id
 af79cd13be357-945f34b5572mr260401085a.24.1793958185665; 
 Fri, 06 Nov 2026 01:43:05 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:04 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:37 +0100
Subject: [PATCH 05/14] usb: gadget: firehose: add the patch command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-5-e7591c12fc65@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: o5V1PVTg8idRcYRBBy_pnba2fHs8AfL7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX9vqogWyfzZDE
 zuEjmQUpPBs43HXZgpwhid/jRPIKUT6ak6i0RUoXbKday1mRFPCWRcpX5ZvE/UnStBIxtbSr2Mv
 qW7bmqeZMHJ2hODt4a8g7eSZ+4J34I8fg4iM6Pfp3NWQR5YmaznUIgR+wnoABgf7RPZfX9aHC9n
 O4j0zLb7maOIrmdsCVktwuM/Mds/yDQ3rUGjt2hSTkEuflsqQ02F5Df7EFiuBHEwhIpR8QwbATs
 SDt6c9F78YinA28vnGjmQT5svXMqlBgZQ3HbHg4fs4DAPefE0E3Q4fkPytIqTQMoC5p+Z603XGk
 bd4eGMO0LRBZ8ZEa9NYBa/S/OhEw2l6xGKp9We7E2F3+bHJVLbkJk/GttGZHR0bH+88bDSepvyC
 r4BXMG9klck1j+jwtPmKYoYxPIR4orPZFu//V2foaDrhhKv9KqW87z0Fcl8NC+MdvJJq26ykawl
 0Ta4eNi2gaYaRcljJYw==
X-Proofpoint-GUID: o5V1PVTg8idRcYRBBy_pnba2fHs8AfL7
X-Authority-Analysis: v=2.4 cv=TI3Q2Fla c=1 sm=1 tr=0 ts=6aeda12b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=J2job7gXp0_hrzKi1eMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX981N7ZF5hcEi
 FHsf4KOWMmEgB+RUHlUYTuA3WjLM8sobxASfI71SjaBbPlihlC+DqJkz2pkNDkObNF2iFw+T7T1
 /ySY66M26QOp9Vv+vModBZzK/C7rYOk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Write a little-endian value at a byte offset.

Values also may be in format CRC32(<sector>,<bytes>) over the device
contents, as patch0.xml uses for the GPT table.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/usb/gadget/f_firehose.c     | 54 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/gadget/firehose_parse.c | 47 +++++++++++++++++++++++++++++---
 include/firehose.h                  | 13 ++++++---
 3 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/f_firehose.c b/drivers/usb/gadget/f_firehose.c
index 5f36f0ea8e3..14a28a51fd9 100644
--- a/drivers/usb/gadget/f_firehose.c
+++ b/drivers/usb/gadget/f_firehose.c
@@ -441,7 +441,7 @@ static int __printf(3, 4) fh_log(struct f_firehose *fh, bool err,
 
 static int fh_eval(struct f_firehose *fh, const char *s, u64 *val)
 {
-	return firehose_eval(fh->desc, s, val);
+	return firehose_eval(fh->desc, fh->buf, FH_PAYLOAD, s, val);
 }
 
 static int fh_check_partition(struct f_firehose *fh, struct firehose_cmd *cmd)
@@ -645,6 +645,57 @@ static int fh_erase(struct f_firehose *fh, struct firehose_cmd *cmd)
 	return 0;
 }
 
+/* Writes value as a little-endian number of size_in_bytes bytes */
+static int fh_patch(struct f_firehose *fh, struct firehose_cmd *cmd)
+{
+	struct blk_desc *desc = fh->desc;
+	const char *filename = firehose_attr(cmd, "filename");
+	u64 offset, size, start, value, sector;
+	u8 *buf = fh->buf;
+	lbaint_t n;
+	int i, ret;
+
+	if (!filename || strcmp(filename, "DISK")) {
+		fh_log(fh, true, "only patches of DISK are supported");
+		return -EINVAL;
+	}
+
+	ret = fh_check_sector_size(fh, cmd);
+	if (ret)
+		return ret;
+
+	/* CRC32() reads the device, evaluate before the read-modify-write */
+	if (firehose_attr_u64(cmd, "byte_offset", &offset) ||
+	    firehose_attr_u64(cmd, "size_in_bytes", &size) ||
+	    !size || size > sizeof(value) ||
+	    fh_eval(fh, firehose_attr(cmd, "value"), &value) ||
+	    fh_eval(fh, firehose_attr(cmd, "start_sector"), &start)) {
+		fh_log(fh, true, "invalid patch");
+		return -EINVAL;
+	}
+
+	sector = start + offset / desc->blksz;
+	offset %= desc->blksz;
+	n = DIV_ROUND_UP(offset + size, desc->blksz);
+	if (start > desc->lba || sector > desc->lba - n) {
+		fh_log(fh, true, "patch beyond the end of the device");
+		return -ERANGE;
+	}
+
+	if (blk_dread(desc, sector, n, buf) != n)
+		goto err;
+	for (i = 0; i < size; i++)
+		buf[offset + i] = value >> (8 * i);
+	if (blk_dwrite(desc, sector, n, buf) != n)
+		goto err;
+
+	return 0;
+
+err:
+	fh_log(fh, true, "patch at sector %llu failed", sector);
+	return -EIO;
+}
+
 static int fh_power(struct f_firehose *fh, struct firehose_cmd *cmd)
 {
 	const char *value = firehose_attr(cmd, "value");
@@ -672,6 +723,7 @@ static const struct {
 	{ "program", fh_program },
 	{ "read", fh_read },
 	{ "erase", fh_erase },
+	{ "patch", fh_patch },
 	{ "power", fh_power },
 	{ "nop", fh_nop },
 };
diff --git a/drivers/usb/gadget/firehose_parse.c b/drivers/usb/gadget/firehose_parse.c
index ff99566eb40..07de9065b71 100644
--- a/drivers/usb/gadget/firehose_parse.c
+++ b/drivers/usb/gadget/firehose_parse.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Qualcomm Firehose command parser and rawprogram expressions
+ * Qualcomm Firehose command parser and rawprogram/patch expressions
  *
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <u-boot/crc.h>
 
 static char *fh_skip_ws(char *p)
 {
@@ -166,10 +167,48 @@ static int fh_sector(struct blk_desc *desc, const char *s, const char **end,
 	return 0;
 }
 
-int firehose_eval(struct blk_desc *desc, const char *s, u64 *val)
+static int fh_crc32(struct blk_desc *desc, void *buf, size_t size, u64 start,
+		    u64 len, u64 *val)
 {
-	if (!s || fh_sector(desc, s, &s, val) || *s)
-		return -EINVAL;
+	lbaint_t chunk = size / desc->blksz;
+	u32 crc = 0;
+
+	if (start > desc->lba || len > (desc->lba - start) * desc->blksz)
+		return -ERANGE;
+
+	while (len) {
+		lbaint_t n = min_t(u64, chunk, DIV_ROUND_UP(len, desc->blksz));
+		size_t bytes = min_t(u64, len, n * desc->blksz);
+
+		if (blk_dread(desc, start, n, buf) != n)
+			return -EIO;
+		crc = crc32(crc, buf, bytes);
+		start += n;
+		len -= bytes;
+	}
+
+	*val = crc;
 
 	return 0;
 }
+
+int firehose_eval(struct blk_desc *desc, void *buf, size_t size,
+		  const char *s, u64 *val)
+{
+	u64 start, len;
+
+	if (!s)
+		return -EINVAL;
+
+	if (strncmp(s, "CRC32(", 6)) {
+		if (fh_sector(desc, s, &s, val) || *s)
+			return -EINVAL;
+		return 0;
+	}
+
+	if (fh_sector(desc, s + 6, &s, &start) || *s != ',' ||
+	    fh_parse_u64(s + 1, &s, &len) || strcmp(s, ")"))
+		return -EINVAL;
+
+	return fh_crc32(desc, buf, size, start, len, val);
+}
diff --git a/include/firehose.h b/include/firehose.h
index c8f27af4f5c..9ab5c5d37d4 100644
--- a/include/firehose.h
+++ b/include/firehose.h
@@ -75,16 +75,21 @@ const char *firehose_attr(struct firehose_cmd *cmd, const char *name);
 int firehose_attr_u64(struct firehose_cmd *cmd, const char *name, u64 *val);
 
 /**
- * firehose_eval() - evaluate a sector number
+ * firehose_eval() - evaluate a sector number or patch value
  *
  * Accepts "N", "NUM_DISK_SECTORS" and "NUM_DISK_SECTORS-N", each with an
- * optional trailing '.'.
+ * optional trailing '.', and "CRC32(<sector>,<bytes>)" over the contents
+ * of @desc.
  *
  * @desc:	block device the expression refers to
+ * @buf:	scratch buffer for CRC32()
+ * @size:	size of @buf, a multiple of the block size
  * @s:		expression
  * @val:	returns the value
- * Return: 0 or -EINVAL if @s is invalid
+ * Return: 0, -EINVAL if @s is invalid, -ERANGE if CRC32() reaches beyond
+ *	   the device or -EIO on a read error
  */
-int firehose_eval(struct blk_desc *desc, const char *s, u64 *val);
+int firehose_eval(struct blk_desc *desc, void *buf, size_t size,
+		  const char *s, u64 *val);
 
 #endif /* __FIREHOSE_H */

-- 
2.53.0

