Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02B606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wbaMuIjW;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MRjH9sOr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZMEJIEMe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB26B811D5;
	Fri,  6 Nov 2026 09:43:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HFzlSl5c9zhw; Fri,  6 Nov 2026 09:43:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 064F9811BE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958187;
	b=no1CKZvVanK2y4aRI8QBTK970lmATag2wGwj2zmNKN3AIkd6XqW79xDgLMoxTFU2QwaP
	 AYw/sMeCVRr3g7Xj9DoEg9YJav3/Zqz06Rhahmhha0YQwFGAMcjNsvjqybuJtpVd/lrGf
	 5dIqkq2Xr1zzliPSgCrlzeAOBCeN2DTbu9OR6fzvPmVHkF5+Xiec4JBnzzDsGLnXzcCQU
	 m71ArTOg/uWh19jc4Y4giyzsAUhLQ9Blhg/1dl0TzS+dyDawhMjJ2RvY136u6NzBqv0dP
	 sqefeGzWhGuBfdtKtQwDc4+RZJwi6DjH9V1u7SIytjUbWuExUlBCoTwjdAMGGT76+bQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958187;
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
	bh=y7zhbMvZLyfoa/0fLRa6eMQeQQQ/WqmSu3rUNmv/x4Y=;
	b=bMGpAvL3gl/wFPsFDq5iSowkLcd5YMWsLc7ZLpLwTAEkHx6lEDq+7vftU9N6LEHcEPcR
	 GY/khzJZagee2y8BLM1NloAadxXFcVl6FR1ZVPNMvc8EV70MsUywh8fC4aJZeoRrSVnJI
	 cKYTEVx1MIXqwS0sLX9Fr6cUsUl4Z9t7nUO47iwCVqMtZZZTLQ3anbUOtGIiHHEIAY8Lz
	 jeT08iwhg4bIuG/xaB17mcAF+yzCfm+E/Kd2Wxbd4Pxqb88qzIbVl6BRbAW4pcLfsNkId
	 T1h3P2D7CvcaJoQZCLJpYpXj1UjwCc2pxnQzHMrL0bJMDmIAQt5z0WXEnCI4F18w9RA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958187;
	bh=y7zhbMvZLyfoa/0fLRa6eMQeQQQ/WqmSu3rUNmv/x4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wbaMuIjWM7NOtWUMXuYlRu225TBnUWPJ6dFUcd00k/p6kbUrg+Wuy404mKV6BGC+u
	 nSLMFFXx5H6O+bbbPJM76mWUYDpnuJiW59L7yMGu4M4kkfxIKNsSPEfMBs1lSlR/mp
	 3oWuBFSqWR6pldRdyoEy2TyIQlGT+8KjPoLgUHjHw9V2eWFMAEUcj4X5EEtXt8Y5gs
	 HYsMRvRLRQiMfoA0YUGMWPVJ1veNLVkhZBvrEJZj0jr4hUHif1mav5GWl+Jdy5jNYv
	 bud8Kk8RpRt64t20WIkAG82z009dHpdLT/bqjw2yrAMpe3DaKemcZIStK6qkYObLBo
	 hszgNavMhYF+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 064F9811BE;
	Fri,  6 Nov 2026 09:43:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB5E12AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCD32403A9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bCcXLhzlJ0Q0 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:43:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 342D9403A6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MRjH9sOr; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZMEJIEMe
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 342D9403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:43:03 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RJYi1679494
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 09:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y7zhbMvZLyfoa/0fLRa6eMQeQQQ/WqmSu3rUNmv/x4Y=; b=MRjH9sOrnBrDdFne
 WQSyPAb/Mvq1U9jPCamj9HUVn84yEYyLNUOLdewV4UQ7Ye9AT+/kMOiD2+qMLYKU
 020ob3YvqRe6NZ/UXZ6eOUYjE8pii28AvUm9wSGIPaU+k+yyJrhF7QYQfC6T1Z1I
 lwSSGYFxEnAtEjQ3X7apKYwwDXhU+DhMhkP2GKih1c08oO8ClZXnepKGKgpG/OeT
 jYvniWVqfYXk15scAjRP2SQVN90RnnlzG1ySiGP+BJjROOfJh4jSCOOh9k9qmuvv
 t9YzzLaVI/2nFTdSP8q0rDx7yaAZLqEevk/id6lzxMqfgYqlUtjcG0rkJsmL789A
 yrkMLg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pca5hu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:43:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so34605185a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793958182; x=1794562982;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y7zhbMvZLyfoa/0fLRa6eMQeQQQ/WqmSu3rUNmv/x4Y=;
 b=ZMEJIEMeo24ycUvSkQde7cN0ktxKwdqEX3OVMyA/f4qgJmOEgyqAXlRek6SFLMpf9l
 VG5m9NcH03FN4uPCQDGyO2au+Blm9I2N1cvYIf65kB8D9zbSs5rMXTte1yTEnuQakS6n
 LokHeuaadpS7bt8duDByGLqSRcaL0En2t40c9WlICdhfIO3y4toh8tfDWnhqfbeukUai
 +UzYP0tciOj9E7Botjl5ay5hsrLyhQjHtQtjBeSL8aslIOoFViJGQbAq/0jOPJpua/G5
 9sqsHy7WgUrSo/ny+QpeBJktu1sc9i1b4kMnBWH4crmAhJd8txYB4/JwOSO6WacLW5Jj
 +f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958182; x=1794562982;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y7zhbMvZLyfoa/0fLRa6eMQeQQQ/WqmSu3rUNmv/x4Y=;
 b=0KwsriCo9kIsDUmEec7v71vLEd9SdRE1EX4TxXjDXSMxk8hHYTNkvKAlSX+LMO60f6
 bZHyHhLgPBAT8DShIf+VH6+A9W3RQPg9/zeSRLJb4c8NWwvTcYGvfOYLzTDfbVGp6yLI
 1NplXjnDtJCzWCG8ePSgAYy9TA3IIkLDVOtx4r8X2Y4IOtBn1qacvpqqQeVUgVFQion7
 f7xgEacnrATIIoR99bkQUY+Hcjb/fWm2Q2hpRrs0YXAR0ZLfyab+vCCi6nrZ8sWQKAOw
 H6otJFOgSmBoOZ1rSOvfB9PUEQam/ZNpSMUTQi/tOe5GJ0wjliFOuqSjkN+n8krXwQds
 h6OA==
