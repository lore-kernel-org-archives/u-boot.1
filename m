Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D315CCF2D5
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD05060756;
	Mon, 19 Oct 2026 10:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3q4aHsxV0M_a; Mon, 19 Oct 2026 10:54:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 092F4606DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792407263;
	b=V+JYEIwTKFXIYiWW3+RLqUFXLYFivWH/X088jxzlloB50+1P2jil47JBfqXhyrtNQ2IA
	 CMsX/kfJI98jl7HINquge1+V5GPKlWLxqLjaMiRpmC1y6uKF8/84uxSfkFB77D8Br6Z/t
	 qAVwUwHWd6h633+27Tc8QpL/nVWSPAfNsBBvEdVLq/7dXoSjWHmpWIJeMAnoxobnmWbsn
	 /wS5CTsRFVrr2eD+kO/w/e5KFtE9xoUscVAGdGgm6CYOxORnHnFEBESi3GFuBhzRf3Rut
	 GeSyf6nTq8XGDxLmkKXVl4EM4zOIeej2Mmd1/m+LNoD+Gc6HIdW/1nCxf01/EGtEgFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792407263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=N9Oi7MER7S+qatvRfobEzZHlFyTZTn/rsqk8nVlyG4A=;
	b=afbn4Upkf2UVYLN94ES0UhMU3h3RT39fTK0Z8nJ5iqRn3vrpNBR7o6e0hH868dmUJmZ0
	 BFCEfuY1Ql01ZTGhLAcfjk+xgEl77IiOLuSMY7vaCdOnxv5A6nqgxgthYtvLqqhHCMAoL
	 zSaXFkVQZ0T/AB07E4PMo25e/UvPsgzokysBXnR9LlTngvKpwev3Cd7ESpS6k/Y7ySvtH
	 qcTgjHiUEXf/spVFUMQp42bsPMNZ1BWYeWZ3uh0uribPl3G2U3jyo9C4NE8WBmQT8x1Dw
	 T2Pc39tnBHd1FurFUFmnHbzFil1i8/IjRkF+kGaqxTRtdSRX7zff1+MXPd/xrcj5g3A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792407263;
	bh=N9Oi7MER7S+qatvRfobEzZHlFyTZTn/rsqk8nVlyG4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EiaH6/HCSQ2vTMHSbja/zePDs8cTxeigWAXBCToEgotGZG/pXA0Dlx9bd2TJDiIMs
	 o9AoyoU651HIsg58V8Q3wi8/+ulaHY/gUebdQb9eBYgAHrN1KcbQmAt5BtSHSxMdwX
	 ddpQs1p0mtNz3b8jlgUAFRAtTF0TT0nvnWDpDNiACaaj3EJpvadH5zYVnrdng7f50N
	 3rGgADqijC+xewXpqI/4hwXX3DtRPVSmEVPnPpro43uecqPyXszArfVy4ihXM3xG4z
	 4cST8SlZjU+MUjkENoY10hOMuJr6b2aLmkAHBgMkH25VyuyCQnnL4Vyxa7BydCuZ6S
	 70+wAdDgSjZgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 092F4606DA;
	Mon, 19 Oct 2026 10:54:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 92F5F263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90985407CF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KRavhq1DjbAt for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:54:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CEE5B407CA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407261;
 b=HF4Nmmf3C3Xfpzxwo/Ma+eNzdx88NJ5U0eYv0CO2r3H0SdRQy5M8txigOjQFLtITLKop
 j9DTX78iypVDYaAtKISHfJxFPGfMFoer+SUTDFpEGm/+FiRI2M3hPC3bjhsZqlXeq4NUM
 PVZyXfZixbWivPXcVQ9/oAAnBS58g6c41CxCGcb4mLkjoRp7ZAoMUkskL5Qj5y6lenO3m
 fLnXaH18TT3rsdqaSThRHgRgJxsQyHVUv49uozLkaObgfWTnJ5hnxdLbtdP4HH6jAYyc0
 Y6OO2BDv/b06uNdcbbNafrAoFT63dX4ISq8pUIJDGaB3pQJi/wnlRnpH4X3oA1gTvdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407261;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=N9Oi7MER7S+qatvRfobEzZHlFyTZTn/rsqk8nVlyG4A=;
 b=Wmd89Tfq1aRnRY/+gHjZ535mH0ZLjdR+0J23DwfHnNdSGy2bGKcEHSFyOMfpyeLQhnn6
 s9EIVP8IwoBsqxdo2FqYMS/jrl0VTK1+PJ6SbLoJUqw1bKY7Yf91mTBCCEWdHAElVyXwV
 PRODjOegO3QmQhLoce7DLHWmO5CNbeFlL4pXpMdh3UtIpQk7HY+UcYkgcSN0kILIh82mi
 u0xogJZdM2vRFjWkeye9Q0oBQAaQ1otMKUCVTUS9wmKd4kfaC6GLi/8TXl/FqbXirZnLi
 DqVfmwlpabGwLRrFndqiplk8WtXJv+RwDoVdeNlx7HJd/RRjlJW+u8CwyOglRm5Wl1w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=O8SGZ10i; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UY0s8D8F; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=O8SGZ10i; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UY0s8D8F
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEE5B407CA
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:20 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P11o2042122
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N9Oi7MER7S+qatvRfobEzZHlFyTZTn/rsqk8nVlyG4A=; b=O8SGZ10iAtvUToEB
 EOZnxeemLO5l+UQJ8prAxNt9CBDw3qGJuKCQH3smKcFiHtqCl9Mvs/4rUgZKFqMZ
 HL8bfs9ukBRQtELu/1bjuEPOLDOYV3CNrAJHqzdRnbTRWnRF/2Jz+8BO+N/nqiHK
 O13N3P6JfQEQjyXGXtkvU2fCA5KtBmtRlrd2UWO+FGrsBTkfnM/klGQiECYnwRB+
 qlXhk5YoQYvKI+LF4L/XxOoFKxNg2fBICe+9GEiWhAaoUNlssrTJH/qmPs090agH
 vJs07d9ULJnuilF3aXICZ/35VNgfS2cftUwj31amPeqfIAwFAaP11ZBCaLcgYub/
 AfrhXw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur2bu5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:54:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso3438173eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792407258; x=1793012058;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N9Oi7MER7S+qatvRfobEzZHlFyTZTn/rsqk8nVlyG4A=;
 b=UY0s8D8F6U37I5kNJQ27tFfnCpQJnOMFNXilDhyne/623o5MjWIBLhP1EDsYzB6QES
 Ab2HLW+zinHbsQQR08Bfo0lGVt+91DVZzyf+FVHIde23fxnjYHb+ecDVPnecAw93xoqz
 MyxhRkPrW8C5s0vnr7t8pLGkZia30zcS9mLdqYKKcmmVuCny/NRg9SS5CHZoBfWLecG9
 G84kvmxWPMfLFJLzDWrVN0dWE0O89N8df4Z2JsogofOd+/sL3gZgtNJZrdzqUHE5hUqK
 hmCyUuoWf+UVHV5Le3weuTMPTQK5mwRMrmZMhjDhegsxHKcRBXMy8IO+kSLM24wJNcUY
 ipxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792407258; x=1793012058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N9Oi7MER7S+qatvRfobEzZHlFyTZTn/rsqk8nVlyG4A=;
 b=QjLaRCyq4tTavjPpFfgByt/jrLVs3rZDIvR5oTpM32JbPw8GOlci5lQSKcmUsZLObP
 a+5OMlDPZJuc4WshEzuc6h7agWH/Mg4kyMftGdeJXIJm54Mq5P3iUlt5aBxZdAsNtTSo
 a+QvKXMz76lMZbFTMcUXhu73scC0RBYAmvgRS0ZrlzJV2Ryu9ayc/HZsqw3c0zVVG/Td
 XDTFkLOuypAYelI2HMCsCrPFgCvxxdWftztlTNpZFTaF8ZP4oRkP/5M2ovELxH/X0mPr
 ZS7n+huYZYMxO2GhyRehqwlycQVvSAKcywK1iOmIQA2jMjvrFOrh/CrYllF4NxyHovkD
 vzTg==
