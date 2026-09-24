Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D30C98304
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 05:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09361807E0;
	Thu, 24 Sep 2026 05:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KRBXx4tcAW94; Thu, 24 Sep 2026 05:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7156180CB6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790227064;
	b=bfPQioAYTqEIR8ZuUIeAPggLEy4XLl2B/ZNWVZe9b/FkZ/89uGm4sQIVvb9+hG6FnH9G
	 nGKuvVlEwWb1xzQE84zcJ46yMBpBNsVxwF4hyeLlCsuSZAwE2g4oKx8/XsJzIhGVvhFEY
	 S7X4S4Yk5Rjhs7l2XHeR8PZYm4Dgr8NE8Rwbg6Dzi2klB9yNV5+bLiQohlxcdfEbjqKco
	 uovYlEDTO1/MHVLdmDtWL2H9zLNbIKQ+gVOTcGwR9mIcVjGCHKr6z+tshV2UvmDXAo6L3
	 2195nsANKgAJYQafx40PyqEInC7qM6JD9t9D3oiesMiXV8JBn2ePBVqkTmGP+5T5bhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790227064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Content-Type:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tXaIFz4SEm36g7xf2Ce1pKpMXz3RRt55779ZRWAKxTc=;
	b=gHLfMp10owtBGCvhBoqQL7vIY7NXdvuuNwBqzbL/d5F8dUAZL11/YCkTTMVE2u7B6Dto
	 j8lx4fNMKjAJDC+83e9VQcx4/FNpYZ5oheJG3gR7qHybU/Gz14zcTHMhZsznmpQuKulV7
	 axjQyTCnAvH8q3z3YNeECQsl7NPBLaBE9tHPezAxRPghPMQ1H/3JhOl43dP7fVfV+k9If
	 KZ7B0iodbQcR2s6pBUU4rvuqi9KCosA7HcxhMXjFcbZWO2m92SYuFW4LgWB0kwYmIx1A8
	 z2r3hoGGXDMsLogFsirI/OHq8v6dOOrOj/VfdoD7RQLgyJQujDkMEpjJ/t/z2NZpxVw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="K/1K8RDl";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jRhuHJIs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790227064;
	bh=tXaIFz4SEm36g7xf2Ce1pKpMXz3RRt55779ZRWAKxTc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QaSrGcbbR2semtKgcF/LsJJbApNwN2G/w0/+b4kYU9nJQrrcsCE7JkEhgIdcYqMCA
	 23RuNdyZPkBwPSTpCL8/4MLQnomUrStwiV5ZKMq5d22i67BOoc+xU2eAo/uOfwIO6Y
	 b2KpXBQRtfJ4xQpOcNLUWMr5sPLkJhKloGE5WRAen0cTO9C2ObtyTOqCk9tLnT8us2
	 2WrUk+ZJU/Ye9hMjPZv0CmDf2VcEp+uEpF9/jw9/UzJ+x+AeDf4xY3oNw6ybYmtKzI
	 2lJMwxeaCYPaAGtnS3bCffqqUIVFQ0wsC8d6G72y25cTrF+fNAFNyvLRyUyTK4rL2F
	 gf9CSNfUuGXIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7156180CB6;
	Thu, 24 Sep 2026 05:17:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E47113B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10B2580CB6
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H_6Lo0gCKvx0 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 05:17:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3BCC0807E0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790227060;
 b=ToCbBTcbIvdAgU7bJpoTtZu6nnOtbZEVNXG4NrYRnzR0jV3JmQLFpy68hbOcVWEF42/H
 UFfHgAkyCAYhjamGFbdM3LJtgkmpeAtlor07KSLm5F5OZaqUNaPiBxOT1M6f8bl5FBcBg
 1AhTRvVPhuqRK5xaamKBMamgpYuUeiAgLPyDoyoStsHIt37zZB1XEtDgsXKRJUXvHcZTu
 nqAnIoET4DdJhL0K4cnPeccaLBdK8CJ2HiSyeg4H0GC59N3QIpY1ZV9mWsZxoQgMJKuXd
 sLdEi4gc+Pcd0fUQHsBESh/ovucQ/dlmv9HVwl4SOvxuop5KR25BCctYkpXqa1Guixg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790227060;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:
 Content-Type:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 References:Content-Language:From:In-Reply-To:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=tXaIFz4SEm36g7xf2Ce1pKpMXz3RRt55779ZRWAKxTc=;
 b=gI3wuyTeqHVMsLiZo+0PZX8ZcgO0uBM62yy6QXTcvlxUk+fTTY2N/Kid4u2N+ezDn1t2
 VquEbyjMD3Za+dMBu2udONe6b7+2wie5i8+GeZFwNvE2h9qAab+s60Kd3dau1Yjuc+fam
 f+mmQ2RvLS6KbokOWPCdmg0GcZn79hXj3nKddMv8BAWevSx4WJJZE3BeiXNugSc43e73q
 GjVtPR/IWI/KSIHO/D0JHhrKINwEWItD+q6izgHVY74rVwKTYpKP0eGfJpMgRDMyV5mpJ
 s5IQfLcluC4eYok87UQMQq8FmwwDxytVj7aaM0LhauS5n8LiHkedFSKDVaajTc4oh8Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="K/1K8RDl"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jRhuHJIs; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=K/1K8RDl; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jRhuHJIs
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BCC0807E0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:17:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O371dk1574568
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=tXaIFz4SEm36g7xf2Ce1pKpM
 Xz3RRt55779ZRWAKxTc=; b=K/1K8RDlRt2QjaBIhYC5TMJWomyf1eLLitTNddz1
 oCmm0Q0c+UgDUMCPDE5tXwEttRQXL6Ml5AGY3o86cNQ2Zh0Q/CSdXfsN+gHIWadr
 bp/hsRzbwBRlaR9Pm0uQOfATgJGE/WRY+1zOvWjbPlpUMjceim+TYRgXMohk8Ldb
 vnGKddsPfsUGHQ1fJ8CinNX/yJvhyiTvP9i3Tw6WdEKEQT+PhE9joAM05Kmn8eYs
 szGj9e5IazkwUHCbscKaW0pwm6HvYq5uumO2UP7SZ/d/fd0r8hEvTwrRAUnwaX4T
 5aZJeLj4FqtejCJD4O2YaokvC/n8M1LEI2ZvmYBVWnR1Cw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvdb63y2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:17:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-333543ac378so1991745eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 22:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790227055; x=1790831855;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tXaIFz4SEm36g7xf2Ce1pKpMXz3RRt55779ZRWAKxTc=;
 b=jRhuHJIsLNppf6q89Qd0orHO4YaGB2mASHpfYQyf6ffxTTK5u0LuXNt3bhF5tul0rO
 2PjrStChBSwAS4cCSdcTk/VUiOz58oIwUciDhycJAoLdxQcLIkb1hfOnkUwxNalptCV3
 +PJMKlAsnaDHc9g9o8kKNiyeWNgTTrpw0ye5rWJa1t2AvpGrO9w1/CAuEiLid7ix+zrk
 HU4dSQ4S4bjVSCgT5E/Ijoab3SiTUa0Z6pmqDUS9f+YEAeXLnzplHhUppN8KJmmWifqM
 qzhW8mrnryUZsqH82zoGpbcVvjrx+2N1LU0EMAF4O3NVU7TlA1KRVdep+P7gXKdX5y4t
 x30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790227055; x=1790831855;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tXaIFz4SEm36g7xf2Ce1pKpMXz3RRt55779ZRWAKxTc=;
 b=jsgy7AiWFVH7zb4CjPmqrtj5DZiYOTahuvQEcbIBDu6f4U59th9nZTTxIdqS06W/Vw
 3BHKesM0jgU6QsFIZo8VcUhIDxV8EXynfTqEV17ypiF2QWMbnM4fGEU9sFIQ1QfFA6Xo
 T0geMx8uMHFMcV/sNgFFsszovO9BiR0U48T/kJbV1DtGPlvfoQfMzdxx3QZ4Xg/XIIpJ
 IZH5oLeeVjDdkc/R2IpZeOLR6et41aLrsWnS5yAnmHrJCbEJ3XqPlJie36EsQBbcmONb
 QRjP4p0hxYhcwwGhjKrsRj0ZOzjurs2l7eSa5nCTjZlGSqhV+lwfM1PEcxQ2cbGg3/A+
 wIXw==
