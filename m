Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEBB606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s1E/gn2v;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GML6cwW1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EiCiJDpn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CA52811F3;
	Fri,  6 Nov 2026 09:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_eTX5rg6Vsa; Fri,  6 Nov 2026 09:43:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 232798119F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958197;
	b=iq/D0PZIBVhll/OI2z/znIejWywHwjbSA7HQer2GBipSUtXkpih4BfrKRkPivwoG2pxr
	 V+p5DicEAWyxtw8LFY6dQYJ2SjOBEz8DO/6bErE5+nFZ4FFQWOo1bFmjApPbzTJIQRF2B
	 LaXI0A0fZTTKwQQqc1JXMasPsAZPFzzWaCqJXCSUPKqZBLjbgtodz2p3QyycguYfK3SgU
	 ca4zQ8zdtwKSqHYFOGKhwyjh4kO/SPEU6i6KDAfdvXW+/r0Lw6eQf2bKaoH25V0/d5fsi
	 FHDnp4XX4B6hjBYxuBLlpwjfQ+PpVjH1UiKuCTyIv3kTHfBjG55jF491gJ3fRQvuYIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958197;
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
	bh=aIOhgk32BZXquhLpjVFF2IEwyjGy5LlHxiQQWD9rcAs=;
	b=Sw/m60qWVoKAVRiurOAoPUfE5SOdoykUY4LQdykG9uJ2JuUD2QgdUsuVHC35jVaSwdZM
	 u8sxRV/Ztr7EN33jwyFQ6ZrLF/x6LAbiRO1Kt4oOUMCCukL64nw7KBg9ti/39FHxqpMqe
	 VPurv21Nvs4g4Zv/q8QMMli17DLVNVw1mr52RWYnd+KjyKULqxPPwjMZnf5vRLDXPqf9A
	 ggPlnHZY7nO8khjcEllR52RWselDvBAbr5EWEjXACU+x2WuztNSdWlM0n0nezea/RChWG
	 /zgc0vw68RnhoRh0/6gnVESZLAXf+8vXFGAUPwnc+b841YjR0/M45g05XWmScg/Wcww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958197;
	bh=aIOhgk32BZXquhLpjVFF2IEwyjGy5LlHxiQQWD9rcAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s1E/gn2v1H5WX5ca3irhMqsDOZAoAT73AqtnoiVdKf5+/lLjvLPnU+81zjvwD9dzy
	 2qlzxD8Z2xE5FfWnS8uRrcCToKsHFTyo6swG4FZwJ6FBmpBrxA8Ojyj0/A0yaPXzq1
	 8BtTQRS7OXs92w+yVaC6FQImjZf7Qua4rcrb9N0+zaNFabsly/Vw2yGr2yuY7pbG6X
	 h9PpzbaoZ8DVsV3PmpceTs0/1sUHMk822pGbqvwSA7D1hlX5NIG8yFSeOqUMlRvq0r
	 a+wuj6dG4kR54lzIWvHPAF2kgft4Md4A/hdTzGc7UmZJIWpMftUAlBjLZ8yUaY4f4v
	 3RHyBUcZU6j7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 232798119F;
	Fri,  6 Nov 2026 09:43:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E9F9C31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBBDB403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q7j546c9vbKU for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0C53E400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=GML6cwW1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EiCiJDpn
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C53E400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67R7md3243911
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aIOhgk32BZXquhLpjVFF2IEwyjGy5LlHxiQQWD9rcAs=; b=GML6cwW1ThYEGhjK
 bZlCZ00wf3YS8xWKQpyfUemv+bLufwrmSv/2Lo4WamdY8Cvo0DrcbIzniZj4lh77
 OJgAAnXk1Iva9WmtHfkFlZPJM91/hPQ/6XIPC1wsIm6znaBOH77Ng/mPy9y3XIvY
 w9/u9bx3CZDDzDw93n0UJmujTze5tpEJh2Z3SG8N1IO6DAz5VL7i45vdPxl7LpPx
 gZCyNqtRmMT6gFDiG/6aMqPcp9Kg74UMZHM/pGAct5Lb6Djp8nDfXiJ2BsjmhEFW
 DekRdbzE/VoNNTXINg1QXN3LXL2u/4v5lCjykj3CRC9ZQ4zFo55NEUDjCLyqkRQL
 F1+Vnw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa24wt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f1e62510cso105910885a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958189; x=1794562989;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aIOhgk32BZXquhLpjVFF2IEwyjGy5LlHxiQQWD9rcAs=;
 b=EiCiJDpnSPl070U0zwOX50qkKcHz8iB5eyI9PD2GGkWkxJOOH+DsR3gYKozXVc4j9S
 Km1GQNOFUlHCqZddLGI7/LDg738qi6QSlhrZHdc1yr6idqmKdBIUt6dzL2Cb8v00lDSM
 tckZoYjCwHBvslC9UMDvNiBMMr/XNu9rKhDVnSnPIo40XoJUfagVjo8ZnY5MRa+qbrYC
 Zky0pxxj5zG2QUfRqONGykuKLJGWwS7yyKmIzevqXDcQEkkEn3eZ2UL0DpqcU+JT0VhD
 fqn7Vd4H8lzlyrCBRU+kNy34lpMoIqIdlvNV4dZNCErMzjf+rs/3AfTOiqai4Te/9dpu
 uaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958189; x=1794562989;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aIOhgk32BZXquhLpjVFF2IEwyjGy5LlHxiQQWD9rcAs=;
 b=HOTCiU1wjhhVWNby/AQDKm0+20VBkXyDwtvbAY5bcCHbxSngwCg36Y1JKW4mtuDzij
 qTtNHsilGG8yHZKSosAyTbhejDoBOZhBlv+ufHfWJquoZpOGAmWsIwzD615HvEH8ztYT
 /JNEfGj5QEK6cLdQBHOnb+Vhn1MAV+NhSz8Q3prxQetWS6z2Go1bL3pr1FWrdaoVKms5
 JJNP52rC4otyNZSxXoU05N+ZToEbrS0V+SRWpi6IGqkspMIdLjtum8DsloPCaFxR+oWd
 WoiGwQmOIbBVBr9BlkIZRBvHWC4aKzo1oe4wAz4LtHZ97LcD/injnEQBICuDgRoVfCZV
 b0OA==
