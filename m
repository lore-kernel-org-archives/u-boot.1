Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38257606A32C
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fnUj7363;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W+Rp/Art;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AWFfSM6F
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1387840852;
	Thu,  5 Nov 2026 18:27:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJNASKx8un0H; Thu,  5 Nov 2026 18:27:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4FEB6407C8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903256;
	b=pkQsshE/x6Zvsp7Big9+2NCx3dnqFhcU/xh/3lm4DQgd9rKWI4XBS9/fjlP2VtmLACXF
	 lUdqU77ithpeWYH01WQ7gIiLvOaMBJcwkMgXlfFVrb8ym3da4sDpvvU9VEnGUWDm+2Z0D
	 gIk3lEdfy/HyrEu/hBHfNbmOoqKyJ+ciCNNSAFzE2a17lIgE6JTR1tszy6F8SSwHO8efQ
	 62+pxELd20/Xw+Gsyn1UASnzI5vNPHuRNnnZEdqMMAnKEbXlb3bV9RSCKaWdmFIdpFXpL
	 keyWjfbo0N0WPYULXYpnnhCnzg+a/8GZ+NReZ3iRDyx7OccB+YdEh3f9o6nnfm/1+FA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eEsal8rNS/bvP0q3028gPf1Mbribf0DBxuruNxhNAx4=;
	b=qBJqnMJMkb3pi0aTl0iWdp62fI2B+KopL3m99lrMfN11Ej/RBH1e02LfWpoKpNc0gtlm
	 itBF7ipWDxU/K4slBbROrHDgoYuJXfKNQ6KYD75H4oKxRUzyiX2cIWAslE5w4Sy2S0MvK
	 r/q50diMcO6TQ9mIcViaEZChwjlp4il3lWqw/hw3lUjrkAujCFScS9fbwr2kM3JF4xF/6
	 GM/XRMquuMHLV2czOaQCjlZRPSjTqCTsj+2N/CYF3QzuhSqTXoosspR6EdNREGD2aFRCQ
	 quleu+t0hTrOY86DvjzFqEMYuBa7q2zK30W4Mkuv6b3w+MiY4pgowLHfc6RJ2ib5BoQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="W+Rp/Art";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AWFfSM6F;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903256;
	bh=eEsal8rNS/bvP0q3028gPf1Mbribf0DBxuruNxhNAx4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fnUj73632bphOVCUDgK62XH32c9dQ0cCy5Eg/OWGlYvhptyLLuKmQcZh27RmCGg3M
	 uOcQMwPhbAPfg1P6TjOGkyzBO4/SPOf5NNIUXqmO9o1KbCH3LNrkA1S6Q1FPW3vuxo
	 E12r07y2HDiqTFiK7Eu8fRRGxpdRFADN1c1n87sRu//LQ1a4qU1e/O/OpoNxea4Pk6
	 nxeN5jRo6LHIkgMbzRbmN7U+4ZFgQPGk7WnpA/LELdj3r58r9VziIPBCyknrVEvAMO
	 qRJw2rHuf1DeQtdrEK7Jus3QpTxvVuerRicxkqwv+EdnTwx8KpuNytp4uuOZNVbGWU
	 Wicq9fpBgVo4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FEB6407C8;
	Thu,  5 Nov 2026 18:27:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3050931F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2253A406E7
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zD5RoGVz0T9r for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:27:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B021407F5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=W+Rp/Art; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=AWFfSM6F
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B021407F5
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:27:32 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeQhF1122105
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eEsal8rNS/b
 vP0q3028gPf1Mbribf0DBxuruNxhNAx4=; b=W+Rp/Artrr2Au342pfkaWaV2VnE
 a/3AMnCvh9qigfs9amcQDiReHPOSirSHpmdvNuEs6z+qSNzaToWeYoEpEn9wMFRn
 TtME6kmlykC0BAtF0fn2c0dsOEX1YQbXooOAEaJamOEGFfCe2XXAXsZjAIhgE8jx
 CvPMjzGNtskCx7s9YYhMoPrku3VQULOokn8eAkOqUBV+i3G2keRHErZtVjSrH7qQ
 1kbTL5E3hAIgVOcx5n/nrx2w6WD3+wP1ejXSAhQS+Svs07Ty1KQaoipgH8KFhBEd
 Ln61qE7ew2/b676TJivDqG+3A9B4h/BCiZROgwsBog6m4KQ1WN51B3n6aTQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p2e8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:27:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so4207975eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903251; x=1794508051;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eEsal8rNS/bvP0q3028gPf1Mbribf0DBxuruNxhNAx4=;
 b=AWFfSM6FE3ncLcXOu4ZIr2GoA7Ia8cfaokRlUJjXJ0kJyHkcVotCYhs1Uy8kPx92jS
 I9hql+VsfzfM0fMjSBvhwRU4cWKxIQBBAIrLXucPO5ieZj5HYQy0dFGngWlT6xreMEGU
 ma89rkKiaVDj3/nEz7cAvSMgi/tY60w8ItaEatUbcA/FWmDajHc3zoGCEFnd+GrP/cV6
 BZPcJ1ZoIdwkYskcEfW33lgGnpOIYdsL9xmeZm8jBp36BMPfTKUfnqhmpvMuCrnTYp0W
 C65Hh0L+tSJbJ7+tvwGYyR4T3ti+/iP+HFODt0s2tYf2R158E3v8HrDHeIP6DR38LwkV
 JdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903251; x=1794508051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eEsal8rNS/bvP0q3028gPf1Mbribf0DBxuruNxhNAx4=;
 b=eoRnxa82sx0NSfz9M1KqT1g/9/IO7eI7x2qTVLnNza6dUW+etpTDIjmiMTtG7ltXJB
 nbrSICKqgD9NeMIt/7+TJb3wt55Oi3+vHnwtZJgbzUIQjypvvnfHcxQ/ELJlULNHnITH
 +HIKNevykFVy7TbDPHS/4GwZ1JFcUaBabiebEhKdXAfB9zV2e4DTjPDrbYgB50iuaAIe
 lW3wERFhGi2bdQTssuQtDNfV1DBbNd96uF4z3p7X3iZ9lPNhCUm646pj/yxgeqJyj8Sa
 eFUoLIGoodNVMUQvMgQEUQ4HezbVxChomc02leQkgg11lsRAB5NpDSeIc+/hky5MZDQQ
 MiBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4YvyCIWmQOWWJdAc+LNA1OQd1SVlVXndvF8BQk4yBB9DKHJXcR50jTykCbmEaRYph6TVK9v0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/uPNm11IskxmBlDGUMjIx/bUWahDT+UBGVm8O8A4oeIzvAlCeM
 JtwBQ15h/JJUM2yW31NbgCJ4/lsppR5LwV3qSq7B4ySWz1b/8rZAP7Ov1vQyZuhRdEAmBV3omHR
 7WI2HJcGxqI0EBpQMLRM/7BVSH22YfGXj1AvIaXgI5Xhipy31M6IK63xruElwEyqFqXrY8iM=