X-Gm-Message-State: AFq9FYLIKilVn93pQI1AuJFbqaDKR4Pj9TOCsLe2X29kEPrcWlhcs3Rb
 MU58LISjQgQSj3BPXipvan7YLzMxCbW3dqJky4GsitEgbRT7+RoVaWKtal70WLMN2m3CN4WXl+O
 9UnnGGHdWsl9CcQRGmmqVg3eIpVM6zGLPmGuUBHuk6CcQYgfCTSFojPUafhs3LwrxuD9XFyQ=
X-Gm-Gg: AYBFou2+xqFGTvw0T3PkXKGSZ770Mru+aKqKOzAqvwIpait52axjCT4aZopjdTKCxzL
 WwK40EstBX5UzjM7LXQOlU8fF0v623fa5r8q1dlZ9OMUxpVr5HXBgaaYpQMzpo1muPEx3Cque05
 Y8BsAHB4+/cKgEsP/p3YtgJv0Elg3pjfkE5a9l3mX18iz0U11nPlOsvgJFf/gUiJRo2KeEZ5RZr
 37L0YuUqa1lWohLj7Me6MWKL7yV2xf0hWOr3x2YUOd8libLevcefuUga7q17a1zEMnC4PUqmv77
 hPiuooymBYMQnrs0Si8L0O/B36SObsBUeOJhMB9TDQSTr5iXhu2cIe+Kr8WHEPsCkDu+HM2Ytvu
 VPdld+KXODpRUwdyDkINdpwDocwOLtaMapEogbqZ3k8OqSCktn9GJaKd0QVJs2uRQaP1kDNgkqb
 +t8oMclKcAYFtr90CCrLU2MbfFWU7a
