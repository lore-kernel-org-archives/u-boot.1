Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D40606D806
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Urf86+BO;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kRvV6fxN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SXMSbriJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 902F0811F9;
	Fri,  6 Nov 2026 09:43:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HbFyas1HfOUN; Fri,  6 Nov 2026 09:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A7D41811FB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958209;
	b=XhMeiF/hPaZJ9LOFsRdYhKQ6tR81obxZLNfxi1ytKGKMHNwxN8e5ztxn1UeyDXcNera8
	 hRCP6aUc/QMNOYejRBDc+V25i4qcDn6J+8wuoFABeY60Xnldekgd4s5VarI9NN0YggPQ9
	 R4O7COoqny7xP4tjp28A8/RDGU/hP+jknbv4nqsrXmWeSmTB5W9dCdeqpv0pUlEP8OydZ
	 VOArakiH60wsNlwvOL1UJiX5Rg9rMCDqlkWxDuyyQJjb8zrLS/2zPaXJXBMdq1j/Ru9m8
	 A6zZkuTopJWYVnqODkcp5znR0/8/VYofekqKd4W0elA3AUB97xKLoNmNBKamRiIiKxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958209;
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
	bh=uzM30v+n0rhLFG1LYwvD0xnjzcZWpoLWLOEuZzpfXx4=;
	b=Z875fr287MqNNZgujmr7ABgWK3PtTQj3a4NdYVtmSmmIJYnejiFUtxg7FGr+jB1cFPCw
	 Yp4ZY01YbgdWn/YnZ3thMTPJV+rBep6qbSR2GvPpmavr6SEcVkvZd7gL946DpX8pbzv1s
	 +lIq35KdUyFS8QHS7NMrxY2VEJnLh9EX6qfCRzjrXj1tJhRhmk6Gk44bLdjJnezQ15mED
	 DKj1pwMmKEChzQIvn9b1GwuqgvvwHnZ3WcYxFJyELKmEbFlHc4erIjKXkVR5Gba7d86rL
	 zfp2bkecOigE93Ib0ELQhvPsP8Yy3u5AOZbONgQg+/eMhV+JizR3xMsD0ymt0PoTd/g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958209;
	bh=uzM30v+n0rhLFG1LYwvD0xnjzcZWpoLWLOEuZzpfXx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Urf86+BO4SvC1Ce25UhtyYCzLHXSwhdk0Q1ZOxIVteKVgb4rD4D7R28/gNKlFkaH7
	 PAjqhV775jxYwrmrF76CpwOmwuS3LYg7dZHNiqFGj2Q6kquCVo/Mz/uWYVtVNHUF+L
	 LekSLA9PgnPBxnnYE55wiQN1RZFDX38nSrq/5Ti6cqOKdL1csd00FoltWqgKfY5HiZ
	 QKSjJsH12N3OsDjOvLgRh2SBn91Cv5uoyr5ua34faAGSniEwJ84ncB9+XrcFJP52Ao
	 g/+vn1DXprbnywjF142+NPTeH94/kVMT+rWcDZXyw4lUgZ61Fi7Z5IZFD9QNLz+s/5
	 PmRKEcE8ErGQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7D41811FB;
	Fri,  6 Nov 2026 09:43:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B22831F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CFB06069B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mulfV7s7tdea for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9AA1B60640
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kRvV6fxN; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SXMSbriJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AA1B60640
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:26 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67R7uO3243883
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uzM30v+n0rhLFG1LYwvD0xnjzcZWpoLWLOEuZzpfXx4=; b=kRvV6fxNaTiqGKYr
 mhBqJIi2yV6IUAVfk6Y+tOULrRa+HawLkaTfDNGX1YiueoGsiZeQjJ6xXupg4HtN
 g45ls2/53DNNhFnXjUjcrUUwGCCCoiGp7bDQSvTUN4s9kFHrMVJW1XtvDUr7uYxC
 qaBPhXn9pu78PV/ENkXM7j+VtwakE87bqcNJv3GJ97oWGCKUniKfnWUXsy2w3zvP
 3GW9N7eCRJFsin8C4IA25FdkNC66IfqcHi2QRmdxF8Qa78gaQJ6CHbyL32l2DNSM
 kqCYuTPyVWKBxn0+6NktCtCLbwBwloWzilPwNI6uUwfrMQ5q+0igxbfq3xYXZwAq
 n1Fzpg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa24yv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f33438950so102480985a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958205; x=1794563005;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uzM30v+n0rhLFG1LYwvD0xnjzcZWpoLWLOEuZzpfXx4=;
 b=SXMSbriJywIuSVwvswlCJeDxKMYn2wTh7rM8F24zdqbvQOG0zWIXQldBqBPJO1pDg4
 bw5JU/4vV4nRPJppiPYwMkpMpX0rmVdDUzioq+Qb7WB5oxmSuhzMia8ZZ/WGkziKb3bh
 Nx5oJR2Fecn+tfjUWkdOnjeZQU+gze9EDgbB6hENs8CFDQ54SifvitrHuSgx+q/YJX0l
 npYrJaCcn+X4Aj2g6cRY6CLnRsT+/UqsfD90p1/ChC8Pn/Aje4tAKtxA4yT5C02bJuJ2
 Fe7gVA2JLCPDG36FNEd70DMmjvtqf/6vZspp+7umxMALgSlGn4k0qWbInuB2RqMCQ3XY
 EQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958205; x=1794563005;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uzM30v+n0rhLFG1LYwvD0xnjzcZWpoLWLOEuZzpfXx4=;
 b=nS+Usr8eEmLaFL2JsrBiEMD8d3aTZz9Zyk+tau9Rhg1NY/MPNxLYB3VUYmT1YvEUAN
 pxRDMFOZQKLa7BCd9eKOqdNgWQdYy2R5UIS78LkZ8je/mytiy3hmwCrpZgwe5XTi7w/3
 Uxy+zCdJW/ehbk3dg0WI09pKSdLI+9tEVqyBAFWThlmUxLtNehA7HBOpu//DBUYxnmRP
 TzEC5h7M6polF9YwkFlei7MeZ7v9jldEUR3S7XJ2UoT+nIuz/SETLrs0aL1o1zWY3tj7
 ir68HO6xACCJlZvq0wJkrG3V7p2Bu3Vprg8kROKRXIkgemJ1xqndoEPnbGxzEsVOfuTH
 qmig==