X-Forwarded-Encrypted: i=1;
 AKwUvByqd+rMT/a/BxTu3XaNFONWHN6S6OM4pKX1joBc4FrMYcG5i2L0LfuCd5BeHAH1ZFhtB+bGf0Y=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mIANCG9WMcbZILJUwEi4snRD71uwk4vWkx5J6mb9KD44CWrOcd
 cKktZ4VxuezCK4xzW0N0KJsa/x1EC/v+xjXYzRh/T27kMnmHdtDGCdPMK5hChzxLYvfFmCdidiQ
 wlTf92ww1kMez0TRcwHSCfaoc6l8dsA2T6/LJ3gmU13OTOelmrgExDMXWxh1M9q/42IqxewY=
X-Gm-Gg: AYBFou3w5082J7U2TPOQ5j8+RFoUPfsXupZhs8/6fe7SuZ9eXv7WNhKTgPsw7uL57zD
 BSrIbffpvEBwHx4bShSd7Ymf89lVHRCPpbrwsAFyswKObzFN/W/zgDkZJmUYDMAaXvqAgHQ+G+a
 XfdVklVmpcITXl6EFH0UJx3s+nAoR9aKJpyFBSsFy7bycA+94cR0yIXkOTtdMVOTMfcueIIclE7
 QDGRNACvp5nf1CEOIdIevuC0Cd8Zmcf5c1xpeUOY/eigqU4apgj9JMagnq0laMXvBheUonysYkm
 bQ9crXyk0/NnwsGFZBQuLXCDmlEEO9D0HFVu/bVdbapE/hy90LbS/Rs2vzRLOUk0Gq2Sd4PzEfQ
 N7zE9dS5Xaf7m1N44AMnXt49yOiUkrtsUd6PMCyGhCwCbn2j+9A==
X-Received: by 2002:a05:693c:87c3:10b0:33b:c478:a545 with SMTP id
 5a478bee46e88-34002be4604mr864109eec.8.1790227055110; 
 Wed, 23 Sep 2026 22:17:35 -0700 (PDT)
X-Received: by 2002:a05:693c:87c3:10b0:33b:c478:a545 with SMTP id
 5a478bee46e88-34002be4604mr864085eec.8.1790227054398; 
 Wed, 23 Sep 2026 22:17:34 -0700 (PDT)
Received: from [10.152.193.224] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e9684d643sm22144553eec.18.2026.09.23.22.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 22:17:34 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------yVoHJy7e5Gk0tMVLCMwO3sRS"
Message-ID: <eef73458-8d1a-49bb-b292-7abb7e41b73e@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 10:47:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastboot: block: add 'oem set-block-target' command and
 runtime override
To: Guillaume La Roque <glaroque@baylibre.com>,
 u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260917-series2-fastboot-block-target-v1-1-fc8328bc2d12@oss.qualcomm.com>
 <487435d1-9d9d-4e18-a2a6-ed631760fc25@baylibre.com>
 <009abac6-415f-4848-a41c-d8c79f7bcb6b@oss.qualcomm.com>
 <34d17332-b903-479f-ba72-af02ed33c762@baylibre.com>
Content-Language: en-US
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
In-Reply-To: <34d17332-b903-479f-ba72-af02ed33c762@baylibre.com>
X-Proofpoint-GUID: 5MauDz78CUqbD40TmJ2rHlCisr8w3tCX
X-Proofpoint-ORIG-GUID: 5MauDz78CUqbD40TmJ2rHlCisr8w3tCX
X-Authority-Analysis: v=2.4 cv=QeXzLcbv c=1 sm=1 tr=0 ts=6ab4b270 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=XpE1AkgCAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1VxDqnHFAAAA:8
 a=k-42gJp3AAAA:8 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=a_U1oVfrAAAA:8
 a=p-LfKV-GAAAA:8 a=2pSbnfYAKOv5PKAd2QQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IpJZQVW2AAAA:8 a=WUZjv6Me3FWeufkS7v4A:9 a=evF4uVNgsvNFbEa4:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=dpZMgbseYPk84XhQl7oQ:22 a=aZ5uHUMKh6B-zo3GvD48:22 a=uCSXFHLys93vLW5PjgO_:22
 a=cvBusfyB2V15izCimMoJ:22 a=97BuGM4RKn6GwmfqMd6i:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMiBTYWx0ZWRfXzHhD5tBiCcZR
 +ctvWHIVItbLmpt9qljNyAIyY7tKAIgBwXipXQfaShNSTuUAXPYpN17q8msBnBF54dPR6C9LoIZ
 YVALD5yw1fCHmB/mBo6qRB5x/cCCZX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMiBTYWx0ZWRfX7ZrFtjLQyLAe
 yRTA7sB1YMNka+qh6GUtZOq6THF4fiyxWiKWqjpZpwVGmuDUevTIVsnIwErU2pxvGfaUZgKL+6A
 7AJAHCSboiEyg7o6PcrFQPnSKLjBBS3mPSkWs1vCPsnEFEIypKQKNS8/5HOaXfyZtu3+TD+74tl
 8jAXwxussA7xLKgwnreL62qpTFgRIkVcwAXxh8nTcNo2IPWuod9a6JGX0B0G93bbqeSu131rlFt
 +X7bPqRKOzBMY3/uriBbUnevhFD8MhlhdA5U5Fb8BIseawFR0Vf03ep5lakx7QZ/G/1xpyOjoCZ
 uf7s/L7rauBd6OGBC7FnrW7NHKcqpP9T1N8bNVkWL9p62NYuavDSJD6/H0uukfcJOqLduoLUKvY
 B/bpOb8mjXHK6pvdZWibo3eh6uMkRxUhZdSPEnHZy3yGAtXwbwaDswKt66OJ1PoZ/NyY01Ll/yY
 IoZzaoH7rqKvroX/Q8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240022
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

This is a multi-part message in MIME format.
--------------yVoHJy7e5Gk0tMVLCMwO3sRS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Guillaume,

On 9/18/2026 9:55 PM, Guillaume La Roque wrote:
> Hi ,
>
> Thanks for clarification,
>
> Le 17/09/2026 à 19:01, Vandhiadevan Karunamoorthy a écrit :
>> Hi Guillaume,
>>
>> On 9/17/2026 5:59 PM, Guillaume La Roque wrote:
>>> Hi,
>>>
>>> Probably a stupid question but in your commit message you speak 
>>> about SPI-NOR  but fastboot support flash spi , why not enable it or 
>>> update it if it's not exactly work as you want instead of create a 
>>> new command ? 
>>
>> This patch is not intended to add SPI-NOR support itself. I have a 
>> separate change that exposes SPI-NOR through the MTD Fastboot backend.
>>
>> The purpose of this patch is to allow switching the generic block 
>> Fastboot backend between different storage interfaces at runtime. On 
>> some platforms multiple Fastboot-capable storage devices can coexist, 
>> for example a default SCSI/UFS device and an SPI-NOR device exposed 
>> through the MTD block uclass.
>
> to not create a new command it's possible to just use 
> fastboot_raw_partition_*[1] variable extend it to support spi or block 
> fastboot support , actually only missing part is to parse this 
> variable properly to  know in which FASTBOOT_FLASH_XXX use it.
>
> or an other solution will be to extend series on flash[2] command to 
> give possibility to select block device/interface to flash on flash 
> command : for example fastboot flash mtd:0 bootloader XXX
>
> you do a lot of patch to add some new oem command on fastboot not sure 
> it's always the good solution for all , just my opinion .
>
> finally you do this jsut because fastboot not work properly when you 
> enable multiple FASTBOOT_FLASH_XXX Config.
>
> [1] : 
> https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors
>
> [2] : 
> https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/
>
>
> Regards,
> Guillaume
>
Thanks for the review and the suggestions.
 > to not create a new command it's possible to just use
 > fastboot_raw_partition_*[1] variable extend it to support spi or
 > block fastboot support