X-Received: by 2002:a05:693c:638d:20b0:35c:2261:8119 with SMTP id
 5a478bee46e88-361a1668c04mr10490004eec.6.1792407258139; 
 Mon, 19 Oct 2026 03:54:18 -0700 (PDT)
X-Received: by 2002:a05:693c:638d:20b0:35c:2261:8119 with SMTP id
 5a478bee46e88-361a1668c04mr10489968eec.6.1792407257513; 
 Mon, 19 Oct 2026 03:54:17 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081ab80f9sm50709421eec.12.2026.10.19.03.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:54:16 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:23:56 +0530
Subject: [PATCH 2/6] serial: msm: add SPL support for Qualcomm serial drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-spl_qcom_phase-v1-2-2d8f7a1e6730@oss.qualcomm.com>
References: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
In-Reply-To: <20261019-spl_qcom_phase-v1-0-2d8f7a1e6730@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792407243; l=2598;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=K7NOfbCZ27UtlNT87cytrtIMLVeCrUlZTuGi3GIPREA=;
 b=1H82QDaPkYS7QOwFj5fsfgpFioWFNecHar8ZjkLa9Jo9Glk0zHiRrI2KMw6hNJUB++oZvrQkj
 A3uyNkGFuNyCFMprEj8Xa6WxsonGBmFKSQRq3ap9weBQMbW5CcZlseF
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX5wkq8tp2TAcp
 8YtQFt1OALYMwGxx/Oc+KycIrqpU5FXzDvAKRE6ZcmX5wRCtEkVJa4jgPd+qtoDH9KS/0VbEEHM
 rYAvVX9x8VEdga5aQJ4mGPjFGTQ1o1Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MyBTYWx0ZWRfX2uGyxOpHlt0A
 LtvyOLSJBJ8DK/uvSgjRFkjyJd/jaVwRPQYYVEteZv0HHys9yfqJ4iVyNcaDE0pJXqq1Mc6nL4F
 nXwEUhVtmgdlKy8QJG1H6KmNqWbBjVxzEU1kU7h6SaaNPgMhcvXTwZxPAhxAzgnFXV2/3FPXsPw
 xWWC2KXp8842Vee9IYITFqexy9l9Uijj1mLUQNhX404fXV5jj4mTzFh5BlF0puj/d6m9hgdWRu1
 vdxqVDzWlvMF1QYYbNoPchbK3uYY8G1+CwPgseixxCpPgeFSFQcdD/xZR+ThDPT26D2/Ac+8rPu
 3U45InhPSMQ1wlwnnbJ6jepSWiD1vM3+9+8huDmFHD5GZTxqM9U2FQcls+IAPEjKSoZqoAHE3rw
 sE5waa9olPS4kOG/Oh98E/KxnnabK3UIV3qFYwIfMfV4uU4O0hz7oL1n6AssMFsikQgQaQ74s4I
 qdKvUGpJ7ggzhOx1kHg==
