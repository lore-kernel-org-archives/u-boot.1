Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CBA606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qh6FpQyK;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZJw7HWx2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WP9QYHi4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9BAE40958;
	Fri,  6 Nov 2026 09:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RygPrI3Wa2nT; Fri,  6 Nov 2026 09:43:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C3584091F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958184;
	b=CVFWNDLhy+5O4dfLW+q6TFppAV6KUoTuStJFzTv/dBOPmACKWhiJ9rB4v0qBtHuM/WMC
	 uOgd8HulR6Rm5ARPQHJFv7oz5/UkmyhAOID3b+xQIVJOmPBu0y9GLNvbAyFZlDrsEfoM4
	 YS1wW4CrwguwhNpuWSuwjgcj9Mc9XCu+g2AHXu0rYkvzPD2BOT+ELEEL9XnYjx7AM8Dsl
	 wzeJtgOaZ8015gnn4wniooJIpKaJEo/TqrBCuYhY0Kpiy04/bCn+7j+TiEbsuN5GvHRIc
	 ek72dsrWOKhSFWyxsqnQ12ZhmNcYSFNS32u0tHDlQk7ew8NpSz8VqrMKqD3Dr6Q7Iuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958184;
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
	bh=a3BdxxtzgdF0hOvBdHi3cQYZ+sXulis60plRI/dZovY=;
	b=ayVfGDpFoNhTC7JAmXnZeTm8ueXM8wyN7eELEwokcykOLI9+KEjSxqc1zkytrfZ8wKW8
	 RqFMq2yFq9tEeNUMUNK7PTlEvsmWZjyIlJrLH8BC6g3vwiTXOBtqwl79945iaRLYSqNpu
	 dfG0LmKod+jy5INsk2jgIbh9FFDy4B1ozfsPUkt1OhpShWbahC5brD/+C4CFvG2fQkZiL
	 k4pqDyH9tOdsypRygES1iefo85USv1ecYcqWGbbZIi9AliDps1IhmowG/MxQykR9/44KI
	 jPYc7PqsAzoWfsVmcZaDCQmtKIIbdAO3HYQ5zMeSNi3qps23xOZ/Yboj72rCQu/TVBg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958184;
	bh=a3BdxxtzgdF0hOvBdHi3cQYZ+sXulis60plRI/dZovY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qh6FpQyKNz5MF2HbT2DcpsYpay5mXdTDjc44r3BbpI2bYRU93adcFvv3YckS5sPZa
	 yqip979eF7O/9Uw/HitnvkfclPWTttr1k1YabA44zfZ4TTlG7CJQqUfvb+yKt/c1Q6
	 0E5GD+m1a9diuX+My5y53OOPJhloirLWXM4RZfXNiMKdMzGxA0opExyy9NTSyP+1gN
	 ah5NMiH6vaKCC7wxteGMRHY8CUxCAatVv08MDdDWUIXOFJZ6hLUeGOzrIqDSjpuowO
	 2sAO5iCEcdrvJPX/Qr2KenU/PI9LBmfMMfaGjyL3uqaRdgUi66cJo3OVkZflzNT0L9
	 W3nQ4HzFxXgPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C3584091F;
	Fri,  6 Nov 2026 09:43:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 20A881E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12480403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GB3eI8pVdebD for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AE7B2400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZJw7HWx2; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WP9QYHi4
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE7B2400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RTg42730740
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a3BdxxtzgdF0hOvBdHi3cQYZ+sXulis60plRI/dZovY=; b=ZJw7HWx278m2YQ6d
 tP5ifDAjkA3xfUvEE6n4qxXJRqbj6hkXyJZY+KPNzsMXCqXKLtCCIY8NQr6bDAD3
 nKOgX3q3SEtkis6SnGLCRE4jVuNm6rJE7XMW6aaHlIc2YNHuIV7sUhNJ0vUpidyI
 bkdN7q+uh+d3+SfJAvBfd23c4CGbZmLK33Uh6Xo2wY7H13+poCDKrmtkFhkaDsCZ
 POizIDjKxA+ROKcbcMV9ogR7TJVr/UgoU+cf+ytRYsNkLyaHnrQsgCiFY1c6ts41
 OHM+zZVRLIwK278rvNaklsPHD8EZ/JqFdCT6cXM0LLwEwyNuD50IPoyN/gfIxlvS
 NvmfHA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9j4xq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844cb60so103420185a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958179; x=1794562979;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a3BdxxtzgdF0hOvBdHi3cQYZ+sXulis60plRI/dZovY=;
 b=WP9QYHi4LvuEQ1JwbKZJMpcpXn4i4bEegRv5pRndEuHTvtOr5DkyFz1xOjy5w9CWy/
 5Zxf00u8bz1i4R3MwfWAWYnlLffjA8JJCXJWUtns2RTTHnU1Wq9xo+qt9KbZvEA2dlhT
 3k/5He7+PJRqcOn+PH1tF2x1tJaepIkiUoHopnXF1ARxMl7jbLsrlmgXfGFXzPxoAqUD
 k4DVXPgDBaS+9blqTM6bcMa7pYeTRt/9FReKqFOf0OwRy7DScMPFUD0VZ/rmlgMZ30Ai
 9mepW5UmDsUKGV99IyYoFEyQQ6vk8KpgTdLT4tlm6rVtz/JE73Y9FuZ23op1vCrQuWRp
 rpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958179; x=1794562979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a3BdxxtzgdF0hOvBdHi3cQYZ+sXulis60plRI/dZovY=;
 b=P1u3n2StBOdikJwZJRALmHpzX70GBrC8ncFHktqT7YZNmR0FL89KlCgDGi0Fd49MI4
 4JzlZwiPSoPw/ApCPhUgzZk9ZuR13Vt/XhI+GJe+6gRGMSCHzIlaPeOtOBTBdxC+aJIt
 ObeRCGAxDvsEd2/G/wk0KAzxv0diU/BTv57j2eporvkx4sBMsCCvY7JFDqVwOPWNi8YT
 TNSgmtU3p+abxtO6Ue+GX6XWRwa59GXDpSpUDZ1onfBgKV+BLVOMQew0+CBBDurtNNdF
 3SqOHqjB6loQ0zpDiwqaW9xuyVAPBULSo53uZ47Fw6joZJOsmsy/REtt04ZrBn8rkg5Q
 339A==