I had initially considered that direction. One challenge I ran into is
that the current raw partition descriptor only describes an offset/size
within a device, but it does not provide a way to identify which
interface/device owns the partition when multiple Fastboot backends are
enabled.
That said, your feedback led me to reconsider the overall approach, and
the latest revision no longer uses the "oem set-block-target" command.
 > or an other solution will be to extend series on flash[2] command
 > to give possibility to select block device/interface to flash on
 > flash command : for example fastboot flash mtd:0 bootloader XXX
I agree with this idea. The current revision follows that direction by
encoding the interface/device information in the partition argument
itself, e.g.:
fastboot flash mtd:0:bootloader <image>
This allows the request to be routed to the appropriate
FASTBOOT_FLASH_* backend without introducing additional Fastboot state
or requiring a separate target-selection command.
 > you do a lot of patch to add some new oem command on fastboot not
 > sure it's always the good solution for all , just my opinion .
That's a fair comment. I agree that OEM commands should be avoided when
the functionality can fit naturally into the existing Fastboot flow.
For this reason, the "oem set-block-target" command from the earlier
revision has been removed in favor of the inline partition syntax.
 > finally you do this just because fastboot not work properly when
 > you enable multiple FASTBOOT_FLASH_XXX Config.
Yes, that's the underlying motivation. With multiple
FASTBOOT_FLASH_* backends enabled, a partition name alone is no longer
sufficient to uniquely identify the intended target. The goal of this
series is to provide a generic way to disambiguate the target backend
and device while keeping the existing Fastboot workflow unchanged.
Thanks again for the feedback. It helped simplify the design
considerably.
Regards,
Vandhiadevan

