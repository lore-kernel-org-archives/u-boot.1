Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F3606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AqpQ5xZy;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fdW9PzwM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J1y0kfb+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E325405F9;
	Thu,  5 Nov 2026 06:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UznkMsJfmqow; Thu,  5 Nov 2026 06:33:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 16D60405AD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793860398;
	b=jA6rTIANDJSYqkldzAcvc56Wzs3+329SbZLLgrwTsAcXF5TwQr5q8tW7DDA1SE+ofZrA
	 R08LBeAFChy/Hv1NiY7RqneFHV5xMgrEiIU1jywLraTJG+ZYYeX5LX3kyx9BJ5rRv7HaG
	 beAucUaBp94U5AneAqX/eHDusNrl5mNCj51Oq51P1WD6a07DNK3eDafu9yLUw2qlT8Og+
	 IotrXWSuIuS5yGbJTPUrP8yLMbSPl6LFbI+ueQgyM7O7dlPoqXWXBWbiyYN/O/vZ4TriJ
	 x5FDPfIp7ls+tA+LOLqCdzQShi3ulI2hvV35R+rWmrYLDvyhV15DIRNSOdR2wmdFulA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793860398;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZewqcR8HF3KoYASZWhVjt5GjcaGmT0jqsh8WLmAtVbc=;
	b=DVXOkAmbHAJiI3DS4X+Xa/ovqK9/k+l9iU/kVUFjIAjptz1Lf0P0SELH+xgL5elfQMqA
	 tQI3BCbM5f69QG5W88aVeiJ4rXqmrLMp7wLA5zrNplkdCclixVTCsl2W/Ef8dkbp/rOBu
	 UfuF0ZjS83KU4Nmfme0v9dt8pN+F+nYeTwXIJTiy9EemHz/y3kSQEQQpQ9Ti7qyoSpWRw
	 tX7qq3dW6aK/zuGGAvFhhbIgH33pQoE60ft76RoSZVpj0sOVlcpTVJLLSFQe8mtY84WG7
	 ofwu56VdED9pYpGV/ScVQgFDsiydHFRWXmqN/ootZ4uuIFUQ8NxBPKMXGJzKuG1jqjQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793860398;
	bh=ZewqcR8HF3KoYASZWhVjt5GjcaGmT0jqsh8WLmAtVbc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AqpQ5xZyshr0TN1u3ER2lElwNTTVYMtC4vJySmV5Bd8OiJPJHRIXkTxeCrAZueo74
	 hfRhXjUWCCL5Bzz+D7OAhq1GYR0YOEy6BeqIpKJrw2FMlRIjBaRi9+G5vUO3Jwt668
	 /GPp4uQFwx40tS/wKDZxWizKJlMTwMtACcDdZVNkHUUnuMC7h6NJSAO2MwRTtqUVRu
	 9oimje4t9GfY98kZor1cKdl5CKJ5ANbfy5mqf0qvkHHdE1MYV8dD1H/oRfpaLzzTM7
	 gPSQjmk347oxrIZuS++vYK9KDs1s+k4FYkUhBiqZkg9Rp68++Yn8+19G8D8WjW5RVr
	 aokXjGJNx97Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16D60405AD;
	Thu,  5 Nov 2026 06:33:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E22C8B00
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCCA981094
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:33:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8imYTO1K93ZE for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 06:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B51D381082
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=fdW9PzwM; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J1y0kfb+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B51D381082
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:33:12 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56UCP6942006
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 06:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZewqcR8HF3KoYASZWhVjt5GjcaGmT0jqsh8WLmAtVbc=; b=fdW9PzwMXod7lpTP
 iQKDzt95cqaXSpahHT4BuffGSybK9g4/doseGsn9PZgX5g9TKweOmDTMTMe+kTdD
 APNr/HiqCMJ99Nx5ULyfJXH4pYvURkQBSrsatkcE3d1bYg3z+AbI7hJaLHA3JO6Z
 QK8lrvNmcS5PgOtnstpYDPaWgFplYpH7HqJVtdN4GOEc6u6JiC7JHZgqPHG5xds2
 VWmYQy7pD8V5s9mErGCGJoMXr60wCeURntFzaH7C/NoMRGa8MYGRc4atMwadO2D4
 WX9fbLUEjpAKpxfFTnuV8DWmyyIRhCfzGbKbE2fzWhyco+IueaA1L9KDv6szFoel
 wWFS7Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bj3hty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 06:33:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso2966181eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 22:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793860391; x=1794465191;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZewqcR8HF3KoYASZWhVjt5GjcaGmT0jqsh8WLmAtVbc=;
 b=J1y0kfb+ijIrvNDSfpR6hHC87ULrcoLciPL/dRrvyVNuElxa4JEAGKMiE4SivVU1A3
 ucE/HF7Gl8MzJg9zIIQyU8SnvnlItoend+OP6bRKahfUEXLDNlwZwanKJ7rj7cqvp4Bc
 hjjJCEV25jbHjDqpxXdVnbpZTR5r5rXxWUwtYkIyhHM2i0kuUEYuHN6nFisp0yQakfF/
 8HStZkAvdUMcezje3qttE1wmWj5enoxup5D2tXlKg9HlYpvfqaU+ur9gIGxQMxAQIiWi
 TT4hj+xocrxudbp8Xf4czMFqcmi/YZx6Zb9uagznlJeCduwT1oYiHxH2x4ZZ5q4KGw0S
 ZArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793860391; x=1794465191;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZewqcR8HF3KoYASZWhVjt5GjcaGmT0jqsh8WLmAtVbc=;
 b=qZobX0EEOtR0ffxO9YCdhLywz/u7ZkpsMDFPJMnXuW+lVsSWMIXj0GaOjM0Aj8wHIy
 fLtR3haUm5xtP7oOWP6WcOH+UnwUqIJPMyWMWyeM6ypXMaFL3fcUYUXiKkvD2hBQRrlg
 WZ3/OSeNixbnnPNbZ4LLTkGMxk7Dm4/4iaz2gTgYD02KNRhQPhgy3kaQrHhewDbEYRkx
 wvkmciyV2b90QI/g1Ll01f4pWlNBVA+6O2wfV1rmrvyP6Vcvh4TZ1GRQc0fBW5QVyceZ
 Xt93VwFfnT81PH7vwhB+N/FBDk7f3u6rglYDuJHXMSFhwzaFOb5cUm0HCj1JolRAETss
 JYYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNGZ9hv0PAaIiTjOkLiQgmAEUJ0aY+EbHJNZONh6+A2eDK3cHSqsfzda8LjJEI7X/rAtbuTIM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/RMR2bfZqMGc+38dTHV+TyPfnyrTRuZGYjfLpL2uIQaOn6lM/H
 NKt7JweM2aycnancO39PhW25/r6MiojI8d9mxkKJ8ipqTH0hbo8vhoH6jptUDrCOMtylCMSxGzC
 09LBedgMHni09iceKPupYI6qEVUoe0jS828nBovx5ThUyroftXMu+9UsxnClRFchVxOwDmgs=
X-Gm-Gg: AYBFou22/jzPOGxZnZRhvA4e6CKY3iXlQB518kDVqdLnjTTg1hpUQGC5egAxNhpbeMu
 N8Pc4msvHizI7gTE9ENpa7fKf5r6gOiNw4GIvPIA5UZmMd6/tjIbM4vQuoEQYXXyHgeBm0du2YJ
 /bTL8fCpQRyKbP0y69+waV7rpONwznK+q3eBGJRgImI4r4nY8oudgtDQPqisO5+J+f0aPx8R/3m
 hxyNQlmjfPh32esmYtp5rQLPJIBrPbOunPVddAsnGhiGQ/zlHLfTlUfxSYOJn9Jsm8wJ/FMHWRT
 XcaXZj9bcHs2sJU4CHlHo+XAV9NA2iS6e6iElWfuTM+so+GPPCQuYcBnLKuZDugeMmxh+6JeEa5
 pHsLisHNV1fMysShFN597hLZwLVq+IAuH664eeqnwJ0DWMmdHjRqNCsKY1IpXdpAn5ROe6+LnDf
 Me+GKefqoru5oztnAM7kTCGQ==
X-Received: by 2002:a05:7300:6d22:b0:36a:13e1:c889 with SMTP id
 5a478bee46e88-36a425e10f8mr41728191eec.36.1793860389882; 
 Wed, 04 Nov 2026 22:33:09 -0800 (PST)
X-Received: by 2002:a05:7300:6d22:b0:36a:13e1:c889 with SMTP id
 5a478bee46e88-36a425e10f8mr41728131eec.36.1793860388684; 
 Wed, 04 Nov 2026 22:33:08 -0800 (PST)
Received: from [10.152.207.127] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36d34d5960esm13101394eec.5.2026.11.04.22.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 22:33:08 -0800 (PST)
Message-ID: <eca74b5a-aaa6-47c1-8e31-98343ebd8f5e@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 12:03:02 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: Add SA8775P driver
To: Deepak G <deepak.g10@oss.qualcomm.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Michael Srba <Michael.Srba@seznam.cz>
References: <20261103-lemans-ethernet-v1-1-cb7c648e5c78@oss.qualcomm.com>
Content-Language: en-US
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
In-Reply-To: <20261103-lemans-ethernet-v1-1-cb7c648e5c78@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAyNSBTYWx0ZWRfX9xHQFCV4gWCh
 jB9tJzc+kKwgnhB5WssBo8RV4GssYUy2n1taO5xdjYMkpiY8JdtK5HRctwOfUf6G2hz708CCm5H
 fGQXKVk8ZUGMYx+vHs+GZry8OSmwTZUu5JnREdYO6PN0NLDY9KMr8cNiamphRbFG7gvjkq8URio
 XpFKrcg0CuGFWiXrV84EY3zC3+BPr49TSS5+N57J8IeeQDYWflFAxRWRosIOhqiEfBxWMXgyy8o
 zs0s7gTx4345VkqPrGR9nclwDVRbw4LEJbfQ74v9K+9XA6dYkjAJ6LrPL5eR4EF/YRWNes7AaGh
 MqouidxrZyO4FbhX5GTUeUZv1wNPG7TsKVorHZeFbXiwrevzZae7al5XgUwMWm71er/KQIZdO/D
 CBIu3k63qP4m+Sw1tJWM58HzWNoac031driHIOcSPQtfcycUVp5sxYWDwy5QjUt4Et6MU1f6XWS
 9f2bHbogFRyVbG7R4sg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAyNSBTYWx0ZWRfX7Eg26x0sgwVw
 fKrSZdJtPv/wN48PDdrr9UgQ4AnkCGt4OxMmyGH5KjMjyaqF930voi5Bz6knQ8YZeHfsJ2lKZZz
 jZPURaEBKnoXX+MHpMo3nwYIhXNGyNA=
X-Proofpoint-ORIG-GUID: dyE6-pwPfewUrPazHtK37PXHTRM6mAhE
X-Proofpoint-GUID: dyE6-pwPfewUrPazHtK37PXHTRM6mAhE
X-Authority-Analysis: v=2.4 cv=N/u8hG9B c=1 sm=1 tr=0 ts=6aec2327 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=5_9UOBq_9JQSxC8q43UA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050025
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Deepak,

Thanks for the patch. I tried it on the LeMans EVK and have two questions.

1. Node arrays (e.g. aggre1_noc_nodes[]):

The arrays are indexed by the SA8775P_* IDs (aggre1_noc_nodes[] uses 22, 
23, 52, 57, 63 to 66 and 71; qxm_qup3 is at 52).
lemans.dtsi uses the binding IDs, where MASTER_QUP_3 is 0, and 
qcom_icc_xlate() indexes xlate_nodes[] by the DT cell.
So of_icc_get(dev, "qup-memory") on spi21 got a NULL node and aborted in 
icc_path_find().
Could you check how the arrays are meant to be indexed?

2. Provider clocks:qcom_icc_rpmh_probe() does not enable the clocks in 
the provider's DT clocks property. For aggre1_noc that includes 
GCC_AGGRE_NOC_QUPV3_AXI_CLK.
On my side, QUP3 SE-DMA transfers failed until that clock was enabled.
Is enabling the provider clocks planned for this patch or for a follow-up?

Thanks,

VK

On 11/3/2026 4:10 PM, Deepak G wrote:

