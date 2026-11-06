Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96B606A32E
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ThzDJFuV;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yj3sjHYo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UyVl7yZO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8C2F8120B;
	Fri,  6 Nov 2026 09:43:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R5hYZ_MJwG0r; Fri,  6 Nov 2026 09:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DED53811D1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958204;
	b=KhsUuMbmUh/npb7I8T0hOrdCbocz7bseXtj9RHTG8l19NQDagdRtVKDamQFvLUdhMncn
	 m0l20qWHM0AcIgJoBJC4Q9TKD98rn9C43FjZTuv2CNIHO59CIkK2IMs8sMW0GtolMl9AW
	 gLkWbtqBcs2yqh+wA6xGfc7m6/uSNuBTW/o7FcCDST6UIXFGTKb+R7qQsA3zzmLIep5QY
	 9cNJECFR7bGzCkSqtTTwScjWKPUBkaIW3Oo18l+j4CefnZ6h4usjIGAAmYchrLODqnS0a
	 Jr5fkzNwNmggII3ZQdXkOkIVPszuv6fOS2mHzv5x4WHQ2AQ3MOl0t8HFLNlRyJ8mVQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RoSA2T7Lxel6R6uBJJiikTK0V1kQ9YoJpWe6QvkdHb4=;
	b=E6FNCsq1VXwEKeQJ3XHE0c3sXWL/uJ8lNgrRL6u51OtsdUiZoxUwZ/DCmV9DwxsVlceF
	 QgoHqbCn0eX5nClkZdtqM3xFt22QVTJWXgJNjmLtJjbLE07EEcG/mkK2QWTHFIUhovDfe
	 655kKRnRhxQr5SaScyhMSJmlQOCUaJjscbGGr6a5mP/jM38xMCOY0fpMSoTeim9Reb0dp
	 jZxcjVRmpuSPARoTiBM9AMEIYbE1Rm+TtKcQVsoJe4knYDA3BUvpgWQO+6gRsglFjxTNl
	 Xqx6J/Dg6w/g9k/CcON6vfLfvYwhl+So09LhPsRyrGUEqug288HlT//rUICZEufeHkA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958204;
	bh=RoSA2T7Lxel6R6uBJJiikTK0V1kQ9YoJpWe6QvkdHb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ThzDJFuV2fT2pv1Onyz9MduGn2Md1l6MZk0DhJZ0jR/KU4mYO91veafDxv4dmqBrM
	 bMr2WlhrpVLU+2zfaP9d2gVv2WWPA+Waq5t3gXhj60qWRe5HxVZ56cxrQvXB2kWdZw
	 PL1wRXRv5ko1Aj+Xlmf0/MDh+WaUM+vLkTehcTMurwz3H2xMJtIBqTJBd0nnBkXNL+
	 fb+aNms80vuIejUmxQ7u26CWpf+JaUbjoVf6JIF06ogevdsaQ5xN0mkYF2Ucq+Oj0k
	 asf9q4N+QkFm/VojPKDcPVBEvQgiIoeZW+yrOHuwuzIs4ltY5QdoKOGAsNtjVBCgVl
	 rnmRBE8KtiShA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DED53811D1;
	Fri,  6 Nov 2026 09:43:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 29D7E34D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B92C400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HGdQqe9jEwqr for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7BAC2403A6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yj3sjHYo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UyVl7yZO
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BAC2403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:19 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67R5dW129121
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RoSA2T7Lxel6R6uBJJiikTK0V1kQ9YoJpWe6QvkdHb4=; b=Yj3sjHYos7GVwiW6
 jQre4S9TXD54UmSZWrb9TNWT6LpRjZwrnPpbktxSLTYGcbd0NvYSacEnlHhRqSTM
 cVYsiesVwkkK9nFD+oiDGTr5Krw39s5QpHJbAubyg5dilKoEas0yfuBKD9692uad
 QZCfFsm0AQb3QQbURHl9zyCnrCnkhZ32vmu8jjGkENYsIHPNdCDwiXrLQbGlYY5R
 72p6HNlUOmiCdUrQMsOiAvKC4n5KkV8ZcByM6nNT1YZCZobEZ486/lotmdHPM/Pj
 RczlBt0dTgI94o1qSH93DkoubjnG4l5zUb3RnSLe1ev6q7voz/TmvlCPZDS8Uxqy
 uzkwdA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9t686-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-944138ed63fso75517985a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958198; x=1794562998;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RoSA2T7Lxel6R6uBJJiikTK0V1kQ9YoJpWe6QvkdHb4=;
 b=UyVl7yZOIzfJPTu0zCpOrl10ehi5h1M7AmOmZNy6iVe73uOjQSrmXl8bqnCWRLgZAy
 g4Tu7lmrYfeoLeH9In4ecUdJwKF93jOt8FLdTXATpWXfupzDXXNLZ7ABlhuVp3iHGJfp
 1ZHyGIHusrproJFRmMpfEmGDnacp1oOATe/MOAyY7800a2vr0RF+mKSg4sCwRrLSVBqg
 WbmPnlpbdEf4h0X+XgxG26aGPxZKXLDF9VcEFgrzqL8zbjeaWNQCS7vYHp2llRIsNyYL
 OiHe6OAOMix6MTuTOxXqgFrKwkoP6lDimwZxiuUlYYTTNOaqg4mYqAk9LjmQ26ZRRH06
 p2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958198; x=1794562998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RoSA2T7Lxel6R6uBJJiikTK0V1kQ9YoJpWe6QvkdHb4=;
 b=LvQDzv4DrelmghmFvO3GlCuCrhWbWCGxZCBgYu8pyNtKn4LBY2g/uNIxpvhvgbIq1P
 E6t71EgReQfYzCfAUpmBKWDSCX1dHCnAsjy8off6C68uLM5b9IJhcj/Hb6jtzLHr1z3q
 wQWMZCbCTTGrqKlMczJ0dfb4Vj+d3/Pe2eGBCv9V8fcYFuRJdX6xGplexntZEGcD6eHj
 O/X1OHMtotV/nkdhXAUwQo+bzSaYPppT7lxoj+1CvXS/sv+HKCXeX5Qq9B3sAZ+ieaA1
 r95z56Pl8f882JzIvvGgDfD2HhukQpX9kFgxBMYp6nc58jJETjuUN+9hK9dlvYbLRxA1
 qanA==