X-Gm-Gg: AYBFou2jQ1oHwfgjkBulUO32XswQK0GHK4hEmhk4p38OtVjcn3lWbBbBDuFvhXbtSeR
 Jny2dHjtSpkLQlkkq633cU68WltRia2QNzTm+q+aK2cw23IVY3TDWDKGOQtF7W/rMslymshIxqr
 5FYfuyK+X8E4WnZTJ7C+a+yG70KvGy3Ai0R/EY3UHrEeBFdi8/8s4bRy0W9xXiJimKptjysrJi9
 9fCBDU9p55nggNdIlV1BpaXA6Vv1ykbaxryNP5zcid2m2DguJFYJBKbTy6I/97qThmF5bFGyIYx
 t+M7Qq3JE06WwwCNgh/ygDHRFDX9lVq+TzNLxILgn09lp4mhTJAHKQ82jaarl52a6s9fYeP4HnP
 AAwEBbX+9lFa38gODvfqZxOb2JsPXpfFkBFDqdCm231KBQKRGt1IDZkXVdJ8SeLCLy7kfNtYsvY
 B/khw15y3nLD111x/ZrIKRoVqzZ9PLmbpigWeXmHijihdYSA06KSbhmK6LPjooPo0LhegS
X-Received: by 2002:a05:693c:8358:b0:36c:c521:b9cb with SMTP id
 5a478bee46e88-36cc521bfb2mr7810344eec.1.1793903250503; 
 Thu, 05 Nov 2026 10:27:30 -0800 (PST)
X-Received: by 2002:a05:693c:8358:b0:36c:c521:b9cb with SMTP id
 5a478bee46e88-36cc521bfb2mr7810296eec.1.1793903249944; 
 Thu, 05 Nov 2026 10:27:29 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:27:29 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, tyler.baker@oss.qualcomm.com,
 jbx6244@gmail.com, nikroks@mainlining.org,
 bartosz.golaszewski@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
 andersson@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 11/13] tools: qcom: mkmbn: add Nord board mappings
Date: Thu,  5 Nov 2026 23:56:12 +0530
Message-Id: <20261105182614.2405482-12-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aecca93 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=x8bNZKwIL-H_PKrZlPIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX63iQWeKOQ06R
 OMjavVxqCTMaz1rJSc0KCp4ZnPrwu6VCAQ+ypXNFM8MFcQvZC+A0BwehhAcd3TBta4xRTDiV7f5
 X9AP2O66lB7/Ei9nyle1RtikhEO6Ok1iClmSehV/gQdqreJQ4bdiFNDnLHTLvRFVp8SzaYdKv6a
 tEKip1ruCTHCo87+nn7PfA5flXbvyJLikpDSEHI3Cja2c0pAxMpTl+xCC5SCgozPyd3PzbK64jd
 qKjOXiPBe+ftEQ8Sc8ynRVT/hCB/46lCV/3B2xxsTsYGYtuVRDeRJpyzcNJHWQA41LTqCoH0uJd
 Pwq78wxBBj9nHDA7f1o1U2OdWKlEfGamF3VJSrXj/TTkRXcC2V2cLQQJ9jyxNXSVLwP4o5G9/2c
 LIHpOQCh2XcP80GDrP5UNgrG7SzCbhSM/5xgBmzEsQ+jCo9FxJHzye72ui6DkXFm0xF1QbQjmed
 KkTf+fMiSVpjuzUY1hg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX2xCoDqO/5ycc
 fixzFMd8GC0OgZ5ngxE4CLWgkn0BXdTGYxoHY+n/UrPRk4QSpMb3ajsrIFkR013Wy6du1T2k7EG
 ie5L2AusjL4IMfDu9SKcxcQtmgEBzE0=
X-Proofpoint-ORIG-GUID: ADo2T63kU0EDLqU8owBPabFRMVz5FHtt
X-Proofpoint-GUID: ADo2T63kU0EDLqU8owBPabFRMVz5FHtt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050073
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

Add mkmbn entries for the Nord platform using the platform
compatible string ("qcom,nord").

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..6e9ba19cdfb 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -87,6 +87,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
     b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
+    b"qcom,nord\0": MbnData(0xD8D00000, 7, SwId.uefi),  # Dragonwing IQ10
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same
     # They use header version 3.
-- 
2.34.1