> Add the interconnect driver for the SA8775P SoC along with the
> Kconfig option and Makefile to build it and enable it in qcom_defconfig.
>
> Taken from 3655a63f9661 ("interconnect: qcom: add a driver for sa8775p")
>
> Signed-off-by: Deepak G <deepak.g10@oss.qualcomm.com>
> ---
>   configs/qcom_defconfig              |    1 +
>   drivers/interconnect/qcom/Kconfig   |    6 +
>   drivers/interconnect/qcom/Makefile  |    1 +
>   drivers/interconnect/qcom/sa8775p.c | 2347 +++++++++++++++++++++++++++++++++++
>   drivers/interconnect/qcom/sa8775p.h |  205 +++
>   5 files changed, 2560 insertions(+)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index e5291750aa7..38fa1fc519d 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -94,6 +94,7 @@ CONFIG_INTERCONNECT=y
>   CONFIG_INTERCONNECT_QCOM_RPMH=y
>   CONFIG_INTERCONNECT_QCOM_SC7280=y
>   CONFIG_INTERCONNECT_QCOM_SM8650=y
> +CONFIG_INTERCONNECT_QCOM_SA8775P=y
>   CONFIG_IOMMU=y
>   CONFIG_QCOM_HYP_SMMU=y
>   CONFIG_MISC=y
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 4123a1d2247..6f3f67ff1b9 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -22,3 +22,9 @@ config INTERCONNECT_QCOM_SM8650
>   	depends on INTERCONNECT_QCOM_RPMH
>   	help
>   	  Enable support for the interconnect driver for the SM8650 SoC.
> +
> +config INTERCONNECT_QCOM_SA8775P
> +	bool "Enable interconnect support for SA8775P SoC"
> +	depends on INTERCONNECT_QCOM_RPMH
> +	help
> +	  Enable support for the interconnect driver for the SA8775P SoC.
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index ac6b8cee196..84977f0b924 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_RPMH) += icc-rpmh.o bcm-voter.o
>   obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_QCS8300) += qcs8300.o
>   obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SC7280) += sc7280.o
>   obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SM8650) += sm8650.o
> +obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SA8775P) += sa8775p.o
> diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
> new file mode 100644
> index 00000000000..1d0ae65bce4
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sa8775p.c
> @@ -0,0 +1,2347 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <dm.h>
> +#include <interconnect-uclass.h>
> +#include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
> +
> +#include "icc-rpmh.h"
> +#include "sa8775p.h"
> +
> +static struct qcom_icc_node qxm_qup3 = {
> +	.name = "qxm_qup3",
> +	.id = SA8775P_MASTER_QUP_3,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_emac_0 = {
> +	.name = "xm_emac_0",
> +	.id = SA8775P_MASTER_EMAC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_emac_1 = {
> +	.name = "xm_emac_1",
> +	.id = SA8775P_MASTER_EMAC_1,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_sdc1 = {
> +	.name = "xm_sdc1",
> +	.id = SA8775P_MASTER_SDC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_ufs_mem = {
> +	.name = "xm_ufs_mem",
> +	.id = SA8775P_MASTER_UFS_MEM,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_usb2_2 = {
> +	.name = "xm_usb2_2",
> +	.id = SA8775P_MASTER_USB2,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_usb3_0 = {
> +	.name = "xm_usb3_0",
> +	.id = SA8775P_MASTER_USB3_0,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_usb3_1 = {
> +	.name = "xm_usb3_1",
> +	.id = SA8775P_MASTER_USB3_1,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qhm_qdss_bam = {
> +	.name = "qhm_qdss_bam",
> +	.id = SA8775P_MASTER_QDSS_BAM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qhm_qup0 = {
> +	.name = "qhm_qup0",
> +	.id = SA8775P_MASTER_QUP_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qhm_qup1 = {
> +	.name = "qhm_qup1",
> +	.id = SA8775P_MASTER_QUP_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qhm_qup2 = {
> +	.name = "qhm_qup2",
> +	.id = SA8775P_MASTER_QUP_2,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qnm_cnoc_datapath = {
> +	.name = "qnm_cnoc_datapath",
> +	.id = SA8775P_MASTER_CNOC_A2NOC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qxm_crypto_0 = {
> +	.name = "qxm_crypto_0",
> +	.id = SA8775P_MASTER_CRYPTO_CORE0,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qxm_crypto_1 = {
> +	.name = "qxm_crypto_1",
> +	.id = SA8775P_MASTER_CRYPTO_CORE1,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qxm_ipa = {
> +	.name = "qxm_ipa",
> +	.id = SA8775P_MASTER_IPA,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_qdss_etr_0 = {
> +	.name = "xm_qdss_etr_0",
> +	.id = SA8775P_MASTER_QDSS_ETR_0,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_qdss_etr_1 = {
> +	.name = "xm_qdss_etr_1",
> +	.id = SA8775P_MASTER_QDSS_ETR_1,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node xm_ufs_card = {
> +	.name = "xm_ufs_card",
> +	.id = SA8775P_MASTER_UFS_CARD,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qup0_core_master = {
> +	.name = "qup0_core_master",
> +	.id = SA8775P_MASTER_QUP_CORE_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_QUP_CORE_0 },
> +};
> +
> +static struct qcom_icc_node qup1_core_master = {
> +	.name = "qup1_core_master",
> +	.id = SA8775P_MASTER_QUP_CORE_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_QUP_CORE_1 },
> +};
> +
> +static struct qcom_icc_node qup2_core_master = {
> +	.name = "qup2_core_master",
> +	.id = SA8775P_MASTER_QUP_CORE_2,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_QUP_CORE_2 },
> +};
> +
> +static struct qcom_icc_node qup3_core_master = {
> +	.name = "qup3_core_master",
> +	.id = SA8775P_MASTER_QUP_CORE_3,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_QUP_CORE_3 },
> +};
> +
> +static struct qcom_icc_node qnm_gemnoc_cnoc = {
> +	.name = "qnm_gemnoc_cnoc",
> +	.id = SA8775P_MASTER_GEM_NOC_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 82,
> +	.links = { SA8775P_SLAVE_AHB2PHY_0, SA8775P_SLAVE_AHB2PHY_1,
> +		   SA8775P_SLAVE_AHB2PHY_2, SA8775P_SLAVE_AHB2PHY_3,
> +		   SA8775P_SLAVE_ANOC_THROTTLE_CFG, SA8775P_SLAVE_AOSS,
> +		   SA8775P_SLAVE_APPSS, SA8775P_SLAVE_BOOT_ROM,
> +		   SA8775P_SLAVE_CAMERA_CFG, SA8775P_SLAVE_CAMERA_NRT_THROTTLE_CFG,
> +		   SA8775P_SLAVE_CAMERA_RT_THROTTLE_CFG, SA8775P_SLAVE_CLK_CTL,
> +		   SA8775P_SLAVE_CDSP_CFG, SA8775P_SLAVE_CDSP1_CFG,
> +		   SA8775P_SLAVE_RBCPR_CX_CFG, SA8775P_SLAVE_RBCPR_MMCX_CFG,
> +		   SA8775P_SLAVE_RBCPR_MX_CFG, SA8775P_SLAVE_CPR_NSPCX,
> +		   SA8775P_SLAVE_CRYPTO_0_CFG, SA8775P_SLAVE_CX_RDPM,
> +		   SA8775P_SLAVE_DISPLAY_CFG, SA8775P_SLAVE_DISPLAY_RT_THROTTLE_CFG,
> +		   SA8775P_SLAVE_DISPLAY1_CFG, SA8775P_SLAVE_DISPLAY1_RT_THROTTLE_CFG,
> +		   SA8775P_SLAVE_EMAC_CFG, SA8775P_SLAVE_EMAC1_CFG,
> +		   SA8775P_SLAVE_GP_DSP0_CFG, SA8775P_SLAVE_GP_DSP1_CFG,
> +		   SA8775P_SLAVE_GPDSP0_THROTTLE_CFG, SA8775P_SLAVE_GPDSP1_THROTTLE_CFG,
> +		   SA8775P_SLAVE_GPU_TCU_THROTTLE_CFG, SA8775P_SLAVE_GFX3D_CFG,
> +		   SA8775P_SLAVE_HWKM, SA8775P_SLAVE_IMEM_CFG,
> +		   SA8775P_SLAVE_IPA_CFG, SA8775P_SLAVE_IPC_ROUTER_CFG,
> +		   SA8775P_SLAVE_LPASS, SA8775P_SLAVE_LPASS_THROTTLE_CFG,
> +		   SA8775P_SLAVE_MX_RDPM, SA8775P_SLAVE_MXC_RDPM,
> +		   SA8775P_SLAVE_PCIE_0_CFG, SA8775P_SLAVE_PCIE_1_CFG,
> +		   SA8775P_SLAVE_PCIE_RSC_CFG, SA8775P_SLAVE_PCIE_TCU_THROTTLE_CFG,
> +		   SA8775P_SLAVE_PCIE_THROTTLE_CFG, SA8775P_SLAVE_PDM,
> +		   SA8775P_SLAVE_PIMEM_CFG, SA8775P_SLAVE_PKA_WRAPPER_CFG,
> +		   SA8775P_SLAVE_QDSS_CFG, SA8775P_SLAVE_QM_CFG,
> +		   SA8775P_SLAVE_QM_MPU_CFG, SA8775P_SLAVE_QUP_0,
> +		   SA8775P_SLAVE_QUP_1, SA8775P_SLAVE_QUP_2,
> +		   SA8775P_SLAVE_QUP_3, SA8775P_SLAVE_SAIL_THROTTLE_CFG,
> +		   SA8775P_SLAVE_SDC1, SA8775P_SLAVE_SECURITY,
> +		   SA8775P_SLAVE_SNOC_THROTTLE_CFG, SA8775P_SLAVE_TCSR,
> +		   SA8775P_SLAVE_TLMM, SA8775P_SLAVE_TSC_CFG,
> +		   SA8775P_SLAVE_UFS_CARD_CFG, SA8775P_SLAVE_UFS_MEM_CFG,
> +		   SA8775P_SLAVE_USB2, SA8775P_SLAVE_USB3_0,
> +		   SA8775P_SLAVE_USB3_1, SA8775P_SLAVE_VENUS_CFG,
> +		   SA8775P_SLAVE_VENUS_CVP_THROTTLE_CFG, SA8775P_SLAVE_VENUS_V_CPU_THROTTLE_CFG,
> +		   SA8775P_SLAVE_VENUS_VCODEC_THROTTLE_CFG, SA8775P_SLAVE_DDRSS_CFG,
> +		   SA8775P_SLAVE_GPDSP_NOC_CFG, SA8775P_SLAVE_CNOC_MNOC_HF_CFG,
> +		   SA8775P_SLAVE_CNOC_MNOC_SF_CFG, SA8775P_SLAVE_PCIE_ANOC_CFG,
> +		   SA8775P_SLAVE_SNOC_CFG, SA8775P_SLAVE_BOOT_IMEM,
> +		   SA8775P_SLAVE_IMEM, SA8775P_SLAVE_PIMEM,
> +		   SA8775P_SLAVE_QDSS_STM, SA8775P_SLAVE_TCU },
> +};
> +
> +static struct qcom_icc_node qnm_gemnoc_pcie = {
> +	.name = "qnm_gemnoc_pcie",
> +	.id = SA8775P_MASTER_GEM_NOC_PCIE_SNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_PCIE_0, SA8775P_SLAVE_PCIE_1 },
> +};
> +
> +static struct qcom_icc_node qnm_cnoc_dc_noc = {
> +	.name = "qnm_cnoc_dc_noc",
> +	.id = SA8775P_MASTER_CNOC_DC_NOC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_LLCC_CFG, SA8775P_SLAVE_GEM_NOC_CFG },
> +};
> +
> +static struct qcom_icc_node alm_gpu_tcu = {
> +	.name = "alm_gpu_tcu",
> +	.id = SA8775P_MASTER_GPU_TCU,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node alm_pcie_tcu = {
> +	.name = "alm_pcie_tcu",
> +	.id = SA8775P_MASTER_PCIE_TCU,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node alm_sys_tcu = {
> +	.name = "alm_sys_tcu",
> +	.id = SA8775P_MASTER_SYS_TCU,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node chm_apps = {
> +	.name = "chm_apps",
> +	.id = SA8775P_MASTER_APPSS_PROC,
> +	.channels = 4,
> +	.buswidth = 32,
> +	.num_links = 3,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC,
> +		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC },
> +};
> +
> +static struct qcom_icc_node qnm_cmpnoc0 = {
> +	.name = "qnm_cmpnoc0",
> +	.id = SA8775P_MASTER_COMPUTE_NOC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node qnm_cmpnoc1 = {
> +	.name = "qnm_cmpnoc1",
> +	.id = SA8775P_MASTER_COMPUTE_NOC_1,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node qnm_gemnoc_cfg = {
> +	.name = "qnm_gemnoc_cfg",
> +	.id = SA8775P_MASTER_GEM_NOC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 4,
> +	.links = { SA8775P_SLAVE_SERVICE_GEM_NOC_1, SA8775P_SLAVE_SERVICE_GEM_NOC_2,
> +		   SA8775P_SLAVE_SERVICE_GEM_NOC, SA8775P_SLAVE_SERVICE_GEM_NOC2 },
> +};
> +
> +static struct qcom_icc_node qnm_gpdsp_sail = {
> +	.name = "qnm_gpdsp_sail",
> +	.id = SA8775P_MASTER_GPDSP_SAIL,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node qnm_gpu = {
> +	.name = "qnm_gpu",
> +	.id = SA8775P_MASTER_GFX3D,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node qnm_mnoc_hf = {
> +	.name = "qnm_mnoc_hf",
> +	.id = SA8775P_MASTER_MNOC_HF_MEM_NOC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_LLCC, SA8775P_SLAVE_GEM_NOC_PCIE_CNOC },
> +};
> +
> +static struct qcom_icc_node qnm_mnoc_sf = {
> +	.name = "qnm_mnoc_sf",
> +	.id = SA8775P_MASTER_MNOC_SF_MEM_NOC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 3,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC,
> +		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC },
> +};
> +
> +static struct qcom_icc_node qnm_pcie = {
> +	.name = "qnm_pcie",
> +	.id = SA8775P_MASTER_ANOC_PCIE_GEM_NOC,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node qnm_snoc_gc = {
> +	.name = "qnm_snoc_gc",
> +	.id = SA8775P_MASTER_SNOC_GC_MEM_NOC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node qnm_snoc_sf = {
> +	.name = "qnm_snoc_sf",
> +	.id = SA8775P_MASTER_SNOC_SF_MEM_NOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 3,
> +	.links = { SA8775P_SLAVE_GEM_NOC_CNOC, SA8775P_SLAVE_LLCC,
> +		   SA8775P_SLAVE_GEM_NOC_PCIE_CNOC },
> +};
> +
> +static struct qcom_icc_node qxm_dsp0 = {
> +	.name = "qxm_dsp0",
> +	.id = SA8775P_MASTER_DSP0,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_GP_DSP_SAIL_NOC },
> +};
> +
> +static struct qcom_icc_node qxm_dsp1 = {
> +	.name = "qxm_dsp1",
> +	.id = SA8775P_MASTER_DSP1,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_GP_DSP_SAIL_NOC },
> +};
> +
> +static struct qcom_icc_node qhm_config_noc = {
> +	.name = "qhm_config_noc",
> +	.id = SA8775P_MASTER_CNOC_LPASS_AG_NOC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 6,
> +	.links = { SA8775P_SLAVE_LPASS_CORE_CFG, SA8775P_SLAVE_LPASS_LPI_CFG,
> +		   SA8775P_SLAVE_LPASS_MPU_CFG, SA8775P_SLAVE_LPASS_TOP_CFG,
> +		   SA8775P_SLAVE_SERVICES_LPASS_AML_NOC, SA8775P_SLAVE_SERVICE_LPASS_AG_NOC },
> +};
> +
> +static struct qcom_icc_node qxm_lpass_dsp = {
> +	.name = "qxm_lpass_dsp",
> +	.id = SA8775P_MASTER_LPASS_PROC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 4,
> +	.links = { SA8775P_SLAVE_LPASS_TOP_CFG, SA8775P_SLAVE_LPASS_SNOC,
> +		   SA8775P_SLAVE_SERVICES_LPASS_AML_NOC, SA8775P_SLAVE_SERVICE_LPASS_AG_NOC },
> +};
> +
> +static struct qcom_icc_node llcc_mc = {
> +	.name = "llcc_mc",
> +	.id = SA8775P_MASTER_LLCC,
> +	.channels = 8,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_EBI1 },
> +};
> +
> +static struct qcom_icc_node qnm_camnoc_hf = {
> +	.name = "qnm_camnoc_hf",
> +	.id = SA8775P_MASTER_CAMNOC_HF,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_camnoc_icp = {
> +	.name = "qnm_camnoc_icp",
> +	.id = SA8775P_MASTER_CAMNOC_ICP,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_camnoc_sf = {
> +	.name = "qnm_camnoc_sf",
> +	.id = SA8775P_MASTER_CAMNOC_SF,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_mdp0_0 = {
> +	.name = "qnm_mdp0_0",
> +	.id = SA8775P_MASTER_MDP0,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_mdp0_1 = {
> +	.name = "qnm_mdp0_1",
> +	.id = SA8775P_MASTER_MDP1,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_mdp1_0 = {
> +	.name = "qnm_mdp1_0",
> +	.id = SA8775P_MASTER_MDP_CORE1_0,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_mdp1_1 = {
> +	.name = "qnm_mdp1_1",
> +	.id = SA8775P_MASTER_MDP_CORE1_1,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_HF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_mnoc_hf_cfg = {
> +	.name = "qnm_mnoc_hf_cfg",
> +	.id = SA8775P_MASTER_CNOC_MNOC_HF_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SERVICE_MNOC_HF },
> +};
> +
> +static struct qcom_icc_node qnm_mnoc_sf_cfg = {
> +	.name = "qnm_mnoc_sf_cfg",
> +	.id = SA8775P_MASTER_CNOC_MNOC_SF_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SERVICE_MNOC_SF },
> +};
> +
> +static struct qcom_icc_node qnm_video0 = {
> +	.name = "qnm_video0",
> +	.id = SA8775P_MASTER_VIDEO_P0,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_video1 = {
> +	.name = "qnm_video1",
> +	.id = SA8775P_MASTER_VIDEO_P1,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_video_cvp = {
> +	.name = "qnm_video_cvp",
> +	.id = SA8775P_MASTER_VIDEO_PROC,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_video_v_cpu = {
> +	.name = "qnm_video_v_cpu",
> +	.id = SA8775P_MASTER_VIDEO_V_PROC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_MNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qhm_nsp_noc_config = {
> +	.name = "qhm_nsp_noc_config",
> +	.id = SA8775P_MASTER_CDSP_NOC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SERVICE_NSP_NOC },
> +};
> +
> +static struct qcom_icc_node qxm_nsp = {
> +	.name = "qxm_nsp",
> +	.id = SA8775P_MASTER_CDSP_PROC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_HCP_A, SA8775P_SLAVE_CDSP_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qhm_nspb_noc_config = {
> +	.name = "qhm_nspb_noc_config",
> +	.id = SA8775P_MASTER_CDSPB_NOC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SERVICE_NSPB_NOC },
> +};
> +
> +static struct qcom_icc_node qxm_nspb = {
> +	.name = "qxm_nspb",
> +	.id = SA8775P_MASTER_CDSP_PROC_B,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 2,
> +	.links = { SA8775P_SLAVE_HCP_B, SA8775P_SLAVE_CDSPB_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node xm_pcie3_0 = {
> +	.name = "xm_pcie3_0",
> +	.id = SA8775P_MASTER_PCIE_0,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_ANOC_PCIE_GEM_NOC },
> +};
> +
> +static struct qcom_icc_node xm_pcie3_1 = {
> +	.name = "xm_pcie3_1",
> +	.id = SA8775P_MASTER_PCIE_1,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_ANOC_PCIE_GEM_NOC },
> +};
> +
> +static struct qcom_icc_node qhm_gic = {
> +	.name = "qhm_gic",
> +	.id = SA8775P_MASTER_GIC_AHB,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node qnm_aggre1_noc = {
> +	.name = "qnm_aggre1_noc",
> +	.id = SA8775P_MASTER_A1NOC_SNOC,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node qnm_aggre2_noc = {
> +	.name = "qnm_aggre2_noc",
> +	.id = SA8775P_MASTER_A2NOC_SNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node qnm_lpass_noc = {
> +	.name = "qnm_lpass_noc",
> +	.id = SA8775P_MASTER_LPASS_ANOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node qnm_snoc_cfg = {
> +	.name = "qnm_snoc_cfg",
> +	.id = SA8775P_MASTER_SNOC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SERVICE_SNOC },
> +};
> +
> +static struct qcom_icc_node qxm_pimem = {
> +	.name = "qxm_pimem",
> +	.id = SA8775P_MASTER_PIMEM,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_GC },
> +};
> +
> +static struct qcom_icc_node xm_gic = {
> +	.name = "xm_gic",
> +	.id = SA8775P_MASTER_GIC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_SLAVE_SNOC_GEM_NOC_GC },
> +};
> +
> +static struct qcom_icc_node qns_a1noc_snoc = {
> +	.name = "qns_a1noc_snoc",
> +	.id = SA8775P_SLAVE_A1NOC_SNOC,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qns_a2noc_snoc = {
> +	.name = "qns_a2noc_snoc",
> +	.id = SA8775P_SLAVE_A2NOC_SNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_A2NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qup0_core_slave = {
> +	.name = "qup0_core_slave",
> +	.id = SA8775P_SLAVE_QUP_CORE_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qup1_core_slave = {
> +	.name = "qup1_core_slave",
> +	.id = SA8775P_SLAVE_QUP_CORE_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qup2_core_slave = {
> +	.name = "qup2_core_slave",
> +	.id = SA8775P_SLAVE_QUP_CORE_2,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qup3_core_slave = {
> +	.name = "qup3_core_slave",
> +	.id = SA8775P_SLAVE_QUP_CORE_3,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ahb2phy0 = {
> +	.name = "qhs_ahb2phy0",
> +	.id = SA8775P_SLAVE_AHB2PHY_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ahb2phy1 = {
> +	.name = "qhs_ahb2phy1",
> +	.id = SA8775P_SLAVE_AHB2PHY_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ahb2phy2 = {
> +	.name = "qhs_ahb2phy2",
> +	.id = SA8775P_SLAVE_AHB2PHY_2,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ahb2phy3 = {
> +	.name = "qhs_ahb2phy3",
> +	.id = SA8775P_SLAVE_AHB2PHY_3,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_anoc_throttle_cfg = {
> +	.name = "qhs_anoc_throttle_cfg",
> +	.id = SA8775P_SLAVE_ANOC_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_aoss = {
> +	.name = "qhs_aoss",
> +	.id = SA8775P_SLAVE_AOSS,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_apss = {
> +	.name = "qhs_apss",
> +	.id = SA8775P_SLAVE_APPSS,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_boot_rom = {
> +	.name = "qhs_boot_rom",
> +	.id = SA8775P_SLAVE_BOOT_ROM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_camera_cfg = {
> +	.name = "qhs_camera_cfg",
> +	.id = SA8775P_SLAVE_CAMERA_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_camera_nrt_throttle_cfg = {
> +	.name = "qhs_camera_nrt_throttle_cfg",
> +	.id = SA8775P_SLAVE_CAMERA_NRT_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_camera_rt_throttle_cfg = {
> +	.name = "qhs_camera_rt_throttle_cfg",
> +	.id = SA8775P_SLAVE_CAMERA_RT_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_clk_ctl = {
> +	.name = "qhs_clk_ctl",
> +	.id = SA8775P_SLAVE_CLK_CTL,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_compute0_cfg = {
> +	.name = "qhs_compute0_cfg",
> +	.id = SA8775P_SLAVE_CDSP_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_CDSP_NOC_CFG },
> +};
> +
> +static struct qcom_icc_node qhs_compute1_cfg = {
> +	.name = "qhs_compute1_cfg",
> +	.id = SA8775P_SLAVE_CDSP1_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_CDSPB_NOC_CFG },
> +};
> +
> +static struct qcom_icc_node qhs_cpr_cx = {
> +	.name = "qhs_cpr_cx",
> +	.id = SA8775P_SLAVE_RBCPR_CX_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_cpr_mmcx = {
> +	.name = "qhs_cpr_mmcx",
> +	.id = SA8775P_SLAVE_RBCPR_MMCX_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_cpr_mx = {
> +	.name = "qhs_cpr_mx",
> +	.id = SA8775P_SLAVE_RBCPR_MX_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_cpr_nspcx = {
> +	.name = "qhs_cpr_nspcx",
> +	.id = SA8775P_SLAVE_CPR_NSPCX,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_crypto0_cfg = {
> +	.name = "qhs_crypto0_cfg",
> +	.id = SA8775P_SLAVE_CRYPTO_0_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_cx_rdpm = {
> +	.name = "qhs_cx_rdpm",
> +	.id = SA8775P_SLAVE_CX_RDPM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_display0_cfg = {
> +	.name = "qhs_display0_cfg",
> +	.id = SA8775P_SLAVE_DISPLAY_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_display0_rt_throttle_cfg = {
> +	.name = "qhs_display0_rt_throttle_cfg",
> +	.id = SA8775P_SLAVE_DISPLAY_RT_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_display1_cfg = {
> +	.name = "qhs_display1_cfg",
> +	.id = SA8775P_SLAVE_DISPLAY1_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_display1_rt_throttle_cfg = {
> +	.name = "qhs_display1_rt_throttle_cfg",
> +	.id = SA8775P_SLAVE_DISPLAY1_RT_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_emac0_cfg = {
> +	.name = "qhs_emac0_cfg",
> +	.id = SA8775P_SLAVE_EMAC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_emac1_cfg = {
> +	.name = "qhs_emac1_cfg",
> +	.id = SA8775P_SLAVE_EMAC1_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_gp_dsp0_cfg = {
> +	.name = "qhs_gp_dsp0_cfg",
> +	.id = SA8775P_SLAVE_GP_DSP0_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_gp_dsp1_cfg = {
> +	.name = "qhs_gp_dsp1_cfg",
> +	.id = SA8775P_SLAVE_GP_DSP1_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_gpdsp0_throttle_cfg = {
> +	.name = "qhs_gpdsp0_throttle_cfg",
> +	.id = SA8775P_SLAVE_GPDSP0_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_gpdsp1_throttle_cfg = {
> +	.name = "qhs_gpdsp1_throttle_cfg",
> +	.id = SA8775P_SLAVE_GPDSP1_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_gpu_tcu_throttle_cfg = {
> +	.name = "qhs_gpu_tcu_throttle_cfg",
> +	.id = SA8775P_SLAVE_GPU_TCU_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_gpuss_cfg = {
> +	.name = "qhs_gpuss_cfg",
> +	.id = SA8775P_SLAVE_GFX3D_CFG,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_hwkm = {
> +	.name = "qhs_hwkm",
> +	.id = SA8775P_SLAVE_HWKM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_imem_cfg = {
> +	.name = "qhs_imem_cfg",
> +	.id = SA8775P_SLAVE_IMEM_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ipa = {
> +	.name = "qhs_ipa",
> +	.id = SA8775P_SLAVE_IPA_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ipc_router = {
> +	.name = "qhs_ipc_router",
> +	.id = SA8775P_SLAVE_IPC_ROUTER_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_lpass_cfg = {
> +	.name = "qhs_lpass_cfg",
> +	.id = SA8775P_SLAVE_LPASS,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_CNOC_LPASS_AG_NOC },
> +};
> +
> +static struct qcom_icc_node qhs_lpass_throttle_cfg = {
> +	.name = "qhs_lpass_throttle_cfg",
> +	.id = SA8775P_SLAVE_LPASS_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_mx_rdpm = {
> +	.name = "qhs_mx_rdpm",
> +	.id = SA8775P_SLAVE_MX_RDPM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_mxc_rdpm = {
> +	.name = "qhs_mxc_rdpm",
> +	.id = SA8775P_SLAVE_MXC_RDPM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pcie0_cfg = {
> +	.name = "qhs_pcie0_cfg",
> +	.id = SA8775P_SLAVE_PCIE_0_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pcie1_cfg = {
> +	.name = "qhs_pcie1_cfg",
> +	.id = SA8775P_SLAVE_PCIE_1_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pcie_rsc_cfg = {
> +	.name = "qhs_pcie_rsc_cfg",
> +	.id = SA8775P_SLAVE_PCIE_RSC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pcie_tcu_throttle_cfg = {
> +	.name = "qhs_pcie_tcu_throttle_cfg",
> +	.id = SA8775P_SLAVE_PCIE_TCU_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pcie_throttle_cfg = {
> +	.name = "qhs_pcie_throttle_cfg",
> +	.id = SA8775P_SLAVE_PCIE_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pdm = {
> +	.name = "qhs_pdm",
> +	.id = SA8775P_SLAVE_PDM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pimem_cfg = {
> +	.name = "qhs_pimem_cfg",
> +	.id = SA8775P_SLAVE_PIMEM_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_pke_wrapper_cfg = {
> +	.name = "qhs_pke_wrapper_cfg",
> +	.id = SA8775P_SLAVE_PKA_WRAPPER_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qdss_cfg = {
> +	.name = "qhs_qdss_cfg",
> +	.id = SA8775P_SLAVE_QDSS_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qm_cfg = {
> +	.name = "qhs_qm_cfg",
> +	.id = SA8775P_SLAVE_QM_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qm_mpu_cfg = {
> +	.name = "qhs_qm_mpu_cfg",
> +	.id = SA8775P_SLAVE_QM_MPU_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qup0 = {
> +	.name = "qhs_qup0",
> +	.id = SA8775P_SLAVE_QUP_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qup1 = {
> +	.name = "qhs_qup1",
> +	.id = SA8775P_SLAVE_QUP_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qup2 = {
> +	.name = "qhs_qup2",
> +	.id = SA8775P_SLAVE_QUP_2,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_qup3 = {
> +	.name = "qhs_qup3",
> +	.id = SA8775P_SLAVE_QUP_3,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_sail_throttle_cfg = {
> +	.name = "qhs_sail_throttle_cfg",
> +	.id = SA8775P_SLAVE_SAIL_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_sdc1 = {
> +	.name = "qhs_sdc1",
> +	.id = SA8775P_SLAVE_SDC1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_security = {
> +	.name = "qhs_security",
> +	.id = SA8775P_SLAVE_SECURITY,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_snoc_throttle_cfg = {
> +	.name = "qhs_snoc_throttle_cfg",
> +	.id = SA8775P_SLAVE_SNOC_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_tcsr = {
> +	.name = "qhs_tcsr",
> +	.id = SA8775P_SLAVE_TCSR,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_tlmm = {
> +	.name = "qhs_tlmm",
> +	.id = SA8775P_SLAVE_TLMM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_tsc_cfg = {
> +	.name = "qhs_tsc_cfg",
> +	.id = SA8775P_SLAVE_TSC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ufs_card_cfg = {
> +	.name = "qhs_ufs_card_cfg",
> +	.id = SA8775P_SLAVE_UFS_CARD_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_ufs_mem_cfg = {
> +	.name = "qhs_ufs_mem_cfg",
> +	.id = SA8775P_SLAVE_UFS_MEM_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_usb2_0 = {
> +	.name = "qhs_usb2_0",
> +	.id = SA8775P_SLAVE_USB2,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_usb3_0 = {
> +	.name = "qhs_usb3_0",
> +	.id = SA8775P_SLAVE_USB3_0,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_usb3_1 = {
> +	.name = "qhs_usb3_1",
> +	.id = SA8775P_SLAVE_USB3_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_venus_cfg = {
> +	.name = "qhs_venus_cfg",
> +	.id = SA8775P_SLAVE_VENUS_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_venus_cvp_throttle_cfg = {
> +	.name = "qhs_venus_cvp_throttle_cfg",
> +	.id = SA8775P_SLAVE_VENUS_CVP_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_venus_v_cpu_throttle_cfg = {
> +	.name = "qhs_venus_v_cpu_throttle_cfg",
> +	.id = SA8775P_SLAVE_VENUS_V_CPU_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_venus_vcodec_throttle_cfg = {
> +	.name = "qhs_venus_vcodec_throttle_cfg",
> +	.id = SA8775P_SLAVE_VENUS_VCODEC_THROTTLE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_ddrss_cfg = {
> +	.name = "qns_ddrss_cfg",
> +	.id = SA8775P_SLAVE_DDRSS_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_CNOC_DC_NOC },
> +};
> +
> +static struct qcom_icc_node qns_gpdsp_noc_cfg = {
> +	.name = "qns_gpdsp_noc_cfg",
> +	.id = SA8775P_SLAVE_GPDSP_NOC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_mnoc_hf_cfg = {
> +	.name = "qns_mnoc_hf_cfg",
> +	.id = SA8775P_SLAVE_CNOC_MNOC_HF_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_CNOC_MNOC_HF_CFG },
> +};
> +
> +static struct qcom_icc_node qns_mnoc_sf_cfg = {
> +	.name = "qns_mnoc_sf_cfg",
> +	.id = SA8775P_SLAVE_CNOC_MNOC_SF_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_CNOC_MNOC_SF_CFG },
> +};
> +
> +static struct qcom_icc_node qns_pcie_anoc_cfg = {
> +	.name = "qns_pcie_anoc_cfg",
> +	.id = SA8775P_SLAVE_PCIE_ANOC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_snoc_cfg = {
> +	.name = "qns_snoc_cfg",
> +	.id = SA8775P_SLAVE_SNOC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_SNOC_CFG },
> +};
> +
> +static struct qcom_icc_node qxs_boot_imem = {
> +	.name = "qxs_boot_imem",
> +	.id = SA8775P_SLAVE_BOOT_IMEM,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qxs_imem = {
> +	.name = "qxs_imem",
> +	.id = SA8775P_SLAVE_IMEM,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qxs_pimem = {
> +	.name = "qxs_pimem",
> +	.id = SA8775P_SLAVE_PIMEM,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node xs_pcie_0 = {
> +	.name = "xs_pcie_0",
> +	.id = SA8775P_SLAVE_PCIE_0,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node xs_pcie_1 = {
> +	.name = "xs_pcie_1",
> +	.id = SA8775P_SLAVE_PCIE_1,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node xs_qdss_stm = {
> +	.name = "xs_qdss_stm",
> +	.id = SA8775P_SLAVE_QDSS_STM,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node xs_sys_tcu_cfg = {
> +	.name = "xs_sys_tcu_cfg",
> +	.id = SA8775P_SLAVE_TCU,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_llcc = {
> +	.name = "qhs_llcc",
> +	.id = SA8775P_SLAVE_LLCC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_gemnoc = {
> +	.name = "qns_gemnoc",
> +	.id = SA8775P_SLAVE_GEM_NOC_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_GEM_NOC_CFG },
> +};
> +
> +static struct qcom_icc_node qns_gem_noc_cnoc = {
> +	.name = "qns_gem_noc_cnoc",
> +	.id = SA8775P_SLAVE_GEM_NOC_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_GEM_NOC_CNOC },
> +};
> +
> +static struct qcom_icc_node qns_llcc = {
> +	.name = "qns_llcc",
> +	.id = SA8775P_SLAVE_LLCC,
> +	.channels = 6,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_LLCC },
> +};
> +
> +static struct qcom_icc_node qns_pcie = {
> +	.name = "qns_pcie",
> +	.id = SA8775P_SLAVE_GEM_NOC_PCIE_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_GEM_NOC_PCIE_SNOC },
> +};
> +
> +static struct qcom_icc_node srvc_even_gemnoc = {
> +	.name = "srvc_even_gemnoc",
> +	.id = SA8775P_SLAVE_SERVICE_GEM_NOC_1,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node srvc_odd_gemnoc = {
> +	.name = "srvc_odd_gemnoc",
> +	.id = SA8775P_SLAVE_SERVICE_GEM_NOC_2,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node srvc_sys_gemnoc = {
> +	.name = "srvc_sys_gemnoc",
> +	.id = SA8775P_SLAVE_SERVICE_GEM_NOC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node srvc_sys_gemnoc_2 = {
> +	.name = "srvc_sys_gemnoc_2",
> +	.id = SA8775P_SLAVE_SERVICE_GEM_NOC2,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_gp_dsp_sail_noc = {
> +	.name = "qns_gp_dsp_sail_noc",
> +	.id = SA8775P_SLAVE_GP_DSP_SAIL_NOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_GPDSP_SAIL },
> +};
> +
> +static struct qcom_icc_node qhs_lpass_core = {
> +	.name = "qhs_lpass_core",
> +	.id = SA8775P_SLAVE_LPASS_CORE_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_lpass_lpi = {
> +	.name = "qhs_lpass_lpi",
> +	.id = SA8775P_SLAVE_LPASS_LPI_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_lpass_mpu = {
> +	.name = "qhs_lpass_mpu",
> +	.id = SA8775P_SLAVE_LPASS_MPU_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qhs_lpass_top = {
> +	.name = "qhs_lpass_top",
> +	.id = SA8775P_SLAVE_LPASS_TOP_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_sysnoc = {
> +	.name = "qns_sysnoc",
> +	.id = SA8775P_SLAVE_LPASS_SNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_LPASS_ANOC },
> +};
> +
> +static struct qcom_icc_node srvc_niu_aml_noc = {
> +	.name = "srvc_niu_aml_noc",
> +	.id = SA8775P_SLAVE_SERVICES_LPASS_AML_NOC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node srvc_niu_lpass_agnoc = {
> +	.name = "srvc_niu_lpass_agnoc",
> +	.id = SA8775P_SLAVE_SERVICE_LPASS_AG_NOC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node ebi = {
> +	.name = "ebi",
> +	.id = SA8775P_SLAVE_EBI1,
> +	.channels = 8,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_mem_noc_hf = {
> +	.name = "qns_mem_noc_hf",
> +	.id = SA8775P_SLAVE_MNOC_HF_MEM_NOC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_MNOC_HF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qns_mem_noc_sf = {
> +	.name = "qns_mem_noc_sf",
> +	.id = SA8775P_SLAVE_MNOC_SF_MEM_NOC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_MNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node srvc_mnoc_hf = {
> +	.name = "srvc_mnoc_hf",
> +	.id = SA8775P_SLAVE_SERVICE_MNOC_HF,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node srvc_mnoc_sf = {
> +	.name = "srvc_mnoc_sf",
> +	.id = SA8775P_SLAVE_SERVICE_MNOC_SF,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_hcp = {
> +	.name = "qns_hcp",
> +	.id = SA8775P_SLAVE_HCP_A,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_nsp_gemnoc = {
> +	.name = "qns_nsp_gemnoc",
> +	.id = SA8775P_SLAVE_CDSP_MEM_NOC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_COMPUTE_NOC },
> +};
> +
> +static struct qcom_icc_node service_nsp_noc = {
> +	.name = "service_nsp_noc",
> +	.id = SA8775P_SLAVE_SERVICE_NSP_NOC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_nspb_gemnoc = {
> +	.name = "qns_nspb_gemnoc",
> +	.id = SA8775P_SLAVE_CDSPB_MEM_NOC,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_COMPUTE_NOC_1 },
> +};
> +
> +static struct qcom_icc_node qns_nspb_hcp = {
> +	.name = "qns_nspb_hcp",
> +	.id = SA8775P_SLAVE_HCP_B,
> +	.channels = 2,
> +	.buswidth = 32,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node service_nspb_noc = {
> +	.name = "service_nspb_noc",
> +	.id = SA8775P_SLAVE_SERVICE_NSPB_NOC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qns_pcie_mem_noc = {
> +	.name = "qns_pcie_mem_noc",
> +	.id = SA8775P_SLAVE_ANOC_PCIE_GEM_NOC,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_ANOC_PCIE_GEM_NOC },
> +};
> +
> +static struct qcom_icc_node qns_gemnoc_gc = {
> +	.name = "qns_gemnoc_gc",
> +	.id = SA8775P_SLAVE_SNOC_GEM_NOC_GC,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_SNOC_GC_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qns_gemnoc_sf = {
> +	.name = "qns_gemnoc_sf",
> +	.id = SA8775P_SLAVE_SNOC_GEM_NOC_SF,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { SA8775P_MASTER_SNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node srvc_snoc = {
> +	.name = "srvc_snoc",
> +	.id = SA8775P_SLAVE_SERVICE_SNOC,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_bcm bcm_acv = {
> +	.name = "ACV",
> +	.enable_mask = BIT(3),
> +	.num_nodes = 1,
> +	.nodes = { &ebi },
> +};
> +
> +static struct qcom_icc_bcm bcm_ce0 = {
> +	.name = "CE0",
> +	.num_nodes = 2,
> +	.nodes = { &qxm_crypto_0, &qxm_crypto_1 },
> +};
> +
> +static struct qcom_icc_bcm bcm_cn0 = {
> +	.name = "CN0",
> +	.keepalive = true,
> +	.num_nodes = 2,
> +	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie },
> +};
> +
> +static struct qcom_icc_bcm bcm_cn1 = {
> +	.name = "CN1",
> +	.num_nodes = 76,
> +	.nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
> +		   &qhs_ahb2phy2, &qhs_ahb2phy3,
> +		   &qhs_anoc_throttle_cfg, &qhs_aoss,
> +		   &qhs_apss, &qhs_boot_rom,
> +		   &qhs_camera_cfg, &qhs_camera_nrt_throttle_cfg,
> +		   &qhs_camera_rt_throttle_cfg, &qhs_clk_ctl,
> +		   &qhs_compute0_cfg, &qhs_compute1_cfg,
> +		   &qhs_cpr_cx, &qhs_cpr_mmcx,
> +		   &qhs_cpr_mx, &qhs_cpr_nspcx,
> +		   &qhs_crypto0_cfg, &qhs_cx_rdpm,
> +		   &qhs_display0_cfg, &qhs_display0_rt_throttle_cfg,
> +		   &qhs_display1_cfg, &qhs_display1_rt_throttle_cfg,
> +		   &qhs_emac0_cfg, &qhs_emac1_cfg,
> +		   &qhs_gp_dsp0_cfg, &qhs_gp_dsp1_cfg,
> +		   &qhs_gpdsp0_throttle_cfg, &qhs_gpdsp1_throttle_cfg,
> +		   &qhs_gpu_tcu_throttle_cfg, &qhs_gpuss_cfg,
> +		   &qhs_hwkm, &qhs_imem_cfg,
> +		   &qhs_ipa, &qhs_ipc_router,
> +		   &qhs_lpass_cfg, &qhs_lpass_throttle_cfg,
> +		   &qhs_mx_rdpm, &qhs_mxc_rdpm,
> +		   &qhs_pcie0_cfg, &qhs_pcie1_cfg,
> +		   &qhs_pcie_rsc_cfg, &qhs_pcie_tcu_throttle_cfg,
> +		   &qhs_pcie_throttle_cfg, &qhs_pdm,
> +		   &qhs_pimem_cfg, &qhs_pke_wrapper_cfg,
> +		   &qhs_qdss_cfg, &qhs_qm_cfg,
> +		   &qhs_qm_mpu_cfg, &qhs_sail_throttle_cfg,
> +		   &qhs_sdc1, &qhs_security,
> +		   &qhs_snoc_throttle_cfg, &qhs_tcsr,
> +		   &qhs_tlmm, &qhs_tsc_cfg,
> +		   &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg,
> +		   &qhs_usb2_0, &qhs_usb3_0,
> +		   &qhs_usb3_1, &qhs_venus_cfg,
> +		   &qhs_venus_cvp_throttle_cfg, &qhs_venus_v_cpu_throttle_cfg,
> +		   &qhs_venus_vcodec_throttle_cfg, &qns_ddrss_cfg,
> +		   &qns_gpdsp_noc_cfg, &qns_mnoc_hf_cfg,
> +		   &qns_mnoc_sf_cfg, &qns_pcie_anoc_cfg,
> +		   &qns_snoc_cfg, &qxs_boot_imem,
> +		   &qxs_imem, &xs_sys_tcu_cfg },
> +};
> +
> +static struct qcom_icc_bcm bcm_cn2 = {
> +	.name = "CN2",
> +	.num_nodes = 4,
> +	.nodes = { &qhs_qup0, &qhs_qup1,
> +		   &qhs_qup2, &qhs_qup3 },
> +};
> +
> +static struct qcom_icc_bcm bcm_cn3 = {
> +	.name = "CN3",
> +	.num_nodes = 2,
> +	.nodes = { &xs_pcie_0, &xs_pcie_1 },
> +};
> +
> +static struct qcom_icc_bcm bcm_gna0 = {
> +	.name = "GNA0",
> +	.num_nodes = 1,
> +	.nodes = { &qxm_dsp0 },
> +};
> +
> +static struct qcom_icc_bcm bcm_gnb0 = {
> +	.name = "GNB0",
> +	.num_nodes = 1,
> +	.nodes = { &qxm_dsp1 },
> +};
> +
> +static struct qcom_icc_bcm bcm_mc0 = {
> +	.name = "MC0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &ebi },
> +};
> +
> +static struct qcom_icc_bcm bcm_mm0 = {
> +	.name = "MM0",
> +	.keepalive = true,
> +	.num_nodes = 5,
> +	.nodes = { &qnm_camnoc_hf, &qnm_mdp0_0,
> +		   &qnm_mdp0_1, &qnm_mdp1_0,
> +		   &qns_mem_noc_hf },
> +};
> +
> +static struct qcom_icc_bcm bcm_mm1 = {
> +	.name = "MM1",
> +	.num_nodes = 7,
> +	.nodes = { &qnm_camnoc_icp, &qnm_camnoc_sf,
> +		   &qnm_video0, &qnm_video1,
> +		   &qnm_video_cvp, &qnm_video_v_cpu,
> +		   &qns_mem_noc_sf },
> +};
> +
> +static struct qcom_icc_bcm bcm_nsa0 = {
> +	.name = "NSA0",
> +	.num_nodes = 2,
> +	.nodes = { &qns_hcp, &qns_nsp_gemnoc },
> +};
> +
> +static struct qcom_icc_bcm bcm_nsa1 = {
> +	.name = "NSA1",
> +	.num_nodes = 1,
> +	.nodes = { &qxm_nsp },
> +};
> +
> +static struct qcom_icc_bcm bcm_nsb0 = {
> +	.name = "NSB0",
> +	.num_nodes = 2,
> +	.nodes = { &qns_nspb_gemnoc, &qns_nspb_hcp },
> +};
> +
> +static struct qcom_icc_bcm bcm_nsb1 = {
> +	.name = "NSB1",
> +	.num_nodes = 1,
> +	.nodes = { &qxm_nspb },
> +};
> +
> +static struct qcom_icc_bcm bcm_pci0 = {
> +	.name = "PCI0",
> +	.num_nodes = 1,
> +	.nodes = { &qns_pcie_mem_noc },
> +};
> +
> +static struct qcom_icc_bcm bcm_qup0 = {
> +	.name = "QUP0",
> +	.vote_scale = 1,
> +	.num_nodes = 1,
> +	.nodes = { &qup0_core_slave },
> +};
> +
> +static struct qcom_icc_bcm bcm_qup1 = {
> +	.name = "QUP1",
> +	.vote_scale = 1,
> +	.num_nodes = 1,
> +	.nodes = { &qup1_core_slave },
> +};
> +
> +static struct qcom_icc_bcm bcm_qup2 = {
> +	.name = "QUP2",
> +	.vote_scale = 1,
> +	.num_nodes = 2,
> +	.nodes = { &qup2_core_slave, &qup3_core_slave },
> +};
> +
> +static struct qcom_icc_bcm bcm_sh0 = {
> +	.name = "SH0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &qns_llcc },
> +};
> +
> +static struct qcom_icc_bcm bcm_sh2 = {
> +	.name = "SH2",
> +	.num_nodes = 1,
> +	.nodes = { &chm_apps },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn0 = {
> +	.name = "SN0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &qns_gemnoc_sf },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn1 = {
> +	.name = "SN1",
> +	.num_nodes = 1,
> +	.nodes = { &qns_gemnoc_gc },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn2 = {
> +	.name = "SN2",
> +	.num_nodes = 1,
> +	.nodes = { &qxs_pimem },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn3 = {
> +	.name = "SN3",
> +	.num_nodes = 2,
> +	.nodes = { &qns_a1noc_snoc, &qnm_aggre1_noc },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn4 = {
> +	.name = "SN4",
> +	.num_nodes = 2,
> +	.nodes = { &qns_a2noc_snoc, &qnm_aggre2_noc },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn9 = {
> +	.name = "SN9",
> +	.num_nodes = 2,
> +	.nodes = { &qns_sysnoc, &qnm_lpass_noc },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn10 = {
> +	.name = "SN10",
> +	.num_nodes = 1,
> +	.nodes = { &xs_qdss_stm },
> +};
> +
> +static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
> +	&bcm_sn3,
> +};
> +
> +static struct qcom_icc_node * const aggre1_noc_nodes[] = {
> +	[SA8775P_MASTER_QUP_3] = &qxm_qup3,
> +	[SA8775P_MASTER_EMAC] = &xm_emac_0,
> +	[SA8775P_MASTER_EMAC_1] = &xm_emac_1,
> +	[SA8775P_MASTER_SDC] = &xm_sdc1,
> +	[SA8775P_MASTER_UFS_MEM] = &xm_ufs_mem,
> +	[SA8775P_MASTER_USB2] = &xm_usb2_2,
> +	[SA8775P_MASTER_USB3_0] = &xm_usb3_0,
> +	[SA8775P_MASTER_USB3_1] = &xm_usb3_1,
> +	[SA8775P_SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_aggre1_noc = {
> +	.nodes = aggre1_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
> +	.bcms = aggre1_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
> +	.qos_requires_clocks = true,
> +};
> +
> +static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
> +	&bcm_ce0,
> +	&bcm_sn4,
> +};
> +
> +static struct qcom_icc_node * const aggre2_noc_nodes[] = {
> +	[SA8775P_MASTER_QDSS_BAM] = &qhm_qdss_bam,
> +	[SA8775P_MASTER_QUP_0] = &qhm_qup0,
> +	[SA8775P_MASTER_QUP_1] = &qhm_qup1,
> +	[SA8775P_MASTER_QUP_2] = &qhm_qup2,
> +	[SA8775P_MASTER_CNOC_A2NOC] = &qnm_cnoc_datapath,
> +	[SA8775P_MASTER_CRYPTO_CORE0] = &qxm_crypto_0,
> +	[SA8775P_MASTER_CRYPTO_CORE1] = &qxm_crypto_1,
> +	[SA8775P_MASTER_IPA] = &qxm_ipa,
> +	[SA8775P_MASTER_QDSS_ETR_0] = &xm_qdss_etr_0,
> +	[SA8775P_MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
> +	[SA8775P_MASTER_UFS_CARD] = &xm_ufs_card,
> +	[SA8775P_SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_aggre2_noc = {
> +	.nodes = aggre2_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
> +	.bcms = aggre2_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
> +	.qos_requires_clocks = true,
> +};
> +
> +static struct qcom_icc_bcm * const clk_virt_bcms[] = {
> +	&bcm_qup0,
> +	&bcm_qup1,
> +	&bcm_qup2,
> +};
> +
> +static struct qcom_icc_node * const clk_virt_nodes[] = {
> +	[SA8775P_MASTER_QUP_CORE_0] = &qup0_core_master,
> +	[SA8775P_MASTER_QUP_CORE_1] = &qup1_core_master,
> +	[SA8775P_MASTER_QUP_CORE_2] = &qup2_core_master,
> +	[SA8775P_MASTER_QUP_CORE_3] = &qup3_core_master,
> +	[SA8775P_SLAVE_QUP_CORE_0] = &qup0_core_slave,
> +	[SA8775P_SLAVE_QUP_CORE_1] = &qup1_core_slave,
> +	[SA8775P_SLAVE_QUP_CORE_2] = &qup2_core_slave,
> +	[SA8775P_SLAVE_QUP_CORE_3] = &qup3_core_slave,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_clk_virt = {
> +	.nodes = clk_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
> +	.bcms = clk_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const config_noc_bcms[] = {
> +	&bcm_cn0,
> +	&bcm_cn1,
> +	&bcm_cn2,
> +	&bcm_cn3,
> +	&bcm_sn2,
> +	&bcm_sn10,
> +};
> +
> +static struct qcom_icc_node * const config_noc_nodes[] = {
> +	[SA8775P_MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
> +	[SA8775P_MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
> +	[SA8775P_SLAVE_AHB2PHY_0] = &qhs_ahb2phy0,
> +	[SA8775P_SLAVE_AHB2PHY_1] = &qhs_ahb2phy1,
> +	[SA8775P_SLAVE_AHB2PHY_2] = &qhs_ahb2phy2,
> +	[SA8775P_SLAVE_AHB2PHY_3] = &qhs_ahb2phy3,
> +	[SA8775P_SLAVE_ANOC_THROTTLE_CFG] = &qhs_anoc_throttle_cfg,
> +	[SA8775P_SLAVE_AOSS] = &qhs_aoss,
> +	[SA8775P_SLAVE_APPSS] = &qhs_apss,
> +	[SA8775P_SLAVE_BOOT_ROM] = &qhs_boot_rom,
> +	[SA8775P_SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
> +	[SA8775P_SLAVE_CAMERA_NRT_THROTTLE_CFG] = &qhs_camera_nrt_throttle_cfg,
> +	[SA8775P_SLAVE_CAMERA_RT_THROTTLE_CFG] = &qhs_camera_rt_throttle_cfg,
> +	[SA8775P_SLAVE_CLK_CTL] = &qhs_clk_ctl,
> +	[SA8775P_SLAVE_CDSP_CFG] = &qhs_compute0_cfg,
> +	[SA8775P_SLAVE_CDSP1_CFG] = &qhs_compute1_cfg,
> +	[SA8775P_SLAVE_RBCPR_CX_CFG] = &qhs_cpr_cx,
> +	[SA8775P_SLAVE_RBCPR_MMCX_CFG] = &qhs_cpr_mmcx,
> +	[SA8775P_SLAVE_RBCPR_MX_CFG] = &qhs_cpr_mx,
> +	[SA8775P_SLAVE_CPR_NSPCX] = &qhs_cpr_nspcx,
> +	[SA8775P_SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
> +	[SA8775P_SLAVE_CX_RDPM] = &qhs_cx_rdpm,
> +	[SA8775P_SLAVE_DISPLAY_CFG] = &qhs_display0_cfg,
> +	[SA8775P_SLAVE_DISPLAY_RT_THROTTLE_CFG] = &qhs_display0_rt_throttle_cfg,
> +	[SA8775P_SLAVE_DISPLAY1_CFG] = &qhs_display1_cfg,
> +	[SA8775P_SLAVE_DISPLAY1_RT_THROTTLE_CFG] = &qhs_display1_rt_throttle_cfg,
> +	[SA8775P_SLAVE_EMAC_CFG] = &qhs_emac0_cfg,
> +	[SA8775P_SLAVE_EMAC1_CFG] = &qhs_emac1_cfg,
> +	[SA8775P_SLAVE_GP_DSP0_CFG] = &qhs_gp_dsp0_cfg,
> +	[SA8775P_SLAVE_GP_DSP1_CFG] = &qhs_gp_dsp1_cfg,
> +	[SA8775P_SLAVE_GPDSP0_THROTTLE_CFG] = &qhs_gpdsp0_throttle_cfg,
> +	[SA8775P_SLAVE_GPDSP1_THROTTLE_CFG] = &qhs_gpdsp1_throttle_cfg,
> +	[SA8775P_SLAVE_GPU_TCU_THROTTLE_CFG] = &qhs_gpu_tcu_throttle_cfg,
> +	[SA8775P_SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
> +	[SA8775P_SLAVE_HWKM] = &qhs_hwkm,
> +	[SA8775P_SLAVE_IMEM_CFG] = &qhs_imem_cfg,
> +	[SA8775P_SLAVE_IPA_CFG] = &qhs_ipa,
> +	[SA8775P_SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
> +	[SA8775P_SLAVE_LPASS] = &qhs_lpass_cfg,
> +	[SA8775P_SLAVE_LPASS_THROTTLE_CFG] = &qhs_lpass_throttle_cfg,
> +	[SA8775P_SLAVE_MX_RDPM] = &qhs_mx_rdpm,
> +	[SA8775P_SLAVE_MXC_RDPM] = &qhs_mxc_rdpm,
> +	[SA8775P_SLAVE_PCIE_0_CFG] = &qhs_pcie0_cfg,
> +	[SA8775P_SLAVE_PCIE_1_CFG] = &qhs_pcie1_cfg,
> +	[SA8775P_SLAVE_PCIE_RSC_CFG] = &qhs_pcie_rsc_cfg,
> +	[SA8775P_SLAVE_PCIE_TCU_THROTTLE_CFG] = &qhs_pcie_tcu_throttle_cfg,
> +	[SA8775P_SLAVE_PCIE_THROTTLE_CFG] = &qhs_pcie_throttle_cfg,
> +	[SA8775P_SLAVE_PDM] = &qhs_pdm,
> +	[SA8775P_SLAVE_PIMEM_CFG] = &qhs_pimem_cfg,
> +	[SA8775P_SLAVE_PKA_WRAPPER_CFG] = &qhs_pke_wrapper_cfg,
> +	[SA8775P_SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
> +	[SA8775P_SLAVE_QM_CFG] = &qhs_qm_cfg,
> +	[SA8775P_SLAVE_QM_MPU_CFG] = &qhs_qm_mpu_cfg,
> +	[SA8775P_SLAVE_QUP_0] = &qhs_qup0,
> +	[SA8775P_SLAVE_QUP_1] = &qhs_qup1,
> +	[SA8775P_SLAVE_QUP_2] = &qhs_qup2,
> +	[SA8775P_SLAVE_QUP_3] = &qhs_qup3,
> +	[SA8775P_SLAVE_SAIL_THROTTLE_CFG] = &qhs_sail_throttle_cfg,
> +	[SA8775P_SLAVE_SDC1] = &qhs_sdc1,
> +	[SA8775P_SLAVE_SECURITY] = &qhs_security,
> +	[SA8775P_SLAVE_SNOC_THROTTLE_CFG] = &qhs_snoc_throttle_cfg,
> +	[SA8775P_SLAVE_TCSR] = &qhs_tcsr,
> +	[SA8775P_SLAVE_TLMM] = &qhs_tlmm,
> +	[SA8775P_SLAVE_TSC_CFG] = &qhs_tsc_cfg,
> +	[SA8775P_SLAVE_UFS_CARD_CFG] = &qhs_ufs_card_cfg,
> +	[SA8775P_SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
> +	[SA8775P_SLAVE_USB2] = &qhs_usb2_0,
> +	[SA8775P_SLAVE_USB3_0] = &qhs_usb3_0,
> +	[SA8775P_SLAVE_USB3_1] = &qhs_usb3_1,
> +	[SA8775P_SLAVE_VENUS_CFG] = &qhs_venus_cfg,
> +	[SA8775P_SLAVE_VENUS_CVP_THROTTLE_CFG] = &qhs_venus_cvp_throttle_cfg,
> +	[SA8775P_SLAVE_VENUS_V_CPU_THROTTLE_CFG] = &qhs_venus_v_cpu_throttle_cfg,
> +	[SA8775P_SLAVE_VENUS_VCODEC_THROTTLE_CFG] = &qhs_venus_vcodec_throttle_cfg,
> +	[SA8775P_SLAVE_DDRSS_CFG] = &qns_ddrss_cfg,
> +	[SA8775P_SLAVE_GPDSP_NOC_CFG] = &qns_gpdsp_noc_cfg,
> +	[SA8775P_SLAVE_CNOC_MNOC_HF_CFG] = &qns_mnoc_hf_cfg,
> +	[SA8775P_SLAVE_CNOC_MNOC_SF_CFG] = &qns_mnoc_sf_cfg,
> +	[SA8775P_SLAVE_PCIE_ANOC_CFG] = &qns_pcie_anoc_cfg,
> +	[SA8775P_SLAVE_SNOC_CFG] = &qns_snoc_cfg,
> +	[SA8775P_SLAVE_BOOT_IMEM] = &qxs_boot_imem,
> +	[SA8775P_SLAVE_IMEM] = &qxs_imem,
> +	[SA8775P_SLAVE_PIMEM] = &qxs_pimem,
> +	[SA8775P_SLAVE_PCIE_0] = &xs_pcie_0,
> +	[SA8775P_SLAVE_PCIE_1] = &xs_pcie_1,
> +	[SA8775P_SLAVE_QDSS_STM] = &xs_qdss_stm,
> +	[SA8775P_SLAVE_TCU] = &xs_sys_tcu_cfg,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_config_noc = {
> +	.nodes = config_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(config_noc_nodes),
> +	.bcms = config_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(config_noc_bcms),
> +};
> +
> +static struct qcom_icc_node * const dc_noc_nodes[] = {
> +	[SA8775P_MASTER_CNOC_DC_NOC] = &qnm_cnoc_dc_noc,
> +	[SA8775P_SLAVE_LLCC_CFG] = &qhs_llcc,
> +	[SA8775P_SLAVE_GEM_NOC_CFG] = &qns_gemnoc,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_dc_noc = {
> +	.nodes = dc_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
> +};
> +
> +static struct qcom_icc_bcm * const gem_noc_bcms[] = {
> +	&bcm_sh0,
> +	&bcm_sh2,
> +};
> +
> +static struct qcom_icc_node * const gem_noc_nodes[] = {
> +	[SA8775P_MASTER_GPU_TCU] = &alm_gpu_tcu,
> +	[SA8775P_MASTER_PCIE_TCU] = &alm_pcie_tcu,
> +	[SA8775P_MASTER_SYS_TCU] = &alm_sys_tcu,
> +	[SA8775P_MASTER_APPSS_PROC] = &chm_apps,
> +	[SA8775P_MASTER_COMPUTE_NOC] = &qnm_cmpnoc0,
> +	[SA8775P_MASTER_COMPUTE_NOC_1] = &qnm_cmpnoc1,
> +	[SA8775P_MASTER_GEM_NOC_CFG] = &qnm_gemnoc_cfg,
> +	[SA8775P_MASTER_GPDSP_SAIL] = &qnm_gpdsp_sail,
> +	[SA8775P_MASTER_GFX3D] = &qnm_gpu,
> +	[SA8775P_MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
> +	[SA8775P_MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
> +	[SA8775P_MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
> +	[SA8775P_MASTER_SNOC_GC_MEM_NOC] = &qnm_snoc_gc,
> +	[SA8775P_MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
> +	[SA8775P_SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
> +	[SA8775P_SLAVE_LLCC] = &qns_llcc,
> +	[SA8775P_SLAVE_GEM_NOC_PCIE_CNOC] = &qns_pcie,
> +	[SA8775P_SLAVE_SERVICE_GEM_NOC_1] = &srvc_even_gemnoc,
> +	[SA8775P_SLAVE_SERVICE_GEM_NOC_2] = &srvc_odd_gemnoc,
> +	[SA8775P_SLAVE_SERVICE_GEM_NOC] = &srvc_sys_gemnoc,
> +	[SA8775P_SLAVE_SERVICE_GEM_NOC2] = &srvc_sys_gemnoc_2,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_gem_noc = {
> +	.nodes = gem_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
> +	.bcms = gem_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const gpdsp_anoc_bcms[] = {
> +	&bcm_gna0,
> +	&bcm_gnb0,
> +};
> +
> +static struct qcom_icc_node * const gpdsp_anoc_nodes[] = {
> +	[SA8775P_MASTER_DSP0] = &qxm_dsp0,
> +	[SA8775P_MASTER_DSP1] = &qxm_dsp1,
> +	[SA8775P_SLAVE_GP_DSP_SAIL_NOC] = &qns_gp_dsp_sail_noc,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_gpdsp_anoc = {
> +	.nodes = gpdsp_anoc_nodes,
> +	.num_nodes = ARRAY_SIZE(gpdsp_anoc_nodes),
> +	.bcms = gpdsp_anoc_bcms,
> +	.num_bcms = ARRAY_SIZE(gpdsp_anoc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
> +	&bcm_sn9,
> +};
> +
> +static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
> +	[SA8775P_MASTER_CNOC_LPASS_AG_NOC] = &qhm_config_noc,
> +	[SA8775P_MASTER_LPASS_PROC] = &qxm_lpass_dsp,
> +	[SA8775P_SLAVE_LPASS_CORE_CFG] = &qhs_lpass_core,
> +	[SA8775P_SLAVE_LPASS_LPI_CFG] = &qhs_lpass_lpi,
> +	[SA8775P_SLAVE_LPASS_MPU_CFG] = &qhs_lpass_mpu,
> +	[SA8775P_SLAVE_LPASS_TOP_CFG] = &qhs_lpass_top,
> +	[SA8775P_SLAVE_LPASS_SNOC] = &qns_sysnoc,
> +	[SA8775P_SLAVE_SERVICES_LPASS_AML_NOC] = &srvc_niu_aml_noc,
> +	[SA8775P_SLAVE_SERVICE_LPASS_AG_NOC] = &srvc_niu_lpass_agnoc,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_lpass_ag_noc = {
> +	.nodes = lpass_ag_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
> +	.bcms = lpass_ag_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(lpass_ag_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const mc_virt_bcms[] = {
> +	&bcm_acv,
> +	&bcm_mc0,
> +};
> +
> +static struct qcom_icc_node * const mc_virt_nodes[] = {
> +	[SA8775P_MASTER_LLCC] = &llcc_mc,
> +	[SA8775P_SLAVE_EBI1] = &ebi,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_mc_virt = {
> +	.nodes = mc_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
> +	.bcms = mc_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
> +	&bcm_mm0,
> +	&bcm_mm1,
> +};
> +
> +static struct qcom_icc_node * const mmss_noc_nodes[] = {
> +	[SA8775P_MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
> +	[SA8775P_MASTER_CAMNOC_ICP] = &qnm_camnoc_icp,
> +	[SA8775P_MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
> +	[SA8775P_MASTER_MDP0] = &qnm_mdp0_0,
> +	[SA8775P_MASTER_MDP1] = &qnm_mdp0_1,
> +	[SA8775P_MASTER_MDP_CORE1_0] = &qnm_mdp1_0,
> +	[SA8775P_MASTER_MDP_CORE1_1] = &qnm_mdp1_1,
> +	[SA8775P_MASTER_CNOC_MNOC_HF_CFG] = &qnm_mnoc_hf_cfg,
> +	[SA8775P_MASTER_CNOC_MNOC_SF_CFG] = &qnm_mnoc_sf_cfg,
> +	[SA8775P_MASTER_VIDEO_P0] = &qnm_video0,
> +	[SA8775P_MASTER_VIDEO_P1] = &qnm_video1,
> +	[SA8775P_MASTER_VIDEO_PROC] = &qnm_video_cvp,
> +	[SA8775P_MASTER_VIDEO_V_PROC] = &qnm_video_v_cpu,
> +	[SA8775P_SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
> +	[SA8775P_SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
> +	[SA8775P_SLAVE_SERVICE_MNOC_HF] = &srvc_mnoc_hf,
> +	[SA8775P_SLAVE_SERVICE_MNOC_SF] = &srvc_mnoc_sf,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_mmss_noc = {
> +	.nodes = mmss_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
> +	.bcms = mmss_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const nspa_noc_bcms[] = {
> +	&bcm_nsa0,
> +	&bcm_nsa1,
> +};
> +
> +static struct qcom_icc_node * const nspa_noc_nodes[] = {
> +	[SA8775P_MASTER_CDSP_NOC_CFG] = &qhm_nsp_noc_config,
> +	[SA8775P_MASTER_CDSP_PROC] = &qxm_nsp,
> +	[SA8775P_SLAVE_HCP_A] = &qns_hcp,
> +	[SA8775P_SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
> +	[SA8775P_SLAVE_SERVICE_NSP_NOC] = &service_nsp_noc,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_nspa_noc = {
> +	.nodes = nspa_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(nspa_noc_nodes),
> +	.bcms = nspa_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(nspa_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const nspb_noc_bcms[] = {
> +	&bcm_nsb0,
> +	&bcm_nsb1,
> +};
> +
> +static struct qcom_icc_node * const nspb_noc_nodes[] = {
> +	[SA8775P_MASTER_CDSPB_NOC_CFG] = &qhm_nspb_noc_config,
> +	[SA8775P_MASTER_CDSP_PROC_B] = &qxm_nspb,
> +	[SA8775P_SLAVE_CDSPB_MEM_NOC] = &qns_nspb_gemnoc,
> +	[SA8775P_SLAVE_HCP_B] = &qns_nspb_hcp,
> +	[SA8775P_SLAVE_SERVICE_NSPB_NOC] = &service_nspb_noc,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_nspb_noc = {
> +	.nodes = nspb_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(nspb_noc_nodes),
> +	.bcms = nspb_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(nspb_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
> +	&bcm_pci0,
> +};
> +
> +static struct qcom_icc_node * const pcie_anoc_nodes[] = {
> +	[SA8775P_MASTER_PCIE_0] = &xm_pcie3_0,
> +	[SA8775P_MASTER_PCIE_1] = &xm_pcie3_1,
> +	[SA8775P_SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_pcie_anoc = {
> +	.nodes = pcie_anoc_nodes,
> +	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
> +	.bcms = pcie_anoc_bcms,
> +	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const system_noc_bcms[] = {
> +	&bcm_sn0,
> +	&bcm_sn1,
> +	&bcm_sn3,
> +	&bcm_sn4,
> +	&bcm_sn9,
> +};
> +
> +static struct qcom_icc_node * const system_noc_nodes[] = {
> +	[SA8775P_MASTER_GIC_AHB] = &qhm_gic,
> +	[SA8775P_MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
> +	[SA8775P_MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
> +	[SA8775P_MASTER_LPASS_ANOC] = &qnm_lpass_noc,
> +	[SA8775P_MASTER_SNOC_CFG] = &qnm_snoc_cfg,
> +	[SA8775P_MASTER_PIMEM] = &qxm_pimem,
> +	[SA8775P_MASTER_GIC] = &xm_gic,
> +	[SA8775P_SLAVE_SNOC_GEM_NOC_GC] = &qns_gemnoc_gc,
> +	[SA8775P_SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
> +	[SA8775P_SLAVE_SERVICE_SNOC] = &srvc_snoc,
> +};
> +
> +static const struct qcom_icc_desc sa8775p_system_noc = {
> +	.nodes = system_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(system_noc_nodes),
> +	.bcms = system_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(system_noc_bcms),
> +};
> +
> +static const struct udevice_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,sa8775p-aggre1-noc", .data = (ulong)&sa8775p_aggre1_noc },
> +	{ .compatible = "qcom,sa8775p-aggre2-noc", .data = (ulong)&sa8775p_aggre2_noc },
> +	{ .compatible = "qcom,sa8775p-clk-virt", .data = (ulong)&sa8775p_clk_virt },
> +	{ .compatible = "qcom,sa8775p-config-noc", .data = (ulong)&sa8775p_config_noc },
> +	{ .compatible = "qcom,sa8775p-dc-noc", .data = (ulong)&sa8775p_dc_noc },
> +	{ .compatible = "qcom,sa8775p-gem-noc", .data = (ulong)&sa8775p_gem_noc },
> +	{ .compatible = "qcom,sa8775p-gpdsp-anoc", .data = (ulong)&sa8775p_gpdsp_anoc },
> +	{ .compatible = "qcom,sa8775p-lpass-ag-noc", .data = (ulong)&sa8775p_lpass_ag_noc },
> +	{ .compatible = "qcom,sa8775p-mc-virt", .data = (ulong)&sa8775p_mc_virt },
> +	{ .compatible = "qcom,sa8775p-mmss-noc", .data = (ulong)&sa8775p_mmss_noc },
> +	{ .compatible = "qcom,sa8775p-nspa-noc", .data = (ulong)&sa8775p_nspa_noc },
> +	{ .compatible = "qcom,sa8775p-nspb-noc", .data = (ulong)&sa8775p_nspb_noc },
> +	{ .compatible = "qcom,sa8775p-pcie-anoc", .data = (ulong)&sa8775p_pcie_anoc },
> +	{ .compatible = "qcom,sa8775p-system-noc", .data = (ulong)&sa8775p_system_noc },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(qnoc_sa8775p) = {
> +	.name = "qnoc-sa8775p",
> +	.id = UCLASS_INTERCONNECT,
> +	.of_match = qnoc_of_match,
> +	.probe = qcom_icc_rpmh_probe,
> +	.bind = qcom_icc_rpmh_bind,
> +	.unbind = qcom_icc_rpmh_unbind,
> +	.ops = &qcom_icc_rpmh_ops,
> +	.plat_auto = sizeof(struct qcom_icc_provider),
> +};
> diff --git a/drivers/interconnect/qcom/sa8775p.h b/drivers/interconnect/qcom/sa8775p.h
> new file mode 100644
> index 00000000000..e6886890473
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sa8775p.h
> @@ -0,0 +1,205 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * SA8775P interconnect IDs
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_SA8775P_H
> +#define __DRIVERS_INTERCONNECT_QCOM_SA8775P_H
> +
> +#define SA8775P_MASTER_A1NOC_SNOC		0
> +#define SA8775P_MASTER_A2NOC_SNOC		1
> +#define SA8775P_MASTER_ANOC_PCIE_GEM_NOC		2
> +#define SA8775P_MASTER_APPSS_PROC		3
> +#define SA8775P_MASTER_CAMNOC_HF		4
> +#define SA8775P_MASTER_CAMNOC_ICP		5
> +#define SA8775P_MASTER_CAMNOC_SF		6
> +#define SA8775P_MASTER_CDSPB_NOC_CFG		7
> +#define SA8775P_MASTER_CDSP_NOC_CFG		8
> +#define SA8775P_MASTER_CDSP_PROC		9
> +#define SA8775P_MASTER_CDSP_PROC_B		10
> +#define SA8775P_MASTER_CNOC_A2NOC		11
> +#define SA8775P_MASTER_CNOC_DC_NOC		12
> +#define SA8775P_MASTER_CNOC_LPASS_AG_NOC		13
> +#define SA8775P_MASTER_CNOC_MNOC_HF_CFG		14
> +#define SA8775P_MASTER_CNOC_MNOC_SF_CFG		15
> +#define SA8775P_MASTER_COMPUTE_NOC		16
> +#define SA8775P_MASTER_COMPUTE_NOC_1		17
> +#define SA8775P_MASTER_CRYPTO_CORE0		18
> +#define SA8775P_MASTER_CRYPTO_CORE1		19
> +#define SA8775P_MASTER_DSP0		20
> +#define SA8775P_MASTER_DSP1		21
> +#define SA8775P_MASTER_EMAC		22
> +#define SA8775P_MASTER_EMAC_1		23
> +#define SA8775P_MASTER_GEM_NOC_CFG		24
> +#define SA8775P_MASTER_GEM_NOC_CNOC		25
> +#define SA8775P_MASTER_GEM_NOC_PCIE_SNOC		26
> +#define SA8775P_MASTER_GFX3D		27
> +#define SA8775P_MASTER_GIC		28
> +#define SA8775P_MASTER_GIC_AHB		29
> +#define SA8775P_MASTER_GPDSP_SAIL		30
> +#define SA8775P_MASTER_GPU_TCU		31
> +#define SA8775P_MASTER_IPA		32
> +#define SA8775P_MASTER_LLCC		33
> +#define SA8775P_MASTER_LPASS_ANOC		34
> +#define SA8775P_MASTER_LPASS_PROC		35
> +#define SA8775P_MASTER_MDP0		36
> +#define SA8775P_MASTER_MDP1		37
> +#define SA8775P_MASTER_MDP_CORE1_0		38
> +#define SA8775P_MASTER_MDP_CORE1_1		39
> +#define SA8775P_MASTER_MNOC_HF_MEM_NOC		40
> +#define SA8775P_MASTER_MNOC_SF_MEM_NOC		41
> +#define SA8775P_MASTER_PCIE_0		42
> +#define SA8775P_MASTER_PCIE_1		43
> +#define SA8775P_MASTER_PCIE_TCU		44
> +#define SA8775P_MASTER_PIMEM		45
> +#define SA8775P_MASTER_QDSS_BAM		46
> +#define SA8775P_MASTER_QDSS_ETR_0		47
> +#define SA8775P_MASTER_QDSS_ETR_1		48
> +#define SA8775P_MASTER_QUP_0		49
> +#define SA8775P_MASTER_QUP_1		50
> +#define SA8775P_MASTER_QUP_2		51
> +#define SA8775P_MASTER_QUP_3		52
> +#define SA8775P_MASTER_QUP_CORE_0		53
> +#define SA8775P_MASTER_QUP_CORE_1		54
> +#define SA8775P_MASTER_QUP_CORE_2		55
> +#define SA8775P_MASTER_QUP_CORE_3		56
> +#define SA8775P_MASTER_SDC		57
> +#define SA8775P_MASTER_SNOC_CFG		58
> +#define SA8775P_MASTER_SNOC_GC_MEM_NOC		59
> +#define SA8775P_MASTER_SNOC_SF_MEM_NOC		60
> +#define SA8775P_MASTER_SYS_TCU		61
> +#define SA8775P_MASTER_UFS_CARD		62
> +#define SA8775P_MASTER_UFS_MEM		63
> +#define SA8775P_MASTER_USB2		64
> +#define SA8775P_MASTER_USB3_0		65
> +#define SA8775P_MASTER_USB3_1		66
> +#define SA8775P_MASTER_VIDEO_P0		67
> +#define SA8775P_MASTER_VIDEO_P1		68
> +#define SA8775P_MASTER_VIDEO_PROC		69
> +#define SA8775P_MASTER_VIDEO_V_PROC		70
> +#define SA8775P_SLAVE_A1NOC_SNOC		71
> +#define SA8775P_SLAVE_A2NOC_SNOC		72
> +#define SA8775P_SLAVE_AHB2PHY_0		73
> +#define SA8775P_SLAVE_AHB2PHY_1		74
> +#define SA8775P_SLAVE_AHB2PHY_2		75
> +#define SA8775P_SLAVE_AHB2PHY_3		76
> +#define SA8775P_SLAVE_ANOC_PCIE_GEM_NOC		77
> +#define SA8775P_SLAVE_ANOC_THROTTLE_CFG		78
> +#define SA8775P_SLAVE_AOSS		79
> +#define SA8775P_SLAVE_APPSS		80
> +#define SA8775P_SLAVE_BOOT_IMEM		81
> +#define SA8775P_SLAVE_BOOT_ROM		82
> +#define SA8775P_SLAVE_CAMERA_CFG		83
> +#define SA8775P_SLAVE_CAMERA_NRT_THROTTLE_CFG		84
> +#define SA8775P_SLAVE_CAMERA_RT_THROTTLE_CFG		85
> +#define SA8775P_SLAVE_CDSP1_CFG		86
> +#define SA8775P_SLAVE_CDSPB_MEM_NOC		87
> +#define SA8775P_SLAVE_CDSP_CFG		88
> +#define SA8775P_SLAVE_CDSP_MEM_NOC		89
> +#define SA8775P_SLAVE_CLK_CTL		90
> +#define SA8775P_SLAVE_CNOC_MNOC_HF_CFG		91
> +#define SA8775P_SLAVE_CNOC_MNOC_SF_CFG		92
> +#define SA8775P_SLAVE_CPR_NSPCX		93
> +#define SA8775P_SLAVE_CRYPTO_0_CFG		94
> +#define SA8775P_SLAVE_CX_RDPM		95
> +#define SA8775P_SLAVE_DDRSS_CFG		96
> +#define SA8775P_SLAVE_DISPLAY1_CFG		97
> +#define SA8775P_SLAVE_DISPLAY1_RT_THROTTLE_CFG		98
> +#define SA8775P_SLAVE_DISPLAY_CFG		99
> +#define SA8775P_SLAVE_DISPLAY_RT_THROTTLE_CFG		100
> +#define SA8775P_SLAVE_EBI1		101
> +#define SA8775P_SLAVE_EMAC1_CFG		102
> +#define SA8775P_SLAVE_EMAC_CFG		103
> +#define SA8775P_SLAVE_GEM_NOC_CFG		104
> +#define SA8775P_SLAVE_GEM_NOC_CNOC		105
> +#define SA8775P_SLAVE_GEM_NOC_PCIE_CNOC		106
> +#define SA8775P_SLAVE_GFX3D_CFG		107
> +#define SA8775P_SLAVE_GPDSP0_THROTTLE_CFG		108
> +#define SA8775P_SLAVE_GPDSP1_THROTTLE_CFG		109
> +#define SA8775P_SLAVE_GPDSP_NOC_CFG		110
> +#define SA8775P_SLAVE_GPU_TCU_THROTTLE_CFG		111
> +#define SA8775P_SLAVE_GP_DSP0_CFG		112
> +#define SA8775P_SLAVE_GP_DSP1_CFG		113
> +#define SA8775P_SLAVE_GP_DSP_SAIL_NOC		114
> +#define SA8775P_SLAVE_HCP_A		115
> +#define SA8775P_SLAVE_HCP_B		116
> +#define SA8775P_SLAVE_HWKM		117
> +#define SA8775P_SLAVE_IMEM		118
> +#define SA8775P_SLAVE_IMEM_CFG		119
> +#define SA8775P_SLAVE_IPA_CFG		120
> +#define SA8775P_SLAVE_IPC_ROUTER_CFG		121
> +#define SA8775P_SLAVE_LLCC		122
> +#define SA8775P_SLAVE_LLCC_CFG		123
> +#define SA8775P_SLAVE_LPASS		124
> +#define SA8775P_SLAVE_LPASS_CORE_CFG		125
> +#define SA8775P_SLAVE_LPASS_LPI_CFG		126
> +#define SA8775P_SLAVE_LPASS_MPU_CFG		127
> +#define SA8775P_SLAVE_LPASS_SNOC		128
> +#define SA8775P_SLAVE_LPASS_THROTTLE_CFG		129
> +#define SA8775P_SLAVE_LPASS_TOP_CFG		130
> +#define SA8775P_SLAVE_MNOC_HF_MEM_NOC		131
> +#define SA8775P_SLAVE_MNOC_SF_MEM_NOC		132
> +#define SA8775P_SLAVE_MXC_RDPM		133
> +#define SA8775P_SLAVE_MX_RDPM		134
> +#define SA8775P_SLAVE_PCIE_0		135
> +#define SA8775P_SLAVE_PCIE_0_CFG		136
> +#define SA8775P_SLAVE_PCIE_1		137
> +#define SA8775P_SLAVE_PCIE_1_CFG		138
> +#define SA8775P_SLAVE_PCIE_ANOC_CFG		139
> +#define SA8775P_SLAVE_PCIE_RSC_CFG		140
> +#define SA8775P_SLAVE_PCIE_TCU_THROTTLE_CFG		141
> +#define SA8775P_SLAVE_PCIE_THROTTLE_CFG		142
> +#define SA8775P_SLAVE_PDM		143
> +#define SA8775P_SLAVE_PIMEM		144
> +#define SA8775P_SLAVE_PIMEM_CFG		145
> +#define SA8775P_SLAVE_PKA_WRAPPER_CFG		146
> +#define SA8775P_SLAVE_QDSS_CFG		147
> +#define SA8775P_SLAVE_QDSS_STM		148
> +#define SA8775P_SLAVE_QM_CFG		149
> +#define SA8775P_SLAVE_QM_MPU_CFG		150
> +#define SA8775P_SLAVE_QUP_0		151
> +#define SA8775P_SLAVE_QUP_1		152
> +#define SA8775P_SLAVE_QUP_2		153
> +#define SA8775P_SLAVE_QUP_3		154
> +#define SA8775P_SLAVE_QUP_CORE_0		155
> +#define SA8775P_SLAVE_QUP_CORE_1		156
> +#define SA8775P_SLAVE_QUP_CORE_2		157
> +#define SA8775P_SLAVE_QUP_CORE_3		158
> +#define SA8775P_SLAVE_RBCPR_CX_CFG		159
> +#define SA8775P_SLAVE_RBCPR_MMCX_CFG		160
> +#define SA8775P_SLAVE_RBCPR_MX_CFG		161
> +#define SA8775P_SLAVE_SAIL_THROTTLE_CFG		162
> +#define SA8775P_SLAVE_SDC1		163
> +#define SA8775P_SLAVE_SECURITY		164
> +#define SA8775P_SLAVE_SERVICES_LPASS_AML_NOC		165
> +#define SA8775P_SLAVE_SERVICE_GEM_NOC		166
> +#define SA8775P_SLAVE_SERVICE_GEM_NOC2		167
> +#define SA8775P_SLAVE_SERVICE_GEM_NOC_1		168
> +#define SA8775P_SLAVE_SERVICE_GEM_NOC_2		169
> +#define SA8775P_SLAVE_SERVICE_LPASS_AG_NOC		170
> +#define SA8775P_SLAVE_SERVICE_MNOC_HF		171
> +#define SA8775P_SLAVE_SERVICE_MNOC_SF		172
> +#define SA8775P_SLAVE_SERVICE_NSPB_NOC		173
> +#define SA8775P_SLAVE_SERVICE_NSP_NOC		174
> +#define SA8775P_SLAVE_SERVICE_SNOC		175
> +#define SA8775P_SLAVE_SNOC_CFG		176
> +#define SA8775P_SLAVE_SNOC_GEM_NOC_GC		177
> +#define SA8775P_SLAVE_SNOC_GEM_NOC_SF		178
> +#define SA8775P_SLAVE_SNOC_THROTTLE_CFG		179
> +#define SA8775P_SLAVE_TCSR		180
> +#define SA8775P_SLAVE_TCU		181
> +#define SA8775P_SLAVE_TLMM		182
> +#define SA8775P_SLAVE_TSC_CFG		183
> +#define SA8775P_SLAVE_UFS_CARD_CFG		184
> +#define SA8775P_SLAVE_UFS_MEM_CFG		185
> +#define SA8775P_SLAVE_USB2		186
> +#define SA8775P_SLAVE_USB3_0		187
> +#define SA8775P_SLAVE_USB3_1		188
> +#define SA8775P_SLAVE_VENUS_CFG		189
> +#define SA8775P_SLAVE_VENUS_CVP_THROTTLE_CFG		190
> +#define SA8775P_SLAVE_VENUS_VCODEC_THROTTLE_CFG		191
> +#define SA8775P_SLAVE_VENUS_V_CPU_THROTTLE_CFG		192
> +
> +#endif
>
> ---
> base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
> change-id: 20261103-lemans-ethernet-c5fcad136deb
>
> Best regards,
> --
> Deepak G <deepak.g10@oss.qualcomm.com>