X-Gm-Message-State: APuU4Z+q2YvBDgt6YWJmKOJPiyDHacnGGCHrik1M0x8lUaw+vjQhiODE
 MrR1gq4jLxN2igR5NCaK25weiM4GfZj4XGJY0lfXftEAoetOSq8KpgLFg1s/LXGUGjgsh7oEWvP
 u4oXvmh4MIg49nTt6BRhdwrQFM19hBqUYqNA8EoP0jYUrgkD2Nsgd54xEiq6TJOCwx1tQ2ZA=
X-Gm-Gg: AYBFou0G6OQXUn0pr4hrfEVbUJuA7StZS9IDXzuMBaxniiHGehIxYqeiVVFUkX8+cdt
 AqBg+vAK3YOmSehEQIhqPXV9qz3EpbiY8unDdTfKVLUtkcRcInGhPcan+ePyDL6veJnwGJ76Dlv
 gx+M3zkQRb/tDQsdnbH2mBXm5qFPkdMMErfcf2n8dlVTdHFPRtJPscEzfZQQ9KGmGbcLTRGJEle
 3UdUo1Jon2+I03X/AczS+XdKrmUEL4pQlpl5GeVzP4r7aLe1d2dAC2CH3R2fQQEabm9H7olMoFc
 WR1lBzu6WbVxXRaQUIEKWyJXY3/dEKhEhTLSRpTGQ6+UbTfSjOKyGrGfGj+pcmpS5BIedou240b
 2MqKfqcS4rFne8IjEkWeRKbG0h9dPzd1k2Y/s9l6954CR1i71qmMGZjGO18RIvvRcUORZkKxLl8
 JW6acEtKpb2E83
X-Received: by 2002:a05:620a:4044:b0:945:af5d:287b with SMTP id
 af79cd13be357-945e178b731mr842669385a.30.1793958179179; 
 Fri, 06 Nov 2026 01:42:59 -0800 (PST)
X-Received: by 2002:a05:620a:4044:b0:945:af5d:287b with SMTP id
 af79cd13be357-945e178b731mr842666785a.30.1793958178737; 
 Fri, 06 Nov 2026 01:42:58 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:42:57 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:34 +0100
Subject: [PATCH 02/14] usb: gadget: firehose: add the read command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-2-e7591c12fc65@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: gvxLDi7YzQP92XTQF9AlHay2JvbLnLE9
X-Proofpoint-GUID: gvxLDi7YzQP92XTQF9AlHay2JvbLnLE9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX51O4mKwFzjlC
 3J0DLmdvEvprTJFJ2lUkg9M4MsNrAWYuoQ5TiVNq+cksKTUGFSDxxc2DInsnzjOfxzIpWOY1PeJ
 hrK9aRs0Pp5tZkJ4qdQmbX771BC/I5A=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aeda124 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ietKCmjYrys0r6OM5mcA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfXwKoStWSWMYdi
 Anq4jphoDNqyZTKJ9JG72krYkUjDYmNR2kxMlm/4Tc7nmz8timVhrY3euAzx2IDc4DyJy2/ZBRa
 e/3GqGmH9cldaNYfBdEjtc3w4eprws92wy2PTCMqbzddQsKpA39HpQKbP/Akb0u6zIvWWdRZETe
 EgfjmfpiZu6Aec9No1ftR9yt5zBaCbRi49qSc/GQpTT78cYA9qA95AJwU87lEbdrWo6SN/7qK+R
 tu6e5tYlBiFxCJpoOERD8+tPm8lNCwhiwaGI57dLFYKi4SvU0fiElvVcD/ggPGdeFWVsznMPoAt
 YhZ198ZbsEcq25veB3pSBy4Zw7ZYYkrswG0vWRAIRX9WegwwSMwxajjH/63rHHczzp98w+f5E+1
 uRaVJMUvL2b3CqNYwmgX9wcOZ59thaEZdubtelgvjzeKSPsWvqXDU9Flt6aV182Vvy3obiF8TDC
 8Dv608lkg4My+bxF0mg==
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