>>
>> Today the block backend is selected through the build-time
>> CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME and
>> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID settings, so only a single target
>> can be accessed during a Fastboot session. The OEM command allows
>> changing the active interface/device at runtime and accessing either
>> storage device without rebuilding or restarting Fastboot.
>>
>> SPI-NOR was mentioned only as an example use case for a runtime-selected
>> target rather than as a replacement for existing Fastboot SPI/MTD
>> support.
>> Thanks,
>> Vandhiadevan
>> ``
>>
>>>
>>> Thanks
>>> Guillaume
>>>
>>> Le 17/09/2026 à 11:01, Vandhiadevan Karunamoorthy a écrit :
>>>> Add fastboot_block_set_target() so an OEM command can point the
>>>> generic block fastboot backend at a different interface/device at
>>>> runtime, without requiring a rebuild. Falls back to the existing
>>>> build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME/
>>>> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults when no override is
>>>> set.
>>>>
>>>> Expose this to fastboot clients via a new "oem set-block-target
>>>> <interface> [device]" command, gated behind
>>>> CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET (depends on
>>>> CONFIG_FASTBOOT_FLASH_BLOCK).
>>>>
>>>> This is needed to target storage devices, such as SPI-NOR exposed
>>>> through the MTD block uclass, that aren't known until runtime or
>>>> that coexist with another default block interface on the same
>>>> board.
>>>>
>>>> To: u-boot@lists.u-boot-project.org
>>>> To: u-boot@lists.denx.de
>>>> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Cc: Dmitrii Merkurev <dimorinny@google.com>
>>>> Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>>> Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
>>>> Cc: Heiko Schocher <hs@nabladev.com>
>>>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>>>>
>>>> Signed-off-by: Vandhiadevan Karunamoorthy 
>>>> <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>>>> ---
>>>> This series lets a fastboot client redirect the generic block
>>>> fastboot backend (CONFIG_FASTBOOT_FLASH_BLOCK) to a different
>>>> interface/device at runtime, instead of being fixed to the
>>>> build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
>>>> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults.
>>>>
>>>> This is useful for storage devices that aren't known until runtime,
>>>> or that coexist with another default block interface on the same
>>>> board -- for example, SPI-NOR exposed through the MTD block uclass
>>>> (see the companion "mtd: spi: Expose SPI-NOR as a GPT-capable MTD
>>>> block device" series).
>>>>
>>>> The patch adds fastboot_block_set_target() to the generic block
>>>> backend, plus a new "oem set-block-target <interface> [device]"
>>>> fastboot command (gated behind
>>>> CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET, which depends on
>>>> CONFIG_FASTBOOT_FLASH_BLOCK) that lets a client invoke it.
>>>> ---
>>>> Depends on: [PATCH v6 0/8] arm: snapdragon: Add snagboot support 
>>>> for Lemans-EVK
>>>> Link: 
>>>> https://lore.kernel.org/u-boot/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com/
>>>> Depends on: [PATCH v2 0/4] fastboot: block: Add GPT/MBR and device 
>>>> selection
>>>> Link: 
>>>> https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/
>>>> ---
>>>>   drivers/fastboot/Kconfig      | 11 +++++++
>>>>   drivers/fastboot/fb_block.c   | 75 
>>>> ++++++++++++++++++++++++++++++++++++-------
>>>>   drivers/fastboot/fb_command.c | 51 +++++++++++++++++++++++++++++
>>>>   include/fastboot.h            |  1 +
>>>>   include/fb_block.h            |  9 ++++++
>>>>   5 files changed, 136 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>>>> index a4539844d89..c7e0509eaad 100644
>>>> --- a/drivers/fastboot/Kconfig
>>>> +++ b/drivers/fastboot/Kconfig
>>>> @@ -225,6 +225,17 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>>>>         Device identifiers are numbered starting from 0 and the most
>>>>         common case is to use the first controller on the system.
>>>>   +config FASTBOOT_CMD_OEM_SET_BLOCK_TARGET
>>>> +    bool "Enable the 'oem set-block-target' command"
>>>> +    depends on FASTBOOT_FLASH_BLOCK
>>>> +    help
>>>> +      Add support for the "oem set-block-target" command from a 
>>>> client.
>>>> +      This allows switching the block interface (e.g. scsi, mtd) and
>>>> +      device number used by the fastboot "flash"/"erase" commands at
>>>> +      runtime, instead of relying solely on the
>>>> +      CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
>>>> +      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID build-time defaults.
>>>> +
>>>>   config FASTBOOT_GPT_NAME
>>>>       string "Target name for updating GPT"
>>>>       depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && 
>>>> EFI_PARTITION
>>>> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
>>>> index a8c74e35d0d..d3e5f6ed1f3 100644
>>>> --- a/drivers/fastboot/fb_block.c
>>>> +++ b/drivers/fastboot/fb_block.c
>>>> @@ -125,6 +125,66 @@ static lbaint_t fb_block_sparse_reserve(struct 
>>>> sparse_storage *info,
>>>>       return blkcnt;
>>>>   }
>>>>   +/**
>>>> + * block_interface_override - runtime-set block interface name, 
>>>> empty if unset
>>>> + */
>>>> +static char block_interface_override[16];
>>>> +/**
>>>> + * block_device_override - runtime-set block device number, -1 if 
>>>> unset
>>>> + */
>>>> +static int block_device_override = -1;
>>>> +
>>>> +/**
>>>> + * fb_block_interface() - Resolve the block interface name to use
>>>> + *
>>>> + * Returns the runtime override set via 
>>>> fastboot_block_set_target() if one
>>>> + * is active, otherwise falls back to the build-time config default.
>>>> + */
>>>> +static const char *fb_block_interface(void)
>>>> +{
>>>> +    if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
>>>> +        return NULL;
>>>> +
>>>> +    if (block_interface_override[0])
>>>> +        return block_interface_override;
>>>> +
>>>> +    return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>>> + CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
>>>> +}
>>>> +
>>>> +/**
>>>> + * fb_block_device() - Resolve the block device number to use
>>>> + *
>>>> + * Returns the runtime override set via 
>>>> fastboot_block_set_target() if one
>>>> + * is active, otherwise falls back to the build-time config default.
>>>> + */
>>>> +static int fb_block_device(void)
>>>> +{
>>>> +    if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
>>>> +        return -1;
>>>> +
>>>> +    if (block_device_override >= 0)
>>>> +        return block_device_override;
>>>> +
>>>> +    return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>>> +                  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
>>>> +}
>>>> +
>>>> +int fastboot_block_set_target(const char *interface, int device)
>>>> +{
>>>> +    if (interface) {
>>>> +        if (strlen(interface) >= sizeof(block_interface_override))
>>>> +            return -EINVAL;
>>>> +        strlcpy(block_interface_override, interface,
>>>> +            sizeof(block_interface_override));
>>>> +    }
>>>> +
>>>> +    if (device >= 0)
>>>> +        block_device_override = device;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   /**
>>>>    * parse_device_partition() - Parse and validate device:partition 
>>>> format
>>>>    * @part_name: Input string in format "N:partition" or "partition"
>>>> @@ -140,8 +200,7 @@ static int parse_device_partition(const char 
>>>> *part_name, int *device,
>>>>   {
>>>>       const char *colon_pos;
>>>>   -    *device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>>> -                     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
>>>> +    *device = fb_block_device();
>>>>         /* Check for colon in partition name */
>>>>       colon_pos = strchr(part_name, ':');
>>>> @@ -190,9 +249,7 @@ int fastboot_block_get_part_info(const char 
>>>> *part_name,
>>>>                    char *response)
>>>>   {
>>>>       int ret;
>>>> -    const char *interface = 
>>>> config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>>> - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>>>> -                           NULL);
>>>> +    const char *interface = fb_block_interface();
>>>>       int device;
>>>>       const char *partition_name;
>>>>   @@ -385,9 +442,7 @@ void fastboot_block_flash_write(const char 
>>>> *part_name, void *download_buffer,
>>>>   #if CONFIG_IS_ENABLED(EFI_PARTITION)
>>>>       if (is_partition_table_name(part_name, 
>>>> CONFIG_FASTBOOT_GPT_NAME)) {
>>>>           int device;
>>>> -        const char *interface = 
>>>> config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>>> - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>>>> -                               NULL);
>>>> +        const char *interface = fb_block_interface();
>>>>             parse_device_partition(part_name, &device, NULL);
>>>>           fastboot_flash_gpt_partition_table(interface, device,
>>>> @@ -399,9 +454,7 @@ void fastboot_block_flash_write(const char 
>>>> *part_name, void *download_buffer,
>>>>   #if CONFIG_IS_ENABLED(DOS_PARTITION)
>>>>       if (is_partition_table_name(part_name, 
>>>> CONFIG_FASTBOOT_MBR_NAME)) {
>>>>           int device;
>>>> -        const char *interface = 
>>>> config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
>>>> - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
>>>> -                               NULL);
>>>> +        const char *interface = fb_block_interface();
>>>>             parse_device_partition(part_name, &device, NULL);
>>>>           fastboot_flash_mbr_partition_table(interface, device,
>>>> diff --git a/drivers/fastboot/fb_command.c 
>>>> b/drivers/fastboot/fb_command.c
>>>> index 18d86988f4c..235fae74fee 100644
>>>> --- a/drivers/fastboot/fb_command.c
>>>> +++ b/drivers/fastboot/fb_command.c
>>>> @@ -45,6 +45,7 @@ static void oem_partconf(char *, char *);
>>>>   static void oem_bootbus(char *, char *);
>>>>   static void oem_console(char *, char *);
>>>>   static void oem_board(char *, char *);
>>>> +static void oem_set_block_target(char *, char *);
>>>>   static void run_ucmd(char *, char *);
>>>>   static void run_acmd(char *, char *);
>>>>   @@ -120,6 +121,11 @@ static const struct {
>>>>           .command = "oem board",
>>>>           .dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, 
>>>> (oem_board), (NULL))
>>>>       },
>>>> +    [FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET] = {
>>>> +        .command = "oem set-block-target",
>>>> +        .dispatch = 
>>>> CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_SET_BLOCK_TARGET,
>>>> +                          (oem_set_block_target), (NULL))
>>>> +    },
>>>>       [FASTBOOT_COMMAND_UCMD] = {
>>>>           .command = "UCmd",
>>>>           .dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, 
>>>> (run_ucmd), (NULL))
>>>> @@ -589,3 +595,48 @@ static void __maybe_unused oem_board(char 
>>>> *cmd_parameter, char *response)
>>>>   {
>>>>       fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, 
>>>> image_size, response);
>>>>   }
>>>> +
>>>> +/**
>>>> + * oem_set_block_target() - Execute the OEM set-block-target command
>>>> + *
>>>> + * @cmd_parameter: Pointer to "<interface> [device]" command 
>>>> parameter
>>>> + * @response: Pointer to fastboot response buffer
>>>> + *
>>>> + * Switches the block interface (e.g. "scsi", "mtd") and, optionally,
>>>> + * device number used by the fastboot block backend at runtime.
>>>> + */
>>>> +static void __maybe_unused oem_set_block_target(char 
>>>> *cmd_parameter, char *response)
>>>> +{
>>>> +    char interface[16] = { 0 };
>>>> +    int device = -1;
>>>> +    char *space;
>>>> +
>>>> +    if (!cmd_parameter) {
>>>> +        fastboot_fail("Expected command parameter", response);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    space = strchr(cmd_parameter, ' ');
>>>> +    if (space) {
>>>> +        size_t len = space - cmd_parameter;
>>>> +
>>>> +        if (len >= sizeof(interface)) {
>>>> +            fastboot_fail("interface name too long", response);
>>>> +            return;
>>>> +        }
>>>> +        memcpy(interface, cmd_parameter, len);
>>>> +        interface[len] = '\0';
>>>> +        device = simple_strtoul(space + 1, NULL, 10);
>>>> +    } else {
>>>> +        if (strlen(cmd_parameter) >= sizeof(interface)) {
>>>> +            fastboot_fail("interface name too long", response);
>>>> +            return;
>>>> +        }
>>>> +        strlcpy(interface, cmd_parameter, sizeof(interface));
>>>> +    }
>>>> +
>>>> +    if (fastboot_block_set_target(interface, device))
>>>> +        fastboot_fail("invalid interface name", response);
>>>> +    else
>>>> +        fastboot_okay(NULL, response);
>>>> +}
>>>> diff --git a/include/fastboot.h b/include/fastboot.h
>>>> index b106d617749..13dcdf919bc 100644
>>>> --- a/include/fastboot.h
>>>> +++ b/include/fastboot.h
>>>> @@ -51,6 +51,7 @@ enum {
>>>>       FASTBOOT_COMMAND_OEM_RUN,
>>>>       FASTBOOT_COMMAND_OEM_CONSOLE,
>>>>       FASTBOOT_COMMAND_OEM_BOARD,
>>>> +    FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET,
>>>>       FASTBOOT_COMMAND_ACMD,
>>>>       FASTBOOT_COMMAND_UCMD,
>>>>       FASTBOOT_COMMAND_COUNT
>>>> diff --git a/include/fb_block.h b/include/fb_block.h
>>>> index 189c708e2f0..fd981d95316 100644
>>>> --- a/include/fb_block.h
>>>> +++ b/include/fb_block.h
>>>> @@ -102,4 +102,13 @@ void fastboot_block_write_sparse_image(struct 
>>>> blk_desc *dev_desc, struct disk_pa
>>>>   void fastboot_block_flash_write(const char *part_name, void 
>>>> *download_buffer,
>>>>                   u32 download_bytes, char *response);
>>>>   +/**
>>>> + * fastboot_block_set_target() - Override block interface/device 
>>>> at runtime
>>>> + *
>>>> + * @interface: New interface name (e.g. "scsi", "mtd"), or NULL to 
>>>> leave unchanged
>>>> + * @device: New device number, or -1 to leave unchanged
>>>> + * Return: 0 on success, -EINVAL if interface name too long
>>>> + */
>>>> +int fastboot_block_set_target(const char *interface, int device);
>>>> +
>>>>   #endif // _FB_BLOCK_H_
>>>>
>>>> ---
>>>> base-commit: 4d3823469724bca19ba4ed3a5a38fc8e951775e2
>>>> change-id: 20260824-series2-fastboot-block-target-c8e9418babdf
>>>>
>>>> Best regards,
>>>> -- 
>>>> Vandhiadevan Karunamoorthy 
>>>> <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>>>>
>>>
>
--------------yVoHJy7e5Gk0tMVLCMwO3sRS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Guillaume,</p>
    <div class="moz-cite-prefix">On 9/18/2026 9:55 PM, Guillaume La
      Roque wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:34d17332-b903-479f-ba72-af02ed33c762@baylibre.com">Hi ,
      <br>
      <br>
      Thanks for clarification,
      <br>
      <br>
      Le 17/09/2026 à 19:01, Vandhiadevan Karunamoorthy a écrit :
      <br>
      <blockquote type="cite">Hi Guillaume,
        <br>
        <br>
        On 9/17/2026 5:59 PM, Guillaume La Roque wrote:
        <br>
        <blockquote type="cite">Hi,
          <br>
          <br>
          Probably a stupid question but in your commit message you
          speak about SPI-NOR  but fastboot support flash spi , why not
          enable it or update it if it's not exactly work as you want
          instead of create a new command ? </blockquote>
        <br>
        This patch is not intended to add SPI-NOR support itself. I have
        a separate change that exposes SPI-NOR through the MTD Fastboot
        backend.
        <br>
        <br>
        The purpose of this patch is to allow switching the generic
        block Fastboot backend between different storage interfaces at
        runtime. On some platforms multiple Fastboot-capable storage
        devices can coexist, for example a default SCSI/UFS device and
        an SPI-NOR device exposed through the MTD block uclass.
        <br>
      </blockquote>
      <br>
      to not create a new command it's possible to just use
      fastboot_raw_partition_*[1] variable extend it to support spi or
      block fastboot support , actually only missing part is to parse
      this variable properly to  know in which FASTBOOT_FLASH_XXX use
      it.
      <br>
      <br>
      or an other solution will be to extend series on flash[2] command
      to give possibility to select block device/interface to flash on
      flash command : for example fastboot flash mtd:0 bootloader XXX
      <br>
      <br>
      you do a lot of patch to add some new oem command on fastboot not
      sure it's always the good solution for all , just my opinion .
      <br>
      <br>
      finally you do this jsut because fastboot not work properly when
      you enable multiple FASTBOOT_FLASH_XXX Config.
      <br>
      <br>
      [1] :
<a class="moz-txt-link-freetext" href="https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors">https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors</a><br>
      <br>
      [2] :
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/">https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/</a><br>
      <br>
      <br>
      Regards,
      <br>
      Guillaume
      <br>
      <br>
    </blockquote>
    <style>a {
    text-decoration: none;
    color: #464feb;
}tr th, tr td {
    border: 1px solid #e6e6e6;
}tr th {
    background-color: #f5f5f5;
}</style>
    <div
style="font-family:'Segoe UI';font-size:14px;font-style:normal;font-weight:400;line-height:20px">
      <div data-line-index="2" class="ek5na0Uy WFF1SUlH">Thanks for the
        review and the suggestions.</div>
      <div class="aVpoNnJN" data-line-number="4"></div>
      <div data-line-index="3" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="5"></div>
      <div data-line-index="4" class="ek5na0Uy WFF1SUlH">&gt; to not
        create a new command it's possible to just use</div>
      <div class="aVpoNnJN" data-line-number="6"></div>
      <div data-line-index="5" class="ek5na0Uy WFF1SUlH">&gt;
        fastboot_raw_partition_*[1] variable extend it to support spi or</div>
      <div class="aVpoNnJN" data-line-number="7"></div>
      <div data-line-index="6" class="ek5na0Uy WFF1SUlH">&gt; block
        fastboot support</div>
      <div class="aVpoNnJN" data-line-number="8"></div>
      <div data-line-index="7" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="9"></div>
      <div data-line-index="8" class="ek5na0Uy WFF1SUlH">I had initially
        considered that direction. One challenge I ran into is</div>
      <div class="aVpoNnJN" data-line-number="10"></div>
      <div data-line-index="9" class="ek5na0Uy WFF1SUlH">that the
        current raw partition descriptor only describes an offset/size</div>
      <div class="aVpoNnJN" data-line-number="11"></div>
      <div data-line-index="10" class="ek5na0Uy WFF1SUlH">within a
        device, but it does not provide a way to identify which</div>
      <div class="aVpoNnJN" data-line-number="12"></div>
      <div data-line-index="11" class="ek5na0Uy WFF1SUlH">interface/device
        owns the partition when multiple Fastboot backends are</div>
      <div class="aVpoNnJN" data-line-number="13"></div>
      <div data-line-index="12" class="ek5na0Uy WFF1SUlH">enabled.</div>
      <div class="aVpoNnJN" data-line-number="14"></div>
      <div data-line-index="13" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="15"></div>
      <div data-line-index="14" class="ek5na0Uy WFF1SUlH">That said,
        your feedback led me to reconsider the overall approach, and</div>
      <div class="aVpoNnJN" data-line-number="16"></div>
      <div data-line-index="15" class="ek5na0Uy WFF1SUlH">the latest
        revision no longer uses the "oem set-block-target" command.</div>
      <div class="aVpoNnJN" data-line-number="17"></div>
      <div data-line-index="16" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="18"></div>
      <div data-line-index="17" class="ek5na0Uy WFF1SUlH">&gt; or an
        other solution will be to extend series on flash[2] command</div>
      <div class="aVpoNnJN" data-line-number="19"></div>
      <div data-line-index="18" class="ek5na0Uy WFF1SUlH">&gt; to give
        possibility to select block device/interface to flash on</div>
      <div class="aVpoNnJN" data-line-number="20"></div>
      <div data-line-index="19" class="ek5na0Uy WFF1SUlH">&gt; flash
        command : for example fastboot flash mtd:0 bootloader XXX</div>
      <div class="aVpoNnJN" data-line-number="21"></div>
      <div data-line-index="20" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="22"></div>
      <div data-line-index="21" class="ek5na0Uy WFF1SUlH">I agree with
        this idea. The current revision follows that direction by</div>
      <div class="aVpoNnJN" data-line-number="23"></div>
      <div data-line-index="22" class="ek5na0Uy WFF1SUlH">encoding the
        interface/device information in the partition argument</div>
      <div class="aVpoNnJN" data-line-number="24"></div>
      <div data-line-index="23" class="ek5na0Uy WFF1SUlH">itself, e.g.:</div>
      <div class="aVpoNnJN" data-line-number="25"></div>
      <div data-line-index="24" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="26"></div>
      <div data-line-index="25" class="ek5na0Uy WFF1SUlH"> fastboot
        flash mtd:0:bootloader &lt;image&gt;</div>
      <div class="aVpoNnJN" data-line-number="27"></div>
      <div data-line-index="26" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="28"></div>
      <div data-line-index="27" class="ek5na0Uy WFF1SUlH">This allows
        the request to be routed to the appropriate</div>
      <div class="aVpoNnJN" data-line-number="29"></div>
      <div data-line-index="28" class="ek5na0Uy WFF1SUlH">FASTBOOT_FLASH_*
        backend without introducing additional Fastboot state</div>
      <div class="aVpoNnJN" data-line-number="30"></div>
      <div data-line-index="29" class="ek5na0Uy WFF1SUlH">or requiring a
        separate target-selection command.</div>
      <div class="aVpoNnJN" data-line-number="31"></div>
      <div data-line-index="30" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="32"></div>
      <div data-line-index="31" class="ek5na0Uy WFF1SUlH">&gt; you do a
        lot of patch to add some new oem command on fastboot not</div>
      <div class="aVpoNnJN" data-line-number="33"></div>
      <div data-line-index="32" class="ek5na0Uy WFF1SUlH">&gt; sure it's
        always the good solution for all , just my opinion .</div>
      <div class="aVpoNnJN" data-line-number="34"></div>
      <div data-line-index="33" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="35"></div>
      <div data-line-index="34" class="ek5na0Uy WFF1SUlH">That's a fair
        comment. I agree that OEM commands should be avoided when</div>
      <div class="aVpoNnJN" data-line-number="36"></div>
      <div data-line-index="35" class="ek5na0Uy WFF1SUlH">the
        functionality can fit naturally into the existing Fastboot flow.</div>
      <div class="aVpoNnJN" data-line-number="37"></div>
      <div data-line-index="36" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="38"></div>
      <div data-line-index="37" class="ek5na0Uy WFF1SUlH">For this
        reason, the "oem set-block-target" command from the earlier</div>
      <div class="aVpoNnJN" data-line-number="39"></div>
      <div data-line-index="38" class="ek5na0Uy WFF1SUlH">revision has
        been removed in favor of the inline partition syntax.</div>
      <div class="aVpoNnJN" data-line-number="40"></div>
      <div data-line-index="39" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="41"></div>
      <div data-line-index="40" class="ek5na0Uy WFF1SUlH">&gt; finally
        you do this just because fastboot not work properly when</div>
      <div class="aVpoNnJN" data-line-number="42"></div>
      <div data-line-index="41" class="ek5na0Uy WFF1SUlH">&gt; you
        enable multiple FASTBOOT_FLASH_XXX Config.</div>
      <div class="aVpoNnJN" data-line-number="43"></div>
      <div data-line-index="42" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="44"></div>
      <div data-line-index="43" class="ek5na0Uy WFF1SUlH">Yes, that's
        the underlying motivation. With multiple</div>
      <div class="aVpoNnJN" data-line-number="45"></div>
      <div data-line-index="44" class="ek5na0Uy WFF1SUlH">FASTBOOT_FLASH_*
        backends enabled, a partition name alone is no longer</div>
      <div class="aVpoNnJN" data-line-number="46"></div>
      <div data-line-index="45" class="ek5na0Uy WFF1SUlH">sufficient to
        uniquely identify the intended target. The goal of this</div>
      <div class="aVpoNnJN" data-line-number="47"></div>
      <div data-line-index="46" class="ek5na0Uy WFF1SUlH">series is to
        provide a generic way to disambiguate the target backend</div>
      <div class="aVpoNnJN" data-line-number="48"></div>
      <div data-line-index="47" class="ek5na0Uy WFF1SUlH">and device
        while keeping the existing Fastboot workflow unchanged.</div>
      <div class="aVpoNnJN" data-line-number="49"></div>
      <div data-line-index="48" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="50"></div>
      <div data-line-index="49" class="ek5na0Uy WFF1SUlH">Thanks again
        for the feedback. It helped simplify the design</div>
      <div class="aVpoNnJN" data-line-number="51"></div>
      <div data-line-index="50" class="ek5na0Uy WFF1SUlH">considerably.</div>
      <div class="aVpoNnJN" data-line-number="52"></div>
      <div data-line-index="51" class="ek5na0Uy WFF1SUlH"> </div>
      <div class="aVpoNnJN" data-line-number="53"></div>
      <div data-line-index="52" class="ek5na0Uy WFF1SUlH">Regards,</div>
      <div class="aVpoNnJN" data-line-number="54"></div>
      <div data-line-index="53" class="ek5na0Uy WFF1SUlH">Vandhiadevan</div>
    </div>
    <br>
    <blockquote type="cite"
      cite="mid:34d17332-b903-479f-ba72-af02ed33c762@baylibre.com">
      <blockquote type="cite">
        <br>
        Today the block backend is selected through the build-time
        <br>
        CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME and
        <br>
        CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID settings, so only a single
        target
        <br>
        can be accessed during a Fastboot session. The OEM command
        allows
        <br>
        changing the active interface/device at runtime and accessing
        either
        <br>
        storage device without rebuilding or restarting Fastboot.
        <br>
        <br>
        SPI-NOR was mentioned only as an example use case for a
        runtime-selected
        <br>
        target rather than as a replacement for existing Fastboot
        SPI/MTD
        <br>
        support. <br>
        Thanks,
        <br>
        Vandhiadevan
        <br>
        ``
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Thanks
          <br>
          Guillaume
          <br>
          <br>
          Le 17/09/2026 à 11:01, Vandhiadevan Karunamoorthy a écrit :
          <br>
          <blockquote type="cite">Add fastboot_block_set_target() so an
            OEM command can point the
            <br>
            generic block fastboot backend at a different
            interface/device at
            <br>
            runtime, without requiring a rebuild. Falls back to the
            existing
            <br>
            build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME/
            <br>
            CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults when no
            override is
            <br>
            set.
            <br>
            <br>
            Expose this to fastboot clients via a new "oem
            set-block-target
            <br>
            &lt;interface&gt; [device]" command, gated behind
            <br>
            CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET (depends on
            <br>
            CONFIG_FASTBOOT_FLASH_BLOCK).
            <br>
            <br>
            This is needed to target storage devices, such as SPI-NOR
            exposed
            <br>
            through the MTD block uclass, that aren't known until
            runtime or
            <br>
            that coexist with another default block interface on the
            same
            <br>
            board.
            <br>
            <br>
            To: <a class="moz-txt-link-abbreviated" href="mailto:u-boot@lists.u-boot-project.org">u-boot@lists.u-boot-project.org</a>
            <br>
            To: <a class="moz-txt-link-abbreviated" href="mailto:u-boot@lists.denx.de">u-boot@lists.denx.de</a>
            <br>
            Cc: Mattijs Korpershoek <a class="moz-txt-link-rfc2396E" href="mailto:mkorpershoek@kernel.org">&lt;mkorpershoek@kernel.org&gt;</a>
            <br>
            Cc: Tom Rini <a class="moz-txt-link-rfc2396E" href="mailto:trini@konsulko.com">&lt;trini@konsulko.com&gt;</a>
            <br>
            Cc: Quentin Schulz <a class="moz-txt-link-rfc2396E" href="mailto:quentin.schulz@cherry.de">&lt;quentin.schulz@cherry.de&gt;</a>
            <br>
            Cc: Ilias Apalodimas <a class="moz-txt-link-rfc2396E" href="mailto:ilias.apalodimas@linaro.org">&lt;ilias.apalodimas@linaro.org&gt;</a>
            <br>
            Cc: Dmitrii Merkurev <a class="moz-txt-link-rfc2396E" href="mailto:dimorinny@google.com">&lt;dimorinny@google.com&gt;</a>
            <br>
            Cc: Balaji Selvanathan
            <a class="moz-txt-link-rfc2396E" href="mailto:balaji.selvanathan@oss.qualcomm.com">&lt;balaji.selvanathan@oss.qualcomm.com&gt;</a>
            <br>
            Cc: Adrian Freihofer <a class="moz-txt-link-rfc2396E" href="mailto:adrian.freihofer@siemens.com">&lt;adrian.freihofer@siemens.com&gt;</a>
            <br>
            Cc: Heiko Schocher <a class="moz-txt-link-rfc2396E" href="mailto:hs@nabladev.com">&lt;hs@nabladev.com&gt;</a>
            <br>
            Cc: Neil Armstrong <a class="moz-txt-link-rfc2396E" href="mailto:neil.armstrong@linaro.org">&lt;neil.armstrong@linaro.org&gt;</a>
            <br>
            <br>
            Signed-off-by: Vandhiadevan Karunamoorthy
            <a class="moz-txt-link-rfc2396E" href="mailto:vandhiadevan.karunamoorthy@oss.qualcomm.com">&lt;vandhiadevan.karunamoorthy@oss.qualcomm.com&gt;</a>
            <br>
            ---
            <br>
            This series lets a fastboot client redirect the generic
            block
            <br>
            fastboot backend (CONFIG_FASTBOOT_FLASH_BLOCK) to a
            different
            <br>
            interface/device at runtime, instead of being fixed to the
            <br>
            build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
            <br>
            CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults.
            <br>
            <br>
            This is useful for storage devices that aren't known until
            runtime,
            <br>
            or that coexist with another default block interface on the
            same
            <br>
            board -- for example, SPI-NOR exposed through the MTD block
            uclass
            <br>
            (see the companion "mtd: spi: Expose SPI-NOR as a
            GPT-capable MTD
            <br>
            block device" series).
            <br>
            <br>
            The patch adds fastboot_block_set_target() to the generic
            block
            <br>
            backend, plus a new "oem set-block-target &lt;interface&gt;
            [device]"
            <br>
            fastboot command (gated behind
            <br>
            CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET, which depends on
            <br>
            CONFIG_FASTBOOT_FLASH_BLOCK) that lets a client invoke it.
            <br>
            ---
            <br>
            Depends on: [PATCH v6 0/8] arm: snapdragon: Add snagboot
            support for Lemans-EVK
            <br>
            Link:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/u-boot/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com/">https://lore.kernel.org/u-boot/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com/</a><br>
            Depends on: [PATCH v2 0/4] fastboot: block: Add GPT/MBR and
            device selection
            <br>
            Link:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/">https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/</a><br>
            ---
            <br>
              drivers/fastboot/Kconfig      | 11 +++++++
            <br>
              drivers/fastboot/fb_block.c   | 75
            ++++++++++++++++++++++++++++++++++++-------
            <br>
              drivers/fastboot/fb_command.c | 51
            +++++++++++++++++++++++++++++
            <br>
              include/fastboot.h            |  1 +
            <br>
              include/fb_block.h            |  9 ++++++
            <br>
              5 files changed, 136 insertions(+), 11 deletions(-)
            <br>
            <br>
            diff --git a/drivers/fastboot/Kconfig
            b/drivers/fastboot/Kconfig
            <br>
            index a4539844d89..c7e0509eaad 100644
            <br>
            --- a/drivers/fastboot/Kconfig
            <br>
            +++ b/drivers/fastboot/Kconfig
            <br>
            @@ -225,6 +225,17 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
            <br>
                    Device identifiers are numbered starting from 0 and
            the most
            <br>
                    common case is to use the first controller on the
            system.
            <br>
              +config FASTBOOT_CMD_OEM_SET_BLOCK_TARGET
            <br>
            +    bool "Enable the 'oem set-block-target' command"
            <br>
            +    depends on FASTBOOT_FLASH_BLOCK
            <br>
            +    help
            <br>
            +      Add support for the "oem set-block-target" command
            from a client.
            <br>
            +      This allows switching the block interface (e.g. scsi,
            mtd) and
            <br>
            +      device number used by the fastboot "flash"/"erase"
            commands at
            <br>
            +      runtime, instead of relying solely on the
            <br>
            +      CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
            <br>
            +      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID build-time
            defaults.
            <br>
            +
            <br>
              config FASTBOOT_GPT_NAME
            <br>
                  string "Target name for updating GPT"
            <br>
                  depends on (FASTBOOT_FLASH_MMC ||
            FASTBOOT_FLASH_BLOCK) &amp;&amp; EFI_PARTITION
            <br>
            diff --git a/drivers/fastboot/fb_block.c
            b/drivers/fastboot/fb_block.c
            <br>
            index a8c74e35d0d..d3e5f6ed1f3 100644
            <br>
            --- a/drivers/fastboot/fb_block.c
            <br>
            +++ b/drivers/fastboot/fb_block.c
            <br>
            @@ -125,6 +125,66 @@ static lbaint_t
            fb_block_sparse_reserve(struct sparse_storage *info,
            <br>
                  return blkcnt;
            <br>
              }
            <br>
              +/**
            <br>
            + * block_interface_override - runtime-set block interface
            name, empty if unset
            <br>
            + */
            <br>
            +static char block_interface_override[16];
            <br>
            +/**
            <br>
            + * block_device_override - runtime-set block device number,
            -1 if unset
            <br>
            + */
            <br>
            +static int block_device_override = -1;
            <br>
            +
            <br>
            +/**
            <br>
            + * fb_block_interface() - Resolve the block interface name
            to use
            <br>
            + *
            <br>
            + * Returns the runtime override set via
            fastboot_block_set_target() if one
            <br>
            + * is active, otherwise falls back to the build-time config
            default.
            <br>
            + */
            <br>
            +static const char *fb_block_interface(void)
            <br>
            +{
            <br>
            +    if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
            <br>
            +        return NULL;
            <br>
            +
            <br>
            +    if (block_interface_override[0])
            <br>
            +        return block_interface_override;
            <br>
            +
            <br>
            +    return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
            <br>
            +                 
            CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
            <br>
            +}
            <br>
            +
            <br>
            +/**
            <br>
            + * fb_block_device() - Resolve the block device number to
            use
            <br>
            + *
            <br>
            + * Returns the runtime override set via
            fastboot_block_set_target() if one
            <br>
            + * is active, otherwise falls back to the build-time config
            default.
            <br>
            + */
            <br>
            +static int fb_block_device(void)
            <br>
            +{
            <br>
            +    if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
            <br>
            +        return -1;
            <br>
            +
            <br>
            +    if (block_device_override &gt;= 0)
            <br>
            +        return block_device_override;
            <br>
            +
            <br>
            +    return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
            <br>
            +                  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID,
            -1);
            <br>
            +}
            <br>
            +
            <br>
            +int fastboot_block_set_target(const char *interface, int
            device)
            <br>
            +{
            <br>
            +    if (interface) {
            <br>
            +        if (strlen(interface) &gt;=
            sizeof(block_interface_override))
            <br>
            +            return -EINVAL;
            <br>
            +        strlcpy(block_interface_override, interface,
            <br>
            +            sizeof(block_interface_override));
            <br>
            +    }
            <br>
            +
            <br>
            +    if (device &gt;= 0)
            <br>
            +        block_device_override = device;
            <br>
            +
            <br>
            +    return 0;
            <br>
            +}
            <br>
            +
            <br>
              /**
            <br>
               * parse_device_partition() - Parse and validate
            device:partition format
            <br>
               * @part_name: Input string in format "N:partition" or
            "partition"
            <br>
            @@ -140,8 +200,7 @@ static int parse_device_partition(const
            char *part_name, int *device,
            <br>
              {
            <br>
                  const char *colon_pos;
            <br>
              -    *device =
            config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
            <br>
            -                     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID,
            -1);
            <br>
            +    *device = fb_block_device();
            <br>
                    /* Check for colon in partition name */
            <br>
                  colon_pos = strchr(part_name, ':');
            <br>
            @@ -190,9 +249,7 @@ int fastboot_block_get_part_info(const
            char *part_name,
            <br>
                               char *response)
            <br>
              {
            <br>
                  int ret;
            <br>
            -    const char *interface =
            config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
            <br>
            - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
            <br>
            -                           NULL);
            <br>
            +    const char *interface = fb_block_interface();
            <br>
                  int device;
            <br>
                  const char *partition_name;
            <br>
              @@ -385,9 +442,7 @@ void fastboot_block_flash_write(const
            char *part_name, void *download_buffer,
            <br>
              #if CONFIG_IS_ENABLED(EFI_PARTITION)
            <br>
                  if (is_partition_table_name(part_name,
            CONFIG_FASTBOOT_GPT_NAME)) {
            <br>
                      int device;
            <br>
            -        const char *interface =
            config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
            <br>
            - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
            <br>
            -                               NULL);
            <br>
            +        const char *interface = fb_block_interface();
            <br>
                        parse_device_partition(part_name, &amp;device,
            NULL);
            <br>
                      fastboot_flash_gpt_partition_table(interface,
            device,
            <br>
            @@ -399,9 +454,7 @@ void fastboot_block_flash_write(const
            char *part_name, void *download_buffer,
            <br>
              #if CONFIG_IS_ENABLED(DOS_PARTITION)
            <br>
                  if (is_partition_table_name(part_name,
            CONFIG_FASTBOOT_MBR_NAME)) {
            <br>
                      int device;
            <br>
            -        const char *interface =
            config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
            <br>
            - CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
            <br>
            -                               NULL);
            <br>
            +        const char *interface = fb_block_interface();
            <br>
                        parse_device_partition(part_name, &amp;device,
            NULL);
            <br>
                      fastboot_flash_mbr_partition_table(interface,
            device,
            <br>
            diff --git a/drivers/fastboot/fb_command.c
            b/drivers/fastboot/fb_command.c
            <br>
            index 18d86988f4c..235fae74fee 100644
            <br>
            --- a/drivers/fastboot/fb_command.c
            <br>
            +++ b/drivers/fastboot/fb_command.c
            <br>
            @@ -45,6 +45,7 @@ static void oem_partconf(char *, char *);
            <br>
              static void oem_bootbus(char *, char *);
            <br>
              static void oem_console(char *, char *);
            <br>
              static void oem_board(char *, char *);
            <br>
            +static void oem_set_block_target(char *, char *);
            <br>
              static void run_ucmd(char *, char *);
            <br>
              static void run_acmd(char *, char *);
            <br>
              @@ -120,6 +121,11 @@ static const struct {
            <br>
                      .command = "oem board",
            <br>
                      .dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD,
            (oem_board), (NULL))
            <br>
                  },
            <br>
            +    [FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET] = {
            <br>
            +        .command = "oem set-block-target",
            <br>
            +        .dispatch =
            CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_SET_BLOCK_TARGET,
            <br>
            +                          (oem_set_block_target), (NULL))
            <br>
            +    },
            <br>
                  [FASTBOOT_COMMAND_UCMD] = {
            <br>
                      .command = "UCmd",
            <br>
                      .dispatch =
            CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
            <br>
            @@ -589,3 +595,48 @@ static void __maybe_unused
            oem_board(char *cmd_parameter, char *response)
            <br>
              {
            <br>
                  fastboot_oem_board(cmd_parameter, (void
            *)fastboot_buf_addr, image_size, response);
            <br>
              }
            <br>
            +
            <br>
            +/**
            <br>
            + * oem_set_block_target() - Execute the OEM
            set-block-target command
            <br>
            + *
            <br>
            + * @cmd_parameter: Pointer to "&lt;interface&gt; [device]"
            command parameter
            <br>
            + * @response: Pointer to fastboot response buffer
            <br>
            + *
            <br>
            + * Switches the block interface (e.g. "scsi", "mtd") and,
            optionally,
            <br>
            + * device number used by the fastboot block backend at
            runtime.
            <br>
            + */
            <br>
            +static void __maybe_unused oem_set_block_target(char
            *cmd_parameter, char *response)
            <br>
            +{
            <br>
            +    char interface[16] = { 0 };
            <br>
            +    int device = -1;
            <br>
            +    char *space;
            <br>
            +
            <br>
            +    if (!cmd_parameter) {
            <br>
            +        fastboot_fail("Expected command parameter",
            response);
            <br>
            +        return;
            <br>
            +    }
            <br>
            +
            <br>
            +    space = strchr(cmd_parameter, ' ');
            <br>
            +    if (space) {
            <br>
            +        size_t len = space - cmd_parameter;
            <br>
            +
            <br>
            +        if (len &gt;= sizeof(interface)) {
            <br>
            +            fastboot_fail("interface name too long",
            response);
            <br>
            +            return;
            <br>
            +        }
            <br>
            +        memcpy(interface, cmd_parameter, len);
            <br>
            +        interface[len] = '\0';
            <br>
            +        device = simple_strtoul(space + 1, NULL, 10);
            <br>
            +    } else {
            <br>
            +        if (strlen(cmd_parameter) &gt;= sizeof(interface))
            {
            <br>
            +            fastboot_fail("interface name too long",
            response);
            <br>
            +            return;
            <br>
            +        }
            <br>
            +        strlcpy(interface, cmd_parameter,
            sizeof(interface));
            <br>
            +    }
            <br>
            +
            <br>
            +    if (fastboot_block_set_target(interface, device))
            <br>
            +        fastboot_fail("invalid interface name", response);
            <br>
            +    else
            <br>
            +        fastboot_okay(NULL, response);
            <br>
            +}
            <br>
            diff --git a/include/fastboot.h b/include/fastboot.h
            <br>
            index b106d617749..13dcdf919bc 100644
            <br>
            --- a/include/fastboot.h
            <br>
            +++ b/include/fastboot.h
            <br>
            @@ -51,6 +51,7 @@ enum {
            <br>
                  FASTBOOT_COMMAND_OEM_RUN,
            <br>
                  FASTBOOT_COMMAND_OEM_CONSOLE,
            <br>
                  FASTBOOT_COMMAND_OEM_BOARD,
            <br>
            +    FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET,
            <br>
                  FASTBOOT_COMMAND_ACMD,
            <br>
                  FASTBOOT_COMMAND_UCMD,
            <br>
                  FASTBOOT_COMMAND_COUNT
            <br>
            diff --git a/include/fb_block.h b/include/fb_block.h
            <br>
            index 189c708e2f0..fd981d95316 100644
            <br>
            --- a/include/fb_block.h
            <br>
            +++ b/include/fb_block.h
            <br>
            @@ -102,4 +102,13 @@ void
            fastboot_block_write_sparse_image(struct blk_desc *dev_desc,
            struct disk_pa
            <br>
              void fastboot_block_flash_write(const char *part_name,
            void *download_buffer,
            <br>
                              u32 download_bytes, char *response);
            <br>
              +/**
            <br>
            + * fastboot_block_set_target() - Override block
            interface/device at runtime
            <br>
            + *
            <br>
            + * @interface: New interface name (e.g. "scsi", "mtd"), or
            NULL to leave unchanged
            <br>
            + * @device: New device number, or -1 to leave unchanged
            <br>
            + * Return: 0 on success, -EINVAL if interface name too long
            <br>
            + */
            <br>
            +int fastboot_block_set_target(const char *interface, int
            device);
            <br>
            +
            <br>
              #endif // _FB_BLOCK_H_
            <br>
            <br>
            ---
            <br>
            base-commit: 4d3823469724bca19ba4ed3a5a38fc8e951775e2
            <br>
            change-id:
            20260824-series2-fastboot-block-target-c8e9418babdf
            <br>
            <br>
            Best regards,
            <br>
            -- <br>
            Vandhiadevan Karunamoorthy
            <a class="moz-txt-link-rfc2396E" href="mailto:vandhiadevan.karunamoorthy@oss.qualcomm.com">&lt;vandhiadevan.karunamoorthy@oss.qualcomm.com&gt;</a>
            <br>
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------yVoHJy7e5Gk0tMVLCMwO3sRS--