X-Gm-Message-State: APuU4Z/sR+ISrQK3boyj24Jxmk/sr0Z37DA5fyOuZTuoAcRSqTLckXMK
 QMlxuAYC34U/zPma9aUBV517G0SE3Lmvzp4Lg5Ulqsbw3k5wcR7vLfFEV1PTuoVotYud4tbg4cB
 +TL+eU2tsFoejDUJTN80eGRAAImPqlZ6W2G8EoTIdHIrOzF6sPD4h+PTp09Y6EETs8RUX4Lc=
X-Gm-Gg: AYBFou2jwAEnHSd0wknilMTzdcJXoSD779f1kEx4ydlJgc0xHiHIuav3L+HLiBcJQfA
 hYSXxfbMc3YGZitO5waPiafqtwU6a4esiZmXeWInWW2xvob17rjFZu7L4xBnWjmyLb/GHAE5IS1
 +ZMD7TiZHW9jCUCCEACbiUn3JLpkTguKL1Sz6uYuNbinY8pUWgNtOO68OnA9PYWNEQ4ZrvL4z9S
 bIBMvhUtHWim7AkfK6tTDRiihw3lhqTZQeAHqyq2+jLhBWtaJsJOSTNmlU8WVndqCdFO8PLD//q
 G2y0HrF/VyFyLyEU40alPX/OvDNABziy+hMBHvO+Jjqal7CsY27eRouhsnWv88soTI21zRm3DWn
 Rshe2Al0RAAgbDzZhNUkD8anOzjYMZrJWQ0ywI4HKv4A5Ubu1QdKB8t6MpTjpUT2Kw4tqHLO24i
 J7ve8NOXUfi+8f
X-Received: by 2002:a05:620a:2688:b0:93f:2eaf:64d6 with SMTP id
 af79cd13be357-945f34cab4fmr276329785a.48.1793958181571; 
 Fri, 06 Nov 2026 01:43:01 -0800 (PST)