X-Proofpoint-ORIG-GUID: TCACiPDCHrlIuIA35TTj2eDFKHon6EV3
X-Proofpoint-GUID: TCACiPDCHrlIuIA35TTj2eDFKHon6EV3
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad5f6db cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=0WqLS-FEAbKVq3S080sA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190043
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add SPL_MSM_SERIAL and SPL_MSM_GENI_SERIAL Kconfig symbols to
enable the Qualcomm UART DM and GENI UART drivers in SPL. Update
the Makefile to use the $(PHASE_) macro so both serial objects
build for both SPL and non-SPL phases.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/serial/Kconfig  | 20 ++++++++++++++++++++
 drivers/serial/Makefile |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 909e5e4c5f5..1cc8befbceb 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1011,6 +1011,15 @@ config MSM_SERIAL
 	  for example APQ8016 and MSM8916.
 	  Single baudrate is supported in current implementation (115200).
 
+config SPL_MSM_SERIAL
+	bool "Qualcomm on-chip UART"
+	depends on SPL_DM_SERIAL
+	help
+	  Support Data Mover UART used on Qualcomm Snapdragon SoCs for SPL.
+	  It should support all Qualcomm devices with UARTDM version 1.4,
+	  for example APQ8016 and MSM8916.
+	  Single baudrate is supported in current implementation (115200).
+
 config MSM_GENI_SERIAL
 	bool "Qualcomm on-chip GENI UART"
 	depends on QCOM_GENI
@@ -1022,6 +1031,17 @@ config MSM_GENI_SERIAL
 	  Driver works in FIFO mode.
 	  Multiple baudrates supported.
 
+config SPL_MSM_GENI_SERIAL
+	bool "Qualcomm on-chip GENI UART in SPL"
+	depends on SPL_QCOM_GENI
+	help
+	  Support UART based on Generic Interface (GENI) Serial Engine (SE),
+	  used on Qualcomm Snapdragon SoCs in SPL. Should support all qualcomm SOCs
+	  with Qualcomm Universal Peripheral (QUP) Wrapper cores,
+	  i.e. newer ones, starting from SDM845.
+	  Driver works in FIFO mode.
+	  Multiple baudrates supported.
+
 config MXS_AUART_SERIAL
 	bool "MXS AUART"
 	depends on DM_SERIAL
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 44fb2170f9a..fa4cf8e79af 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -43,8 +43,8 @@ obj-$(CONFIG_STI_ASC_SERIAL) += serial_sti_asc.o
 obj-$(CONFIG_PIC32_SERIAL) += serial_pic32.o
 obj-$(CONFIG_BCM283X_MU_SERIAL) += serial_bcm283x_mu.o
 obj-$(CONFIG_BCM283X_PL011_SERIAL) += serial_bcm283x_pl011.o
-obj-$(CONFIG_MSM_SERIAL) += serial_msm.o
-obj-$(CONFIG_MSM_GENI_SERIAL) += serial_msm_geni.o
+obj-$(CONFIG_$(PHASE_)MSM_SERIAL) += serial_msm.o
+obj-$(CONFIG_$(PHASE_)MSM_GENI_SERIAL) += serial_msm_geni.o
 obj-$(CONFIG_MXS_AUART_SERIAL) += serial_mxs.o
 obj-$(CONFIG_MVEBU_A3700_UART) += serial_mvebu_a3700.o
 obj-$(CONFIG_MPC8XX_CONS) += serial_mpc8xx.o

-- 
2.34.1