X-Gm-Message-State: APuU4Z8762yeFfNGjjVHsUsqrUEQwOPiCmrEX0RU7iWAOvekpz8wfSoJ
 UsgS7FhTpBHq+Wesy+7DT6LHdBJH8ZXGPFmqGgB2wh1uafumWfi/v4O+EfTTfbCQK62Pyz2Vy8V
 gjBrf0U51T6rP3JJDeGjzm9XcNdav6Pbba/TcrXN/ZO+HG7ko/+QUC0Lo3wBTPiXk9RV1wo4=
X-Gm-Gg: AYBFou0ZFaDsLQaG/bMLR+fc0OyIY8PGszuMxy5JaTrjw98hSvY8ZCUpd4QVt4teNl/
 aH3afAq6nkbea1mS24G9bgMJHBhSqg9s+PAjOM6GbfwTPz+LQ0AronRftAQ0ez7RX9JIR7LseWq
 A3/sbnkonn46110tVDRGbfOazzOBsH/pZyd7RE95RNfjywPw+FbeN8EU5zJ8WJhXBXxMKv8cjme
 2NVN81fZMlMgRYSOIEJBYVAePYfzY95F3hT7hrlwVwvvVzdAZqFG0jahgTOR+z6bfFK3U2BQV0n
 EFwHJa4wPUATeFDYcDQ1apYPdBCuWQrmVRjtuV5ZWpRGWqZJB3YnlJhp0/Je+mDr4369vfJbDF6
 JzcfuEs1kmBgYP+zx679Oqq5SxjMrk0HtUH06KheaIugeFaw3N0O03ZSYuGwsAgZQUH2CubiAPD
 k7BE1sqnJ0KBe7
X-Received: by 2002:a05:620a:2811:b0:93e:a51e:7ffb with SMTP id
 af79cd13be357-945f3355eb4mr209716985a.2.1793958204508; 
 Fri, 06 Nov 2026 01:43:24 -0800 (PST)