X-Received: by 2002:a05:620a:2688:b0:93f:2eaf:64d6 with SMTP id
 af79cd13be357-945f34cab4fmr276326585a.48.1793958181091; 
 Fri, 06 Nov 2026 01:43:01 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ec2csm64822366b.14.2026.11.06.01.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 01:43:00 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 10:42:35 +0100
Subject: [PATCH 03/14] usb: gadget: firehose: add the program command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-firehose-v1-v1-3-e7591c12fc65@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: QmEZfrFMEs30BaJEkExxuEzLr7GPC9FK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfX33vpI35qSg5U
 /Z/Cs5ZUG97TsLbLerJ7TfQe9+lG8y9emPRH6e6INteu7RDna1/qcreQ1GUhdXJ0+yMLHgtcaAu
 gSRkp3ulaW4Qv/2bQdCTcABiESjyCLMFoH9tms5w6JOuhTVPDgDs+6hw6RpHZT6c/UWWkVBNaCl
 ibb4MQqgoBF/S0AfD+iKHqj0MbduRBQaQnzKXiMKuTzc16ojIqeQ4m0AMdiNEs6QKRyuoL1XiRw
 BC1pA/W8fDW0Ifrd/SZzHD/VuBQ18ggh16S2FjzmVjqRaLwXlM7jmLc8dMEgalGev47WPpP8GzT
 3DVS6Jy7Zv6PUG4wIzeJIATYzdWQGWimSZjLfMIiImq+b51xQHqH9r2Hz/8EFk8iELBNqgkzkLX
 USYY6+MFow/I3QlE4OQ2ENUoFviA7/ZiOJpYuxxTlmEMtG2Dg5Ywa4YNDS21tVt7GD635r9bebl
 N7vVxwz2n1dlX3Hbclw==
X-Proofpoint-GUID: QmEZfrFMEs30BaJEkExxuEzLr7GPC9FK
X-Authority-Analysis: v=2.4 cv=TI3Q2Fla c=1 sm=1 tr=0 ts=6aeda126 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=cyhEUakKG5qjLxDO30EA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzOCBTYWx0ZWRfXypmmesVWWeHZ
 7FoCCYlBcsKsySa86KC9Bkc3BboviybM/j9Cop+gi6O4EGUCAzYix3aj6lMS/38nm/U6BkNnIw0
 qUkQhpqV2p9atWapTpKPjYoBxfqHoB0=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Write the raw sector data the host sends after the rawmode ACK.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/usb/gadget/f_firehose.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/usb/gadget/f_firehose.c b/drivers/usb/gadget/f_firehose.c
index 4be8d3ef1ba..5f1a4254436 100644
--- a/drivers/usb/gadget/f_firehose.c
+++ b/drivers/usb/gadget/f_firehose.c
@@ -540,6 +540,43 @@ static int fh_configure(struct f_firehose *fh, struct firehose_cmd *cmd)
 	return ret ?: FH_RESPONDED;
 }
 
+/* After a write error the data is still drained, then NAKed */
+static int fh_program(struct f_firehose *fh, struct firehose_cmd *cmd)
+{
+	struct blk_desc *desc = fh->desc;
+	lbaint_t chunk = FH_PAYLOAD / desc->blksz;
+	lbaint_t start, left, n;
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
+		ret = fh_rx(fh, fh->buf, n * desc->blksz);
+		if (ret < 0)
+			return ret;
+		if (ret != n * desc->blksz) {
+			fh_log(fh, true, "short data transfer");
+			return -EPROTO;
+		}
+
+		if (!err && blk_dwrite(desc, start, n, fh->buf) != n) {
+			fh_log(fh, true, "write at sector %lu failed",
+			       (ulong)start);
+			err = -EIO;
+		}
+	}
+
+	return err;
+}
+
 /*
  * After a read error zeros are sent for the rest, then a NAK. The host
  * expects a ZLP after each transfer that is a multiple of maxpacket; not
@@ -609,6 +646,7 @@ static const struct {
 	int (*handle)(struct f_firehose *fh, struct firehose_cmd *cmd);
 } fh_handlers[] = {
 	{ "configure", fh_configure },
+	{ "program", fh_program },
 	{ "read", fh_read },
 	{ "power", fh_power },
 	{ "nop", fh_nop },

-- 
2.53.0