X-Gm-Message-State: APuU4Z+2RDoBZKL29LRPn0oHNZ3su4/t0QpqAG3Kt7yWZpp7bmC+FPgc
 +mpVhLxRglva457NJ72TlNv6qFeEE9WI6NdJdxa4CC2X91qs6EWsmfNjf0wPvGoA8qLMKPKlwTn
 R0HE9+62AUcY92XeNQ7HplL/wW8DOtHogwTdHC51hqbn3CPIUPrUxodLPrz8yHy6uDMPnle6iaK
 eYRak=
X-Gm-Gg: AYBFou1lsj4gL5SkTiSAkmjvVHiKqcV15skBGmcYxKKy4bny++kYT0V5CV8z4sXwAyO
 zBqK+iBNdJS46hiYFDWmqMlC07GFL4RFFbUZwFy4wvUdms1iFwMxDZTW0AqEFzRZuBx79UDwMw2
 cqt24P2tK1hkpzse6rrrgFv3Vj2+Y6nHw5zN0e5FOK927h/IUjB2v9w70dZS3huxnafaaAaa8Dj
 Xc1sT3o2o6hvifaGtQVvQFSLFJMXTGdVrykaS/lkkD+Q6QIxseCHRLOCcs6UQpBrodznS5lDvU1
 CMbuSWMjKm3Ow6T0E5QycDqJVr9m4It0ZVmRL/u10W5F4x4DU2feoQDZUKQ8bZjlLd4tR6uQPcS
 6Q2+TO32hzquXqxXyGCK+zZLpxEhL7gey3AQ39ogO+5PN3uluxm1fU6t7Cm1uzTqVWk/qdhkCGX
 pjYBuGD92YaQS2
X-Received: by 2002:a05:620a:838f:b0:93f:2ba5:170e with SMTP id
 af79cd13be357-945f34d7e66mr277191185a.18.1793958197791; 
 Fri, 06 Nov 2026 01:43:17 -0800 (PST)
