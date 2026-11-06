Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183F606A32E
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GK++ga28;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TfgiOQGA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SCyGFb28
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DB1A409A5;
	Fri,  6 Nov 2026 09:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GY83C69sdgwc; Fri,  6 Nov 2026 09:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E23D409A1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958205;
	b=Zkl/6daw4c1+ss5JsNhikW25WOCbB1ow3umvlnvhMaT0XZz51lZeIdB3gwM8T3ZCR2/A
	 8dsdSAMMSAp6gmUoUx0mXqctIlffiUg0Nu/5LzU+QGPMHItbOp1fbKsEMH4/5TLMORfSo
	 Ld67lXFY0tQPIKo1FD+my6OQI97HHmnA72R8h4doumv2SOTRvy4UACF6088jsSkmIsICK
	 MHTh2xPE/MIL824CwspaGsvHW9bHKikUkdzvrek0zuu4o5rqMCyRagtMuhreW5izuLBzl
	 27AzaOcLDMnRmU1BuNY4oXHMLhd7TUO4IWlcFs9YngVSQwv3NTS39cFmfYYhPrxxXtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958205;
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
	bh=sVYXoRLqvxmlXS8CQTSvSIo7Wht4n+RrPYxMGZMUSgU=;
	b=KHn/pMgwjEGZ/Tsi+tyHX75ddoPh+Z5PQWnckgkVIIpQvYENKigiFGIPVqYCgyc+XHqb
	 U3j49HEf1IbfqJjh39BRIyA0dKnwGGfHNA7fZyQxaY5Z1VisBx7StlalAdKE3D6rAIK3Y
	 7O/+Uegmfm4+MxzvvYxkc6Y+KCTHxakxVbzLEsS6pwjxfGiQKVXUXCe+YdoQklkENdLvh
	 YwGFx/g0jz+oX9hjTTbWjCqrBKF0GLdLhDw8DQ5Gh8w8et5UC74jaanRMWvY6dFOMC944
	 YBRnD9PYTv+vxNGALHaxHGP9JGxJJTFAVDYU7HO2D4WxGZ8R1youqusAHRjje3rlhkw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958205;
	bh=sVYXoRLqvxmlXS8CQTSvSIo7Wht4n+RrPYxMGZMUSgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GK++ga28sqFY3qfoBbnR7J3fSD7yaGvgn25WGFoBF7/nhTAzxNE+2eiLWGz5PqsWT
	 qzse20FlW0Gzs/rG2rktHW9fOgL3/PkqD6UqYoCe7LJQs5dq0yE7fvV/qLr4dppYOP
	 I8IhqGkbSXuutjwjASG86IIy98FK+qqQ4XiQSzTZjZcS0QSzcaA9DrdWRlAyulfpbW
	 iRhUt2JI+00j7JQqerjd0bV1ROXXx8th+xQSbKltmC/Q07uF8g52N7fCfrCaPPcU8Y
	 AOP0/lhWUvwPORZOtdDS960y6cnSaL5oJW3EgaO4SWx26M6wjEa24XOp3HU/oxsPYp
	 8UYDsrRwwVTZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E23D409A1;
	Fri,  6 Nov 2026 09:43:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB4731E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9CEFC8119F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uBeb9rIqeEw2 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 126E98119E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TfgiOQGA; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SCyGFb28
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 126E98119E
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:21 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67R7uM3243883
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sVYXoRLqvxmlXS8CQTSvSIo7Wht4n+RrPYxMGZMUSgU=; b=TfgiOQGA8L87yioi
 pbIxiCyPu94K9Hp/FblqkMbM3CODgLUm1IMKSvdNvF/EG0xqmFdn8qfOIp/ZOJDl
 eMOCubYkbhltMZHQgUp8hnoqaSQPIIF/TXYCY9r7tYQ8+GI0ySN/ApqX9qokBsuf
 LHMDD58POszV1arHEqGbyd4d91kl2RwNBSMHTKw5jP74/vQUuyt0x8Zgv6zGcx+p
 xuog57xVpljXhl8sKjpXaGH/DFyerVt9ndwRyRtzmm9/X1NGVBmpys/FENl8+vhe
 a5PmxSTUzpvvzuKtosZn+XA1vqcpznwO9gTIzjQ6HsN7l7M3DTvYPA67Rfpy6F4l
 UbxE4A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa24y8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2005ce21so89483785a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958200; x=1794563000;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sVYXoRLqvxmlXS8CQTSvSIo7Wht4n+RrPYxMGZMUSgU=;
 b=SCyGFb286Tp+d1OKwJEGXrgRE59EqpxsQ8EGhVTViBKo++V+vp6n5blBADRA+gXayL
 SRm4T7uhf6NzG9j7zBUB7cMMM0CYzKn4201Zm5gfJGHgXCIsp1MxunmydYE51HiIa1Va
 jCDShkcyJUsAehRYK60Jcdoq6EL+sLx0/La6yiTHnYTBWE1XTo+XkYKc/xNGDFE50oiI
 QmrKm/I7L47ghZJogeXKw6eORAs8kWh/qu1cQS/+DoZUJzxoJiTQL/nF7q7g2H4cLyp8
 X4b22Cl4EZUEDx3hJWr4ALQtyiwt6CeNLdOozZMffYLLY9+ZoGUIbkibxW9rUWIA/LVK
 bmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958200; x=1794563000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sVYXoRLqvxmlXS8CQTSvSIo7Wht4n+RrPYxMGZMUSgU=;
 b=GRMR6GVQSOV/JCPu6rUnV6OzlDQ6Ai/rkLSyJPpo61esQGzHo2zzqSMM18rEkb5NZ+
 SIJsDCPe02LiMxU7d1ueWG2d+AYEXyiLBnd2/Ln9TFYjQxHMvG6jUWIIekg9i+IyxASv
 ZJZ0PFXF+p9I2Ldiu15IGBMqyVjyOL/33n+JKPl/lzXpz0gsLY3tRg2724czW3DG11lE
 d0OyBtcqu4hijpGHniOi8IsoI4SmGA/OBet6P6eCMRmBu2Q39hsQtMUW1mswUyWELXGp
 mQWiBSvAz8cGqtZ7lJGj7aVTiHBGEEllX71fG/cUiajSzu6DTu+w9QMPgVD/T8hCoipH
 yXqg==
