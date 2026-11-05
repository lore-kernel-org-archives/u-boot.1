Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06F606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q78BGBwS;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S+RR7PtM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B5cDWi/i
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A4B3404C8;
	Thu,  5 Nov 2026 10:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V6sZSB9k2XYa; Thu,  5 Nov 2026 10:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FB28403E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793874966;
	b=WK6CF/R0dU2l46orF1yHsNsr7vAjxbmpGkX1GYnusfhr7C4wK+jPDjz3VF8DFlteKJF7
	 DtU1WMqHOUAd3vFzV8HbgxbuXitcHL2h91cJT7ItJxw3lKV+RCGDp6r2N+tr+BtWsyr8i
	 hXvWDRUkuw8WBYrXzYwz7SpV50B2h9YRYzhFKicCl/+D/aE60G3bqg96293N0Frqtz27O
	 QvRrcdXZd1dljiKsQUL7ZbFSuwGfGz5+nk7ERQXBsNN47NeuxfWXB2m6kBQrAyjopAFk9
	 wj/MSqhnc7Lm4H7wbtY5X+dIwKJ4xbXOSSvkAiL+1h7hcIBORJWFRKkWS29+g+WTaZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793874966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2EQ61IWAOMGueQVMITuVNgM3brGNjoffwWz3EKGSsTE=;
	b=UYS2Q2t0O6r0E8XFNMP29kgPESLKpB5kbLre0nV6zGqpfSmyxDhOuc40rRsezaeXAtwK
	 W/ywebrPDihtRcgU+u+mRs0liD5cmNONqXZiSYWPdrplkgdEkgLYur19EJQxATrFQRZHo
	 WWkOZ6afZwun82pli5ABUQtsv/fp12jGeBEtBHTHzUNnZNeOdqnE4twYdybYlPAoh4CsF
	 AGuRbNp2kdIu416ulKkUqu48q6M8fCXBXFzWQpSnKTjDnfyUb116+wQFJW/xMZvXcNnZa
	 ARda8neC/BRMzGmw5kn7glJKfJ36kkCvHygnmjNymCp66IaxEF83RZ/itAJn09GaZag==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793874966;
	bh=2EQ61IWAOMGueQVMITuVNgM3brGNjoffwWz3EKGSsTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q78BGBwSC/GtVtqJcFXxSdPu0Ix/PiOAjhtsBQ7JfDPrMOmeR9zgEN6bxdHGcaO/k
	 6Ra5Gvwnnc7eiBwajU1Stjc3lmm0SeK6erWToCW8M7R8A2FYFPCWQRo66IFkd6kM8Q
	 oakC+vnBup2eAIFxbAOvnrxZ4+oQkKELDWiFroZaR7OeUrvnXEFaCwxlVyGrsQDM2O
	 7WGtI/Ir9zOOGyxb6h46c1z2tEEdCjy0OUv/K26WbPrJm3dtxjd/4bfxFjNZ7bOJNi
	 YTYpb3lQjw8/o+K8ECrb6PwJx1iHZrSSp7NKP6GGwb2D135ST5GMwh3tbxvRMlL8AM
	 mvD7Bx/HtR5Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FB28403E8;
	Thu,  5 Nov 2026 10:36:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B37052B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D5E8810AD
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Amz5FNKfzyYd for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 818188108E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=S+RR7PtM; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=B5cDWi/i
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 818188108E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:36:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tDCj444466
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 10:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2EQ61IWAOMGueQVMITuVNgM3
 brGNjoffwWz3EKGSsTE=; b=S+RR7PtM1gqTUM66G6b5zcQRoe2zxX4+sZ4mWJej
 +nkWfxuom+JygESsSn/N3wt8rK93W5iAX9rpZu13EtQ9S7gvyjbZJ0eYHgtRWCMe
 Haw2JnbgkPTU0wbquKsSzhy+MPevAJjO3owG2InxJBVjR+skJ6ESEiwgFdE8nlOj
 vEbT6F9b60nZfvsaDQLs21UYt1BfW7nINRbqMHnbQazabobnDqMTYUpbxTg9Cvy1
 GHMrtdsTZNrGSexBafSEEIVuBjr73mTHBXKrQsmv/sE6P5uEkYUDGV6F8ZfgMfcX
 467IqZiEuLC6uUC35rcsvKooZ8LhkIalgVFE7e8TBNOTBw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaagguf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:36:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3662e7a9299so6026540eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793874960; x=1794479760;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2EQ61IWAOMGueQVMITuVNgM3brGNjoffwWz3EKGSsTE=;
 b=B5cDWi/iHp4V7weniijpobhTw9lXpQjc2oKAwiiWldixihZxQVY+lbrpYUCcQhyc6q
 GwDwq3TUIlnQo6YabvNkLndszC5wgCA1PYHidEAY+07Pt2Z9oP5cDWQ1oku7bRnO8S+Q
 1pge4z6ppebhegXgplb0OE0PyeQzbKVQI8jH+j1HjvAh8tkinFVn5P5bxR57GeXN1fRH
 YJfqvbAjPVbwI5ZpMxSlnKM4sVNgo7fk7EbpvFdrAHZQ0OwpqFRf00J27eBBgDuk+JdT
 Ay/NEik9eTYrCQZqN+l0Qm4cQPtqhmeqiWxTWQCqFQf11QcAz1jWURMvSnb15JKhIkPg
 p8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793874960; x=1794479760;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2EQ61IWAOMGueQVMITuVNgM3brGNjoffwWz3EKGSsTE=;
 b=EvdmHFZuaX9L/nISAICrpP7W+xu8HDSB7LXbqn2g+pkVsOivFD7aQ6rr3wGb01+m7b
 QHnASGkf18lpgD/mL2IozJKb1KY1NwnbMqbl+vUjMVfWkR5XJ/TQritoAeC2Tqv1sgfO
 o1eP2iFAxVfuBoTCIQq494s4R554osmifsHf3SE8JrDr/iiZS37tNuDp3E2qm+4glVBE
 VqvWqOU5P8Hykw+rhtwFSjtqXHvNWSwwlP4K2EzjzRF8hTU/a9Ieil1o+NF5H9fxcMtH
 21QodtAJHxBlFjMB5ucRyLGf2IwKCrLb8d4qbeU288QZEqS0+cPfN7MQwVEJXFMghb1c
 sz3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz78oGaJXIN1Qkr1U9W2RoMwPnE9qvbsx4if8Zssj3WjJ1xKvU/Cjj8ZU3cfkSjplbj909oyZo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+UtpUXm096slBtTbG7XW3+Hpc1MLqjIO1O5jeJXmOwHaCcsqGb
 p3gCu6yVe5Vr5htWkJCi6ap7uVIlDV8hbLYNomXpvZ4Pf9bwmCa1HUEXZMQek5KmO599gSaVzrw
 eJO6FNsbB31+HQNHZDdceAK4/Pr9kcMBTD6vMggFou4vm252qqWRN6SfgY29iKZfC/bNeJUs=