X-Gm-Message-State: APuU4Z/X90C77mrSsIXR/QgDZTUGOrcxX/M8GrhHzjWTXAJCy2DAgQQl
 eZNNhm2TOgAU1hhOZKzkOvNo5jVj8ujKYPY05ohnOZrZwdI//KEYXrie5+HwdfiLmeHPSputHBX
 5OcRYHN27+zLqMnhyHXQf6ZE0m8q9DN121mbUmO/zZbkimZFOeGO143z+0xca4dUNUgZCPwg=
X-Gm-Gg: AYBFou1xYAzxirvFzRUEW6vgKWnResRaoL/rCpJYPEiDHDstzK98in7InFuA/Tzvtvx
 XSAfTVPES1gJh/4ELV08XB2aYRj9Jt8t5lqC9ZgYLukvZVAfEa2uwS2V7obI6T0ZefLSQoP1wJS
 z+Kdiiaexj7G2n0DF5HSKrSN20irVgt7fo9eXufTspdBLhiPcvHd5ZJ9hqX9O6MqVYqaDGOhhz+
 Y5TX4E4na1sPQuHAx+KHVt9J4oykeX/ff8+Brj8OGLQKEly1vOFlLyt719gwVPqN45I7995S/wY
 5fjU4JyvTRslJEku4wkJrvl1a6eh+r+8x8fKuIHIR+zL8sLjmVpkYlerpL/Z/cSeQRrrFdwPxbQ
 cdCpPiCvCcao0GhdYWd3i9Z+nRabr/H0ZoZlSCFvC82p5BbpKJ3cgIOG5TzwCC1mWBU7NFA9RWO
 hLAmir0Pj4WSz1
X-Received: by 2002:a05:620a:318e:b0:93f:1ed3:a9d7 with SMTP id
 af79cd13be357-945f34d82b2mr265216985a.27.1793958189393; 
 Fri, 06 Nov 2026 01:43:09 -0800 (PST)