Stream sectors of physical partition 0 to the host in 1 MiB transfers.
start_sector accepts the NUM_DISK_SECTORS[-N] form of the XML files.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/usb/gadget/f_firehose.c     | 106 ++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/firehose_parse.c |  67 ++++++++++++++++++++++-
 include/firehose.h                  |  23 ++++++++
 3 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_firehose.c b/drivers/usb/gadget/f_firehose.c
index 460216a2bf8..4be8d3ef1ba 100644
--- a/drivers/usb/gadget/f_firehose.c
+++ b/drivers/usb/gadget/f_firehose.c
@@ -439,6 +439,66 @@ static int __printf(3, 4) fh_log(struct f_firehose *fh, bool err,
 			   msg);
 }
 
+static int fh_eval(struct f_firehose *fh, const char *s, u64 *val)
+{
+	return firehose_eval(fh->desc, s, val);
+}
+
+static int fh_check_partition(struct f_firehose *fh, struct firehose_cmd *cmd)
+{
+	const char *ppn = firehose_attr(cmd, "physical_partition_number");
+
+	/* qdl probes the other partitions when it looks up names */
+	if (ppn && strcmp(ppn, "0")) {
+		fh_log(fh, false, "ERROR: only physical partition 0 is supported");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fh_check_sector_size(struct f_firehose *fh, struct firehose_cmd *cmd)
+{
+	u64 sector_size;
+
+	if (firehose_attr_u64(cmd, "SECTOR_SIZE_IN_BYTES", &sector_size) ||
+	    sector_size != fh->desc->blksz) {
+		fh_log(fh, true, "sector size must be %lu", fh->desc->blksz);
+		return -EINVAL;
+	}
+
+	return fh_check_partition(fh, cmd);
+}
+
+static int fh_get_range(struct f_firehose *fh, struct firehose_cmd *cmd,
+			lbaint_t *start, lbaint_t *count)
+{
+	struct blk_desc *desc = fh->desc;
+	u64 first, num;
+	int ret;
+
+	ret = fh_check_sector_size(fh, cmd);
+	if (ret)
+		return ret;
+
+	if (fh_eval(fh, firehose_attr(cmd, "start_sector"), &first) ||
+	    firehose_attr_u64(cmd, "num_partition_sectors", &num)) {
+		fh_log(fh, true, "invalid start_sector or num_partition_sectors");
+		return -EINVAL;
+	}
+
+	if (first > desc->lba || num > desc->lba - first) {
+		fh_log(fh, true, "sectors %llu+%llu beyond the end (%llu)",
+		       first, num, (u64)desc->lba);
+		return -ERANGE;
+	}
+
+	*start = first;
+	*count = num;
+
+	return 0;
+}
+
 static int fh_configure(struct f_firehose *fh, struct firehose_cmd *cmd)
 {
 	const char *memory = firehose_attr(cmd, "MemoryName");
@@ -480,6 +540,51 @@ static int fh_configure(struct f_firehose *fh, struct firehose_cmd *cmd)
 	return ret ?: FH_RESPONDED;
 }
 
+/*
+ * After a read error zeros are sent for the rest, then a NAK. The host
+ * expects a ZLP after each transfer that is a multiple of maxpacket; not
+ * all UDC drivers honour usb_request.zero, so it is a request of its own.
+ */
+static int fh_read(struct f_firehose *fh, struct firehose_cmd *cmd)
+{
+	struct blk_desc *desc = fh->desc;
+	lbaint_t chunk = FH_PAYLOAD / desc->blksz;
+	lbaint_t start, left, n;
+	size_t len;
+	int err = 0;
+	int ret;
+
+	ret = fh_get_range(fh, cmd, &start, &left);
+	if (ret)
+		return ret;
+
+	ret = fh_respond(fh, true, true);
+	if (ret)
+		return ret;
+
+	for (; left; start += n, left -= n) {
+		n = min(chunk, left);
+		len = n * desc->blksz;
+		if (!err && blk_dread(desc, start, n, fh->buf) != n)
+			err = -EIO;
+		if (err)
+			memset(fh->buf, 0, len);
+
+		ret = fh_tx_queue(fh, fh->buf, len);
+		if (!ret && !(len % fh->maxpacket))
+			ret = fh_tx_queue(fh, fh->buf, 0);
+		if (!ret)
+			ret = fh_tx_flush(fh);
+		if (ret)
+			return ret;
+	}
+
+	if (err)
+		fh_log(fh, true, "read failed");
+
+	return err;
+}
+
 static int fh_power(struct f_firehose *fh, struct firehose_cmd *cmd)
 {
 	const char *value = firehose_attr(cmd, "value");
@@ -504,6 +609,7 @@ static const struct {
 	int (*handle)(struct f_firehose *fh, struct firehose_cmd *cmd);
 } fh_handlers[] = {
 	{ "configure", fh_configure },
+	{ "read", fh_read },
 	{ "power", fh_power },
 	{ "nop", fh_nop },
 };
diff --git a/drivers/usb/gadget/firehose_parse.c b/drivers/usb/gadget/firehose_parse.c
index 89e47659fb2..ff99566eb40 100644
--- a/drivers/usb/gadget/firehose_parse.c
+++ b/drivers/usb/gadget/firehose_parse.c
@@ -1,13 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Qualcomm Firehose command parser
+ * Qualcomm Firehose command parser and rawprogram expressions
  *
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <blk.h>
 #include <firehose.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/string.h>
 
 static char *fh_skip_ws(char *p)
@@ -108,3 +110,66 @@ const char *firehose_attr(struct firehose_cmd *cmd, const char *name)
 	return NULL;
 }
 
+/* Decimal only: simple_strtoull() also takes a 0x prefix in base 10 */
+static int fh_parse_u64(const char *s, const char **end, u64 *val)
+{
+	const char *start = s;
+	u64 v = 0;
+
+	for (; isdigit(*s); s++) {
+		if (v > (U64_MAX - (*s - '0')) / 10)
+			return -EINVAL;
+		v = v * 10 + *s - '0';
+	}
+	if (s == start)
+		return -EINVAL;
+
+	*val = v;
+	*end = s;
+
+	return 0;
+}
+
+int firehose_attr_u64(struct firehose_cmd *cmd, const char *name, u64 *val)
+{
+	const char *s = firehose_attr(cmd, name);
+	const char *end;
+
+	if (!s || fh_parse_u64(s, &end, val) || *end)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* "N", "NUM_DISK_SECTORS" or "NUM_DISK_SECTORS-N", with an optional '.' */
+static int fh_sector(struct blk_desc *desc, const char *s, const char **end,
+		     u64 *val)
+{
+	u64 n;
+
+	if (!strncmp(s, "NUM_DISK_SECTORS", 16)) {
+		*val = desc->lba;
+		s += 16;
+		if (*s == '-') {
+			if (fh_parse_u64(s + 1, &s, &n) || n > *val)
+				return -EINVAL;
+			*val -= n;
+		}
+	} else if (fh_parse_u64(s, &s, val)) {
+		return -EINVAL;
+	}
+
+	if (*s == '.')
+		s++;
+	*end = s;
+
+	return 0;
+}
+
+int firehose_eval(struct blk_desc *desc, const char *s, u64 *val)
+{
+	if (!s || fh_sector(desc, s, &s, val) || *s)
+		return -EINVAL;
+
+	return 0;
+}
diff --git a/include/firehose.h b/include/firehose.h
index 2a31d862cd0..c8f27af4f5c 100644
--- a/include/firehose.h
+++ b/include/firehose.h
@@ -64,4 +64,27 @@ int firehose_parse(char *xml, struct firehose_cmd *cmd);
  */
 const char *firehose_attr(struct firehose_cmd *cmd, const char *name);
 
+/**
+ * firehose_attr_u64() - get an unsigned decimal attribute
+ *
+ * @cmd:	parsed command
+ * @name:	attribute name
+ * @val:	returns the value
+ * Return: 0 or -EINVAL if missing or not a number
+ */
+int firehose_attr_u64(struct firehose_cmd *cmd, const char *name, u64 *val);
+
+/**
+ * firehose_eval() - evaluate a sector number
+ *
+ * Accepts "N", "NUM_DISK_SECTORS" and "NUM_DISK_SECTORS-N", each with an
+ * optional trailing '.'.
+ *
+ * @desc:	block device the expression refers to
+ * @s:		expression
+ * @val:	returns the value
+ * Return: 0 or -EINVAL if @s is invalid
+ */
+int firehose_eval(struct blk_desc *desc, const char *s, u64 *val);
+
 #endif /* __FIREHOSE_H */

-- 
2.53.0