X-Received: by 2002:a05:620a:2811:b0:93e:a51e:7ffb with SMTP id
 af79cd13be357-945f3355eb4mr209713085a.2.1793958203910; 
 Fri, 06 Nov 2026 01:43:23 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:23 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:44 +0100
Subject: [PATCH 12/14] test: dm: add Firehose tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-12-e7591c12fc65@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aeda13d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=W1BiHNyAc7_2oUjjS0wA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX26TG50HPe3PA
 zCVy9gN8fdwT98+Zv58Jr0P8AHKDNRF+VA0GSO96uuyCpU/7eIqM8ITt49dwrWCeypquvWjGAIb
 syy0jMamDyM40vfoZ4vxTWsX7ExV2O4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX2hXDepYxZqF3
 q7V/fsFhrTpsK+vyIQCqGbHPkLp7SLisJotcorcrWf7BXaPy+nwluz5b9WyA9lqKc0Kh0U30Tvw
 M8xed3JBxKVnSisl2fBrW5WxYBfqBHJtiRf8v0PbyKz5kIHCOKm8zOu6xwuEZ1WhwUHbcsusx8Q
 tJa4N1fkym/176cfc4YviHn3QJZzgA7VXXXf+rjTxrU8K9GTD29+VzSALC7PgOtMAJOQnhhTfdX
 0jqqxxeYrs5BO0FE8FERDkhyB33vDzvsytloKTS2L1UnALJHYyOyMtZgbfPQ3AUDxoW5U1M32RT
 Nruz8kYF3b2SzOWtum7sUWNUZVb+lUdLOA1CT36mHYLgLfB8eIcnVcT5Hup1u2UU/S7AtEnYY+b
 2ZjmvA4TjP4qhB1LFxj7o+tpz9JHUcrnRZ1R5lRnFmIRbfZFvWSlqqE9Akr6yM7fMl+5sDvT4DR
 9f+8w2ShDbr9srzBj5Q==
X-Proofpoint-GUID: yDjU6Mn-I0bJORfawI5HmY_3P5WBDA5M
X-Proofpoint-ORIG-GUID: yDjU6Mn-I0bJORfawI5HmY_3P5WBDA5M
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

Check commands as qdl sends them and the rejection of malformed ones,
including qdl's Sahara probe; sector values and CRC32() against the
sandbox MMC; and the MemoryName lookup: SD cards do not count as eMMC,
UFS finds the sandbox SCSI disk.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 test/dm/Makefile   |   1 +
 test/dm/firehose.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 1b3a20aa932..e9c7daa1636 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_CMD_MUX) += mux-cmd.o
 obj-$(CONFIG_MULTIPLEXER) += mux-emul.o
 obj-$(CONFIG_MUX_MMIO) += mux-mmio.o
 obj-y += fdtdec.o
+obj-$(CONFIG_USB_FUNCTION_FIREHOSE) += firehose.o
 obj-$(CONFIG_MTD_RAW_NAND) += nand.o
 obj-$(CONFIG_IP_DEFRAG) += net_defrag.o
 obj-$(CONFIG_CMD_NFS) += nfs.o