X-Received: by 2002:a05:620a:318e:b0:93f:1ed3:a9d7 with SMTP id
 af79cd13be357-945f34d82b2mr265214585a.27.1793958188885; 
 Fri, 06 Nov 2026 01:43:08 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:07 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:38 +0100
Subject: [PATCH 06/14] usb: gadget: firehose: pick the storage from MemoryName
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-6-e7591c12fc65@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aeda12e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ZoSkeqUJdwFJ4aiteZoA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX/hSPuF2JpZmC
 fwoGvA01AzIaA6Iqrl7V/eVSLXll66sGzjr1qrcvj9vjbv2dyKcsjw8tBLk3sQKVaPgGWhizwCM
 CkHfFWltvQSNM89qGTzrJaZdjqTiFh0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX4hEsFR8RDJz1
 LAHZ+WX86pAsEnmrSNA5VcFcI4K0r5gts0ic14yz5MBhjUt6ocqbV3CWcxgfCeO3lqLLql23laK
 p7Bjzq31L4Xn4SetwTrLdRSYK15HnX8JKJJ9Y+haQZ+2ohb1kdnDQQCLakIeII2WImwgZItsGCc
 HMGCp6uVtaUj73aee9aV9DOh6jXBtjPbV5rizI0e8g5xtVQFgYvYu/0Z0/yz+RtmuZ/jqAYVcXp
 K7kViSQWioFSgHvkrxNT7AvYoH9sdEJtPi9aHMUcHjYpKgd0Gq7Orw+8fasTGs8gYJELJnSTH9H
 2nLGomlFJLKG/crmHGOq4WGDJ8kzdMxIxsa9XM+6Y7TVfY9702lEpJClGXMOMwmRLSA5wYOJFkE
 mP+j9DOUeAXB12mw8iz37X7IEXSaPfnFbfY5bw/hn9gt5LtumEAR38EJpaCwADuIUQ11S8RZGPY
 6RGBB3wxecZa6uUgx9Q==
X-Proofpoint-GUID: zb3yedtCW8Cf_WVWjLABOvRtIBz4LzUs
X-Proofpoint-ORIG-GUID: zb3yedtCW8Cf_WVWjLABOvRtIBz4LzUs
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Without a block device from the caller, select it when the host
configures the session, as Qualcomm's own programmer does: the first
eMMC device (SD cards are skipped) for emmc, the first SCSI device with
LUN 0 for ufs and the first NVMe device for nvme.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/usb/gadget/f_firehose.c     | 70 +++++++++++++++++++++++--------------
 drivers/usb/gadget/firehose_parse.c | 70 ++++++++++++++++++++++++++++++++++++-
 include/firehose.h                  | 24 ++++++++++++-
 3 files changed, 136 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/gadget/f_firehose.c b/drivers/usb/gadget/f_firehose.c