X-Gm-Message-State: APuU4Z+XgAaVw/lWgpErbNd07W2Qa3RkMdhUlSmnns1iKuBK5HihInmG
 mRVWctMMLBWeckBL078nRq2JSAITjEdjBFdj5zyD9UjnhCp+XHfBcueACxi6b0mTX1ntNohTfPO
 YUgHCNjN7CwnsMmxABikMgyxQ2BBPu5UhtIDhkONlwlbiQZSTUSQtgKnJqMdGuohp6FH0PBg=
X-Gm-Gg: AYBFou18E/uQ9hSEVSqvUlCiSu+AnDRw67ev0/WJKawzrYEdcfCPB4s4K+M8VsM/f8T
 es9BlWdSslx0eNndQ2FA6Hj7x2Q7kRl2hn01pKjAo71TbU4y2aD1OOOw8KxcoA9dMtjJqQbPbWj
 eRe/njg3rx1a+lnnrHE1ouZ0Q7xrHhcrM6gP1eBU0BIzQ4qsqpno7dA7ZYiwqezLTlyd4B+Cm1J
 VEZ6jK94BBOuvpUrtikKwG6JQwE4jYC0ucp+mf85sAAmJvxJnNUmVRS/jHvdUaWsabMyJreHziE
 BCUxxQ9ZNzpzy1YO8rRDnij/CRcq1oy2+ffnyXJ9mJ/gh7ZhwVY5PoKt159ASXR+vKmkoDA+6rB
 XfkxopQEHtKgv26XtqbL2R32wOflAS03ooj+pTrCPUaaj3OXfl8lOD3rRNBCJq1SiPQBoPLQzK6
 T7rwLosvD0Q3ky
X-Received: by 2002:a05:620a:270b:b0:944:192:85f1 with SMTP id
 af79cd13be357-945f34ee6ffmr265304785a.48.1793958200079; 
 Fri, 06 Nov 2026 01:43:20 -0800 (PST)
X-Received: by 2002:a05:620a:270b:b0:944:192:85f1 with SMTP id
 af79cd13be357-945f34ee6ffmr265301885a.48.1793958199645; 
 Fri, 06 Nov 2026 01:43:19 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:18 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:42 +0100
Subject: [PATCH 10/14] configs: qcom: enable the firehose command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-10-e7591c12fc65@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aeda139 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ccr4njV4S4mf9kQOGJsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX+oZiNVL8B9GP
 lg7EYdXkn/WVYSwcSbUhStl+FVBM1UdDQTfWnIJ+QVGmsHhZ06ReE1IsIQzEGTxUdDZ9k5D2dcH
 OAEIgoaTq4JXduwhWb+nmOwnOPIE+2A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX8xAHjEJvSyNR
 HwzPaD9qNXRYvlZyXfkWkCRCVqpxNdXxLec1tpiTkK1JVAadSzj9NIs9rtPjlutegs0JyDZNODz
 f1nXpHFbWhnKwngP0Z0bOIijx2LSfyGeSi8U6dU5sUiJ/6chbwKlbgljAnzu9m3koFj0CyFg/ZH
 KNI6sG9aN4xaj1CQcLdn3boPpx9bXnaeog11Cl7GKaQoyxlbxB/25OWWDFjCDstFOQevoCcpMOL
 H9GgDIvYNfTlrK2wQT9ItaUbS9vihhY+G+0+Dw0pCLOKw0Jn2YIuUq2AEXaQsa7oXaboC1ZsQpT
 zVy7kPWI5vSFQHmTKHfgz8ukUJ/IUgsTIuaz0v6wVlQ7PDKVNHB3e04qYiSCnsyaelyaMy5kglg
 LpQKjdJqS5yrucnW27D1l+qwsc/jh51lEji9zCVeTzB7hK3wgB+6EXvnZ9JHC9zDa6irLMUCIOF
 VNXv6EifGEG36k1f9Sg==
X-Proofpoint-GUID: xCxWCBhYArTniClKmKgb2wiPWAgie9EJ
X-Proofpoint-ORIG-GUID: xCxWCBhYArTniClKmKgb2wiPWAgie9EJ
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the Firehose function and command for Qualcomm boards.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e5291750aa7..a29352eb8a2 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -41,6 +41,7 @@ CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_FIREHOSE=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y

-- 
2.53.0