X-Gm-Gg: AYBFou3BmofuKjH2YIIHeSdGvBbcvskPe/pm9p6lifDZ4GO9PAiiTo1Y6oJGks3X9Le
 zp428BGsqhaq5/8pKxe4wxq3zNA62vb4roMc4wiOghT42LwPw+5jzA0VmPpSOjXq6J6QSF+PkwQ
 EYK6lWuWyycnHeqtLuQQcyDBl38njGdsWZTXUsBMZVRjJVJ/oTxHIcKDDbiklwVT6D3kCfIqg6t
 qq0Ttg8+6BMreSTzpaqq0DZ8YC/W6vEB0nFEjCMQeyZRBxD+dJD54VTQgM5cV2ifsKHXCX4p8bU
 sNzsi+z/SK/H1ZkTB/MVCYtv6/UqAuEl6lu0ZJPULLQpWwE2sSVO8M0GYPUanmC20ilY1tcqIJJ
 V502caWKrXoVDzeRWbLd0ofombnB4xm7jr9VjZ12Ln8ockczUQKm3BOM0sP/p0vzwb5K8GT8mEb
 295qZDPVVIOkcjxELxojajsnCjcNIzBIAOktFDOe4jn/r/VihVYLhnFApHu8Ntd6KZ9rVP6DVN3
 xeJkg==