X-Received: by 2002:a05:620a:838f:b0:93f:2ba5:170e with SMTP id
 af79cd13be357-945f34d7e66mr277188185a.18.1793958197363; 
 Fri, 06 Nov 2026 01:43:17 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:16 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:41 +0100
Subject: [PATCH 09/14] mach-snapdragon: use the EDL USB IDs for Firehose
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-9-e7591c12fc65@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX0g2UD1pWr0X1
 GwA7HJsa14VfYaKfPtqRbONKsQBCLWxje+1FYNUo9+QOZ0t2sdzrTAkGskl5ZBECP3nrePYzLub
 Oh4/7luRVlDMzZCg6lB3LkIwge9jwcI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX/LCW4AvuDUnv
 Stzec02BpPpAobxiV8LbueOZxaj5lFRf13+TM5y6dK25d2tysDqnigX9RG5bu+rW4OWk3Ljn5Ro
 XifEHLFyv6KB+t3jIDKprds7aZJSUFltOOdlmXYq52hsmFlbTI2Ay4UQd6UtVeqTUJbhImZkFXI
 c0QOuGjtAaFAo9ofv9Lkz5154PkDcm9HL3w3X8YZOM8J34T9ZBgHQrvWOX80GShV+6jehK3IOsd
 tjTwo99ux2EKO1KR/Zo4Rb4BgfD0oScHmIWHbFA2ZN/uLamHJZxJilDe/oDC4Orw5TkTZ4POB3O
 yPRdWgfO7YjiDgYKK90W8hqsVVMUfEFOix7/MOx+0wJB2Z0K/P/sbwX1k+feQA1LaxF9Z7dojg7
 IrytkdyR+yCeNmdtePQuKJP3W6oiGhHDsiyb7Q7LpGd0GZpAnfh7xTSdg2faLAf8ck2uNpCdejT
 u27ijsnwXF52ls/T9ww==
X-Proofpoint-ORIG-GUID: QGc8VP8KpKuHezlD4dK-oxYczC0YeFSD
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aeda136 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=7Ph7dtaHp9H7j0HNadQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: QGc8VP8KpKuHezlD4dK-oxYczC0YeFSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
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

qdl only probes Qualcomm device VID:PID. Enumerate the Firehose gadget as
05c6:9008, the EDL ID, and keep the configured IDs for the others.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 2569f875a8a..99c8ae112da 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -11,9 +11,11 @@
 #define pr_fmt(fmt) "QCOM: " fmt
 
 #include <asm/psci.h>
+#include <asm/unaligned.h>
 #include <dm/ofnode.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <g_dnl.h>
 #include <init.h>
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
@@ -224,6 +226,27 @@ void qcom_set_serialno(void)
 		env_set("serial#", serial);
 }
 
+#if IS_ENABLED(CONFIG_USB_FUNCTION_FIREHOSE)
+/* Firehose host tools look for the Emergency Download (EDL) device IDs */
+#define QCOM_EDL_VENDOR_NUM	0x05c6
+#define QCOM_EDL_PRODUCT_NUM	0x9008
+
+int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
+{
+	if (!strcmp(name, "usb_dnl_firehose")) {
+		put_unaligned(cpu_to_le16(QCOM_EDL_VENDOR_NUM), &dev->idVendor);
+		put_unaligned(cpu_to_le16(QCOM_EDL_PRODUCT_NUM), &dev->idProduct);
+	} else {
+		put_unaligned(cpu_to_le16(CONFIG_USB_GADGET_VENDOR_NUM),
+			      &dev->idVendor);
+		put_unaligned(cpu_to_le16(CONFIG_USB_GADGET_PRODUCT_NUM),
+			      &dev->idProduct);
+	}
+
+	return 0;
+}
+#endif
+
 /* Sets up the "board", and "soc" environment variables as well as constructing the devicetree
  * path, with a few quirks to handle non-standard dtb filenames. This is not meant to be a
  * comprehensive solution to automatically picking the DTB, but aims to be correct for the

-- 
2.53.0