diff --git a/test/dm/firehose.c b/test/dm/firehose.c
new file mode 100644
index 00000000000..bcd89d3764a
--- /dev/null
+++ b/test/dm/firehose.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the Qualcomm Firehose command parser and expressions
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <blk.h>
+#include <firehose.h>
+#include <malloc.h>
+#include <part.h>
+#include <scsi.h>
+#include <vsprintf.h>
+#include <dm/test.h>
+#include <linux/string.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <u-boot/crc.h>
+
+static int parse(const char *xml, struct firehose_cmd *cmd, char *buf,
+		 size_t size)
+{
+	strlcpy(buf, xml, size);
+
+	return firehose_parse(buf, cmd);
+}
+
+static int dm_test_firehose_parse(struct unit_test_state *uts)
+{
+	struct firehose_cmd cmd;
+	char buf[512];
+	u64 val;
+
+	ut_assertok(parse("<?xml version=\"1.0\" ?>\n<data>\n"
+			  "<program SECTOR_SIZE_IN_BYTES=\"512\" "
+			  "start_sector='NUM_DISK_SECTORS-33.' "
+			  "filename=\"gpt_backup0.bin\" />\n</data>",
+			  &cmd, buf, sizeof(buf)));
+	ut_asserteq_str("program", cmd.tag);
+	ut_asserteq(3, cmd.num_attrs);
+	ut_asserteq_str("512", firehose_attr(&cmd, "sector_size_in_bytes"));
+	ut_asserteq_str("NUM_DISK_SECTORS-33.",
+			firehose_attr(&cmd, "start_sector"));
+	ut_asserteq_str("gpt_backup0.bin", firehose_attr(&cmd, "filename"));
+	ut_assertnull(firehose_attr(&cmd, "label"));
+	ut_assertok(firehose_attr_u64(&cmd, "SECTOR_SIZE_IN_BYTES", &val));
+	ut_asserteq(512, val);
+	ut_asserteq(-EINVAL, firehose_attr_u64(&cmd, "filename", &val));
+	ut_asserteq(-EINVAL, firehose_attr_u64(&cmd, "label", &val));
+
+	/* As qdl sends it, without the declaration and with no attribute */
+	ut_assertok(parse("<data><nop/></data>", &cmd, buf, sizeof(buf)));
+	ut_asserteq_str("nop", cmd.tag);
+	ut_asserteq(0, cmd.num_attrs);
+
+	ut_assertok(parse("<?xml version=\"1.0\"?>\n<data><power value=\"reset\" "
+			  "DelayInSeconds=\"10\"/></data>\n",
+			  &cmd, buf, sizeof(buf)));
+	ut_asserteq_str("power", cmd.tag);
+	ut_asserteq_str("reset", firehose_attr(&cmd, "value"));
+
+	return 0;
+}
+DM_TEST(dm_test_firehose_parse, 0);
+
+static int dm_test_firehose_parse_invalid(struct unit_test_state *uts)
+{
+	static const char * const invalid[] = {
+		"",
+		"\x02",		/* Sahara HELLO response, as qdl probes */
+		"<program A=\"1\"/>",
+		"<data><program A=\"1\"></data>",
+		"<data><program A=\"1\"/>",
+		"<data><program A=\"1/></data>",
+		"<data><program A=1/></data>",
+		"<data><program A/></data>",
+		"<data><program A=\"1\"B=\"2\"/></data>",
+		"<data><program A=\"&amp;\"/></data>",
+		"<data><program A=\"<\"/></data>",
+		"<data><1program/></data>",
+		"<data></data>",
+		"<?xml version=\"1.0\" <data><nop/></data>",
+		"<data><nop/></dat>",
+	};
+	struct firehose_cmd cmd;
+	char buf[512];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(invalid); i++)
+		ut_asserteq(-EINVAL, parse(invalid[i], &cmd, buf, sizeof(buf)));
+
+	/* One attribute more than fits */
+	strcpy(buf, "<data><program");
+	for (i = 0; i <= FIREHOSE_MAX_ATTRS; i++)
+		sprintf(buf + strlen(buf), " a%d=\"%d\"", i, i);
+	strcat(buf, "/></data>");
+	ut_asserteq(-EINVAL, firehose_parse(buf, &cmd));
+
+	return 0;
+}
+DM_TEST(dm_test_firehose_parse_invalid, 0);
+
+static int dm_test_firehose_eval(struct unit_test_state *uts)
+{
+	static const char * const invalid[] = {
+		"", "x", "-1", "+1", " 1", "1 ", "1.2", "0x10",
+		"18446744073709551616", "NUM_DISK_SECTORS+1",
+		"NUM_DISK_SECTORS-", "NUM_DISK_SECTORS-1-1",
+		"CRC32(2,700", "CRC32(2)", "CRC32(,700)", "CRC32(2,0x10)",
+		"CRC32(2,700) ", "(1)",
+	};
+	struct blk_desc *desc;
+	char expr[64];
+	u8 *data;
+	void *buf;
+	u64 n, val;
+	int i;
+
+	ut_assertok(blk_get_device_by_str("mmc", "0", &desc));
+	n = desc->lba;
+	buf = malloc(4 * desc->blksz);
+	ut_assertnonnull(buf);
+
+	ut_assertok(firehose_eval(desc, buf, 4 * desc->blksz, "0", &val));
+	ut_asserteq(0, val);
+	ut_assertok(firehose_eval(desc, buf, 4 * desc->blksz, "34", &val));
+	ut_asserteq(34, val);
+	ut_assertok(firehose_eval(desc, buf, 4 * desc->blksz, "34.", &val));
+	ut_asserteq(34, val);
+	ut_assertok(firehose_eval(desc, buf, 4 * desc->blksz,
+				  "18446744073709551615", &val));
+	ut_asserteq_64(U64_MAX, val);
+	ut_assertok(firehose_eval(desc, buf, 4 * desc->blksz,
+				  "NUM_DISK_SECTORS", &val));
+	ut_asserteq(n, val);
+	ut_assertok(firehose_eval(desc, buf, 4 * desc->blksz,
+				  "NUM_DISK_SECTORS-1.", &val));
+	ut_asserteq(n - 1, val);
+	ut_assertok(firehose_eval(desc, buf, 4 * desc->blksz,
+				  "NUM_DISK_SECTORS-33", &val));
+	ut_asserteq(n - 33, val);
+
+	/* Fill sectors 2-3 and the last one, then check CRC32() against them */
+	data = malloc(3 * desc->blksz);
+	ut_assertnonnull(data);
+	for (i = 0; i < 3 * desc->blksz; i++)
+		data[i] = i * 7;
+	ut_asserteq(2, blk_dwrite(desc, 2, 2, data));
+	ut_asserteq(1, blk_dwrite(desc, n - 1, 1, data + 2 * desc->blksz));
+
+	ut_assertok(firehose_eval(desc, buf, 4 * desc->blksz, "CRC32(2,700)",
+				  &val));
+	ut_asserteq(crc32(0, data, 700), val);
+	/* A buffer of one sector makes CRC32() read in chunks */
+	ut_assertok(firehose_eval(desc, buf, desc->blksz, "CRC32(2,1024)",
+				  &val));
+	ut_asserteq(crc32(0, data, 1024), val);
+	ut_assertok(firehose_eval(desc, buf, 4 * desc->blksz,
+				  "CRC32(NUM_DISK_SECTORS-1.,92)", &val));
+	ut_asserteq(crc32(0, data + 2 * desc->blksz, 92), val);
+
+	ut_asserteq(-ERANGE, firehose_eval(desc, buf, 4 * desc->blksz,
+					   "CRC32(NUM_DISK_SECTORS,1)", &val));
+	ut_asserteq(-ERANGE, firehose_eval(desc, buf, 4 * desc->blksz,
+					   "CRC32(NUM_DISK_SECTORS-1,513)",
+					   &val));
+
+	sprintf(expr, "NUM_DISK_SECTORS-%llu", n + 1);
+	ut_asserteq(-EINVAL, firehose_eval(desc, buf, 4 * desc->blksz, expr,
+					   &val));
+	ut_asserteq(-EINVAL, firehose_eval(desc, buf, 4 * desc->blksz, NULL,
+					   &val));
+	for (i = 0; i < ARRAY_SIZE(invalid); i++)
+		ut_asserteq(-EINVAL, firehose_eval(desc, buf, 4 * desc->blksz,
+						   invalid[i], &val));
+
+	free(data);
+	free(buf);
+
+	return 0;
+}
+DM_TEST(dm_test_firehose_eval, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int dm_test_firehose_storage(struct unit_test_state *uts)
+{
+	struct blk_desc *desc;
+
+	ut_assertok(blk_get_device_by_str("mmc", "0", &desc));
+	ut_asserteq_str("eMMC", firehose_storage_name(desc));
+
+	/* The sandbox MMC devices are SD cards, not eMMC */
+	ut_asserteq(-ENODEV, firehose_find_storage("emmc", &desc));
+	ut_asserteq(-EINVAL, firehose_find_storage("spinor", &desc));
+	ut_asserteq(-EINVAL, firehose_find_storage("", &desc));
+
+	ut_assertok(scsi_scan(false));
+	ut_assertok(firehose_find_storage("ufs", &desc));
+	ut_asserteq(UCLASS_SCSI, desc->uclass_id);
+	ut_asserteq(0, desc->lun);
+	ut_asserteq_str("UFS", firehose_storage_name(desc));
+
+	return 0;
+}
+DM_TEST(dm_test_firehose_storage, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.53.0