X-Received: by 2002:a05:7301:e0cd:b0:35c:707b:acba with SMTP id
 5a478bee46e88-36a4220406emr28396353eec.3.1793874960037; 
 Thu, 05 Nov 2026 02:36:00 -0800 (PST)
X-Received: by 2002:a05:7301:e0cd:b0:35c:707b:acba with SMTP id
 5a478bee46e88-36a4220406emr28396320eec.3.1793874959591; 
 Thu, 05 Nov 2026 02:35:59 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38fa273sm17992865eec.16.2026.11.05.02.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 02:35:59 -0800 (PST)
Date: Thu, 5 Nov 2026 16:05:50 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 lukma@nabladev.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 nikroks@mainlining.org, jbx6244@gmail.com, xerikasxx@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v8 2/3] pinctrl: qcom: Add ipq9650 pinctrl driver
Message-ID: <auxcBtwNtas2YqKL@hu-varada-blr.qualcomm.com>
References: <20261105095821.3009544-1-badhrinath.s@oss.qualcomm.com>
 <20261105095821.3009544-3-badhrinath.s@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105095821.3009544-3-badhrinath.s@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MiBTYWx0ZWRfXzuE5w7lMyzOG
 ytL0bLduxviSxUWItTq0PWwMh66DG+OcRa8rB9xvQDlgmxoOBAwSOe2LfK/rXoyZHF3xxsNOb6q
 OnwC4QJIkvYJZmc16lt3ZkALatOuOPX/bPnYZH78DOVxoEeEh6OjVgFqbWNa4AIw7uXmLpyq3/u
 9kUPYbgYdvhcuS7jPTia6/U3dTD55QlDBqWOqwkEBKFe2pbWgAiTmMnptvoXcLdHWWbJl1qeLhA
 pbBBYc/WEA+EnogNGs4cPKwwZtSA+j0wJGWEG/nDVGSm1810uUYGFhMuXZbKPGEv3QShJCl0+CP
 18BouOfp6+q4xPb55en7A5OoJNJBNyAZ7Rta7dtoLTccqqbxAaZgcB96DVZcCLxTYdQZLqHGWO5
 rulaPfsEbP8acG4D8sS1zDVIK7dWV4WB7EWJoa052M3ap1ItOVr0WKWCDFMt5U54nPoZawun9le
 IRpXmL3O++0cfzyP5Gg==
X-Proofpoint-GUID: kaxqCT4FrfWClRV0jrOqHf9AHLKSvXTS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MiBTYWx0ZWRfX7t0H2i2xXQgF
 ccVb6NZTe2Qc8lNBnMu8ZGrFNmRVMNOsHzCsMdC1coabrTIRSbCrh4B8CglR4igeYDKz9WDVMJ2
 nYASZhd24GuzmUme663A0hQp4U3gl+E=
X-Proofpoint-ORIG-GUID: kaxqCT4FrfWClRV0jrOqHf9AHLKSvXTS
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aec5c11 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZKDt5Znw961Hpe79zl0A:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 03:28:20PM +0530, Badhrinath S wrote:
> Add pinctrl driver for TLMM block found in the Qualcomm IPQ9650 SoC.
>
> This driver supports 54 GPIO pins with various pin functions including
> UART, SPI, I2C, SDCC, PCIe, and other peripherals.
>
> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