index 14a28a51fd9..b31f9fa6cd7 100644
--- a/drivers/usb/gadget/f_firehose.c
+++ b/drivers/usb/gadget/f_firehose.c
@@ -43,7 +43,9 @@ struct f_firehose {
 	bool reset;
 
 	struct udevice *udc;
+	/* Picked by configure unless given by the user (fixed) */
 	struct blk_desc *desc;
+	bool fixed;
 	void *buf;
 	char rx_xml[FH_XML_SIZE + 1] __aligned(ARCH_DMA_MINALIGN);
 	char tx_xml[FH_XML_SIZE] __aligned(ARCH_DMA_MINALIGN);
@@ -502,29 +504,34 @@ static int fh_get_range(struct f_firehose *fh, struct firehose_cmd *cmd,
 static int fh_configure(struct f_firehose *fh, struct firehose_cmd *cmd)
 {
 	const char *memory = firehose_attr(cmd, "MemoryName");
+	struct blk_desc *desc = fh->desc;
 	const char *name;
 	int ret;
 
-	switch (fh->desc->uclass_id) {
-	case UCLASS_MMC:
-		name = "eMMC";
-		break;
-	case UCLASS_SCSI:
-		name = "UFS";
-		break;
-	case UCLASS_NVME:
-		name = "NVMe";
-		break;
-	default:
-		name = blk_get_uclass_name(fh->desc->uclass_id);
-		break;
-	}
-
 	/* qdl gives up on a NAK without the payload attributes */
-	if (memory && strcasecmp(memory, name)) {
-		fh_log(fh, true, "MemoryName does not match the device (%s)",
-		       name);
-		return -EINVAL;
+	if (fh->fixed) {
+		name = firehose_storage_name(desc) ?:
+		       blk_get_uclass_name(desc->uclass_id);
+		if (memory && strcasecmp(memory, name)) {
+			fh_log(fh, true, "MemoryName does not match %s", name);
+			return -EINVAL;
+		}
+	} else {
+		if (!memory || firehose_find_storage(memory, &desc)) {
+			fh_log(fh, true, "no device for this MemoryName");
+			return -ENODEV;
+		}
+		if (FH_PAYLOAD % desc->blksz) {
+			fh_log(fh, true, "unsupported block size %lu",
+			       desc->blksz);
+			return -EINVAL;
+		}
+		name = firehose_storage_name(desc);
+		if (fh->desc != desc)
+			log_info("firehose: %s on %s %d\n", name,
+				 blk_get_uclass_name(desc->uclass_id),
+				 desc->devnum);
+		fh->desc = desc;
 	}
 
 	/* A host that asked for another size adopts the supported one */
@@ -718,12 +725,13 @@ static int fh_nop(struct f_firehose *fh, struct firehose_cmd *cmd)
 static const struct {
 	const char *tag;
 	int (*handle)(struct f_firehose *fh, struct firehose_cmd *cmd);
+	bool storage;
 } fh_handlers[] = {
 	{ "configure", fh_configure },
-	{ "program", fh_program },
-	{ "read", fh_read },
-	{ "erase", fh_erase },
-	{ "patch", fh_patch },
+	{ "program", fh_program, true },
+	{ "read", fh_read, true },
+	{ "erase", fh_erase, true },
+	{ "patch", fh_patch, true },
 	{ "power", fh_power },
 	{ "nop", fh_nop },
 };
@@ -748,6 +756,11 @@ static int fh_handle(struct f_firehose *fh, char *xml)
 		return fh_respond(fh, false, false);
 	}
 
+	if (fh_handlers[i].storage && !fh->desc) {
+		fh_log(fh, true, "no storage, send configure first");
+		return fh_respond(fh, false, false);
+	}
+
 	ret = fh_handlers[i].handle(fh, &cmd);
 	if (fh->xfer_err)
 		return fh->xfer_err;
@@ -770,8 +783,12 @@ static int fh_session(struct f_firehose *fh)
 	fh->xfer_err = 0;
 
 	/* An XML first message tells the host to skip Sahara */
-	ret = fh_log(fh, false, "U-Boot Firehose, %llu sectors of %lu bytes",
-		     (u64)fh->desc->lba, fh->desc->blksz);
+	if (fh->fixed)
+		ret = fh_log(fh, false,
+			     "U-Boot Firehose, %llu sectors of %lu bytes",
+			     (u64)fh->desc->lba, fh->desc->blksz);
+	else
+		ret = fh_log(fh, false, "U-Boot Firehose, storage by MemoryName");
 
 	while (!ret && !fh->reset) {
 		ret = fh_rx(fh, fh->rx_xml, FH_XML_SIZE);
@@ -790,7 +807,7 @@ int firehose_run(struct udevice *udc, struct blk_desc *desc)
 	struct f_firehose *fh;
 	int ret;
 
-	if (FH_PAYLOAD % desc->blksz)
+	if (desc && FH_PAYLOAD % desc->blksz)
 		return -EINVAL;
 
 	fh = memalign(ARCH_DMA_MINALIGN, sizeof(*fh));
@@ -799,6 +816,7 @@ int firehose_run(struct udevice *udc, struct blk_desc *desc)
 	memset(fh, 0, sizeof(*fh));
 	fh->udc = udc;
 	fh->desc = desc;
+	fh->fixed = !!desc;
 	fh->buf = memalign(ARCH_DMA_MINALIGN, FH_PAYLOAD);
 	if (!fh->buf) {
 		ret = -ENOMEM;
diff --git a/drivers/usb/gadget/firehose_parse.c b/drivers/usb/gadget/firehose_parse.c
index 07de9065b71..f32e9868e48 100644
--- a/drivers/usb/gadget/firehose_parse.c
+++ b/drivers/usb/gadget/firehose_parse.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Qualcomm Firehose command parser and rawprogram/patch expressions
+ * Qualcomm Firehose command parser, rawprogram/patch expressions and
+ * storage lookup
  *
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <blk.h>
+#include <dm.h>
 #include <firehose.h>
+#include <mmc.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -212,3 +215,68 @@ int firehose_eval(struct blk_desc *desc, void *buf, size_t size,
 
 	return fh_crc32(desc, buf, size, start, len, val);
 }
+
+static const struct {
+	const char *name;
+	enum uclass_id id;
+} fh_storage[] = {
+	{ "eMMC", UCLASS_MMC },
+	{ "UFS", UCLASS_SCSI },
+	{ "NVMe", UCLASS_NVME },
+};
+
+const char *firehose_storage_name(struct blk_desc *desc)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fh_storage); i++)
+		if (fh_storage[i].id == desc->uclass_id)
+			return fh_storage[i].name;
+
+	return NULL;
+}
+
+static bool fh_storage_match(struct blk_desc *desc, enum uclass_id id)
+{
+	struct mmc *mmc;
+
+	if (desc->uclass_id != id)
+		return false;
+
+	switch (id) {
+	case UCLASS_MMC:
+		/* Skip SD cards */
+		if (!IS_ENABLED(CONFIG_MMC))
+			return false;
+		mmc = find_mmc_device(desc->devnum);
+		return mmc && !IS_SD(mmc);
+	case UCLASS_SCSI:
+		/* Physical partition 0 of UFS is LUN 0 */
+		return !desc->lun;
+	default:
+		return true;
+	}
+}
+
+int firehose_find_storage(const char *name, struct blk_desc **descp)
+{
+	struct udevice *dev;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fh_storage); i++)
+		if (!strcasecmp(name, fh_storage[i].name))
+			break;
+	if (i == ARRAY_SIZE(fh_storage))
+		return -EINVAL;
+
+	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
+		struct blk_desc *desc = dev_get_uclass_plat(dev);
+
+		if (fh_storage_match(desc, fh_storage[i].id)) {
+			*descp = desc;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
diff --git a/include/firehose.h b/include/firehose.h
index 9ab5c5d37d4..37ef92646b1 100644
--- a/include/firehose.h
+++ b/include/firehose.h
@@ -41,7 +41,8 @@ struct firehose_cmd {
  * until the user presses Ctrl-C.
  *
  * @udc:	USB device controller to register the function on
- * @desc:	block device to program
+ * @desc:	block device to program, or NULL to pick it from the MemoryName
+ *		of the host's configure command
  * Return: 0 on Ctrl-C, negative error code on failure
  */
 int firehose_run(struct udevice *udc, struct blk_desc *desc);
@@ -92,4 +93,25 @@ int firehose_attr_u64(struct firehose_cmd *cmd, const char *name, u64 *val);
 int firehose_eval(struct blk_desc *desc, void *buf, size_t size,
 		  const char *s, u64 *val);
 
+/**
+ * firehose_storage_name() - get the Firehose MemoryName of a block device
+ *
+ * @desc:	block device
+ * Return: "eMMC", "UFS", "NVMe" or NULL for other devices
+ */
+const char *firehose_storage_name(struct blk_desc *desc);
+
+/**
+ * firehose_find_storage() - find the block device for a MemoryName
+ *
+ * Picks the first eMMC device (SD cards are skipped), the first SCSI device
+ * with LUN 0 for UFS or the first NVMe device.
+ *
+ * @name:	MemoryName, compared ignoring case
+ * @descp:	returns the block device
+ * Return: 0, -EINVAL for an unsupported name or -ENODEV if there is no
+ *	   such device
+ */
+int firehose_find_storage(const char *name, struct blk_desc **descp);
+
 #endif /* __FIREHOSE_H */

-- 
2.53.0

